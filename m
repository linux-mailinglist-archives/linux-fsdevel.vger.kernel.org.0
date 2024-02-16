Return-Path: <linux-fsdevel+bounces-11785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB37857230
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A128185B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69A28E8;
	Fri, 16 Feb 2024 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Sft0/ZJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05A19E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041846; cv=none; b=XPCCK6E71akEVT8O9tg5+AmIHIR3c/NyM8EAuO9M5DniR2IEVvR7zkCye+dskZutOJWNx9d/ZBaPpzRTZ0QjpbbU+vVlBBlUJWtUYRdRK9LNp5NquiEfKFHrO8Ra3myOsIk8/I+7sDJuOPS+jz9KkE6ZwbkICj/eJAr2BrODdBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041846; c=relaxed/simple;
	bh=4zyTyZe00v3lyBoz60hnuxhzt0lL1FV+d6rh/GPrF+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZwho3VMdxNBvsQQOZ1wBzdyS75xRJ5Crtbb2GPWD+9pXvik4MEGEyR1jUGzRtNcH/leUfVw1p2iO+u1c+ryZR+fmGmcof5qY+wIg438pxQObi4Eh1mIVE92rUF3i+hV8PokZmvjvUBumS1m87yFNhum8I4vaGiQU/oF0DWLi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Sft0/ZJU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e10d08cb4fso1427705b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 16:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708041844; x=1708646644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+hW1/MwR04S4IUgIII8rEgyOltSHRihojBGlZc3thU=;
        b=Sft0/ZJUk/47p3pG0yimW79YnldAjIBEOiSIU/K70A/9bxPAHl+DiErJEFL0BV2l0k
         Erx0nUserfbRKD7SyGGpQsFO0MOjB6pUojILO6aGqhQDSPQ8CDVUANDXqvdqDO5LqWPv
         g/ZkAqwXiuAEZYMEdTWVuCGDpSoLlf6o225TGD//QSl2ZQIZ0TVs/AcBNwcOXYyjuyxr
         6FTmI+Lsq5WB2C26JBZ7VSENrq4XbZaPTQl/3FDAhf17sH68Y/+kc8zD0v6lPS81E8F+
         0JWIYHYhNgIdBWJUexgR2eLobIGokOAH8W2RDVKKJOb7HMO9RJomRyUwdKuGmW43q+xD
         GTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041844; x=1708646644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hW1/MwR04S4IUgIII8rEgyOltSHRihojBGlZc3thU=;
        b=OvpYN35mTiGIMQzVNsl4CeZkHyPDru+7/L81nN2s1apeKPaqKTwUjTwtf11QxWQtdS
         YMBSvO/H8JcAp1S4h3Pml48AVTL6LklrXK1lJ0rh277pXy6qtGJhfOmEernrbw7HuQ0X
         t35/RxbT5wlsW5SikMBLveGT8uHCD0DbExmv3m1205LWyF38K3/DNJDpmvf5d0eq4k6b
         TMvlJ+7mLR3I5nHfQklpECdY5BMMXR9TdU/aN2LAEr9ToZyubJ/vREuW9TH7KhlNFqZo
         BhUl4cm4f+S0Y4IM71QrWC6SuQFhzBFFfH8aMPE1YXdvc01uZbyWsO1U+ANiE8kp2OUn
         pUtA==
X-Forwarded-Encrypted: i=1; AJvYcCXxAwyYuPlNGmVI/vP+C+0ks8We8R7kAcBZSxI6EofYWl48YXOA3O0EMnjWOLYAtL0BG6YghkklAxnCyWWpqu3kZRzlmJLdJV6H+VpT1Q==
X-Gm-Message-State: AOJu0YzGzQKpheZCAeviuiza9M2u4cqIcTTICg+IIraafKXnd4V0j1iB
	ghWRY0sW/aBpEaBj0+YSZj92OAVZPKPekUpCM/89QQKCfTRaXn+oF7QfGzFx93/rZlE3oK/qzTi
	v
X-Google-Smtp-Source: AGHT+IGK13f/ddwLuPDd7VBJvpcBJliwQaaFIZvWhXTQpf0/0SU9Fo3kjiG0dUjoKg8zCluHKNB/DA==
X-Received: by 2002:a05:6a21:2d0c:b0:19e:c9e8:f2bc with SMTP id tw12-20020a056a212d0c00b0019ec9e8f2bcmr5193728pzb.15.1708041843767;
        Thu, 15 Feb 2024 16:04:03 -0800 (PST)
Received: from dread.disaster.area (pa49-195-8-86.pa.nsw.optusnet.com.au. [49.195.8.86])
        by smtp.gmail.com with ESMTPSA id p37-20020a056a0026e500b006db9604bf8csm1889606pfw.131.2024.02.15.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:04:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ralhw-0073PF-1Q;
	Fri, 16 Feb 2024 11:04:00 +1100
Date: Fri, 16 Feb 2024 11:04:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <21cnbao@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/filemap: Allow arch to request folio size for exec
 memory
Message-ID: <Zc6mcDlcnOZIjqGm@dread.disaster.area>
References: <20240215154059.2863126-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215154059.2863126-1-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 03:40:59PM +0000, Ryan Roberts wrote:
> Change the readahead config so that if it is being requested for an
> executable mapping, do a synchronous read of an arch-specified size in a
> naturally aligned manner.
> 
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" changes, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low liklihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
> 
> The reason for the low liklihood is that the current readahead algorithm
> starts with an order-2 folio and increases the folio order by 2 every
> time the readahead mark is hit. But most executable memory is faulted in
> fairly randomly and so the readahead mark is rarely hit and most
> executable folios remain order-2.

Yup, this is a bug in the readahead code, and really has nothing to
do with executable files, mmap or the architecture.  We don't want
some magic new VM_EXEC min folio size per architecture thingy to be
set - we just want readahead to do the right thing.

Indeed, we are already adding a mapping minimum folio order
directive to the address space to allow for filesystem block sizes
greater than PAGE_SIZE. That's the generic mechanism that this
functionality requires. See here:

https://lore.kernel.org/linux-xfs/20240213093713.1753368-5-kernel@pankajraghav.com/

(Probably worth reading some of the other readahead mods in that
series and the discussion because readahead needs to ensure that it
fill entire high order folios in a single IO to avoid partial folio
up-to-date states from partial reads.)

IOWs, it seems to me that we could use this proposed generic mapping
min order functionality when mmap() is run and VM_EXEC is set to set
the min order to, say, 64kB. Then the readahead code would simply do
the right thing, as would all other reads and writes to that
mapping.

We could trigger this in the ->mmap() method of the filesystem so
that filesysetms that can use large folios can turn it on, whilst
other filesystems remain blissfully unaware of the functionality.
Filesystems could also do smarter things here, too. eg. enable PMD
alignment for large mapped files....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

