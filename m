Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10AF9C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfD3NS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 09:18:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44922 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfD3NS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:18:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hLSeL-0002Js-1r; Tue, 30 Apr 2019 13:18:21 +0000
Date:   Tue, 30 Apr 2019 14:18:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190430131820.GK23075@ZenIV.linux.org.uk>
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
 <20190430031144.GG23075@ZenIV.linux.org.uk>
 <20190430130739.GA11224@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430130739.GA11224@quack2.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 03:07:39PM +0200, Jan Kara wrote:
> On Tue 30-04-19 04:11:44, Al Viro wrote:
> > On Tue, Apr 30, 2019 at 04:55:01AM +0200, Jan Kara wrote:
> > 
> > > Yeah, you're right. And if we push the patch a bit further to not take
> > > loop_ctl_mutex for invalid ioctl number, that would fix the problem. I
> > > can send a fix.
> > 
> > Huh?  We don't take it until in lo_simple_ioctl(), and that patch doesn't
> > get to its call on invalid ioctl numbers.  What am I missing here?
> 
> Doesn't it? blkdev_ioctl() calls into __blkdev_driver_ioctl() for
> unrecognized ioctl numbers. That calls into lo_ioctl() in case of a loop
> device. lo_ioctl() calls into lo_simple_ioctl() for ioctl numbers it
> doesn't recognize and lo_simple_ioctl() will lock loop_ctl_mutex as you
> say.

Not with the patch upthread.  lo_ioctl() part was

@@ -1567,10 +1564,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_BLOCK_SIZE:
 		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		/* Fall through */
+		return lo_simple_ioctl(lo, cmd, arg);
 	default:
-		err = lo_simple_ioctl(lo, cmd, arg);
-		break;
+		return -EINVAL;
 	}
 
 	return err;

so anything unrecognized doesn't make it to lo_simple_ioctl() at all.
