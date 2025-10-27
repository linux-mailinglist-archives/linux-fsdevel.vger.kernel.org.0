Return-Path: <linux-fsdevel+bounces-65739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB078C0F5FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41D2734F78B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8943128DA;
	Mon, 27 Oct 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BSCrR+pG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAC2D248E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583134; cv=none; b=pBDI3q3eLkEy/V72iB/8GGK2bX6MAHRZg3+x38zsjeUxHfJGlx33grhtacu9sgoo/mmD2yCDsQPF9U2q+fuelsuy8y1azeZcGq7NjhavcFzLWKNPjt4yfxDkGxFTpnwAOhnRX+bs8zPITSAVHpYhmQpChDArjENb0AJpTnr3Dws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583134; c=relaxed/simple;
	bh=nAhmUlr/hO6AGJs14F5PTgWNTU6mEzb9QsSufy3So/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLdFE/msjNfVMgOE1/ZESClD6Bm6KaHLXDnsSMj0Yo8XuDZPcuMlBb5Lb1ghgFt7E2m6gGE7qWA9H4k6Gq1GOsm1fCJUSlNP2wIJjoZC6pZuv4dRrqOez2CPUoX5of71VDONoVhlK6LLB8Lq+ZS2mqmMhMFunUydYbUr0fODjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BSCrR+pG; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8a1744d9b8fso298832585a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761583132; x=1762187932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2HGwzd/4lzqDYF3XkN+FOghRP60HTqO9KJmTXVpNDU=;
        b=BSCrR+pG+Y7/saGJaQX20uzc1Qo1+qKSDQNhfe3Jq5mp2ZVIuA1AfXqrkKMasdFzmW
         7Qx+hR79rqhMBQVyg3XVENRsHeiXAbOlGwuG8YjTI4x6f+K86y+AUpDV6/Dwg0/i7ua4
         dtX3BNjxD8vykbbF2cTq0jAEukuu2uPSRi4AnTxPKyd/oeBEMaEjFTSYhZWoGLnpeRyS
         RilIGepkRXt83NIzS1lFthelm2vYj9pSCBbeq7bWvbUbmksj5tBICCrCnngGIpRRkGPd
         xDPc57+tG5kSN+8jOfsZ+gwtFsIILrsnYXvwMFI43BJ1Ux4gumpj4AIgWoy/kGuTDcHp
         lqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583132; x=1762187932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2HGwzd/4lzqDYF3XkN+FOghRP60HTqO9KJmTXVpNDU=;
        b=LCOC/9GwheALPn83OzNdOS8Q9bnfyQw5C70s1ZWcILh56j5jQq5NMNrruzWw3OfCPb
         78B3YSFm3KjNVlQLPu0UQzqA0Zg7VUNKbYyu8/dMC/SW+ksiZG/tibeVre8szdMLnwd0
         DYH6Xq6PTVjnPrAejSuXtJUL9vhYZVxGbhRY3528CxJJacqAuSp00gjdCk7W5Yu4iuqk
         VG3AeLr0AChrGiQL0wKRL88ZuCWbx2f1RlppSLEn5YRd49oqBjsPgdPmishUSNeXYpXR
         nfHrKitqh4eR077r66ooBd0F+ahruuLwEx0QxGRaoZgyRCf7TKNdydNBvVuyXzLwIkJK
         V0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXfPjkXBtYCE5yuuWEzA99TdQZWSX4npJmojMucnHE4KgQ1xFW2YDsP1zlVqrBT8poS8HFU44xZLE74H0Vo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyls+jHGzdr2zBJUSODgzpET8KJnYBaEfme3DGsxtmsYtIeqqwr
	WTHUyA7DPjyE4Z2XjQyf5zS3iOCs/1Rq3VQjv6kGOA7TVM18SuA1f+tXOW/9oSDerJY=
X-Gm-Gg: ASbGncu4mYbW+IYNxqJWou385qmtLlawRNEBpGG7pBpcJQH+jHZPId9fgmft1Xu7cW9
	SXk7t9UkhpKaFNIMW8DuU4Qv66W/jYjNFFzX+rw9g+cgMHOkfco9R5Lxi5A6pl/qfE/05Jo/MkT
	LArbAQm4UzMPnV5AQmngETceqCq/u7Nq1IS1J9Y89wNO8xdXhMT+eMthtRJ0hTIvbE6evFOXOIX
	Dc1TwFoML+WdVKfDkC+oxxHbK+wpAK7WEXVVAv7fvi5WMDZkavfIljv5zREXnZbElXKPrXlS1zM
	qEoKohxCvA7qkC2a1g3ysbWbi87vUmPJOzPwzcwxp1u6uYtWDD7tSnwVyN60mbsndEFMKb76a8D
	LEGJeU8rjCihZuHBpykVmaPDl2eh1JaMO/JbMAFvXrin40VaEhi2FuRmo697QpkBWqbcXU8g1j/
	8qcYV0hPcvPcaDcfCLWYPcWav25Nryx2BAnWqcsYZ9xmKNr09SSVi3l6qo/rxPGQtuaSBFyA==
X-Google-Smtp-Source: AGHT+IE8OFT35MTx0jxBdZigqHGpIP25NqCfl0+l6c8fCefLdIH0hfSup7UdNhOGnYzqPJc4qxyLmA==
X-Received: by 2002:a05:620a:711c:b0:892:636a:5675 with SMTP id af79cd13be357-8a6f704a25amr58519385a.58.1761583131221;
        Mon, 27 Oct 2025 09:38:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25798afesm626595985a.37.2025.10.27.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:38:50 -0700 (PDT)
Date: Mon, 27 Oct 2025 12:38:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <aP-gGKMa6Rcw6ZWH@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
 <20251027161146.GG760669@ziepe.ca>
 <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a5ea4e-155c-40d1-87d7-e27e98b4871d@lucifer.local>

On Mon, Oct 27, 2025 at 04:26:54PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 27, 2025 at 01:11:46PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 24, 2025 at 04:37:18PM -0400, Gregory Price wrote:
> > > On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> > > > On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> > > >
> > > > So maybe actually that isn't too bad of an idea...
> > > >
> > > > Could also be
> > > >
> > > > nonpresent_or_swap_t but that's kinda icky...
> > >
> > > clearly we need:
> > >
> > > union {
> > > 	swp_entry_t swap;
> > > 	nonpresent_entry_t np;
> > > 	pony_entry_t pony;
> > > 	plum_emtry_t beer;
> > > } leaf_entry_t;
> 
> I think Greg meant this as a joke [correct me if wrong] :) that was my
> impression anyway (see original end of email...)
>
> I like leaf_entry_t name-wise.
> 
> I don't love the union.
>

The union was definitely a joke - see `plum_entry_t beer`

There definitely shouldn't be enough extensions to warrant a union here,
that seems like negative value.

leaf_entry_t naming replacing swp_entry_t seems reasonable since that's
basically all swp_entry_t is in its current form - even according to the
this set's cover letter:

```
  There's an established convention in the kernel that we treat leaf page
  tables (so far at the PTE, PMD level) as containing 'swap entries' should
  they be neither empty (i.e. p**_none() evaluating true) nor present
  (i.e. p**_present() evaluating true).
```

~Gregory

