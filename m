Return-Path: <linux-fsdevel+bounces-17713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F08B1A68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764E28224D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0A83D0AD;
	Thu, 25 Apr 2024 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z0pDTZgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D33BBF6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023690; cv=none; b=aOhfyjLkX9a5Ht5ahlt0jW6LpDL8OIQpbdMEqaMQw4YoFNgcfJKELx42W/+icgXTRpHPzZN7LMYNat6Xi0mJf7Lf2cSDNQ0D3WAlStnuR9G+s53iMv+yektvuQ8Q0NlrUTl5AVGeKRp5GjBrOkCCDoC7AICnDgiYTvcnQ1qqSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023690; c=relaxed/simple;
	bh=EJTC3wowI1j2u2TKzcLePfke7haCbSp9UOfnO38aLsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0Fwb78pIZXJHWIZgVUhA66YHAk2/8Gu+DuwBfizrYHQOobzhJfArWV7w4eAyJLdoSjWbuxYq5r8UORgDEcvjak2Mg5BJQxR73y6a0j9JDyfqk/8plfN++Va3xUlYzZDsiC/x0imrH9W2WGC16ZzaqiBeE0v2lV/P5wdZLQLkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Z0pDTZgx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso597184b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714023687; x=1714628487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=Z0pDTZgxcfwcesXia1wJRS9dt9hJ40n7xfQfhvhIvateALKUbfdTJpwZV2HRcQtO4q
         4+QnDt/wYZEjcw2CToBQ6pXYEhQQ8QhCR/T+W6h+jV08oiysmY8tjPBiXYhrLTrml69r
         cjh68P9+NuBDtifHELS9ofoANW0QvBvSEDMK9RH1iI3LrsDiMHYbwnZI4uuSf/tdMbmC
         bn2V39ZMkwQa2kBhv4eNeM2IobLGyOSKCNa1vYsLA/BxBu2fZ6lIvEef9usvCJbyQ0Oy
         yHQq+0PUEnptnT/m3/AMLzHZoAX/fAN+x14/acGlnArhiGX65Sj3h8vHA9fMmMMJ2Nyv
         l44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023687; x=1714628487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiVVv+CXcN+CvM+zB+3igsIJaaE0zH8C5SDY181CcQk=;
        b=JqDczmBPzhf6/DO5UM3bgJ8EdkBTT538Vt3WDe+tfHEcYUqitY35Uud4blfjkgbaqX
         Hn5qHCQJA2e1eek0cGM2164i1swkfZjGpyaHxBCGRG9Gq88W1VdZSBgNCHcLhrezF5Gp
         LK361W913sfPVX9vgvtks6rJuvg0daElQBl7cC7ycoUl3QJTgKfNOkvPBCcGOglP3Fdb
         n+HkHgWmD4scVQwABMikZcwvd0wsBog5+QHiTJK2DQ241rmK6s/L0DLN0nTRZiE+W8dZ
         x65TGuCxXKkrhRqkQqR+eSKdJQkq3zOfuxKv6w1Y7xUhaz57+QeVKEihikevD7ujl1Nu
         cqdw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwJV34I1MnFuVOoJjzECVhtHZkvJgSYwcBBrq91wpMkXScI/Orw8QaSU1AiWjcSNv5Fonq5QvTGm+DGtaL3EeZQSJJyM7DFTUNyLa0w==
X-Gm-Message-State: AOJu0YxOQD6UWxI2Vjhy+BcS0AIUmprch4iaOQMAe0837cTg/2H8T2k+
	laH6KKPyq3xs6cppXzGudjQOQtqvC0aX1HngRDySHDDhd8pGAaLW7aDtpsVFSvc=
X-Google-Smtp-Source: AGHT+IHNJBsklbaNtuhephdNcHI3SdblGcDt0X5IXkyJ+9Sg3RqlYnd4/Js8ZPm7qlkq9lbveXh7Sg==
X-Received: by 2002:a05:6a00:1492:b0:6ed:1c7:8c5d with SMTP id v18-20020a056a00149200b006ed01c78c5dmr5655256pfu.12.1714023687307;
        Wed, 24 Apr 2024 22:41:27 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b006e554afa254sm12333974pfr.38.2024.04.24.22.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 22:41:26 -0700 (PDT)
Message-ID: <8572a732-ca12-48d7-817c-d8218d536c0c@bytedance.com>
Date: Thu, 25 Apr 2024 13:41:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cachefiles: flush ondemand_object_worker during clean
 object
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
 <20240424033409.2735257-4-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033409.2735257-4-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for catching this. How about adding a Fixes tag.

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>


在 2024/4/24 11:34, libaokun@huaweicloud.com 写道:
> From: Hou Tao <houtao1@huawei.com>
> 
> When queuing ondemand_object_worker() to re-open the object,
> cachefiles_object is not pinned. The cachefiles_object may be freed when
> the pending read request is completed intentionally and the related
> erofs is umounted. If ondemand_object_worker() runs after the object is
> freed, it will incur use-after-free problem as shown below.
> 
> process A  processs B  process C  process D
> 
> cachefiles_ondemand_send_req()
> // send a read req X
> // wait for its completion
> 
>             // close ondemand fd
>             cachefiles_ondemand_fd_release()
>             // set object as CLOSE
> 
>                         cachefiles_ondemand_daemon_read()
>                         // set object as REOPENING
>                         queue_work(fscache_wq, &info->ondemand_work)
> 
>                                  // close /dev/cachefiles
>                                  cachefiles_daemon_release
>                                  cachefiles_flush_reqs
>                                  complete(&req->done)
> 
> // read req X is completed
> // umount the erofs fs
> cachefiles_put_object()
> // object will be freed
> cachefiles_ondemand_deinit_obj_info()
> kmem_cache_free(object)
>                         // both info and object are freed
>                         ondemand_object_worker()
> 
> When dropping an object, it is no longer necessary to reopen the object,
> so use cancel_work_sync() to cancel or wait for ondemand_object_worker()
> to complete.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/cachefiles/ondemand.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index d24bff43499b..f6440b3e7368 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -589,6 +589,9 @@ void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   		}
>   	}
>   	xa_unlock(&cache->reqs);
> +
> +	/* Wait for ondemand_object_worker() to finish to avoid UAF. */
> +	cancel_work_sync(&object->ondemand->ondemand_work);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

