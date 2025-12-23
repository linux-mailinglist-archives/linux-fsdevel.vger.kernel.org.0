Return-Path: <linux-fsdevel+bounces-71947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1FCD7DFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 03:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEAF2301CD0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D257B24503F;
	Tue, 23 Dec 2025 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hDlmawTr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AD1F541E;
	Tue, 23 Dec 2025 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457138; cv=none; b=jkBVRvqiYc6/xXVVTVAsGy1Mik6Sm9q1eyacAoh8nt5j69BkOH0ye/iYbn/LqILNPB/dQlnExSFzyLa4vQg4348xv05r1SYJZTf4BUDgTu0LW39Cxxwo13ng8/RmsLQiOZYvxLexm7AJzClpUtAJh16XSajjmQ4bLeddxJr82lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457138; c=relaxed/simple;
	bh=aGQcFcA6rVDBuzg6qgXgqURPfKInCJoPm6VQAiDCtL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPnikTmX+eIaRKYm3ywg/TMoykygNr7R/Un8yIXHLXJeLZZmSW1Di3jdkyRPFvon8/KzU3EC5B191FecbAJD/XZ7fElBXzNT6Gp5Ott8SwE0ypaZIzzImMm+2DRFI+gZCkC1Zf2yOtNCpzyNmEYrbZ7XMl+6L7qNXbBAurgd5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hDlmawTr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766457130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P7yuWWW0S7jbDDkt/SoyrOQc7euoUuNF2KjMNdz0I+g=;
	b=hDlmawTrQh21w/t5FT1w29E8bm623kKu36hl1AgVXxRG3SKUGPjlKRsuVbZsFttcJn6Wf15dluZyOw+Nm0TYtVHKN9rmLdfoGDfgW9x00g5LeV2th9KKOCZhidDpu/sSaRrlnzebjjdk9YPVCJ564+G49ppB4HofvtmlGdmxLT4=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvW2.0d_1766457128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 10:32:09 +0800
Message-ID: <665e4ff3-0289-431b-b718-4cf71925fc29@linux.alibaba.com>
Date: Tue, 23 Dec 2025 10:32:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>   - implement an efficient page cache sharing feature, since iomap
>     needs to apply to anon inode page cache but we'd like to get the
>     backing inode/fs instead, so filesystem-specific private data is
>     needed to keep such information;
> 
>   - pass in both struct page * and void * for inline data to avoid
>     kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

