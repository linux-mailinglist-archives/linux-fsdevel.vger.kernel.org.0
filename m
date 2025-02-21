Return-Path: <linux-fsdevel+bounces-42219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456AAA3F2B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFC33BD741
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9242080F4;
	Fri, 21 Feb 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sZ4HO3ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A3207E04;
	Fri, 21 Feb 2025 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136212; cv=none; b=Al5ul2L/2J2xK0lHxABqMcwgIJvwMpPk3Yc7RiOnBOkXEOerUM5ppptwpCDGeYfUdjGSYwNcFxcufQN9UFoAxfnD6sEbqetnnd8yMZ9cJyn0L4J7qrQStx8t3PvEPK0vK6YCed2FBUubXY2rS3YGvO/H4AxRizmVHJAyknBBEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136212; c=relaxed/simple;
	bh=hjXDGoT+hOomjbv8cAAK4nM/3bD91dUIboriw9kRQos=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fobPJul/bfWFDuUzf5nwpc9hczmLwJMtniPMUXrUWnSL4XQGxWYdd3pWArdT8Cex9RPvNE/qYSkN1VVqc7RcJ4sTL2Sle7OHdwfxWFxeOamwQAGpRLUp27615HrP8qnQsFOCbt74kd6wwk3dHGgrFBzPDn70N3zJNGTZ+pRPgXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sZ4HO3ik; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740136200; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zOrQAAS8CZFLit4/3yJGBz17ImP6kw+Q4gm5LXpK2co=;
	b=sZ4HO3ikxbqz7C3nbHYuS1ee2We55gIKS6CpGbUJkIriM9ZkHzr/Qfh4LMJgYaS2qsrpJSZImQ6qCMHu67ql6FCe4n4MkGafLlaSEVGkS5gj+HR03GpzL6OhlSw2301uO+Yy91W4NAFC+RkoEUEXhSUtlnDvQYlutX79CBnpI9w=
Received: from 30.221.145.73(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WPwGwIh_1740136199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 19:09:59 +0800
Message-ID: <38ac7f54-2e72-4878-8ea6-3a8ad57e07ca@linux.alibaba.com>
Date: Fri, 21 Feb 2025 19:09:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fixes for uncached IO
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Christian Brauner <brauner@kernel.org>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2/18/25 8:02 PM, Jingbo Xu wrote:
> Jingbo Xu (2):
>   mm/filemap: fix miscalculated file range for
>     filemap_fdatawrite_range_kick()
>   mm/truncate: don't skip dirty page in folio_unmap_invalidate()
> 
>  include/linux/fs.h | 4 ++--
>  mm/filemap.c       | 2 +-
>  mm/truncate.c      | 2 --
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 

Would you consider these fixes?

-- 
Thanks,
Jingbo

