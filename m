Return-Path: <linux-fsdevel+bounces-65810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FF3C1211B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F463AF31D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F932E72F;
	Mon, 27 Oct 2025 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XPfEVKpA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774142F0C6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607984; cv=none; b=jKOQbeFpgt4XtRhJaDohJogrWQVMOh5sV2XICpXS9qXvXhfJoFCoVYCNpjfOMOz88uJXTsjwGKHnAQZla+hThxrTNQN5vFcT798Y1plJXkBmMu/1X3BEZR82U41fl7Kvmo3UCvyms1/m+M9DV9IGg7YqYLsOPWDTG5fan2X+fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607984; c=relaxed/simple;
	bh=ya34dnXBkVMZ4acUVB749ZaVXuLYyX25Ei5hDiCldOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8U5RxEX2hNy+nhxccupXOPEjfphmu5Ea+i9qV+cZCKk/o6THrSIoCYMNRrbcpB1dO1uMC5/ZFaUX1DnkcMVxUETofXLtsBAvPW8y52JaTfezVueLe2HuoxJxPa+kLZe4qChjSGvR9wh3M/4BJ+hjawk2kYdh1mHjfaFK6kxopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XPfEVKpA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-78ea15d3489so47147896d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761607981; x=1762212781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SeBkBGZ09M3QB76OpujQtXgjWBBtrpYzqcpEmFvCTi4=;
        b=XPfEVKpAkz0EqqJlblUgrQ2PbfAJJwC+FFil/Vd5htXfHTtIAt0AcJCsl4NmBxKXRJ
         eIW5UeA7107giYfaQifJ5a/gcKAR8VZ9z0golFJy5Hb23kycJSDDiGo9zpEv9kL7Qk7s
         w7zRqTxUMrIW23T1nvKpH2c36Y7Gmc+zKGLLJpUtGCt5fPfRM1WTsbfA/tTdW9nn2aUs
         ftNj7HpeKguvAOHG0jEjFwpWYouZrm59oAzF2CNPOw8w7oeCkLSrBScDF73Fz4cxKAC8
         hjTanLd8/LkCYdg+DpDtdHCnEdUb1gxr4DzFdHDnJdW+eZ6Z/hxItchsfPdz1TLQ2R8w
         4aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607981; x=1762212781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeBkBGZ09M3QB76OpujQtXgjWBBtrpYzqcpEmFvCTi4=;
        b=aO3clH9PY8elFRFHVcX5AgDU1T72uYcW2mVuW5WuGeRq/wg1LIGKGiyr5gwaYyRkln
         SQbkT+6VpTnY02mnsUO0mBlLFF2U7eb/vcYrmaNHXei5rjNpj1ST3gBqqV1sQqnkSOCT
         F1yGayudGtXJWLlIQlW4Wj44IQuwzqt8Dt2QG1ZWvcOH7GEBls5WGNGsPIk57LG/KvbX
         wcRwsYBBfmAG6b4Rm/p3laFtuvLAcMM/H11ROTVBBWHrk+EPrTeZsJ3kbNKZFMyXHizj
         3io+qPvspgN22h59m5ALSX3FvpN0AX5kkbmu9FfShICR/+FVHsiUiSy3FEHVoBp9hsV/
         oMKA==
X-Forwarded-Encrypted: i=1; AJvYcCWsguyCsETiIc3KAjTUMWJ1vFTUvfevmG6xWprXdGiv/sQ7gSUSech4/Sg4eSRyRCinoFdobGfNofQDT+2k@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5AE5WFT4ptgjEFsI+5Bixphx+1dTqPYhVL5mb4dXi+1cLUDD
	Mplcr8uN7/FYJFZ3zYsxPAhJq6QQe70dFidUWR3M9CAh14DtR8l25qaUnMo7JD0PAEY=
X-Gm-Gg: ASbGncuR4+l+BO9byCz5iy1Bpv77Dzaff2RrBbVTgV3mdYmzKCdWnuGoxNSReG18qav
	iXdb5pS0rWKDWniStCaV/GvPypMnWk4X9nGh8/C9hUiiNtcUrfnc1jw+UCp8BqW1MZV/3/uG0Qs
	BtNpWJSxDLTnEyM4HNg4g0Irg2Bgg573F6zvfV8ryiIm0bVzzAt5+UDUk41hp30i0FFSC+k9Pw9
	DKrkY9aHQZAbXvTWAkwa3U5gWLjvanfMEcLDsbfBPwEVY16jQ+UM7on1m/GvxOZu7exm3NVC5ft
	NOuNGoMzufA1+nCajs/Z+i/8iVkt/9d6lkCm/bO2rrHvJKD3Njudx8Eyuzifa3/YV53yWFtyWbW
	SSG78PGKfsK58oqnduBSECl5mNZQnqOsKFJ6cRe0K90Iw3cm2fRhVBlyJByPkETJeHcmZU5eX9X
	A5IfonoLRMWajFmpyZdwug+uBIVxdtu8Zydqor7VVCyJ2BliDj1l6q6a/dN8M=
X-Google-Smtp-Source: AGHT+IGY0mnN3CFDP7vaLRad7aeAt7RbVIUmDhfxoFPsiCMHR/zS0q6YLuuynQuqtuF/1igQEZd8Tg==
X-Received: by 2002:ad4:5cad:0:b0:87c:2b03:c776 with SMTP id 6a1803df08f44-87ffb0f3094mr20891046d6.47.1761607981318;
        Mon, 27 Oct 2025 16:33:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48ea92fsm64277606d6.24.2025.10.27.16.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 16:33:00 -0700 (PDT)
Date: Mon, 27 Oct 2025 19:32:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <aQABKgQYfVkO7n9m@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <20251027160923.GF760669@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027160923.GF760669@ziepe.ca>

On Mon, Oct 27, 2025 at 01:09:23PM -0300, Jason Gunthorpe wrote:
> 
> I'm not keen on is_non_present_entry(), it seems confusing again.
> 

The confusion stems from `present` referring to the state of the hardware
PTE bits, instead of referring to the state of the entry.

But even if we're stuck with "non-present entry", it's still infinitely
more understandable (and teachable) than "non_swap_swap_entry".

So even if we never get to the point of replacing swp_entry_t, this is a
clear and obvious improvement.
~Gregory

