Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA427404B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 13:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIVLCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 07:02:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgIVLCS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:02:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92ED3AD85;
        Tue, 22 Sep 2020 11:02:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71E0CDA6E9; Tue, 22 Sep 2020 13:01:01 +0200 (CEST)
Date:   Tue, 22 Sep 2020 13:01:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+84a0634dc5d21d488419@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible deadlock in blkdev_put
Message-ID: <20200922110101.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+84a0634dc5d21d488419@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <000000000000fc04d105afcf86d7@google.com>
 <20200922091642.GE16464@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922091642.GE16464@quack2.suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:16:42AM +0200, Jan Kara wrote:
> Looks like btrfs issue. Adding relevant people to CC.

Thanks.

> On Mon 21-09-20 02:32:21, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    325d0eab Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=102425d9900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b12e84189082991c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=84a0634dc5d21d488419
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+84a0634dc5d21d488419@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 5.9.0-rc5-syzkaller #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.0/6878 is trying to acquire lock:
> > ffff88804c17d780 (&bdev->bd_mutex){+.+.}-{3:3}, at: blkdev_put+0x30/0x520 fs/block_dev.c:1804
> > 
> > but task is already holding lock:
> > ffff8880908cfce0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: close_fs_devices.part.0+0x2e/0x800 fs/btrfs/volumes.c:1159
> > 
> > which lock already depends on the new lock.

That matches what "btrfs: move btrfs_rm_dev_replace_free_srcdev outside
of all locks" fixes, among other syzbot reports.

On the way to master:
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=next-fixes&id=d1db82c9a34451e8c0288315b51d9a67fb8eff95
