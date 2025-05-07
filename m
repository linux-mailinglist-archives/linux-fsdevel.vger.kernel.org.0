Return-Path: <linux-fsdevel+bounces-48410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE373AAE779
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09633B4A47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763628B7D8;
	Wed,  7 May 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gk6j96ju"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117A28C2BE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637906; cv=none; b=SE2i+fmVxxWhfYW3dAZ6X7pIhChIJC8z6BxS6Zwd5evmkdGGGh+cbQwFFQLBjkzn4zx0UJKhY/vWLgbGm0rHZLGn36z9HBe3VoB8Z2HxyHZDhLTVNApOQpULdpfe3qNJZ06DmwfyLuynyFCe8bSe1bG/IxGaS0r7wB8KqrsxYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637906; c=relaxed/simple;
	bh=D1J7HuRcXvcw25jBkFuTWpcuJ/aCBJioWOKdjIUpPqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuJvPC9i2RihsiSbnIeiT17mKfcG+t7KxBjY8bTuyrU5d38+ybC0qtVoCXL5dJHd2YGSSmQ1Ej0gzP994y67aTZJbPwmBlA58oB2xCFByCJC0blvvTIUCsBRM2dvqLvSnZwujoM/P2V22S6rWf17DztOEtAy76Gi/21b+CBBU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gk6j96ju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746637902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5O2TqgpWxzRwP3QqeFI3cCUlhW/V+ugLYUrXf8tgEs=;
	b=gk6j96jutAPnIi7jMqwx7JkgnH8EGspVWmgGqIx4NQpf5DCI/2DExfJ379XnvtirFVmseG
	CI28NqkxFbrxZhiUJ+f71A4636XLskwETP2sE56pvXJQPSHMjq8tYTkUP1RCbT9QM6IS0L
	0W4kNxSy2TTAHkFb8x8/mV+ZMwwNVrg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-UAuYJg6KMO2IfKsdgjYc6Q-1; Wed, 07 May 2025 13:11:41 -0400
X-MC-Unique: UAuYJg6KMO2IfKsdgjYc6Q-1
X-Mimecast-MFC-AGG-ID: UAuYJg6KMO2IfKsdgjYc6Q_1746637899
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e7551197bso19016639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 10:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746637899; x=1747242699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5O2TqgpWxzRwP3QqeFI3cCUlhW/V+ugLYUrXf8tgEs=;
        b=a9nXgnjSnJ4BEAi8IZMTszRIYJfwGaPSO53HiIyv/RqKRclxbK6y/yOBDvdsaEZS68
         m8f3K7WOG6GNF9q5oM3u100/QCq0JVIZVrx7eq4Zdux3HUNjyivxbvV/KRmm91LLEIVk
         lUnpwLk8+jgZieucOsTuPTq0PjZQTYnxgeXfpFZtFt5OB5g3dHvEubO+CpcZV3KByFv+
         DZ1pYLTiWMtXqYWSUumSFkXfpEY5ZkqrzbdKNKUVOtFJrL2T0NZq7fAwWWa8YhqNZCHm
         fxL87OaZqPyOtSPeAg9+DnbThWpI1CMUoZoHq0zs0Ojqi3oOhETqaaZIbI0AuqOtUPiI
         NPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbF2rWHFtFxQ8oIs549Bm7y+lEDKFffbNId4l37w6O/09NWB/iNw5pku3+TwyGJAwR71IP5ltcqtKsKITY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6CnODH4j62Sv+mnPuuqiJ9UJ6q1iaxHTb1+hMmjVq0Gg6TV9
	oDtCJvNEJ4JH8V8RQ4JeWNvovo1n3nxQk6ELJoo4IeqS5eGlHOJuSG3ckhoBbelOGKQk+fTbf3A
	nX2RQTR2/qRWv0ZZkj9wrcIJVdqrc+MiVFlhCAlaVD+DKX5qBQ4tyKeg7w+va1X5BU4xk81RDOw
	==
X-Gm-Gg: ASbGnctA3pT0TO3D6Dq19C4yGijDxQl6YtQYXrOQz+2Wb+hidNN7bguZ88/LI5JlS/w
	ec1105tjP4tN78WeIJg372xa5FW3BVHWNnD/ma5JkT9hHsnT8jgHLrzy6dW/oa+vDisNCqEX3rP
	MvYGEa+q9MwH2EGmgOvDy+WNp/I/uxvHUnfJiMB0zBbQK76yigPTHVMWWUzN3Q5fNF55/yk899k
	T+C0dXwQBrwNkyDUXlPKX4hI2W0mnHbOMNpv9W6MKpnA5cDXsXVAEjxrJyN//t5tcHSDajcpx1/
	Z65UYlV3WYAdgFMM77s+YJSYFncBIl92EGTrbJNUu6kDDfM9zw==
X-Received: by 2002:a05:6602:6d8e:b0:867:973:f2cb with SMTP id ca18e2360f4ac-8675504b269mr45217739f.7.1746637898920;
        Wed, 07 May 2025 10:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/wX5e69Mhobwt2UxF7KW1vk8xgMiCcyMylgrksgKX/WZmmmbkgTlQU19JIYMNiyJAl2ZLlA==
X-Received: by 2002:a05:6602:6d8e:b0:867:973:f2cb with SMTP id ca18e2360f4ac-8675504b269mr45213339f.7.1746637898572;
        Wed, 07 May 2025 10:11:38 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa2bcf11sm263323839f.8.2025.05.07.10.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 10:11:38 -0700 (PDT)
Message-ID: <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>
Date: Wed, 7 May 2025 12:11:36 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 chao@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
 <aBtyRFIrDU3IfQhV@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBtyRFIrDU3IfQhV@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 9:46 AM, Jaegeuk Kim wrote:

> I meant:
> 
> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> # mount /dev/vdb mnt
> 
> It's supposed to be successful, since extent_cache is enabled by default.

I'm sorry, clearly I was too sleepy last night. This fixes it for me.

We have to test the mask to see if the option was explisitly set (either
extent_cache or noextent_cache) at mount time.

If it was not specified at all, it will be set by the default f'n and
remain in the sbi, and it will pass this consistency check.

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d89b9ede221e..e178796ce9a7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1412,7 +1414,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (f2fs_sb_has_device_alias(sbi) &&
-			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
+			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
+			 !ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
 		f2fs_err(sbi, "device aliasing requires extent cache");
 		return -EINVAL;
 	}


