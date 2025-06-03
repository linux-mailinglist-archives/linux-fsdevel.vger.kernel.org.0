Return-Path: <linux-fsdevel+bounces-50482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F3ACC876
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539443A628E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130B238D3A;
	Tue,  3 Jun 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HHu1oDRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993423816C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958664; cv=none; b=fkpWSe3hTkjpRZnz3Lf8QL+82Rpj4CKxNva3tCztOmDUw7fE7ZiiRG52L+SPsJdyMHkHSnKWXVblFSc2A+2F9gWBxLq4shcN4Ez4cFt7/MXJdXlWn99LhHqPTrR7Uek3oW9406Jo5FYCH03kQG2YFpx+g/w+iCqBh2wFDkZaZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958664; c=relaxed/simple;
	bh=TpMwl2oz7EgmR302mml/BLJBQvaM57yfpZzI6Z7p75c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcrfRbl6NVrpSbC57fU38iHpgueqAAIXv481za/jI5xmGz3RvS4S52F6KrW4/ggDHnHmzzEB+xns3yPPmf8pPKlUhOiZZqCUp7CeTGvu/SYJogQI3/wZsA+5EHswUOWS8Gheipc+dJVzuEHKCUr2nWWSywDEfuyXUOfvjh27/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HHu1oDRp; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fabb948e5aso58509416d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958661; x=1749563461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=HHu1oDRpTNtra6tuj7FlilI8t8rEU1vcMPPGF5eq1lVmrzXw6a4oW3qUOYXOrGM0RE
         PwWbU4tsgpg23N1H2eqAFQCPDUbpSDSosK7U6gWhBSueuoHWrUfz4P8CMBRLuqZHkwai
         l2yqecHVvI/j0u3/zvloy7ayyc6WmV5eobdOHbGMb+MmbH/mQjnRkQrmBI62L25eY7qn
         IaI4A/04vzNjAcm/RLlVEo6XpurI2xKLlsuXatsbSmKzwBHtRFMlaiFfhe2FYNma9CPW
         QdCxzXYrihvvbjDIIbA6eVeuqYnLeKfgl80siksUqnFih2dt/+Fa4jrrBfKqNzygMsfr
         t3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958661; x=1749563461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=e17yZ9z/26TdOUplyOWc6vJUOq+pdku6yV5gmX4HOyx5tc9nHqu49Lr/N/mlsFlWeU
         REoz+UPL587dNPAiPzcNoQlK4EXEt66tLg6TuUK/jrmKIXnaz5r3OOajnbhGbFRoYPaQ
         JaDzD98rw+UG+QTjdZe2M4gihZAK0hYONJXptMr+qm5SyPKULTwBqJKDgQS7TZ4zbPmF
         +5+cusqtNuF5oX8Kr2fRmQ4YRXenG60o0HDJ6gwdkI6npMAYjvYhB0+gwlth1OnZE6NO
         97ATcjveza5vsNjGjKBVsRSNyqlPfXYNLRpEBZ3vtoE9DNeFK/wPGD8qt1wm6se90JIz
         s9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXnpd8WviYlAz/mPKmhrrLEfn8Km5uJ/6X/kAhsPly+DT5V4KENodUGTOC13RFkmXrA8/BlyJDKZQt1irWf@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFYkZpNj4Zt6j+Ts4GAM1UnFONBHdSAmwipG/tQ6T23DUEGrX
	PnpcGcLS0innBoWWfbsHFFpggjmUiAP4kUw3g47II1oteKjnCxljUXliZLm3Ct5a1ZleWrlYqcU
	NHfFr
X-Gm-Gg: ASbGncupZf7gXyKiOQMjp5JCr2fVd9wntl/zBuFzLoiTIhQRZTNFUeVk8Lg6u8mmGpb
	0AWHTgynCUxT4k/5Jy0bGLyg0ttwFR6xhVlRVVY2GdNNlg1v+ZtxdnuJ8u00+r8jRDMzyFCSJuq
	DpVGvu8WHcRg1y8iJ4UUfwekh+JWbHpqT9NpWW4jgCQHZTBSVXCCGdkJhhR/A5QRErmieRk+tr8
	qfWg2zVIRqmaMohfuwmSa4eeOBIXaZ4wwv2TlRCDj/5wCJYsycKW9JHtW6ef6xdrPx8SBpU4k2v
	RS53pZ6HBfUQDQeHjLLBHIoQ7S8GJSWGxa8pqybEA/HP5uF9NpoEl4+riX4dGFB/TycQsm4HurH
	gcX9tIqGrIFZSLSTxvmyoUV91E2cA0g3PmJARRA==
X-Google-Smtp-Source: AGHT+IEFP32FP1kWWCcJZHDROTyLVsjrCtV3bR6kiIwGVnTYe5RPt72l9Jyf9JX2LfFifGppycDP9g==
X-Received: by 2002:a05:620a:4629:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7d0eac62c8fmr1708400485a.14.1748958650816;
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f9925sm841658185a.41.2025.06.03.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2T-00000001hDC-3YG8;
	Tue, 03 Jun 2025 10:50:49 -0300
Date: Tue, 3 Jun 2025 10:50:49 -0300
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
Subject: Re: [PATCH 11/12] mm: Remove callers of pfn_t functionality
Message-ID: <20250603135049.GL386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:12PM +1000, Alistair Popple wrote:
> All PFN_* pfn_t flags have been removed. Therefore there is no longer
> a need for the pfn_t type and all uses can be replaced with normal
> pfns.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yay!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

