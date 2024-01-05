Return-Path: <linux-fsdevel+bounces-7482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB15825A38
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 19:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E91F27239
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455335EE1;
	Fri,  5 Jan 2024 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hxIhcJXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F173341B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4283670b6e2so9159721cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jan 2024 10:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1704479716; x=1705084516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fi0onpTGrV63R/StoJONU4NViJ6wCXVAQDgLv/SfZY=;
        b=hxIhcJXgek4kTcVU5r5+3CF9KqdBn/t/u6jPzsHHXdCK7jkTn8Knn97SZ2fEd644RA
         NIyZDsqY8mngkUqAzBkUUzBYouJK9DDlzRTpS996dSGsNIvMNmFNCA7HGlvNModSxU6h
         CmRN6dZKRCtWigNuVixZW+agv4HMEHZKFQbBx4yNyS0xxST6AvgKzIrdjEF7mXQIWjdP
         toygHEX7vDMQB821PAPOo8+xbokor2mQRlIFnrYnDtp6eu9un8hZS24QD9+htyV6oDFc
         HTsFfAPzDuShVyuvOLgIGA9LKrzrCDnhT755yYwQtcgO+jSDEmUWb1584XVyQgb26VCI
         LJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479716; x=1705084516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fi0onpTGrV63R/StoJONU4NViJ6wCXVAQDgLv/SfZY=;
        b=vRuInk2e/ewGQC69F6TDQf6G6dncB0ihx/S5qQVYNpa8V1yu/tW4yZ9socQ9TyO4Sx
         c8bsueR8UYfzijxjxT/RLtcayPOFhzIzgGliwlHa94+VN9yvhJJFlxL7GXyA/KFrSucT
         ZYdVCAN9BBCdAQZpL9nrTFGqidtjNgwBTExjbXo1PZDWj8kUYBrnVevRjKQ+nrLHZimC
         y0vXhySc9yFUUa0XCHDjKNN64ut0BggFOf1+CJzt3Pi9Z5o2BOLAz4Kn7nvaIRQcZr11
         2nIAfbcYiJhgMid8ygsIlXpHK5yHShDaztllckdYNyJAAbzpBBTmJGjOS4mc2cDp6N2b
         oXjg==
X-Gm-Message-State: AOJu0Yzna5b7XZaiQqcGytuExG0QdQeuDcxPTouzsYvkvhbZH3SU3CBL
	RetnP6fGDvxLOVpBF+YpvULzj0UuXjV6b7WdfUUhkmS0JEgbUA==
X-Google-Smtp-Source: AGHT+IHmU5qlRGVBENYOfD7z6dPji/OFPx/ITRYU+YEm9BgcGmgM+TEf6pY7gJVNIC8n1fUbK0KxIgA/D68rxuFpvLM=
X-Received: by 2002:a05:622a:148d:b0:429:760d:64da with SMTP id
 t13-20020a05622a148d00b00429760d64damr1492011qtx.19.1704479716012; Fri, 05
 Jan 2024 10:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205223118.3575485-1-souravpanda@google.com> <20231205223118.3575485-2-souravpanda@google.com>
In-Reply-To: <20231205223118.3575485-2-souravpanda@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 5 Jan 2024 13:34:39 -0500
Message-ID: <CA+CK2bDjght3M=uTHcuDbW4C_Co7fXTiq7PN-HBjepF-X44Stw@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] mm: report per-page metadata information
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:31=E2=80=AFPM Sourav Panda <souravpanda@google.com=
> wrote:
>
> Adds two new per-node fields, namely nr_page_metadata and
> nr_page_metadata_boot, to /sys/devices/system/node/nodeN/vmstat
> and a global PageMetadata field to /proc/meminfo. This information can
> be used by users to see how much memory is being used by per-page
> metadata, which can vary depending on build configuration, machine
> architecture, and system use.
>
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. In this patch, exported
> field nr_page_metadata in /sys/devices/system/node/nodeN/vmstat would

It is OK to have nr_page_metadata field in nodeN/vmstat based on this
discussion:
https://lore.kernel.org/linux-mm/CA+CK2bB2=3DraEP8W5GDW_JY7TDvwtSCbkQjvn=3D=
SvbjUjPETXZow@mail.gmail.com

> exclusively track buddy allocations while nr_page_metadata_boot would
> exclusively track memblock allocations. Furthermore, PageMetadata in
> /proc/meminfo would exclusively track buddy allocations allowing it to
> be compared against MemTotal.
>
> This memory depends on build configurations, machine architectures, and
> the way system is used:
>
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Pasha

