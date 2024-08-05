Return-Path: <linux-fsdevel+bounces-25009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9012947AE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E601F21794
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4135E156862;
	Mon,  5 Aug 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CX7r3Irc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4q0B/Dlf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CX7r3Irc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4q0B/Dlf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A121553BD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860034; cv=none; b=RY4xXuK0g8IlJbTGE1YTT9fDXnp26PGJplgOpaB8eYhiJIEXaMY9jaWTfpgPzbsFkRRoNXQ5AKbFTyTJnEPoQIIFcmvjVuvF3cX/fJ9eN3of+73VLO+OxmPnUwFN3DpYA/l8ZWE8lEvLtAFwL6CAAMIf4qhc298axw4WrP7sQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860034; c=relaxed/simple;
	bh=q1zJdHVn6WpmI07WcosiGlQwtsGk+8FpxbJvdojsXZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYVvJDy0a8MadSFWb5XAkoSLluuezKEZieRe3cAEkmkprmyyyaJ9pc8sSP4KC/2hLALfqzyWNRdNtX+UvKOO2h4QOnV8cl9E0KtbzUEou0wL2IHoMWlEjpVoEXHoUhsL5txLEmY02wNNaa078J8uWvzW6Bcbq46MOrSfDliZc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CX7r3Irc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4q0B/Dlf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CX7r3Irc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4q0B/Dlf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19E991F839;
	Mon,  5 Aug 2024 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722860030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQy1qhsS25ufuqCAstuLNEzTgHNgD7Jtih3ghMK0QlQ=;
	b=CX7r3IrcJ01nI/QepPb43kK/hv0TxsRdV10Tfa9M9wwqh0SI+50EpUfWbTNR7SaVmqILjC
	50gmEyHRPDZzSPSr5rw9ihfzSWkgy23zUu2qb2pnINgO8N87QqXOwEHCAc9nH5LYM7t5NV
	ydA1Vths7VMXWdIdd9G03qxwALH/Kfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722860030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQy1qhsS25ufuqCAstuLNEzTgHNgD7Jtih3ghMK0QlQ=;
	b=4q0B/DlfbE9q6200rUYNU4Jj1jN98+4Ha5ssWVD+Xw4bOW3mOLAmk1kY4MmvgVQD3EGeHU
	bw7gpDBw/pFurjDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CX7r3Irc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4q0B/Dlf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722860030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQy1qhsS25ufuqCAstuLNEzTgHNgD7Jtih3ghMK0QlQ=;
	b=CX7r3IrcJ01nI/QepPb43kK/hv0TxsRdV10Tfa9M9wwqh0SI+50EpUfWbTNR7SaVmqILjC
	50gmEyHRPDZzSPSr5rw9ihfzSWkgy23zUu2qb2pnINgO8N87QqXOwEHCAc9nH5LYM7t5NV
	ydA1Vths7VMXWdIdd9G03qxwALH/Kfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722860030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQy1qhsS25ufuqCAstuLNEzTgHNgD7Jtih3ghMK0QlQ=;
	b=4q0B/DlfbE9q6200rUYNU4Jj1jN98+4Ha5ssWVD+Xw4bOW3mOLAmk1kY4MmvgVQD3EGeHU
	bw7gpDBw/pFurjDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E86813254;
	Mon,  5 Aug 2024 12:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FXaGA/7BsGZkIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 12:13:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ED50A0897; Mon,  5 Aug 2024 14:13:49 +0200 (CEST)
Date: Mon, 5 Aug 2024 14:13:49 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jan Kara <jack@suse.cz>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org
Subject: Re: [PATCH 10/10] fsnotify: generate pre-content permission event on
 page fault
Message-ID: <20240805121349.i4esnngbuckbpdea@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
 <20240801214025.t5zjblmdjreheab6@quack3>
 <20240802160357.GD6306@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802160357.GD6306@perftesting>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,fb.com,vger.kernel.org,gmail.com,kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 19E991F839

