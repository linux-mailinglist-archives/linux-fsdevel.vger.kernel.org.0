Return-Path: <linux-fsdevel+bounces-62486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD54B94E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46B4190392E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C431985B;
	Tue, 23 Sep 2025 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="NjWVkt4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A33191CC;
	Tue, 23 Sep 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614622; cv=none; b=U/ag1O0QSByJIuSZA/2HuqnObSNY/bLihv1OlNukEok5zLjxWzY+WxpncabDb2Clu3IIOd8Mf47BOqx6DrN8n4G09xUwFgn967fo5JqFZR4dTLxXaT2ruZYCF+9e4sx9yYHOVwKUvW8imZZyi77xUi+MsBLxnkLl5aiyGfdulWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614622; c=relaxed/simple;
	bh=qWAVnKahXerGLTVl6U4/xu1rjKFMnWUBRsOMkj47iaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naRZPrvUkjWX10YLABA5fnMw20XXCaV8DYGtFe9OTQ0vC2SJLtMdTO/wpXBCdB3TVdvZORCw8N5Awk+r3qWr3tqavUbR/m/OWS9b9A6fqAtaTgYz2aHTXTVM5yXHJsSxZhZuAJUhCQHXH5dCbk+NJi+9kRsEcGvad8Xbg0Pc3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=NjWVkt4f; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=eezc9pSQCQApzALMoVtwFT9+N+ozo1hRehESSYFDA9k=;
	b=NjWVkt4fzZ4WqP1pSybS0D7QFEM3e16cxDcVsWEqa8JXYcWCKXFdCa9iGVklM16p/qI+AMoc0
	C1rksFf4KAwZZ9dEkN242V/mmrdpk2Q9lXQQzdZEI7ODnapuo7A7oa3ldPf5tNBADqy4hSkriH7
	Yj6JVRtgK5Yxfd7GtjiXDc0=
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cWCC92JSrzYlvnf;
	Tue, 23 Sep 2025 16:03:01 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 16:03:23 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 16:03:23 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <yuanchu@google.com>
CC: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>,
	<apopple@nvidia.com>, <axboe@kernel.dk>, <axelrasmussen@google.com>,
	<baohua@kernel.org>, <baolin.wang@linux.alibaba.com>, <byungchul@sk.com>,
	<david@redhat.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<harry.yoo@oracle.com>, <jackmanb@google.com>, <jaewon31.kim@samsung.com>,
	<jiahao1@lixiang.com>, <johannes.thumshirn@wdc.com>,
	<joshua.hahnjy@gmail.com>, <kanchana.p.sridhar@intel.com>, <kas@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<liulei.rjpt@vivo.com>, <lorenzo.stoakes@oracle.com>,
	<mathieu.desnoyers@efficios.com>, <matthew.brost@intel.com>,
	<mhiramat@kernel.org>, <mhocko@suse.com>, <mingo@kernel.org>,
	<npache@redhat.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<pmladek@suse.com>, <rakie.kim@sk.com>, <rostedt@goodmis.org>,
	<rppt@kernel.org>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<usamaarif642@gmail.com>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<yosry.ahmed@linux.dev>, <yu.c.chen@intel.com>, <yuzhao@google.com>,
	<zhengqi.arch@bytedance.com>, <ziy@nvidia.com>
Subject: Re: [RFC PATCH v0] mm/vmscan: Add readahead LRU to improve readahead file page reclamation efficiency
Date: Tue, 23 Sep 2025 16:03:19 +0800
Message-ID: <20250923080319.28520-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJj2-QHy3rTSPpE5uyu4gW9dWe1E5Q28P_N-VX2Uo+xBFauxdw@mail.gmail.com>
References: <CAJj2-QHy3rTSPpE5uyu4gW9dWe1E5Q28P_N-VX2Uo+xBFauxdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

> 1. Problem Background
> In Android systems, a significant challenge arises during application 
> startup when a large number of private application files are read.
> Approximately 90% of these file pages are loaded into memory via readahead.
> However, about 85% of these pre-read pages are reclaimed without ever being
> accessed, which means only around 15% of the pre-read pages are effectively
> utilized. This results in wasted memory, as unaccessed file pages consume
> valuable memory space, leading to memory thrashing and unnecessary I/O 
> reads.
>  
> 2. Solution Proposal
> Introduce a Readahead LRU to track pages brought in via readahead. During
> memory reclamation, prioritize scanning this LRU to reclaim pages that
> have not been accessed recently. For pages in the Readahead LRU that are
> accessed, move them back to the inactive_file LRU to await subsequent
> reclamation.
>  
> 3. Benefits Data
> In tests involving the cold start of 30 applications:
>   Memory Reclamation Efficiency: The slowpath process saw a reduction of
>   over 30%.

Did you enable MGLRU? If you did, I guess "do not active page" and a separate
LRU would have the same effect, but I didn't find any benefits.

diff --git a/mm/swap.c b/mm/swap.c
index 3632dd061beb..9e87996abbc9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -504,7 +504,8 @@ void folio_add_lru(struct folio *folio)

        /* see the comment in lru_gen_folio_seq() */
        if (lru_gen_enabled() && !folio_test_unevictable(folio) &&
-           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
+           lru_gen_in_fault() && !(current->flags & PF_MEMALLOC) &&
+               !folio_test_readahead_lru(folio))
                folio_set_active(folio);

        folio_batch_add_and_move(folio, lru_add, false);

> 4. Current Issues
> The refault metric for file pages has significantly degraded, increasing
> by about 100%. This is primarily because pages are reclaimed too quickly,
> without sufficient aging.
>  
> 5. Next Steps
> When calculating reclamation propensity, adjust the intensity of
> reclamation from the Readahead LRU. This ensures aging and reclamation
> efficiency while allowing adequate aging time.
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

