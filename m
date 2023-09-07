Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069C7976EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbjIGQSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbjIGQRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:17:35 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CD7D9C;
        Thu,  7 Sep 2023 09:06:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7b8d2631fdso1057028276.3;
        Thu, 07 Sep 2023 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694102704; x=1694707504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPtfkfbmzBJe0il1HeMhl5xNwrMq2oxj0ghltDuUoRI=;
        b=rJvu+SQIE7FAVlSW05CdEzCJiV+m/rRNdbIag7v1hBm6OCpsNlBvJcWn3s/lnPB44J
         2wzSXCZq3Q98salQO262v6KU1pm3JglLxeKZojDVd0e3O+UOIlgZpRWoRajrM0EBwUdH
         OARRvcwt9S84acLI6bx5BI7tM5dDq0F/ijK3KlUIP76hsLhIfIjIlb65Hvsffv0DBM7x
         4u47fBNc0vZ7sRJyGBDQUzHCaquPzcMvhNWkw2d8ZjzYMjv3HXP4Pw6oo2OGz+wP2fz8
         Kd7JpAUwBnY9kH/ZKjJG48yLWDU+sPh7qVn/9GJ0/sgGRuvhuW5jKDT2N73lDADwMlDr
         LYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102704; x=1694707504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPtfkfbmzBJe0il1HeMhl5xNwrMq2oxj0ghltDuUoRI=;
        b=BL510YJK7CyxMu62eG3vsYGRuqV/5aa7U8lE+E2CHJeRjM8mkJqwywp0UE96tw0LUB
         LZnDGgZE/ANge/CeTSkQNvDJuCLhUYj9xefqdf1yOum614jA6m+jJcp9xGru+rUyaQGL
         s7d7sskiRFxQZVhUORim/y7ilRJ1wkAYjzW9y6X0mRIkBxC21AecgfEOVXnTLFmLyQh0
         NS69Ke5fBpYd0t1OtcWBQ/MkE3RjaUJA9Ir7NOS5rxdJq+5bAAjBzVylGCZbwyNhx4cL
         HBuMMZ6W4sHA6khwzpDZ3j7KWdnKBcwRKYNnC4k/noDXJ1DlZDVmWVoxSVlCNwAPFk2B
         +QaQ==
X-Gm-Message-State: AOJu0Yx214t/M7tmxXfw1+ityGBsttrRKAto1/9MA6D0kb6QHMEgSqpQ
        mXMkykI/WxcsdZWG5oxeJX0Y/N4qrOM=
X-Google-Smtp-Source: AGHT+IHaerTIzyQ1j830ZBKfXGOl1PCU6e4CzctWhFwKBhiJsdxWsVxU4BOcmx5wcYE7alahTA0D7g==
X-Received: by 2002:a17:902:ce8e:b0:1c1:fc5c:b330 with SMTP id f14-20020a170902ce8e00b001c1fc5cb330mr19606805plg.12.1694091942106;
        Thu, 07 Sep 2023 06:05:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902bcc300b001b89b7e208fsm12732824pls.88.2023.09.07.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 06:05:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 7 Sep 2023 06:05:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Message-ID: <56f72849-178a-4cb7-b2e1-b7fc6695a6ef@roeck-us.net>
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809220545.1308228-14-hch@lst.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:05:45PM -0700, Christoph Hellwig wrote:
> As a rule of thumb everything allocated to the fs_context and moved into
> the super_block should be freed by ->kill_sb so that the teardown
> handling doesn't need to be duplicated between the fill_super error
> path and put_super.  Implement an ntfs3-specific kill_sb method to do
> that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

This patch results in:

