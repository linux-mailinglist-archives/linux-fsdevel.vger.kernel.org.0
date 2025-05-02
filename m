Return-Path: <linux-fsdevel+bounces-47910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05388AA7191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638AC16A0B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734FE250C08;
	Fri,  2 May 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V6DegJyw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+e5aQFV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zIljpT8R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TfQgwou6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891122578C
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188444; cv=none; b=AoeDLNY4bY2qV/rw7SShf8OlY/BeSw+Qe4tUmqkh42gRbjgDnF+x1EkdkBTWT7GbLxi+1F+0t/FLjwrDfB1hq5ZgDBkw0t8a3bJelVKS3QEErqRIE5px4LVBvnEuvBGapnWfDbLPHFD7czeTOqq25rUW8mBmQyXyCVc5fhRaI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188444; c=relaxed/simple;
	bh=q9Wt2nv3tB4D1QRkd4VGcrAcWby6DCCuswobmhTV6vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9d4Nq7KreoaosQRE/77PX49dgLy9hJdocizXzdNqyIUW9ggm0VkwugK5HbecrvJMzagp+NHCmf46cmoYQOAFJGTObyR8jPUXNhpY/M0zELwIqmRmMT0r40SSIRqgRhSJfrpiXr62xs54hYK8myXvH6PD0aCuivr7A7aMzzsIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V6DegJyw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+e5aQFV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zIljpT8R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TfQgwou6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14451F387;
	Fri,  2 May 2025 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746188440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XGzJGzTYHGCyVRD8KTVZyUw74RJvDiVdSvzltzOus=;
	b=V6DegJywf70AoxraMTuMW3jX9SKGfYwdLkLahmtXuDy5LAxewP6td7SnDTTO+NzYfktOsm
	PnN3lOm084p+AOAKJdweLY4xX5KFWpqGMyspqZW0t/WEwJnouVx9eWrpAcHZTdN9CYO+k7
	Q7qO4v9gXdHur7d7rPmxltYcck5Y6uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746188440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XGzJGzTYHGCyVRD8KTVZyUw74RJvDiVdSvzltzOus=;
	b=H+e5aQFVjUIdjrBDL6m5nNJPljJgie3g0+7oaAQxYM88121amB/4uERDL6LtjksEXKCWEk
	Fzwdmp4cEKLT92CA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zIljpT8R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TfQgwou6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746188438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XGzJGzTYHGCyVRD8KTVZyUw74RJvDiVdSvzltzOus=;
	b=zIljpT8RYZGWd/HBqgGRL0/G/EPLljblmAn6xhBisAStcablM7g7QF0gUsaHrQXmW0jKTl
	dwjOsB7J49AfnSGAcZGtH3/MakJXuhOpKUZuo7xVVEnTlXycCvM2AcykGc1HUaDAs/6A/P
	zz76gazA5mrQeaa7EMBz8jLGP4fox9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746188438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3XGzJGzTYHGCyVRD8KTVZyUw74RJvDiVdSvzltzOus=;
	b=TfQgwou6GFyRLC590TZR8fNmQk57E8vvDttvruRgNUVOqSnjaPNyXinuLP4siuNGqte9Jx
	ZbU7EJsr0SUHThAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBE861372E;
	Fri,  2 May 2025 12:20:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lB6qNZa4FGiICAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 May 2025 12:20:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 520F6A0921; Fri,  2 May 2025 14:20:38 +0200 (CEST)
Date: Fri, 2 May 2025 14:20:38 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/3] eliminate mmap() retry merge, add
 .mmap_prepare hook
Message-ID: <uevybgodhkny6dihezto4gkfup6n7znaei6q4ehlkksptlptwr@vgm2tzhpidli>
References: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746116777.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: F14451F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 01-05-25 18:25:26, Lorenzo Stoakes wrote:
> During the mmap() of a file-backed mapping, we invoke the underlying driver
> file's mmap() callback in order to perform driver/file system
> initialisation of the underlying VMA.
> 
> This has been a source of issues in the past, including a significant
> security concern relating to unwinding of error state discovered by Jann
> Horn, as fixed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour") which performed the recent, significant, rework of
> mmap() as a whole.
> 
> However, we have had a fly in the ointment remain - drivers have a great
> deal of freedom in the .mmap() hook to manipulate VMA state (as well as
> page table state).
> 
> This can be problematic, as we can no longer reason sensibly about VMA
> state once the call is complete (the ability to do - anything - here does
> rather interfere with that).
> 
> In addition, callers may choose to do odd or unusual things which might
> interfere with subsequent steps in the mmap() process, and it may do so and
> then raise an error, requiring very careful unwinding of state about which
> we can make no assumptions.
> 
> Rather than providing such an open-ended interface, this series provides an
> alternative, far more restrictive one - we expose a whitelist of fields
> which can be adjusted by the driver, along with immutable state upon which
> the driver can make such decisions:
> 
> struct vm_area_desc {
> 	/* Immutable state. */
> 	struct mm_struct *mm;
> 	unsigned long start;
> 	unsigned long end;
> 
> 	/* Mutable fields. Populated with initial state. */
> 	pgoff_t pgoff;
> 	struct file *file;
> 	vm_flags_t vm_flags;
> 	pgprot_t page_prot;
> 
> 	/* Write-only fields. */
> 	const struct vm_operations_struct *vm_ops;
> 	void *private_data;
> };
> 
> The mmap logic then updates the state used to either merge with a VMA or
> establish a new VMA based upon this logic.
> 
> This is achieved via new file hook .mmap_prepare(), which is, importantly,
> invoked very early on in the mmap() process.
> 
> If an error arises, we can very simply abort the operation with very little
> unwinding of state required.

Looks sensible. So is there a plan to transform existing .mmap hooks to
.mmap_prepare hooks? I agree that for most filesystems this should be just
easy 1:1 replacement and AFAIU this would be prefered?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

