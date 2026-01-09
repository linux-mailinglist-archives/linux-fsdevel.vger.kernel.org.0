Return-Path: <linux-fsdevel+bounces-73068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E6CD0B87B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 18:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF5130FCFA9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2741364EB6;
	Fri,  9 Jan 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ceboVegt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AD364EBA
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978232; cv=none; b=ftvMy/8QxUFF7yXQpu50CIR50/MddXpTNKuSYU0HD6pDHxoWH1MkaNpTIgc0PDbG8OO+p+42A/O6+4wkkXEa4w6qWbW+GUhOnECfIUO6D6PHQpj1ZDnZGEDGyAi+O0hmvpw6TkF77tDEqnbNQ4XzyZP8y4FUIvLIS0A0g74MIzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978232; c=relaxed/simple;
	bh=aXxH8KsFvCOcvxGrWrHWB8GtMC6vSUV/Y2dfp44NGeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxNYgNx6oDokyuzbp91w8vDljnIfs16q+R4TmfO9Q040a6RIvjHZ+MRrHvDP52X8tSSbpY9kkO3IJkteSAc0wvibKvA0mf+34ZwnVT+g0ofOEsVmTT+c5rv08WHfT1LI8BjFNR6UskhIvuFO9Maio1qxgKerEcjkfi7c2U3LYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ceboVegt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fccbc683bso50740397b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767978230; x=1768583030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=ceboVegtXCbOvmnNp2QmNW0oW6yOL+fOvMlu7QSUb5OKOXsY4gmoTlqnOdcyGyFOh3
         ljn1LyUtiDHlU3YI87wJgJxraydAh3esLo6vpHOxwYpSYVZ59YcaeAAivzmoGdCcAe/H
         SWqg6sHST3ebJsJblSLiodDIwpcJpflVJLh3gSPSYqqN5y0bYx6WJKiRCWe3F3vxkZi0
         yJeoThQxo+ls5W5NZtwM+I/2nurnTsH+UzRVh7fV9fFvxbBuvFmhu6eWvQNmi8ShWRBJ
         UEW5EHDLVmLx/QXv1eP1ru87TF7xf2jfQJzsUb9jNt/sbJvG1ZS3TcGr5XEHlqieR56t
         C9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978230; x=1768583030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyvnXFALVV85dAj0zPDPAtv4QErhsz/aJNW7Eaaf5yo=;
        b=uD5UKDcMKyC4YDrkyKGwjqL/PbviqV6a3dWHcQYVY5o06w3sC3MeVDYNyVF05yPzhy
         7lABXS5cP6qRmZ5hPn26vcvNFOJngOsblK27YS7l1OFuTBvE6dOEz+N3wos9QEVjY+Bh
         2bFT9uyLf5HAj2KcuHclabLIzEy225p+yanN4Xlfl3oDQu8P0ZX0YUz/F0LgQbIvuAXK
         zC6cTyGmm4PCkD4pYy97RkA53elsBv/Tr2BsW+YnD3bJDdg7B5rdaruYI7hV72s4vtsY
         8nUfefVI5veG02i80jgYhFJMZmNmNiqc4l3do++6SZEazl7rCBUtQazJ/hXML6DUV0LB
         6m8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVapEGTYSbUEdyocbhcOdxhHYoG5+mIE+ljzAjBoe1lMI9rDlwA7r35MhjlCMteCxHhHHgPd5R5fk43NEpU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1i9p1wdNm34psx5IyBiNoSZ/vVqw/eP6wazBOhQTPq7EpYiz
	NWrRkAaMwgmp9gfMNUev8ugn2bIobN+F18O7tY7M0l24v1bSdcgdDPh45HDUGOipdkM=
X-Gm-Gg: AY/fxX7vsR7ayGcegomz6mwmiXYNx+6D/OoSmdn9/b1Ef0saW62b1W4++OFfEFyDLJs
	x8Yv8zFhXArKfyZMMAB2Bo+HkxvtVmoNJB8C3BsxoClGXNry0RIYdPpVG4khrMf8nRU72Q9+KMm
	JgErMnCJ9+TXUfrXQZTwm9ygxnKT9DiOr7c3Na+y812Da3QFDbpMkStf96RX4UetWTC9Y68NrHf
	PP47KGIvRV6k0WmeB9NsjFm7E8rqZejBjLBnLRikAjO9+DUgA0lx7YoQbGAcwDsE5Et3oa+gFaM
	0NHP+AEfB3uxxsfi32qJUiFeQydv0DXy6yUD7rjyE6joF2xNpp24X8XnB0MRWuUITRnuwIuSMV7
	Nvr0bPO0xMz9jZx8DJdaj/MhQWS2gPnp0dSP1u/mSHs9VbKUjCqQFyue4sezuPI3xejb/llz8qa
	1Lf77FJLVxwifVr19TOoTRVf2TkMDrU6kYIIiiFtGWrxicyleZ+RdbhtLpEJ4ia+3JMM36KQ==
X-Google-Smtp-Source: AGHT+IG5ur4wn6WRv+wDPnOobb9XgNDN4tAmFs6v5FHNYg3NZYd4D74cNfEP3p2oKp1wSQ0Qs+dvkA==
X-Received: by 2002:a05:690e:4106:b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-64716ba363dmr7881450d50.36.1767978229938;
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907710632asm77625366d6.24.2026.01.09.09.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:03:49 -0800 (PST)
Date: Fri, 9 Jan 2026 12:03:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWE00tFHjyXnNmtD@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>

On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > If a private zswap-node is available, skip the entire software
> > compression process and memcpy directly to a compressed memory
> > folio, and store the newly allocated compressed memory page as
> > the zswap entry->handle.
> > 
> > On decompress we do the opposite: copy directly from the stored
> > page to the destination, and free the compressed memory page.
> > 
> > The driver callback is responsible for preventing run-away
> > compression ratio failures by checking that the allocated page is
> > safe to use (i.e. a compression ratio limit hasn't been crossed).
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Hi Gregory,
> 
> Thanks for sending this, I have a lot of questions/comments below, but
> from a high-level I am trying to understand the benefit of using a
> compressed node for zswap rather than as a second tier.
>

Don't think to hard about it - this is a stepping stone until we figure
out the cram.c usage pattern.

unrestricted write access to compress-ram a reliability issue, so:
  - zswap restricts both read and write.
  - a cram.c service would restrict write but leave pages mapped read

Have to step away, will come back to the rest of feedback a bit latter,
thank you for the review.

~Gregory

