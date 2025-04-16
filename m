Return-Path: <linux-fsdevel+bounces-46579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9312A90A5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 19:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E684476BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FE218AB9;
	Wed, 16 Apr 2025 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFidgRJQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2C2139C4;
	Wed, 16 Apr 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825439; cv=none; b=OTbLPj1seeoNgujzhnRkuDv8454N7mv83p2C6YNvK/S0HeMczjoSWF9MNjGz+kuVCeq3msoUTnSZu02lxfggsyrvyrhYnxUktiq53mIuQq+uYbl3GOW+XZiTTkg1zkjpalurnYsQtdfLG2dysCm9aeD5X25JQAKJhniN2QkxUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825439; c=relaxed/simple;
	bh=Lo9jwrieLP5o4ZDRqzDbGqU898hWvBSp8D51Zlz8DPw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JlNy6bzmVeDPI6st/tedEKY0lzDCIqYvX1CdQ8ALiEGyD2QTuBHYKOZQJuoUOSAS3gv+LC+GHuSaofGw617cRBOTJIDhbOhcH7UCSmZKs+jYBEjIIzhSh4yMG9AbrkXbJIPU5u+yPLCbl08FL0rAbFetohJ+03FLgydRz36jS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFidgRJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006D9C4CEE2;
	Wed, 16 Apr 2025 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744825439;
	bh=Lo9jwrieLP5o4ZDRqzDbGqU898hWvBSp8D51Zlz8DPw=;
	h=Date:From:To:Cc:Subject:From;
	b=aFidgRJQSNRZ6Z1cTDN/zSzxg9740CbPef4H9usMI/iIOYZgD6/Z7ig/Vh3D1rVMY
	 QR0Co+FZNTaS65/8xDxwFVLhGXlhBAjC1Qwsyo4Wx0vohokPj97ouiC4BsVr26S5bD
	 qszP3c9bY7mOSHsKGqeOXubX1CeML6rpOClFd+9z+512PQYHroLSusFRAYUIDkw2ZR
	 SHbOtZjHlyLGW+XvyBlLE0we2YuRMiItcGNQVieMs+bAwuzPvxT53/aa1y1ehdKRE5
	 POCuvasxspgYhiDuaeJkz3lhUcK6qz1TMGAWhF4By3cfrvUTgThD9NQLrzAb4rmhmA
	 dlEXWLhMIZnJw==
Date: Wed, 16 Apr 2025 10:43:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: linux-xfs@vger.kernel.org
Subject: [6.15-rc2 regression] xfs: null pointer in the dax fault code
Message-ID: <20250416174358.GM25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

After upgrading to 6.15-rc2, I see the following crash in (I think?) the
DAX code on xfs/593 (which is a fairly boring fsck test).

MKFS_OPTIONS=" -m metadir=1,autofsck=1,uquota,gquota,pquota, -d daxinherit=1,"
MOUNT_OPTIONS=""

Any ideas?  Does this stack trace ring a bell for anyone?

--D

BUG: kernel NULL pointer dereference, address: 00000000000008a8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] SMP
CPU: 2 UID: 0 PID: 1717921 Comm: fsstress Tainted: G        W           6.15.0-rc2-xfsx #rc2 PREEMPT(lazy)
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__lruvec_stat_mod_folio+0x50/0xd0
Code: e8 85 70 da ff 48 8b 53 38 48 89 d0 48 83 e0 f8 83 e2 02 74 04 48 8b 40 10 48 63 d5 48 85 c0 74 50 6
0 75 54 44
RSP: 0000:ffffc9000679fa20 EFLAGS: 00010206
RAX: 0000000000000200 RBX: ffffea000e298040 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000012 RDI: ffffea000e298040
RBP: 0000000000000001 R08: 8000000000000025 R09: 0000000000000001
R10: 0000000000001000 R11: ffffc9000679fc10 R12: 0000000000000012
R13: ffff88807ffd9d80 R14: ffff888040a79a80 R15: ffffea000e298040
FS:  00007f2dce659740(0000) GS:ffff8880fb85e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000008a8 CR3: 000000005f22a003 CR4: 00000000001706f0
Call Trace:
 <TASK>
 folio_add_file_rmap_ptes+0x109/0x200
 insert_page_into_pte_locked+0x1b6/0x340
 insert_page+0x93/0xc0
 vmf_insert_page_mkwrite+0x2d/0x50
 dax_fault_iter+0x330/0x730
 dax_iomap_pte_fault+0x1a9/0x3e0
 __xfs_write_fault+0x11d/0x290 [xfs 05d1f477986dfc3e3925c4fd18979e6f6f9a9e35]
 __do_fault+0x2d/0x170
 do_fault+0xc8/0x680
 __handle_mm_fault+0x5ba/0x1030
 handle_mm_fault+0x18f/0x280
 do_user_addr_fault+0x481/0x7e0
 exc_page_fault+0x62/0x130
 asm_exc_page_fault+0x22/0x30
RIP: 0033:0x7f2dce7af44a
Code: c5 fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 47 60 c5 f8 77 c3 66 0f 1f 84 00 00 00 00 00 40 0
0 00 66 90
RSP: 002b:00007fffe75b3198 EFLAGS: 00010202
RAX: 0000000000000054 RBX: 000000000008c000 RCX: 0000000000000dfd
RDX: 00007f2dce63e000 RSI: 0000000000000054 RDI: 00007f2dce658000
RBP: 000000000001adfd R08: 0000000000000005 R09: 000000000008c000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007fffe75b31e0
R13: 8f5c28f5c28f5c29 R14: 00007fffe75b37a0 R15: 000056030c3be570
 </TASK>
Modules linked in: ext4 crc16 mbcache jbd2 xfs nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv
set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables nfnetlink sha512_ssse3 ahci
d_btt sch_fq_codel loop fuse configfs ip_tables x_tables overlay nfsv4 af_packet
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 00000000000008a8
---[ end trace 0000000000000000 ]---


