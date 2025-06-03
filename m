Return-Path: <linux-fsdevel+bounces-50483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69217ACC86E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F8B1894737
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986A238D2B;
	Tue,  3 Jun 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IedptUNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C226290
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958685; cv=none; b=KLZfp2bjwEZN3xzfqtm3+rDF+fQZSZ7mRIZA7p1UiG4YWCSAHSmBLOAmNU+w01lP4GClWy1D0M8XtiPNorPpkJqR9K9tJJXTB2jWCfAdZLoeTqBswQZ0s8skpmUGAiaUMfDIVM4Dvltez3D81Gzb8saER/k417UeqS32df8efog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958685; c=relaxed/simple;
	bh=DZgdvaQsVzy3FEkZ9qjIOfWCU7WN4gcYp04RM+bGGPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdPhxCM5W/pSfG/oTm1Zjq5+BgOO/eBuM0CsEj4cn2Mwr77F2x7XOdjp03OxqI7hf8Koxyyq+PCqyyVNi6+SoI+e2HgcUgsZ5Ebmmqpc/mctbysjMpFMLBlCcTaDtFqUSxcZJGiA4qLzj+9ULNSb+dUUgQHuBOBZfJ7cyjqmBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IedptUNT; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecf99dd567so65998126d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958683; x=1749563483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=IedptUNT6Ql+/A5IUfTIL7owDIGPJY0PsmqMowMi5fm5w+soHZVqfQoQ/cDhRyyczv
         gv0wx05D6nHlPoaVhBYfP2NoFtlfEgPYO+Ch19nMcWVuzoPb0f0eCVPT/4CG6/dc7BHT
         n+YnHg/hH46ufdhzaX4fPCz7fdGiDzfGY3LntiePxXSGPACwjQotc8xocpu/j862zsQz
         aE0A4G3dVJHskD0CTgXP9wDqaQOPOqXniIfLaZGjazqE7x+jp2UNzQhfuJDjnpDeqMri
         vzpw3L9W4Ygj2ge2rovOCCf5BtnKxfSuTXZie1+lX5SvFbGbR7TDt8/rDu0mRdjOGZcH
         wWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958683; x=1749563483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=dT570ffnJFRL0FrOPFxzhT4Xw6jutbrjuILGMJMmzFYqVsO2gU00R2J3F6Imjq8Knk
         aWtnWS1GpwUIeFvYsZ9MxrROelo17HRM8gjN9xIU6Hy4+aI8avG2VTcx/kASDjJNiS6Q
         zRSDSGc7plpNfWN9ZvNZHiNEfYPex+M2L+39kEpro06wbEjCANLIAp7GwmIBcACAiH7a
         FCy+Tk46A6PA9kvvoJy5P5fKBVPAfvAOMxtrcMMG/SCQeOdX1TmCxaAHyln1RJQ3i7NY
         z3gd3PhT/dFSTkyk+NRXvckY/w4WLMT3/AWRiUOFl7MTScJhXcer8pio4oZGITKp4iCN
         CWkw==
X-Forwarded-Encrypted: i=1; AJvYcCXEmLMi1g/+Z0XRstA+3fp6iLk4LcEMYDeZ6QEXIXWGUxbysWcttp9+e1cz6xKada20kAD7tetMsLILK95A@vger.kernel.org
X-Gm-Message-State: AOJu0YwPuYp0sqz+NWPsYbE4dnEw9d/hYrtc/IMR43rneLlX2Tyl0QOW
	G/zmbaANbpYUwWAhWNaUocfo14pcoXwPgABt28GMtAhVDgLY8d4Mjow+7zr+Kz1tyCy2qDPDzmi
	83pZ0
X-Gm-Gg: ASbGncu9in36oAK1pJ/b1ebkOl9bkuNM7TuPCC5fbapAwrC6ztj9/VEXhhpNo7jO5RX
	8o1GeVRHHeSXnnPivbVEsk5Cxkth49YePm+xPeKWJ9RuIRruUTiXpnYd+DEGSSQ8SNYHQMvBGVD
	r2zBcoCLx5sPr4K9OO2ICtbLq/D9rgKvMNB3OM7U4rS7abJCM/OfBiLOKXCwGfOeH8pgGZbHNAD
	MHDm+Zc+4Ts5os/lVoFPSDL04GYL3Y4YWra5OHvwar4ZDMz387+1i+uhFaAXDGi5tdXnyz2iBaQ
	yM50b9tumkW7utvH6A7Z9vzFdgbi9yItEetDtGNaq56EOFZHIGr1MsxdZ4T/6YwHzGKVhaE9O1d
	ICWpxhIGuUocTYKbCGRB9fe0yJhQ=
X-Google-Smtp-Source: AGHT+IFvqH9ubcC6dbv0UqQGW5DGDtp+BZ9QNaQHwHo+bs9Vg0oCfSh3AzQ5xeJI5fTattmwccxXPg==
X-Received: by 2002:a05:6214:2aa3:b0:6fa:caa2:19bc with SMTP id 6a1803df08f44-6fad916605amr159392986d6.44.1748958672893;
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fad0495cf2sm68040826d6.39.2025.06.03.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2p-00000001hDX-3xh9;
	Tue, 03 Jun 2025 10:51:11 -0300
Date: Tue, 3 Jun 2025 10:51:11 -0300
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
Subject: Re: [PATCH 12/12] mm/memremap: Remove unused devmap_managed_key
Message-ID: <20250603135111.GM386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:13PM +1000, Alistair Popple wrote:
> It's no longer used so remove it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/memremap.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

