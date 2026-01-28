Return-Path: <linux-fsdevel+bounces-75817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGCuKhCUemmC8AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:56:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790BA9C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB8E730080BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540BD3446D8;
	Wed, 28 Jan 2026 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUevwDKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA3258ED5;
	Wed, 28 Jan 2026 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640964; cv=none; b=TsXFOv95pZQDPaPhDr5D0CqFVvgHHKrwhwZzDGhkMiFiEDQuHW83b0KR+6YA1mOaDp8CmSRTTXNa+qXHXAQWQcn5+UuhQ5stRDYwEMYbtLGjTXuTmhFLLp0NNYduxzMvgsjJ+08iO+n0E5Ojr5bXa4WKMbBbKad9YVAv5RX0CWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640964; c=relaxed/simple;
	bh=G6AVfIC1JGDmaTVQGwdR7hkkzoGFp2N573ZSu778fg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plpcb8vgpoS2Y/9wk+j3++SlqB8ZVkHHJgTABUeCVvpPgC26u0c9IoOno83OHq0HzD1Ki07M4WSPh5Od+wdg+TJ78+j2V+GWTFqamVO/3S+WYTE7Ky4sMcLUq849OvpHiN4L8ENHodFGCCZ2HL2KtGPmSLBd7ErYbL1c4HvQ7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUevwDKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EEDC4CEF1;
	Wed, 28 Jan 2026 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640964;
	bh=G6AVfIC1JGDmaTVQGwdR7hkkzoGFp2N573ZSu778fg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUevwDKSYXW2qTthC9suQTp33pQKthgDUbL5JNSr8SUB95p7dbq9JTSxHdI+D8HOd
	 /YqIbK8xa3d3Qzi2bBHGXDpc7pFtPhMllHX71bDnH4cJGrYgnci5TYNl/KlJUg1Fiq
	 e4yDFz3nJ+KopJVJ8s+TdRiFXhHwJ6mbEt1Tjk8+3C6XT5IVlWkp3RfoF13IUfR21B
	 wIgkwMYfz9yhgE8eQn+6TntFv4LHtqxeGuwUs9v7bnfX8U3VNieD6IMpG9hC+n3SJt
	 WrtLVoQ8Wj2cToeVUyzXmGk99CjqQDtTFdOzWyxTVDcXLZFgUlrji2NtZD9/EYkSfs
	 jwlYa7R7l7AgQ==
Date: Wed, 28 Jan 2026 14:56:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/15] fsverity: kick off hash readahead at data I/O
 submission time
Message-ID: <20260128225602.GB2024@quark>
References: <20260128152630.627409-1-hch@lst.de>
 <20260128152630.627409-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128152630.627409-9-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75817-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0790BA9C6D
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:26:20PM +0100, Christoph Hellwig wrote:
> Currently all reads of the fsverity hashes is kicked off from the data
> I/O completion handler, leading to needlessly dependent I/O.  This is
> worked around a bit by performing readahead on the level 0 nodes, but
> still fairly ineffective.
> 
> Switch to a model where the ->read_folio and ->readahead methods instead
> kick off explicit readahead of the fsverity hashed so they are usually
> available at I/O completion time.
> 
> For 64k sequential reads on my test VM this improves read performance
> from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
> random reads are likely to be even bigger.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Sterba <dsterba@suse.com> [btrfs]

Unfortunately, this patch causes recursive down_read() of
address_space::invalidate_lock.  How was this meant to work?

[   20.563185] ============================================
[   20.564179] WARNING: possible recursive locking detected
[   20.565170] 6.19.0-rc7-00041-g7bd72c6393ab #2 Not tainted
[   20.566180] --------------------------------------------
[   20.567169] cmp/2320 is trying to acquire lock:
[   20.568019] ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x280
[   20.569828] 
[   20.569828] but task is already holding lock:
[   20.570914] ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x280
[   20.572739] 
[   20.572739] other info that might help us debug this:
[   20.573938]  Possible unsafe locking scenario:
[   20.573938] 
[   20.575042]        CPU0
[   20.575522]        ----
[   20.576003]   lock(mapping.invalidate_lock#2);
[   20.576849]   lock(mapping.invalidate_lock#2);
[   20.577698] 
[   20.577698]  *** DEADLOCK ***
[   20.577698] 
[   20.578795]  May be due to missing lock nesting notation
[   20.578795] 
[   20.580045] 1 lock held by cmp/2320:
[   20.580726]  #0: ffff888108465030 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_unbounded+0x6f/0x20
[   20.582596] 
[   20.582596] stack backtrace:
[   20.583428] CPU: 0 UID: 0 PID: 2320 Comm: cmp Not tainted 6.19.0-rc7-00041-g7bd72c6393ab #2 PREEMPT(none) 
[   20.583433] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[   20.583435] Call Trace:
[   20.583437]  <TASK>
[   20.583438]  show_stack+0x48/0x60
[   20.583446]  dump_stack_lvl+0x75/0xb0
[   20.583451]  dump_stack+0x14/0x1a
[   20.583452]  print_deadlock_bug.cold+0xc0/0xca
[   20.583457]  validate_chain+0x4ca/0x970
[   20.583463]  __lock_acquire+0x587/0xc40
[   20.583465]  ? find_held_lock+0x31/0x90
[   20.583470]  lock_acquire.part.0+0xaf/0x230
[   20.583472]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583474]  ? debug_smp_processor_id+0x1b/0x30
[   20.583481]  lock_acquire+0x67/0x140
[   20.583483]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583484]  down_read+0x40/0x180
[   20.583487]  ? page_cache_ra_unbounded+0x6f/0x280
[   20.583489]  page_cache_ra_unbounded+0x6f/0x280
[   20.583491]  ? lock_acquire.part.0+0xaf/0x230
[   20.583492]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583495]  generic_readahead_merkle_tree+0x133/0x140
[   20.583501]  ext4_readahead_merkle_tree+0x2a/0x30
[   20.583507]  fsverity_readahead+0x9d/0xc0
[   20.583510]  ext4_mpage_readpages+0x194/0x9b0
[   20.583515]  ? __lock_release.isra.0+0x5e/0x160
[   20.583517]  ext4_readahead+0x3a/0x40
[   20.583521]  read_pages+0x84/0x370
[   20.583523]  page_cache_ra_unbounded+0x16c/0x280
[   20.583525]  page_cache_ra_order+0x10c/0x170
[   20.583527]  page_cache_sync_ra+0x1a1/0x360
[   20.583528]  filemap_get_pages+0x141/0x4c0
[   20.583532]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583534]  filemap_read+0x11f/0x540
[   20.583536]  ? __folio_batch_add_and_move+0x7c/0x330
[   20.583539]  ? __this_cpu_preempt_check+0x17/0x20
[   20.583541]  generic_file_read_iter+0xc1/0x110
[   20.583543]  ? do_pte_missing+0x13a/0x450
[   20.583547]  ext4_file_read_iter+0x51/0x17

