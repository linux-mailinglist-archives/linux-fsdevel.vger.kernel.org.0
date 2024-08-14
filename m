Return-Path: <linux-fsdevel+bounces-25880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BA9513F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184B31F25306
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB056F2FA;
	Wed, 14 Aug 2024 05:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VaShOaTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3538385;
	Wed, 14 Aug 2024 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613795; cv=none; b=aElkra05axZp3Vqc0QPXNdUUVDd1An2T/k4ZanV/i70f3takGBn/mwov3MD7LXVbHWVkRXDWYdAoG/g6/pIj02tueyRPHPZQafqJZdVRkxYyCysjsQpVcILu6FwKTIcIyf09zMRI1eGDnZWkd0QaqJTb9AQIdbxDn6lrQ0wjHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613795; c=relaxed/simple;
	bh=/rAEJs1r0VD4fmwlanwnKSDqoQUALUIzkvQEReJ6Jvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTbxTd+AQf3wnJMXINR4lltab1DeotJmCQCD6Mdl/qyledkys7Bqrk2CebpPheTfzec2rLVSeLg/dbni5iCwMR8PmD38pU8X/EKeZnUKwU0PJVippWoo1z3Usyn0ldxvYfD+dsk7+v5Jxk1APyRoy0euOy1RJMY3GgjWWU6RLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VaShOaTf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xEfWbo8r2cyR9oaWqebE1Q4YcRl+hmd5XVA7kyPWT3I=; b=VaShOaTf5lfz3eoGIoM2Zqoyk+
	GpoKDkROSOU/YhGjjqEvAb3i4qE2dzzDu2ceLytVmzakSVv2i9pkVLMPuK2XIalOqCBdQDy7VFEXs
	7fDLSuaillPBuDTAHHRWdB97GEq2Ft6uDWfE1GCqbCQ6nROU40R1NjA81jTgA6HPKlwRvGg2Loe7j
	g5+xPWtIN1k1zJmiIeQLtnWgCz1cSYaMOsi2KB1N7Uq8LBFfnNAHRUIPMnArRpdRpRGmtgX/pR45N
	kM9YhMvpuM5L5PHUW4KiVjHpFN5fbD6Mntda234wLgWeNv0I4FzjOOQ4sOVvjVhtU4k4ePmAfEgsy
	TNYtAiEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se6gT-00000005p9e-2EX9;
	Wed, 14 Aug 2024 05:36:33 +0000
Date: Tue, 13 Aug 2024 22:36:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, jack@suse.cz,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
Message-ID: <ZrxCYbqSHbpKpZjH@infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 08:11:57PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
> folio by folio_mark_dirty() even the map length is shorter than one
> folio. However, on the filesystem with more than one blocks per folio,
> we'd better to only set counterpart block's dirty bit according to
> iomap_length(), so open code folio_mark_dirty() and pass the correct
> length.

What about moving the folio_mark_dirty out of the loop and directly
into iomap_page_mkwrite so that it is exactly called once?  The
iterator then does nothing for the !buffer_head case (but we still
need to call it to allocate the blocks).