On Fri 02-08-24 12:03:57, Josef Bacik wrote:
> On Thu, Aug 01, 2024 at 11:40:25PM +0200, Jan Kara wrote:
> > On Thu 25-07-24 14:19:47, Josef Bacik wrote:
> > > FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
> > > on the faulting method.
> > > 
> > > This pre-content event is meant to be used by hierarchical storage
> > > managers that want to fill in the file content on first read access.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ...
> > > @@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> > >  	if (unlikely(index >= max_idx))
> > >  		return VM_FAULT_SIGBUS;
> > >  
> > > +	/*
> > > +	 * If we have pre-content watchers then we need to generate events on
> > > +	 * page fault so that we can populate any data before the fault.
> > > +	 *
> > > +	 * We only do this on the first pass through, otherwise the populating
> > > +	 * application could potentially deadlock on the mmap lock if it tries
> > > +	 * to populate it with mmap.
> > > +	 */
> > > +	if (fault_flag_allow_retry_first(vmf->flags) &&
> > > +	    fsnotify_file_has_content_watches(file)) {
> > 
> > I'm somewhat nervous that if ALLOW_RETRY isn't set, we'd silently jump into
> > readpage code without ever sending pre-content event and thus we'd possibly
> > expose invalid content to userspace? I think we should fail the fault if
> > fsnotify_file_has_content_watches(file) && !(vmf->flags &
> > FAULT_FLAG_ALLOW_RETRY).
> 
> I was worried about this too but it seems to not be the case that we'll not ever
> have ALLOW_RETRY.  That being said I'm fine turning this into a sigbus.

Do you mean that with your workloads we always have ALLOW_RETRY set? As I
wrote, currently you'd have to try really hard to hit such paths but they
are there - for example if you place uprobe on an address in a VMA that is
not present, the page fault is going to happen without ALLOW_RETRY set.

> > > +		int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
> > > +		loff_t pos = vmf->pgoff << PAGE_SHIFT;
> > > +
> > > +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> > > +
> > > +		/*
> > > +		 * We can only emit the event if we did actually release the
> > > +		 * mmap lock.
> > > +		 */
> > > +		if (fpin) {
> > > +			error = fsnotify_file_area_perm(fpin, mask, &pos,
> > > +							PAGE_SIZE);
> > > +			if (error) {
> > > +				fput(fpin);
> > > +				return VM_FAULT_ERROR;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > >  	/*
> > >  	 * Do we have something in the page cache already?
> > >  	 */
> > ...
> > > @@ -3612,6 +3643,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
> > >  	unsigned long rss = 0;
> > >  	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
> > >  
> > > +	/*
> > > +	 * We are under RCU, we can't emit events here, we need to force a
> > > +	 * normal fault to make sure the events get sent.
> > > +	 */
> > > +	if (fsnotify_file_has_content_watches(file))
> > > +		return ret;
> > > +
> > 
> > I don't think we need to do anything for filemap_map_pages(). The call just
> > inserts page cache content into page tables and whatever is in the page
> > cache and has folio_uptodate() set should be already valid file content,
> > shouldn't it?
> 
> I'll make this comment more clear.  filemap_fault() will start readahead,
> but we'll only emit the event for the page size that we're faulting.  I
> had looked at putting this at the readahead place and figuring out the
> readahead size, but literally anything could trigger readahead so it's
> better to just not allow filemap_map_pages() to happen, otherwise we'll
> end up with empty pages (if the content hasn't been populated yet) and
> never emit an event for those ranges.

This seems like an interesting problem. Even ordinary read(2) will trigger
readahead and as you say, we would be instantiating folios with wrong
content (zeros) due to that. It seems as a fragile design to keep such
folios in the page cache and place checks in all the places that could
possibly make their content visible to the user. I'd rather make sure that
if we pull folios into page cache (and set folio_uptodate() bit), their
content is indeed valid.

What we could do is to turn off readahead on the inode if
fsnotify_file_has_content_watches() is true. Essentially the handler of the
precontent event can do a much better job of prefilling the page cache with
whatever content is needed in a range that makes sense. And then we could
leave filemap_map_pages() intact. What do you think guys?

								Honza


> Thanks,
> 
> Josef
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

