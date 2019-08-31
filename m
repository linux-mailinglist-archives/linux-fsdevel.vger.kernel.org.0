Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7EA4516
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 17:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfHaPmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 11:42:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39838 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaPmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:42:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i45WY-0005fB-7m; Sat, 31 Aug 2019 15:42:46 +0000
Date:   Sat, 31 Aug 2019 16:42:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkp@01.org
Subject: Re: [fs/namei.c]  e013ec23b8: WARNING:at_fs/dcache.c:#dentry_free
Message-ID: <20190831154246.GY1131@ZenIV.linux.org.uk>
References: <20190831130917.ea4yx4uo5uttxk6l@inn2.lkp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831130917.ea4yx4uo5uttxk6l@inn2.lkp.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 09:09:17PM +0800, kernel test robot wrote:

> [   13.886602] WARNING: CPU: 0 PID: 541 at fs/dcache.c:338 dentry_free+0x7f/0x90
> [   13.889208] Modules linked in:
> [   13.890276] CPU: 0 PID: 541 Comm: readlink Not tainted 5.3.0-rc1-00008-ge013ec23b8231 #1
> [   13.892699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   13.895419] RIP: 0010:dentry_free+0x7f/0x90
> [   13.896739] Code: f0 75 cb 48 8d be b0 00 00 00 48 83 c4 08 48 c7 c6 60 8d cd a5 e9 51 69 e4 ff 48 89 3c 24 48 c7 c7 f8 a9 cb a6 e8 7f 37 e3 ff <0f> 0b 48 8b 34 24 eb 8f 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90
> [   13.901957] RSP: 0018:ffffb5524063fe38 EFLAGS: 00010282
> [   13.903527] RAX: 0000000000000024 RBX: ffff9941878040c0 RCX: ffffffffa706aa08
> [   13.905566] RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000246
> [   13.907612] RBP: 0000000000000000 R08: 0000000000000280 R09: 0000000000000033
> [   13.909664] R10: 0000000000000000 R11: ffffb5524063fce8 R12: ffff994187804118
> [   13.911711] R13: ffff99427a810000 R14: ffff994187d7c8f0 R15: ffff99427a810b80
> [   13.913753] FS:  0000000000000000(0000) GS:ffff9942bfc00000(0000) knlGS:0000000000000000
> [   13.916187] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [   13.917892] CR2: 000000000937458b CR3: 000000006800a000 CR4: 00000000000006f0
> [   13.919925] Call Trace:
> [   13.920840]  __dentry_kill+0x13c/0x1a0
> [   13.922076]  path_put+0x12/0x20
> [   13.923148]  free_fs_struct+0x1b/0x30
> [   13.924346]  do_exit+0x304/0xc40
> [   13.925438]  ? __schedule+0x25d/0x670
> [   13.926642]  do_group_exit+0x3a/0xa0
> [   13.927817]  __ia32_sys_exit_group+0x14/0x20
> [   13.929160]  do_fast_syscall_32+0xa9/0x340
> [   13.930565]  entry_SYSENTER_compat+0x7f/0x91
> [   13.931924] ---[ end trace 02c6706eb2c2ebf2 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.3.0-rc1-00008-ge013ec23b8231 .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

Can't reproduce here...

I see one potential problem in there, but I would expect it to have the
opposite effect (I really don't believe that it's a ->d_count wraparound -
that would've taken much longer than a minute, if nothing else).

How reliably is it reproduced on your setup and does the following have
any impact, one way or another?

diff --git a/fs/namei.c b/fs/namei.c
index 412479e4c258..671c3c1a3425 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -643,10 +643,8 @@ static bool legitimize_root(struct nameidata *nd)
 {
 	if (!nd->root.mnt || (nd->flags & LOOKUP_ROOT))
 		return true;
-	if (unlikely(!legitimize_path(nd, &nd->root, nd->root_seq)))
-		return false;
 	nd->flags |= LOOKUP_ROOT_GRABBED;
-	return true;
+	return legitimize_path(nd, &nd->root, nd->root_seq);
 }
 
 /*
