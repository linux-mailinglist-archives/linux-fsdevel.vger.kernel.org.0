Return-Path: <linux-fsdevel+bounces-69452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77807C7B62C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FBBB363B9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9042E8B9F;
	Fri, 21 Nov 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mqq83c+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF326FA6C;
	Fri, 21 Nov 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751094; cv=none; b=IRcwrFA9G9cBZ+yxpI22yoiB+nymHeWOl7pKIw0Bi49k/Ij+6RqR5d7In9eokqTBVpY03nyeh7EtOc/kR2ILbuAmbWdxrb/iq59tRhDeLexQ88Cxmlj1Z98gzZ/B8hDEpKX/kyjygKP779Z2sVm6Gr6NPDgXSI10ovSJCU7USy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751094; c=relaxed/simple;
	bh=d2GokLH9Jn7Ay35MXv4HSVUXdJS/fnCjmcIwOcL9BgA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aNvZVVJlOdRugTsNA/dWBjKY5hQTfzSmP1zDv6cOJapaaEa6ZT5XfkEBrGjtkc31IkKMUGJ7xzGt2NBHRIFEmaTBR3klR5Q+2n7Ta0mkltmzDOJnqEgIbjBzNYkcSZQhsUZxuGuUD+RVsrPzpOd//SyqrbU8i1hIbNrlcbsMcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mqq83c+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8378DC4CEF1;
	Fri, 21 Nov 2025 18:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763751093;
	bh=d2GokLH9Jn7Ay35MXv4HSVUXdJS/fnCjmcIwOcL9BgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mqq83c+AcV3bkcoekyHmiQP/DqqYSLvxbz5l/EP7TMtFKSF7Y1Dfuq6nLL5ZCwD7I
	 Z4Y7RhDpT3IL2ZJF3wsSy+RVz56gobTC3n8MTAfklAdDkzaGyJupYGWQUMDvbJM1Wr
	 m3urCQ1obcfSRU4B9FjtR5fbCIr1Z4wBKfqeREiQ=
Date: Fri, 21 Nov 2025 10:51:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Peter Xu
 <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Kees
 Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn
 <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Pedro
 Falcato <pfalcato@suse.de>, Shakeel Butt <shakeel.butt@linux.dev>, David
 Rientjes <rientjes@google.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song
 <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He
 <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: introduce VMA flags bitmap type
Message-Id: <20251121105131.1dea1fbd744587b433390116@linux-foundation.org>
In-Reply-To: <c82d75d1-5795-4401-92f8-58df6ac8dbd3@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
	<195625e7d1a8ff9156cb9bb294eb128b6a4e9294.1763126447.git.lorenzo.stoakes@oracle.com>
	<c82d75d1-5795-4401-92f8-58df6ac8dbd3@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 17:44:43 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> As Vlastimil noticed, something has gone fairly horribly wrong here in the
> actual commit [0] vs. the patch here for tools/testing/vma/vma_internal.h.
> 
> We should only have the delta shown here, let me know if I need to help with a
> conflict resolution! :)

OK, thanks, easy fix.

