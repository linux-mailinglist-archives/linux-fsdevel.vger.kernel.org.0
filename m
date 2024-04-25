Return-Path: <linux-fsdevel+bounces-17703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A5F8B1943
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085371C22222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F291812B7D;
	Thu, 25 Apr 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P0skKWW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B047484
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 03:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014819; cv=none; b=JJHqZ1kYDb3AS+LtqE3skSU0Vvh6ZCGyDSpZyJn/BnRb5aubqlksAMZn6LHfUNG8dWTd4gaUlBHOOS64vjAO254ZOsFgT+WpUYIuWehF+9gAKdWoj0L6vNe/59sKgYtDyCuq1+jn1p9BCwbIn0HyoQvTgx0BQ/rnLwR8ToNcZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014819; c=relaxed/simple;
	bh=F/1VMu7Ncu+E5GMEYHg5FIcaKmH6+lOLwTRFwG32kF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeD9Z5f7tvWOPBOexr3BsdFdtGFHlIAHrM0xnTZpysqmnP+XLV2y4Rj7NOPrC7m9d35Ym0G+zfFEiwVXinCRJgD1BnpHGkxACZy10lTpg2jZKyp9SBLoS/HrwyUyqPTbGjNfG6OhDAWqA5Kz2OE2+YDfMLt0QeesUbrFuqlehaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P0skKWW/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so494229a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1714014817; x=1714619617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
        b=P0skKWW/Jai0p9npUPOBKXvqbhGdkkvN7178oAs0Ss0Be0O8QXZbmIm/X/ZNfCWKYa
         oI8IuO5pewkfNzmCEBUWh/EIpCnfOQE6BP8IPOk8Jw8k0TZe4JkLBByIXm4DKLrY3QUx
         2hBvDfzFEQcgQPOsz2faZssNLWKmkH4OrD16ydQeGtD2+h4SE4F7SL4SwfiRcs+lUKzS
         79PAzhFaLaKBktuXPN1xqKopr5AkCk9PXXRMfAlCv2eke86+32BK4RTlVoGuVDO7mBbH
         aANQl6H1nlEGL111WtHTBYrCDaN271Q9ea+W9lCQG0V7tX5oXIb4U3cMIYhNtmad8SKe
         HTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014817; x=1714619617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=45q2opjjuUYEePVm3ifdMLHGn3JYGUOldjvko9Req9k=;
        b=qF/g8NOPAHIXX32XV5Aucnx8JgYK8P2G2kuKW9nG9Qt2oKl/OPcQ+NyyuOhEfc9Fsa
         oLXVs/H0GO3EI/sZSBJ0qm4TSvdHenv/8/QF44S9J6vY3lKehrgmLruPD/FJ43qFm1bW
         g/PYfduxeHImOsOlCFemAOzfd9i1zqgfbcBOvqpM4AoT+IJ0Hpsa7qzuSkdVTO2z/cS9
         rV7EpHJ7Tlzht4cY8P6oIpbIKU20YQJ/qPx2/BqB+NoomLr9Nxyn44o4JrFZbJemDM0x
         fIh+YzDLHnGHAtvtkV57vmCjPObj52wEW+Qg1kESp/0Gt2TJJbr6LP1BDOc/WYaOeEYa
         XIjg==
X-Forwarded-Encrypted: i=1; AJvYcCWlnrXsmKS5Sq76HVhdIwPUUOulXkhK5fmP0x6SklSADjSo553sjLb1tWkt3+aEKp/b++RRzCahGNMQy8M5ZjTW8Agy0kKF8gWJ6ece+g==
X-Gm-Message-State: AOJu0YxPzFHFAqOzv4FGkbOuo16B3yqrCfVGMxgUhul35+4S4ixWu2oO
	DYmYOQNLDFbFDuscYhzDrTKt/hERiyJs+uAs+YOJ4bB0fxpnB1EHxNmfCEnTqvY=
X-Google-Smtp-Source: AGHT+IEuq2nC3+NrQjBJkDqAEPYGH85KMdEqJehJWR0o0NQ3qmkCAsRYPwQPdvh8mGs6423pdhVCfA==
X-Received: by 2002:a17:90a:6b47:b0:2ad:6294:7112 with SMTP id x7-20020a17090a6b4700b002ad62947112mr4177222pjl.14.1714014817331;
        Wed, 24 Apr 2024 20:13:37 -0700 (PDT)
Received: from [10.3.132.118] ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id gk1-20020a17090b118100b002a5290ad3d4sm11981013pjb.3.2024.04.24.20.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:13:36 -0700 (PDT)
Message-ID: <6c04aab1-44d7-464c-8080-b06d5c0f16ee@bytedance.com>
Date: Thu, 25 Apr 2024 11:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] cachefiles: remove request from xarry during flush
 requests
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>,
 zhujia.zj@bytedance.com
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-2-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240424033916.2748488-2-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/24 11:39, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This prevents concurrency from causing access to a freed req.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/daemon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 6465e2574230..ccb7b707ea4b 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -159,6 +159,7 @@ static void cachefiles_flush_reqs(struct cachefiles_cache *cache)
>   	xa_for_each(xa, index, req) {
>   		req->error = -EIO;
>   		complete(&req->done);
> +		__xa_erase(xa, index);
>   	}
>   	xa_unlock(xa);
>   

