Return-Path: <linux-fsdevel+bounces-34467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300419C5A74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61E51F219E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF31FCC67;
	Tue, 12 Nov 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wo9EdhFn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O03eL8K9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wo9EdhFn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O03eL8K9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8571F7093;
	Tue, 12 Nov 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422080; cv=none; b=XAO5743dvbZy5woLUZini5EHv3aBjENxSItROC/uimnhiwYpRNm11Esz1sSik2Hd9YtW8876s1SNkZHgyYzsEoHBlg2ZLnDycqcQnxphYo2/ebEh6Erwn+Lj+nzLrzBtRmjMtOWbHcciSl4FY/xoLBcb6IioGEvwJyaK4dfLva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422080; c=relaxed/simple;
	bh=38Cat+mTHIwEdTCRWoxB7/cJ0Tc2zilueN0nvwFkzdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIqytdvR5ruVSwJ38vuSsL9UUgO22Q1fL56Ie5/+1Qi+03wWYN0wvAcjrbTMNwHdLrsiG7Bn9JJvjXPg2WWMwZZWMOylTvNKB6Mqz45pW4MLYFEunsCIbP7lUuEpYQbN9I1+el4UahW+kmMReb3QAAmUELwgVJ81/9bJeysjn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wo9EdhFn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O03eL8K9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wo9EdhFn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O03eL8K9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9CF21F451;
	Tue, 12 Nov 2024 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731422076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVQgsqOYFZoxlytwLwYIeskoXYMoZVzYMX1BO/EMw8=;
	b=Wo9EdhFnFAPvNY6+Z/KkEpCRCgsFAEUyzleJ/yRlSenPkIf5+L41vB51cKs5Q/cEdcKog0
	8SAtVddMNLSeJJ6x0MQPrxNZcI0xxZZ7qNUCRy/zM/p/7BNl++NsiXUG+/dDtxYCc5k94j
	Nn3aKdoypSaj8TpMD9TC6WGgW19yQso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731422076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVQgsqOYFZoxlytwLwYIeskoXYMoZVzYMX1BO/EMw8=;
	b=O03eL8K9wy1y+iKsGzoVaQRu02eW6PlnV1TTGzJ0h7LKiHePkrTphVhygcxPljAUnSdlvY
	6Ka/D5pmlQeDB0CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731422076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVQgsqOYFZoxlytwLwYIeskoXYMoZVzYMX1BO/EMw8=;
	b=Wo9EdhFnFAPvNY6+Z/KkEpCRCgsFAEUyzleJ/yRlSenPkIf5+L41vB51cKs5Q/cEdcKog0
	8SAtVddMNLSeJJ6x0MQPrxNZcI0xxZZ7qNUCRy/zM/p/7BNl++NsiXUG+/dDtxYCc5k94j
	Nn3aKdoypSaj8TpMD9TC6WGgW19yQso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731422076;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9VVQgsqOYFZoxlytwLwYIeskoXYMoZVzYMX1BO/EMw8=;
	b=O03eL8K9wy1y+iKsGzoVaQRu02eW6PlnV1TTGzJ0h7LKiHePkrTphVhygcxPljAUnSdlvY
	6Ka/D5pmlQeDB0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9795313301;
	Tue, 12 Nov 2024 14:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nQT8JHxnM2cHfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 14:34:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47094A08D0; Tue, 12 Nov 2024 15:34:36 +0100 (CET)
Date: Tue, 12 Nov 2024 15:34:36 +0100
From: Jan Kara <jack@suse.cz>
To: Asahi Lina <lina@asahilina.net>
Cc: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <20241112143436.c2irwddrwopusqad@quack3>
References: <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
 <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
 <20241108121641.jz3qdk2qez262zw2@quack3>
 <a6866a71-dde9-44a2-8b0e-d6d3c4c702f8@asahilina.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6866a71-dde9-44a2-8b0e-d6d3c4c702f8@asahilina.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 12-11-24 18:49:46, Asahi Lina wrote:
