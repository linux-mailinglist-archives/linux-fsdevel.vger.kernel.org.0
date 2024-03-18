Return-Path: <linux-fsdevel+bounces-14686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237287E1CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ED41C21D11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F42263E;
	Mon, 18 Mar 2024 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0T/yw6tI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F08225CE;
	Mon, 18 Mar 2024 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725736; cv=none; b=aFPepSViZ6cL6jYDnGtDSw9zHbzjq4essgUTPFdm57w1j1pzKGEKi6hWSWXrU8AecJKHPTHEFHlAWbP775zSsjk34z7jEH6jtFSPtKs9VjQlzFNwwQGaFTIs4WEsm1jKrxVivPy4y+J8ZXtVsq8YwZ6uRG8DE5XGkcIdvWQ4QXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725736; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsEhHe2IzwcjhhHBpyGpVOXY3rVOHNRbsUmki2bU/TQgcqYp5Kap89aBKe2RuATe+ZqjmpJOVS/wyzcYIvb2m2GyI7Ea/TI8eF23rC33csDrLy5DnTAAEDyGu2GzZSOTqgJiY/OABvT3i7yistRooNVklwshDTR4NkIm25WXK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0T/yw6tI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0T/yw6tIFPTOaj4Wjw2BDEzpyO
	35vW9fMO51ITSpr4QltmUKXQ3hyT4fqKoap+XhjET5vlvAeyzyQEMZ31tgIeikbEzhwTXwn61TAEs
	xYj0EBD2SJMDXUVtMnqpD36Au/c72l4THCeVjydLkXLwM9JzHVPVe/vZKx5GMpgZg/+lmnNAN1JE5
	/Z0FOuFPBbLbyY6V6siB0xs5hIloVYq599iQ/tKO8OvI0SZtXm1kft2J49ccVXOMmEcWUcKlj/aOg
	hjySbNA9rk/jybXzO7uRt/TMWw/ztW9FdukdG2e5BK8+bEY2vi6nWND6FTERkh2ButtkviU1syjkb
	z1J1cVdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm1uY-00000006wYz-2GvV;
	Mon, 18 Mar 2024 01:35:34 +0000
Date: Sun, 17 Mar 2024 18:35:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, tytso@mit.edu,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 08/10] iomap: use a new variable to handle the written
 bytes in iomap_write_iter()
Message-ID: <ZfeaZtDqi9JVnzS8@infradead.org>
References: <20240315125354.2480344-1-yi.zhang@huaweicloud.com>
 <20240315125354.2480344-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315125354.2480344-9-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

