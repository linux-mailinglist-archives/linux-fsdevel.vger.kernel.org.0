Return-Path: <linux-fsdevel+bounces-72975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE165D06D27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C5BE30118CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822F2798F8;
	Fri,  9 Jan 2026 02:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yFJIcvok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C2C27602C;
	Fri,  9 Jan 2026 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924844; cv=none; b=d5hhOWsNKZQDIR/n87LwPrdtIUjAIu5b1U+6MpjWh3VUKn9lpzc1Y64f1cPovLPc6wilRjm8L6KpsWti98aAkMaXOgZv0KRgcJnvX9be7J0xwLpKZ5Cp18HqRAJHAEx/SClo8WJNI17X5oDp94MAwloB6MCxGbUCHKxf0QePlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924844; c=relaxed/simple;
	bh=hOQanfWYn4q4zUHe7Yc8FZ7Ushod7wJsftPFwtDT+nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwBM6+qBnJjXsPZ13/VRnC1Hskji6cfJoI6D+Ecb5DWNFzkJt8SO+lc9swhbpa+kwS3oi8Kp/RwDiQkp+aOH3bsCxcPGRLl2aq12qgLG5Qk1fFhOg1PFJW+Y5BiM3am2u+zwlkyZujawsxqI+j/aU9+dKAsQVcCa3NMK8XgYU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yFJIcvok; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767924839; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DWQ6k/9zv2rPdmZeXF6RHX1RHm1hSelcRC+JR4wzbYA=;
	b=yFJIcvokMAPIJziuqm4AiM1RVGrbnvGvhNaryiQ8ihEdFz4rk/naUJ7Pv4ZhS2rdaRdlsc7Q/fnDyLvsInfHOfj0msxFxfpS0F4MFVz3kSrC07GL85jGXlq2WvQd5VOJDybK7IykHrn00Dv+oiqvYgC661hMrCpohVN6ZVvskcs=
Received: from 30.221.147.42(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WweQUpk_1767924838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 10:13:58 +0800
Message-ID: <5b9fd5cb-2494-4dbd-8779-82525cb46bf4@linux.alibaba.com>
Date: Fri, 9 Jan 2026 10:13:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: invalidate the page cache after direct write
To: Bernd Schubert <bernd@bsbernd.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
References: <20260106075234.63364-1-jefflexu@linux.alibaba.com>
 <b6cfc411-8d2e-45c2-b237-e79f71016bbb@bsbernd.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <b6cfc411-8d2e-45c2-b237-e79f71016bbb@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 12:16 AM, Bernd Schubert wrote:
> 
> The side effect should only come without FOPEN_DIRECT_IO. Could you add
> this diff to avoid it?
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index d6ae3b4652f8..c04296316a82 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1177,7 +1177,13 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
>         written = ia->write.out.size;
>         if (!err && written > count)
>                 err = -EIO;
> -       if (!err && written && mapping->nrpages) {
> +
> +       /*
> +        * without FOPEN_DIRECT_IO generic_file_direct_write() does the
> +        * invalidation for us
> +        */
> +       if (!err && written && mapping->nrpages &&
> +           (ff->open_flags & FOPEN_DIRECT_IO)) {
>                 /*
>                  * As in generic_file_direct_write(), invalidate after the
>                  * write, to invalidate read-ahead cache that may have competed
> 

Actually I think it's more complicated:

```
/*
 * without FOPEN_DIRECT_IO generic_file_direct_write() does the
 * invalidation for synchronous write.
 */
if (!err && written && mapping->nrpages &&
    ((ff->open_flags & FOPEN_DIRECT_IO) || !io->blocking)) {
```

I will send v2 soon if you feel good about the above diff.

-- 
Thanks,
Jingbo


