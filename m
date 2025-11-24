Return-Path: <linux-fsdevel+bounces-69706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC876C8202B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A45E3A7DE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9E316900;
	Mon, 24 Nov 2025 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xyI9E9od"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF418F49;
	Mon, 24 Nov 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007479; cv=none; b=VPucNO6af9Jx2FCnNW1P8KX4g9PGvwzX6DDhmirngyvNmhFrwFOMRRckM7kegQaerf7+wxsoOUZYIP3MMDOIrCkXilCU+HXtN9ylmS6JH97ZEU2GDcIF2DQgMp1VJZ6PnQqLw6/Cq/0gLiK2pVGZ1vQTsQK+ZI0ujL2LcJ8HAjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007479; c=relaxed/simple;
	bh=Buz89wV/XVRY7PHLg2aVA1DAoOfcPJ65WQO4XoSmrzI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RnPcAyB3CvMqKLSjBkm0Od644FXQtIu7fWmdm9mqWOuj5dLZYGTZJdKd0BtxgjFEzN9Fq6aI8NaWG5Hs1FA1L4ujjRpij71JZknFKC7ZWQLFlYjSbxUkyN68x25EudlzMA5AE0HyMjPnPCGjNCcMAPwhaRjvdpM4zbsQxvsilRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xyI9E9od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97B0C4CEF1;
	Mon, 24 Nov 2025 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764007478;
	bh=Buz89wV/XVRY7PHLg2aVA1DAoOfcPJ65WQO4XoSmrzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xyI9E9od5lVrE4kHG4x9twVnaDACV/2qZqaLgwff9DcB6X+ci1UtO8BJ8idl78jZh
	 JPm1bnkVQz7FOKFpBIk2GcAnwN60r8E82ewlguVLQJGRtJAmIndk4UnSinKDANlozZ
	 Fodw67tClV9Br70Br21nFRSztMX9zsmGyHM6DfBk=
Date: Mon, 24 Nov 2025 10:04:36 -0800
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
Subject: Re: [PATCH v2 3/4] tools/testing/vma: eliminate dependency on
 vma->__vm_flags
Message-Id: <20251124100436.cad9c3ecd7fc592e8ff23e3a@linux-foundation.org>
In-Reply-To: <09c2d927-6d34-4e72-a593-4a3f2b739a60@lucifer.local>
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
	<fb709773edcaf13d7a2c4cede046e454b4e88b1e.1763126447.git.lorenzo.stoakes@oracle.com>
	<4aff8bf7-d367-4ba3-90ad-13eef7a063fa@lucifer.local>
	<09c2d927-6d34-4e72-a593-4a3f2b739a60@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 12:43:18 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> It seems that the ordering of things has messed us up a bit here!
> 
> So this patch (3/4) currently introduces an issue where vm_flags_reset() is
> missing from the VMA userland tests.
> 
> Then 4/4, now with the vma_internal.h fixes in place, puts vm_flags_reset()
> back in place (this was my mistake in the series originally!).
> 
> But then this fix-patch, now applied as the latest patch from me in mm-new,
> breaks the tests again by duplicating this function :)
> 
> So, I'm not sure if too late for rebases - if not, then just squash this
> into 3/4.
> 
> If it is - then just drop this patch altogether and we'll live with this
> being broken for a single commit!

All confused.  I dropped the whole series - please resend?

