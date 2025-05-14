Return-Path: <linux-fsdevel+bounces-48955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E3AB6855
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDF3B1E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C012E26E16C;
	Wed, 14 May 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OMhGCGQJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fby0+Cd/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OMhGCGQJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fby0+Cd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72521129A78
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216916; cv=none; b=SCixTwFz4KPwSKeW9lsjIT2JWTF6yPrKXQvgD2kj0df5YnOzbnSa5emUfES6OAABxdCPBX+Sbkk+9ljJZIkIfwjF7otC0UJ66H+GVZMVwe4yS+TvD7XQAUYLJDap7KV4oFbey1SN8fMIYi84FE8KzNaPgmEzw/8jjHBO9WcIeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216916; c=relaxed/simple;
	bh=VVS2WTybSPbS/SG0YWlD7O5FkHMWLh8k8y1Nr+psFC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESsJVnIhWK1gZb1trJMUMBE/q4q6/gjB8dke+YL+wAJ71W/5sPe17X64Csg0XAKM+ra7SCr6JFf1kOoMQKRWQ/UfzOXlDXwNepjWqOzpCm0SB14eUZ39VKFzAA9kGqIUBlTEBPwTiPlKQzWGGsbdXF84MyXCzni4DMu8xyTRxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OMhGCGQJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fby0+Cd/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OMhGCGQJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fby0+Cd/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CC43211D0;
	Wed, 14 May 2025 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747216912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qFvpH2MgN8teidabV80M0BZ5ot+a2R9QqLMuMJOrW4=;
	b=OMhGCGQJey9EaGuP4MAxOm1U6wITxW42sRXkpw+vhjFteV1yKucf35eQc0IqkNmlQP6N1T
	J//7jilJzTlY8/ZEOvhuC07prHFMXw2olb+a/cAKS+swhzm7rU/InP1O9gWRJ/RhDXdMsd
	t/OhITkHjXg1a0rh1kVv+h61jYyHnrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747216912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qFvpH2MgN8teidabV80M0BZ5ot+a2R9QqLMuMJOrW4=;
	b=Fby0+Cd/bt2q98+8gHe/IaIYZPAXdZV/i2QMGngR2mg9vvawgdAlMEDGvHUnCwl5Gw6SnR
	S1UoZ5ZWAaSeX6BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747216912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qFvpH2MgN8teidabV80M0BZ5ot+a2R9QqLMuMJOrW4=;
	b=OMhGCGQJey9EaGuP4MAxOm1U6wITxW42sRXkpw+vhjFteV1yKucf35eQc0IqkNmlQP6N1T
	J//7jilJzTlY8/ZEOvhuC07prHFMXw2olb+a/cAKS+swhzm7rU/InP1O9gWRJ/RhDXdMsd
	t/OhITkHjXg1a0rh1kVv+h61jYyHnrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747216912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0qFvpH2MgN8teidabV80M0BZ5ot+a2R9QqLMuMJOrW4=;
	b=Fby0+Cd/bt2q98+8gHe/IaIYZPAXdZV/i2QMGngR2mg9vvawgdAlMEDGvHUnCwl5Gw6SnR
	S1UoZ5ZWAaSeX6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F8B613306;
	Wed, 14 May 2025 10:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B/sAHA9qJGjtNgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 14 May 2025 10:01:51 +0000
Date: Wed, 14 May 2025 11:01:49 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Message-ID: <e3olqweuiyxlkewat26n4vyltpn5ordg6ckfndejwjleoemrtw@e2mo6nocaepy>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
 <dqir4mv7twugxj6nstqziympxc6z3k5act4cwhgpg2naeqy3sx@wkn4wvnwbpih>
 <e18fea49-388d-40d2-9b55-b9f91ac3ce11@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e18fea49-388d-40d2-9b55-b9f91ac3ce11@lucifer.local>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, May 14, 2025 at 10:12:49AM +0100, Lorenzo Stoakes wrote:
