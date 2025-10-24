Return-Path: <linux-fsdevel+bounces-65571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E711C07DA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A394E2E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD6357A38;
	Fri, 24 Oct 2025 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="djkYqlQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEBC3557E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333134; cv=none; b=W1zwosurU0BRaf6bwy0VaM53uVeZw3Kj1rMKlB+NHZDYNkEDd0Yo6JDFLH1NOBV9O78gc7L4hkg4aDasCOP/APd8PxAODVQt/UMDBfHif++2ehGuY2adKZ1ztChEvu+Vdd6/wFfAH312zxnEh3TDMVu/1CpAlRVPHQEtAuqvzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333134; c=relaxed/simple;
	bh=1HPzzMYQqxXuYn0hH8eWdbKEvenGvJhB7Md6BvkK5BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSxFnF8hiTUWdhjEtHswDQepfmLyboyLr7TfQvktHdTU/Nyw9wq2Lp6m4EEQpB+E6eOzHR8kaR5wbighVhwMTJOX5QoanMlIRRDUk00O8hy5o937ENuvg9s7nhx2m2deq9pah4Vn71rEND/JZ7tTeddHB+wfYukyfjahE/ksYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=djkYqlQ2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89e7a7e0256so69994285a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761333132; x=1761937932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCR40IXSwb8+XBgjln+OQr+nWcDb8wZGch2v8uE7uTg=;
        b=djkYqlQ2uBE1MVPYP1auCvtzMJ0Wu2EtdfpvkXLGD90SupS9f9s9/4rdKlaMhfEJox
         DX/90A+NeF8nW1jkcJ3QJFRXNWojxQIuy6d97DSYvgLqJLVlDYpn0GN6Fo0WgvyM4pH8
         Do0eRekndgYnh3AbtIMo0dTPH5EaHXWzEFzHMt3jiqHF5oFC2dS27VmhFEggEA5KM5xM
         B5BT2gQH81z4fIfWm8uW8m/1Id4k3mjfbTaD9gvQUr+TESeom1DF+ui2wUjr/CgaY4+P
         T16BZt1efnbfpsmkhUb4PW6+F3Fh55DVIgQNJJeehyKgzH6KB2UkkUuOSU0AjqDlm1V6
         ebqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333132; x=1761937932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCR40IXSwb8+XBgjln+OQr+nWcDb8wZGch2v8uE7uTg=;
        b=T2gjOqeFS32D5U9GtB0gG9YSG8igM5shmbowh1/f2oJ7V7+LuuQT6CIsiTAp3X2sPF
         /E+ffwp1/kUV0fjaQAEHjXGtjRXruF5Qo9zZkC/1XRVhyZmShe6ItD9Upubhi511U7Av
         t2i2IYqXGgsBct44QQRTri5rnJplWTI0+wbZ+I3y37t6uk5WxFvn6pTPcEZjqp+TWrm9
         cu9iRWrJZk/FQrrB1l1r79N3szTcPdhWEGrXsgaImOzk1bec2LX0arcW6Pmu2Ej40JK3
         GvdMjV8gYInhsDtklFFfVJ8jcHsINBlcv/2UQpansU+WMpw6Qp4AoQuPo3V+ZoViZiYu
         no6A==
X-Forwarded-Encrypted: i=1; AJvYcCWqlTP6TDd+z7ugGSC0mYOLBEFtBIHBr6w2NNuwt8JI6m6gp+rVwpCmz1KgKMZNE1aLTOMraiXhchgLdm4e@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOeDpzi1lI/dt/9ivel/NcIiKFN05xknvzMJ4RQADPug0LhBJ
	kqKpIMAp/SSqwygV0NDaR1Ipo7kWZyU8lEXon3WqgSLsARSBHUjHyTW5clRsEc8VDCI=
X-Gm-Gg: ASbGncsjitKsSDf2yDAcQ5VkXtYC8N12Gu/Mwftr3xSUdCqKnaUaC1lZ3C4+dgiggQP
	WxQeIJUwLcSA8OuXSIrhXvOSXJj9GaAhme2rVmR8TBXOZ3dEIGlZolRk779i+iGRjW7YmkGNU/j
	iXMv108WzaOqioM5ecvba5Le1+wasdHqywtLk4BFR58zMfSMZkIdT9wr+9wnwKl6LeCjeqthEKW
	mCTn4iz9jYeaHXjFh5uXva+tm5mtPB+qvephos3VNMTYhi1FvpXKYTU4Ok3ITp9xGcprmdcGXrd
	MCKqrMLeIcvlcOyYsf6NrGV5T8oCvZuBcybFBTtAYSbNiHOY6A7IZtcBIQessxXTgxxCg5OPEB1
	5KZ/qt/ODTqijJc7j+VT6b5BVXFkGu02755phuVvqc6y4xD6+ifYTSaZmiP0ciqvhdf08dfaEid
	7kRp0RqeryBBD5kSCTWw3XekPxTLGV9nJLZ+pld70Gknk16bYx9znB/rt4BVM=
X-Google-Smtp-Source: AGHT+IE/iLPq0l1+7yrz/BbyhVyC9k5N0OQCI/Q9HFSHISzKMdQEsDIOj6nKXRkCdZrjDczCxThRnw==
X-Received: by 2002:a05:620a:178c:b0:892:eb85:53cd with SMTP id af79cd13be357-892eb855743mr2482012485a.42.1761333131934;
        Fri, 24 Oct 2025 12:12:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eb805e0869sm40330861cf.1.2025.10.24.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:12:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:12:08 -0400
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
Message-ID: <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>

On Fri, Oct 24, 2025 at 07:19:11PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 01:32:29PM -0400, Gregory Price wrote:
> 
> A next step will be to at least rename swp_entry_t to something else, because
> every last remnant of this 'swap entries but not really' needs to be dealt
> with...
>

hah, was just complaining about this on the other patch.

ptleaf_entry_t?

:shrug:

keep fighting the good fight
~Gregory

