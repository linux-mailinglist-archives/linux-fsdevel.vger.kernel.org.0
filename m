Return-Path: <linux-fsdevel+bounces-59987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18855B40523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA56F1A80489
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD48320CD6;
	Tue,  2 Sep 2025 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C366B2kF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c8YOn2Wt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C366B2kF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c8YOn2Wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D10320A08
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820479; cv=none; b=sK+pv19y26v6mYBytYwa8+J4AZeyqudp4Dmrp898I8z1efG7b+fzDbu630mTEaBQEgoLYDe8mQf2r42NZu7OLzbBHlkL0dNZPi/VdnNli0gYpRyPPMbgCAQ/2zjBF+HvARGwrZCbFnjB4ng0bUYmlmT0dcOX4yX1X5zUFrETCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820479; c=relaxed/simple;
	bh=IMr2mOcuHo3/vTdVH2kl3wY1rO0r/4mGDmp0yXuUPPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtKCU4bWgHU1YhAHrSOycYUo7gUpL5UqC2gEn58JVd6BLzypzMl4spXsRgn/ZP82qp85kwITOLH6FLunXqkW8khthAoD5lEMCdSyVB+z9Oc0wsMH4ou0SJIeyouMpX4CizDV6ULHS0WueMccXIUccRNSh58wA9MlVHlo7FbnQ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C366B2kF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c8YOn2Wt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C366B2kF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c8YOn2Wt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1A731F38E;
	Tue,  2 Sep 2025 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756820475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhOTfgygnk23brwzYKfsgKlsXFSLIcGbgvQqte8GedY=;
	b=C366B2kFcPZ+d4ABXG9d7/JZfdkttWp3hQADsbYoVlwRsy5OhaB4SRfW3XPprc/AdqnkhR
	sX/jtmLiP/tba/OOcMja3xuRKYBL265ho6XHzTVl03NyvFMMvRdjp6UutU5m9pLVNItrH1
	F5eUBx/zaNKSkEG3pPbQFXDfZDP5WSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756820475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhOTfgygnk23brwzYKfsgKlsXFSLIcGbgvQqte8GedY=;
	b=c8YOn2WtFkxrYyvtLWKR91DZtpdVFvqyiVu0FoeIz83yqeYbRidpJLNnXqmb8DgyEfPYnB
	0HBC2Fqj0j5oYYCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=C366B2kF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c8YOn2Wt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756820475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhOTfgygnk23brwzYKfsgKlsXFSLIcGbgvQqte8GedY=;
	b=C366B2kFcPZ+d4ABXG9d7/JZfdkttWp3hQADsbYoVlwRsy5OhaB4SRfW3XPprc/AdqnkhR
	sX/jtmLiP/tba/OOcMja3xuRKYBL265ho6XHzTVl03NyvFMMvRdjp6UutU5m9pLVNItrH1
	F5eUBx/zaNKSkEG3pPbQFXDfZDP5WSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756820475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhOTfgygnk23brwzYKfsgKlsXFSLIcGbgvQqte8GedY=;
	b=c8YOn2WtFkxrYyvtLWKR91DZtpdVFvqyiVu0FoeIz83yqeYbRidpJLNnXqmb8DgyEfPYnB
	0HBC2Fqj0j5oYYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D06F113882;
	Tue,  2 Sep 2025 13:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rT11L/rztmifYAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Sep 2025 13:41:14 +0000
Date: Tue, 2 Sep 2025 14:41:08 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: do not assume file == vma->vm_file in
 compat_vma_mmap_prepare()
Message-ID: <ngqpybolf2e2gp266k7vkehzg2xrbng2proq3jv3quurk32wzm@j7d3je7im4fj>
References: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C1A731F38E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On Tue, Sep 02, 2025 at 11:45:33AM +0100, Lorenzo Stoakes wrote:
> In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
> nested file systems") we introduced the ability for 'nested' drivers and
> file systems to correctly invoke the f_op->mmap_prepare() handler from an
> f_op->mmap() handler via a compatibility layer implemented in
> compat_vma_mmap_prepare().
> 
> This invokes vma_to_desc() to populate vm_area_desc fields according to
> those found in the (not yet fully initialised) VMA passed to f_op->mmap().
> 
> However this function implicitly assumes that the struct file which we are
> operating upon is equal to vma->vm_file. This is not a safe assumption in
> all cases.
> 
> This is not an issue currently, as so far we have only implemented
> f_op->mmap_prepare() handlers for some file systems and internal mm uses,
> and the only nested f_op->mmap() operations that can be performed upon
> these are those in backing_file_mmap() and coda_file_mmap(), both of which
> use vma->vm_file.
> 
> However, moving forward, as we convert drivers to using
> f_op->mmap_prepare(), this will become a problem.
> 
> Resolve this issue by explicitly setting desc->file to the provided file
> parameter and update callers accordingly.
> 
> We also need to adjust set_vma_from_desc() to account for this fact, and
> only update the vma->vm_file field if the f_op->mmap_prepare() caller
> reassigns it.
> 
> We may in future wish to add a new field to struct vm_area_desc to account
> for this 'nested mmap invocation' case, but for now it seems unnecessary.
> 
> While we are here, also provide a variant of compat_vma_mmap_prepare() that
> operates against a pointer to any file_operations struct and does not
> assume that the file_operations struct we are interested in is file->f_op.
> 
> This function is __compat_vma_mmap_prepare() and we invoke it from
> compat_vma_mmap_prepare() so that we share code between the two functions.
> 
> This is important, because some drivers provide hooks in a separate struct,
> for instance struct drm_device provides an fops field for this purpose.
> 
> Also update the VMA selftests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

LGTM, thanks!

-- 
Pedro

