Return-Path: <linux-fsdevel+bounces-47089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8434A98A82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17301887BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7F13C908;
	Wed, 23 Apr 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDi/aphc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802A35957
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413708; cv=none; b=JLdnI/PxNAwo5rDGsk8cPOdU1jA/xk4W+F7BNpwYMqES0NB+q64T1peBYrgKCA9hnKUejTck/vDeb5cc4PZLhga6hyGim+ggfwjFXJAcLwz9Mp595phf/7p8vRdZmwfGwhq3eCHYUe01ACAuRXfTETcOY8L9ZWs+PF/AIzCxXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413708; c=relaxed/simple;
	bh=L7JtrhS7BvZk+vMKscQrGUgIEYcJsNk3zT6lIhrjt9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHkv2sP6u3+0JYi4NQfsUGnA0X/i88W0Wh3VKt3OkxRlleNRxC900XOfxQYJZ6WWT/FhCHCXN+b3AArjKw61L3o948s66UmUrSK0TR63lcDXu6eEAdP4u4oF/fwn91ps1GXkTBGwgauj45MWRnOOW+1cs8xDxit2gaE9xqndZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDi/aphc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745413705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tw5QkYjbUX88v+0BEYQ53saJV7aVYcuDEPi0hJNXifI=;
	b=FDi/aphcOTSvhTIvFdfnb5wOjQ3JhtQyPRiDvUiVQwWwAIQVVxTjsVHP8x2Uajy4gOpaRQ
	3vrEknmyc99dr6OMfrXfLnVJl5SCg295pycyTxgf5t7ihqPzgp321MUJ8E2BKGq58hAHoZ
	SAfIk//C9pTIItvAy/1/P4NR9OD0Y8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-f5n9Aq_QNq-k3utY_nK-IA-1; Wed, 23 Apr 2025 09:08:24 -0400
X-MC-Unique: f5n9Aq_QNq-k3utY_nK-IA-1
X-Mimecast-MFC-AGG-ID: f5n9Aq_QNq-k3utY_nK-IA_1745413703
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912d5f6689so3471668f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745413703; x=1746018503;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tw5QkYjbUX88v+0BEYQ53saJV7aVYcuDEPi0hJNXifI=;
        b=wq4I4mDYi7IYy/a/VOj7cI4/aBlFrAZ+CpZqXJQubQrVVUPDmpjawFW1O9DbS0Act7
         09xOA7lPqcPmIZOc9UKPBXFk9AnwoTXRIHA6p8H50YYr70jh3KKz4YtRPplhXfMgiTw+
         nOJzHAeajRZXS2BdguPfI92aCSEQjTLMJp8PYQuUeqcT+UnfNBo45LYTK7mbjINGS+kA
         0BPhniqln9BeHlKcbgL0os2/zhhNLZ57IQeEeLElxRqIjOQyrlP5ZWj6cCzDtaxnMvJu
         ZQRGXn1nyv4SDHzwnNbtG/wtAhACV+XEdSa9EPB1kJ00kW2jW00KPqm6oJbAOwq9PsOH
         3flA==
X-Forwarded-Encrypted: i=1; AJvYcCXurkgcGzgrkutfgCio2Dax4r3bR3zqus+wWbGJqLU+F9EnjLiqdijcsnA7DOBzipxa3y3eeW2jCqWVhds8@vger.kernel.org
X-Gm-Message-State: AOJu0YzFAFn9w8W+AX3/nRtmPh9EKHef9y/n2MhmYKmLwOQZlq0YjIua
	n/rG/ElBXBbmlCu0/miPmz4RqjDVn11wW5+VnCQ4lpYD2h04CNiInsc3MLK9o9ctTSNi7Vnf5cg
	nEpMl66VhPitPRnD4cBYtTlrVBGlSXU6HWaFYuMfedV302BUT1tWkfT4Jl2+2V9Y=
X-Gm-Gg: ASbGncvUjg9GptVqjkCUtayIpeatsiPvvsD89Dby39h1HVcRW4tKjhAZkytvVpRL7PA
	ywfDWYvqUnxbZT5Z0TXGMqikm9ND41LExDUj5huyyAeM5cwJaFSsN55oSblzDRvBE/wBpzRLQQg
	+ahWtbE7gdK8mFsvuSuFijJ9q+RScczTMz65TluHmEqFUX+SbsOuVOP9yj79pfsRBOUPQf5RvN1
	pRjcLzoJJCFP1u0uY4E/imOv+IeTOv3umGEB0bXmXVqhkyAWcMeEtmPccgYKEnWR1qraIVL/W99
	JNszMib11yeLV9eiPN13oMP7AS/pr/hAy4SaX1uBDa0gl6wg0CutfwUfPUisgqe5IbRT+gfiY6F
	8GNVnIe8LoQWYkGs1FgCS83c0bt/mQRgaChHJMpg=
X-Received: by 2002:a05:6000:2907:b0:39e:f89b:85e2 with SMTP id ffacd0b85a97d-39efba5ae96mr16605116f8f.26.1745413703091;
        Wed, 23 Apr 2025 06:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1uPpvEz5P9ccgo4rkBC5tHZb6a8Sfm5Stca/6CyUjNxZGTYBy4H0ZspJUsugxSLDXR9DhaQ==
X-Received: by 2002:a05:6000:2907:b0:39e:f89b:85e2 with SMTP id ffacd0b85a97d-39efba5ae96mr16605062f8f.26.1745413702602;
        Wed, 23 Apr 2025 06:08:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2c00:d977:12ba:dad2:a87f? (p200300cbc7402c00d97712badad2a87f.dip0.t-ipconnect.de. [2003:cb:c740:2c00:d977:12ba:dad2:a87f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092dbfac7sm25685485e9.37.2025.04.23.06.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 06:08:22 -0700 (PDT)
Message-ID: <6663d393-bac8-4bcc-b36b-58b08143d959@redhat.com>
Date: Wed, 23 Apr 2025 15:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/6] support ksm_stat showing at cgroup level
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, yang.yang29@zte.com.cn
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.25 13:14, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related
> metrics.
> 
> This patch introduces a new interface named ksm_stat
> at the cgroup hierarchy level, enabling users to monitor KSM merging
> statistics specifically for containers where this feature has been
> activated, eliminating the need to manually inspect KSM information for
> each individual process within the cgroup.
> 
> Users can obtain the KSM information of a cgroup just by:
> 
> # cat /sys/fs/cgroup/memory.ksm_stat
> ksm_rmap_items 76800
> ksm_zero_pages 0
> ksm_merging_pages 76800
> ksm_process_profit 309657600
> 
> Current implementation supports cgroup v1 temporarily; cgroup v2
> compatibility is planned for future versions.

As raised by Willy, we focus on v2.

Independent of that, I strongly assume that 
Documentation/admin-guide/cgroup-v1/memory.rst needs care :)

-- 
Cheers,

David / dhildenb


