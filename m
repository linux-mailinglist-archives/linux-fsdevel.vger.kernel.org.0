Return-Path: <linux-fsdevel+bounces-10573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0284C656
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B8282FC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783CC208BA;
	Wed,  7 Feb 2024 08:37:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AA2031C;
	Wed,  7 Feb 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295041; cv=none; b=lbBEjB1cPqrfytDZfl7+uocNcokN2FEjHHYJ5EVGC0rPg9U05okyowIB8c62BpkqaQM7kUiKoSwylOdew6rB1C7FoTuslsz7d/+rGU6WXncpJWd72zKOVVcUXbZQVmVugjNMC+LVUHWssuO4zPIzBIIPnTTgeXPruYPKNf8FROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295041; c=relaxed/simple;
	bh=a62Qe+OkzOix6n4E9jvUjz3W0HHUEkc1RpP+Q3LpxWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5GKlivpO6wYEr8f0iHD7zUnFjLYLOoO5JZatD2c2vUdga5koPBqLEU2UzliELFPHgQ83FFBQ+quwSAKpRxu6NL3b79D3wtEKKKc3Ty5pXSDzhPy9r0Naj0iK05assYAgZfu3FkSWYuqmH8wkmAmDmJbmo3SwW2MRFSQB3+C/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so347204a12.2;
        Wed, 07 Feb 2024 00:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295037; x=1707899837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nV42hv6cpuX4brq4lqpQ5oyaSmY9OdIUk6vM2n0m8g0=;
        b=sE/sCztlJ7hinuhaO69p45WrzCXVpM/7jNBaqR26eFVKog1XOzBi03MGNcrtJbVfIw
         103doygm/NlziDfRbYvWLeF35caNUKik8/Eeg8j6RKDI6X0VGcPHvoS8yeb1oppzRbT+
         blVAia9LNIbgp6VIR0gwUff0Eh/1d71D4mbdYfVjfrc84nN0moT7bZI1Lqy4TKjifNrq
         53LJ+CLjMuBTcBz7j1TqKBvXPGIeTrEjdFKC280LZ5RDLPkoqxCuieB/NGK8o733Flwl
         1BQ0oO46002ndksBXKG6S7B4UUjVTDR/4FC/BPx0+1BrCnyJlIoic/+7EiuSYX/4Vn+B
         2Mkw==
X-Gm-Message-State: AOJu0Yxoqxd5zFgLhbwodeBCD9jbJmDgCAvtsytB/fR/3mnk8YMSGJFf
	5SId2W6q/slcKIiNo//t7BLauD0LJAMiA5iwl65VGpdmolAzboPJ
