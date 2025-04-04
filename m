Return-Path: <linux-fsdevel+bounces-45729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9FA7B8D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B0607A7C6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40B1990D8;
	Fri,  4 Apr 2025 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tqgQ+ZAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879A18BBB0
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755191; cv=none; b=bVZbtlMAUSihwt+yKZEL6gLVRMVslFHBDuYUnKepJJT/5AQpGBqOhym6+Ux1I5UX4jFYpQVMdOeHNJ43rAF7TKOp5asQy1UCNVVTpK9MEx3TOxZVIoiGw39bbnZPBx9afmZ9HUzDsSQtLhEfNQ6tNwf6ssc4AaZfF+/h6e3+UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755191; c=relaxed/simple;
	bh=8sVFAFxEvNmewWXZjEVgR8PsHqiJuhYGlG/GmOaU42A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8Ng4DdPwa9FQ+nCdYAeTqHNXSp3Wkq440iPWhtVmlaNGVCsx5Nv2ZMnIlT24iNb1r6+ful5An4P7WKhM/VbVnWCTHk+Zr3DoctXF3qxWNjurWZdfrzIyzOhdLgmlxS7Ar/yOYYX5ZG5FQ4bvUd/pxlPpsbi7AJBx0nsnmWhOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tqgQ+ZAI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oraxD8aMa5Ju/0vnsP/hcRb2KGBRetYjxu8XH5KcdDM=; b=tqgQ+ZAI13WIHA+fNSs8NHoX3s
	z8IJ44dv8nuoiw+jyiPTGW3Z5EeB6WUPInEoTrNeMSTCbxHdIZna/wHMGBZNaDzpo+HpdqXgJJK/5
	aciJdw8KAQLtbNDnRLOM8jWoWXhSQnynFWRdspyjR/pLUt5h1D0eym8qq1VLb+wFuubsrKmuemtaH
	QuMQ7YALe7p0d+SyyVrg+0SpKbTx7D5p5WxzNabWNKf5g/DqNyoq8Y3GpYGrIpHcXpBHaMYsjkki3
	JVkGvBXTOKb4dGnk0nnRhs//xR5ZcFPTyvm5wBMl7+pPavcxeTEKVnpUvgMRO2oofwedE2ul/zqKS
	jDCzOKHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cNh-0000000B8KM-1Xm2;
	Fri, 04 Apr 2025 08:26:29 +0000
Date: Fri, 4 Apr 2025 01:26:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/9] i915: Use writeback_iter()
Message-ID: <Z--XtaM7Z3zbjzAu@infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
 <20250402150005.2309458-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402150005.2309458-7-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 02, 2025 at 04:00:00PM +0100, Matthew Wilcox (Oracle) wrote:
> Convert from an inefficient loop to the standard writeback iterator.

Not for this patch but a follow on:  we really need to improve the
abstraction for using shmem for driver a bit.  Drivers implementing
their own writeback_iter based loop is a bad idea.   Instead the
code here in __shmem_writeback and the similar version in ttm need to
be consolidated into a nicely abstracted highlevel API in shmem.c.

Similarly for the mess these drivers cause by calling into the
write_begin and write_end aops.


