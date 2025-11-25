Return-Path: <linux-fsdevel+bounces-69763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC7FC8487F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B31D734DAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CCF3101A7;
	Tue, 25 Nov 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wMFOmfV0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WY7EhNEv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K2FYgCgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J54rdR/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7362DAFBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067368; cv=none; b=trcLTtPLYBJhmC0HIYDZQ8PcCof2NqpTh4JFSC6j7D1US1+domrbgx8V0jYOeyELnYGSjT1DaQ/qB2duFYYfK6MddoJACE7V1ebwRB0OXl64RJNX1zwIwb8wo1Vn8SThPeqNUAz7nsdDv/TyRDeSYESc0Ovh5EbZziPwedWBPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067368; c=relaxed/simple;
	bh=ELiNL1d54YZbxOjKDUuShrGKcvo74xDlL5WqP4k5TUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsojfFSVCm9Y3UgIQVhug8YV0j1vzC5gteAsjmy/GWf8JMWbeXc/v4J0Ry7JzBXb/MzZP3i4dINv21n2X6n+5a5e6YSX+u+IPZiVmewb+izBz19y566ShwCnNdX/8vKbKV4K9PqXIjUM0WqONd7hcSpqmkTpRmiIsuw+fziFufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wMFOmfV0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WY7EhNEv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K2FYgCgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J54rdR/m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A054422774;
	Tue, 25 Nov 2025 10:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYspdjC0lpi9JmCQilKQweJ66sk4zl5eE8yE81CCRs=;
	b=wMFOmfV0+x/Yh7CMm56VlBlnQn/SjulBKf5Drv1UP5Br1KP+afi+VZLWXQNwZ/5GWjVvlV
	W7dVeKSaoC0KFbN8OKsJ+EtWQ7E02q7VMdMgz22hebAmIstXrQ7Nn0JU0Ti4/uVqJ4LEhg
	LHes/c62gT5AUJgvtMONKF5Uidj8YXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYspdjC0lpi9JmCQilKQweJ66sk4zl5eE8yE81CCRs=;
	b=WY7EhNEvDwQkbNYSwBQmlI/iaBNtANR/gBR2OZQSTnZzxO2x3buhhuR/QBWLP9egatayXB
	yl1LcGujoc+KyZBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K2FYgCgP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J54rdR/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764067363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYspdjC0lpi9JmCQilKQweJ66sk4zl5eE8yE81CCRs=;
	b=K2FYgCgPxSBYbK++lrRIDXKEC48MYnC2nSGgvwNpJgbuWEuFlH5kPY8z+amA/XrFIp7p7L
	WjA4NNTce1KibnEdhSifNyHcDZ/ckDBvTY/MlB8M7qB+Qv2f/f5YjPYOefaSQu7nCe13Vg
	VPuLPH6mxSnH211BBjqhxZncKmrDA60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764067363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SsYspdjC0lpi9JmCQilKQweJ66sk4zl5eE8yE81CCRs=;
	b=J54rdR/mXqBTtJR/9i1hqqfUiUBOEZQvN2+kshns9Vlo3mnxux34iF9W5RzxDAv33orMgM
	SxvGtELkbp3/wNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DED93EA63;
	Tue, 25 Nov 2025 10:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAlUIx+IJWlpCQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 25 Nov 2025 10:42:39 +0000
Date: Tue, 25 Nov 2025 10:42:37 +0000
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
Subject: Re: [PATCH v3 1/4] mm: declare VMA flags by bit
Message-ID: <fs6mvtx5tla556t4bo4cex6i2pf4huvdzbfwymtckqh6ughd3h@yjjpeyko3kng>
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
 <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a35e5a0bcfa00e84af24cbafc0653e74deda64a.1764064556.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: A054422774
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 

On Tue, Nov 25, 2025 at 10:00:59AM +0000, Lorenzo Stoakes wrote:
> In order to lay the groundwork for VMA flags being a bitmap rather than a
> system word in size, we need to be able to consistently refer to VMA flags
> by bit number rather than value.
> 
> Take this opportunity to do so in an enum which we which is additionally
> useful for tooling to extract metadata from.
> 
> This additionally makes it very clear which bits are being used for what at
> a glance.
> 
> We use the VMA_ prefix for the bit values as it is logical to do so since
> these reference VMAs. We consistently suffix with _BIT to make it clear
> what the values refer to.
> 
> We declare bit values even when the flags that use them would not be
> enabled by config options as this is simply clearer and clearly defines
> what bit numbers are used for what, at no additional cost.
> 
> We declare a sparse-bitwise type vma_flag_t which ensures that users can't
> pass around invalid VMA flags by accident and prepares for future work
> towards VMA flags being a bitmap where we want to ensure bit values are
> type safe.
> 
> To make life easier, we declare some macro helpers - DECLARE_VMA_BIT()
> allows us to avoid duplication in the enum bit number declarations (and
> maintaining the sparse __bitwise attribute), and INIT_VM_FLAG() is used to
> assist with declaration of flags.
> 
> Unfortunately we can't declare both in the enum, as we run into issue with
> logic in the kernel requiring that flags are preprocessor definitions, and
> additionally we cannot have a macro which declares another macro so we must
> define each flag macro directly.
> 
> Additionally, update the VMA userland testing vma_internal.h header to
> include these changes.
> 
> We also have to fix the parameters to the vma_flag_*_atomic() functions
> since VMA_MAYBE_GUARD_BIT is now of type vma_flag_t and sparse will
> complain otherwise.
> 
> We have to update some rather silly if-deffery found in mm/task_mmu.c which
> would otherwise break.
> 
> Finally, we update the rust binding helper as now it cannot auto-detect the
> flags at all.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Scary but cromulent-looking. Thanks :)

--
Pedro

