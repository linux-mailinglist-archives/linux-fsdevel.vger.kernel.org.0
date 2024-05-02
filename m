Return-Path: <linux-fsdevel+bounces-18473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731B8B9450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 07:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654701C2105B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 05:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D7E20DD2;
	Thu,  2 May 2024 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMR9I+e6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C31E494;
	Thu,  2 May 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628709; cv=none; b=KP+ZDS+vXLH8TqmN/Se/uKX+PNpml2upBRHHGPUfkDliuBZ7zLfLqdSG8J2ENWoCwTaa/4morETyO5BbjZYMQTeigcLRp8H+7zjb9nDZfv2KSLA/dk+yEN8xSvrA16rQbIConXvzMBbZmxL6CSavGYgOuzmq8ztWlcX8ecNsJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628709; c=relaxed/simple;
	bh=IXN/mfvF6cGl3Hq0J/SzZeRjYZXcjAMPFguqTJ2l1N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeLW9FokrHLFTAZS5NX7yFJmuN44QufARK4rS1AdBOClCBhjFQ5owoWxdtO2OV2iFhCpHFuqg1QvprIVPbvRvbRZEOTkVn5lN9jbbWZqkDdP6Wgo6dWjxALk11TWycwXvpWog6GMp4RVuZi8lBGyIPMiud+0N62ExxLIl6/gNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMR9I+e6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xk8NY8yS0I7BW3IiVNcNaWblOMXw9d4l6MbCzMzN5rM=; b=DMR9I+e6ihjS8ejEzjOFgU2Ctk
	u4cIMWc9s/FKldKGzPfscbmSGHFhGa28QkRh/0/kIdOwQPs7pGZgZbMdSnhhCP1W1d72xzP7Cg6V4
	EbNh/6ZZH36I4f9JX6U4y0Rg0Kz+/qdu8aOA3mnWICgmOuUC8UBl1C51IHUzghjcasWYrFlijEWZP
	KOhKLMoWHxMroa6TljN910WxGRerxgTesBKlhzo17vAPKKkYs/s495zTUG6Mn59ZN5r5q5WsSVCjn
	Yr9YDbAqFD6gWFIyYjtGqt3a8rUHXi/BLmFxEMNIsM5KIVzcH9xk2zYpZQW2msWjITM26JHxV89UB
	CikSHXMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2PFi-0000000BYGx-2wbq;
	Thu, 02 May 2024 05:45:06 +0000
Date: Wed, 1 May 2024 22:45:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-block@vger.kernel.org, Jeremy Bongio <jbongio@google.com>
Subject: Re: [RFC PATCH 1/1] Remove buffered failover for ext4 and block fops
 direct writes.
Message-ID: <ZjMoYkUsQnd33mXm@infradead.org>
References: <20240501231533.3128797-1-bongiojp@gmail.com>
 <20240501231533.3128797-2-bongiojp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501231533.3128797-2-bongiojp@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 01, 2024 at 04:15:33PM -0700, Jeremy Bongio wrote:
> From: Jeremy Bongio <jbongio@google.com>
> 
> ext4 and block fops would both failover to syncronous, buffered writes if
> the direct IO results in a short write where only a portion of the request
> was completed.
> 
> This patch changes the behavior to simply return the number of bytes
> written if the direct write is short.

Please don't combine ext4 and block changes in a single patch.  Please
also explain why you want to change things.

AFAIK this is simply the historic behavior of the old direct I/O code
that's been around forever.  I think the XFS semantics make a lot more
sense, but people might rely on this one way or another.


