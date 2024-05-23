Return-Path: <linux-fsdevel+bounces-20054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD58CD4CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096AB1C211A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB114A4F1;
	Thu, 23 May 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eP12UAf5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FB13C66A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471270; cv=none; b=mpkFGnSSEmjx4FBR+NvybQwl1eHMha3URDo6XA5gCpuPz5BR8IIMgVGu/7m6HXBhpa1PV9M22k724YPM2JdimMPdVsflQ8SPcxPuXYeF2ZXr4ko9d81NlCbCynVnYTB+LY16xu9KmIglTQueZg2myf77l/4p00DswhJacRu2vzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471270; c=relaxed/simple;
	bh=bCRMbB6cekUI5JM+kJI0vRo4bpBeJF/xEBIDouelZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSHBPzFWePIhAq7BCvupsCGrSo62QqbGfvai2ypurJyK+57vVcGblrvt6EBJssnbue7P/nXSNkajryZ+VWel/yJxtVN6k+omCNr4hvZoO2A4Wrx+FtvGmvFDFoZMbrSRypNG5xuGY8TDwt0UW8OlfCVAkpnwi05Yu+W4J90W/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eP12UAf5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xbWCCbwQjO7X+s9ZGQYW4un8Ki/8nZzTUt6+z7BaPmU=; b=eP12UAf5SMVZd8Gyh5RzJNu44Q
	3iDf3TYgwzwJF8lHsfODEXBe7IkN0BVHVZZJEShBGwNHjjsbYSHAbbBHamJCi9b9axKcOICc5G+7C
	sQm2wuMqurux3F8gIoSxw4+oiTNNp42llcxbv+2paPoBwu1z5kpe+V4D21u1HKV4ns7z/og3hCBV9
	Jo8GJZDTpp09DX6xKTqaXqNnpKcb/2rpsqe+1Mk6idQY0I9j5JNQE5zqfpqVIOB7iY+Vv7JaXywEs
	aHLs52SryLhu9+Gle33VsOytnwFK/U05F+uxf+TlQ9YGQBuLqYauhX7QqqwvfALY9HyOeeXq+afNX
	AIxnuY/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA8aR-00000001n2t-1qy3;
	Thu, 23 May 2024 13:34:27 +0000
Date: Thu, 23 May 2024 14:34:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2] zonefs: move super block reading from page to folio
Message-ID: <Zk9F43It82lvM3Nr@casper.infradead.org>
References: <20240523130153.27537-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523130153.27537-1-jth@kernel.org>

On Thu, May 23, 2024 at 03:01:53PM +0200, Johannes Thumshirn wrote:
>  static int zonefs_read_super(struct super_block *sb)
>  {
>  	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct address_space *address_space = sb->s_bdev->bd_inode->i_mapping;

203c1ce0bb06 killed bd_inode.  You want

	struct address_space *address_space = sb->s_bdev->bd_mapping

> +	folio = read_mapping_folio(address_space, 0, NULL);
> +	if (IS_ERR(folio))
> +		return -EINVAL;

Wouldn't it be better to return PTR_ERR(folio)?


