Return-Path: <linux-fsdevel+bounces-51709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97ECADA7C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 07:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A62816B58B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DC1D5AC6;
	Mon, 16 Jun 2025 05:40:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93AF17BA6;
	Mon, 16 Jun 2025 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750052441; cv=none; b=nBumbYhLWcu98Y7ExxtFhN3OL1URwxGVnhmDV+tO5+RsLWoI7LLXVGADh5ue3D52bHctt3iH+0yY74aBN6dz4MkSxSSwA52iT71RSmEkKADmaLeJ551WIDRM5KL+gIHeB7bbJNb7RAN6OBgmFQOetsW2hhJYAoPhBOtMb0dbYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750052441; c=relaxed/simple;
	bh=zM9L3jCsYS9otA53EROIFxm91VKU6Dqzm/0PSoIh4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjUv0BHd6jCmMrjL+w4YA6TepB5qV805W7wDd9K7ykrtkCdE24emn3xEDhoyteF8goTK3sucnu94QKwlX5rEn0ArTEJXXGn5DSdhlSE12NnboG498PiLWh5WKed6pdbjswGUdjAnGEkqmSzOIOm3r9YICaqgQTOhRNgFWTdYE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2157468BFE; Mon, 16 Jun 2025 07:40:35 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:40:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, x86@kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de
Subject: Re: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
Message-ID: <20250616054034.GA1559@lst.de>
References: <20250612105100.59144-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612105100.59144-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Just curious: why doesn't this series get rid of the iomap zero_page,
which would be really low hanging fruit?


