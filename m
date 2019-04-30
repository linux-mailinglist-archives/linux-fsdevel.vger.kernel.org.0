Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32FFC72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfD3PH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:07:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:58418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD3PH6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:07:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39B3CAD33;
        Tue, 30 Apr 2019 15:07:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D52041E3BEC; Tue, 30 Apr 2019 17:07:53 +0200 (CEST)
Date:   Tue, 30 Apr 2019 17:07:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190430150753.GA14000@quack2.suse.cz>
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
 <20190430031144.GG23075@ZenIV.linux.org.uk>
 <20190430130739.GA11224@quack2.suse.cz>
 <20190430131820.GK23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430131820.GK23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-04-19 14:18:21, Al Viro wrote:
> On Tue, Apr 30, 2019 at 03:07:39PM +0200, Jan Kara wrote:
> > On Tue 30-04-19 04:11:44, Al Viro wrote:
> > > On Tue, Apr 30, 2019 at 04:55:01AM +0200, Jan Kara wrote:
> > > 
> > > > Yeah, you're right. And if we push the patch a bit further to not take
> > > > loop_ctl_mutex for invalid ioctl number, that would fix the problem. I
> > > > can send a fix.
> > > 
> > > Huh?  We don't take it until in lo_simple_ioctl(), and that patch doesn't
> > > get to its call on invalid ioctl numbers.  What am I missing here?
> > 
> > Doesn't it? blkdev_ioctl() calls into __blkdev_driver_ioctl() for
> > unrecognized ioctl numbers. That calls into lo_ioctl() in case of a loop
> > device. lo_ioctl() calls into lo_simple_ioctl() for ioctl numbers it
> > doesn't recognize and lo_simple_ioctl() will lock loop_ctl_mutex as you
> > say.
> 
> Not with the patch upthread.  lo_ioctl() part was
> 
> @@ -1567,10 +1564,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
>  	case LOOP_SET_BLOCK_SIZE:
>  		if (!(mode & FMODE_WRITE) && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> -		/* Fall through */
> +		return lo_simple_ioctl(lo, cmd, arg);
>  	default:
> -		err = lo_simple_ioctl(lo, cmd, arg);
> -		break;
> +		return -EINVAL;
>  	}
>  
>  	return err;
> 
> so anything unrecognized doesn't make it to lo_simple_ioctl() at all.

Ah, right. I've missed that in your patch. So your patch should be really
fixing the problem. Will you post it officially? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
