Return-Path: <linux-fsdevel+bounces-69757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41DC8464D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 435AC343000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72022EE5FE;
	Tue, 25 Nov 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qj1aRZge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D872DC76C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065594; cv=none; b=X/KCRLdDcagvO3zJV7qLKw98ZI3ByPxE0HltMY4HoBw/2Co2REm9c6TEmercLaYtqhKemgZh9QBjGEIiXGW/qj381KrkP1dF/udp95MVGwt5NjbVVc30QLcuui4W+EWBLdSfbiAvxqlH9Qv6HXnk9Ox4WsRXTQaC5+qQj3qhdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065594; c=relaxed/simple;
	bh=gsMSARXH32SKLC9OxBjpDrzvpj6wltDkXJ6u0vg9Su8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+7wpK8Jo9fWnPMDqapU2egWMHAaB4uoB0M/EwuuDiXrXap1uVGnsQk8iVf/d7qGvjxFPXp+aalgWZG160m39IS/XGfwWMDWHvVJ03a4wUROSyg7kh4y5T7INXGqw59C0ef4swrXTJcixyK2eLJSiLBXSJ6Z66Q9s4ffY5x1bG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qj1aRZge; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429cce847c4so3666291f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 02:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764065591; x=1764670391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/erQEEZyPzxAtDWVJKBMClg46msX9PfsRuYGXr+zPI=;
        b=qj1aRZgecQylqgzz/q+Yx1GRwoSq1vW1M3MlfXSTHTZhaabuScGiLRhiuWw4g6fpwh
         KPuDMoItswKcpZz8JG3ULIxsvmHf7mJGCTAt5Jtludg3uGbZbT/jHKHu7mrExRjbovBV
         etTbi4CdsClGG1YvAqMD/Jr0GeI301URB7g/B6uyDRukJoXFgZB7UXUpN5a/uvF7l1N8
         HoDatknTcLVTP+BY907n0GneW/BMMkwNVNwdRL/C/g/35MraXxLuOpPsBsvjc7iNCyjI
         FVN0vzO0n937qdiR3rR4VDwSZ37qve5V7BVkgdgDp5THjRqfKV9h4meu7/aRWDS89yIS
         5fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065591; x=1764670391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/erQEEZyPzxAtDWVJKBMClg46msX9PfsRuYGXr+zPI=;
        b=YN6WPNnhVzj3IIS+2nX9t/TZhyMcfq8cspT1tjRRNaIG+Yy9LmiQmDNIr0QyTGK0/H
         wma4EbVegH1OSPVv9mkbGo40aECBBKWvL08OZA0traWTkp4D0eQ8E5SYHdqXzhtrEMgU
         /JNFpxk/ijtUa1f04Y7gVmGye6ltW1G6tdnG+jYJd98D+nwVU8orb0QtiPZa/kba+NGd
         CQZ8p4p8pYxm6bMSn9QPtaPbaLTDXfckbZW7lyGzhPgMKHfp9ZInsoPUHIr1wBHRLBbf
         Wq0jkSrcpdtkd59l6nL+kcuUPwwfuLH/1Tv6ck7eHXkTxz8GJfILPyrRujxPr5WxDWrH
         t9xg==
X-Forwarded-Encrypted: i=1; AJvYcCUSQA2c6DA2mlSkXHxZRjP5lDZC5XR2r5nF/QrADu+lhHyaJtUnLcOdGFog/TnODaOsv2XHWLnJY9pgD7qF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tCw/EyAEdD/2kUwLEXFf+G55uaZSEMkrDZ/ifeE5fY2RmWwc
	5b9YGCXdGHkQInvPOJYvtMv713LWBynQTxbqhMqJ2qQhSwS8tuSn8QFMUS/VeGKwqxcftlRt3NE
	lqzr1DNbU4IunRXmBIw==
X-Google-Smtp-Source: AGHT+IHsGtiL+iNDNVV1EqqG8i9Q6opGUyl7TTE27f4MhISajHThGLKjh7t7VU/7sKSZKE4kViLCm6zohC53wBY=
X-Received: from wrno15.prod.google.com ([2002:adf:eacf:0:b0:42b:31d0:1334])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26c4:b0:42b:2f79:755e with SMTP id ffacd0b85a97d-42cc1ab8874mr14661798f8f.3.1764065590345;
 Tue, 25 Nov 2025 02:13:10 -0800 (PST)
Date: Tue, 25 Nov 2025 10:13:09 +0000
In-Reply-To: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1764064556.git.lorenzo.stoakes@oracle.com>
Message-ID: <aSWBNSbXrWJnpsRl@google.com>
Subject: Re: [PATCH v3 0/4] initial work on making VMA flags a bitmap
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

On Tue, Nov 25, 2025 at 10:00:58AM +0000, Lorenzo Stoakes wrote:
> We are in the rather silly situation that we are running out of VMA flags
> as they are currently limited to a system word in size.
> 
> This leads to absurd situations where we limit features to 64-bit
> architectures only because we simply do not have the ability to add a flag
> for 32-bit ones.
> 
> This is very constraining and leads to hacks or, in the worst case, simply
> an inability to implement features we want for entirely arbitrary reasons.
> 
> This also of course gives us something of a Y2K type situation in mm where
> we might eventually exhaust all of the VMA flags even on 64-bit systems.
> 
> This series lays the groundwork for getting away from this limitation by
> establishing VMA flags as a bitmap whose size we can increase in future
> beyond 64 bits if required.
> 
> This is necessarily a highly iterative process given the extensive use of
> VMA flags throughout the kernel, so we start by performing basic steps.
> 
> Firstly, we declare VMA flags by bit number rather than by value, retaining
> the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
> fields.
> 
> While we are here, we use sparse annotations to ensure that, when dealing
> with VMA bit number parameters, we cannot be passed values which are not
> declared as such - providing some useful type safety.
> 
> We then introduce an opaque VMA flag type, much like the opaque mm_struct
> flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
> field"), which we establish in union with vma->vm_flags (but still set at
> system word size meaning there is no functional or data type size change).
> 
> We update the vm_flags_xxx() helpers to use this new bitmap, introducing
> sensible helpers to do so.
> 
> This series lays the foundation for further work to expand the use of
> bitmap VMA flags and eventually eliminate these arbitrary restrictions.

LGTM from Rust perspective.

Acked-by: Alice Ryhl <aliceryhl@google.com>

