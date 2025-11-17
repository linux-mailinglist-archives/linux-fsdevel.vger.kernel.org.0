Return-Path: <linux-fsdevel+bounces-68756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B2C656EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 737594F3B18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC7304BCB;
	Mon, 17 Nov 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o3t4oDlJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF23302752;
	Mon, 17 Nov 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399350; cv=none; b=YPgvt3Kc9ksClr3e2cSPwl09dGjaIob0EdRFBF+WbWkuiBPnYAd/1GyEC6PGvmVGJTkyQyJT20IQPMBzopNbRgnzpW5ukvrvfT4W3O9jfnpuTg0AoCm3BHe4wsE/CQud1kkXEUshH9AM+//QtELFUNdy0gntRfhs54XVT7UrNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399350; c=relaxed/simple;
	bh=3gAmb2je6GDoZZpPAknX+xSrjdFFV7hW2fCBhpf8m/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2MHnt/JJtVoifFSEDdcPxFHOPB2OKuxUqbTJOMiHq8/aGzOXqM5ceJfJ4NvjZMyKyw0tuuVEqmQA7WUBYS5R5zxYeww3a2Txo4fBlSnXb0xL0J32zLfQPzb09puHF95LgO/gRaAWvMlrL+jvl7liPoDIY+xAkuC2DI1n6ZASx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o3t4oDlJ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763399338; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zM/R4Dr9RpUZUo8HSaf8GZKE3kicTTpfzgR/zeFwliY=;
	b=o3t4oDlJkT6tPk3UqF2mdhA5EEG9kbrTvfCs3dAYYA7RwEXcP9LqWiItBAiwWyttVdKpEAMmgaNn80GS8InPhdixsePbTWNRT6goM4RIRyTT3BH4cxrMPfKuKnODiNLEaW0kBWtwefSuh1/qzmfLp6ArxdPHG27Ren7j7oLXdqg=
Received: from 30.170.82.147(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsegVOK_1763399336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Nov 2025 01:08:57 +0800
Message-ID: <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
Date: Tue, 18 Nov 2025 01:08:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251117132537.227116-2-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Darrick, Christian,

On 2025/11/17 21:25, Hongbo Li wrote:
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
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Could you help review this iomap change, since erofs uses iomap
and erofs page cache sharing needs this change, as I told
Joanne months ago.

Even without the page cache sharing feature, introducing
iomap_iter_ctx for .iomap_{begin,end}, like the current DIO
does, is still useful for erofs, as patch 2 mentioned.

Thanks,
Gao XIang

