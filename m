Return-Path: <linux-fsdevel+bounces-59840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A18B3E565
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EDC441605
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A133A003;
	Mon,  1 Sep 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRG/ThSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F853375AB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733931; cv=none; b=CAyb98+BF78LIkQOSLXkagtFToArNZ9I8TpU9/p6dVTaR41ulfKT4dtcTw3lVPSCXvlIFTAJDSSxo0/jZ0yRSdiLyoLTTN2u/iF0feSO8jf/wOWOSslyOp6PCB8/lvxKc/ePn4HkffMVIYKZ5fQmnJi7KiByfBzq1UnmKPqcJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733931; c=relaxed/simple;
	bh=/NQr4Fzrj5u7T4v3gEVtjOziZJNCcfw9PANcMFZ8fHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4RF1VFpuSjN6Rs1TMrkMGCOy0KYxVI58/wO+1rw+ZfwiMHNwmJTqrWvtRbrhDExRUzT47y1S58eWK/+WVEJ7rlW2+51JT8eYcrdKzcatrsEudrjnMsTvh3l36MEQB6mYiBsrIBkHpxu55CRP6oyLGKLI80S/JLcCeS+S81FPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRG/ThSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756733928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WYwpi82W7VIihj8uBfuL+qMQaHX4FplKNy0RIRsXcCU=;
	b=YRG/ThSg+vf5ZEJ0hj2j8TYCJ4er4FkTLnR1/gq83+s3TxcBZqDhnQySUgR9xO7vhHDhmn
	AbEZAOz+jBQGdZPcNm63wz97VnaIYBcnnpqiseo6iNrP2L37bjQm+cU2EoXTCjAktb+2t8
	l5LNVEYzkIPyOgP7qjr6/Xdz8/W0Js4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-USr5UZoJPaaucxBHV09FDw-1; Mon, 01 Sep 2025 09:38:47 -0400
X-MC-Unique: USr5UZoJPaaucxBHV09FDw-1
X-Mimecast-MFC-AGG-ID: USr5UZoJPaaucxBHV09FDw_1756733926
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ccfd90630aso1871851f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 06:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733926; x=1757338726;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYwpi82W7VIihj8uBfuL+qMQaHX4FplKNy0RIRsXcCU=;
        b=qrAJjQkB513QRoz74fxiZ2BvLuu/35fmqauduXSK9ZHE8nBt0zRoEIFSUIsTPLlZXh
         6xmAHVPHjTXmkuvKCXhHTsJU5b5fpauFAE1XbD6nTKyifiGlannelUkdHLgzUuYYoyed
         MDL/c8yuBUe4vQ0fg+4qI4KMCv8WLGsTNpAASoWr5N2ubN9rChO85VpjuFUEq+0PYIvE
         5Q/208MMgjFm4SPBI5DMB14B2hNIiYwTqjSrK2hA5ErX2R7Usf7JLMFEK1vpGd1DR3gA
         B3PZCSuydp/iVbubeOvErSFaJeTd6nlugtTCrBXqeMYjHOGBIptmhMJ+xCdtFr13ygfb
         KqFA==
X-Forwarded-Encrypted: i=1; AJvYcCXSSPU1Cfdcd+MiXGjTj33BIbWgd/ir+TCh8Vpp8YUe8HfkWEpMAPxAKWp0QZ+a5clSsYyz3Ej7uVJn4ou0@vger.kernel.org
X-Gm-Message-State: AOJu0YyLo+rjPWJbKqIRO2ASQh0xpjQLGi90iX+kVOMJuDgYa3SURO4x
	oY3kTjNuKgOzb9QY8g/SFmkk3uvgycZ3fNWJqK8agrTlDvkFFn0czXahc2lK2ciOb9C3YvqURlq
	fHrAojLg93m/oc1wfIZl66h58w8VSV2FRhsB9Fs8w20Vfk8PleTJV0kVqpnYcZYaOO00=
X-Gm-Gg: ASbGnct/N1zWk0Mgi3RKRfq/pkzyMZsU65wwSbMF9N3opwnLHB9Lt7Cmv/rd8eoLRYk
	Z/fjZkouAEYDlytX3nJQyAHAsQBJgkc86LbtRfgNgK/kOaEsvgpAHY5UJAeqwsyx7a/+qhRh2ka
	9fuQ6r30a7xayRwi7j9UiCosOYdXkfCgYwKS96OzuiLDs+JYJeZp+b0E9d3DUFc9Tjzl43vH+Qg
	qrUEc8jqy1PckIBOmjlw8OVYK42ARJPd5KL1WAmDt3YEABZ+6K92Qf1CRoBqLG2IAG4aDSBFWs7
	Vb2u3TwNfaNrb7Ss33j3g810df9dbvMOScOwXnEqgrMxyofTFbddP+F0XYDb4aRPacPQtxgj0Mq
	iy6gMq4RPAvfeveKtUkHSO1NVEXU92G7iBJatGuqNTmwIHDZQE7UzqUAEpETFvteSE2g=
