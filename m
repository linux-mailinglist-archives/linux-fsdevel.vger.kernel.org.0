Return-Path: <linux-fsdevel+bounces-63946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C48BD2B02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D11C346FE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC126A1B6;
	Mon, 13 Oct 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ylakt6nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhVD3dfx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ylakt6nJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uhVD3dfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C51F4703
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353321; cv=none; b=c1UUqKMOolKPUeKXpe4llF+noJxo7QUrw0ezi6mBxSg48kTX3N0ktO9J6BKi1C8iRXg/l/I9H6nsiHLmUcmnJe5z5VD3mrJztu2oBHwLaPWgzRD04AtT1o9NkZX6Waf0vn3/mcfb8hjxa1qg/tNI+GibHNlrbJOL3+SQ4x5i628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353321; c=relaxed/simple;
	bh=kvMCiUwbXB8fb9VrpsB2T2inrNZ3vhTARyP+8578cXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXWkMFLGB1cspDcje7599zVXYsQ2kXgS5dBX+gG6lKxNHKdN3LcuXCsyMGNc5mx4cPfJ1irmvG/1W8X9tgJdxcuqvw5z3BWwaunT0n39tPH2AVkhlx5uNG+wZYMNGMU7GezAmEABcgYA7PVFQ2jDncYWPNL6v2iaAjUcSC6C8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ylakt6nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhVD3dfx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ylakt6nJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uhVD3dfx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 876A61F7B9;
	Mon, 13 Oct 2025 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760353317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zy8pfvyXl3VuUijiH4RETqJtOQUlXSkDaMZCmtJF83E=;
	b=Ylakt6nJHMdkPdOymXjxqcwZC7UAQuNtqe93yQJTPNglXfMAK2bfbJHxbx3SgtlJDDfDGY
	Y/HCdETEBOuaD9mcFXTmb1IMJGMK5v9RCTR4GS1dbk8JcrIKWBXVi9qjyz814UwWeVgtxb
	H6va4D97R6KKTo1tZRDCSuYEnh/z2qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760353317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zy8pfvyXl3VuUijiH4RETqJtOQUlXSkDaMZCmtJF83E=;
	b=uhVD3dfxWidyK+nP+PZLffwzR7zS+ju6MNd0rTD0b/jvg/2MiL/V4Kthnf/xWoeDA0BQOS
	eAjaoc0Hp9lcW4AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760353317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zy8pfvyXl3VuUijiH4RETqJtOQUlXSkDaMZCmtJF83E=;
	b=Ylakt6nJHMdkPdOymXjxqcwZC7UAQuNtqe93yQJTPNglXfMAK2bfbJHxbx3SgtlJDDfDGY
	Y/HCdETEBOuaD9mcFXTmb1IMJGMK5v9RCTR4GS1dbk8JcrIKWBXVi9qjyz814UwWeVgtxb
	H6va4D97R6KKTo1tZRDCSuYEnh/z2qQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760353317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zy8pfvyXl3VuUijiH4RETqJtOQUlXSkDaMZCmtJF83E=;
	b=uhVD3dfxWidyK+nP+PZLffwzR7zS+ju6MNd0rTD0b/jvg/2MiL/V4Kthnf/xWoeDA0BQOS
	eAjaoc0Hp9lcW4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792F0139D8;
	Mon, 13 Oct 2025 11:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMGRHSXc7GgLSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 11:01:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 238E7A0A58; Mon, 13 Oct 2025 13:01:49 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:01:49 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: jack@suse.cz, willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, dlemoal@kernel.org, 
	linux-xfs@vger.kernel.org, hans.holmberg@wdc.com
Subject: Re: [PATCH, RFC] limit per-inode writeback size considered harmful
Message-ID: <j55u2ol6bconzpeaxdldqjimyrmnuafx5jarzhvic3r2ljbdus@tkmjzu4ka7eh>
References: <20251013072738.4125498-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013072738.4125498-1-hch@lst.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello!

On Mon 13-10-25 16:21:42, Christoph Hellwig wrote:
> we have a customer workload where the current core writeback behavior
> causes severe fragmentation on zoned XFS despite a friendly write pattern
> from the application.  We tracked this down to writeback_chunk_size only
> giving about 30-40MBs to each inode before switching to a new inode,
> which will cause files that are aligned to the zone size (256MB on HDD)
> to be fragmented into usually 5-7 extents spread over different zones.
> Using the hack below makes this problem go away entirely by always
> writing an inode fully up to the zone size.  Damien came up with a
> heuristic here:
> 
>   https://lore.kernel.org/linux-xfs/20251013070945.GA2446@lst.de/T/#t
> 
> that also papers over this, but it falls apart on larger memory
> systems where we can cache more of these files in the page cache
> than we open zones.
> 
> Does anyone remember the reason for this limit writeback size?  I
> looked at git history and the code touched comes from a refactoring in
> 2011, and before that it's really hard to figure out where the original
> even worse behavior came from.   At least for zoned devices based
> on a flag or something similar we'd love to avoid switching between
> inodes during writeback, as that would drastically reduce the
> potential for self-induced fragmentation.

That has been a long time ago but as far as I remember the idea of the
logic in writeback_chunk_size() is that for background writeback we want
to:

a) Reasonably often bail out to the main writeback loop to recheck whether
more writeback is still needed (we are still over background threshold,
there isn't other higher priority writeback work such as sync etc.).

b) Alternate between inodes needing writeback so that continuously dirtying
one inode doesn't starve writeback on other inodes.

c) Write enough so that writeback can be efficient.

Currently we have MIN_WRITEBACK_PAGES which is hardwired to 4MB and which
defines granularity of write chunk. Now your problem sounds like you'd like
to configure MIN_WRITEBACK_PAGES on per BDI basis and I think that makes
sense. Do I understand you right?

								Honza

> 
> ---
>  fs/fs-writeback.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..9dd9c5f4d86b 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1892,9 +1892,11 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
>  	 *                   (quickly) tag currently dirty pages
>  	 *                   (maybe slowly) sync all tagged pages
>  	 */
> -	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
> +	if (1) { /* XXX: check flag */
> +		pages = SZ_256M; /* Don't hard code? */
> +	} else if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages) {
>  		pages = LONG_MAX;
> -	else {
> +	} else {
>  		pages = min(wb->avg_write_bandwidth / 2,
>  			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
>  		pages = min(pages, work->nr_pages);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

