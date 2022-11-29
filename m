Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5249763B88A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 04:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiK2DG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 22:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiK2DGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:06:55 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E69FE09;
        Mon, 28 Nov 2022 19:06:50 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AT36cD1024412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 22:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669691201; bh=M4rHxCg6JKzqJ4nEeTDWsAlMSHzC3QVS7TIvKuS9ZnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=G74482q/+yr023kqbiRqx5pY6uGFJRMwASJX18GB0m1Mm4i0qTd7DfjaZD4QGioNR
         xbJdu2bHxfiPexSIOYaUyneufYE6/d8Dh412oFgGlE0j1Pb5YJAA3nMGdhzGPuo7Dj
         YOynz6eFC+fZYqKkcsGZG9VO0ViGsSKr3OP/U4H4GvTUQoQmlPClosn+mFtOtI/6mk
         w019MFqyXtoGokVCSLw6Jdw/QYSf6L2jU98lCOd1ELTmujuPMK6iLrb0cKSr7pH92f
         tFOIYTxi95b6nA/HVM++qZXRFJ8eJUFnvaQ3ERyL179Z7IyPM4qLj5TgjBUOQpEUiB
         Web6qozKGNbBg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4ED1815C00E4; Mon, 28 Nov 2022 22:06:34 -0500 (EST)
Date:   Mon, 28 Nov 2022 22:06:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y4V3OrSwxA8rZHyy@mit.edu>
References: <cover.1665776268.git.ojaswin@linux.ibm.com>
 <8421bbe2feb4323f5658757a3232e4c02e20c697.1665776268.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8421bbe2feb4323f5658757a3232e4c02e20c697.1665776268.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit (determined via bisecion) seems to be causing a reliable
failure using the ext4/ext3 configuration when running generic/269:

% kvm-xfstests -c ext4/ext3 generic/269
    ...
BEGIN TEST ext3 (1 test): Ext4 4k block emulating ext3 Mon Nov 28 21:39:35 EST 2022
DEVICE: /dev/vdd
EXT_MKFS_OPTIONS: -O ^extents,^flex_bg,^uninit_bg,^64bit,^metadata_csum,^huge_file,^die
EXT_MOUNT_OPTIONS: -o block_validity,nodelalloc
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 kvm-xfstests 6.1.0-rc4-xfstests-00018-g1c85d4890f15 #8492
MKFS_OPTIONS  -- -F -q -O ^extents,^flex_bg,^uninit_bg,^64bit,^metadata_csum,^huge_filc
MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity,nodelalloc /dev/vdc /vdc

generic/269 23s ...  [21:39:35][    3.085973] run fstests generic/269 at 2022-11-28 215
[   14.931680] ------------[ cut here ]------------
[   14.931902] kernel BUG at fs/ext4/mballoc.c:4025!
[   14.932137] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   14.932366] CPU: 1 PID: 2677 Comm: fsstress Not tainted 6.1.0-rc4-xfstests-00018-g19
[   14.932756] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-4
[   14.933169] RIP: 0010:ext4_mb_pa_adjust_overlap.constprop.0+0x18e/0x1c0
[   14.933457] Code: 66 54 8b 48 54 89 4c 24 04 e8 ae 92 9f 00 41 8b 46 40 85 c0 75 bc4
[   14.934270] RSP: 0018:ffffc90003aeb868 EFLAGS: 00010283
[   14.934499] RAX: 0000000000000000 RBX: 00000000000000fc RCX: 0000000000000000
[   14.934830] RDX: 0000000000000001 RSI: ffffc90003aeb8d4 RDI: 0000000000000001
[   14.935146] RBP: 0000000000000200 R08: 0000000000008000 R09: 0000000000000001
[   14.935447] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000103
[   14.935744] R13: 0000000000000101 R14: ffff8880073370e0 R15: ffff888007337118
[   14.936043] FS:  00007f94eda0b740(0000) GS:ffff88807dd00000(0000) knlGS:000000000000
[   14.936390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.936634] CR2: 000055ba905a0448 CR3: 000000001092c005 CR4: 0000000000770ee0
[   14.936932] PKRU: 55555554
[   14.937048] Call Trace:
[   14.937190]  <TASK>
[   14.937285]  ext4_mb_normalize_request.constprop.0+0x1e9/0x440
[   14.937534]  ext4_mb_new_blocks+0x3a2/0x560
[   14.937715]  ext4_alloc_branch+0x21e/0x350
[   14.937892]  ext4_ind_map_blocks+0x322/0x750
[   14.938076]  ext4_map_blocks+0x380/0x6e0
[   14.938260]  _ext4_get_block+0xb2/0x120
[   14.938426]  ext4_block_write_begin+0x13c/0x3d0
[   14.938624]  ? _ext4_get_block+0x120/0x120
[   14.938801]  ext4_write_begin+0x1c1/0x570
[   14.938973]  generic_perform_write+0xcf/0x220
[   14.939175]  ext4_buffered_write_iter+0x84/0x140
[   14.939377]  do_iter_readv_writev+0xf0/0x150
[   14.939562]  do_iter_write+0x80/0x150
[   14.939722]  vfs_writev+0xed/0x1f0
[   14.939871]  do_writev+0x73/0x100
[   14.940016]  do_syscall_64+0x37/0x90
[   14.940186]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   14.940403] RIP: 0033:0x7f94edb02da3
[   14.940559] Code: 8b 15 f1 90 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f8
[   14.941341] RSP: 002b:00007ffc5e82d0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
[   14.941659] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: 00007f94edb02da3
[   14.941961] RDX: 0000000000000356 RSI: 000055ba901c1240 RDI: 0000000000000003
[   14.942290] RBP: 0000000000000003 R08: 000055ba901cf240 R09: 00007f94edbccbe0
[   14.942596] R10: 0000000000000080 R11: 0000000000000246 R12: 000000000000062a
[   14.942902] R13: 0000000000000356 R14: 000055ba901c1240 R15: 000000000000b529
[   14.943219]  </TASK>
[   14.943326] ---[ end trace 0000000000000000 ]---

Looking at the stack trace it looks like we're hitting this BUG_ON:

		spin_lock(&tmp_pa->pa_lock);
		if (tmp_pa->pa_deleted == 0)
			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
		spin_unlock(&tmp_pa->pa_lock);

... in the inline function ext4_mb_pa_assert_overlap(), called from
ext4_mb_pa_adjust_overlap().

The generic/269 test runs fstress with an ENOSPC hitter as an
antogonist process.  The ext3 configuration disables delayed
allocation, which means that fstress is going to be allocating blocks
at write time (instead of dirty page writeback time).

Could you take a look?   Thanks!

						- Ted
