Return-Path: <linux-fsdevel+bounces-57307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10646B205DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0B442354D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9949D22A80D;
	Mon, 11 Aug 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnjrsA1x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F5199223;
	Mon, 11 Aug 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908817; cv=none; b=PLOfg/F8fJDx4ro18ZyeDr+TVj00Asl4GTjlJVCxiXeZUQficgXAf6HOh2AvrqwWIGRdhDhB1UUCbBWmI32xXby/baWYqeL0Ygtd/+jr69LLQqSgPbMCx6VTHMmJykI7dPOUB89DE9PhvsVkSorjy+z8GAFa9aQfeein7IQqFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908817; c=relaxed/simple;
	bh=om6JfWLZVRtvDi6qNqPmHdco7kV0RdKCRgDPL5ahG1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE6ATjQ+FYoiTXAn8JiBYXJKkS/G9zYkqLO9tLLm5/7nGy3ImenVu9doNg/XQJdhvBddlQDrwb89eTS4q0U0O7J73PtCK5R/qJgJxIh0B6+hRwibIwAjhXrx2/gdzjyqDHC2bseAROx/NHwVhJr4ImhdWvzKzTpjO54aRWs7ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LnjrsA1x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rxwbTT1FLodYXCESWkzyM+gC4qGnfhBJn4uShisd0/Q=; b=LnjrsA1xHawpQtpKPMDZjfsifo
	Y4ZPCPk5BFihu8i8u3Jb3lTn44OyErWjK2rLQDJxVb0uka5noLgo5uHytJi5c2PLU1p+0NTjZmnzr
	rzttM52Bq1L15z8HM5S1/Q4KOKMv5vxqFTcD5aIFsYHq+nG5nyZyLfCq6rI4l4W3Bt+HG+WP8iYaN
	UXu8q89D5oMIl8Fe9knaeTT5yGrlrQ+RUBdMuEH5f4UhkOa2shZI73cmx4knC/OmWaMWQesTblYcb
	tjIov5+tXMkgjLutyKW8bYgj6WSZ7fcxXuH1S9OuQ67dtwwG1mSm7riYi2umAMxgt4yM05NmajqyP
	UqmqyTCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulPwj-00000007MSe-29H2;
	Mon, 11 Aug 2025 10:40:05 +0000
Date: Mon, 11 Aug 2025 03:40:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v2 2/4] iomap: move iter revert case out of the unwritten
 branch
Message-ID: <aJnIhSpBzoWv_kL0@infradead.org>
References: <20250810101554.257060-1-alexjlzheng@tencent.com>
 <20250810101554.257060-3-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810101554.257060-3-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 10, 2025 at 06:15:52PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> This reverts commit e1f453d4336d ("iomap: do some small logical
> cleanup in buffered write"), for preparetion for the next patches
> which allow iomap_write_end() return a partial write length.

Please provide a reason why you revert it.  As a courtesy it would also
be nice to Cc the author of the	commit.


