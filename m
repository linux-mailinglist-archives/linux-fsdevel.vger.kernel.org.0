Return-Path: <linux-fsdevel+bounces-50481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA67ACC860
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C93188ADD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3B23956E;
	Tue,  3 Jun 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kNIl6V3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFC238C3B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958622; cv=none; b=K9GskGr+OX6OtI3bAKY5SGueuamo8ef69lCeJz7ysl/6/kq/O2eOuZH1Ptnye1nucE3V7j515kBVzzruA38knW6A6YBvNMWBITZxR0qKpnc0UaxdAlwvFIMDZDq2VCccWeyXyFbvCd2FaCLUm6sWFzb0y3JFgptVexaQsOYrVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958622; c=relaxed/simple;
	bh=1doqpPZBZdBJM8o+kHQlB7CeX2bycDJ6ijoRgFE2Vjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJJxWbvbnDtGv68oUF3dIRGexSW+X2IKLdMN/BWWYsCZ4oypROvbW1b/NCviHCHMLP84epI2T/ZtLCqY3bGp3eABJTCB6MWz6xLh/0x3DJLHZvhuRQvaqdsIn9jlRKJguUBJJ21QM5ATKUmZKnjy0qpBk2OPZLnLTXiE3xZhrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kNIl6V3J; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a44b9b2af8so24112091cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958619; x=1749563419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YkymsPnXdQBda6JrJEhL1GWpprQuWSyxObGqKIJXWus=;
        b=kNIl6V3JpKp6i8E1J3rartq8Eb1PZ0J+L6CKvgEXKdMxoKIiAfmyApPk6Y4TMiZb1x
         It/fmYK+k1cXfB8qG9pGwNRJjb4gPaxbUch+Mm8CIWuz7JVInJmWeoYZE3nZDBxao0md
         udDjoJz8SeH9bHFbetsiOzOJhUqdkwNzpkDkG1GV1/K0iEliFCR7/7nYpNCdgUlejOPG
         4xxdlClipsKftsjPceD+0xfW+xGFK49r1r5C25TYjU4CIh4b+FvbGPnpBsK8Q0mYwzCX
         xhN9Jb3u/lp1E5JmRLMQUZ5KmpVwImFt3N02p34b/K1tafFpvi/pGJeK3f9QTwtxu0N4
         YlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958619; x=1749563419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkymsPnXdQBda6JrJEhL1GWpprQuWSyxObGqKIJXWus=;
        b=clk85KZ+eZwL/xtef6XJE4lRpp/gb8lJ5BYmJNcbwC9o7OvpkYQRyvBVrKJsvuWNys
         DxAlv0Zerlnc6Zw5Pd3tHt59zQVgk5XKb0xf5cPMpR3nOfhK+kqa0llVndttvFb0F0Hu
         5I9N0MNT7f53vhIp4svb5grOa5C0EcEAgjuVwH4q+sURrMhNh+QP0/hSy7ofIeGCxfqD
         gHQ16IhwY4zs8xiqwEfjfHVpszGYfMhKKnLNpPv+5bvyZ69iyw/JYHm7dZYsn9Est8iw
         kSaeBG6iWCYp7vQp61ISGpc3IXYvsi4rsSStgks/X4GjjFNqGZ/xvAqIz1bVriQhkojN
         EUnw==
X-Forwarded-Encrypted: i=1; AJvYcCXnB1+l+Bs7BgPY4oE3qVBDV0A47OmDItxQv4gNAlw1ElaEDd/RZb78SceJH4Q4oL0gYZOhM/MC+yz1lYcr@vger.kernel.org
X-Gm-Message-State: AOJu0YyVl+k4W21/zDIUSuCdWaExqTBFYrEXP7WfP+8TLZzCWfSvQ+vp
	r1AShUNS+QGO8ed0U7ovwD+h2uvKP6iQqw6TgzjiwBLCmotPy9LxtfTTmNXbD4u4f+c=
