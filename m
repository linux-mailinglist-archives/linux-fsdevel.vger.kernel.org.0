Return-Path: <linux-fsdevel+bounces-69765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81AC8489A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9853AE869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50B3115B8;
	Tue, 25 Nov 2025 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sQpNbmEC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B6Ie/feE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pni0UpLe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rSwNxQHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127931062C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067493; cv=none; b=i5cvtjk+djdbZK1RBiSmm4idrKiiFsPWWbpVvRpKjHlzOcaYeCkziVYIAQN6mW1StKQyX8skRssDFJtWlHWpVEVikpAZ3OucUdBMuhM6geyYhiuj8Rmnxsnl+nqsK/jsfw1HCUJDFVkm0w/MU8HL+2kJpX9XS+a0QH8Xw4LzrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067493; c=relaxed/simple;
	bh=1Wg6A1mBhSAsxQ9/6TugeSCfRipMhDQOlhMS0vggRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVsOTYnYwBb+3OLZ26kw5eywJ06uzLWHQHy6ExavjKVtWHUkO/HF+QLY8Bq4PdHPfoeVU5+toMTXHW7CoGAleJ2dBGcnfQyOuHuYvBh4Oyz5Fs8cIwvybkZm8qRaK3DLW57EtbRxcYp+E+7s/zNWLn4gCXam0Z9cSY/Ee47SYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sQpNbmEC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B6Ie/feE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pni0UpLe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rSwNxQHW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D12622252C;
	Tue, 25 Nov 2025 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9l+WKaVmYFmKkau1igqnO66HrPcwewgu+mf1wm0Emc=;
	b=sQpNbmECKgw6Pgrg/cIHjRNisNi2615W38ShQ9oCJ8EGPFTh4VSemlymJLhmSlQqdkM78i
	JkPuk4Ju/7WsBivKl1gVj3GgeQ6ihw2OuUvZft8fn8G/DsMYhMTMtExMinBjT8L4of8nPi
	asj2nidVPBMDr4412n7UxzByqmgZsek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9l+WKaVmYFmKkau1igqnO66HrPcwewgu+mf1wm0Emc=;
	b=B6Ie/feEIHc3aLvu18o8cmUY6/0um006z88Ss2vnBxhp9CgwF0paqlSOQOppYYQwbCmJKv
	JtGu3Ki0vB9wx0AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pni0UpLe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rSwNxQHW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9l+WKaVmYFmKkau1igqnO66HrPcwewgu+mf1wm0Emc=;
	b=pni0UpLef8iQNq0HR9r64Wkp8Cq9nhFJJ4zY4si3AjLLD1EewTEDdsotaHHqgza0PC1Eht
	c59UdGvOVIXEJ8ICP353eEg4mnVtQ9pnq/vq6ZiLmUrHbl7ZJNJcG7B6YzsC/jYKncHYd8
	5Dyye8QA3b7fcKbB4uHDMS1daJOv7B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9l+WKaVmYFmKkau1igqnO66HrPcwewgu+mf1wm0Emc=;
	b=rSwNxQHWMHZtAmf8vLv79+41k+m9B2qwlXUZvvTZ+h6jAUFZ5Eecdp6lt2uuaPZ0g6t1Ty
	GWHnUDb+Cli97oCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE7BA3EA63;
	Tue, 25 Nov 2025 10:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lbk1L52IJWmECwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 25 Nov 2025 10:44:45 +0000
Date: Tue, 25 Nov 2025 10:44:36 +0000
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
Subject: Re: [PATCH v3 2/4] mm: simplify and rename mm flags function for
 clarity
Message-ID: <wpvjnzaffij4thc7djcl6uhyoo6kegjsgplplv5cyagcgw2szj@vlbnxzs4xbrl>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
 <8f0bc556e1b90eca8ea5eba41f8d5d3f9cd7c98a.1764064557.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0bc556e1b90eca8ea5eba41f8d5d3f9cd7c98a.1764064557.git.lorenzo.stoakes@oracle.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D12622252C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.cz:email]
X-Spam-Score: -2.51

On Tue, Nov 25, 2025 at 10:01:00AM +0000, Lorenzo Stoakes wrote:
> The __mm_flags_set_word() function is slightly ambiguous - we use 'set' to
> refer to setting individual bits (such as in mm_flags_set()) but here we
> use it to refer to overwriting the value altogether.
> 
> Rename it to __mm_flags_overwrite_word() to eliminate this ambiguity.
>
                          write_word()?
> We additionally simplify the functions, eliminating unnecessary
> bitmap_xxx() operations (the compiler would have optimised these out but
> it's worth being as clear as we can be here).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Anyway:
Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

