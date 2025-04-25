Return-Path: <linux-fsdevel+bounces-47349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D4A9C658
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04F29C2C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEC23D2B7;
	Fri, 25 Apr 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LZXHZdSW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0RkbJDl1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LZXHZdSW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0RkbJDl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3723BD02
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578430; cv=none; b=oBXL2qFbiC7sAH5ZoJbG6GBE4WkjQMEyYr7NpkS3w0s3D7mk47qOmb+9p8YazBFsKXj2Jk8dTTMH6gTQBaVR7KGQpZFJkeILuddnTRDPD9cFI+70x9MwKS8gIUlf03eBEDaAm1w1Z+ZFZ9xBaap8k9SuGl3OFP8CczXUi0ByQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578430; c=relaxed/simple;
	bh=6HbRMSSRnsUZ92hk42wBqxEetL1cFaIz9chcKvtpJ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ9FZbFqwiEi9RcMMvdyARAqkfkr7yxTuel1HNLbpE+TUMUu70fe5IaRzuMTksDANQUTlj4uYHFV1Q36EfEJD7+8f2s69t7Dl+dZ2OdH2ef89LhBp93SeB4iwvgvT34OrU8bIhTfsIFSJzQE2XZPDbbLgrmbhtoLjE+iceylqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LZXHZdSW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0RkbJDl1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LZXHZdSW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0RkbJDl1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 39245211CC;
	Fri, 25 Apr 2025 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745578426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDUol4MQ50pAphpzZ6W2npMBigYKRKuXYHWjYCtm5sw=;
	b=LZXHZdSWJ4FaCTcIqZyvAvnv2ztHdQDpGQEOaJ69UsEavsmIfwbJjvDQl5NMHb+VvJd0nU
	BjtHHwZOVKvS+xlBLd0okYFwCTSR3HtLTCOtHWo2/XGalYpOcaBvumGjl1pCMNaEx8gS/B
	mawo5798n2O2sgHU+q2KpfTMmX5X4Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745578426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDUol4MQ50pAphpzZ6W2npMBigYKRKuXYHWjYCtm5sw=;
	b=0RkbJDl157bjkWVXiPmD3gN6jmpx5uTHmkBb1bZ1oyX6zLdn8Knz5V+rV9G7j1Mg9/jaWG
	D9sRdNzIJ9apweCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LZXHZdSW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0RkbJDl1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745578426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDUol4MQ50pAphpzZ6W2npMBigYKRKuXYHWjYCtm5sw=;
	b=LZXHZdSWJ4FaCTcIqZyvAvnv2ztHdQDpGQEOaJ69UsEavsmIfwbJjvDQl5NMHb+VvJd0nU
	BjtHHwZOVKvS+xlBLd0okYFwCTSR3HtLTCOtHWo2/XGalYpOcaBvumGjl1pCMNaEx8gS/B
	mawo5798n2O2sgHU+q2KpfTMmX5X4Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745578426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hDUol4MQ50pAphpzZ6W2npMBigYKRKuXYHWjYCtm5sw=;
	b=0RkbJDl157bjkWVXiPmD3gN6jmpx5uTHmkBb1bZ1oyX6zLdn8Knz5V+rV9G7j1Mg9/jaWG
	D9sRdNzIJ9apweCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CC211388F;
	Fri, 25 Apr 2025 10:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+BYCLlpC2jPKAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Apr 2025 10:53:45 +0000
Date: Fri, 25 Apr 2025 11:53:43 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <a722nw6yfaddc4oujcv22ucjpidryqe5hxb24kqs7watpkeoc3@so57zxtdmycq>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <51903B43-2BFC-4BA6-9D74-63F79CF890B7@kernel.org>
 <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7212f5f4-f12b-4b94-834f-b392601360a3@lucifer.local>
X-Rspamd-Queue-Id: 39245211CC
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 25, 2025 at 11:40:00AM +0100, Lorenzo Stoakes wrote:
> On Thu, Apr 24, 2025 at 08:15:26PM -0700, Kees Cook wrote:
> >
> >
> > On April 24, 2025 2:15:27 PM PDT, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >+static void vm_area_init_from(const struct vm_area_struct *src,
> > >+			      struct vm_area_struct *dest)
> > >+{
> > >+	dest->vm_mm = src->vm_mm;
> > >+	dest->vm_ops = src->vm_ops;
> > >+	dest->vm_start = src->vm_start;
> > >+	dest->vm_end = src->vm_end;
> > >+	dest->anon_vma = src->anon_vma;
> > >+	dest->vm_pgoff = src->vm_pgoff;
> > >+	dest->vm_file = src->vm_file;
> > >+	dest->vm_private_data = src->vm_private_data;
> > >+	vm_flags_init(dest, src->vm_flags);
> > >+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> > >+	       sizeof(dest->vm_page_prot));
> > >+	/*
> > >+	 * src->shared.rb may be modified concurrently when called from
> > >+	 * dup_mmap(), but the clone will reinitialize it.
> > >+	 */
> > >+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
> > >+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> > >+	       sizeof(dest->vm_userfaultfd_ctx));
> > >+#ifdef CONFIG_ANON_VMA_NAME
> > >+	dest->anon_name = src->anon_name;
> > >+#endif
> > >+#ifdef CONFIG_SWAP
> > >+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> > >+	       sizeof(dest->swap_readahead_info));
> > >+#endif
> > >+#ifdef CONFIG_NUMA
> > >+	dest->vm_policy = src->vm_policy;
> > >+#endif
> > >+}
> >
> > I know you're doing a big cut/paste here, but why in the world is this function written this way? Why not just:
> >
> > *dest = *src;
> >
> > And then do any one-off cleanups?
> 
> Yup I find it odd, and error prone to be honest. We'll end up with uninitialised
> state for some fields if we miss them here, seems unwise...
> 
> Presumably for performance?
> 
> This is, as you say, me simply propagating what exists, but I do wonder.

There's a particular advantage here: KMSAN will light up in all sorts of ways
if you forget to copy something explicitly, instead of silently working but also
possibly being silently broken.

Anyway, it came from here: https://lore.kernel.org/all/CAJuCfpFO3Hj+7f10e0Pnvf0U7-dHeYgvjK+4AFD8V=kmG4JA=w@mail.gmail.com/

-- 
Pedro

