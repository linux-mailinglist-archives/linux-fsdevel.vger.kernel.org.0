Return-Path: <linux-fsdevel+bounces-49223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4CDAB9950
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43FF3A2237
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4C230BE9;
	Fri, 16 May 2025 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jfHPkFos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIEh9PWT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jfHPkFos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIEh9PWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89021B9E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388922; cv=none; b=uGvEWATFmmTDmAH1nmiEFW1KbzU0Hqz36xYacrvtfBG4wpStYAyTpBcfioK5n90EXTiIaGpPMOuOLXiw2XqwZ3W4brQOXt2LB01qM5CA2S2h/9TuzVrVC88HfOOJMNy6AmgTW+mjCQkfgW7WpU+WP9wcdePi0rz/DwVwwdIHabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388922; c=relaxed/simple;
	bh=nogtO8ftGcaHoVtJVaRpB3bEfBdfkhsxvYWkFVA/SDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2o81wERciuNuvfVXEUMxRaJ9MljgFJGUCvL/OJtXQG+zBmTFFtRqPBV4TLZoKOpM0+xIUesiDR7pD7JjnOem99DPMl4A3k+sdlCLcLvZAZGMoDa4uVLvb9GRMS372uN099vHm4490J8EUw7y2/cYD/XTiNALQtrFWio64ORwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jfHPkFos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIEh9PWT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jfHPkFos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIEh9PWT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59DF31F7EE;
	Fri, 16 May 2025 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHw5iVD+t2SLXfhdn4ldQrSf6ixQ4NJaqF98oyKz1K8=;
	b=jfHPkFosPekWRPYxIZK7DMoPmkKErln2qFM+F3MzV1+6ILhpKDl03TrY2BuM/WDGR/VH40
	1Ig4LDQaQwbHe8PM1FYGrbC1kw9NxfmbJjf/hqyycGntydDpWagBjSkJFK0BCLMb5TqJiP
	NQyj9l9uThier3b/adQgPqEuqmxJ7CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHw5iVD+t2SLXfhdn4ldQrSf6ixQ4NJaqF98oyKz1K8=;
	b=EIEh9PWTxyN6RutoZDatN65xvgmMRe3UcjzJDkFRECE8XOhhjyM/7lTtGZYsA+pbCQCmov
	bk3TH66tJLScs5Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHw5iVD+t2SLXfhdn4ldQrSf6ixQ4NJaqF98oyKz1K8=;
	b=jfHPkFosPekWRPYxIZK7DMoPmkKErln2qFM+F3MzV1+6ILhpKDl03TrY2BuM/WDGR/VH40
	1Ig4LDQaQwbHe8PM1FYGrbC1kw9NxfmbJjf/hqyycGntydDpWagBjSkJFK0BCLMb5TqJiP
	NQyj9l9uThier3b/adQgPqEuqmxJ7CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388919;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHw5iVD+t2SLXfhdn4ldQrSf6ixQ4NJaqF98oyKz1K8=;
	b=EIEh9PWTxyN6RutoZDatN65xvgmMRe3UcjzJDkFRECE8XOhhjyM/7lTtGZYsA+pbCQCmov
	bk3TH66tJLScs5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ABAC13977;
	Fri, 16 May 2025 09:48:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O0A5EvcJJ2gfdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 16 May 2025 09:48:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4522A09DD; Fri, 16 May 2025 11:48:38 +0200 (CEST)
Date: Fri, 16 May 2025 11:48:38 +0200
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Machine lockup with large d_invalidate()
Message-ID: <tqjywesrp66t4bc4k5xap3bqnomqtm62nwwoff25uxi7nk46dp@7y6rdgwckwag>
References: <vmjjaofrxvwfkse7gybj5r4mj2mbg345ganq3ydbzllees7oi2@uomtwdvj6xcd>
 <CAJfpegs-umW78v6WzX-4_2DkMLzdoFX=BY5Jp7P+QR+m62TEiw@mail.gmail.com>
 <CAJfpegsWWFqQriC5k859=AYK3C0ingNZ2_KpoMFKMpXkucKEYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsWWFqQriC5k859=AYK3C0ingNZ2_KpoMFKMpXkucKEYQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]

On Thu 15-05-25 17:22:57, Miklos Szeredi wrote:
> On Thu, 15 May 2025 at 17:15, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 15 May 2025 at 16:57, Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello,
> > >
> > > we have a customer who is mounting over NFS a directory (let's call it
> > > hugedir) with many files (there are several millions dentries on d_children
> > > list). Now when they do 'mv hugedir hugedir.bak; mkdir hugedir' on the
> > > server, which invalidates NFS cache of this directory, NFS clients get
> > > stuck in d_invalidate() for hours (until the customer lost patience).
> > >
> > > Now I don't want to discuss here sanity or efficiency of this application
> > > architecture but I'm sharing the opinion that it shouldn't take hours to
> > > invalidate couple million dentries. Analysis of the crashdump revealed that
> > > d_invalidate() can have O(n^2) complexity with the number of dentries it is
> > > invalidating which leads to impractical times to invalidate large numbers
> > > of dentries. What happens is the following:
> > >
> > > There are several processes accessing the hugedir directory - about 16 in
> > > the case I was inspecting. When the directory changes on the server all
> > > these 16 processes quickly enter d_invalidate() -> shrink_dcache_parent()
> >
> > First thing d_invalidate() does is check if the dentry is unhashed and
> > return if so, unhash it otherwise.   So only d_invalidate() that won
> > the race for d_lock is going to invoke shink_dcache_parent() the
> > others will return immediately.
> >
> > What am I missing?
> 
> It's it's an old kernel (<4.18) it might be missing commit
> ff17fa561a04 ("d_invalidate(): unhash immediately")

Right and thanks for the pointer! I've indeed missed this subtle difference
between current upstream and the old (4.12-based) distro kernel which does
not have ff17fa561a04. Thanks again!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

