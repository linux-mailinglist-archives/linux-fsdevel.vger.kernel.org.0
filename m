Return-Path: <linux-fsdevel+bounces-58988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF37B33B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D2D7AE9B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABCC2C17B4;
	Mon, 25 Aug 2025 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2D1ZdU+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4D3393DC1;
	Mon, 25 Aug 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114484; cv=none; b=MTi2lNnel9nDUlF01SGMAkFN1YDWdOWsCOUD9L8EuShqs7EaeAqxJFDDwyw2Xw7qNxDIOMa3T5LyV+uxdeEenpTAOeYX9POHxA5DKunscIx9w1sDFKjnPJa7TKLhCsy62/gL3MMoLlZcoIJ/bpWInG4odrIBC9EyQTl0PDAntog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114484; c=relaxed/simple;
	bh=MvtAWtfKPb4hnTohO5qtneHIrMJbGiqKJhIWV1Rvf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWaSGIwfSUMD7f/5rqGeQZmgduv97D19rrvtGTW1Mw58X2D46+ZQN09Jv4ab6h+MlUha6nU7jJEp8Wph4+/0xvwdKiqwCM89X6FcgpmZTutRQpyzB3j2lOxbjxjYft15yB1pTaXescg3Rk5tqjEM0fZJgmPnTTVUGxvrvZDL7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2D1ZdU+k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Nqg/rQBOOl0cufmDMreXF7fdBPqq2mi8wohNeldYaI=; b=2D1ZdU+ktlNflPPjejftKh3Mn8
	h4X9jpME7XeGjhT0l0gooWMmZQcv/6Zk9NWl1H5MFmyxTgcYNTzu7kp6KWHli4cSWxE+yVts8fy1c
	PPyMn58Gi3wlpt2tCOxdlEBSp7qOaPCQ7wXZoc+7m0VNx0T5KezrlbL/0dXWOrgo+3EIh4J6NmSOH
	48CL/sMRL1ieDB1atuBq4q1RfuRdVPY0xGnuf8IDbzELVqKrKSOakk6mVy5D9HpR0/gcx3alSe/Kj
	FykC+KtgQimMR0DIL0Ld5VBDF7yBn27mDZxTwJ+sv3ykyvlEOn03KdEmUIJ8kfzPLS4d9XBwZFFz9
	YfgcUlcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTaw-00000007Vkl-2L9D;
	Mon, 25 Aug 2025 09:34:30 +0000
Date: Mon, 25 Aug 2025 02:34:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alexjlzheng@gmail.com
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Message-ID: <aKwuJptHVsx-Ed82@infradead.org>
References: <20250812091538.2004295-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812091538.2004295-1-alexjlzheng@tencent.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 12, 2025 at 05:15:34PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> With iomap_folio_state, we can identify uptodate states at the block
> level, and a read_folio reading can correctly handle partially
> uptodate folios.
> 
> Therefore, when a partial write occurs, accept the block-aligned
> partial write instead of rejecting the entire write.
> 
> For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
> bytes are 2MB-3kB.

I'd still love to see some explanation of why you are doing this.
Do you have a workload that actually hits this regularly, and where
it makes a difference.  Can you provide numbers to quantify them?


