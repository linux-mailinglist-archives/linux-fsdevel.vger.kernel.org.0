Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAFBF989
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfD3NHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 09:07:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbfD3NHo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:07:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 233F6ADC7;
        Tue, 30 Apr 2019 13:07:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AAC8E1E3BEC; Tue, 30 Apr 2019 15:07:39 +0200 (CEST)
Date:   Tue, 30 Apr 2019 15:07:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190430130739.GA11224@quack2.suse.cz>
References: <001a113ed5540f411c0568cc8418@google.com>
 <0000000000002cd22305879b22c4@google.com>
 <20190428185109.GD23075@ZenIV.linux.org.uk>
 <20190430025501.GB6740@quack2.suse.cz>
 <20190430031144.GG23075@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430031144.GG23075@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 30-04-19 04:11:44, Al Viro wrote:
> On Tue, Apr 30, 2019 at 04:55:01AM +0200, Jan Kara wrote:
> 
> > Yeah, you're right. And if we push the patch a bit further to not take
> > loop_ctl_mutex for invalid ioctl number, that would fix the problem. I
> > can send a fix.
> 
> Huh?  We don't take it until in lo_simple_ioctl(), and that patch doesn't
> get to its call on invalid ioctl numbers.  What am I missing here?

Doesn't it? blkdev_ioctl() calls into __blkdev_driver_ioctl() for
unrecognized ioctl numbers. That calls into lo_ioctl() in case of a loop
device. lo_ioctl() calls into lo_simple_ioctl() for ioctl numbers it
doesn't recognize and lo_simple_ioctl() will lock loop_ctl_mutex as you
say.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
