Return-Path: <linux-fsdevel+bounces-43361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C17A54D63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003263A9C38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448D15FD13;
	Thu,  6 Mar 2025 14:17:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC021487C8
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270646; cv=none; b=dlN6xsQLemaua6i0EPdKoR7hKQ26qJpf7F2MdJEWEVb/wXAFNcenWQs08rF7SqB0s79XhGkNS4RgBCgbPu8b+/BbMNRNtD5LqEyuUAi5YkVIKULKGjZnc/3yTmivXCrBp0b77ELaYMNwNDfuWbh/KF6EpUfWLE/dHGHK4xaYqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270646; c=relaxed/simple;
	bh=gP+bRMDLabVdKkg9fiGZtOotPXrC1J1nOUqUpfoGeIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcAebmeeBYtqqDHK4fFZhr2HN7VebBUZ9Mvrlh3SI+pRqte2R1ClzMrh0bVltc2nq5KDj4BnGVmZcjwa/PS/IvP+42eaPcDfDrLwh0QNsWrAam7DbFphBOt8AR9LnQvSNVuAD8bYQUUKLryzLcuoNbKYW08qm05zBhfanOAIo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id qBuxtGkbUjsVIqBuytFtDY; Thu, 06 Mar 2025 07:09:45 -0700
X-CMAE-Analysis: v=2.4 cv=ZNgtmW7b c=1 sm=1 tr=0 ts=67c9aca9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FXvPX3liAAAA:8
 a=70GUUZxsgcFP8lEI_bwA:9 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <ae31e0a6-7cea-4f76-824c-d8f5ae97c101@squashfs.org.uk>
Date: Thu, 6 Mar 2025 14:09:40 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: Fix invalid pointer dereference in
 squashfs_cache_delete
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>, akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250306132855.2030-1-zhiyuzhang999@gmail.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20250306132855.2030-1-zhiyuzhang999@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOnnLoEViXSynWXN230Yh91rrSC3vY400r6+cgUzL82cHjJv3lYTHvjI2Zl66DgPVd5qnLbnpEENULljH/6n9sT6NzXqs1Ed41CZk5FwRFOhihCo9/qi
 b9xRshh5R0vJayXGz2zWHq1aQ4zewdEe8mTW2rVSvNg7/nZGLBHEScMiwznTpnVWvI+iJ7GRgd9kObk0cmVMrj97rO1rwLCcsurc1+4fxGZMFEd/L58L5AxE
 AlwRvps2xl+oaLsPLoob6UNvNAdfLDYw40k/BP7qmMuzL8aUsGna1cPa4UVdXorKqu/ZTcvW8KzIppznlt5qhIkV4+RsR3l+EZ5YEdkkbrE=



On 06/03/2025 13:28, Zhiyu Zhang wrote:
> When mounting a squashfs fails, squashfs_cache_init() may return an error
> pointer (e.g., -ENOMEM) instead of NULL. However, squashfs_cache_delete()
> only checks for a NULL cache, and attempts to dereference the invalid
> pointer. This leads to a kernel crash (BUG: unable to handle kernel paging
> request in squashfs_cache_delete).
> 
> This patch fixes the issue by checking IS_ERR(cache) before accessing it.
> 
> Fixes: 49ff29240ebb ("squashfs: make squashfs_cache_init() return ERR_PTR(-ENOMEM)")
> Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CALf2hKvaq8B4u5yfrE+BYt7aNguao99mfWxHngA+=o5hwzjdOg@mail.gmail.com/
> Tested-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> ---
>   fs/squashfs/cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
> index 4db0d2b0aab8..181260e72680 100644
> --- a/fs/squashfs/cache.c
> +++ b/fs/squashfs/cache.c
> @@ -198,7 +198,7 @@ void squashfs_cache_delete(struct squashfs_cache *cache)
>   {
>   	int i, j;
>   
> -	if (cache == NULL)
> +	if (IS_ERR(cache) || cache == NULL)
>   		return;
>   
>   	for (i = 0; i < cache->entries; i++) {

Looks good to me.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

