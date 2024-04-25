Return-Path: <linux-fsdevel+bounces-17711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3626A8B1A3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DC81C209E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278073B7AC;
	Thu, 25 Apr 2024 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BRBRiOrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C93A1BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022146; cv=none; b=Ar5/3Btjef9PDcrbUvXzyWLuwqwoUM5GGWRIoc9XFOAK76VukK5cwtGqHUQzpte48kvE+II0V+m7lerKAWnb5HxyYbuXOL/tejyudfvFcOWLPq8aANDkXMlVYYGW1ZtvJzqKc3w5dFatDiBNeaw20EaAb5czhJULY40UJZ4URkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022146; c=relaxed/simple;
	bh=KMml6kOnTgP5A7N4cMeQuHkBnwThjTY+lkYFRv3m4lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kp9/SnWZITY8lDzunZEcCoIsPBJfq8he/7ichMxjPciscJwss4UdzZagyn26F+4pGJKSc4d4kpf04M9j6T+3Zpdr8Rv7fRWIUaVptgYC03lN3zzujExXskEKtaBKH7lJSCvT6MF8fYQep0mWwhrXcdDTRAIXWqtdlq6T5rWWoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BRBRiOrO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e5715a9ebdso4419705ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714022143; x=1714626943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=BRBRiOrO/0ZBdi6rDOWpLKIIojZHBhZm7QsyoAqowo+sVt8BDsvaEGq0Ocfg0gq/gb
         UoJzv2UlLwZ/dR7Ro5ZYZSV5teT5ivU1mbSfkwoOA72XOm2eqzktzkiWZmWAFtpF6KLr
         M4leknzkYM+c6XFYIaQi/KuE5Mv5gk+DIrjIchinNS1LdeId6bCEoJKRd3UAJnw3810J
         yGBmIhVdPrMhqHBIeXbqsUW/2J/9buwfqMboZUyyig7GkXodgW+20e8g2AArryz1At9K
         4fzCh5zpLy1NvrcnsEjXio7nEsKETLYaWhDi7KjFO/hr5epEncL1wm6Q05QAVuUdE7Vc
         YkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022143; x=1714626943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bNdUFtYR2xbr86vH1UwuLkPY/+I0PhhpA884pNqNeBA=;
        b=BJ0WDLzhydUA4YNTUQDF8MaFkXP90laVrSfcs9xVwOFRSC8L2FtEI1sJYCh/OLfq2p
         hE9jYmHPh69YxYidLLOZhQ+v1WuShHOolhTNcT6IL6tj9PyPXgg14KYC+e2aJDQSXR0p
         u/jYIsTduYg4Y0VPco3IEQqRfaWh2rLZwFvlRRfNmk96A752UqR9LAanvwFoVm7EndAD
         l2YL1uA5doZUMhrGKft7DR6kEOVR6IntmpCAL/PnOiZjRP62XQ5NGRqU4vi8Rt3ZfMYJ
         iQbbU2c2L0ZGFfgqrjfWiXy8Wu2VWn37v3+DZa8OoNo4gkPgZ6f156Cdur2NHnhML7y9
         L4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVJvyvIzIycjkqHrAz3F+ErS0qLK3ZI+SdakebbneQeNT9KbMB4ojOXEQNkOWSDWZmJ3Qw/lf8N6JgtS0rgmUgQ+1ZmrmA5LkZP6M0ujw==
X-Gm-Message-State: AOJu0YwGwZzqyAvIHHIo8GE+s7hmswodV9nOzI6rbtFZz4B5T89TkFQ9
	IV+L9ehHlw613ZgcYMIsJ7RNj4rvFzef8szMTZfbq8seFtEGVepXO8ftL7JXJJY=
X-Google-Smtp-Source: AGHT+IEQITLDZGcYmA+FjKYuiztsfCh0wLhqQI6Xcb/IceR3ZPd+qhouMoKXS2ZMMGdGKHN5UKg2Ig==
X-Received: by 2002:a17:903:41d0:b0:1e4:6243:8543 with SMTP id u16-20020a17090341d000b001e462438543mr5733230ple.5.1714022143006;
        Wed, 24 Apr 2024 22:15:43 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001e78d217fd9sm12826398plg.16.2024.04.24.22.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:15:42 -0700 (PDT)
Message-ID: <e1c97315-de7a-4222-9fd4-788e566b2eaa@bytedance.com>
Date: Thu, 25 Apr 2024 13:15:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] cachefiles: make on-demand read killable
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 Hou Tao <houtao1@huawei.com>, zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-13-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-13-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Replacing wait_for_completion() with wait_for_completion_killable() in
> cachefiles_ondemand_send_req() allows us to kill processes that might
> trigger a hunk_task if the daemon is abnormal.
> 
> But now only CACHEFILES_OP_READ is killable, because OP_CLOSE and OP_OPEN
> is initiated from kworker context and the signal is prohibited in these
> kworker.
> 
> Note that when the req in xas changes, i.e. xas_load(&xas) != req, it
> means that a process will complete the current request soon, so wait
> again for the request to be completed.
> 
> Suggested-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 673e7ad52041..b766430f4abf 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -525,8 +525,25 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		goto out;
>   
>   	wake_up_all(&cache->daemon_pollwq);
> -	wait_for_completion(&req->done);
> -	ret = req->error;
> +wait:
> +	ret = wait_for_completion_killable(&req->done);
> +	if (!ret) {
> +		ret = req->error;
> +	} else {
> +		xas_reset(&xas);
> +		xas_lock(&xas);
> +		if (xas_load(&xas) == req) {
> +			xas_store(&xas, NULL);
> +			ret = -EINTR;
> +		}
> +		xas_unlock(&xas);
> +
> +		/* Someone will complete it soon. */
> +		if (ret != -EINTR) {
> +			cpu_relax();
> +			goto wait;
> +		}
> +	}
>   	cachefiles_req_put(req);
>   	return ret;
>   out:

