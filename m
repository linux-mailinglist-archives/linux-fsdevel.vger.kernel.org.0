Return-Path: <linux-fsdevel+bounces-1272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA37D8C26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 01:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98911282298
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 23:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D593FB21;
	Thu, 26 Oct 2023 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IavvdCuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C863FB0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BE2121;
	Thu, 26 Oct 2023 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kNKyr2vdFwrs0u1yAU9PrAKTZTudRp/eXEwLtaEij4A=; b=IavvdCuXlVtA5Zsx/UvnexXJUM
	+wLvkhfhlj3IyFP/gaRWMB8TwauDNFFJ1X1j+zIK/nhKK5yCUnxkvFUTEU6KrkYF7cEnSp0v6YfKP
	JDtYCin46KPUmF0I27CBuTgXP3ASxnxEudQxVNRd6hDPSpGq0+2EQafIkd35lTfdPeN7Xm+Qr3THk
	1MFOBOC264vUBIE4+daH8BFhuOUiODw1DzxwTI608W7FDK6qXibgYBIKPC/BnhnQUAdXG2Y+4fTex
	efJzOvgx48wwwPsHcyAOjNb8maFiinlLT0F6LPzDhTwHFEtTLaGzsFyWoTYzJbwRDUGAbJ4j07MVt
	Y3qC3eDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qw9e5-00FJOt-0j;
	Thu, 26 Oct 2023 23:20:09 +0000
Date: Thu, 26 Oct 2023 16:20:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, djwong@kernel.org, hch@lst.de,
	da.gomez@samsung.com, gost.dev@samsung.com, david@fromorbit.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: fix iomap_dio_zero() for fs bs > system page size
Message-ID: <ZTr0KZnrWdwrSUp/@bombadil.infradead.org>
References: <20231026140832.1089824-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026140832.1089824-1-kernel@pankajraghav.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Oct 26, 2023 at 04:08:32PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> size < page_size. This is true for most filesystems at the moment.
> 
> If the block size > page size (Large block sizes)[1], this will send the
> contents of the page next to zero page(as len > PAGE_SIZE) to the
> underlying block device, causing FS corruption.
> 
> iomap is a generic infrastructure and it should not make any assumptions
> about the fs block size and the page size of the system.
> 
> Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")

Nice!

> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> [1] https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/

This URL jus tneeds to go above the Fixes tag.

   Luis

