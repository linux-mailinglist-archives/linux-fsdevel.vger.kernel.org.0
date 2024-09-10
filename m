Return-Path: <linux-fsdevel+bounces-29022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 746EE97390A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206D01F25232
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0C193092;
	Tue, 10 Sep 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEY2rbqH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB76757EB;
	Tue, 10 Sep 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976067; cv=none; b=GkBecppOz3MbcqDZ1usUSwxLKUjsngBcdlfJ9UN+NKmAUdyOPuTZ7bgepnmnVyEH/KBDPzihyM/suwwHLM5CBz3SRnJt/SVW3ZxYUPG7y0RIRKiQpmZ0VSsbsSa7mUN+/AixzwBlqDiK6lOFjIqVRtE80yWayPS39kYgByySnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976067; c=relaxed/simple;
	bh=5BIOwvLP7xQQalA/sz2+3hW69BzQPTxbRY8bNFFdbAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LsA2VlMYGQmD56r9l+4ytCwowrQtiX6g9RHpQeVBAR12xGqRm+CtLGvxHIW5xpSZDW+ZZ1MwcGs8fzwlJAYjjauNDT3CQehEP8r8LrZ2nzzEpiHkmGVpaRIks/+ldyx2VrxZ2KsgXKTgyQvzzwPHQRad7NUDSLHfpueiZGEIUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEY2rbqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D511CC4CEC3;
	Tue, 10 Sep 2024 13:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725976067;
	bh=5BIOwvLP7xQQalA/sz2+3hW69BzQPTxbRY8bNFFdbAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IEY2rbqH3w3QWrZlffkEMhj/SAK8BlbPxQf4rRb1zSHKyK4xF+Srv+UDY+zHbUHzs
	 JA0DvU5f0DbgBMr3Sb5NitOnO2l6OHERxru8WQxOi/fJE6CW+QLpPt6O5/ESc2+/r+
	 nEyp+8CDZog+NSU2TE5LTInkxU2EuSK5CR0ndMZpCY+3IMEwxr53HALAeZLU8Bi7l/
	 cUTwVYBmS/QHkMC1jDttI9VWJbTdhB+eeTr/YItiNqDBT0HATyT6n3eyy5pPwSbLn2
	 iHAiH4D62eBGk+h2r6ea7QlTKFYhvpIXWUtNZ+ZEIM4X00o83BFiF+6ZPyxS5I2Qe6
	 0pct/bThNgVEA==
Date: Tue, 10 Sep 2024 08:47:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	david@fromorbit.com
Subject: Re: [PATCH 02/12] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <20240910134745.GA577955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8326d9d9e81f1cb893c2bd6f17878b138cf93d.1725941415.git-series.apopple@nvidia.com>

In subject:

  PCI/P2PDMA: ...

would match previous history.

On Tue, Sep 10, 2024 at 02:14:27PM +1000, Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/pci/p2pdma.c |  6 ++++++
>  mm/memremap.c        | 17 +++++++++++++----
>  mm/mm_init.c         | 22 ++++++++++++++++++----
>  3 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13..210b9f4 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -129,6 +129,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  	}
>  
>  	/*
> +	 * Initialise the refcount for the freshly allocated page. As we have
> +	 * just allocated the page no one else should be using it.
> +	 */
> +	set_page_count(virt_to_page(kaddr), 1);

No doubt the subject line is true in some overall context, but it does
seem to say the opposite of what happens here.

Bjorn

