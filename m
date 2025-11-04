Return-Path: <linux-fsdevel+bounces-66948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE4C3107A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF41A4E91F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58D2EB841;
	Tue,  4 Nov 2025 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2po4ymw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dofjR7yM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2po4ymw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dofjR7yM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC29BD96
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260138; cv=none; b=rC4DTGfP8unYK+ODvll6+u+P/SOH7HqlCW9nxgejynBM0h4ipwT9XXN0abHrntGSJQ32EwaZZTkDbMV6gbVYx/SgRF/yHDXxO67rCO5yM3SXPp3KV/YpkY9R8Eacw3+fGbbgNcxJ6LzWafMgs+ViAZciwMGEo7rit167owgc49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260138; c=relaxed/simple;
	bh=gR8k9hcil4t6MZaR8pcDqIsnghRiT3qRPIpREe7ZpHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRCUobCqCKKY/8gFvffRqvPexxAKOoGfKOka7stksdGC2JNX1dWshofyXGpKPJ7UAYvFPWtIoVtnpmNmz3xHM4cYmfSwyhKpTCPB5EWEzCNlGBLXLCCEZ7ZwssKSJOF6sDzBUDtFBxW42SfCPwe0sTNn4033rWyprwiVcR8Zlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2po4ymw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dofjR7yM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2po4ymw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dofjR7yM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB0292118C;
	Tue,  4 Nov 2025 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762260134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nor8wdBoIuiGnISw8EUnq57y9SkwuWb+No/Lg9Q/14=;
	b=t2po4ymwq3x7o2u2fle0Bo4wsIrY8Ck6BEe5BRfudTbz23k65Cgh3XHFjcC27IG98TvwEo
	5x0CMxuaJdK5OfwtFZZiVCZptdMx27uV9jJKM6V8afaDbJk+VQL+Rhs/LF8GyP21BsHl2d
	q+FzjYDDRK5GAWWrGOn7WUrx6h3agHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762260134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nor8wdBoIuiGnISw8EUnq57y9SkwuWb+No/Lg9Q/14=;
	b=dofjR7yMFa5EDtxf3yZcXJHQqoX+AnJ3TGl9CHfmnoBnRjBcpHwPTeJBvaxc8NMcb5exQ1
	WW1fW2PiMf5wcpCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762260134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nor8wdBoIuiGnISw8EUnq57y9SkwuWb+No/Lg9Q/14=;
	b=t2po4ymwq3x7o2u2fle0Bo4wsIrY8Ck6BEe5BRfudTbz23k65Cgh3XHFjcC27IG98TvwEo
	5x0CMxuaJdK5OfwtFZZiVCZptdMx27uV9jJKM6V8afaDbJk+VQL+Rhs/LF8GyP21BsHl2d
	q+FzjYDDRK5GAWWrGOn7WUrx6h3agHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762260134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Nor8wdBoIuiGnISw8EUnq57y9SkwuWb+No/Lg9Q/14=;
	b=dofjR7yMFa5EDtxf3yZcXJHQqoX+AnJ3TGl9CHfmnoBnRjBcpHwPTeJBvaxc8NMcb5exQ1
	WW1fW2PiMf5wcpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFC19139A9;
	Tue,  4 Nov 2025 12:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ss3lKqb0CWnpXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:42:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55B93A28E6; Tue,  4 Nov 2025 13:42:14 +0100 (CET)
Date: Tue, 4 Nov 2025 13:42:14 +0100
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
Message-ID: <ewespqy3nwdpdrwn46bsqapx4hzbliru2ieq2wggghqgwssepo@ucz67koqt23w>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
 <414a076b-174d-414a-b629-9f396bce5538@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414a076b-174d-414a-b629-9f396bce5538@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,vger.kernel.org,zeniv.linux.org.uk,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 04-11-25 19:13:04, Qu Wenruo wrote:
> [...]
> > > > On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
> > > > > At this stage, btrfs is only one super block update away to be fully committed.
> > > > > I believe it's the more or less the same for other fses too.
> > > > 
> > > > Most file systems do not need a superblock update to commit data.
> > > 
> > > That's the main difference, btrfs always needs a superblock update to switch
> > > metadata due to its metadata COW nature.
> > > 
> > > The only good news is, emergency sync is not that a hot path, we have a lot
> > > of time to properly fix.
> > 
> > I'd say even better news is that emergency sync is used practically only
> > when debugging the kernel. So we can do what we wish and will have to live
> > with whatever pain we inflict onto ourselves ;).
> 
> Then what about some documents around the sysrq-s usage?
> 
> The current docs only shows "Will attempt to sync all mounted filesystems",
> thus I guess that's the reason why the original reporter is testing it,
> expecting it's a proper way to sync the fses.

The key is in the word "attempt" :). But yes, we could expand the
description to something like "Will try to writeback data on all mounted
filesystems. There are no guarantees when the data actually hits the
storage or whether all of the data ever hits it. It is just a desperate
attempt to limit data loss if possible."

> > > > > The problem is the next step, sync_bdevs().
> > > > > Normally other fses have their super block already updated in the page
> > > > > cache of the block device, but btrfs only updates the super block during
> > > > > full transaction commit.
> > > > > 
> > > > > So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
> > > > > still using its older super block, all pointing back to the old metadata
> > > > > and data.
> > > > > 
> > > > 
> > > > At least for XFS, no metadata is written through the block device
> > > > mapping anyway.
> > > > 
> > > 
> > > So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will always
> > > submit needed metadata (journal?) to disk?
> > 
> > No, sync_inodes_one_sb() will just prepare transaction in memory (both for
> > ext4 and xfs). For ext4 sync_fs_one_sb() with wait == 0 will start writeback
> > of this transaction to the disk and sync_fs_one_sb() with wait == 1 will make
> > sure the transaction is fully written out (committed). For xfs
> > sync_fs_one_sb() with wait == 0 does nothing, sync_fs_one_sb() with wait
> > == 1 makes sure the transaction is committed.
> 
> Then my question is, why EXT4 (and XFS) is fine with the emergency sync with
> a power loss, at least according to the original reporter.
> 
> Is the journal already committed for every metadata changes?

No it is not. For ext4 if the transaction grows large we'll commit it. Also
if it gets too old (5s by default), we'll commit it. XFS will likely have
similar constraints. So data loss is limited but definitely not completely
avoided. But that never was the point of emergency sync.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

