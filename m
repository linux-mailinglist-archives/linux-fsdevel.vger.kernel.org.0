Return-Path: <linux-fsdevel+bounces-50246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D484DAC97D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 00:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8A57B758E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 22:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A7928B514;
	Fri, 30 May 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cUql0G7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FA2853E2;
	Fri, 30 May 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644973; cv=none; b=oTjQ0ztaae4g2zV9RsH2efAk26DJ6f0ClTr3BT2XU4dmHpvN6LuDoJlitPa2d38hf72Yb0nCcsP34at0z0Sc3OjnlUkfp68oQLq7GDU2V7wPqzteCLtZHRJx85NlvRxryP2sPAjFe+ehSVEdYn5EzcCe71mRssQWJFFvFSiUrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644973; c=relaxed/simple;
	bh=B/iHNMvw8mF0JmcbV/Ww2Zu1GyyER0SInWNMF1ybJBs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pRDITXUwEAi14Z3Ysgz4szrHwX48xGpUGPC3MuHXC1vW3zyr+YrfnmMppt0nA0wV75uIQG31svdeVEisxMk1IUzMonOSvsKpS7X0xk2tkLacc8NzkqPj8dDQpH4dI740xxh8lf7ckrJb3CVFXW7Y91i59MQoEL+CWP67b9dK/o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cUql0G7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A865BC4CEE9;
	Fri, 30 May 2025 22:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748644972;
	bh=B/iHNMvw8mF0JmcbV/Ww2Zu1GyyER0SInWNMF1ybJBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cUql0G7MM2YqNN/UBvnnZgBT5VGYfWKe1XBDEBCJVTML/dklTuCOChratyStM1z3r
	 NJGXoD/xMliKV8+qGZt/n12lWHmh43UX9/OjWVD4xk4/ASqHI1bHx3hR+6ehcrgJ/t
	 CSb9wxzn0ZeI/U2uCsz/KkL5wFRvOwr+0ymJ1WYM=
Date: Fri, 30 May 2025 15:42:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bo Li <libo.gcs85@bytedance.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 kees@kernel.org, david@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, peterz@infradead.org, dietmar.eggemann@arm.com,
 hpa@zytor.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, jannh@google.com,
 pfalcato@suse.de, riel@surriel.com, harry.yoo@oracle.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 duanxiongchun@bytedance.com, yinhongbo@bytedance.com,
 dengliang.1214@bytedance.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, songmuchun@bytedance.com, yuanzhu@bytedance.com,
 chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
Message-Id: <20250530154250.15caab4e3991de779aabe02c@linux-foundation.org>
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 30 May 2025 17:27:28 +0800 Bo Li <libo.gcs85@bytedance.com> wrote:

> During testing, the client transmitted 1 million 32-byte messages, and we
> computed the per-message average latency. The results are as follows:
> 
> *****************
> Without RPAL: Message length: 32 bytes, Total TSC cycles: 19616222534,
>  Message count: 1000000, Average latency: 19616 cycles
> With RPAL: Message length: 32 bytes, Total TSC cycles: 1703459326,
>  Message count: 1000000, Average latency: 1703 cycles
> *****************
> 
> These results confirm that RPAL delivers substantial latency improvements
> over the current epoll implementation—achieving a 17,913-cycle reduction
> (an ~91.3% improvement) for 32-byte messages.

Noted ;)

Quick question:

>  arch/x86/Kbuild                               |    2 +
>  arch/x86/Kconfig                              |    2 +
>  arch/x86/entry/entry_64.S                     |  160 ++
>  arch/x86/events/amd/core.c                    |   14 +
>  arch/x86/include/asm/pgtable.h                |   25 +
>  arch/x86/include/asm/pgtable_types.h          |   11 +
>  arch/x86/include/asm/tlbflush.h               |   10 +
>  arch/x86/kernel/asm-offsets.c                 |    3 +
>  arch/x86/kernel/cpu/common.c                  |    8 +-
>  arch/x86/kernel/fpu/core.c                    |    8 +-
>  arch/x86/kernel/nmi.c                         |   20 +
>  arch/x86/kernel/process.c                     |   25 +-
>  arch/x86/kernel/process_64.c                  |  118 +
>  arch/x86/mm/fault.c                           |  271 ++
>  arch/x86/mm/mmap.c                            |   10 +
>  arch/x86/mm/tlb.c                             |  172 ++
>  arch/x86/rpal/Kconfig                         |   21 +
>  arch/x86/rpal/Makefile                        |    6 +
>  arch/x86/rpal/core.c                          |  477 ++++
>  arch/x86/rpal/internal.h                      |   69 +
>  arch/x86/rpal/mm.c                            |  426 +++
>  arch/x86/rpal/pku.c                           |  196 ++
>  arch/x86/rpal/proc.c                          |  279 ++
>  arch/x86/rpal/service.c                       |  776 ++++++
>  arch/x86/rpal/thread.c                        |  313 +++

The changes are very x86-heavy.  Is that a necessary thing?  Would
another architecture need to implement a similar amount to enable RPAL?
IOW, how much of the above could be made arch-neutral?

