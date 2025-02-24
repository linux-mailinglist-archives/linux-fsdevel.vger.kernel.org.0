Return-Path: <linux-fsdevel+bounces-42411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8EFA422C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3DA1890D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780913F43A;
	Mon, 24 Feb 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCLhTC4S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/JR80vL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCLhTC4S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/JR80vL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21537CF16
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406448; cv=none; b=lq9fxMGOlS2LzI8LS04DHeHhxx/leQ49eX+EHSQZWcj99rn92EZ+7AdF/G5EvmLlMSj4TO+j/lJBvnsPFTKzRHbQ8n1OL7oa7RX3vLsJv8j7CC4+cIDnCSqGkJt2Jgbgsan9pAATLsiLVwwxyYqLtPK7rvgRjYnvvFQ/2utBfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406448; c=relaxed/simple;
	bh=SH8jfmeGWRC6Ig+kjVKk14pIhoDeI6WPOw+lOOveQ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/sX6KZoWnYw8DPhd6FaaFEVBBN8rdegp9IgpPl3je/QirBUOVKTzXfr3xYjPyWAxxI5xjbwi1pLXXPylAItFy+vQF32shlcamX5Q+g2help3pqqRnHGcnPuOOYRNvoAPlFDE0BlOCU9AD56iA8Vr8XZ9lDo7d1MJDRuVQkHHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCLhTC4S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/JR80vL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCLhTC4S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/JR80vL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D73741F397;
	Mon, 24 Feb 2025 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740406444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7IjZogmPFxlkawqZh8kYdAkwk3qdalG/s4P2ZJJZ64=;
	b=aCLhTC4SNEO+Twu9b8dgs0sO0h31DBp3jgFMZ3PXPExx15Op7tOtotFBnqEAutI/PQytAn
	tDnVTaRCuuegaFlMdWmPjAdcrJGJrUtRX5DNKILLbkQw847QQcfrAkqRUaNMrq5H8syNiH
	dHRXJ7PC4eIWX8ZrCNuqkUm76JcC4to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740406444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7IjZogmPFxlkawqZh8kYdAkwk3qdalG/s4P2ZJJZ64=;
	b=X/JR80vLaIteAzc7JWqXt4oWIKEGvhchyII1sWwj3hVdd+Gukzve377JqhrviutUDDRwMJ
	YEmQVA61aV96pyBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740406444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7IjZogmPFxlkawqZh8kYdAkwk3qdalG/s4P2ZJJZ64=;
	b=aCLhTC4SNEO+Twu9b8dgs0sO0h31DBp3jgFMZ3PXPExx15Op7tOtotFBnqEAutI/PQytAn
	tDnVTaRCuuegaFlMdWmPjAdcrJGJrUtRX5DNKILLbkQw847QQcfrAkqRUaNMrq5H8syNiH
	dHRXJ7PC4eIWX8ZrCNuqkUm76JcC4to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740406444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7IjZogmPFxlkawqZh8kYdAkwk3qdalG/s4P2ZJJZ64=;
	b=X/JR80vLaIteAzc7JWqXt4oWIKEGvhchyII1sWwj3hVdd+Gukzve377JqhrviutUDDRwMJ
	YEmQVA61aV96pyBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE09A13707;
	Mon, 24 Feb 2025 14:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePVIMqx+vGc6QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 14:14:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D137A0785; Mon, 24 Feb 2025 15:14:04 +0100 (CET)
Date: Mon, 24 Feb 2025 15:14:04 +0100
From: Jan Kara <jack@suse.cz>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hello!

On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> Problem Statement
> ===============
> 
> Readahead can result in unnecessary page cache pollution for mapped
> regions that are never accessed. Current mechanisms to disable
> readahead lack granularity and rather operate at the file or VMA
> level. This proposal seeks to initiate discussion at LSFMM to explore
> potential solutions for optimizing page cache/readahead behavior.
> 
> 
> Background
> =========
> 
> The read-ahead heuristics on file-backed memory mappings can
> inadvertently populate the page cache with pages corresponding to
> regions that user-space processes are known never to access e.g ELF
> LOAD segment padding regions. While these pages are ultimately
> reclaimable, their presence precipitates unnecessary I/O operations,
> particularly when a substantial quantity of such regions exists.
> 
> Although the underlying file can be made sparse in these regions to
> mitigate I/O, readahead will still allocate discrete zero pages when
> populating the page cache within these ranges. These pages, while
> subject to reclaim, introduce additional churn to the LRU. This
> reclaim overhead is further exacerbated in filesystems that support
> "fault-around" semantics, that can populate the surrounding pages’
> PTEs if found present in the page cache.
> 
> While the memory impact may be negligible for large files containing a
> limited number of sparse regions, it becomes appreciable for many
> small mappings characterized by numerous holes. This scenario can
> arise from efforts to minimize vm_area_struct slab memory footprint.

OK, I agree the behavior you describe exists. But do you have some
real-world numbers showing its extent? I'm not looking for some artificial
numbers - sure bad cases can be constructed - but how big practical problem
is this? If you can show that average Android phone has 10% of these
useless pages in memory than that's one thing and we should be looking for
some general solution. If it is more like 0.1%, then why bother?

> Limitations of Existing Mechanisms
> ===========================
> 
> fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> entire file, rather than specific sub-regions. The offset and length
> parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> POSIX_FADV_DONTNEED [2] cases.
> 
> madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> VMA, rather than specific sub-regions. [3]
> Guard Regions: While guard regions for file-backed VMAs circumvent
> fault-around concerns, the fundamental issue of unnecessary page cache
> population persists. [4]

Somewhere else in the thread you complain about readahead extending past
the VMA. That's relatively easy to avoid at least for readahead triggered
from filemap_fault() (i.e., do_async_mmap_readahead() and
do_sync_mmap_readahead()). I agree we could do that and that seems as a
relatively uncontroversial change. Note that if someone accesses the file
through standard read(2) or write(2) syscall or through different memory
mapping, the limits won't apply but such combinations of access are not
that common anyway.

Regarding controlling readahead for various portions of the file - I'm
skeptical. In my opinion it would require too much bookeeping on the kernel
side for such a niche usecache (but maybe your numbers will show it isn't
such a niche as I think :)). I can imagine you could just completely
turn off kernel readahead for the file and do your special readahead from
userspace - I think you could use either userfaultfd for triggering it or
new fanotify FAN_PREACCESS events.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

