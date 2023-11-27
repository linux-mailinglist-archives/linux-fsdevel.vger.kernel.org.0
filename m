Return-Path: <linux-fsdevel+bounces-3937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF27FA1D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD7B2157D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF3C30F95;
	Mon, 27 Nov 2023 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IsmlOcaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED612D60
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CHmqVTKbadqpp0DEt82dAXH5APdrX4pjdfJ4z6BXKhc=; b=IsmlOcaJhPUgiX9PGSH7LNGfVz
	UYc4lWory8hVkU8Vdrnlu8JswxItBW4JcP7EtiEpr7MgLt4PYkEqqX9Z9H/7nZ/MHrskJR/7COT7/
	q5Va1NfqFznHeQLjDmzvMXaAA+t2y7kp77VYTCknBBTFCbrBxbwrhwa+JU6f5FUphil72OCw9w86z
	3OrHkJY01rQsvC6eOIsSjJxzQ1SHiSNDf4+qxe1ZkGhuzrYxTYnRVdsQWkyp+TIH+k5zkdFGaa0mK
	vFHuJwtLBWdcXQITijlG+Cb5KG8mIBOBOy8fkhPdVUIqxLDL1QGI5bl/09T7kAsuoVPmYT13d6JKn
	TKIApyIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7c9u-002dd0-0y;
	Mon, 27 Nov 2023 14:00:22 +0000
Date: Mon, 27 Nov 2023 06:00:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Usama Arif <usama.arif@bytedance.com>
Cc: Christoph Hellwig <hch@infradead.org>, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	nvdimm@lists.linux.dev, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Fam Zheng <fam.zheng@bytedance.com>,
	"liangma@liangbit.com" <liangma@liangbit.com>
Subject: Re: [External] Re: Conditions for FOLL_LONGTERM mapping in fsdax
Message-ID: <ZWSg9vw/nCzOaMLr@infradead.org>
References: <172ab047-0dc7-1704-5f30-ec7cd3632e09@bytedance.com>
 <454dbfa1-2120-1e40-2582-d661203decca@bytedance.com>
 <a0d67f2d-f66b-8873-7c11-31d90aae8e8c@bytedance.com>
 <ZVw2CYKcZgjmHPXk@infradead.org>
 <9867cf7b-29a1-4fc7-61b0-7212268f9d50@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9867cf7b-29a1-4fc7-61b0-7212268f9d50@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 27, 2023 at 11:52:15AM +0000, Usama Arif wrote:
> By recall do you mean put the LONGTERM pages back? If I removed the check in
> check_vma and allowed the mappings to happen in fsdax, I can see that the
> mappings unmap/unpin in vfio_iommu_type1_unmap_dma later on which eventually
> ends up calling put_pfn.

recall as in stop pinning them on notice from the page owner.