X-Gm-Gg: ASbGncuWUQAhwj4W1P0QtnQhNMEydMSD98BiaeXPMo7Tz5VfU848x20wbpmRMFbEqtR
	qS8zRfgr6x7xb7ZNJ2/LKV1Yo6ElSBFmgLJKseeXa6g3YVzBa4ihpDt4sMZGHMTyMWQGhIrkxxS
	kzUCx88Tp+69Jv1EFl8dYi6UCpGBZJzrWWN6kVT7fBivNXJi0HyeF7cwCHZhcdWbSbJXXDY6RXH
	pdZye5reY7dspHn4DVeTu6FP/elaTwfOW1rf7X59sIIv9lUKkPAhdjodk4h4aGz/G/8bNnYsOlb
	5Xjtd0A7D+c9EyTXXBBAytmJNYKF1bT1WTkL0cvMCvUaPiFem5IC79bG3vgZa0oieHP5grdpK+6
	6fwPw+yKCvS1JlOVSV92caJHR7NA=
X-Google-Smtp-Source: AGHT+IFrQ3mNOrW6/ZBr5BKf2weoO3iOKbQMChhnKb6iKzSLwy4jyxYkXr8u6rUugOKC/0R4gbcrnw==
X-Received: by 2002:a05:622a:4d96:b0:4a4:3171:b942 with SMTP id d75a77b69052e-4a4aed86ba3mr229299171cf.39.1748958619327;
        Tue, 03 Jun 2025 06:50:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358eef6csm75933171cf.48.2025.06.03.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:50:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS1y-00000001hCj-1MTz;
	Tue, 03 Jun 2025 10:50:18 -0300
Date: Tue, 3 Jun 2025 10:50:18 -0300
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
	John@groves.net, Will Deacon <will@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH 10/12] mm: Remove devmap related functions and page table
 bits
Message-ID: <20250603135018.GK386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <32209333cfdddffc76f18981f41a989b14780956.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32209333cfdddffc76f18981f41a989b14780956.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:11PM +1000, Alistair Popple wrote:
> Now that DAX and all other reference counts to ZONE_DEVICE pages are
> managed normally there is no need for the special devmap PTE/PMD/PUD
> page table bits. So drop all references to these, freeing up a
> software defined page table bit on architectures supporting it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org> # arm64
> Suggested-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  Documentation/mm/arch_pgtable_helpers.rst     |  6 +--
>  arch/arm64/Kconfig                            |  1 +-
>  arch/arm64/include/asm/pgtable-prot.h         |  1 +-
>  arch/arm64/include/asm/pgtable.h              | 24 +--------
>  arch/loongarch/Kconfig                        |  1 +-
>  arch/loongarch/include/asm/pgtable-bits.h     |  6 +--
>  arch/loongarch/include/asm/pgtable.h          | 19 +------
>  arch/powerpc/Kconfig                          |  1 +-
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |  6 +--
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |  7 +--
>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 53 +------------------
>  arch/powerpc/include/asm/book3s/64/radix.h    | 14 +-----
>  arch/riscv/Kconfig                            |  1 +-
>  arch/riscv/include/asm/pgtable-64.h           | 20 +-------
>  arch/riscv/include/asm/pgtable-bits.h         |  1 +-
>  arch/riscv/include/asm/pgtable.h              | 17 +------
>  arch/x86/Kconfig                              |  1 +-
>  arch/x86/include/asm/pgtable.h                | 51 +-----------------
>  arch/x86/include/asm/pgtable_types.h          |  5 +--
>  include/linux/mm.h                            |  7 +--
>  include/linux/pgtable.h                       | 19 +------
>  mm/Kconfig                                    |  4 +-
>  mm/debug_vm_pgtable.c                         | 59 +--------------------
>  mm/hmm.c                                      |  3 +-
>  mm/madvise.c                                  |  8 +--
>  25 files changed, 17 insertions(+), 318 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

