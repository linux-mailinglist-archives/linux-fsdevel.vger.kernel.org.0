Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A747428943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 10:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhJKJAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 05:00:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49112 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhJKJAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:00:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FABA2003F;
        Mon, 11 Oct 2021 08:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633942693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nFTauugQXCaCCh+0bc8cEQ37ERZ0+/bMBhgY8e9IWk=;
        b=cefpgdoXfDTF5WqJPAkxkS4iyg3gY6xiRB5pT2Qb/jhWCgZeI/LIglyalW3YFPDk1hFCKd
        daLMCLEoDuVsKMjBq5qJ8em8NAvk4j3mW7l03GGZ0Qo1X4vDnsJh2yaRWjW24RaBzdQI38
        LbzPxtaa0OS3I4OhuYK3PpG0Ycp6YFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633942693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nFTauugQXCaCCh+0bc8cEQ37ERZ0+/bMBhgY8e9IWk=;
        b=WLOLmJ8mPi20hEXcrb2+jpIsHMl6DunD2GyPrLRTQV9lRM1G88jEvXUmZRUYVhjOqOFu//
        W2oUtvszBpmA+XBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 23B33A3B81;
        Mon, 11 Oct 2021 08:58:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3B961E0FC4; Mon, 11 Oct 2021 10:58:12 +0200 (CEST)
Date:   Mon, 11 Oct 2021 10:58:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 0/2] quota: fix oops when loading corrupted quota file
Message-ID: <20211011085812.GA9697@quack2.suse.cz>
References: <20211008093821.1001186-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008093821.1001186-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-10-21 17:38:19, Zhang Yi wrote:
> We hit an oops issue on our Syzkaller machine, it test on an corrupted
> ext4 filesystem image with quota feature.
> 
>  BUG: unable to handle page fault for address: ffffffffd9c01f8d
>  PGD 732e0f067 P4D 732e0f067 PUD 732e11067 PMD 0 
>  Oops: 0000 [#1] SMP PTI
>  CPU: 5 PID: 1282 Comm: chown Not tainted 5.15.0-rc4-00019-g5af4055fa813 #572
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>  ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31
>  04/01/2014
>  RIP: 0010:do_raw_spin_lock+0x6/0x190
>  Code: e8 00 44 8b 4d 08 48 85 db 0f 84 c5 b9 e8 00 e9 fd b9 e8 00 48 83
>  05 d0 ec cc 02 01 31 db eb b0 0f 1f 40 00 0f 1f 44 00 00 53 <8b> 47 04
>  48 89 fb 48 83 05 0c ee cc 02 01 48 83 05 e4 ec cc 02 01
>  RSP: 0018:ffffac4140be7b78 EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: ffffffffd9c01f11 RCX: 0000000000000000
>  RDX: ffffac4140be7c00 RSI: 0000000000000001 RDI: ffffffffd9c01f89
>  RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000002
>  R10: 0000000000000001 R11: 0000000000000005 R12: ffffac4140be7c00
>  R13: ffffffffd9c01f89 R14: ffffac4140be7d20 R15: 0000000000000000
>  FS:  00007efd702dc580(0000) GS:ffff889ca5740000(0000)
>  knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffffffd9c01f8d CR3: 000000015dae8000 CR4: 00000000000006e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   _raw_spin_lock+0x1a/0x30
>   dquot_add_inodes+0x28/0x2a0
>   __dquot_transfer+0x3af/0x8e0
>   ? jbd2_journal_stop+0x213/0x510
>   ? __ext4_journal_stop+0x43/0x110
>   ? ext4_acquire_dquot+0xb2/0x120
>   ? dqget+0x317/0x710
>   dquot_transfer+0xaa/0x1f0
>   ext4_setattr+0x1b1/0xf20
>   ? path_lookupat.isra.0+0xca/0x200
>   notify_change+0x484/0x790
>   ? chown_common+0x16e/0x2f0
>   chown_common+0x16e/0x2f0
>   do_fchownat+0x107/0x180
>   __x64_sys_fchownat+0x29/0x40
>   do_syscall_64+0x3b/0x90
> 
> We could 100% reproduce it through the following simple test case. The
> first patche add some block validity check and the second patch fix an
> incorrect return value.
> 
> 
>  TEST_DEV=/dev/pmem0
>  
>  useradd fsgqa
>  useradd 123456-fsgqa
>  
>  mkfs.ext4 -F -O quota -b 1024 $TEST_DEV
>  debugfs -w -R "zap_block -o 0 -l 1 -p 6 -f <3> 1" $TEST_DEV
>  mount $TEST_DEV /mnt
>  chown fsgqa:fsgqa /mnt
>  touch /mnt/foo
>  rm -f /mnt/foo
>  chown 123456-fsgqa:123456-fsgqa /mnt
> 
> 
> Thanks,
> Yi.
> 
> Zhang Yi (2):
>   quota: check block number when reading the block in quota file
>   qupta: correct error number in free_dqentry()

Thanks, I've merged both patches into my tree with some minor spelling
fixes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