[   10.136703] ------------[ cut here ]------------
ILLOPC: ffffffffbbcb48c0: 0f 0b
[   10.136841] VFS: Busy inodes after unmount of sdb (ntfs3)
[   10.138019] WARNING: CPU: 0 PID: 188 at fs/super.c:695 generic_shutdown_super+0x100/0x160
[   10.138241] Modules linked in:
[   10.138417] CPU: 0 PID: 188 Comm: umount Not tainted 6.5.0-12107-g7ba2090ca64e #1
[   10.138541] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[   10.138736] RIP: 0010:generic_shutdown_super+0x100/0x160
[   10.138857] Code: cc cc e8 b3 a1 f7 ff 48 8b bb 38 01 00 00 eb d9 48 8b 43 28 48 8d b3 20 06 00 00 48 c7 c7 48 f8 62 bd 48 8b 10 e8 d0 1a dd ff <0f> 0b 4c 8d a3 80 08 00 00 4c 89 e7 e8 
2f 51 06 01 48 8b 8b c0 08
[   10.139177] RSP: 0018:ffff9d8b004f3e60 EFLAGS: 00000282
[   10.139281] RAX: 0000000000000000 RBX: ffff979982dc1000 RCX: 0000000000000027
[   10.139378] RDX: ffff9799bec2c888 RSI: 0000000000000001 RDI: ffff9799bec2c880
[   10.139485] RBP: ffff979982dc18c0 R08: ffffffffbd956908 R09: 00000000ffffdfff
[   10.139584] R10: ffffffffbd876920 R11: ffffffffbd929cc8 R12: ffff979981418040
[   10.139681] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   10.139801] FS:  00007f6c00b1eb48(0000) GS:ffff9799bec00000(0000) knlGS:0000000000000000
[   10.139978] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.140096] CR2: 00007ffd8265f60f CR3: 0000000003268000 CR4: 00000000000406f0
[   10.140249] Call Trace:
[   10.140377]  <TASK>
[   10.140471]  ? __warn+0x7f/0x160
[   10.140561]  ? generic_shutdown_super+0x100/0x160
[   10.140636]  ? report_bug+0x199/0x1b0
[   10.140696]  ? prb_read_valid+0x16/0x20
[   10.140762]  ? handle_bug+0x3c/0x70
[   10.140828]  ? exc_invalid_op+0x18/0x70
[   10.140937]  ? asm_exc_invalid_op+0x1a/0x20
[   10.141036]  ? generic_shutdown_super+0x100/0x160
[   10.141129]  kill_block_super+0x16/0x40
[   10.141209]  ntfs3_kill_sb+0x13/0x50
[   10.141275]  deactivate_locked_super+0x30/0xa0
[   10.141344]  cleanup_mnt+0xfb/0x150
[   10.141414]  task_work_run+0x58/0xa0
[   10.141475]  exit_to_user_mode_prepare+0x108/0x110
[   10.141549]  syscall_exit_to_user_mode+0x21/0x50
[   10.141618]  do_syscall_64+0x4c/0x90
[   10.141677]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   10.141785] RIP: 0033:0x7f6c00aa421d
[   10.142030] Code: 05 48 89 c7 e8 d2 e8 ff ff 5a c3 31 f6 50 b8 a6 00 00 00 0f 05 48 89 c7 e8 be e8 ff ff 5a c3 48 63 f6 50 b8 a6 00 00 00 0f 05 <48> 89 c7 e8 a9 e8 ff ff 5a c3 49 89 ca 
50 48 63 ff 4d 63 c0 b8 2f
[   10.142241] RSP: 002b:00007ffd15c5ad90 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   10.142349] RAX: 0000000000000000 RBX: 00007f6c00b1fdc0 RCX: 00007f6c00aa421d
[   10.142437] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f6c00b1f9e0
[   10.142524] RBP: 00007f6c00b1f9f0 R08: 00007f6c00b1f9f0 R09: 0000000000000012
[   10.142611] R10: 00007f6c00b1f9fc R11: 0000000000000246 R12: 00007f6c00b1fdc0
[   10.142698] R13: 00007f6c00b1f9e0 R14: 0000000000000000 R15: 00007ffd15c5aee8
[   10.142828]  </TASK>
[   10.142966] ---[ end trace 0000000000000000 ]---
[   10.151159] general protection fault, probably for non-canonical address 0xdead000000000125: 0000 [#1] PREEMPT SMP PTI
[   10.151393] CPU: 0 PID: 188 Comm: umount Tainted: G        W          6.5.0-12107-g7ba2090ca64e #1
[   10.151504] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[   10.151626] RIP: 0010:iput.part.0+0xbd/0x230
[   10.151687] Code: 05 c0 8b e5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 f7 62 01 00 65 ff 0d 28 33 36 44 75 a5 0f 1f 44 00 00 eb 9e 48 8b 5d 28 <48> 8b 4b 30 a8 08 0f 85 d7 00 00 00 48 
8b 49 28 48 85 c9 0f 84 b6
[   10.151884] RSP: 0018:ffff9d8b004f3e80 EFLAGS: 00000246
[   10.151962] RAX: 0000000000000000 RBX: dead0000000000f5 RCX: ffff9799831c2458
[   10.152045] RDX: 0000000000000001 RSI: 00000000b39f7e05 RDI: ffff9799817a89d0
[   10.152126] RBP: ffff9799817a8948 R08: 00000000ffffffff R09: 00000000ffffffff
[   10.152206] R10: ffff9799817fc2c8 R11: 0000000000000000 R12: ffff9799817a89d0
[   10.152287] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   10.152367] FS:  00007f6c00b1eb48(0000) GS:ffff9799bec00000(0000) knlGS:0000000000000000
[   10.152459] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.152528] CR2: dead000000000125 CR3: 0000000003268000 CR4: 00000000000406f0
[   10.152609] Call Trace:
[   10.152644]  <TASK>
[   10.152678]  ? die_addr+0x32/0x90
[   10.152730]  ? exc_general_protection+0x1a8/0x3d0
[   10.152800]  ? asm_exc_general_protection+0x26/0x30
[   10.152869]  ? iput.part.0+0xbd/0x230
[   10.152940]  ntfs3_free_sbi+0x5d/0x110
[   10.153001]  deactivate_locked_super+0x30/0xa0
[   10.153078]  cleanup_mnt+0xfb/0x150
[   10.153132]  task_work_run+0x58/0xa0
[   10.153200]  exit_to_user_mode_prepare+0x108/0x110
[   10.153266]  syscall_exit_to_user_mode+0x21/0x50
[   10.153327]  do_syscall_64+0x4c/0x90
[   10.153384]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   10.153449] RIP: 0033:0x7f6c00aa421d
[   10.153499] Code: 05 48 89 c7 e8 d2 e8 ff ff 5a c3 31 f6 50 b8 a6 00 00 00 0f 05 48 89 c7 e8 be e8 ff ff 5a c3 48 63 f6 50 b8 a6 00 00 00 0f 05 <48> 89 c7 e8 a9 e8 ff ff 5a c3 49 89 ca 
50 48 63 ff 4d 63 c0 b8 2f
[   10.153697] RSP: 002b:00007ffd15c5ad90 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[   10.153788] RAX: 0000000000000000 RBX: 00007f6c00b1fdc0 RCX: 00007f6c00aa421d
[   10.153869] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f6c00b1f9e0
[   10.153949] RBP: 00007f6c00b1f9f0 R08: 00007f6c00b1f9f0 R09: 0000000000000012
[   10.154029] R10: 00007f6c00b1f9fc R11: 0000000000000246 R12: 00007f6c00b1fdc0
[   10.154110] R13: 00007f6c00b1f9e0 R14: 0000000000000000 R15: 00007ffd15c5aee8
[   10.154199]  </TASK>
[   10.154238] Modules linked in:
[   10.154539] ---[ end trace 0000000000000000 ]---
[   10.154666] RIP: 0010:iput.part.0+0xbd/0x230
[   10.154731] Code: 05 c0 8b e5 01 48 85 c0 74 0c 48 8b 78 08 48 89 ee e8 f7 62 01 00 65 ff 0d 28 33 36 44 75 a5 0f 1f 44 00 00 eb 9e 48 8b 5d 28 <48> 8b 4b 30 a8 08 0f 85 d7 00 00 00 48 
8b 49 28 48 85 c9 0f 84 b6
[   10.154999] RSP: 0018:ffff9d8b004f3e80 EFLAGS: 00000246
[   10.155070] RAX: 0000000000000000 RBX: dead0000000000f5 RCX: ffff9799831c2458
[   10.155159] RDX: 0000000000000001 RSI: 00000000b39f7e05 RDI: ffff9799817a89d0
[   10.155261] RBP: ffff9799817a8948 R08: 00000000ffffffff R09: 00000000ffffffff
[   10.155342] R10: ffff9799817fc2c8 R11: 0000000000000000 R12: ffff9799817a89d0
[   10.155423] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   10.155503] FS:  00007f6c00b1eb48(0000) GS:ffff9799bec00000(0000) knlGS:0000000000000000
[   10.155594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.155662] CR2: dead000000000125 CR3: 0000000003268000 CR4: 00000000000406f0

