Return-Path: <linux-fsdevel+bounces-68498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537E7C5D6E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC17421646
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7131D375;
	Fri, 14 Nov 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0t10MRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087631C597
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128251; cv=none; b=C0B9fKwmGsEn6U0ExTLfOQUKGfi4JRxxh2/ziV9ZfYPkeU3ViZH7yuBBf5Wp0cUKWTk/QdiN+JYOPbQHeR+0wQIml92FzNMMR7DcO4cgnlF3ns/p/AnzdFkSP0cHRTXJxFUuGoy7AK7hpv7EFopuivhscYWCDW2CZoDj2Qhluak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128251; c=relaxed/simple;
	bh=CsIEbKP1oj7XlTEG+3Uocz8o2caJW9JzXXh9HJQrUiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRt0ihAQAD1EZi6D04yCccMwbKwEbmhEsamZrnAsECEx6/Ln9dUI/WLAGifPIzRvy4+bllt1rPGTx0o8NgarHzo9JoVj3/DD/9xJ8wsqogTggSlh3urs75Jk4bKR2uquXNhjnYr4bu2vSg4tDi5ADPtxzNxKuz+uoZNEn3CwaZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0t10MRZ; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b487cda00so1054258f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763128248; x=1763733048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrI+zvBboCdfdse/X2BfoaixhuDzfAQTP9joVyOmZM=;
        b=D0t10MRZsMzAagfAcY0YldrrYNcStrIq8CuCwLgFCwF8CgnIdPtjNc2x5+DS3Gj9UU
         7NGGkHRLG2TSprcCC40G6UZwTFOVvjKWfc27KPHafSDSM8p5nZHgmXuIGpP6G/x70yBt
         inGFdVn+AGo9cf9IB/3k6iwllkNPchP77IRglZBq+DZJCNe6U7aXZJzYyf9WK/Xlwd0A
         oJFzbSytCx5UobDRXYADa1iQ6zzE6KFMrzUNM4ZgEmGizRRmuJHfwJys1RN8BlxDen1Q
         mwgjWYawACQiSjBUMVGMVkG1yFpVstxmWMPYjLRLOR5e+x76hSq/a25zSK3Vg/gn8ZyN
         Euew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763128248; x=1763733048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrI+zvBboCdfdse/X2BfoaixhuDzfAQTP9joVyOmZM=;
        b=qPi/HYvJfvQQMY0wz4HNDjd9jF81R9iowRHqR7UUiebXryhLA3m/4EesizECwjIz9L
         5wl+8ur802XIeqKyLBt9+1IxX85PRg4ACDyu9kcReHVI0qZvsTcRN+KjiaHM/W3/5/M4
         vung+HwNxOuNWzApx18z52lupkY/xG0LoRwpQrq99hIG51gXnJUdA/CRRU8bWwOKQaJ0
         YuwzceugwbNstgS7ac6rHZ21z4ATaQ8laZU3fMW6AlVSwu1Zl+smdcxk0jxd+nHGhnr7
         uPw5mNj+p05LHm0akn1m/wqFjn8db5/IGGVQ9GZdAdcEPO3dFltcjjNM1Qvv3dhJjNI9
         m9ig==
X-Forwarded-Encrypted: i=1; AJvYcCWrkC0XbSF2Cpv3wJlYxWpiubl7X0aSGvqq/SB0iYyDB7eAL/+KzON4ME00ihm1Wms7uFlDvV7/E/1Pw7Nc@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFTUjVvBKlbp/r9JNIpEd0HUQds+GquEpAvKS2eO6eodbupsg
	N2GuDUS3lEnmPDUPBOwVSFiXvSjfiqU7eXhAdkXNZuYBb5XkMYG6v7SMfibvFt7U1STAbyWkHBQ
	VUSFdE6foi0/t5DHosA==
