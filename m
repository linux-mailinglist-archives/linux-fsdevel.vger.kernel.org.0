Return-Path: <linux-fsdevel+bounces-46582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59BEA90AE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D78F3B30FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726721ABAA;
	Wed, 16 Apr 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUue77R9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D965217723;
	Wed, 16 Apr 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826919; cv=none; b=djjTgelH4GJmrzWJfQUE5aeJbUMOrKn+A87FqCgPpmrCHBz7QB2AxKKF0jXBSBoO+PWcdIJJ3OFpD4VnrvW5kSxnlXXJMXR4W51iD7Pfawm2G5KK9EQ6eezbCQz559///qNZOf8UQBaOvWWq1/qx2GrkogX8ztsIVSJorKNpc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826919; c=relaxed/simple;
	bh=y+txb+Hoc7kRj0gHmHqFRU5cVYJ7URrQ8h6MBpihVI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h9C9vCgXJxwbQ5hByFcdpo7zMlL6JZrBaz31TrzX48EzQy05cOccyWEIu6g4heKV21pBI+KZdLHCJTFIt6S2trRlQpMcIUiYCxzNHZfshnA1akREpI29UqvvdFwoJ+Xg7TLp/XOHxc5gAEvbCn74jFSrrG1jIQBWhum0dTq0BRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUue77R9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE6CC4CEE2;
	Wed, 16 Apr 2025 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744826918;
	bh=y+txb+Hoc7kRj0gHmHqFRU5cVYJ7URrQ8h6MBpihVI0=;
	h=Date:From:To:Cc:Subject:From;
	b=PUue77R9FoBdWqVLBzqW+apgigeVbvFuVKM50AudITazjm94Pinc1z13S0H6BRWsd
	 OK/JiUscRUA7Rqr8RRFuB/XJrV0J8ohq6xmHxPDj26i/aby4ZDfISVs9XMilVZDDq6
	 H4uNkYkoiVs2/VQsLG365glH9RhQF9gHgHyAs1fu8tB6fIIOMJyjplM9n3t7nYWLJN
	 AK0RiTpQF4y419Bow431yxUxfhOlEBBkOQRqqGkSmvYN6Ku3qHSq2CZoF/1+VPc9Wm
	 JtOxgkAmXSIIVc/ursD/hSuPP2t6sx9GcNUAn/IOL/pA8yxBXUOEzItreO77R40dcK
	 RtBW7v1CTEExg==
Date: Wed, 16 Apr 2025 11:08:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: linux-xfs@vger.kernel.org
Subject: [6.15-rc2 regression] iomap: null pointer in a bio completion
Message-ID: <20250416180837.GN25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I upgraded my arm64 kernel to 6.15-rc2, and I also see this splat in
generic/363.  The fstets config is as follows:

MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=65536,"
MOUNT_OPTIONS=""

The VM is arm64 with 64k base pages.  I've disabled LBS to work around
a fair number of other strange bugs.  Does this ring a bell for anyone?

--D

list_add double add: new=ffffffff40538c88, prev=fffffc03febf8148, next=ffffffff40538c88.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:35!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in: dm_delay dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm
_flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf
xt_set nft_compat ip_set_hash_mac nf_tables sha2_ce sha256_arm64 bfq sch_fq_codel fuse l
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.15.0-rc2-xfsa #rc2 
Tainted: [W]=WARN
Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
pstate: 604010c5 (nZCv daIF +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : __list_add_valid_or_report+0xd4/0xd8
lr : __list_add_valid_or_report+0xd4/0xd8
sp : fffffe008180fa70
x29: fffffe008180fa70 x28: ffffffff40538c80 x27: 0000000000000000
x26: ffffffff40538c88 x25: ffffffff40538c88 x24: fffffc03febf8148
x23: fffffc03ffdfdd80 x22: 0000000000000001 x21: fffffc03febf8148
x20: 0000000000000000 x19: ffffffff40538c88 x18: 0000000000000010
x17: 3834313866626566 x16: 3330636666666666 x15: 3d76657270202c38
x14: 3863383335303466 x13: 2e38386338333530 x12: fffffe0081304268
x11: 00000000008c8bc0 x10: 00000000008c8b68 x9 : fffffe00800e2940
x8 : c00000010001db68 x7 : fffffe00812f9068 x6 : 0000000005000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : fffffc00e06f3200 x0 : 0000000000000058
Call trace:
 __list_add_valid_or_report+0xd4/0xd8 (P)
 free_frozen_page_commit+0x98/0x398
 __free_frozen_pages+0x32c/0x5e8
 free_frozen_pages+0x1c/0x30
 __folio_put+0xc0/0x138
 folio_end_writeback+0xf0/0x1e8
 iomap_finish_ioend_buffered+0x134/0x3b8
 iomap_writepage_end_bio+0x34/0x50
 bio_endio+0x178/0x228
 blk_update_request+0x188/0x4b8
 scsi_end_request+0x38/0x278
 scsi_io_completion+0x64/0x660
 scsi_finish_command+0xdc/0x120
 scsi_complete+0x88/0x198
 blk_mq_complete_request+0x3c/0x58
 scsi_done_internal+0xcc/0x150
 scsi_done+0x1c/0x30
 virtscsi_complete_cmd+0xa4/0x160
 virtscsi_req_done+0x7c/0xe8
 vring_interrupt+0x70/0xb8
 __handle_irq_event_percpu+0x58/0x228
 handle_irq_event+0x54/0xb8
 handle_fasteoi_irq+0xc8/0x268
 handle_irq_desc+0x48/0x68
 generic_handle_domain_irq+0x24/0x38
 gic_handle_irq+0x54/0x124
 call_on_irq_stack+0x24/0x58
 do_interrupt_handler+0xdc/0xf0
 el1_interrupt+0x34/0x68
 el1h_64_irq_handler+0x18/0x28
 el1h_64_irq+0x6c/0x70
 default_idle_call+0x38/0x148 (P)
 do_idle+0x20c/0x270
 cpu_startup_entry+0x3c/0x50
 secondary_start_kernel+0x12c/0x158
 __secondary_switched+0xc0/0xc8
Code: aa1503e2 f0003ca0 91156000 97ee8906 (d4210000) 
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt
SMP: stopping secondary CPUs
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
CPU features: 0x0800,000000e0,01000650,8241700b
Memory Limit: none
---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt ]---

