Return-Path: <linux-fsdevel+bounces-65567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13873C07CB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8EFC508913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E034A784;
	Fri, 24 Oct 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BGyX8JeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8631A7F6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331269; cv=none; b=HLt1GFkfDHCFnfLwzJ2qyxy8oWrUzMUKr5emzV54N8VX+kbJqJVq7qGMRWWHzzwdIobnsV8AlQW3KLAPFys8m1kPbHxBQTAOKmGY/d0ovzOxqFiQXkrgptQuH4et2Z1zh3P0u0voTk+BntRdsTFc8A7nvOcWIzsBirQDnrySjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331269; c=relaxed/simple;
	bh=0nC8tJfsbUxYAiM3oB8e/6iPoDpwQx4IwD1lKsUxMmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5GHzhcFoYqSmVJskDRBJI3RROzUoEOELW7CD5dXU7QWtsUvf4DIdF6FwbENwFPzux+5VgfCUZ7hCoHWnNDW4qsln84syWy1pgWWlJ7irbsO7b7WTYp/k1zCxg6u98vVg54qiKsMVmkSm7XeMC2WTq+AYc0UORFI5t4GeogFjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BGyX8JeR; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e51cf965dso315735185a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761331266; x=1761936066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKqOWG1gpzHwxwYl3SQC/dTHK3GeimTlZWo8wLiUVXY=;
        b=BGyX8JeRXEcu4pr63rHWRLPkb+MIPvJk1pfjW/kGtqHWCx/l7kobKlb6qKNA4J5LvK
         6yTqO4lbvILYPnhvyamfWOyygZkULwde22ElPZcvDjAbrZf35Bjbuvr0uF5pAlYUuliX
         45Ypq8+gYGFk0DNuaJE/5KuPXKhupuGY2eyZSnuR2TLUIahRmhs6v1k1GHZpWOUuolPH
         Ch+Hzyquuq1vwUzB6sjGuFajYHxKZb6M5gB9GPXEaqIWpOKXltFC/7q4SYswK3eAvp23
         TWoo/Kb5dx+2BSk4k8QoWyX8gC+bEhTY+UoGX6YtShx3Ph4ag4IQPGzlIpm4FJ4R2xof
         CsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331266; x=1761936066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKqOWG1gpzHwxwYl3SQC/dTHK3GeimTlZWo8wLiUVXY=;
        b=tt5mEMns8ZJTtFBeErI4ZZD+Hxa/cbsTnKNkcBsJJKsAtO8LaGHswc7IB0fZk0L8aw
         /NUbutv7RYJsip2AUr8ObYiyXAzT5zk7akrCXi2sp1hHeWTDb60ZLftBL7KmBxx8LxLO
         G7HcqJFXfr1EV22xG5Ad1Vf3n5qYokzdZ6sDTs772AGm0PtHgXu2QttvJ1OzO0NdSnum
         R74n0i/VCyS8XkfS1VFThyEjLmCtIE+N6YDu/HGyVZvAaBTtBRsp7PGmGt0waF3jsgj0
         OsZaw929YH+0r68UdG0cNwRCo3xHIagCyC/tqNq1tCnD/OSoY/HGi3o7LmMz1Dsfn2WS
         rOLA==
X-Forwarded-Encrypted: i=1; AJvYcCW+9QOY5u8+biDJ8vMvRXODJN61u1ieRZki0DBWhSGSd4ezDiPXKk7ytaDOj2WjZ/JkwBzcOjjMZzVg2JEY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6/r8fuvlfIKNrTapofE/k/tEMH6HKcCh4Lpb1ZcHg+AyLWjc
	G52KAr5Kx8Id8BniGJUcDPjAcVhBOEFQFqLOCo/pRFdmqjEAcY57B+V84gC0gmpYa9A=
X-Gm-Gg: ASbGncvEY5o6Hab7DWrdmhtgyiaNdJo0vsT5tJ0MKzxI04K6xfKGzxWTM4eIqjdvWPU
	0GGwtPaBG9guMbRo60FKiy/t9BJqRQEgfLqAzJXuLAINi3ORmLypuLUFtHp/BGvRBR+aqMLwXU2
	cFuns/CQklC0mmEUFHFvGZfEjwaXqKXsMjdn8y3hXMYX2WQ42BqCp2TkFimLjfhqyq/IvBk/3AB
	zZxo8zJfBqSt8sg0P9F8wfxYe4qP8DjATOuPVOPeJ14bTd7/DzKDaUZIkm+I4RFo7HCC80DnSBu
	ms/D2fKCZ+U76Wp2aSxGz0yx0OmeOedKkuerzJrsthSTpBZG0m+wCFgyMhhISvKdQlQb/mPnYAn
	BYrv17wgxybtMpMHbGx1Lv7Pv3K4YgipUvBGyCiYbXPTCr+oFc1uApqDvDy/DyYq7kTEQXnofm3
	hTxTd5MDb/s/+9Oqjj9enwcQoRLbvp/jOr7T4dp1pQ8rAPhyNndt88c8l9+mYM6u1Q3TKVdbbHc
	dMIpS45
X-Google-Smtp-Source: AGHT+IGnY4R12t5EHq14eSTeJNU2ADxULRmUNWe43hSkC8AnH74fLNRTNtzJmefk6NfxewScJ3xiIw==
X-Received: by 2002:a05:620a:190e:b0:883:5640:b0da with SMTP id af79cd13be357-8906e2cf39dmr3403918985a.3.1761331265598;
        Fri, 24 Oct 2025 11:41:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0dbcd225sm441582885a.12.2025.10.24.11.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:41:05 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:41:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/12] mm/huge_memory: refactor change_huge_pmd()
 non-present logic
Message-ID: <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>

On Fri, Oct 24, 2025 at 08:41:25AM +0100, Lorenzo Stoakes wrote:
> Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
> the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
> use thp_migration_supported() consistently.
> 
> Resolve this by separating out this logic and introduce
> change_non_present_huge_pmd().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
--- >8

> +	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
> +		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
> +					    uffd_wp_resolve);

You point out the original code doesn't have thp_migration_supported()

is this a bug? or is it benign and just leads to it failing (nicely)
deeper in the stack?

If it's a bug, maybe this patch should be pulled out ahead of the rest?

~Gregory

