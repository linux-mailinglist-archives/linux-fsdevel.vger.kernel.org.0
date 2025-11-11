Return-Path: <linux-fsdevel+bounces-67792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84446C4B705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 05:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B813BA880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 04:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3134AB14;
	Tue, 11 Nov 2025 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCjZOCu0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBD34AAFB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834073; cv=none; b=I0D9aDJr2/NoaoZtMQNQUhrGv8eBrHhrr7NfOffKS67AfvzT63gLOpeyb1yezuweJ4CRGp3deFgeTEivKpEGjLj3uNK1i7VCocFhXUIkMABlJd3lq5mruhsM/RFOLYhFVFijA0L5tUBQHlXWm6FT1lvI/wJng1NLsMw+l88TuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834073; c=relaxed/simple;
	bh=sDNd3xKtQvuFQAbxJpzalFUBsuOA54Wttu1ZWggpyB4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XnYc95nbJqz8YWnrCPeWemL0ZUH2uBLrz6BZAmUTQ/7zNX4s2R1dLt3tcFmoAiM5CjiAbhvLe/upBZEn6HTtXPorKPafyKJ5uCzgLfcfKMkPK++IanNPOYc8fOIwNCaoAvsS6jp2vdiMWi60HVoa4ZaZpjhtA09SUn/yV/Sa4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCjZOCu0; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f97c4eccaso3497111d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 20:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762834070; x=1763438870; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQtvX2XQ8t15gjBEKpXNNs3ZpjZjdksPbAQ0ahr9C3A=;
        b=zCjZOCu0BeaWv5mb2hY4SDz/t/r4SViDFuaciRkffcF0F/xBEeI/T3/p/dEew7Yt7s
         kO7tISPHZT4t0insBD2ax0ZrTu4EFmGMp+tI8kx8EsxldNoE5ozgxQUndJBQ/SAYuyrj
         6DAGXYBXWTlqfKcGb6xdEtFUARPosxO6VWBu839ymHxPQjg4Tp50Yn9TCsrE6lNQ5fjQ
         pN6DmgNoDU3YIF518O4A9B0KBp+stmwFhyUQOrmGpOBihtWOfsutNF+oHmBLmVvqZEVt
         IwR0ZfkDT879st2KmK5QYHt/npvji/lpm3/mq8mJqXO0nZ4t+j4cBUIAN5YB+mDPuKZn
         /6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762834070; x=1763438870;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQtvX2XQ8t15gjBEKpXNNs3ZpjZjdksPbAQ0ahr9C3A=;
        b=ZOqJCLgkOd6HuTh8goKqsJQwaMnVWG9q4HvaToGbqVRfZKVIW4vdSU33xyDhYWOifY
         eNKeQ4D3uHMScCDv9PtmDPTcuZZUct2gt4i4yO53X1IIgJ4GD/W7ZrXrHJe/oQ+Dc1QZ
         4fp+IAFyBhnHpPsc1qS1hRQTvDkai2goFmXNFiAIlotG0pf2610PWg50ZVeh/1eMx5xl
         7pZjaDmk5KXO6+BApWGzgrqqEJqULkSq2Q6+fMF1ab/YDYKNPyi0PY00iKQJPxCtJHGN
         7ZhqNUkZVoeKa/N0gl0eVJbHKyxNl3j8eLXxXqH5Vkh6pSIvU9vnZMsfp7yaf/7hN4Eh
         2JAA==
X-Forwarded-Encrypted: i=1; AJvYcCWFzQBcIJr7gnAOriIf1ESB2nhVCeI4X2HSh/iG2GKZa28Oot2gYVkbwtG3tUeFQl364SvLTEEtOsd4X7ai@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJokjRcxNYxmnr0xIohMmFuSvcp4rcoYZVNx4rXTsErl5HfdX
	AomwBwCAKypqEjkzj993PuO7PCu7uraMrC1jbaXdF5EtJLvyl0KhpeP2dcN7WLzvHQ==
