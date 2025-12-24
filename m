Return-Path: <linux-fsdevel+bounces-72031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B11CDB9A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 08:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0413530213E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649E32D43F;
	Wed, 24 Dec 2025 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v0wnQmL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D528643D;
	Wed, 24 Dec 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766561758; cv=none; b=p5u0pWVdOg3Ffye/a7M/fzYaTdzxSfrEGpKLWbS8VHmgyj571ur4N68IJ7zkpAS/CcM8DacEd0I6TGBx25gBFudGOpruuvry4ZbPhxcP+6bc4fDbmlUOX9GqhE1G8T3zYTu6ivE7fhDVKWTYGOPBy/CZtgB6Jo3mfjuPenhyJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766561758; c=relaxed/simple;
	bh=zBs8uXmXefHGulrO1IUqSFZabUWbdeX8ag8PzQ20K74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSHGRY0CmjeVlAkFZk8ZAQaCNameFV96FjAooKfVpZufVjP1vk5E2c6vw4xFbLzMGjh5u3Vl7i1CJk7t16nOQPX8IqnH8d/MJyA1ytM3MKvkd8uD5M06aeZtAgH8kP2Gb6nx3a1l9BOjAJ1iOSD5i1NaQlfRsjauFQhsPJxZICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v0wnQmL0; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766561744; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EKclLrJzBVisN2PeDLUkiQ9uaIOQq13bMgXD4yQB+wI=;
	b=v0wnQmL0NEfW3NiuJQQheAdgnV3XqmgVYBrHdSLFQAemH8BAryih6hT1pw42/nT7LfbFOWGOGiFaGJ/BGNAxfihbRt5BraORxCVGgf+1JWJtVsXiXJGbl0g7zBUOGzHgDO3TUDzaDWyaopXAs2F/YypunD0UA68G5ZowZwxlzo0=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaMJ.1_1766561743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 15:35:43 +0800
Message-ID: <93700ebd-7bda-42c9-b718-57ad4710e615@linux.alibaba.com>
Date: Wed, 24 Dec 2025 15:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] erofs: support domain-specific page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, amir73il@gmail.com, Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Only files in the same domain will share the page cache. Also modify
> the sysfs related content in preparation for the upcoming page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

