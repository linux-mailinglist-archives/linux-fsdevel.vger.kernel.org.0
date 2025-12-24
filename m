Return-Path: <linux-fsdevel+bounces-72036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BB7CDBA7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 09:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D49302177F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0F25F988;
	Wed, 24 Dec 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nIXDxuzd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D98269CE7;
	Wed, 24 Dec 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766564385; cv=none; b=tqBvDhhKfJox76W/XXkO3zzfvcxJSEMRbvfMCCr3aQSv/KML64LrCwfS2qu9YI2Pjq7NIOOefSogQsspRy7cexI6ghP/xgsEOnoc2dLO5U3FJpS4k37OiK1pigDvZw0pXNZpPuSHXwUzcg0nwz5geVqEiUyZ7N2i9YFBYFy3mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766564385; c=relaxed/simple;
	bh=/vb+kTRQXxV74NqIzAsBMsSAprz5e8IMJSdrh/pUTSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gklk2uyb8g1k/3eC+7R2+byLy6ztph10t+G9LuuYTyt1mY8joMXlNax85vGldnxdDnmtfqFsisUr/QuVEOwgbE09ouEk1ADIhedODPdjZc4t+Sd3ynOId6TMH+fj9Y8gcUDYotC9t5oXVxnabsfZwpzRsPClIRhUcH7h9v++rC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nIXDxuzd; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Poea4D6ZtkRk1wYWsUlI3KQOAqqgo7NAY+cTVCqmt8M=;
	b=nIXDxuzdRAaPHB0ZH96/+tjoYpAIi4YLM2g6XLnrRSQGOybnl4EJQwmKfWdDmwY8LaqQ90dStsFOqzmIPdrlOSWDsL9WjKUtKhmCPG0befEXmvS5spd12sRZ2awjIKT10dVw8Cj+1qlc8rgFKhc5LIgcGweoApOu3gQJ/KLgDhU=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaV2jt_1766564372 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:19:33 +0800
Message-ID: <ce214bc3-4f11-4f07-a52d-bbe5ac385a07@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:19:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/10] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-11-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-11-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

