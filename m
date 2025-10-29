Return-Path: <linux-fsdevel+bounces-66309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D3C1B377
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6486E1EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFC24467E;
	Wed, 29 Oct 2025 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XtYF3cBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F291CF5C6
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747053; cv=none; b=FUreAH+Sb1XdRXM6PMs+N1JnhPJUBtTpGOO4XhoPccplmzm4deiORRCbECBN2UyY2U627zRxJK+lUofDx2x2VhVAxH3wgC/8erDSC4rLNgiWSIi5fHpKqmOmDwJhlclL0Nahp93xXKccq9rkhbobyA6230tf1wRBy2NyNv8LsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747053; c=relaxed/simple;
	bh=FtkXBRR1i74hdYvMHxT8SXn72fikHIr5QYRX/FKzjvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ranJotoDOxFfz/aHh1pmf9EZboNypt+HNKDUfpqVUY4OOpbmwgjcNqIBONj+YyzMEYnWWBtVsy9IeS04g+wZkX8sEE5U6lr9L6PNdfwlSsIpw9rgy20nn5hdGF2v9GViepuWdp2ASfs6nNtWzvtw6CZ925uqCDD+aGCBCBksyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XtYF3cBQ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-87c1a760df5so100838146d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761747050; x=1762351850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gCBuq56/59adr8Ol0O4W3+IsGMOD3y6s+9TcTsiPOY=;
        b=XtYF3cBQ/iUolTaq0Qh4Wu/3nUIzHeTXQKWw3P1uEJ7RX5J/q+NHSZ90s2g+2F7tak
         5b0nlI5yabJThUBrmRjLTa1MrbtK2boO52QUqXpoG6pvXqItN1ByTDfFCk4wvSnbwVII
         UHKzqgWf/eR154V2f2iL1FBzr4RYaiE8Nxtrvpdwrlak7AmslIVYFSHLhJwSPdN0tmSU
         qUi6Iy2fUwbuXQPhaIkM/RLKVJXdsQOuUjUZZqz2Dy/XIrEkzLae8amIgt4NXfgy2Lnj
         AVKHykL6FOst8ffgc7l9mWVm9m8WEj3JTFjJAAE/YvzZmx03GvBm0xnVYzF5tmSl4PLV
         V6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747050; x=1762351850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gCBuq56/59adr8Ol0O4W3+IsGMOD3y6s+9TcTsiPOY=;
        b=Qx+c/Re+pVdK5Vwn5OE6d2scie+ZBffEBleN25tlmM3WazLQ6yWhO7p5eU90LyBo4U
         DKDo1B+tpI3EEhsGVwmeViBZMbmJOqE93Vj1d70b8kCvv7Hk0oFo7pcEFO7IkkM1wHe0
         iT8UyoGzxFYsfpTI3vYTXIQUYwA/hibHt6ZIuV6zKCVYWFCHGzMD4zK9zAcYSrgrQp3a
         68abxq98bUKvIFJfjce4jBGhl3gFhWrbuhkND4zrnGR3GQ7EvwDxXN3/D8GIbAOk+XYr
         mTWz1yaEzk+DAjNm3pPqpyvHCDWxH/G5faZ0jz3XARLU7MmgDdbYDVDruHmQa25zxVDM
         nrwA==
X-Forwarded-Encrypted: i=1; AJvYcCWAeiKfWLXisUsmijGRzAKpfNkEDsXCZPe+zWNWHt2CP6rlTJvaudzSDTAlEi+S1jEfdSG6dsYgAu6nR+SJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63SXgU9InvcFSxqFoNXrDbQnhPu3EJj66FaTIf606b3W18303
	6EQcMl6NaHawn7ndhqYTASvfwapZirK9prVBhHUp845YJ0lXIXBvmFMEwOZ/gmxUWI8=
X-Gm-Gg: ASbGncszAq+cuI5jK+m/nKXQc0v5X8iHzajBmbNCnkqjwzouwg5sy3tbBQ+hkrtZz22
	qC3F/KubJCGIdV2OADKKF8mRk8fXIGIMTXh7BjPrjG9ZpcFTeRd3HHOYRjQE8f/xL4nBO6iupZL
	mYqjxevFAq8eCnr2kcDys39zYsg6PoPF0NXw82zLPfOu329uWvx5kdgQGqj3iIqw6+tZilYk+Qx
	w2ZRPoBRIFBKXBq5/Wa3sU6Lr9EYt+kLEvSlZx/3jH9mH1paj6pk4v0JX5GfynJzJJpzoSLwIRu
	XLLnIZj4Dcz5Ogmcd1E8UPLl9QysskSe9PDAQ/m+0S2/NrptDTTpQNWgTZ/cUu27r5wPuOgYG5l
	LEw6FZVpF4KRGaafKqiRNuZX+zT17cb3gZCcj7eLW89RQRODbCXx2QOCFQsN5E+QtDhIhCv8dql
	M5b3g8J0dnKaDsK5E1VYpBrV7aRh+ITVUR3EAntgCZjHk08GhMirKeWYBP
X-Google-Smtp-Source: AGHT+IFN9EEFBAzfjpvQnmAHpqKEJbqdqdrZ9KL1PtSYGMem5wdE9qnodevFJl+GDHD76k8KE97qmg==
X-Received: by 2002:a05:6214:23cb:b0:70d:fa79:baf0 with SMTP id 6a1803df08f44-88009be5c01mr41077486d6.38.1761747050399;
        Wed, 29 Oct 2025 07:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc494ab16sm98679066d6.39.2025.10.29.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:10:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE6sy-00000004etU-2Jns;
	Wed, 29 Oct 2025 11:10:48 -0300
Date: Wed, 29 Oct 2025 11:10:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <20251029141048.GN760669@ziepe.ca>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
 <8d4da271-472b-4a32-9e51-3ff4d8c2e232@lucifer.local>
 <20251028124817.GH760669@ziepe.ca>
 <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce71f42f-e80d-4bae-9b8d-d09fe8bd1527@lucifer.local>

On Tue, Oct 28, 2025 at 06:20:54PM +0000, Lorenzo Stoakes wrote:
> > > And use the new type right away.
> >
> > Then the followup series is cleaning away swap_entry_t as a name.
> 
> OK so you're good with the typedef? This would be quite nice actually as we
> could then use leaf_entry_t in all the core leafent_xxx() logic ahead of
> time and reduce confusion _there_ and effectively document that swp_entry_t
> is just badly named.

Yeah, I think so, a commit message explaining it is temporary and a
future series will mechanically rename it away and this is
preparation.

> I mean I'm not so sure that's all that useful, you often want to skip over
> things that are 'none' entries without doing this conversion.

Maybe go directly from a pte to the leaf entry type for this check?

#define __swp_type(x) ((x).val >> (64 - SWP_TYPE_BITS))

That's basically free on most arches..

> We could use the concept of 'none is an empty leaf_entry_t' more thoroughly
> internally in functions though.
> 
> I will see what I can do.

Sure, maybe something works out

Though if we want to keep them seperate then maybe pte_is_leafent() is
the right name for pte_none(). Reads so much better like this:

if (pte_is_leafent(pte)) {
    leafent_t leaf = leafent_from_pte(pte)

     if (leafent_is_swap(leaf)) {..}
}

> > Then this:
> >
> >   pmd_is_present_or_leafent(pmd)
> 
> A PMD can be present and contain an entry pointing at a PTE table so I'm
> not sure that helps... naming is hard :)

pmd_is_leaf_or_leafent()

In the PTE API we are calling present entries that are address, not
tables, leafs.

Jason