when trying to mount and unmount an ntfs3 file system.

Guenter

---
# bad: [7ba2090ca64ea1aa435744884124387db1fac70f] Merge tag 'ceph-for-6.6-rc1' of https://github.com/ceph/ceph-client
# good: [830b3c68c1fb1e9176028d02ef86f3cf76aa2476] Linux 6.1
git bisect start 'HEAD' 'v6.1'
# good: [5c7ecada25d2086aee607ff7deb69e77faa4aa92] Merge tag 'f2fs-for-6.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect good 5c7ecada25d2086aee607ff7deb69e77faa4aa92
# good: [6c1561fb900524c5bceb924071b3e9b8a67ff3da] Merge tag 'soc-dt-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 6c1561fb900524c5bceb924071b3e9b8a67ff3da
# bad: [68cf01760bc0891074e813b9bb06d2696cac1c01] Merge tag 'v6.6-p1' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 68cf01760bc0891074e813b9bb06d2696cac1c01
# good: [1c7873e3364570ec89343ff4877e0f27a7b21a61] mm: lock newly mapped VMA with corrected ordering
git bisect good 1c7873e3364570ec89343ff4877e0f27a7b21a61
# good: [b92e8f5472a28e311983f9f47e281e0adf56f10a] btrfs: print block group super and delalloc bytes when dumping space info
git bisect good b92e8f5472a28e311983f9f47e281e0adf56f10a
# bad: [330235e87410349042468b52baff02af7cb7d331] Merge tag 'acpi-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 330235e87410349042468b52baff02af7cb7d331
# bad: [547635c6ac47c7556d6954935b189defe90422f7] Merge tag 'for-6.6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad 547635c6ac47c7556d6954935b189defe90422f7
# good: [615e95831ec3d428cc554ac12e9439e2d66038d3] Merge tag 'v6.6-vfs.ctime' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect good 615e95831ec3d428cc554ac12e9439e2d66038d3
# bad: [475d4df82719225510625b4263baa1105665f4b3] Merge tag 'v6.6-vfs.fchmodat2' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect bad 475d4df82719225510625b4263baa1105665f4b3
# good: [de16588a7737b12e63ec646d72b45befb2b1f8f7] Merge tag 'v6.6-vfs.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect good de16588a7737b12e63ec646d72b45befb2b1f8f7
# bad: [8ffa54e3370c5a8b9538dbe4077fc9c4b5a08f45] xfs use fs_holder_ops for the log and RT devices
git bisect bad 8ffa54e3370c5a8b9538dbe4077fc9c4b5a08f45
# good: [4abc9a43d99ccab7bd71742b86d2f48d8be798c3] exfat: free the sbi and iocharset in ->kill_sb
git bisect good 4abc9a43d99ccab7bd71742b86d2f48d8be798c3
# bad: [4b41828be268544286794c18200e83861de3554e] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more robust
git bisect bad 4b41828be268544286794c18200e83861de3554e
# bad: [a4f64a300a299f884a1da55d99c97a87061201cd] ntfs3: free the sbi in ->kill_sb
git bisect bad a4f64a300a299f884a1da55d99c97a87061201cd
# good: [5f0fb2210bb34ecd3f7bfde0d8f0068b79b2e094] ntfs3: don't call sync_blockdev in ntfs_put_super
git bisect good 5f0fb2210bb34ecd3f7bfde0d8f0068b79b2e094
# first bad commit: [a4f64a300a299f884a1da55d99c97a87061201cd] ntfs3: free the sbi in ->kill_sb
