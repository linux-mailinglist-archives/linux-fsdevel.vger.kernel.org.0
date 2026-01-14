Return-Path: <linux-fsdevel+bounces-73758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B085D1F8D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B15630090C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8D30E0EC;
	Wed, 14 Jan 2026 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e+idGHda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7C2DCF61;
	Wed, 14 Jan 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402445; cv=none; b=DxQa9QFOv6u2dO12IvJWU9IIwFfAd0U/VpRPNrfHX+c1M8BQEVeqjA3i5kb+ioo6XRO+16qPBQAtAFFYwT21zOBmQpbzSGMHZZ5W8wWNYLK//yD7yz6QY9lC+7Nmgzc6wK6js+QqoHLT9Q5zIBJ3oFYfyITvnsvSUULWCldfx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402445; c=relaxed/simple;
	bh=moIIOY1gpw9EpZvC+45GRxxo7lcaye/cg8ULx/EYen0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHu3cNpX8NTDG8p9WjvXQIXndLRgjEZS0Go6fniVvyuQ0hkLWBD24k1PIeTw9nQ1m545xOwgmskYyHGBGQHQqn2Mre8ZjQox8SxNwqJAuO+7GU6TNZXH7j4lPisb+Wb7s1BVM7dE63KRmuwqWSFh0L/G51hk0pc4hVcoJzqIYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e+idGHda; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768402433; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NBHzWnw/Bz1netRes1MD8Dx3Xm+VZaSz/9OEB/xBLNA=;
	b=e+idGHda0zZ/Pf0y5/zwYlW1bbW60id1eIY6+y0WjEoeHgAREgAt9YmNgTTvMWOP/1qfCx8Q7zMswJRZhdwuOxNx2sGvT9b++Wth1YpTJEYmRugWRA7p12znsjiprtEgklelNpc/CidLAm7R5bUWMLKgd3tAFKeF3gw4qv4LalU=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx2jwhk_1768402432 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 22:53:53 +0800
Message-ID: <615134f7-fcfd-44d0-b895-dd5a4901ea7b@linux.alibaba.com>
Date: Wed, 14 Jan 2026 22:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/10] erofs: support compressed inodes for page cache
 share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109102856.598531-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/9 18:28, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch adds page cache sharing functionality for compressed inodes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

