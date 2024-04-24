Return-Path: <linux-fsdevel+bounces-17684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0658B1799
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 01:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB0B23811
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2F716F831;
	Wed, 24 Apr 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="igcTIqHM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A816F292;
	Wed, 24 Apr 2024 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003151; cv=none; b=grgIH9P98q6ou/mS3sCXCNN/Sg7BLtUyem7b6i2ocGOl3KYUZyfANLlkyvVgPMsbkr146z5H0xf6CBmKpl8V3cu7GHiqHCVyQCMhBIsWnsDTCt16vmMm4jeMoV2cscNpz7NxQdcCP0Rb6dCrVcN9GndMzeer52m/yNsA5+EgaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003151; c=relaxed/simple;
	bh=/VuQ2TZ3I7By7nnlfH/Yl/asFP7aAx0YS12Cg+NH+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4G5K8mvR/hNvHHdqux/VlTO3r2eNjr72LNyvvOP5DcuUSyOXUQ2Dak+1bl/K3AGyWQwYkdOZd1jVkFV9F1L4MgAI/FzSPBY3OxS+6sdc88GF33Qtv/QEEzPZj4wgbEk3TydHcr6RRbJO69L5g2acpOeaTWGcuxXT8G1/dtQhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=igcTIqHM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vNG9QqElHBsq1h44jED4ysNt8/35kOzYfpgTExkMc2E=; b=igcTIqHM0RfUK1MeyaDix1TNP0
	ZwowTxoD2j9tUNWIzPpqEVnl0G0D8+fvjPtAQC8fzyCq1Pv1/maLu8N4Safh1O9uOrq1zcuQBGKmX
	qYCETvKlaZI+4P5NYWghu05eTa/CAO+ol1z2xNzWYc5Yg03deYfxaLzB7xQpU+DIPecm9S5Xj/lvJ
	zsPSyLcgVJ2SdZ/S4gA69JKH/dVLPaKvuf5Dnweg3281KfEc3BbXBLDUwAIAoiQ3vXnF1WfpMmCiN
	lRJqCz8/9lC2FTBiBDf+VWYofEBq7JK2luLR8SxZh3UpR+tEDhXVYXxW7mKm4/IHYvuTM+z6JcU0F
	UAjQCT0g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzmVz-00000001wNo-0OuB;
	Wed, 24 Apr 2024 23:59:04 +0000
Date: Thu, 25 Apr 2024 00:59:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/6] mm: Remove page_mapping()
Message-ID: <ZimcxvN1fyYfpRVl@casper.infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-7-willy@infradead.org>
 <7c52ae2a-8f72-4c3c-b4b3-24b50bdb5486@redhat.com>
 <20240424163423.ad6e23a984deb731e2de497c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424163423.ad6e23a984deb731e2de497c@linux-foundation.org>

On Wed, Apr 24, 2024 at 04:34:23PM -0700, Andrew Morton wrote:
> For some reason,
> 
> mm/hugetlb.c: In function 'hugetlb_page_mapping_lock_write':
> mm/hugetlb.c:2164:41: error: implicit declaration of function 'page_mapping'; did you mean 'page_mapped'? [-Werror=implicit-function-declaration]
>  2164 |         struct address_space *mapping = page_mapping(hpage);
>       |                                         ^~~~~~~~~~~~
>       |                                         page_mapped
> mm/hugetlb.c:2164:41: error: initialization of 'struct address_space *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> 
> 
> I'll disable "mm: Remove page_mapping()" pending review of the below,
> please.

Looks pretty similar to
https://lore.kernel.org/linux-mm/20240412193510.2356957-7-willy@infradead.org/

Sorry, I thought you'd picked up that series; I think it's fully
reviewed by now?

