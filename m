Return-Path: <linux-fsdevel+bounces-33004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8899B1568
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7391F22504
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB0C178CF6;
	Sat, 26 Oct 2024 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wczahDW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152C217F2E
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924493; cv=none; b=MFTYwJ6Ea5luN/Xx//z83aB0sOGRaxKNtn0lxHhK2kPPgtJYGHOFqP2+XS6OwQfV1NFRehPHFqQ8+dcV5qEODH20o1lMJt6c9l0IFko999Labrro1K+IVB5o0kvLKM5ps9GD0OOmnN1rfqNkvjGE0SQHVKDNpPoULi3EZHoB5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924493; c=relaxed/simple;
	bh=8MEZ7lwX5sGzz8KdBgtWG5NX15NIfJ7Pjy5GijPHl0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtR0V84EDHcetR+l6O8251giAJVVEouJqF+RBJoAbFpM6OXj9wu59SpgYKt97MuX0VCXKJt7w12VQOKbDPP9l7WmhT3+3DiRUuvu8gv8xXGV9Xuydw2lpuP+R0H3jPCavJw+gzBkU2DB8V9/Zc3oLgyG8L29BaSaum6Y7T1rj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wczahDW0; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 23:34:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729924489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxrrU0C1HHBfUSnsjeyhEXVDIjFovKtPgZ0TUPmLbvU=;
	b=wczahDW06h7sCwR/14RhOAhWxIUZiK9a9DHkNpFa54ZSDnpRWfSNkjci9DWRCMM39T3yFY
	JucMbidVMqOQGS8doMn8rAbfDURpjRycJKApjaKvXDDDtGBdV+pAorShsf6DE8hljux/dC
	Td3IuC1aSRPgC4lmUR0FdWkEr9EwdWo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-ID: <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025012304.2473312-6-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> While updating the generation of the folios, MGLRU requires that the
> folio's memcg association remains stable. With the charge migration
> deprecated, there is no need for MGLRU to acquire locks to keep the
> folio and memcg association stable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Andrew, can you please apply the following fix to this patch after your
unused fixup?


index fd7171658b63..b8b0e8fa1332 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3353,7 +3353,7 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
        if (folio_nid(folio) != pgdat->node_id)
                return NULL;

-       if (folio_memcg_rcu(folio) != memcg)
+       if (folio_memcg(folio) != memcg)
                return NULL;

        /* file VMAs can contain anon pages from COW */


