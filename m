Return-Path: <linux-fsdevel+bounces-17704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D178B1952
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87539B22DD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC81CFB2;
	Thu, 25 Apr 2024 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P16Apjv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF117984
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015036; cv=none; b=uCzgl7HOR1Buda5dM/aMSjpJOfNOiysvyS4Sup7ENFqEHYrtDew5iDb9EEPGgGi4dViP3Jlf9NKvjd33gaNz76j6Fdkxrs/6iWFE1VggpWNS+pSuEaiI0LeAik3zm3+/TURf9fuZQ3Z+l5aCzol9FPXgcIh2HGZ6lN9Rd7ND4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015036; c=relaxed/simple;
	bh=pL8OHOWHZcsyFmPcEjc+fBoaOnXJeZNW3DcIFx6MFus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asjMZqGgir/TKpDaeRTkk70AcYskwbcAJemN153Fm3ryx0dd01XmFavANZm1WiD502upHWKqtCmI7nTtMOsUgw2AFsr9kbQfKVl2qykQeDO5OgwFRTK2xHE1DcAV9484FC7ELmgqWxp0RyuI4BNFB4NolREge/QR7gedl/geIiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P16Apjv7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f074520c8cso627201b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714015034; x=1714619834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
        b=P16Apjv79ZDKsMeWquK73sSlQg9s8QgWLu0QI/QT0qP8hoMn3Ji5qdzct0Y170RN0V
         dgBiOxTGZdWGB8Lkm0xtrFNI2fmUm44Q5s/H1Hmh6mSReBjB0U8t1Ix7ZFGiRzyHhYrR
         /92FG/iQFHLe6Rv4CLdyn26CHZ18sVGZJxlqvcLni8JrDaqLdurYOLMCawMgvaLqUcj7
         ce2F0rYK5nXlSgxyMEouxx9KXOqPDJqqmvkTzyODyqu92RIJWwIw6fn4P+rDU5pK9dUl
         RoJyZd2c4ogQNrQS5aYBSoxwITj7rV9ZsrshAgAemNbrV3qamH2UYfwz4Yldb0B5Kr2z
         F/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015034; x=1714619834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDC6+MkZwtTiyGD4zhDwbs6EKw+Azk2OsJsJxDq9WIg=;
        b=MgVbDl11VFGay7TwGkoBw08QdamtRUUBqA/yE+YlwhW7Hlz8bDGEh3IGloOTa5JSWc
         zA1EtTqTJAFYu64aMO710pf7fNg3tyB/ZkknWxPM8FJgM+dPhfTVEQwfmiMcjdFhcUo8
         09q8Jw1qwvz5ejJLBAJQK7+ADr0UNuc8WLH2DZBmkAKyjd0oPguzzgXIwUzc9I3RdZqb
         XksDkRM210fqbFklgQrJiBcIeqTFvFSD/LKo/vUUZWB8Jl6ojzR5C/msnLjJkKoLA72M
         ty9JHWQSYNwt/mCWZw4bbYniZ9HRt/hB/oSxF32hBtmomu8KYJ+KM9jN1+Wt+JJSj7NT
         HQYA==
X-Forwarded-Encrypted: i=1; AJvYcCXfGlgH8vZwmeGlHLnydpoNGTHs5QSzk+WaY3t4DY/uJ6wZrNaBLEczQBzZScy2ilDb68n8xUZe4P9FpBTfCyDFDdAgSdNt2HiGrIqy6w==
X-Gm-Message-State: AOJu0Yw1foBcfyJcuDf1zp/+ghJ7cc5Z0ELEM/lh6fwL0V2ALPAGq4zh
	2EsRFSiteoLAy8Nk3GTNynraif4609Q3Zj7a6cXqP73rQVIUg1ZPkQgKDWyYBgo=
X-Google-Smtp-Source: AGHT+IFsDUKcepwhTMfngbtOJkYdquZcdm/7+0FnSBhsRuUAiazYGUUz8MH7tc0XTEkAcFEoXbsTQw==
X-Received: by 2002:a05:6a21:3d89:b0:1ac:dead:1370 with SMTP id bj9-20020a056a213d8900b001acdead1370mr4849697pzc.21.1714015034157;
        Wed, 24 Apr 2024 20:17:14 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006edadf8058asm12160586pfh.23.2024.04.24.20.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:17:13 -0700 (PDT)
Message-ID: <9228a873-8250-4b63-bf75-473e9a87ab80@bytedance.com>
Date: Thu, 25 Apr 2024 11:17:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] cachefiles: remove err_put_fd tag in
 cachefiles_ondemand_daemon_read()
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-3-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-3-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The err_put_fd tag is only used once, so remove it to make the code more
> readable.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 4ba42f1fa3b4..fd49728d8bae 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -347,7 +347,9 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	if (copy_to_user(_buffer, msg, n) != 0) {
>   		ret = -EFAULT;
> -		goto err_put_fd;
> +		if (msg->opcode == CACHEFILES_OP_OPEN)
> +			close_fd(((struct cachefiles_open *)msg->data)->fd);
> +		goto error;
>   	}
>   
>   	/* CLOSE request has no reply */
> @@ -358,9 +360,6 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>   
>   	return n;
>   
> -err_put_fd:
> -	if (msg->opcode == CACHEFILES_OP_OPEN)
> -		close_fd(((struct cachefiles_open *)msg->data)->fd);
>   error:
>   	xa_erase(&cache->reqs, id);
>   	req->error = ret;

