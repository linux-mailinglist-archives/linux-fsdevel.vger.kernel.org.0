Return-Path: <linux-fsdevel+bounces-24839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1694542D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 23:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14277285EED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 21:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88414B95F;
	Thu,  1 Aug 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPvXf82Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sS4er+Ot";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWVGv/y0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S5ppgNLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD214A603
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548430; cv=none; b=jnuCr5stgVbpUO9rDKjnWKzB3bYMqCjAkXJpGDh/WLgxTwpoVCF0ftJDtB+afx4O8EAOGi9541ta2eiGduAsaIn4tN3d7BKW7dQuC6CCF59f3lWc9tgXZ6c9HXS3Du+Hbt1ZsOJoqPRQkzaeGSFO8tSEkvIZmn+ARQBAUA1xYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548430; c=relaxed/simple;
	bh=M8uzxpINF8vB7mnz4qTEFvNEHJ/tNZdhiiChCNAxn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiWNQftE4K4io7Cr4guOimPr1RSCX8D0lhxXJaKwhEaGl0Z1sIEEYJ7sDtqpVHDDOZAaCwvfaGGXdHfoG9+WElkw/hswZ+UN21D1uAxE3Y31QiSUqMVeKFvFh5w4avxpMBCxd/T1OyBltEmPIhys1ADueH8AJd5QPBmo1WvuE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPvXf82Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sS4er+Ot; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWVGv/y0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S5ppgNLB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F2511FB6F;
	Thu,  1 Aug 2024 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722548427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0Q2PtiHBCLXGENC38iuFqiVU+DWqIYDxSVFpbVu//Q=;
	b=bPvXf82Qkw0at8cOUyJtdi4RBbV2RVrlCP6xJtKf7QjShN+wlStrywNwyciUvM9iul5Cri
	MDyLiveQAfKqH670MS45LkZ2ye734B4O5oEoMsmOsaNgFclE3YFbjDa5sxntzvdfuxDAxv
	+hfzcOC34xE7zI/Vu2KoCYjASf5Qjvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722548427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0Q2PtiHBCLXGENC38iuFqiVU+DWqIYDxSVFpbVu//Q=;
	b=sS4er+Ot1XeaujgUII1z7PN4wqb14ujHorGr6O78nWFm3FkvRSbIUDkWchLjKChDuY1njz
	EC7pmBrVyQvwh/AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lWVGv/y0";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S5ppgNLB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722548426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0Q2PtiHBCLXGENC38iuFqiVU+DWqIYDxSVFpbVu//Q=;
	b=lWVGv/y0QX6MOkW+v9O1baOsmjUEXsC6OXqsA0YcjugxHra9XLWuY4DFSUEzMLeGxQeEC+
	fxgcjXeSmPCVcNrIlNFBd6x0uNwFFvM7C9mfAPv060hzKXEgri6BjUSQbhDtGROLtALTjD
	CVwx2J6MyOLLuNqwlo5bL0HGi/kEGvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722548426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0Q2PtiHBCLXGENC38iuFqiVU+DWqIYDxSVFpbVu//Q=;
	b=S5ppgNLBm9ttUwDkNPRi6wxOtBKA99ATXhHLLJFNZxtqPb/E7OgAGUMPmIHuHP50xqPWb7
	jqNrSIIKBPPgeZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15490136CF;
	Thu,  1 Aug 2024 21:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m+QsBcoArGZ8dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 21:40:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CBB85A08CB; Thu,  1 Aug 2024 23:40:25 +0200 (CEST)
Date: Thu, 1 Aug 2024 23:40:25 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240801214025.t5zjblmdjreheab6@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,toxicpanda.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 1F2511FB6F
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.81

On Thu 25-07-24 14:19:47, Josef Bacik wrote:
> FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> on the faulting method.
> 
> This pre-content event is meant to be used by hierarchical storage
> managers that want to fill in the file content on first read access.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
...
> @@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	if (unlikely(index >= max_idx))
>  		return VM_FAULT_SIGBUS;
>  
> +	/*
> +	 * If we have pre-content watchers then we need to generate events on
> +	 * page fault so that we can populate any data before the fault.
> +	 *
> +	 * We only do this on the first pass through, otherwise the populating
> +	 * application could potentially deadlock on the mmap lock if it tries
> +	 * to populate it with mmap.
> +	 */
> +	if (fault_flag_allow_retry_first(vmf->flags) &&
> +	    fsnotify_file_has_content_watches(file)) {

I'm somewhat nervous that if ALLOW_RETRY isn't set, we'd silently jump into
readpage code without ever sending pre-content event and thus we'd possibly
expose invalid content to userspace? I think we should fail the fault if
fsnotify_file_has_content_watches(file) && !(vmf->flags &
FAULT_FLAG_ALLOW_RETRY).

> +		int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
> +		loff_t pos = vmf->pgoff << PAGE_SHIFT;
> +
> +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +
> +		/*
> +		 * We can only emit the event if we did actually release the
> +		 * mmap lock.
> +		 */
> +		if (fpin) {
> +			error = fsnotify_file_area_perm(fpin, mask, &pos,
> +							PAGE_SIZE);
> +			if (error) {
> +				fput(fpin);
> +				return VM_FAULT_ERROR;
> +			}
> +		}
> +	}
> +
>  	/*
>  	 * Do we have something in the page cache already?
>  	 */
...
> @@ -3612,6 +3643,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	unsigned long rss = 0;
>  	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
>  
> +	/*
> +	 * We are under RCU, we can't emit events here, we need to force a
> +	 * normal fault to make sure the events get sent.
> +	 */
> +	if (fsnotify_file_has_content_watches(file))
> +		return ret;
> +

I don't think we need to do anything for filemap_map_pages(). The call just
inserts page cache content into page tables and whatever is in the page
cache and has folio_uptodate() set should be already valid file content,
shouldn't it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