X-Gm-Gg: ASbGncuVEg6cHP2C8QzsZIRC69+rBHSbh20S9X4y3TXZGkRteFmslYhXxPfWPEUqcTP
	WqE0gev+2u2rK9Foop7/5m/IlzuoTaq+HbPmguo8nmPJL7BjWypwm1cCqgotGsxGIxrgLy+1W+b
	1UzqyJwVucyEOYx5RNOp+FA4HM2iRZ4Fc0bOCRWlO5TFW3uLNiDCS6DC+Hrz/GPlLzpBLB0mhlb
	g+QqT9cobWZP5AdvnbU95RjNjd8637hmsAYGlZHSpsOVQvsbJSiH1DgoN3aP1BX+S2lnp1aygOf
	8RAI1YnM3LM4DB//Z6KG7ODBi6Ye1M9qW8dhao3YHOO1ubkwfMye5AMftpy1ZJarUeDjRg+y2E9
	XueIKccvfEbXC/8VqItBXZ6rV/XrWVKei8B0K1MgISQrXujBa54f79pSGA3y7tjNOeTeXI+yv9x
	6RYSBcA+v+MwxHx0JDYS9uIfW45Lj9vsTeT1sGj265q8Uf7CFGcb88A/q0+5xv5q8KfTi+pLPf0
	rVWgvXGow==
X-Google-Smtp-Source: AGHT+IHG/jZ//4QM4bUIX92EmnHpoMxramdxwXCxkW843uk4feMGQ0nNfJGMFAqbmmzMPaRjaD7rEg==
X-Received: by 2002:a05:690e:d47:b0:640:e6aa:b2bf with SMTP id 956f58d0204a3-640e6aab4e1mr5979840d50.43.1762834070176;
        Mon, 10 Nov 2025 20:07:50 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640d2d68bf0sm3436465d50.11.2025.11.10.20.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 20:07:49 -0800 (PST)
Date: Mon, 10 Nov 2025 20:07:34 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Janosch Frank <frankja@linux.ibm.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@redhat.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
    Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
    Michal Hocko <mhocko@suse.com>, Matthew Brost <matthew.brost@intel.com>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
    Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
    Ying Huang <ying.huang@linux.alibaba.com>, 
    Alistair Popple <apopple@nvidia.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
    Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
    SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
    Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
    Naoya Horiguchi <nao.horiguchi@gmail.com>, 
    Pedro Falcato <pfalcato@suse.de>, 
    Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
In-Reply-To: <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
Message-ID: <ba5d8603-4140-1678-b2d5-d49ab1a40fe0@google.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com> <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com> <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local> <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com> <20251110162313.baee36f4815b3aeb3f12921e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Andrew Morton wrote:
> On Mon, 10 Nov 2025 15:38:55 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:
> 
> > > I'm sorry but this is not a reasonable request. I am being as empathetic and
> > > kind as I can be here, but this series is proceeding without arbitrary delay.
> > > 
> > > I will do everything I can to accommodate any concerns or issues you may have
> > > here _within reason_ :)
> > 
> > But Lorenzo, have you even tested your series properly yet, with
> > swapping and folio migration and huge pages and tmpfs under load?
> > Please do.
> > 
> > I haven't had time to bisect yet, maybe there's nothing more needed
> > than a one-liner fix somewhere; but from my experience it is not yet
> > ready for inclusion in mm and next - it stops testing other folks' work.
> > 
> > I haven't tried today's v3, but from the cover letter of differences,
> > it didn't look like much of importance is fixed since v2: which
> > (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,
> > not seen with v1, and probably not really serious) soon hits an Oops
> > or a BUG or something (as v1 did) - I don't have any logs or notes
> > to give yet, just forewarning before pursuing later in the day.
> > 
> > If you think v3 has fixed real crashes under load, please say so:
> > otherwise, I doubt it's worth Andrew hurrying to replace v2 by v3.
> 
> Oh.  Thanks.  I'll move the v3 series into mm-new for now.

Lorenzo, I can happily apologize: the v3 series in mm-everything-
2025-11-11-01-20 is a big improvement over v2 and v1, it is showing
none of the bad behaviours I saw with those.  I've not searched or
compared for what actually fixed those symptoms (though have now
spotted mails from Shivank and Kairui regarding 3ffffffffffff),
I'm content now to move on to unrelated work...

Thanks,
Hugh