X-Google-Smtp-Source: AGHT+IEEEiHYJI+b6scg9420GxTSMXSd3kJvcKNNLeOb4Vv2MuIamRerOxz+6A18SIElO1n0+gVhXA==
X-Received: by 2002:a17:906:374f:b0:a38:526e:8474 with SMTP id e15-20020a170906374f00b00a38526e8474mr2051652ejc.53.1707295037337;
        Wed, 07 Feb 2024 00:37:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvTY8sR/HtRsqE/L9yipVOIltNGRzG4Qe8np0UHEstRqagfL00t06pUoKFsKa1lXeHSJzj5xZ/MRSSXBifuQa7U+4v+3V+oGq0AVsVdYFcWNRPeWlpRc1eLsO4rfrsBDs2i0+HYt/+F2VLYx9vPz9GDE5rt2jSPesi/bitJQvYkdtyPCk1duwtfW6V+0KlSzP42qbnLt0Yap4GvvgDXASIcUSluwqjjM30+oWiNZoHoqKNkDfZIm6tzBbfGSAb/XhW0ccU5w8E1wNBbxtkBod5Dv7odwtZMdv3Ct+uV0+FjwiftunLpQU/YXOg5CTrYkvLbbkD53yfVwhmggSZTh0yUicoQeBrgE4NUq2k9sjBAO5EsmqAGFRLnpreOPvDaXI4gfVs9dIIEP9FP8CPjLU0zpZwsqNTjauvgM4cNwXKxk9hDWgAwnaoU1pqfrFxVc1+eoXbF3qxjOhSaCA5BNi5eD8vdo7wkh2h0WvQQLVN8W17tKIDHRTbv+DuNOZlgiz3znUibfRAGxbvmWPFxOiX4pEgiKPSPNt8C7so95P6ILqhipBd0ZypOvL1APn+H63WdotVm5URV+6m4/VY4aLbMVxE4IHlOnUgeIftg8EFGF/2SCBrPvqu2AfM4vwFS34gegFd5+j82qtiHPGrmHBPNmqaTl22cPQvVtKN0vH631LiTC3fdlFZJ2S7pTEvWakeEACk5x/7z4G/Ouj1mVFZZB137LSJd7CDpfsMytQspLoCHgHIaZbl8Gz4tfBISm/2m7v0Sbe/V2z+kPA/FE3RpFdzbI4JNQF8d+QTt8963JazWgstE5SHtSLCb6uoZnbPeKB5ZKz4yVrjddLdXe+ibCgpNYuoc25hSVEvpxGPsSkZiZjlLG0faY6gj668aeGxZUAWknOIjHFVVhZClGWSQriaDecrUS6ylgJPhIHCR12WX8NdGc/ykrQo8CXIxZnG31
 BcOpdNKX1o5konwmyF7CZdb1N15is2MgkZ6gVIbWKEznktg3uaHQ==
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id gs11-20020a170906f18b00b00a371037a42bsm489672ejb.208.2024.02.07.00.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:37:16 -0800 (PST)
Message-ID: <ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
Date: Wed, 7 Feb 2024 09:37:14 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com, weiwan@google.com, David.Laight@ACULAB.COM,
 arnd@arndb.de, sdf@google.com, amritha.nambiar@intel.com,
 Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Nathan Lynch <nathanl@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>,
 Andrew Waterman <waterman@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-5-jdamato@fastly.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240205210453.11301-5-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05. 02. 24, 22:04, Joe Damato wrote:
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time, packet budget, and
> prefer busy poll params for a specific epoll context.
> 
> Parameters are limited:
>    - busy_poll_usecs is limited to <= u32_max
>    - busy_poll_budget is limited to <= NAPI_POLL_WEIGHT by unprivileged
>      users (!capable(CAP_NET_ADMIN))
>    - prefer_busy_poll must be 0 or 1
>    - __pad must be 0
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
...
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
...
> @@ -497,6 +498,50 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>   	ep->napi_id = napi_id;
>   }
>   
> +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	struct eventpoll *ep;
> +	struct epoll_params epoll_params;
> +	void __user *uarg = (void __user *) arg;
> +
> +	ep = file->private_data;

This might have been on the ep declaration line.

> +	switch (cmd) {
> +	case EPIOCSPARAMS:
> +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		if (memchr_inv(epoll_params.__pad, 0, sizeof(epoll_params.__pad)))
> +			return -EINVAL;
> +
> +		if (epoll_params.busy_poll_usecs > U32_MAX)
> +			return -EINVAL;
> +
> +		if (epoll_params.prefer_busy_poll > 1)
> +			return -EINVAL;
> +
> +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
> +		    !capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> +		ep->prefer_busy_poll = !!epoll_params.prefer_busy_poll;

This !! is unnecessary. Nonzero values shall be "converted" to true.

But FWIW, the above is nothing which should be blocking, so:

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> +		return 0;
> +	case EPIOCGPARAMS:
> +		memset(&epoll_params, 0, sizeof(epoll_params));
> +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> +		epoll_params.prefer_busy_poll = ep->prefer_busy_poll;
> +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> +			return -EFAULT;
> +		return 0;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
...
thanks,
-- 
js
suse labs


