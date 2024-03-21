Return-Path: <linux-fsdevel+bounces-15028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8948861BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C728873A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 20:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6AC1353E2;
	Thu, 21 Mar 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="myqqqaYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00E5680;
	Thu, 21 Mar 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053111; cv=none; b=U8f0onOFfhAERUKKryZoe7bfx9AAEsYqbeRp9UhkdEtPE5JYse6Ee8sn15F08GlQ1ZnnZ/iFDFY9McLbcQa91UpvvSRdHNrSB2WNDU6SFFXjGge6x3Y2yzY5o/DQs/nly50FYYYwqzw4oHHx0cdEf6fZJe+7PXWLERSOu/uzdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053111; c=relaxed/simple;
	bh=baRa6A2qOinOd5YVAtWej5lfyO2Yw47YmlHbzlE1Jvg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OE+semlzvoEKhY1+ZzXqxt61kWAta5CLgzXWUp+ilDqSxYI7VV0Ph2ix9CoWZfcqW2kCbGRn7dS9UOtC3oi5eUO1q5uskRm4BbLtWW+Tj97ajKqTsszNZDCtkpG0pNDWJtf7DX8Z/WrShhh+73u78YkN0+T2fHOxMItE6xc0lZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=myqqqaYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C826DC433C7;
	Thu, 21 Mar 2024 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711053110;
	bh=baRa6A2qOinOd5YVAtWej5lfyO2Yw47YmlHbzlE1Jvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=myqqqaYbliRJE7PVgZhrPNW4VsZSILLB+0SlZqyShzqltI9nE6pTdWnygoFZn4dbb
	 cd7SNGeTgLc7GfmU2xwl33gTqeb9pkt91tBji4fk8llEMAbUkAQtFXJU5/LCiWBvgC
	 EtAkHaVZ9tqLwxhvUHQb1iYeHrpwdBWq8Zx/XJf4=
Date: Thu, 21 Mar 2024 13:31:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
 dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org,
 muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
 pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
 dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
 keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com,
 gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
 glider@google.com, elver@google.com, dvyukov@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 kernel-team@android.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 05/37] fs: Convert alloc_inode_sb() to a macro
Message-Id: <20240321133147.6d05af5744f9d4da88234fb4@linux-foundation.org>
In-Reply-To: <20240321163705.3067592-6-surenb@google.com>
References: <20240321163705.3067592-1-surenb@google.com>
	<20240321163705.3067592-6-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Mar 2024 09:36:27 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.

I'd have thought that there would be many similar
inlines-which-allocate-memory.  Such as, I dunno, jbd2_alloc_inode(). 
Do we have to go converting things to macros as people report
misleading or less useful results, or is there some more general
solution to this?

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3083,11 +3083,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
>   * This must be used for allocating filesystems specific inodes to set
>   * up the inode reclaim context correctly.
>   */
> -static inline void *
> -alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
> -{
> -	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> -}
> +#define alloc_inode_sb(_sb, _cache, _gfp) kmem_cache_alloc_lru(_cache, &_sb->s_inode_lru, _gfp)

Parenthesizing __sb seems sensible here?  

