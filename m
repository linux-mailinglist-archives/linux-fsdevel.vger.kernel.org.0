Return-Path: <linux-fsdevel+bounces-25485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C594C6F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D27287778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9A15ECFA;
	Thu,  8 Aug 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFq0YFlY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0515A85E;
	Thu,  8 Aug 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155862; cv=none; b=m0PwP1kEp1LGsjCNFMDbLwC6fWGBaJV2Tnlh55X/hk3A/sPDOBl6zDpG9EeEw5ShJnw5nNf+8FAEZj299AzW1LXg3oWKBq7yzoHhb8DHgNBj+GzI57a4NMqK29bU2J+yZnndYr8sg0DnuShWCRBE5RQzUb2+M00PBHr5f5VttPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155862; c=relaxed/simple;
	bh=oGeQ/IZ/BAX6uaFiQyDJ4OD/I2YS3n5wIX4qZL0U+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4kkFd00xn8o66Vk/vj95yyPhA1lPK3L4Sjr4SDoPdoQMiXxQwpd3RD2tDpwKrLNJ5x7LqZyCWMDCaRdzxUfMG/Pmiy39mw+5QWvM2V6hX9BJhwVYYEmA3pWUWOT7SKllxEeEE7Y8RpRi33Ve3kUwMV+66QEHwsRUzAUSsBGHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFq0YFlY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723155860; x=1754691860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGeQ/IZ/BAX6uaFiQyDJ4OD/I2YS3n5wIX4qZL0U+fk=;
  b=YFq0YFlYtyxssLasHeZL21pSofO8md4bm0IN+8mm+byNmbljBooK58D3
   VaLjViGpc2h2mmZXdOYRWlKTh1jT/Kc+l+O88hOIBhoNax+tGkjDMAlHf
   cE5J6UlDIZUKhchqYWNo+3VFCjbEgTozK/mP+vUi9uWPw1hkA1SF5nFn7
   dNXuFjN6WHw1RDadRTaX3ubuZTM7ZRDJl/P+5h/lzxI/4Pc63lRFT+Vll
   wJQAbzyF3Wr2Zh6sjc2l8a3EbopCFvduDOzmWN81Fxw2MxiguJ8smQ9c1
   sQdjcivbLkCAYRr2EUif0n5yqGRyhvnGWqbC5WbV1ToLvGWvQL7hEPn3i
   w==;
X-CSE-ConnectionGUID: FuqyU3ZjRWWQTM2sxct39w==
X-CSE-MsgGUID: 5gRQ/puqSL2h9pqdpVnn2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21172134"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="21172134"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 15:24:19 -0700
X-CSE-ConnectionGUID: xA9RCXOqQ96yXN8YSIP2aQ==
X-CSE-MsgGUID: xJKSzS0BQNqlJdF/zHcszw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="80601317"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 15:24:19 -0700
Date: Thu, 8 Aug 2024 15:24:17 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	osandov@osandov.com, song@kernel.org, jannh@google.com,
	linux-fsdevel@vger.kernel.org, willy@infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 01/10] lib/buildid: harden build ID parsing
 logic
Message-ID: <ZrVFkWQU5qpP2yUh@tassilo>
References: <20240807234029.456316-1-andrii@kernel.org>
 <20240807234029.456316-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807234029.456316-2-andrii@kernel.org>

> +		name_sz = READ_ONCE(nhdr->n_namesz);
> +		desc_sz = READ_ONCE(nhdr->n_descsz);
> +		new_offs = note_offs + sizeof(Elf32_Nhdr) + ALIGN(name_sz, 4) + ALIGN(desc_sz, 4);

Don't you need to check the name_sz and desc_sz overflows separately?

Otherwise name_sz could be ~0 and desc_sz small (or reversed) and the check
below wouldn't trigger, but still bad things could happen.


> +		if (new_offs <= note_offs /* overflow */ || new_offs > note_size)
> +			break;

-Andi

