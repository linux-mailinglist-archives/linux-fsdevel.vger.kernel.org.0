Return-Path: <linux-fsdevel+bounces-50474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064EEACC806
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C557A67CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57C123182D;
	Tue,  3 Jun 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fQm6MF53"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF88231A23
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957864; cv=none; b=f5wmp/rtB3rZpmsYv0204zqmvTTgKSSz2jYCXP+oOAriwtSoJ8L6lMb5/5qnlgePwilBUXlZvwo41Wns4a3O/Eiy3imOrYGBS6PsD2QBh7AAXtJXpcAQ6sC8wgI916nVYThc4fABG2x0lvFIFFTibA3CUOl3dMynbcRXI3I98yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957864; c=relaxed/simple;
	bh=tQw110EHLRiTqyKmaEl6CwpwtZx8Pit5aVtH22wzAog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwChBa4PTuZETwPDn/5UMxCky/sBUNYk/L0e05g9X3ga8/56uW4wcuXdvBpUd5ebUZpzwoV8TOGBo1n+31b7z5idfHXv+JalegPL6Oq1feri769/nYO9nip9O7Qjgoi3Pid6LoAVFKW5ReNSW7Of7e+Fc+Nxz2wPkFEM3aKCwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fQm6MF53; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5851764e1so47125901cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957861; x=1749562661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UoX6ZYAbWcKDR6KFcgyyRoqI5kTXzqc7rOw8qvSUCMg=;
        b=fQm6MF53qYwSSeMTr2sltiD/eFfcQJmzi89gd1I9yNsMcxsJgeykJFQDd2rJFjqK3d
         zsk5PJSORAeq1P7oiOrJN17n1DaJdLiiW9ri6j/qiPpy1ELwXBq3K3mNGpvTzFOob5KR
         PdMSE5qvoLD5EyPMzUDX8gKj7cIeSJvnGlC8HPv1HAr2+HqHxHW4lPJXmlKK0aXsPLbe
         ApXM694n56Q3kwaR6xr1ljighNPXSA2zXEyEFsQVCifkeego146Fp/zwQ2BT8TZVbuSh
         y/nJZTYur6p/nVgIUF0FRaiQyw9MyXovFKMQoYludBFZfAhI94HajoVMu00/SH35WdbQ
         D0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957861; x=1749562661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoX6ZYAbWcKDR6KFcgyyRoqI5kTXzqc7rOw8qvSUCMg=;
        b=jascP0Il1Hfh5HyhllWGYW0SJaPRDVyB/RY0U0Sry2uTDhhytBk+uQ7NaWZTo3oNLk
         kUvQJj4CuTerwwFroJDIko5m1p896bbYjVgo62zx/TNgQ/iGIqfRxAEeUD79wH2szg2H
         QGX6kiYO7kMyL1zUvVK2bJspN3iKELcRgtFjHqpn4dDk8uXmMwYhZnwUTJa2SC3OYghh
         WE5csnVxFErBIg34sMwomM1WE5IHEW6aI4edFmxm8ZnlN3lymx29O5tlIOx+XgaCRiJO
         HZwpdKXc7JSA0kY0CJqsGIlCnfwPcuxA5XHFXCsLwnAaGBa1tQdLkjSsIjgo1HRP3kVd
         dMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUgxLIajHwqYSI8+ZTTQm2mCDKkM9P1N5hfnKvzoZl9LoDwQnK3LJdpqIZffhkVNDXh3ynJI8Z0D4SA5lqn@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIsxV8rT71Ff7kKgj9w4MQ5QecuQzYvMbo/JPFgYMtLsFHm28
	fNo4Mgp/L3Q3j7r0r0wOMLWbR/ToBQNuYWfAga9yq/bXDOjzw3lfjKfMafGNHENdBic=
X-Gm-Gg: ASbGncuJ3fDcNXNeCwI1wzH1w7NgRHhJzLe1v7qpRxmWfAEbkhCL6RL5+Zmt0xoTEy9
	H5oU7QIYlG1GOGGQj8VMLoMQ9ujFxC0+/j68qdyhDmSxxwQ/cQ30v8nyDxUpV3xhX4N4IJEWHh+
	zurF7Fd210Lnn9mg/Yoc/6vs9mwNsFWQxE1Ha/6wpezdp5jrRB+TbeL6UYIZZbyaGKxShug6wDr
	RNVgfgZ3i5c35tklB6QRtUTnb5LAu0tZt2vnH7/uJySGBM0lE+UZfV9Mr1ggq1g5g4PnJaMmHM8
	rkuuWLwi3aYJ6P3KxOQ2qSXwGvevkaSE7OpSWxxDv8PgMKkdJ0vRrlCn3PMcMIfx2yhhilik+vP
	Ugkgdm2NsozRluMPhy/kKZ6+7Xtt/bBD+d+tJsQ==
X-Google-Smtp-Source: AGHT+IHIja21FGplZEuqybwyfzBxoI5k6ggct08qhelvg2n2Sr3vDQGi+qZrCCr84f/KmAHse8r0Yw==
X-Received: by 2002:a05:622a:4c16:b0:4a4:2e99:3a92 with SMTP id d75a77b69052e-4a443f2d1a2mr265367291cf.38.1748957861491;
        Tue, 03 Jun 2025 06:37:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435a36e1bsm73924021cf.62.2025.06.03.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:37:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRpk-00000001h5v-1tYD;
	Tue, 03 Jun 2025 10:37:40 -0300
Date: Tue, 3 Jun 2025 10:37:40 -0300
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
Subject: Re: [PATCH 04/12] mm: Convert vmf_insert_mixed() from using
 pte_devmap to pte_special
Message-ID: <20250603133740.GE386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <171c8ae407198160c434797a96fe56d837cdc1cd.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171c8ae407198160c434797a96fe56d837cdc1cd.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:05PM +1000, Alistair Popple wrote:
> DAX no longer requires device PTEs as it always has a ZONE_DEVICE page
> associated with the PTE that can be reference counted normally. Other users
> of pte_devmap are drivers that set PFN_DEV when calling vmf_insert_mixed()
> which ensures vm_normal_page() returns NULL for these entries.
> 
> There is no reason to distinguish these pte_devmap users so in order to
> free up a PTE bit use pte_special instead for entries created with
> vmf_insert_mixed(). This will ensure vm_normal_page() will continue to
> return NULL for these pages.
> 
> Architectures that don't support pte_special also don't support pte_devmap
> so those will continue to rely on pfn_valid() to determine if the page can
> be mapped.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/hmm.c    |  3 ---
>  mm/memory.c | 20 ++------------------
>  mm/vmscan.c |  2 +-
>  3 files changed, 3 insertions(+), 22 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