X-Google-Smtp-Source: AGHT+IEy1IzfqWatibDXEefRnIBkZupbkLV4W34pV9YXz3HKgkrUUbyPksPnt2imV3NkIkiiyQrvQWIxaug0o/A=
X-Received: from wrrn3.prod.google.com ([2002:adf:fe03:0:b0:42b:585e:3ca8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:144c:b0:42b:39ee:2889 with SMTP id ffacd0b85a97d-42b59374c26mr2988918f8f.48.1763128247691;
 Fri, 14 Nov 2025 05:50:47 -0800 (PST)
Date: Fri, 14 Nov 2025 13:50:45 +0000
In-Reply-To: <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com> <6289d60b6731ea7a111c87c87fb8486881151c25.1763126447.git.lorenzo.stoakes@oracle.com>
Message-ID: <aRcztRaDVyiDO7aH@google.com>
Subject: Re: [PATCH v2 1/4] mm: declare VMA flags by bit
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Kees Cook <kees@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Pedro Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Nov 14, 2025 at 01:26:08PM +0000, Lorenzo Stoakes wrote:
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 2e43c66635a2..4c327db01ca0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -108,7 +108,32 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
>  
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
>  const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
> +
>  const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
> +const vm_flags_t RUST_CONST_HELPER_VM_READ = VM_READ;
> +const vm_flags_t RUST_CONST_HELPER_VM_WRITE = VM_WRITE;
> +const vm_flags_t RUST_CONST_HELPER_VM_EXEC = VM_EXEC;
> +const vm_flags_t RUST_CONST_HELPER_VM_SHARED = VM_SHARED;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYREAD = VM_MAYREAD;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYWRITE = VM_MAYWRITE;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYEXEC = VM_MAYEXEC;
> +const vm_flags_t RUST_CONST_HELPER_VM_MAYSHARE = VM_MAYEXEC;
> +const vm_flags_t RUST_CONST_HELPER_VM_PFNMAP = VM_PFNMAP;
> +const vm_flags_t RUST_CONST_HELPER_VM_IO = VM_IO;
> +const vm_flags_t RUST_CONST_HELPER_VM_DONTCOPY = VM_DONTCOPY;
> +const vm_flags_t RUST_CONST_HELPER_VM_DONTEXPAND = VM_DONTEXPAND;
> +const vm_flags_t RUST_CONST_HELPER_VM_LOCKONFAULT = VM_LOCKONFAULT;
> +const vm_flags_t RUST_CONST_HELPER_VM_ACCOUNT = VM_ACCOUNT;
> +const vm_flags_t RUST_CONST_HELPER_VM_NORESERVE = VM_NORESERVE;
> +const vm_flags_t RUST_CONST_HELPER_VM_HUGETLB = VM_HUGETLB;
> +const vm_flags_t RUST_CONST_HELPER_VM_SYNC = VM_SYNC;
> +const vm_flags_t RUST_CONST_HELPER_VM_ARCH_1 = VM_ARCH_1;
> +const vm_flags_t RUST_CONST_HELPER_VM_WIPEONFORK = VM_WIPEONFORK;
> +const vm_flags_t RUST_CONST_HELPER_VM_DONTDUMP = VM_DONTDUMP;
> +const vm_flags_t RUST_CONST_HELPER_VM_SOFTDIRTY = VM_SOFTDIRTY;
> +const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP = VM_MIXEDMAP;
> +const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE = VM_HUGEPAGE;
> +const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;

I got this error:

error[E0428]: the name `VM_SOFTDIRTY` is defined multiple times
      --> rust/bindings/bindings_generated.rs:115967:1
       |
13440  | pub const VM_SOFTDIRTY: u32 = 0;
       | -------------------------------- previous definition of the value `VM_SOFTDIRTY` here
...
115967 | pub const VM_SOFTDIRTY: vm_flags_t = 0;
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `VM_SOFTDIRTY` redefined here
       |
       = note: `VM_SOFTDIRTY` must be defined only once in the value namespace of this module

Please add the constants in rust/bindgen_parameters next to
ARCH_KMALLOC_MINALIGN to avoid this error. This ensures that only the
version from bindings_helper.h is generated.

Alice

