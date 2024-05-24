Return-Path: <linux-fsdevel+bounces-20106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835108CE1F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 10:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379861F217B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 08:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6D12836A;
	Fri, 24 May 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4LaSb5Dk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630217578;
	Fri, 24 May 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716537841; cv=none; b=ZWlrjbGyDjt4o45JPNA+6IsS+VEn07c67PIUo7pRQT6/wO+V4rqxOiM1xOfACWg7hKXKKr52/aNyH0PTRT9WJk77apAUd087HQhO6azK20WfA8JGlv5edYs+JbnjYqVO1y5QIzh2QojosbVOQAKZMQCsfGZaMf3owKtUpfIhsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716537841; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgPaOmabnSobn6htke0h68hIBVQEgnvVD5EqXHwdm8eOmD/mRI5wGC1gNZFlb1UBXR4rpF9HfbzGqpDERLkjxuHlZWcJC+1Kg7WbilR793+t9KfKFiGQQrinHaWmogcNZ23uaG+0gEnqwmAsmCxMiGOo6znZ54hqnLuFcydmngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4LaSb5Dk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4LaSb5DkqD1oMkgAtQaskvPO2n
	4YT6Bj6kYdPTjWSLDVCdrvexHM2yuYX0lSbHquXZhArPwhqM5DdvhhPwnJe9f3T7W+qXoWcLnPLX3
	wcZ1HnNINU7eMlzQ5c1aJjRB/cxdcwiCXyL5h8uW1rUZaGle95saFynho04Jlos/+0KCDlNx8IHLp
	v4om1FBMe6640uSGvVKIvLWobsUYug5MK1Pt1Q93w9cUo7LF5aYRCOuel9kuO5M2FlOZZkG+dMoCj
	KHVnmSTobboSYaJkZcqGVF25r6uEH1zsVwjMXfIJgVpmmwWQJcnPcl1N+lTQ2EzHwE+nINY2dExD3
	mKdoeJcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPuA-00000008L2W-0pVB;
	Fri, 24 May 2024 08:03:58 +0000
Date: Fri, 24 May 2024 01:03:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, djwong@kernel.org, willy@infradead.org,
	akpm@linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jun.li@nxp.com
Subject: Re: [PATCH v5 2/2] iomap: fault in smaller chunks for non-large
 folio mappings
Message-ID: <ZlBJ7muFSIl-rRwe@infradead.org>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
 <20240521114939.2541461-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521114939.2541461-2-xu.yang_2@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


