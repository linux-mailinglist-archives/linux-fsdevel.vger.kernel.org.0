Return-Path: <linux-fsdevel+bounces-34953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557979CF108
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 17:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CF8B34550
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B71D435C;
	Fri, 15 Nov 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8PqZktV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C61C07C3;
	Fri, 15 Nov 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685961; cv=none; b=ORC3L3GrjCG81khjse0L8Z6/90/Ot/19GEj7ePkusPupBBRtaGfCNjNC1aqp0atJiLB4YO2IVKtJNdBvUOQlV45biSfc5zRbcrNWOvt2SO8zFp3qmynifFRAGgtmC1EFqD71T6+mFmYBwdOmviRT/2kz83vA2mNZQy3tXN3Sh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685961; c=relaxed/simple;
	bh=pXPwGiY6ZahzSG9hx9W4hCF3O8g/5+71d3AXALytPfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gf+DGJE59ugsic479yIWDqm2qTr5iNYCnWm794sV/oz2i8H6JlsgHEj0HCc8gt+by1KcrzyzRPwArh9IEyYc94sv3eweTjKbIt2elfpjnlJmLkecWfEP4wPwUsvIYJFsDn84EHzzdcf1JTlFndrXzHzj2pqfrM20TGaHD5YRT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8PqZktV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1543093a12.1;
        Fri, 15 Nov 2024 07:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731685956; x=1732290756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mN7g2gHiaSOhWfvm7ZnjpAw9qkNOQF8YTr8uTh3XZAA=;
        b=c8PqZktVXVQSKxCRunTSOxqs8zj32Y4yKKTsHyFVrqvRXnHqh3KQuHD1wlpKIRd0dW
         DsUz0ZIxyYZxn5glbOjLh6vz7LfphcAppeEz4dzCzXHcNRxJcrI8atYeMIC/lt2dlhYC
         806pzwIOnywJu5NN9KIGZg7ihGeU54mO9988hqtQmvw2wUwmygq+6ljsjfpuaEOrAOLI
         mbcDVYFShYqnbQ6i3tL+hag+ikpNaphCRR/xLhZYNJoK2sbibAiqyiMnlhvWsncJg9kO
         Adyoe4RunSQRR1CiFkx9/AZWHTJCJUGhwxlBVzmo5JL3iDkhp9tTCJMJWBcoKv/4mqsW
         6aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685956; x=1732290756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mN7g2gHiaSOhWfvm7ZnjpAw9qkNOQF8YTr8uTh3XZAA=;
        b=w/zdAqRG8Y4Rz9X6D3yEFqDtvzLsXTky/SCe8OLfEqGf5X9KsFuM8mcrdaM5l4cLWo
         w0MDjrxOhweQfZ8uwRMh/vFASgLS3AKxE5UwP+LPv7YSXvgrTJOfK7l2HAJRNfABBNbe
         6sEhgSXELwh3JS/djjBAP1beSVzaTfvDxP3M3rbQMjoSjwVjuwmJQHNKgJ2iWD04saAb
         qv2ecI3CCD4zDC6iiS+0Rx+sDoJagkyw07l/+l3m3hMgMKSIqPvSJGT7zbsuH1Avwh7y
         opDAIAgu1hb1ywwXcXr0sv7QtKZyv++NT/ZNMzG+rqNEk2UyK7o5xdlagQacIzIU95G7
         qy0w==
X-Gm-Message-State: AOJu0YzBKGGnoYfIwP+tA4F3qRpIauw8zvzWw/TIYP7lh+R8bTdNb593
	M+V+7SAUD0i+rur4Qv6J9U3lPtLvdduOQuGJMKyItgs8kytdowsN3V78c4nKDfg=
X-Google-Smtp-Source: AGHT+IHxKS2bvHVhPRdClCTHRndZZWwGMbGXbWceEWCnJM/VVBfTMP2iPk8e+y8YTQ/ziCSnQ21IdQ==
X-Received: by 2002:a05:6a21:32a3:b0:1dc:96e7:5219 with SMTP id adf61e73a8af0-1dc96e75271mr1909657637.11.1731685956217;
        Fri, 15 Nov 2024 07:52:36 -0800 (PST)
Received: from [192.168.0.198] ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c67a41sm1438045a12.49.2024.11.15.07.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:52:35 -0800 (PST)
Message-ID: <e43ec7eb-6acf-41e3-b7f9-f0391bf4cb65@gmail.com>
Date: Fri, 15 Nov 2024 21:22:31 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: Fix uninitialized value issue in hfs_iget
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
References: <20240923180050.11158-1-surajsonawane0215@gmail.com>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20240923180050.11158-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/24 23:30, SurajSonawane2415 wrote:
> Fix uninitialized value issue in hfs_iget by initializing the hfs_cat_rec
> structure in hfs_lookup.
> 
> Reported-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=18dd03a3fcf0ffe27da0
> Tested-by: syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>   fs/hfs/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index b75c26045df4..3b880b3e4b4c 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -20,7 +20,7 @@
>   static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
>   				 unsigned int flags)
>   {
> -	hfs_cat_rec rec;
> +	hfs_cat_rec rec = {0};
>   	struct hfs_find_data fd;
>   	struct inode *inode = NULL;
>   	int res;

I wanted to follow up on the patch I submitted. I was wondering if you 
had a chance to review it and if there are any comments or feedback.

Thank you for your time and consideration. I look forward to your response.

Best regards,
Suraj Sonawane

