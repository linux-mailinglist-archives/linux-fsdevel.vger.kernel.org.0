Return-Path: <linux-fsdevel+bounces-50472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8ECACC7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF221188CF92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49504233133;
	Tue,  3 Jun 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L9faMCZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA1230D1E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957714; cv=none; b=AdkkhrVCrbFKvzX0IlPbYTyZtCq7+sF33dQWhwHRWcAdJq4umuoux/cjfywf8GaOFQmnADDCeqKXvDn+ACom2qNOq5Hwfz1UI7g3zUF9ASx+jyfdrHj9nbf8YvedwOeDy298V9xtl3IXSeqYywNIkNdJYvGuHBerfKcDhNAFbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957714; c=relaxed/simple;
	bh=6aXyILyNFzvdfLvnjhe+7eEg65vKZaS3Xgt9s4P7IoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi3YyJz+2WrF+UaWK66JzU4v83E0O2GShGDmnmM20uLs0kMGD3KamKnSTEYCrE5B9r7gdSFd/7DuaXdRLNdvBKyLKS8Y8cHoCZNmv1ITASZCFTSRd4p8JtcPqsVpmUi6puyTH5OSNtkfP5K4Db+L792Gm8nm3x2ad7/fVrJ45ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L9faMCZo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fac7b6fd32so29254346d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957710; x=1749562510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csMjX6EgdDvsoUroDDkC2t6M2H8xOJU7irccfVA/OHY=;
        b=L9faMCZoU5k/eDkzQK021wVY5FNVNBtn7krLf6IoxlHpm1QF2vWzXGv0u7r8BdGjAm
         1ZfBSaDxx3E9EAaIl/9pE9ng1Ii3grLFqUSNGGaK/HmxD9aPIBsW35Zgihs/nAsL0Pj0
         DB8vqs9CFLwCTqERpAvT061kIhjcj3MYkTlunlPQb+nFkd+h4UHb1+UK5G6X5N4nFEQQ
         sJPnqYrKWS9tONkmVjTCC/GacIFCzFqn+4L4+rl4h+tk40iZk7kbUbSsFPC4JZsFF0YK
         YM+kJYa126BBD/AZ0Vw6T1+y8HPQFkyAjcpfoGYjT4hjB5l0PB43dSKVcIDuV8xRE9Cb
         gDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957710; x=1749562510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csMjX6EgdDvsoUroDDkC2t6M2H8xOJU7irccfVA/OHY=;
        b=mzlkHlbbQIqB4PJ+UgHMwUKvpGCuwgGJqGmiAOIKvtI8UZlgdZx1vXNMqeYvW7zVUw
         6L3tpeG3cxWVTu6pAn4YVk9HAAYhVeT9ZHE9FJBBikDDyvtIHEYib+BJtnQCxFzNtRzq
         Uduf/vJAt9wfPicZco8QhzoSacXXNWSfFCJ9UqS81vcG8akgiKq08khKEP8fOAFuuaya
         AEv47FCcs3bhIk9mRQ+isIL1pUEcMC9GK2RGNn3qK2aIxDXjfaaEBq/gZWlKLUd8MV5Z
         Fm31mw0FQXpiVoKIKX62ZyOFXLGBegrOwXrstpiiBs5Crjk25EUNo0l3XIBG2HPTVxgx
         yqOw==
X-Forwarded-Encrypted: i=1; AJvYcCU4HxP9wMqq+aLCpyazcZo9wD/32UnowMvafqq01Rkk6eaOjqQg+0+Gj8dZFvOakyZ8of5hBjGXWoWFbWHm@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlhnugxYC0kaygbR7+whd3jidAZWMA7dy0gObS3Wem+hHVoje
	OC2kO/3fF+QMnZzJly2J6LvCSZpVyTfwFR/QCXOHx/mqpvrcnYh9cYKC914LsxN2V3s=
X-Gm-Gg: ASbGnctN3CGJsvLN8Fb27UjAKP1X0Xa41IiJjVgO8Y3a3O3ACJ/5ClRONynVl5p+0H1
	PnxSKPu3Z6h7LBDopFa1LzaxilSL9F7S4Pgjvv/fjnca9Il7RFSk9dghWToTMWL9Et9u+A4P5++
	ZVykclFcYq8hK6I5ZnMbdjk3JmWgPJNcxisVcLJVsusByluvpxgH/8dIujXOFqMPnMkcy5cnLXm
	hukWAYDCwkNURm0ShqTOgQka/dsB39+0URO8xdCvcH+mnr7LcAbqXobwatAcu2mBaAFUBXlYfZR
	mSIywUl+33AYV150T7xc3fGntKcqDeXpi4X3e+HgWxVj78utN2nLw+qvy+YuCMhECskisGKtEUz
	AHSOEIV03BC1G2p0TQcQxPhnbxohjSpBP/sz2Fg==
X-Google-Smtp-Source: AGHT+IGTO1Uq6qWKkHjHjzXPtbeutCQLStskBTpgABiXf8IiWIF7+BRGzTPM/WsKdaJBbv1DscVTNw==
X-Received: by 2002:a05:6214:d87:b0:6eb:1e80:19fa with SMTP id 6a1803df08f44-6fad9090760mr153489766d6.1.1748957710547;
        Tue, 03 Jun 2025 06:35:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e2fc45sm80639296d6.122.2025.06.03.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:35:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRnJ-00000001h4R-2OPU;
	Tue, 03 Jun 2025 10:35:09 -0300
Date: Tue, 3 Jun 2025 10:35:09 -0300
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
Subject: Re: [PATCH 02/12] mm: Convert pXd_devmap checks to vma_is_dax
Message-ID: <20250603133509.GC386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <224f0265027a9578534586fa1f6ed80270aa24d5.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224f0265027a9578534586fa1f6ed80270aa24d5.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:03PM +1000, Alistair Popple wrote:
> Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
> pages. Therefore page walkers that want to exclude DAX pages can check
> pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
> meaning dax pages are mapped as normal pages.
> 
> Ensure page walkers that currently use pXd_devmap to skip DAX pages
> continue to do so by adding explicit checks of the VMA instead.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  fs/userfaultfd.c | 2 +-
>  mm/hmm.c         | 2 +-
>  mm/userfaultfd.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

