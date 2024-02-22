Return-Path: <linux-fsdevel+bounces-12416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411D85EF4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 03:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D431284513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 02:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A7168AC;
	Thu, 22 Feb 2024 02:46:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EDE12E4A;
	Thu, 22 Feb 2024 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570016; cv=none; b=pRAGK48YHg0YNK9GIS3jtggO6IDBlkPu1qTCgSAFEz2W5j8TulQrkOWiWbxrRmS3c034UHxpgntK11A18SjVKXtLwjAZgFZrRCJDm2+/lmpqxz/sbH5vrnFbJU3DHq0a1+BDkaN4Q0j5/AHVgXlAEvay6ZOyrB9II1J0dOjxHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570016; c=relaxed/simple;
	bh=EJKVkFOUVFpW2TTGCpRGaLNLmRck4XEaonpMaAbW2bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgkSNe8mka5+LLHDqKT23sAPZv6Zr0o9b/obbL9s+cK9ag+qwqzyzcqUr+NuSUNyXfR3dZ/PPfPJCge+/ns2p+vXp1K2WuU9YCnnO68O1RCVfhS8br3Hhwq/hJYZtsE9sEXZA1z36ssC1EkN71tag1r1eZe+mQhHH33XrH17r7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c13410a319so685153b6e.3;
        Wed, 21 Feb 2024 18:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708570014; x=1709174814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJKVkFOUVFpW2TTGCpRGaLNLmRck4XEaonpMaAbW2bc=;
        b=TfpSUl5W3q8X3wWz8iPh7bUIEPZpi6RGjqp0G9anBtKMGR3P53CLdRuYPIaDyPhQ3O
         VPNXNlqutf1m/VRSK5Ne+ta0Rp8Cl0bQF/hfZCt63978Z5P+qFdRafu0Mw7g+wp6fv7P
         DWTShNtBuaodgXcCbd/LX+WTdMg/UPuhCFsPKt9I7SpRjZ/ox0W74LFX0/A7QfMsL1py
         U5oF89c4/WPx32xP2WBg3Y2OC8crLOGsgpIY2d2BPq9ghILE9IzF56ydHjj3xBqoKgFe
         QiF+jg9H0jkDvXJfxXEFU4ONXoWoN1lkNfoPy0A1y6IK0uXtxLrNfiD1Mvao+RsjBGWo
         jOog==
X-Forwarded-Encrypted: i=1; AJvYcCV0x06Z9c5OOIpgFWd0CZPymVk69/Y4GKu05NdvFx4gBTXxmzi/chBG7wOVm24WA4UabsMDu7nq21ESLo3Lcwl8mIt5xqmh0hazoYqcqatWIV9Dp2P9k2ZDCd50Oh5t36YApqeqjMGLpQxWFTTenpebgaRQDc2xAFUfmyH5JNsGoZJ9irwdeQ==
X-Gm-Message-State: AOJu0YyD3uEvhAWmXpGYbS4XmopzGJk5/5uJQrFO6RR1v9bBneASgQ2Q
	ch6qrnmbkigCafvmvn+e0saMdTdI/vGyZqYbh4XCwHbdDDjKysgDR0BWHJcs
X-Google-Smtp-Source: AGHT+IGE4LzStzjy3+p85RFLZ1atlgGrMtQhjfPxzPxLnZ4RWfQOIWvXmhT2mGmjwvdo86Ag09pgBA==
X-Received: by 2002:a05:6808:1b1e:b0:3c1:7886:3699 with SMTP id bx30-20020a0568081b1e00b003c178863699mr941755oib.3.1708570014165;
        Wed, 21 Feb 2024 18:46:54 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id r6-20020aa78b86000000b006e2f9f007b0sm9431452pfd.92.2024.02.21.18.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 18:46:53 -0800 (PST)
Message-ID: <fafab67c-f87d-4684-98d5-6d9f82804bba@acm.org>
Date: Wed, 21 Feb 2024 18:46:51 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/19] fs: Fix rw_hint validation
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-2-bvanassche@acm.org>
 <20240131-skilift-decken-cf3d638ce40c@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240131-skilift-decken-cf3d638ce40c@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 05:56, Christian Brauner wrote:
> The fs parts of this should go through a vfs tree as this is vfs infra.
> I can then give you a stable tag that you can merge and base the big
> block and scsci bits on. It'll minimize merge conflicts and makes it
> easier to coordinate imho.

Hi Christian,

It would be appreciated if such a stable tag could be created on the vfs.rw
branch.

Thanks,

Bart.


