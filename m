Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3201F50D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfEONHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 09:07:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfEONHf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 09:07:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BEA1FABC1;
        Wed, 15 May 2019 13:07:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF5971E3C5A; Wed, 15 May 2019 15:07:30 +0200 (CEST)
Date:   Wed, 15 May 2019 15:07:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-block@vger.kernel.org
Subject: Re: INFO: task hung in __get_super
Message-ID: <20190515130730.GA9526@quack2.suse.cz>
References: <0000000000002cd22305879b22c4@google.com>
 <201905150102.x4F12b6o009249@www262.sakura.ne.jp>
 <20190515102133.GA16193@quack2.suse.cz>
 <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024bba2a-4d2f-1861-bfd9-819511bdf6eb@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-05-19 20:32:27, Tetsuo Handa wrote:
> On 2019/05/15 19:21, Jan Kara wrote:
> > The question is how to fix this problem. The simplest fix I can see is that
> > we'd just refuse to do LOOP_SET_FD if someone has the block device
> > exclusively open as there are high chances such user will be unpleasantly
> > surprised by the device changing under him. OTOH this has some potential
> > for userspace visible regressions. But I guess it's worth a try. Something
> > like attached patch?
> 
> (1) If I understand correctly, FMODE_EXCL is set at blkdev_open() only if
> O_EXCL is specified.

Yes.

> How can we detect if O_EXCL was not used, for the reproducer (
> https://syzkaller.appspot.com/text?tag=ReproC&x=135385a8a00000 ) is not
> using O_EXCL ?

mount_bdev() is using O_EXCL and that's what matters.

> (2) There seems to be no serialization. What guarantees that mount_bdev()
>     does not start due to preempted after the check added by this patch?

That's a good question. lo_ctl_mutex actually synchronizes most of this
(taken in both loop_set_fd() and lo_open()) but you're right that there's
still a small race window where loop_set_fd() need not see bdev->bd_holders
elevated while blkdev_get() will succeed. So I need to think a bit more
about proper synchronization of this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
