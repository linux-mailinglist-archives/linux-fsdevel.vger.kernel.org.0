Return-Path: <linux-fsdevel+bounces-50475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C74ACC811
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69379168583
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA02367A9;
	Tue,  3 Jun 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LvjshFQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD023506E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957922; cv=none; b=nSnY1AElDyPHgZt6jo42wHqsbOX0EsmGosLcos6tPAWZcncVuBt28gGoCpsImp0VQajuA1IX8rGMeAwkl+Wy2e8P5elrfDnzNQlQYve3h0utpdaD0ip4ejoPCXFSAQK/UNM6syC1zFQNzhXzn1UO8aRgynO1PMQkU2YKf+zSjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957922; c=relaxed/simple;
	bh=FJcBKj5IOAP4zBarRXTdKou4i5eFgR4+RYmNBOBDDmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQaI0ffcH+A7lluNPKnnWwFmOa5Ny/bwy8+gKodEx7Z+VeUg4X29oW1vv3LjnwIazmHnvBPHtYEgCgRG0c0qOXQM10EdV7CY0PvuISkN97WO1uTLAEyopUvWXTIJNfWSwlQsS4BmLJxRGWTfxN6o64Eobcm/85Djw+nv0q0w58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LvjshFQd; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58ebece05so20448621cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957919; x=1749562719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2YoBzO9/Vr83m9kWgElnZwYJY0cXKTy7GFrgVmwfY4k=;
        b=LvjshFQdboJOpxr+fB+fWrWhsunI9eeF4CbIQoy588EWAkzdFlgW2ulud0QOLPt26s
         6+PgfGnnw/oyKJHU0QVcB0yUH5b4yx0aMkjI6rJE/SCLq97nnZ5KM0QVqvtvDGC5nHyu
         Wwzk7vssC4s8Jw6WaGJUPLroYsdOKq9vO3byex6fd5NgL0ljJeWOP0neFYHZBQdh9aVl
         1yVrZLUig/vc1Srd4fTVyB1w/JIumebqwlNiowovwMIVaZvQjn1RG7c+bPOFaykPwtLe
         b7nIMyfXi+EC/zVXO77jX2CahfKKPwlV7rE9q+zpmLUMzSPkZ31zjIh9aiG+GXaKR1OW
         QVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957919; x=1749562719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YoBzO9/Vr83m9kWgElnZwYJY0cXKTy7GFrgVmwfY4k=;
        b=eARXnbljUkuha5dZ+mlNSJ2gZJjNw1erFOR/cQhG+ZSAhFXJSxNYy8MMfMnuv/CiQN
         jIYfn8HGE1B3B6VGMyrOWGn2Oa9V/g0SgIgHmfKXjw0n35fObCm30ffQQOiajVznUQmz
         qJ0f2gUrZlk9MZTo7C5hbEbPQa1h1jDz8jaakwQeGx9VFf9oI+v5KGDJrPAmNxcI2Wiq
         PuT0UcMGP6EW+GcRMZLGILjRxuzTd3ztsSOyXF2FGl1bAaWtZA6f2iKlLdx64FUmj+X7
         GZIC5o0mpDXzV744omtIInmrMILT/1wzYe6T6K8cUQ17Jp7T1c44w9+GKrccAI7Cp//6
         Cugw==
X-Forwarded-Encrypted: i=1; AJvYcCXyQrbl++2/4bX4iYXQ7Ct9Kmr/ynScbs71DG8rE8UqhH0MkAPcaHM0BP86oTFRQR9OIzbaSAb+/C6gtFsG@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYIzETTwz71oRPCudYA68HOn5LlJd54CFqJc1bdpfJZN59J0H
	UhhZKNOXdEr+1fSru/Oto3DPpxI6SBUXUTwXJ/TU4p97G9o7KdTfLTynKznxiOy7yHw=
X-Gm-Gg: ASbGncvJ7HAP7fL/Pj0guXG5ANw885vDuBSVf+wCgFnjGBWNiEtJbXLo05ZtbEileAr
	MtLN5/XOiRDupXTfpqpSlg4kDDocYx6i7ofZTKP2cEVAjMpcGY3QnIPLL94KzPubDjf1c7RNXj2
	9LvmnVb4AKRJ/+6U7ffg6l5hAbH8RrOlqPM50J47olTT01GQUu5cpPid7a/zTC+S2akxJLE+LYJ
	VqCuX3cj/YuCJPAkqDM5XiWXEZURAdgqpALVtBJ7b+kutzV3rFpVLFrUWewxGp1IQqfxgBM7TEJ
	Lt4KhRoYfD1c12yJ+xEZYL1I0AVBs0S5q/Q8IXswPnq45g4zxekPAtENkouG2nW+mr67waAvLOD
	A7bveRDOHp7lmWGHtrryL8mucOsI=
X-Google-Smtp-Source: AGHT+IFNNgr1gOgNIDIKGgPc3bhuHOtoZeZOnCuhf1c+LALW25Lvqo21bVxhfooiSUL50e5IoEYUCA==
X-Received: by 2002:a05:6214:194d:b0:6f5:3a79:a4b2 with SMTP id 6a1803df08f44-6fad191b357mr264142056d6.14.1748957918424;
        Tue, 03 Jun 2025 06:38:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e1a681sm80140746d6.98.2025.06.03.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:38:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRqf-00000001h6M-29EG;
	Tue, 03 Jun 2025 10:38:37 -0300
Date: Tue, 3 Jun 2025 10:38:37 -0300
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
Subject: Re: [PATCH 05/12] mm: Remove remaining uses of PFN_DEV
Message-ID: <20250603133837.GF386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <ee89c9f307c6a508fe8495038d6c3aa7ce65553b.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee89c9f307c6a508fe8495038d6c3aa7ce65553b.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:06PM +1000, Alistair Popple wrote:
> PFN_DEV was used by callers of dax_direct_access() to figure out if the
> returned PFN is associated with a page using pfn_t_has_page() or
> not. However all DAX PFNs now require an assoicated ZONE_DEVICE page so can
> assume a page exists.
> 
> Other users of PFN_DEV were setting it before calling
> vmf_insert_mixed(). This is unnecessary as it is no longer checked, instead
> relying on pfn_valid() to determine if there is an associated page or not.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/gma500/fbdev.c     |  2 +-
>  drivers/gpu/drm/omapdrm/omap_gem.c |  5 ++---
>  drivers/s390/block/dcssblk.c       |  3 +--
>  drivers/vfio/pci/vfio_pci_core.c   |  6 ++----
>  fs/cramfs/inode.c                  |  2 +-
>  include/linux/pfn_t.h              | 25 ++-----------------------
>  mm/memory.c                        |  4 ++--
>  7 files changed, 11 insertions(+), 36 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

