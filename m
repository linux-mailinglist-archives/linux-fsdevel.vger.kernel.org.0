Return-Path: <linux-fsdevel+bounces-64090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B4BD7916
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B3B1920E52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A82C15A0;
	Tue, 14 Oct 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l6v6uzQV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFB158535
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423315; cv=none; b=KzbXF+YnFzL6KND+030W3RHQzBFkHhlYOMLtofGDLT1C/JXKrVyie/gF5vBNHOtZkwWA+5SxzFqs5PJqZop0RiLJJ9FME+1zlmbCmFoHguontAvlr7Uxv0JtYlVDWB7i+d7KPLYkm/9hajuczAoKItxoFuGXetMksM0YJsv/JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423315; c=relaxed/simple;
	bh=OpDb8zcmf7OOOUcsljWtaBvRup8+IOw7WICjSqXWuEE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lM6yOuTZCdfTxQpDc/keY9YLD+9lglyVPikLRATO5Dbt9Yi5+frMrI2QwbBlO6H9F35lNaERm3wEpnez1Cqx8jK236gvifcgf43m6T8JmhWCZ9JlwHoWBJg8A5SCkt4o+EB1oaxWfKNRIUvsfLmppsWOJlfED121WmAgby6MaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l6v6uzQV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7ab0012e05aso3590709a34.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760423312; x=1761028112; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=brM2AXzbshOug5S8YTD/rMQwcF1ZQ1CEjKwrbSaUSno=;
        b=l6v6uzQV7BveO2h89PmRTKoHW8euu9I+keWirj34S0msvsJW2fBEG+HQhQXHtVZRyZ
         bAmYTGJHxisFUgCov0+FcZe5K3abP4f2iZQ1Mn8bqT1S5RdQ5PBur1UZht0L9S11fGL9
         qvghedPpPUz2aOXxXqme5WX3y1mfUmjSYsaQfIKUId1PlcXO3i6iGhpRgl9QMDKyZQIm
         p/ozVMclJLwaU7GrB/cH5E3zGZTbcBdanWzalRPrUD7jI774MtRkJCGCAMYwWOcp9/nR
         uJ2MuQ+FFOGkY5hm9dqA9Nb7ZFoYr/vo+y60HABh2tfrPuBcSM3/LfuL472B1WxPBJ25
         5sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760423312; x=1761028112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brM2AXzbshOug5S8YTD/rMQwcF1ZQ1CEjKwrbSaUSno=;
        b=HjYwSibGACOe+f88aVr9lAJZPy1wvsOVORIAAYeqEYOF/scnC7JwOr7wJONNTR31wI
         X0K6pV0TzIdpUym/3IuZ71+J5iEH0aCHjQHGc8cgebUb+va+W1SJA7GzfJ/UD94oT2NX
         2ZwSt4+bc12vXH97HubDpEIXYjfQlhfS8Kacv7u2PESypyXEHTO7xRb7MZAieCPPijgV
         5DBID2p4MUOkXSBy6JLia+IaTXslA+x3IVcmWkIlv4NXyayama6MllcLbHhppRLoaYTv
         UwOpiaTgssVRXIN0P9pXaHkhiiqqRw6/q3jR7tB0oUgeF2EW4D5MipSHchbpiwXyYms9
         jQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAI+SNOhaMOckYDJZVYKaj1IAc7ECFuBNiXOHCITLNE88ne14wXRbkGd0Kx2+O530mngMNcKKT3WralSpn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjx1DF8q0IdZ6HuyQrotXUBRYLygSWO7Ic5ILklvKrCrq8BYsl
	LZBvKxfEbIps72pBPosfQV09fEKXgxjgicYMh7lvO/KARuAtsT1jb8AIOaXP1MIOvA==