> On 11/8/24 9:16 PM, Jan Kara wrote:
> > On Fri 08-11-24 01:09:54, Asahi Lina wrote:
> >> On 11/7/24 7:01 PM, Jan Kara wrote:
> >>> On Wed 06-11-24 11:59:44, Dan Williams wrote:
> >>>> Jan Kara wrote:
> >>>> [..]
> >>>>>> This WARN still feels like the wrong thing, though. Right now it is the
> >>>>>> only thing in DAX code complaining on a page size/block size mismatch
> >>>>>> (at least for virtiofs). If this is so important, I feel like there
> >>>>>> should be a higher level check elsewhere, like something happening at
> >>>>>> mount time or on file open. It should actually cause the operations to
> >>>>>> fail cleanly.
> >>>>>
> >>>>> That's a fair point. Currently filesystems supporting DAX check for this in
> >>>>> their mount code because there isn't really a DAX code that would get
> >>>>> called during mount and would have enough information to perform the check.
> >>>>> I'm not sure adding a new call just for this check makes a lot of sense.
> >>>>> But if you have some good place in mind, please tell me.
> >>>>
> >>>> Is not the reason that dax_writeback_mapping_range() the only thing
> >>>> checking ->i_blkbits because 'struct writeback_control' does writeback
> >>>> in terms of page-index ranges?
> >>>
> >>> To be fair, I don't remember why we've put the assertion specifically into
> >>> dax_writeback_mapping_range(). But as Dave explained there's much more to
> >>> this blocksize == pagesize limitation in DAX than just doing writeback in
> >>> terms of page-index ranges. The whole DAX entry tracking in xarray would
> >>> have to be modified to properly support other entry sizes than just PTE &
> >>> PMD sizes because otherwise the entry locking just doesn't provide the
> >>> guarantees that are expected from filesystems (e.g. you could have parallel
> >>> modifications happening to a single fs block in pagesize < blocksize case).
> >>>
> >>>> All other dax entry points are filesystem controlled that know the
> >>>> block-to-pfn-to-mapping relationship.
> >>>>
> >>>> Recall that dax_writeback_mapping_range() is historically for pmem
> >>>> persistence guarantees to make sure that applications write through CPU
> >>>> cache to media.
> >>>
> >>> Correct.
> >>>
> >>>> Presumably there are no cache coherency concerns with fuse and dax
> >>>> writes from the guest side are not a risk of being stranded in CPU
> >>>> cache. Host side filesystem writeback will take care of them when / if
> >>>> the guest triggers a storage device cache flush, not a guest page cache
> >>>> writeback.
> >>>
> >>> I'm not so sure. When you call fsync(2) in the guest on virtiofs file, it
> >>> should provide persistency guarantees on the file contents even in case of
> >>> *host* power failure. So if the guest is directly mapping host's page cache
> >>> pages through virtiofs, filemap_fdatawrite() call in the guest must result
> >>> in fsync(2) on the host to persist those pages. And as far as I vaguely
> >>> remember that happens by KVM catching the arch_wb_cache_pmem() calls and
> >>> issuing fsync(2) on the host. But I could be totally wrong here.
> >>
> >> I don't think that's how it actually works, at least on arm64.
> >> arch_wb_cache_pmem() calls dcache_clean_pop() which is either dc cvap or
> >> dc cvac. Those are trapped by HCR_EL2<TPC>, and that is never set by KVM.
> >>
> >> There was some discussion of this here:
> >> https://lore.kernel.org/all/20190702055937.3ffpwph7anvohmxu@US-160370MP2.local/
> > 
> > I see. Thanks for correcting me.
> > 
> >> But I'm not sure that all really made sense then.
> >>
> >> msync() and fsync() should already provide persistence. Those end up
> >> calling vfs_fsync_range(), which becomes a FUSE fsync(), which fsyncs
> >> (or fdatasyncs) the whole file. What I'm not so sure is whether there
> >> are any other codepaths that also need to provide those guarantees which
> >> *don't* end up calling fsync on the VFS. For example, the manpages kind
> >> of imply munmap() syncs, though as far as I can tell that's not actually
> >> the case. If there are missing sync paths, then I think those might just
> >> be broken right now...
> > 
> > munmap(2) is not an issue because that has no persistency guarantees in
> > case of power failure attached to it. Thinking about it some more I agree
> > that just dropping dax_writeback_mapping_range() from virtiofs should be
> > safe. The modifications are going to be persisted by the host eventually
> > (so writeback as such isn't needed) and all crash-safe guarantees are
> > revolving around calls like fsync(2), sync(2), sync_fs(2) which get passed
> > by fuse and hopefully acted upon on the host. I'm quite confident with this
> > because even standard filesystems such as ext4 flush disk caches only in
> > response to operations like these (plus some in journalling code but that's
> > a separate story).
> > 
> > 								Honza
> 
> I think we should go with that then. Should I send it as Suggested-by:
> Dan or do you want to send it?

I say go ahead and send it with Dan's suggested-by :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

