Return-Path: <linux-fsdevel+bounces-65581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD80C0813D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A573AD99D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15852F618B;
	Fri, 24 Oct 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qgjWqiQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E02F60D5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338244; cv=none; b=qknUpem8s7aCc6VGAbvicOYI5wB2+Tryc2eKQBVGZnwC8sflMEi2uDa9dwDb0BrOzzRITCTTPNfPSMNfmUTFqVFKG+Vemot4r5psK/p/BW/CP4qfWDEQu3JjxOrB7E4lUqTO7xLbmHzamPUiXNJb8FfGJOjV1KrYut90mIjMsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338244; c=relaxed/simple;
	bh=brPT+lM2XPdvJ0J0zQqzP3FRuejOJIrYJjvdheDJC0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huh+jRXCUOfU2J25+uuAaxhNg1qaTPwVG0gglPW/4zQ5472EWkM1rLVZ3e4Tn8BIwIvhxAh+YDcM8ykaHAX95734WdglaWH+yf+j6k2pRV7IOYOwKvZLKCKOE3vbfNMmD0QJA0dQVykZJDIJ2rGukrvZ1EB+egdCK+AU36VsKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qgjWqiQg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eb7f0b9041so18568261cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761338241; x=1761943041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=qgjWqiQg7Mw0bd6Y7P3gb+spLRaKxWc55mXCg5lTEioPzr2WALPNAO9coZW5YwSU/Q
         CutOTbPQFirUB6W23YGRV/4n3KJAwDc2HuZ1vmW9vsHfhTQE1lFOzrT1zKthKJ1vN7w8
         J99nIJOu6f1vbKH/VbY6iGK7SaV9bmoiquLKjhFMYlujpJGyyVA8Y6ikqLPzjJZE3K4u
         OZgIq3WLWE0V48aNTFEFsT8fugi2BJ4QfjAxzSnSHsv/2yqeA/JFfFAvF5Jn45VPjnM2
         VbQo5z+uEOp/ZfIDudxeAtIZujmHqqIYhpz5spR8VsG3LNndPL57lSFQQ4mQS3eRwY0J
         boJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338241; x=1761943041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn4hQEcGul2fUa7R/OzGXx8vWTt9TjtrdGmgBs4cZEg=;
        b=ZAY9kNdAhWIq+CFpVEhtnbjE3TKd6/GuIFCY5ic5VZ2jfn/vPCE2sMu+Wo6NJA00wa
         ExTxT5mNNwClyQ47j3GSs+TBQnyBSTv50TqlwtftOrTTI0QMUxqpBH2gHDvby178iscR
         PjUgPzEnPjHlj1jamiIMKwwxlyzGJ6DKQnx1DNo13dxS69gk64hmNEXQ+eKMqnpGmBA2
         a0z/AFdjmJx01+4nEe2aNLJJdKqsOjB3wNvQYpusJ1CGQSLoRpJ6OIOHL3G6HQEUQH1w
         BKKrWwWmiIaWbjTMOJ3o1WlX8Ycn9AdgjQfsEFZepeF81SVrjiU9723CHXpJ1xU0BDp1
         BXUA==
X-Forwarded-Encrypted: i=1; AJvYcCVXWlz4ykKaQDR4v0eLjaep3l+tJWiZjtoO6y0fq/zrGGgkmrItrzSekmMdGsgNCAWJQbkn1aJBw8b7ZVCU@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAV1Sp51OFccKonmdET8tIIlXjBr+6Sv59cXsMzqrZWCrAwVc
	4w2suZCrh2ghVf1BKzzE+nSsNy0c1R7Le0JYjyc914thq9P0kYsicxLuY+hLUfsocII=
X-Gm-Gg: ASbGnctmoH6xNTeyVzHkxWQ7gX0ZGh3PtNGIX5FwDS3qdZ3NLu195Mu8DDMHFNV/ytp
	83FxnMjcDQ553Jg+PogPd6aHHcXJdiJd2jr595gFCxq3FH+CAvUX93s6ERlqDvqZz19fOOa557A
	y+0qJeZmblCRvguorgGGi28Fnv8DhaYEKRniS3agFUobjx111oOAIefSgLGw5CFxkuq/Lg2f6qP
	gwNw5jpcp0EnNi1KAkat2cALYs+AhtNCN52xfX+hGDx/tLITkUL4ikVWgzlBqhW9zhX0yOF9dM/
	4LMvI/NLxZbjjrJQQW1VAtv8nYVJUYarqCDcggLRSrQGGwM5rY+zP/o9sAqA9dRQlH8V7JpOQ29
	RjbOOI+NZ0hg2wJ8c8R+6K7j1g22R6HTf/DnILbokvAQ9cwPfoxP0GNruw4jfEeemBPyv98YU4/
	USnugByI+0Lra7OmmwHip8wDDcaCUKeSnTFhy/49uEg1CVyeuqgG/kwVTLphx9HR2F3E01OA==
X-Google-Smtp-Source: AGHT+IEizsVD5MWKlpznZSR+oUAoDamQsr5IFux8tgX6jFrLAoh3hAikSuRK1/9hfCiWycXsqW7SdA==
X-Received: by 2002:ac8:58d6:0:b0:4e8:8ed7:da6a with SMTP id d75a77b69052e-4e89d20680bmr359946041cf.8.1761338241380;
        Fri, 24 Oct 2025 13:37:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37b96d0sm861481cf.6.2025.10.24.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:37:20 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:37:18 -0400
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
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>

On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> 
> So maybe actually that isn't too bad of an idea...
> 
> Could also be
> 
> nonpresent_or_swap_t but that's kinda icky...

clearly we need:

union {
	swp_entry_t swap;
	nonpresent_entry_t np;
	pony_entry_t pony;
	plum_emtry_t beer;
} leaf_entry_t;

with

leaf_type whats_that_pte(leaf_entry_t);

with 20 more new functions about how to manage leaf_entries ;]

no not seriously, please have a good weekend!

and thanks again for doing this!
~Gregory

