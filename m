Return-Path: <linux-fsdevel+bounces-50282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A6ACA8BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 07:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627F23A5B04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 05:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FAD17A31F;
	Mon,  2 Jun 2025 05:03:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFCC2C325B;
	Mon,  2 Jun 2025 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840593; cv=none; b=rw0jr2BdqkyKt04ejxRaTxJEg7AOX3/yabjabHV6W+9iSdKR0tHpYt/Zl9Csd/VRuAt1TPg+CekIT8S/kjSnLCldBP59mlJt/eljcIQ7O2ocQkiEj60xv1owzLHoOvL37rrv4HqH97mxkXVME4M8WQ8OMBPANlpYPR0mqvIYJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840593; c=relaxed/simple;
	bh=ZW5f+q6Wbl0Dgpfr0/2chECrrdMKRJgsgaeagUlFSQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ8LantjiCO3zHSlkCmHDCN/15mgsrVre+jL/veUGJ74txIHbYiQDnXbzEFAU0//DuWTkCiTZOJn8PwfufzDUPgKzU4Twzm8o3GkUgfQhp+LsoGbUHs+ouPWr425NgJCYoia14L2IPdKHF3HMap09dUZPR2IMS3YsGRj9cpUY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 635A668C7B; Mon,  2 Jun 2025 07:03:07 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:03:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	willy@infradead.org, x86@kernel.org, linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de
Subject: Re: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
Message-ID: <20250602050307.GC21716@lst.de>
References: <20250527050452.817674-1-p.raghav@samsung.com> <20250527050452.817674-3-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527050452.817674-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Should this say FOLIO instead of PAGE in the config option to match
the symbol protected by it?


