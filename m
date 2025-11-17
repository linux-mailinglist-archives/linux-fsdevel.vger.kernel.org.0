Return-Path: <linux-fsdevel+bounces-68635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D9C62453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 04:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF5704E663F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 03:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED93F2ED168;
	Mon, 17 Nov 2025 03:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QuRKytqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0D47A6B;
	Mon, 17 Nov 2025 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351336; cv=none; b=C4l34ZjcgsU24IwcvHB3KxaYIWC/XXISzN7/BdJ25btnSgNJKUlRRgyf5VGTNwDsyCEp6pWLf42zK8ODxDD7DR+08+0t0Be4T9Fyn8fk0WHqEj4MxvYDNCdsjqc+zIN+DfgqJC6b10RrKa97Ku6orEta5LTbPRYV2ZvAGi8b/NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351336; c=relaxed/simple;
	bh=LvCKC5ZDE7RQAosXb/u3EaP67Vqm39o2y2yDRZCuAD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XExls9KguLSHQLTExAlCaB1K99r1IjYNXsTNg8JeTyP7RqdaSeTReJeRp6c5ngCnI+vQVpaIlU358Q0RI4YLmEhHqyV/iuwCXjRDkKDwdQglpnSktWOZOJfa2U19+VhElo80K1fXm71y2wGOUg0CVw4pT6qkHBlJiVsc0O+lx58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QuRKytqP; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763351331; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=53C1WjuCoiCOx/J1UsSfsFlmqf2a5Sh9391jCoDbQ6s=;
	b=QuRKytqPLP3AyQWI9V0RridIceMRr1qqaj+9qDrQXTkanOsSmAf4GumVeEzwSD5a8RTnifDut+dAB5ir2EXYWGTr1s1nP/qXqJpBlOLxeVGlq6IxXtPcjnQ99FxX2Hk4/2j4fM1kBuakMhW7o02oqSf+HVvPk8GHs5IzcnAje3c=
Received: from 30.221.131.30(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsUAZG7_1763351330 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Nov 2025 11:48:51 +0800
Message-ID: <1cdc1de7-2a77-4c3f-b877-f71d672c7470@linux.alibaba.com>
Date: Mon, 17 Nov 2025 11:48:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 9/9] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251114095516.207555-1-lihongbo22@huawei.com>
 <20251114095516.207555-10-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251114095516.207555-10-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/14 17:55, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/ishare.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 14b2690055c5..88c4af3f8993 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -239,6 +239,16 @@ static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
>   	return generic_file_readonly_mmap(file, vma);
>   }
>   
> +static int erofs_ishare_fadvice(struct file *file, loff_t offset,
> +				      loff_t len, int advice)

s/fadvice/fadvise/

Otherwise it looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

