Return-Path: <linux-fsdevel+bounces-46583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51032A90B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949051774D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F656224259;
	Wed, 16 Apr 2025 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tztLz82X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0E224227;
	Wed, 16 Apr 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828720; cv=none; b=gkFlsxlMZWCcrzAKKQZM4OzkYLQwP2RTX9D+oeqE9UNvUF9HFxixcS0DiBbo6qEVqol8aHV6MWXFXmjRJuhK0sai7709D450HYTzpcDwWWp+5NSUjmcNKlA72wBBErbE9vJutNffDQbjsCs9TEso2NYWfrgCk+QbTSy+EIKOoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828720; c=relaxed/simple;
	bh=nVMqA/Qlk1IH4Z6r4PoitFLc0yd/4vubnMeZeTd635I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijfF9k1kF1Y0MWwQ0Kpr2H9FwdnTLIzgVbNTCfDLTBYLkKEioclAZIVYnDA/fD2diYVxatIcLIr+j2zDQzCgXUIyZBMWJ6HOOgX8GjHlVoNsh+mVUUne/ejkKAc81MBvRCMnGPlw6jMS4r6MaVpf5YA6NrBdBQHsjzZTmgbmDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tztLz82X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u0W4fVf5J1wIDIFv2MqEHTC0oXA5XqadkRfhKcpZmg0=; b=tztLz82XrJRBwUSIShQYcuYFwx
	PV7dzSaMgtp+N6NLk1LZmpJUy2DUhX8OUfj7qvZaDZwdfN2m6YDIjOwMLCZiZeYzUjfv3AwHP8GJO
	eIT+tTIlrCNMgPTdWmyvF97Dgz8p+Gv+Vj75CHLsUGJs6ZvIyLWQ6zJ43yfdNZK0RzsMDUrQw4lH3
	KkyKXPzS+0Gh6zwd3jhK34cD/nDnsMOQELFOHMDxpLWomC3VMdBWE0PFC4mkcZdI4cyykwmFuTs5O
	3rzTiEJH0aUOv3VRwx8JAB3Rrsw58uPgtB0HFYDbLHNU33QBVzSGOn2K5uExi4zCdDL8rhD+TkEW0
	2cdEhvpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u57ee-0000000AQft-43mx;
	Wed, 16 Apr 2025 18:38:36 +0000
Date: Wed, 16 Apr 2025 19:38:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [6.15-rc2 regression] iomap: null pointer in a bio completion
Message-ID: <Z__5LOpee2-5rIaE@casper.infradead.org>
References: <20250416180837.GN25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416180837.GN25675@frogsfrogsfrogs>

On Wed, Apr 16, 2025 at 11:08:37AM -0700, Darrick J. Wong wrote:
> Hi folks,
> 
> I upgraded my arm64 kernel to 6.15-rc2, and I also see this splat in
> generic/363.  The fstets config is as follows:
> 
> MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=65536,"
> MOUNT_OPTIONS=""
> 
> The VM is arm64 with 64k base pages.  I've disabled LBS to work around
> a fair number of other strange bugs.  Does this ring a bell for anyone?
> 
> --D
> 
> list_add double add: new=ffffffff40538c88, prev=fffffc03febf8148, next=ffffffff40538c88.

Not a bell, but it's weird.  We're trying to add ffffffff40538c88 to
the list, but next already has that value.  So this is a double-free of
the folio?  Do you have VM_BUG_ON_FOLIO enabled with CONFIG_VM_DEBUG?

> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:35!
> Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in: dm_delay dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm
> _flakey xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf
> xt_set nft_compat ip_set_hash_mac nf_tables sha2_ce sha256_arm64 bfq sch_fq_codel fuse l
> CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.15.0-rc2-xfsa #rc2 
> Tainted: [W]=WARN
> Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
> pstate: 604010c5 (nZCv daIF +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> pc : __list_add_valid_or_report+0xd4/0xd8
> lr : __list_add_valid_or_report+0xd4/0xd8
> sp : fffffe008180fa70
> x29: fffffe008180fa70 x28: ffffffff40538c80 x27: 0000000000000000
> x26: ffffffff40538c88 x25: ffffffff40538c88 x24: fffffc03febf8148
> x23: fffffc03ffdfdd80 x22: 0000000000000001 x21: fffffc03febf8148
> x20: 0000000000000000 x19: ffffffff40538c88 x18: 0000000000000010
> x17: 3834313866626566 x16: 3330636666666666 x15: 3d76657270202c38
> x14: 3863383335303466 x13: 2e38386338333530 x12: fffffe0081304268
> x11: 00000000008c8bc0 x10: 00000000008c8b68 x9 : fffffe00800e2940
> x8 : c00000010001db68 x7 : fffffe00812f9068 x6 : 0000000005000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : fffffc00e06f3200 x0 : 0000000000000058
> Call trace:
>  __list_add_valid_or_report+0xd4/0xd8 (P)
>  free_frozen_page_commit+0x98/0x398
>  __free_frozen_pages+0x32c/0x5e8
>  free_frozen_pages+0x1c/0x30
>  __folio_put+0xc0/0x138
>  folio_end_writeback+0xf0/0x1e8
>  iomap_finish_ioend_buffered+0x134/0x3b8
>  iomap_writepage_end_bio+0x34/0x50
>  bio_endio+0x178/0x228
>  blk_update_request+0x188/0x4b8
>  scsi_end_request+0x38/0x278
>  scsi_io_completion+0x64/0x660
>  scsi_finish_command+0xdc/0x120
>  scsi_complete+0x88/0x198
>  blk_mq_complete_request+0x3c/0x58
>  scsi_done_internal+0xcc/0x150
>  scsi_done+0x1c/0x30
>  virtscsi_complete_cmd+0xa4/0x160
>  virtscsi_req_done+0x7c/0xe8
>  vring_interrupt+0x70/0xb8
>  __handle_irq_event_percpu+0x58/0x228
>  handle_irq_event+0x54/0xb8
>  handle_fasteoi_irq+0xc8/0x268
>  handle_irq_desc+0x48/0x68
>  generic_handle_domain_irq+0x24/0x38
>  gic_handle_irq+0x54/0x124
>  call_on_irq_stack+0x24/0x58
>  do_interrupt_handler+0xdc/0xf0
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x28
>  el1h_64_irq+0x6c/0x70
>  default_idle_call+0x38/0x148 (P)
>  do_idle+0x20c/0x270
>  cpu_startup_entry+0x3c/0x50
>  secondary_start_kernel+0x12c/0x158
>  __secondary_switched+0xc0/0xc8
> Code: aa1503e2 f0003ca0 91156000 97ee8906 (d4210000) 
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt
> SMP: stopping secondary CPUs
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> CPU features: 0x0800,000000e0,01000650,8241700b
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt ]---
> 

