Return-Path: <linux-fsdevel+bounces-39923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA2A19D8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 05:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D936188E40F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077A313A3F7;
	Thu, 23 Jan 2025 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joY9kFvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFE74C08;
	Thu, 23 Jan 2025 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605680; cv=none; b=D2six3/dvQ+ER+MlT2Ot2gpC4wwj7M5Jmw1RrYhtpGQNtu0TRBGuSFgcKEv6ni/RYvEMtTL1TB+xMVtOQMCUGfaCO8bwxmsiRgFMs8qdBK7SJ0BrM4ezGK0RXylr2AD6/ae07T8/zQmFgQ9P/yGpTBOKPjYAiqH+v5nN7sICjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605680; c=relaxed/simple;
	bh=6C4+iWlMyg6PxawXcBkeK+7KyoDA3lgJdEYVa4kcDoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhx4cBYpyiRWDg3aM3BMr/wZyHypfjLfh9wOUuAHV1Kq1K4Qwt4F/3sn3XpgU7C0FzQiMubL5Lx5lA8wmtP67wQQfnwBwYKLkD3hVfZKRf6t9E9LFHvlFFnfrpjwNfqhYb1bekLKMYH0YEdfwSMWwySc1ZB3Dfwu0DVUULnA7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joY9kFvk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216426b0865so6353685ad.0;
        Wed, 22 Jan 2025 20:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737605678; x=1738210478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppkXNpZBrPqSK+GsWeQ9xKnnQtyLYONJUiaFJ4TfvHE=;
        b=joY9kFvkBWjF93t6xBIcxN+lLZNhglqd7aOaO9hLUZE2OEtsCGXBa7styF3oH39/SS
         QnJCWb6T4pWTxjRTQhwIjDIyXUv/99HWCgna0j6nPdzw9NOCI14Jo3vl4QSuxhvrrjXB
         Ki1N4jyu8ic0QuLPWBXE35Jhw1yswtAAonLTfoeWWWeLfwXEOcPTFVpLnSemDPQE15I/
         xfpfo9qdOiOtU2fljMcR9qRyfg0QmK/mrV0m3iazSD5T+ro3SyYHxI22/OOSgNcXU466
         F0jKXkgAUR7jkxBigG6VHF6lDitJtQWEc96uDa4R6RAvqMIPsWkk6G+5R9YxFyNOAI3f
         c2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737605678; x=1738210478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppkXNpZBrPqSK+GsWeQ9xKnnQtyLYONJUiaFJ4TfvHE=;
        b=Wmnrr+emo7PrV6eIMsbCh67uHwrk32LOi4fl2AxzJzIeqsCXlGvnBq2Ds1ta900s46
         RmSqmxjF37B8Y1By7RKjE24zJSyYUcV3nmj+yG4RlM99xAvp161T2ku86tZp2Rkh0QI3
         wP3aNq7FBHlfLxJ2zd3Fdi3wE1KZTlgwscsXAe9hIgoQd1epT/nQrK0cpRoGNFYjRheZ
         GSNYDaY2/RQPXhRAjoKIr3CcY3FIhz1BjAU1eSgDkSqFGWX5DQGy2FlFCr4GW6QcIpwH
         1qkUlIXIk9nehITW/JigbV73niPPLgUB1ZLedUGoT70/+xKcPY7xHuMEyibcJoPTv9H2
         bA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaPlxQ48aqLytQcEbGiaS7esESOOu4K/azCXSDHOlOp/dgXarngf1vtO+slHBJ+JFOfZ76pMlxTnGlXfEG@vger.kernel.org, AJvYcCVl/dwMofy6NRK4wQ8hlI2xhzm+iCL/ah4OpNyD+TKWo7JrVQr2l7I8V4ocB5jq2XeMFEhGqlyrTbUGv2TO@vger.kernel.org, AJvYcCX/Y6DqScdRWxZiM8DnakflGmmoG4CgHkgQsB+mqi9sbHmAHc5CSKp16A6OiYl1UdfMASsZRym5ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXA/gw8aGQicLQ+X09sD8Va+/oGdMrGaqzefdnZlTN2ez1hNkq
	XJA8aT72PgIgHOfVk8n4HHlMMo/j8vRYaOmeqGJXIQeg1GG18RmrmswgxQ==
