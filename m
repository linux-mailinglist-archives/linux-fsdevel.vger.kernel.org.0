Return-Path: <linux-fsdevel+bounces-14903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C188488140D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01867284804
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6924CB5B;
	Wed, 20 Mar 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZpuXQT+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8540866;
	Wed, 20 Mar 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947022; cv=none; b=P/bqMrBoWVvh30SghSLrunjj47K1Ty/h3Lrf1FcLp3naKDxvsNvEDRqMT8f/vpucKqSVBICMBl5WXMmOROf43TFWNkDG3AXGmodKRE90ixVTB7VyEr5hYhRAMf6l2eUYd6l2l5fCF7fSMdO16RjrkbtuBCfdcSRW7wL88sMpC3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947022; c=relaxed/simple;
	bh=BoWUfQaMHr/thyi4g9dPBiA3DQnxuO8Sck7TGRIW7D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmJO7TTivAscb1YuIplgyrcQhpbHDSRYXB0x4qklAYfE7BI3z+6VgTckG0XiKVWqUz8b+SgORKf6Q5hveRH4wBwkrJG7wgeZGiPPO2izvnQhV5LnLVwXML4PyVi85GwZETZxdF3lcTOzT91DOFrDY23R14I0A+5iHsiwWkPBgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZpuXQT+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-610e3f906acso22514807b3.3;
        Wed, 20 Mar 2024 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947019; x=1711551819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP2tYj9XNBqoBxVSAs2Zt9sH6G01z8b+zS/s2e8QIV8=;
        b=MZpuXQT+KCsNGTztRpPN9363cS6WZufF9DMooo8JeYnKi89d/Tm9NzThjy0mf622LD
         PUqZDNF9isuXxPPxOg7gqdQQwRYWX5TpkacCQ6lubb/A+2enff2lxbgV1KQEXaCn6jPl
         FiG8zXvorA2/jH2aHcFfyz/xyNOe0Eq3XLh/6LLOLqz6C/UpoLRkFg2SQ0EY9gNb0Rwk
         M2htV6aHmMNEYM3J/sRNwPVv0+eNmALw9mxE47BvhdjZDo+8c1x0f6ppk51Z0t0Wthhh
         vb8Y5pQW9lF69gGki8dfwx9k1KEx+JfcRpiOrlrazyeCUnX1mwMQBBKhb/dVicCDMb+s
         HA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947019; x=1711551819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP2tYj9XNBqoBxVSAs2Zt9sH6G01z8b+zS/s2e8QIV8=;
        b=YLcap9YswQMkiFrtEVribeitx5K5304ezYx9fwW0p90L4oO1GFByk3isfHAxf9xoj3
         0HFY5RhvsPIaVFdXMXoDy0zmqRkv1jvtU2/vpQFVxGKzzesNAMNKgRy60/Ick23nv9+O
         1cS+nU45rWWiW5krU8eLqQeA16EcPqIoHZv3/bZWEIojdNvJDEf4PR4syYFC25EOgXF5
         UNG9+zUttI3baEtB57o/DU1BAhKv52c8EIwG8uMAuGVDE1WrATWtCQvflrmXSUikljUN
         ZtE529Lug9cMm0VSgkuIDkD5Nc9m7B+Pcgyqi5IgP7yyfGwbdZjGPjxXY45eijsskAzd
         9exQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVTX32m+xUAVzXpsvN0wAZi6tjgSmL5gUIJUVcubLveMZvuspSijTV4E/1Rvalw7wwdKQcYoXob1qWWe0lGrlQnhZBtNGbxzt9kObSv2p7CW8SZIVD2T6A/uMfxjDvjNAgZe7W6izrOMNc4A==
X-Gm-Message-State: AOJu0YzYglv5PFzxbIAtu6Gzt6w/+Q9KHCchGlgcD/9nbhf86mJ5KT9J
	m975Dp0N50AC0AU5HMnI9SZ+br5t15JUD/U/t8uWGGCGsx2pWTuO
X-Google-Smtp-Source: AGHT+IEwwOcMH7ZWvm6JnRFrHg9V+axbs+mhrFAazhYO5gpXebpAX8q8NP/Pnnc8OptEa15q4/yZgA==
X-Received: by 2002:a0d:e046:0:b0:60a:851:63af with SMTP id j67-20020a0de046000000b0060a085163afmr17765794ywe.49.1710947017736;
        Wed, 20 Mar 2024 08:03:37 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id eu3-20020a05690c2e8300b00610d7bf610fsm848807ywb.44.2024.03.20.08.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:03:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 08:03:36 -0700
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 3/6] workqueue: remove unnecessary import and function in
 wq_monitor.py
Message-ID: <Zfr6yAaa8tr2RKmP@mtj.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-4-shikemeng@huaweicloud.com>

On Wed, Mar 20, 2024 at 07:02:19PM +0800, Kemeng Shi wrote:
> Remove unnecessary import and function in wq_monitor.py
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Ah, this is a workqueue patch. Do you mind sending this separately? I'll
apply it to the wq tree after -rc1.

Thanks.

-- 
tejun

