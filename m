Return-Path: <linux-fsdevel+bounces-22942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F39923DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6729D28A3F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF91741FB;
	Tue,  2 Jul 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QZn3TC6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F65171E66
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923392; cv=none; b=Jk/6mLP10S6NKNAbKmxp6I80pqR3jXA2wpD0BG9Vr+UnZv30iqOwug5OPXbWcwuXusIMLP/QJQpwzAsXfbP3pljzOAG912iasYwfgEOGIimWy8HJd6BZucCh8esSl5fm1IWtMBQwfcECy+ibfc3CbKb6I+DdGrG2pZdhnOKIA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923392; c=relaxed/simple;
	bh=r+MVQVyGKSk4SBH+Wd7DCDCPj5zC0ZFnMe5ASYCco8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGj9G1D6k6VBehmG8tBgOWDKcOYwN+W49r7u1vP77lRuPzBzIYLDGNwwak8ujzjRMEQasZQ0vMFpyNEYVO3nH9P8z04FLgWvBFQs4HNQDDp2iYgMj3zFs9wDrB8LeZzLgug9pNpA7tZZilDfvfa3wPfhR4BHAwvYH9jq3B+QpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QZn3TC6p; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70ad2488fb1so1096969b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719923390; x=1720528190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
        b=QZn3TC6p4Bkfux3ufSp8KiqadALhCVhVGY81H3eUuZKf6wdAyIIP4O0CeZJqWyHaxP
         2diRPwFKN5T4d+Yfj34VZjVoEZ4JA9+LQcO9g1Jwcmyz5WjIg/4O77oA4dOcVEO/TmZb
         xNgDAt9i0hoAfAC3pk52II+2zQOyzO/KmJEeSpKLZgXqafvHwOMr7jLPfMJo2TS+bzvu
         rif58df8tJGUjSiKX+D/BSqreDCWvaiX9M6jiTaBjVScVMzJrn6xBbpbXfG1gVochxG1
         Hk9t/kiFsG8W+b6I1HM660HoKh0+916VvqwpMnoUgIgrb729CZKYgqwI+Y/M+hgaSjKg
         M4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923390; x=1720528190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qoWo7LK1MBUf7Ek/NbpXFpCCMF0xO5+B4OHWe9xZak=;
        b=o4Co58kWV59SmYa2dPpb4ljOMxV2ySLKNO2xSUV/hxQhFCxyNm297Db/JqeoxZhf2v
         wInIaCWiZq5pJoNCjBjB4SYowQfhjYkiR0b7c2KxMGWVP1acRhBm6gVh/irHyhpvqMoP
         ikvvzV0NiezRJgwbl0t+PAhgfYv4wpgcKcPwbHGe9PAK13qATmd4hJRpR52gNkYxIW40
         cy+dBS+DI3fRsuvO51HlYXiSztpLFrIXWSVx6aOky307vRxVR976KM+jjQpSTQ83o0qv
         btDN+ENlHC6uEXQsAnuvQGbEE6RXWMS7ufpyH+TTOxAz5fFrwDCtMslQTZthEOOnhIA7
         AFwg==
X-Forwarded-Encrypted: i=1; AJvYcCV3VdWvGAW3SE6nchUzKKcdB/vK860DAyn94FsAvHlWFCBylGvRiCnCCqKEJMpJJFb311Z/ocTJwPmgGXw5V4RLkOw7YuxARI4cCvUTKg==
X-Gm-Message-State: AOJu0YzDduh3h4C93A9Htx3CU/JCqwaxwbQLjIcUo/X4E8fhL8GyJ/UF
	VDTgkZlmZqoRIygyXMsfPw68smW89D1sud1s5RzwdoZwSU9Ancl86qRaQiBeu+Q=
X-Google-Smtp-Source: AGHT+IHJjOmbGv3nMlY5xA5nReKwCC+9X/1gT2v0Ln7U8fmaF5LI6r20bPQGA8L6C0NsTtIhJ5COlQ==
X-Received: by 2002:a05:6a00:1944:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-70aaad2c0f3mr11867186b3a.5.1719923390615;
        Tue, 02 Jul 2024 05:29:50 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8374995b3a.163.2024.07.02.05.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:29:49 -0700 (PDT)
Message-ID: <20375364-9147-4079-9f25-8ed8d9ebc057@bytedance.com>
Date: Tue, 2 Jul 2024 20:29:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 5/9] cachefiles: stop sending new request
 when dropping object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-6-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240628062930.2467993-6-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
> object is being dropped, and is set after the close request for the dropped
> object completes, and no new requests are allowed to be sent after this
> state.
> 
> This prepares for the later addition of cancel_work_sync(). It prevents
> leftover reopen requests from being sent, to avoid processing unnecessary
> requests and to avoid cancel_work_sync() blocking by waiting for daemon to
> complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/internal.h |  2 ++
>   fs/cachefiles/ondemand.c | 10 ++++++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 6845a90cdfcc..a1a1d25e9514 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -48,6 +48,7 @@ enum cachefiles_object_state {
>   	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
>   	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
>   	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
> +	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
>   };
>   
>   struct cachefiles_ondemand_info {
> @@ -335,6 +336,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>   CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
>   CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
>   CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
> +CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
>   
>   static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
>   {
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index bce005f2b456..8a3b52c3ebba 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -517,7 +517,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   		 */
>   		xas_lock(&xas);
>   
> -		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
> +		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
> +		    cachefiles_ondemand_object_is_dropping(object)) {
>   			xas_unlock(&xas);
>   			ret = -EIO;
>   			goto out;
> @@ -568,7 +569,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>   	 * If error occurs after creating the anonymous fd,
>   	 * cachefiles_ondemand_fd_release() will set object to close.
>   	 */
> -	if (opcode == CACHEFILES_OP_OPEN)
> +	if (opcode == CACHEFILES_OP_OPEN &&
> +	    !cachefiles_ondemand_object_is_dropping(object))
>   		cachefiles_ondemand_set_object_close(object);
>   	kfree(req);
>   	return ret;
> @@ -667,8 +669,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	if (!object->ondemand)
> +		return;
> +
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +	cachefiles_ondemand_set_object_dropping(object);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

