Return-Path: <linux-fsdevel+bounces-61139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606A2B55831
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 23:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D6B3B762B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94C32F77D;
	Fri, 12 Sep 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNmb4SFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFA334375
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711597; cv=none; b=F9/PCsf6NgqkzUHO2BXmJlQoWJj5bqf5bsfqbdBnhb9xc2grR/j2MOlv6bB1oVhmEhX1/8WClfktOfLtbnOEXGqJvcziiliYYLC2oGlONLU963+07/2Omal8lSq7me2X63vp7DdDXSQx7UOrZ/KgDBO47yeQcpC3VMzuynmL1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711597; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cczb1Ub2NYFq7ujuERAZhfIJdibSPmCcDN/ePI7Z10KalLuWa0rDKqYqHqid0hjjXikQCTxey32yhywfV+9uQYL4igiTOt3xTDKN4YZIyQYkeSjEljTPjzGGxdGSkIDd0xFP7gl4jyE6de92HWD/kkl/e0sawibOmLYpEjlpVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNmb4SFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=BNmb4SFhg5vtKEAZ2u88geYPbXKfOKLXJSc/lcuuSvdflUl61PxqRI+oUueNbUTRdcewi9
	xMCzqSBsrFKAmDmf/RonyTOgORuz5Oud3YJzivIxr1JiNzhhEH9Evm5/HsIvBr+Hf8rmWX
	SvptbA9Q/ZYEbEmcORc6zuPZlqIvKQI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-taJEYVfGNAqhMXUvNKEjDA-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: taJEYVfGNAqhMXUvNKEjDA-1
X-Mimecast-MFC-AGG-ID: taJEYVfGNAqhMXUvNKEjDA_1757711592
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso59046401cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=rKRVZvCWeipINoMbeTmQrQxEwIaXWwuXq6jEw5redpZ9F9xFmVqkLD+3yZF8uBdxnJ
         tE7JvAEyVMFkVFL06WWLqXVK4CmeXayyQ6DBVYUcbqQyw52Xja6knhchUGFk2wArxYTQ
         GhuQHpRv8gHwlT3LO3w9bqR/I6Rbww3mkxGfHsVzVe37lWpbumq/nf8kP/r0Syffd0DJ
         JLnnzY4ohKelDqmuAnorNOgCzNuBQMwCqv+md/9TRjZ5u17QT/DQF71ukI60/OXT/+IT
         LfkvrC2b0PDbe9ZUa5ZZQPdeCfeYPNab9+KEwUmWSV+UuJysnBxVYsTAc2WPzmJuCczL
         8FZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsaAVj1FK6UN4q86q5/YY8J3uePzVnG7ZVYYyWDyDT8U8G45fOctagwxYzGtKrcsdg+F2LYcmNIJLnFgt9@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCrkOx/tCTX5NHzzq/z1iAL2rS0F4J2bfl45rFenn3Awypqow
	iyt6uSwSZbrhR//8w9SWUGjM8mCd/SGXz66V5ORWUuexR5ES0jfpSVaw+N+oFZBD8Fgbkfanx/V
	AcTEbL5d8Xd5KLh2IQhmcC0M5YW3x5D6hiXW3kD+3h6VDuh8NzEU5LiaSN5SjINvo0lA=
X-Gm-Gg: ASbGnctrMLd4Q5bOh3VlwJy/6XL0ZFivIL2IMngE9DQ1dMXJfE7go/SbaB+ape22npQ
	Bk1KqkfNIC6c2od9ubxZ5DiFR9BDa43djDVv8kV9u8sSMJg2unufVVQmyvpVoBKmDNa277gMcsg
	Lo/8+TkuuxWA5Pdo01pRme+k3s7l37HpdSpLoA+4pLpZ1P8wvSbB0c1GX7yjSg6rrJK+kxOSH6Y
	8u/C0+ckaANunuZzCB5nN23MZv9pvIaZvQZuJ3x+xKhpheY8zA0woOQWcfW70gVV9AEsS7CW3uJ
	wiULlgGTH3tyLzxikvvVvY80YAVq+16Nrj7OOMDhOtA2sfI5/4P+SKCZdh8K8C8hldAV3e/IHdo
	4gwSSPgn/ew==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549581cf.25.1757711592219;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman


