Return-Path: <linux-fsdevel+bounces-65570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA3C07D9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2F4E3C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B1357A37;
	Fri, 24 Oct 2025 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YvjFzXO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04834B424
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333004; cv=none; b=dIqGqlJaof68rz7g4I10zkhsito9BjDjn/iWOu/EFrYAn43HSURcU5BknC60BfI8ATkG+gDP7IYLrnUqOQSGKlizXcYCi8oAl4wUWGsT5WPtPRL3ab50yxzJ7wQPb3NdyUsj1ZOWuijDJ62C3XDi9z+ElaEg0WvTzbGJWREXnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333004; c=relaxed/simple;
	bh=eOV8n3GyeI7NGmNQOPYmpec1MI+qOKDL2up+UvX3whg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTNOWVsL6fUz7oYLjsat5V5YpNHgtNYP6pGlFUNiOISOOBBVb5PyNP1PDq686Ay7ckuZYLL/IrBGn3n9BFO8WhRycioTHGLlywFk7KLB70lZzzpfcEaeynERDZakG5AwBHP8T2HwL7Y0HgvFAvgNPa/sXNOvqRd40Xno9Mpr52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YvjFzXO0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-89ed2ee35bbso44839785a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761333000; x=1761937800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=YvjFzXO0J6h2ss5Sjx0x/YOHwNaZ4Tm+e+WqDpFH9ACMNz46aWXSiaQsQwolqekzQO
         2buiBh7TWFig/XGHuU8xyyyCnwtmRTYFFY45EsAZmWULSomAfW1N2sgkiqXHUoHo6QTR
         7CZ5LqV7OgWZGlcGb5jecQPrBWfpBrrsKfEN6nhZgnr0/mzyWb95v2Aoqltu98hD3TZk
         IOG5fzcgJua53NNBnVpecM0fDkXU6wkdxKPJBexBF6Z3DCRjfkWDwMDZqWSMFu5PvSkZ
         K75yKN3CZw31D88pNNMrUcdvvRHb3zV1rkpRutMPmDiSN1YLdM+henQF42C8jPnce2uU
         k2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333000; x=1761937800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=dfAL0BCt2MpdjXn+bGzNUhtiJ33s6BOUyqPaqO41LLQcuLIJQ2sqMqfPyXAxdhxtF9
         1DH9I4icLq5ASKu8/jS+GSad1LtuZuk9Xt9DQXe2jlJnFTwrMkpC1/CyLzX8nxNz3vyp
         XQ5QeMyJY2RfEPSK3Yu56mRvLmmpXZ84JQDX7Zf7FzHYYfJIvkz1Xgq9tQTaccFUJ1Wn
         +kZdlxnysWex71v6PPLD+3LENaTl7pA2wvKuFFG1ycVd4vm+zYUTRTQk+YOBO4pW2OTG
         kWny4XZL6P07H1oagv4WnJCW1DEER2UUe88fqT+hapnGAgqyFqXR9+DFUHUNPdPfSuEC
         0hyw==
X-Forwarded-Encrypted: i=1; AJvYcCWVKpTcFaBu80Snq2HelGAIVn0Z8yJkZqX0vCNVvmj64NT5ByBhhzXr6lPcJ7QlGyQPKr1rrjsRUWUbieWO@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGQqrZx1mq+NtOzygvcgRGFRbCKKhExC5YASl2XtBExzzA9I/
	9Wyb32vR2HZ/ridx62xRbtDB63ObUVg+TdzA9an6rj8BDHqypU5Ped9dmCbzzisMTxY=
X-Gm-Gg: ASbGnctTeGQvL0nhCv20sqna2b/Hixxy3JAgZOLoljhG3SduN3Joc7GbkW08mme/rmr
	Kp5/f/xh3gptP/pu725h8tskTqQT6gaQr6yRfrkyWF3Mei5WOmdxAkJj5dl9qDWGoacziPrj6IL
	ogbxrSKSxtwjW/d5heAve/l/SpknDY4+/BjInsqsGZIyWkXkzlL17dWaBmv7T0SdDQcHpIjXInv
	rh75Ds3PFQjRxYRefjSGmvxHCAUtSra/WXqhBRCI+G78aI9iGo5FMjYzOUrn9yyL/+N6Lsvz6dp
	P4QsqebSNDgzSUnD+yb3zzZX1IYfblAJt0u3WaDT0Dzpg6KYMZdbFVUBU9q7woULSNE/7DQPKy2
	mEGL17aFE3kmBlXCs5SM54P/C8cXQf5v39WW84un+xflSGZjOvKX+qczlfu2RFRFirAkzi/vykl
	uRjRGv8OHEmvGy0jmCm2Ic5SngwAoHLh8MQ/7QM37/Twq7JdjzcIFP7ZQJz88=
X-Google-Smtp-Source: AGHT+IHrkcPaJLyTM5pJbJ/XVcfel+4u6gv+3P752b0IEbbyKeVVUPlOZ4xL4VMnAte1FxD358/CqA==
X-Received: by 2002:a05:620a:40c4:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-8907011583dmr3539276185a.46.1761333000331;
        Fri, 24 Oct 2025 12:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11e631e4sm442634485a.44.2025.10.24.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:09:59 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:09:57 -0400
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
Message-ID: <aPvPBS5H0E9OXEo1@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
 <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>

On Fri, Oct 24, 2025 at 07:44:41PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 02:41:02PM -0400, Gregory Price wrote:
> 
> You can see it's equivalent except we rely on compiler removing dead code when
> we use thp_migration_supported() obviously (which is fine)
> 

derp - disregard.  End of the day friday is probably not the time to
be doing core patch reviews :P.

Cheers,
~Gregory

