Return-Path: <linux-fsdevel+bounces-50477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C0ACC84D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ACCA3A3776
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D423A9BD;
	Tue,  3 Jun 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AjOqEgfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F65239E9A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958500; cv=none; b=fbwXj1y2OETS3m5oHjOAJOIrMzKU+mYCdG8T3b0H/j3telsjKkpRwIeoBSJI7uUWyo+tB4EzOhN3SG4ZtHAmAQIbUo6Rdkf7rOzeFx9Z3TFV1nsUOmy78rZ2iI4IdUY3RthcO9D1axYfTY1u6eyC/rc835OAPZLpgOpxhLj4EuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958500; c=relaxed/simple;
	bh=y7QlyC6KXPLMJYPeW/fxUEb7YGMf3rqlxQiF8jReTpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gkv8RUd710jiBQEFTW6fRBwM8mA3QREI7pXfRnDdmt7fz/9UaTA1ZkKohNy6i7gsUTyPTWdGS9566yeRmQR1EBakXT1U2ykB2gaSGBiDuYnUlvDwPUUoUJyZhfppNXOF/ya3e5FORDXi6Td2+vfzcyZqPSu+swsRZD8zseVQAHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AjOqEgfZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7cadd46ea9aso682652185a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958496; x=1749563296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ag2KSfmpizoceiuoj+cZXZUUA1usyi82jYygfJs/Bg=;
        b=AjOqEgfZCAKJpwstPgw4JUuuLsAGp4nuxZRwWsRx7CMfzOZNcGorTQaU0A+5m3TJgs
         r4OuHdohJGbuNjZ0ZfPjWtHdlHW0OUVT2MLGLWgssYWADyAl4O71jzDVYgB/hFpePHMF
         82h2pWYP3V1Wpd/Dx4GOY6hgM50TO3Sw38gXNjoK5nIiV0BAazMOQed27p1HtLGXrzfG
         Y41CTIjAqO84UvYK8NETu4qxigoFB31sHhGw/l5w/mwTsZm9iCHyHZFq5TAYGiWTz4G9
         jlH6Zb+lGS1JwhW2YHzLp7uXrXNKjo1ZIRmAJZ8hteKsQOdVlximwGQrn5r+EpsPZYxy
         YDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958496; x=1749563296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ag2KSfmpizoceiuoj+cZXZUUA1usyi82jYygfJs/Bg=;
        b=jUenLRf5kvqTtVnlL8qnzDuBl8GPw7L8+GCnt+zHOkLtlRwhjOXZCYTfscvgdXI+vm
         RDF/QeCjRFji5ilfIRegwuDRXaMcTzpELbKgqdXwuxnYTHyxK5hE5fheduTzm8k80E9t
         IgKfCUYJIRmhrM6x4d4kzlSWDGvEEslKlQJRXpEksr1ry9XiUOLh6BfPCkyXZjw+Ii5i
         UW/Nw24wb8kcNTYJ/V3AVZKd++al+fsOoW+5HQsqn0aQwJHgV5jayvcAtzNucVOPKW4I
         eF398VztF7TywZTO5/fUfaPMZwKnGpt8HRqXSEB+1017QhmLktpiwcYzrdOQiOsc49+t
         efNg==
X-Forwarded-Encrypted: i=1; AJvYcCV8+ny+2QKT4ZWJxzXmYUt7q6aqBkLXpAt3dcfuWoQlpr1s5/y2jhuGu7iWaMYibCRpdeHIZM3zRCr9I34r@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjmjUlTOp/BSdwVcjjFImwnEQO6OL7s5bNNLw3PIIRNySyo8g
	dF6RLoLfzRXcbydy0ietn3tqV6fm6FBeSLC3I3wsd6qTuGZiNlAf1A7oY+BlLqHTEMk=
X-Gm-Gg: ASbGncslTWB6YvrPNWUtGSbPcmW7bkcoOxpdOJp53XzI6rH4frjx2c6c9egHj9aZY8T
	dSxYBVRgwDmnaOPvg+9mhatZ9awOp36WydhGVZAsQXIM7Y8qVpf6+oHDn14NAmUYj4biN++pcBt
	C7yw50m0nMvRXfnA0Duo8Ys1dlTXjuaVWseCKq2liqBG6G3KaGSri2OW6XexgeizIGlonKznuca
	tTi+F68scQ/r4DLAf/UB7niIOaik/KVmf1EAvVkXNSNOtojwXLoFSLDSo1SXqplhGKn9P056x5w
	EphywaHh3ugMuI4zycGJiWc7V9oxTr/jS3xRrwXnYs2MxBtwWoutTeghy/d5ILjHTaUQD1LyvZD
	ZZNMEAj/qaMN8drFZ0bwIaNiIU8I=
X-Google-Smtp-Source: AGHT+IEC7tetoyd4MWB27Cys7lEZRwLgg/tDNDKGL2nO8t1WlsQDGW4e4zhoToAJp9Wky9F+fr/2kQ==
X-Received: by 2002:a05:620a:290a:b0:7c5:544e:2ccf with SMTP id af79cd13be357-7d0a4e57644mr2655730585a.57.1748958495697;
        Tue, 03 Jun 2025 06:48:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0e3fa9sm838696585a.24.2025.06.03.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:48:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRzy-00000001hBT-2tOq;
	Tue, 03 Jun 2025 10:48:14 -0300
Date: Tue, 3 Jun 2025 10:48:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 07/12] mm: Remove redundant pXd_devmap calls
Message-ID: <20250603134814.GH386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee5a64581d2c78445e5c4180d7eceed085825ca.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:08PM +1000, Alistair Popple wrote:
> DAX was the only thing that created pmd_devmap and pud_devmap entries
> however it no longer does as DAX pages are now refcounted normally and
> pXd_trans_huge() returns true for those. Therefore checking both pXd_devmap
> and pXd_trans_huge() is redundant and the former can be removed without
> changing behaviour as it will always be false.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  fs/dax.c                   |  5 ++---
>  include/linux/huge_mm.h    | 10 ++++------
>  include/linux/pgtable.h    |  2 +-
>  mm/hmm.c                   |  4 ++--
>  mm/huge_memory.c           | 30 +++++++++---------------------
>  mm/mapping_dirty_helpers.c |  4 ++--
>  mm/memory.c                | 15 ++++++---------
>  mm/migrate_device.c        |  2 +-
>  mm/mprotect.c              |  2 +-
>  mm/mremap.c                |  5 ++---
>  mm/page_vma_mapped.c       |  5 ++---
>  mm/pagewalk.c              |  8 +++-----
>  mm/pgtable-generic.c       |  7 +++----
>  mm/userfaultfd.c           |  4 ++--
>  mm/vmscan.c                |  3 ---
>  15 files changed, 40 insertions(+), 66 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

