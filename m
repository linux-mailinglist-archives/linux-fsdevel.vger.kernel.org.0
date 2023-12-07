Return-Path: <linux-fsdevel+bounces-5131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FED808335
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B697AB21C45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57B328B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C7D41x5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A4173E;
	Thu,  7 Dec 2023 00:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZrFkvVjmgGqgbYVIpnx13kdaPXXAZZlJh+/DhftTK40=; b=C7D41x5BQlcgnROxpxe2FuMQCO
	NqP32cw6wsk+h5AodZ+vpsjltQ6pmrzcfG9fsTeQ2/7TRT8Bzj5xc77Y5bFg+DjR7qRU4BOPRPsFO
	pkL2rMBszmQcNNiHxSiyBd7BcmwkrLz8fTcQ70BCNs+/MBJT1BXbeFCGt5HqEcnwZ0IjOSs+81JB3
	VOYJ6FlBerKIelhEG6tYS0WEmx05l4+3OPjzjoMAv8OUqmj4IiSqf3jBx/vMVf/2pJQJpyR2Ddq4c
	NUVHcPDOAWcYwPUkWj1sll505OSjhGlzb7q0jKkBY8z/gY7yps4NCeQl69OOFfURPa1DmaIuYE9M7
	lXuKNBKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rB9ev-00CCR5-0I;
	Thu, 07 Dec 2023 08:23:01 +0000
Date: Thu, 7 Dec 2023 00:23:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Sergei Shtepa <sergei.shtepa@linux.dev>
Cc: axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 06/11] blksnap: handling and tracking I/O units
Message-ID: <ZXGA5f0/UqC/OHu6@infradead.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-7-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-7-sergei.shtepa@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +
> +static int (*const ctl_table[])(struct tracker *tracker,
> +				__u8 __user *buf, __u32 *plen) = {
> +	ctl_cbtinfo,
> +	ctl_cbtmap,
> +	ctl_cbtdirty,
> +	ctl_snapshotadd,
> +	ctl_snapshotinfo,
> +};

Please use a switch statement like the rest of the kernel.  Besides
being simple to follow it also avoid having a speculation gadget
on user controlled input.


