Return-Path: <linux-fsdevel+bounces-29076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50638974BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163A92853DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37713F454;
	Wed, 11 Sep 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6EPFghP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1764A8F;
	Wed, 11 Sep 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040883; cv=none; b=NHaSnGR9Ha/+nE2p/mX+aFv5qpzHum8jHXDtBb5gRsntJoIBYepQQp+srusmei2YGlKg+VdZwlfY0xHz2JzZc1ywX9GQ2N6Jh83vC9mh6EftmdyDR/du3Pk7f18Mu+rM5xivt+NBcJwDBSGb3S1xD0lJDSptvnXUdMRmyJORVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040883; c=relaxed/simple;
	bh=dWI3Pd8hUNwX1F9lfw5/Q7Gvrg7f+xf+2lh6v/Vvvfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j76xDepQcbvN0Bvg/oeLus6U4qnAJ1WPpdyJT4biZQy8Yv7CK8zh2AHsWeVLN11rwl00dVvWpj5bdz4AayCvI8uFJbBeONbNsePGwW2FjrtRJu8LTpxUkZrOBewp4aKBX559ha/n5CqLzrTbHG7CwjYwuZ9P2qlPfqjTWmbNEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6EPFghP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a837cec81so326571966b.2;
        Wed, 11 Sep 2024 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726040880; x=1726645680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAqoY6jIAjc3xzIZO9ujMSqjm0EX+JGfOEbTRNWh9ek=;
        b=m6EPFghPydfytZDJWMfCAQEaEKkcJQ74hzZLvZVw3pb05TqdMXaC5SEimVq7SMvwF2
         FQlxvdt+ud8uuRXApNhBVpZXEmU2XzVrU1mCqSWvK0Dx62zbkTCEuAlqScmlldwsKR7D
         4l6rmX7i5dYX52FqOiCkVytroRxVq0NbEeDINVnnfVEZw1Tplx/uJQ5sBjl+ekPmS9fA
         qEvtvx317SDeTohgpjENEhsqRD87hXvyg1lZQwXrCtl5GWNQS/6632u20+6hkhJCNtZm
         E2XsRNkMOvkQN3oq1pMYBzQmB9KLs/Y4gWEOKoE7R6cTq8BMTBUxSXEihg+eOXUQLrr6
         Gbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040880; x=1726645680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAqoY6jIAjc3xzIZO9ujMSqjm0EX+JGfOEbTRNWh9ek=;
        b=wLRoeyRUntRUH6k2Zdh763/MRRc4K9Sm66TZCumewl3qsb3f1I6ybDta7/knRMtPe+
         xF43ZgiC+ESD0He1ZK0Xw6xHxSdBNi79ZzAxT8U+Te7ke3nH3Csevx2E88Q0Q/j1UDxi
         CGUjYNO+ItUef126V+kzdIqNbY/KHe7B+KZw1Zen9ZWFjo4zaHhlP7mG72M8tcsX+3rD
         gT9IRwfVZ3BcxMWPhKBOK+wTqT+DD0PAccsQMmj+daZlSv1U5x90Swh/A2XVgfGxzeYn
         WGEAg/Mh3cZbBf1iXkNHf4wGsyVzad+oNnFAziTA859iXJzAuxjIHypkdKSXOCGQRw0E
         mCeg==
X-Forwarded-Encrypted: i=1; AJvYcCU4u/TyTRuWTmYrh4tiaQG6HG7NfVskl3tD4d2XnHGd8i0sOlmyYQrvrp4ZwHYdqrpp48fBjf3Onw+W9w==@vger.kernel.org, AJvYcCVNEP1I6I07IJ9oB75rjLs5l2uuUQTTp2eVxB1l6C+SiwMZAj8Tmu3Hq9buY+MsAg32ROpT0Dfx817VrGFY4A==@vger.kernel.org, AJvYcCVegRNo2Qkz4ghyC09xdlUYJ4aGKPTTuvEY+kmEQ8SmtvBr4KBllXkR2ETlUJH/Kmi8fT8VGJQTSk8x@vger.kernel.org, AJvYcCWFWyJ3FHonq/NEL/BSOoFhOsfaY2FP4+vYbaxDHzdezsrBneMJZcyqOhwxS6ZntnUxpq0ngrLO+T0=@vger.kernel.org, AJvYcCWKIPPpZT9UsqXuoFm3qlu+n+gFSvbVBg76KGE2pTg50zVqjqUy7KOhPCmKczouCgEtN11eMC6eL+EC@vger.kernel.org, AJvYcCWR+bTzKYC0PucYHRIy4MmIfuKDOKjlBlfOHidgO3uZCwlVg+FAwwTU6gvu8fUjH5qQBN+2po/BMDlcx4sH@vger.kernel.org
X-Gm-Message-State: AOJu0YywKHfaxK0K8Se9GXa43rwST3gTnMD6PNh4ffvBPQ7O5VFCTpYa
	obR/Atu0oUGuHETynbUyLgXMrO/YISxfej0ohAemVbvjyBja31rMoqlJhuxcaBT0/9Y1jSqB3qC
	rp6N19xWje+y+8FgknL2/U04v/X0=
X-Google-Smtp-Source: AGHT+IFIM8V4DC0Z/5BWC5YRsJ9oRKTopRmw4RDrk2NBxBFwPDaaIWbAeLPw628HCYH5EvgpHLChk4iqxgrwnmbG4z4=
X-Received: by 2002:a05:6402:40d4:b0:5c3:d0e1:9f81 with SMTP id
 4fb4d7f45d1cf-5c3dc77ab97mr18285042a12.7.1726040879000; Wed, 11 Sep 2024
 00:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <39b1a78aa16ebe5db1c4b723e44fbdd217d302ac.1725941415.git-series.apopple@nvidia.com>
In-Reply-To: <39b1a78aa16ebe5db1c4b723e44fbdd217d302ac.1725941415.git-series.apopple@nvidia.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 11 Sep 2024 15:47:22 +0800
Message-ID: <CAOsKWHCEFSw6d7nC3A1Z4DKMNuUjirt-oULSr7hCWqT2GfnUDQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] mm: Remove devmap related functions and page table bits
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, 
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com, 
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, 
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com, 
	hch@lst.de, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"

Hi Alistair,

On Tue, 10 Sept 2024 at 12:21, Alistair Popple <apopple@nvidia.com> wrote:
>
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64
> ---
>  Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
>  arch/arm64/Kconfig                            |  1 +-
>  arch/arm64/include/asm/pgtable-prot.h         |  1 +-
>  arch/arm64/include/asm/pgtable.h              | 24 +--------
>  arch/powerpc/Kconfig                          |  1 +-
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 52 +------------------
>  arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
>  arch/x86/Kconfig                              |  1 +-
>  arch/x86/include/asm/pgtable.h                | 50 +-----------------
>  arch/x86/include/asm/pgtable_types.h          |  5 +--

RISC-V's references also need to be cleanup, it simply can be done by
reverting the commit

216e04bf1e4d (riscv: mm: Add support for ZONE_DEVICE)

Thanks,
Chunyan

>  include/linux/mm.h                            |  7 +--
>  include/linux/pfn_t.h                         | 20 +-------
>  include/linux/pgtable.h                       | 19 +------
>  mm/Kconfig                                    |  4 +-
>  mm/debug_vm_pgtable.c                         | 59 +--------------------
>  mm/hmm.c                                      |  3 +-
>  18 files changed, 11 insertions(+), 269 deletions(-)
>

