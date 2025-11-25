Return-Path: <linux-fsdevel+bounces-69766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E8C848E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A75AE4E9C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948263148CC;
	Tue, 25 Nov 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CBdCtGYy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KNWnxEp/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FxVJVgHB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FHG4+5eO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F26304976
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067626; cv=none; b=WFPdR57HWCXGNkbYbG+/gE8vTK9d0PHwZyiy2LUYvVHdjdT6Trb3XNqixhVDr7uLuZsAEwz4NdngNOlXCGZkCPvT8Jo7WCpy9L1uYc9b2k0dAE9JAmTEC9Fm667Wf13CqZfnHSH0JhQThlGICvN+1LkijVm8osQusgRDz4B9Cac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067626; c=relaxed/simple;
	bh=aZEgQ+Hc+/KpG0yLkdFsDGu2G3txTPd6dwvjus1xlL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcLoiv/LZBNmWqivK7L5VdIgquCsiLqBBtzEgOgwzle0pELTBWqWDHhekjH+t5KUoP79LGN7G0ipuSlF/SYZnKTW2UlgGRGpPHnOVQCDbXuQvJReKq5FhLKJooDRorMv6k2Wqdo9gQXDk+fY6sNEkTLaWpTfbhby3p41qg/bYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CBdCtGYy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KNWnxEp/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FxVJVgHB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FHG4+5eO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56B3F226E5;
	Tue, 25 Nov 2025 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHbeARP9IlGU7xmiwXNumdGZc6+N0unX3MD+1RRnabQ=;
	b=CBdCtGYyK1EjvwPQaXx387jy3Bu9UYAWqWQMrLUeTiR6l8NpTekjrr2BDkVnzGbOT43fOP
	XUDwZlq/gTR94O2rHkAtAfQ7i+hEhtQiHba5tpOYQLZ+7mbXWRyhqizHL5NvebWvqtRIRJ
	fxdwn28dbH/tVl9CO/0rrqnOv8/oSas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067623;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHbeARP9IlGU7xmiwXNumdGZc6+N0unX3MD+1RRnabQ=;
	b=KNWnxEp/pVdW67N+ThmG5Xy54oNG0gQck+0DW9C/ylBt1jNPNHadybwS+zggZhWG70skwn
	Hp+F6Ms+ayw+TQCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FxVJVgHB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FHG4+5eO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHbeARP9IlGU7xmiwXNumdGZc6+N0unX3MD+1RRnabQ=;
	b=FxVJVgHBDOYu/ok02uSe7CP9n4FIUjpLSRKDpkcRpKnLoIwV4lBgKu8E0im+yMHzSS4BJ4
	pxvQsffVT84yxjWvxYvkk1krupa92isXUX/jrOQu5UxrJjAjAdqNfIoc+WWdefHztE613p
	DaBHggEn+JBmmInmlCbuB0ir24je2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHbeARP9IlGU7xmiwXNumdGZc6+N0unX3MD+1RRnabQ=;
	b=FHG4+5eOqapfmYZZUZdCK/WNbl66FmbJZZPI638ZnaXFe7mRD6ZSfLOi8c7WOAQU/B053D
	fOFwEJzcoJqm3NBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57A033EA63;
	Tue, 25 Nov 2025 10:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uo44EiKJJWm4DQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 25 Nov 2025 10:46:58 +0000
Date: Tue, 25 Nov 2025 10:46:56 +0000
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
Subject: Re: [PATCH v3 3/4] tools/testing/vma: eliminate dependency on
 vma->__vm_flags
Message-ID: <xdks7jbuu573yb6c76t3vcbzsgwyynypl3ldfrzzzcgfsji3ga@sq6jtr4owprg>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
 <6275c53a6bb20743edcbe92d3e130183b47d18d0.1764064557.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6275c53a6bb20743edcbe92d3e130183b47d18d0.1764064557.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 56B3F226E5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,oracle.com:email]
X-Spam-Score: -2.51

On Tue, Nov 25, 2025 at 10:01:01AM +0000, Lorenzo Stoakes wrote:
> The userland VMA test code relied on an internal implementation detail -
> the existence of vma->__vm_flags to directly access VMA flags. There is no
> need to do so when we have the vm_flags_*() helper functions available.
> 
> This is ugly, but also a subsequent commit will eliminate this field
> altogether so this will shortly become broken.
> 
> This patch has us utilise the helper functions instead.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