X-Gm-Gg: ASbGncuEbzDlZFJE7N1/X4GTF4rNai+rU3YvBTlF00Zghiu8Aah3xO2V024QD9pgiWo
	mJbKz8ZAGH13BHLv2Q6fzGOZo0xrCQmIpU+4BwC3LHAeuVDJgLex0QyqCarVtWYiSpkDkZzlrjk
	hnXfRxkaG8kAPw8DHvZG5PL7qxDyfM3/DjnV6OXTbqzW6IrT40grumRzDno+EPClmTDemNHZ/xr
	TVz5zujy0UHVXv1QyogiZE99lTlozQbgMp0vcbGNhJxm5p3+IoMF/L4eIvUoUFNlCBfFLYXmk3X
	Nh2VVVmURMVQAiZazr53xRKU1YJZmcwJkjRTC/T7lis=
X-Google-Smtp-Source: AGHT+IH5Bh8F2DrNQIkivjf6Em4wLwWvvPxYEnSMigCZuYYQfZPIU5Ke/xGHGISHVWN27gDow2cH5w==
X-Received: by 2002:a17:902:c951:b0:216:5268:9aab with SMTP id d9443c01a7336-21c355e832amr340474985ad.46.1737605678018;
        Wed, 22 Jan 2025 20:14:38 -0800 (PST)
Received: from Barrys-MBP.hub ([2407:7000:af65:8200:2131:57ed:b1d2:a6a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d0b543dsm103567005ad.103.2025.01.22.20.14.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jan 2025 20:14:37 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: lokeshgidra@google.com
Cc: Liam.Howlett@oracle.com,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	bgeffon@google.com,
	david@redhat.com,
	jannh@google.com,
	kaleshsingh@google.com,
	kernel-team@android.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ngeoffray@google.com,
	peterx@redhat.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	selinux@vger.kernel.org,
	surenb@google.com,
	timmurray@google.com,
	willy@infradead.org
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd operations
Date: Thu, 23 Jan 2025 17:14:27 +1300
Message-Id: <20250123041427.1987-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240215182756.3448972-5-lokeshgidra@google.com>
References: <20240215182756.3448972-5-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> critical section.
> 
> Write-protect operation requires mmap_lock as it iterates over multiple
> vmas.

Hi Lokesh,

Apologies for reviving this old thread. We truly appreciate the excellent work
you’ve done in transitioning many userfaultfd operations to per-VMA locks.

However, we’ve noticed that userfaultfd still remains one of the largest users
of mmap_lock for write operations, with the other—binder—having been recently
addressed by Carlos Llamas's "binder: faster page installations" series:

https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.com/

The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_register()
and userfaultfd_unregister() operations, both of which require the mmap_lock
in write mode to either split or merge VMAs. Since HeapTaskDaemon is a
lower-priority background task, there are cases where, after acquiring the
mmap_lock, it gets preempted by other tasks. As a result, even high-priority
threads waiting for the mmap_lock — whether in writer or reader mode—can
end up experiencing significant delays（The delay can reach several hundred
milliseconds in the worst case.）

We haven’t yet identified an ideal solution for this. However, the Java heap
appears to behave like a "volatile" vma in its usage. A somewhat simplistic
idea would be to designate a specific region of the user address space as
"volatile" and restrict all "volatile" VMAs to this isolated region.

We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag will be
mapped to the volatile space, while those without it will be mapped to the
non-volatile space.

         ┌────────────┐TASK_SIZE             
         │            │                      
         │            │                      
         │            │mmap VOLATILE         
         ┼────────────┤                      
         │            │                      
         │            │                      
         │            │                      
         │            │                      
         │            │default mmap          
         │            │                      
         │            │                      
         └────────────┘   

VMAs in the volatile region are assigned their own volatile_mmap_lock,
which is independent of the mmap_lock for the non-volatile region.
Additionally, we ensure that no single VMA spans the boundary between
the volatile and non-volatile regions. This separation prevents the
frequent modifications of a small number of volatile VMAs from blocking
other operations on a large number of non-volatile VMAs.

The implementation itself wouldn’t be overly complex, but the design
might come across as somewhat hacky.

Lastly, I have two questions:

1. Have you observed similar issues where userfaultfd continues to
cause lock contention and priority inversion?

2. If so, do you have any ideas or suggestions on how to address this
problem?

> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  fs/userfaultfd.c              |  13 +-
>  include/linux/userfaultfd_k.h |   5 +-
>  mm/huge_memory.c              |   5 +-
>  mm/userfaultfd.c              | 380 ++++++++++++++++++++++++++--------
>  4 files changed, 299 insertions(+), 104 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index c00a021bcce4..60dcfafdc11a 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c

Thanks
Barry