> On Wed, May 14, 2025 at 10:04:06AM +0100, Pedro Falcato wrote:
> > On Fri, May 09, 2025 at 01:13:34PM +0100, Lorenzo Stoakes wrote:
> > > Provide a means by which drivers can specify which fields of those
> > > permitted to be changed should be altered to prior to mmap()'ing a
> > > range (which may either result from a merge or from mapping an entirely new
> > > VMA).
> > >
> > > Doing so is substantially safer than the existing .mmap() calback which
> > > provides unrestricted access to the part-constructed VMA and permits
> > > drivers and file systems to do 'creative' things which makes it hard to
> > > reason about the state of the VMA after the function returns.
> > >
> > > The existing .mmap() callback's freedom has caused a great deal of issues,
> > > especially in error handling, as unwinding the mmap() state has proven to
> > > be non-trivial and caused significant issues in the past, for instance
> > > those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> > > error path behaviour").
> > >
> > > It also necessitates a second attempt at merge once the .mmap() callback
> > > has completed, which has caused issues in the past, is awkward, adds
> > > overhead and is difficult to reason about.
> > >
> > > The .mmap_prepare() callback eliminates this requirement, as we can update
> > > fields prior to even attempting the first merge. It is safer, as we heavily
> > > restrict what can actually be modified, and being invoked very early in the
> > > mmap() process, error handling can be performed safely with very little
> > > unwinding of state required.
> > >
> > > The .mmap_prepare() and deprecated .mmap() callbacks are mutually
> > > exclusive, so we permit only one to be invoked at a time.
> > >
> > > Update vma userland test stubs to account for changes.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > Neat idea, thanks. This should also help out with the insane proliferation of
> > vm_flags_set in ->mmap() callbacks all over. Hopefully.
[snip] 
> >
> > 2) Possibly add a ->mmap_finish()? With a fully constructed vma at that point.
> >    So things like remap_pfn_range can still be used by drivers' mmap()
> >    implementation.
> 
> Thanks for raising the remap_pfn_range() case! Yes this is definitely a
> thing.
> 
> However this proposed callback would totally undermine the purpose of the
> change - the idea is to never give a vma because if we do so we lose all of
> the advantages here and may as well just leave the mmap in place for
> this...
>

Yes, good point.

> However I do think we'll need a new callback at some point (previously
> discussed in thread).
> 
> We could perhaps provide the option to _explicitly_ remap for instance. I
> would want it to be heavily locked down as to what can happen and to happen
> as early as possible.
>

I think we can simply combine various ideas here. Like:

struct vm_area_desc_private {
	struct vm_area_desc desc;
	struct vm_area_struct *vma;
};

Then, for this "mmap_finish" callback and associated infra:

	int (*mmap_finish)(struct vm_area_desc *desc);

int mmap_remap_pfn_range(struct vm_area_desc *desc, /*...*/)
{
	struct vm_area_desc_private *private = container_of(desc, struct vm_area_desc_private, desc);
	return remap_pfn_range(private->vma, /*...*/);
}

int random_driver_mmap_finish(struct vm_area_desc *desc)
{
	return mmap_remap_pfn_range(desc, desc->start, some_pfn, some_size,
				    desc->page_prot);
}


I think something of the sort would be quite less prone to abuse, and we could
take the time to then even polish up the interface (e.g maybe it would be nicer
if mmap_remap_pfn_range took a vma offset, and not a start address).

Anyway, just brainstorming. This idea came to mind, I think it's quite interesting.

> This is something we can iterate on, as trying to find the ideal scheme
> immediately will just lead to inaction, the big advantage with the approach
> here is we can be iterative.
> 
> We provide this, use it in a scenario which allows us to eliminate merge
> retry, and can take it from there :)

Yep, totally.

> 
> So indeed, watch this space basically... I will be highly proactive on this
> stuff moving forward.
> 
> >
> > 1) is particularly important so our VFS and driver friends know this is supposed
> > to be The Way Forward.
> 
> I think probably the answer is for me to fully update the document to be
> bang up to date, right? But that would obviously work best as a follow up
> patch :)
>

You love your big projects :p I had the impression the docs were more or less up to date?
The VFS people do update it somewhat diligently. And for mm we only have ->mmap, ->get_unmapped_area,
and now ->mmap_prepare. And the descriptions are ATM quite useless, just
"called by the mmap(2) system call".

-- 
Pedro

