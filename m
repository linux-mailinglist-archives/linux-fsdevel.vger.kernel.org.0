Return-Path: <linux-fsdevel+bounces-69777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A891BC84C1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AAAD350A13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3F275AE8;
	Tue, 25 Nov 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LfO26gNv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F/i8315q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KZLlVqOD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7k2SPKNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F026FD97
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070533; cv=none; b=LFv8mIlErO+K5bE3MOfUpBCqM3pItCygPrTtyjoGZyN5avlQE4vnwnif7R+GGG+7evZOiCYY5aWL0tohgqcMb4i9SHOGue+1B6yenn8fLFJqA5Oj0suyIt4RJw7mLv2Mg3Eocn1oLKnQZ1Hh+x/XSxG+PGnEYyeONU1bnEiBDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070533; c=relaxed/simple;
	bh=oBeYUnejM45J9ek2I/sFszKCay4UVQEEKIuh9k3c15E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3L9bebtGrhOiSorE+5maJV2dmdCRIFTXySlBCVYW3hv5iZscXP7v2WMMEW48xk+K+STYOW0Ql+mJ6tMWb987P59huNOhUL3Q9mJjV9APQTED8DDmxP921033gnyXDhlEou3xNlaWGpkX0wONJWph0vKA5bYn0jyj/kPcGO0pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LfO26gNv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F/i8315q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KZLlVqOD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7k2SPKNs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E17002280A;
	Tue, 25 Nov 2025 11:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764070529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p6QrTPqrcjFGMk+Yo9ek0ZjatJ2Isxpx46M53PclhY=;
	b=LfO26gNvL6i3mOBxxltDOa7Mm8VYGeVURJ/3KZq8KDwKBrG2ZfN+rQH/RaI2Xq6LVHf7AB
	W+lultHVLM9DVlNhWfH57ujd9eGjL9RA1vK8QnAqLaWNi1eN1pCXLobZHm7wc9uRiRBzYf
	gHviVPB3Xl4NSeomC/8dAFiG13X59wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764070529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p6QrTPqrcjFGMk+Yo9ek0ZjatJ2Isxpx46M53PclhY=;
	b=F/i8315q3n2XsXBKkr5MMX6YasmzsZ3i5KG+4+YC9UpV4zAoZar/3IFE8WIvIb791nmF6k
	JYqZc95yasQHUGDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KZLlVqOD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7k2SPKNs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764070528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p6QrTPqrcjFGMk+Yo9ek0ZjatJ2Isxpx46M53PclhY=;
	b=KZLlVqODwAsFVuNlLAzLgXP+M5fclnuwVfNHpzlK2jerDk0ZIINfp/sEZRsrFAYJ+if39h
	Uu3QS1WmbFQ8EYNLs+Vk9ZdEvujDOib/WdPuIoZNAf+zCjAmigdofRkFltvGqW25Rp/8mS
	lIm39GnDc7lDOQm7F/DtoqxKcdTRqbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764070528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p6QrTPqrcjFGMk+Yo9ek0ZjatJ2Isxpx46M53PclhY=;
	b=7k2SPKNseROSvP+kBu7RQTgUWctv/U+y1dfvjtbO+X9wX4AcP8UFci2JYR7NWpAo0zviP0
	y3vgbbznHHpwxgDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D70063EA63;
	Tue, 25 Nov 2025 11:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yWcWMXyUJWldOwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 25 Nov 2025 11:35:24 +0000
Date: Tue, 25 Nov 2025 11:35:23 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mm: introduce VMA flags bitmap type
Message-ID: <brej2b4dxfyuxojzgu2ge7ybk65t234bjstfzfo63izf2woagm@dd5vwcr3d3dg>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
 <bab179d7b153ac12f221b7d65caac2759282cfe9.1764064557.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab179d7b153ac12f221b7d65caac2759282cfe9.1764064557.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E17002280A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,suse.de,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,infradead.org,linaro.org,arm.com,goodmis.org,ziepe.ca,nvidia.com,linux.alibaba.com,zte.com.cn,intel.com,gmail.com,sk.com,gourry.net,surriel.com,huaweicloud.com,tencent.com,cmpxchg.org,bytedance.com,vger.kernel.org,kvack.org,garyguo.net,protonmail.com,umich.edu];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -2.51

On Tue, Nov 25, 2025 at 10:01:02AM +0000, Lorenzo Stoakes wrote:
> It is useful to transition to using a bitmap for VMA flags so we can avoid
> running out of flags, especially for 32-bit kernels which are constrained
> to 32 flags, necessitating some features to be limited to 64-bit kernels
> only.
> 
> By doing so, we remove any constraint on the number of VMA flags moving
> forwards no matter the platform and can decide in future to extend beyond
> 64 if required.
> 
> We start by declaring an opaque types, vma_flags_t (which resembles
> mm_struct flags of type mm_flags_t), setting it to precisely the same size
> as vm_flags_t, and place it in union with vm_flags in the VMA declaration.
> 
> We additionally update struct vm_area_desc equivalently placing the new
> opaque type in union with vm_flags.
> 
> This change therefore does not impact the size of struct vm_area_struct or
> struct vm_area_desc.
> 
> In order for the change to be iterative and to avoid impacting performance,
> we designate VM_xxx declared bitmap flag values as those which must exist
> in the first system word of the VMA flags bitmap.
> 
> We therefore declare vma_flags_clear_all(), vma_flags_overwrite_word(),
> vma_flags_overwrite_word(), vma_flags_overwrite_word_once(),
> vma_flags_set_word() and vma_flags_clear_word() in order to allow us to
> update the existing vm_flags_*() functions to utilise these helpers.
> 
> This is a stepping stone towards converting users to the VMA flags bitmap
> and behaves precisely as before.
> 
> By doing this, we can eliminate the existing private vma->__vm_flags field
> in the vma->vm_flags union and replace it with the newly introduced opaque
> type vma_flags, which we call flags so we refer to the new bitmap field as
> vma->flags.
> 
> We update vma_flag_[test, set]_atomic() to account for the change also.
> 
> We adapt vm_flags_reset_once() to only clear those bits above the first
> system word providing write-once semantics to the first system word (which
> it is presumed the caller requires - and in all current use cases this is
> so).
> 
> As we currently only specify that the VMA flags bitmap size is equal to
> BITS_PER_LONG number of bits, this is a noop, but is defensive in
> preparation for a future change that increases this.
> 
> We additionally update the VMA userland test declarations to implement the
> same changes there.
> 
> Finally, we update the rust code to reference vma->vm_flags on update
> rather than vma->__vm_flags which has been removed. This is safe for now,
> albeit it is implicitly performing a const cast.
> 
> Once we introduce flag helpers we can improve this more.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

FWIW, I'm not a huge fan of this vma_flags vs vm_flags and hope we can
get rid of this ASAP. But it's a necessary evil for now, anyway.

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