X-Received: by 2002:a05:6000:2102:b0:3d3:8711:d934 with SMTP id ffacd0b85a97d-3d38711dcc7mr3315132f8f.14.1756733926017;
        Mon, 01 Sep 2025 06:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3DliMw41VU4hxaIWHMLNG+OBiPKQ08qUXWAlqHFXtcpv953/vrh5P5rTJMXfl1jn2z2RQzw==
X-Received: by 2002:a05:6000:2102:b0:3d3:8711:d934 with SMTP id ffacd0b85a97d-3d38711dcc7mr3315078f8f.14.1756733925456;
        Mon, 01 Sep 2025 06:38:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a80c723sm10359081f8f.9.2025.09.01.06.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:38:45 -0700 (PDT)
Message-ID: <48ee3dd0-9af3-4513-aef2-25e185cce349@redhat.com>
Date: Mon, 1 Sep 2025 15:38:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] copy_process: pass clone_flags as u64 across
 calltree
To: schuster.simon@siemens-energy.com, Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
 <20250901-nios2-implement-clone3-v2-2-53fcf5577d57@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901-nios2-implement-clone3-v2-2-53fcf5577d57@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 15:09, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32-bit to 64-bit, with a new type of u64 for the flags.
> However, for most consumers of clone_flags the interface was not
> changed from the previous type of unsigned long.
> 
> While this works fine as long as none of the new 64-bit flag bits
> (CLONE_CLEAR_SIGHAND and CLONE_INTO_CGROUP) are evaluated, this is still
> undesirable in terms of the principle of least surprise.
> 
> Thus, this commit fixes all relevant interfaces of callees to
> sys_clone3/copy_process (excluding the architecture-specific
> copy_thread) to consistently pass clone_flags as u64, so that
> no truncation to 32-bit integers occurs on 32-bit architectures.
> 
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   block/blk-ioc.c                | 2 +-
>   fs/namespace.c                 | 2 +-
>   include/linux/cgroup.h         | 4 ++--
>   include/linux/cred.h           | 2 +-
>   include/linux/iocontext.h      | 6 +++---
>   include/linux/ipc_namespace.h  | 4 ++--
>   include/linux/lsm_hook_defs.h  | 2 +-
>   include/linux/mnt_namespace.h  | 2 +-
>   include/linux/nsproxy.h        | 2 +-
>   include/linux/pid_namespace.h  | 4 ++--
>   include/linux/rseq.h           | 4 ++--
>   include/linux/sched/task.h     | 2 +-
>   include/linux/security.h       | 4 ++--
>   include/linux/sem.h            | 4 ++--
>   include/linux/time_namespace.h | 4 ++--
>   include/linux/uprobes.h        | 4 ++--
>   include/linux/user_events.h    | 4 ++--
>   include/linux/utsname.h        | 4 ++--
>   include/net/net_namespace.h    | 4 ++--
>   include/trace/events/task.h    | 6 +++---
>   ipc/namespace.c                | 2 +-
>   ipc/sem.c                      | 2 +-
>   kernel/cgroup/namespace.c      | 2 +-
>   kernel/cred.c                  | 2 +-
>   kernel/events/uprobes.c        | 2 +-
>   kernel/fork.c                  | 8 ++++----
>   kernel/nsproxy.c               | 4 ++--
>   kernel/pid_namespace.c         | 2 +-
>   kernel/sched/core.c            | 4 ++--
>   kernel/sched/fair.c            | 2 +-
>   kernel/sched/sched.h           | 4 ++--
>   kernel/time/namespace.c        | 2 +-
>   kernel/utsname.c               | 2 +-
>   net/core/net_namespace.c       | 2 +-
>   security/apparmor/lsm.c        | 2 +-
>   security/security.c            | 2 +-
>   security/selinux/hooks.c       | 2 +-
>   security/tomoyo/tomoyo.c       | 2 +-
>   38 files changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 9fda3906e5f5..d15918d7fabb 100644
> --- a/block/blk-ioc.c

(adjust To: list)

Hopefully we caught most of them. The ones not called "clone_flags" are 
a bit nasty.

We could have split of some changes (e.g., trace event), but likely not 
worth  it.

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