X-Gm-Gg: ASbGncvAaY2uWrxP00mmSbA1wEGTkEcBzxhLkzpdjpv7E+9K3/1TdvtRMuhHLdNVfqc
	27+L2q/uVI3nan1aSHl0xKrZsviD4Me5IeqwTmuLjXdiwuaV9//MRxZWfFUa3l9R0DMXeBADMbK
	2RFjp8yvfPZW10AQS4ppX2pz3SKPkD+hFzBWk0ME/ICGP9xj871REWbF1W4no/PSKdaN3QxNMP9
	X16BgbIcN+VTHszl6Zc6MlHLptE2s8r+c4qegLnBhmO6dTWiJ4AmUntxsw3sd8i9tGnn3NK2yzV
	0g4jBbiW9q5kjQP4PHvcRCZMTpJePHQE39EXvFjM4a2uL029AIEvarRV8Ug+gxfKi5hf02Oyi9G
	6Gk2mQDWBmwLhkEDM821R86jBTyBKX9zQ87hPUG2wDoVoHeptvF8QOG5m98HNnuFUfk6ozonNwQ
	2yeXcDKYrEqvIw006FvPxAKJ0ijQnAd9K3
X-Google-Smtp-Source: AGHT+IHpAC62Y/PpF9N39pOEV4oQ+R34+qD97A9mi5Ss82ojK2v3fSuKrUmSuLa+MCNnAOAp+Ihp0w==
X-Received: by 2002:a05:6830:710c:b0:744:f113:fef8 with SMTP id 46e09a7af769-7c0df7becc1mr11002097a34.35.1760423311621;
        Mon, 13 Oct 2025 23:28:31 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915eed4sm4209133a34.36.2025.10.13.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:28:30 -0700 (PDT)
Date: Mon, 13 Oct 2025 23:28:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kalesh Singh <kaleshsingh@google.com>
cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
    david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
    pfalcato@suse.de, kernel-team@android.com, android-mm@google.com, 
    stable@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
    Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit
 checks
In-Reply-To: <20251013235259.589015-2-kaleshsingh@google.com>
Message-ID: <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
References: <20251013235259.589015-1-kaleshsingh@google.com> <20251013235259.589015-2-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Oct 2025, Kalesh Singh wrote:

> The VMA count limit check in do_mmap() and do_brk_flags() uses a
> strict inequality (>), which allows a process's VMA count to exceed
> the configured sysctl_max_map_count limit by one.
> 
> A process with mm->map_count == sysctl_max_map_count will incorrectly
> pass this check and then exceed the limit upon allocation of a new VMA
> when its map_count is incremented.
> 
> Other VMA allocation paths, such as split_vma(), already use the
> correct, inclusive (>=) comparison.
> 
> Fix this bug by changing the comparison to be inclusive in do_mmap()
> and do_brk_flags(), bringing them in line with the correct behavior
> of other allocation paths.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: <stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> 
> Changes in v3:
>  - Collect Reviewed-by and Acked-by tags.
> 
> Changes in v2:
>  - Fix mmap check, per Pedro
> 
>  mm/mmap.c | 2 +-
>  mm/vma.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 644f02071a41..da2cbdc0f87b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		return -EOVERFLOW;
>  
>  	/* Too many mappings? */
> -	if (mm->map_count > sysctl_max_map_count)
> +	if (mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>  
>  	/*
> diff --git a/mm/vma.c b/mm/vma.c
> index a2e1ae954662..fba68f13e628 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
>  
> -	if (mm->map_count > sysctl_max_map_count)
> +	if (mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>  
>  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> -- 
> 2.51.0.760.g7b8bcc2412-goog

Sorry for letting you go so far before speaking up (I had to test what
I believed to be true, and had hoped that meanwhile one of your many
illustrious reviewers would say so first, but no): it's a NAK from me.

These are not off-by-ones: at the point of these checks, it is not
known whether an additional map/vma will have to be added, or the
addition will be merged into an existing map/vma.  So the checks
err on the lenient side, letting you get perhaps one more than the
sysctl said, but not allowing any more than that.

Which is all that matters, isn't it? Limiting unrestrained growth.

In this patch you're proposing to change it from erring on the
lenient side to erring on the strict side - prohibiting merges
at the limit which have been allowed for many years.

Whatever one thinks about the merits of erring on the lenient versus
erring on the strict side, I see no reason to make this change now,
and most certainly not with a Fixes Cc: stable. There is no danger
in the current behaviour; there is danger in prohibiting what was
allowed before.

As to the remainder of your series: I have to commend you for doing
a thorough and well-presented job, but I cannot myself see the point in
changing 21 files for what almost amounts to a max_map_count subsystem.
I call it misdirected effort, not at all to my taste, which prefers the
straightforward checks already there; but accept that my taste may be
out of fashion, so won't stand in the way if others think it worthwhile.

Hugh

