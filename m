Return-Path: <linux-fsdevel+bounces-63176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8546BBB069B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44372194617E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A6921ADB9;
	Wed,  1 Oct 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se7Sz0lV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E21F461A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323932; cv=none; b=JCFAkGBb3nQAF3hPPdBnpgC5EJnWKsni8VeJMKSedfV5LGQ5s2iSJA2umKv/hEA26fY2s+IleqfqxMbn9MNozCXT3mQOKmJkh6kpu0DhL1zBgBzAQN73S2K3+c0z2epat8SNM5YwFsnJFCp8WeUWsVg5ukySUjkzgWfdSjd3YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323932; c=relaxed/simple;
	bh=jBmuWH0YUH02uvaUnpyESyNBWMLetO9tuvs3IcDBVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5J71BwfPZN2is5hdvy835WtQ0lUqaYFMJWAjC1YNEgyoLJ3pUJ+8oAbF7O3C42oCAq+oK0mcACZS1CPSL6GzCKBv7NCNXznKDIokhce6yh1lWP0acWdNLL4iXROLFNsrS/xY4zXVraOIH72kDlwFShb6qSIf5F1XdYl3r9RPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se7Sz0lV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174b335bso820112a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759323930; x=1759928730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=Se7Sz0lVmzUHFL7SsLjlQGxP0QJykPNzaNC0heYDRZkQHijNIQeJm8ud/pKzvfPwvy
         s6HOgrWLdXNNJmEjRTrA8cbq0eMzo9kXgmye38cuuxlEtpzulRQGZflPMn3dXl8KEyb/
         w5RzSPChuKTODquLAL6bAXpm433q6Ffi/X5v8czctQ7TjgLTr54mrlWNQ/DLJKmI9Y0k
         ogxI2rlwLCyshPXOHrP/I8wPezbT2E+okvex62ukiYTqb20lrnLcVPJroRox8T8nDO3Q
         2cbKRBF/mpBdpGOBxMWqLBf6feE7iJ0lJg1lQcUEBqNS4r5q4eqzdNcUe2e69BSlNj69
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323930; x=1759928730;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OW6l6wKrmChiKbh7o74M96nQdgGsULiYNKDhud2+Lm0=;
        b=B081JqkP5ETx1IomykDrVHNNZqBRjA91BT62U3YRK7QFGivNt+N4o9PF/rsCGY/6yP
         tudgEpCi4E3UrafbqBWsYCx22y9Xr0zSeetq1CO40fwZw9e+EqP6YIqPFPOWkHV9rXAx
         wj2b8nmLGT5Ss1hMhl/rHpx14AispWGMjIaCjf+oGytHGjsQFb0a+XGlvCTwKQK3sZGX
         XpCXHFQjouyWSziLIQbchDa1mNu+O9ZoiAryy6q0NbdsuRRTHhgX3SdvMkS9D76KiOVx
         aKK4ujYwFmUDkZc/1GQZ4AcsHZl2PZP162jdCHBPaErrcWYG906XhHs9zBWX4BArP7iX
         7Gtw==
X-Forwarded-Encrypted: i=1; AJvYcCXQFsZq1bynrEq2XR20E2lATT1J2F855eMqDSMIrxIa9lvOw6hWaYlmd1hxr4qeiwAwqn30+gR5myue8tnY@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVXhwaaPOuoq7TD0n640D3YXNvksXLT7KCajykfGcuZah5of7
	vr+REji1WpLL5sk5NTk7kRfj/UIggS7Dvj6sH5/VZbtJyRZhszgDCBzm
X-Gm-Gg: ASbGncswsDhf8u0jfN0M0TRxl3LBir8JdlhDYWfV58CJwNsXalIe3zVQy9FqXBBgYhO
	SHonlnEKu1GuJywpBpPXGtlmz2WkeXN+EEMsAwLetNcfkRLsPEl6mjPI8TMRwuI6C85rBYOEGgv
	r2z+uBEpUIHUYP2wYaMLL4tyeCZj966ndwfCwMLzTu/mKCmXCHbJnAwTMBJsxo39E/ZbtVpaJH9
	HF3kjy6vYN+fp0ilaE3bFxdlxPeZkf7Tf/CIE3V1/gq8SpGALGCorsI4pbMBeee8/vKhksn68Ys
	WLEcOuL/E/zd7Ldpqe46ZU3GYqUQP/PBwSYXgCHkxyshvhHafO2h1SIHE9FZgpYHGCUe8OolZS4
	3XGHi+VfiF2Qh20vYcd0ebKQgpmTHxG9losoOBjCUi+ny76lkGsWYNlRi+6ZI6QLcWB+ADir89g
	sxUT1Oa9aanHYfh7uoFtY=
X-Google-Smtp-Source: AGHT+IHoa5xa4f1XTAIYI78HgS2grI+zOJxKw/L/F6af+N9ErpstXh/VbzIlNsFq6puzwXgpQewq9A==
X-Received: by 2002:a05:6a21:32a0:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-321d882a178mr2574832637.2.1759323929715;
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Received: from [172.20.45.103] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557500dsm16012934a12.34.2025.10.01.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:05:29 -0700 (PDT)
Message-ID: <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
Date: Wed, 1 Oct 2025 06:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
From: Kyle Sanderson <kyle.leet@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, axboe@kernel.dk
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com,
 gjoyce@ibm.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Language: en-CA
In-Reply-To: <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/2025 10:20 PM, Kyle Sanderson wrote:
> On 7/30/2025 12:46 AM, Nilay Shroff wrote:
>> To address this, move all sched_tags allocations and deallocations 
>> outside
>> of both the ->elevator_lock and the ->freeze_lock.
> 
> Hi Nilay,
> 
> I am coming off of a 36 hour travel stint, and 6.16.7 (I do not have 
> that log, and it mightily messed up my xfs root requiring offline 
> repair), 6.16.9, and 6.17.0 simply do not boot on my system. After 
> unlocking with LUKS I get this panic consistently and immediately, and I 
> believe this is the problematic commit which was unfortunately carried 
> to the previous and current stable. I am using this udev rule: 
> `ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", ATTR{queue/ 
> scheduler}="bfq"`

Hi Greg,

Slept for a couple hours. This appears to be well known in block (the 
fix is in the 6.18 pull) that it is causing panics on stable, and didn't 
make it back to 6.17 past the initial merge window (as well as 6.16).

Presumably adjusting the request depth isn't common (if this is indeed 
the problem)?

I also have ACTION=="add|change", KERNEL=="sd*[!0-9]|sr*|nvme*", 
ATTR{queue/nr_requests}="1024" as a udev rule.

Jens, is this the only patch from August that is needed to fix this panic?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-6.18/block&id=ba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Kyle.

https://lore.kernel.org/all/37087b24-24f7-46a9-95c4-2a2f3dced09b@niklasfi.de/

https://lore.kernel.org/all/175710207227.395498.3249940818566938241.b4-ty@kernel.dk/


