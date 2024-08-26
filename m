Return-Path: <linux-fsdevel+bounces-27081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B50395E721
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E8A1C2119D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8D29402;
	Mon, 26 Aug 2024 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e4+AllZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387DABA33
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641325; cv=none; b=hBpPTKczfegXkLv0SGGtFLBhYplmn6iai3KzrlYsdXhuJl6RXlQAI0MITTb/iilFtCELiTurwFG+MBZqtpln2FkIlKo/4+Pfb1UL320oHD3qRm4j2w1YwsK1ddJvxbD5XY/DU2qp7p55/ph3Ez+QqaPRZ+GbmhPPDQBEYm6KQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641325; c=relaxed/simple;
	bh=J1pA5SXK1PXEeoiPQmdrthi48tug8rU4W16JsDTgto8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciabKEiOwonoVehJi+GkCP17V4l2Lom8+MaZDtNcigAqZhuGGJTDOdPPPxnR4pe1wrvgivWuw3tj8jvY98R7tLE3eE6G0rJavbQc7H6Td43EtkCtiFX8yfjn4jbmLns3LbZVTke8YB/Wn54qSya+frdKd5hfdQOyseXYX9Ls7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e4+AllZ3; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5d5b22f97b7so4349281eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Aug 2024 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724641322; x=1725246122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqMidpjTyEAXSrDATi1bJfGrokKfF0LLoZX42RYAeCY=;
        b=e4+AllZ3zib2IgTrQtP7sLXdpxd1NNWHSIMxEkidbtquaBtHFCZNAynb0X6p4fUeaK
         tZv9SQM/AmFolJEBYIS1x56WscCNZ8TIgDd+EiOfNx4f3llbuE0diKGVLKOaT6CUqgrL
         PyXZgdUGeMeW0RYvJSjWU0R9ugoJkF9iBT6mGUbhSMId6pP76pAgE2rQSqUxcFvfwnnV
         asmNarlSndUB7GbG0f7NICnMRPhoOENa9OJaM/vsoF8mzgT1jX+enCEtbw8z/TDybbx5
         A2WhmwPQbn4VS7R7n/HKGZRuzo0jjhn9P9r7qKYu5TDVEEHc5l6lwXLnz4J7XGg+vXDl
         PiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724641322; x=1725246122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqMidpjTyEAXSrDATi1bJfGrokKfF0LLoZX42RYAeCY=;
        b=VysL5I++FB6dBZrVDNV8UYRgmK9PLaNt7DMx5ByDET9QcNv/+K7uoMMGT6Ez/HXqct
         CYCdwQp+azlqYC4Ul1KkTvGnPSf9twAVvp4ZoxUivDF3NiLeyEcJehIsQEGIeMhf1XRe
         QfHUqu/sf6UIWFeFPg8yRZQCyOh+/cujNLDRrHDvvyNDoKBzvEr1GU8ULSwARZo47Zsd
         Fy9+quQCY1ihzT2xmsIzUWED48BCETsxxvGkKW6Wpy6U6SeDArDfMUdi2VbceDoFbsAL
         ZRhCZQBoIjlNC+iIvVS4UHb6v165ef9jG+6UHW1cW6dLqLj0UrEExqU8rVmJSpJsEwy/
         PkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxt6V1AJQRz0A3WV4zSriJk5BO2bcPlhxpEbEZ1qUn+khmO7FnI+DMfP/h8lMQyibgUHYzfLtnYfPPT5+V@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5TM0JwMn7Z1ezZcdOMHXK+VeLLyxHFkS8FFhxpKEVvaoiVfN
	zQNsf0H5m+UZz+OM7ayACDHWDBTWbR0xOwZ7pIUrPxAibwWyZHbifxRMO3FH5TU=
X-Google-Smtp-Source: AGHT+IFSrd3sCaL6bPpSE2TcGHIxBmpHgqAk+jJoG4ozmh//3gCUtZ8Hmdck95n6sAftDhh2tcOgGA==
X-Received: by 2002:a05:6870:9708:b0:26f:ddfa:3564 with SMTP id 586e51a60fabf-273e63d6d03mr11605808fac.6.1724641322133;
        Sun, 25 Aug 2024 20:02:02 -0700 (PDT)
Received: from [10.4.59.158] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm5337433a12.26.2024.08.25.20.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 20:02:01 -0700 (PDT)
Message-ID: <122be87e-132f-4944-88d9-3d13fd1050ad@bytedance.com>
Date: Mon, 26 Aug 2024 11:01:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] mm: shrinker: Add a .to_text() method for shrinkers
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: david@fromorbit.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-3-kent.overstreet@linux.dev>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240824191020.3170516-3-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/25 03:10, Kent Overstreet wrote:
> This adds a new callback method to shrinkers which they can use to
> describe anything relevant to memory reclaim about their internal state,
> for example object dirtyness.
> 
> This patch also adds shrinkers_to_text(), which reports on the top 10
> shrinkers - by object count - in sorted order, to be used in OOM
> reporting.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>   include/linux/shrinker.h |  7 +++-
>   mm/shrinker.c            | 73 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 1a00be90d93a..6193612617a1 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -24,6 +24,8 @@ struct shrinker_info {
>   	struct shrinker_info_unit *unit[];
>   };
>   
> +struct seq_buf;
> +
>   /*
>    * This struct is used to pass information from page reclaim to the shrinkers.
>    * We consolidate the values for easier extension later.
> @@ -80,10 +82,12 @@ struct shrink_control {
>    * @flags determine the shrinker abilities, like numa awareness
>    */
>   struct shrinker {
> +	const char *name;
>   	unsigned long (*count_objects)(struct shrinker *,
>   				       struct shrink_control *sc);
>   	unsigned long (*scan_objects)(struct shrinker *,
>   				      struct shrink_control *sc);
> +	void (*to_text)(struct seq_buf *, struct shrinker *);
>   
>   	long batch;	/* reclaim batch size, 0 = default */
>   	int seeks;	/* seeks to recreate an obj */
> @@ -110,7 +114,6 @@ struct shrinker {
>   #endif
>   #ifdef CONFIG_SHRINKER_DEBUG
>   	int debugfs_id;
> -	const char *name;
>   	struct dentry *debugfs_entry;
>   #endif
>   	/* objs pending delete, per node */
> @@ -135,6 +138,8 @@ __printf(2, 3)
>   struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
>   void shrinker_register(struct shrinker *shrinker);
>   void shrinker_free(struct shrinker *shrinker);
> +void shrinker_to_text(struct seq_buf *, struct shrinker *);
> +void shrinkers_to_text(struct seq_buf *);
>   
>   static inline bool shrinker_try_get(struct shrinker *shrinker)
>   {
> diff --git a/mm/shrinker.c b/mm/shrinker.c
> index dc5d2a6fcfc4..ad52c269bb48 100644
> --- a/mm/shrinker.c
> +++ b/mm/shrinker.c
> @@ -1,8 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/memcontrol.h>
> +#include <linux/rculist.h>
>   #include <linux/rwsem.h>
> +#include <linux/seq_buf.h>
>   #include <linux/shrinker.h>
> -#include <linux/rculist.h>
>   #include <trace/events/vmscan.h>
>   
>   #include "internal.h"
> @@ -807,3 +808,73 @@ void shrinker_free(struct shrinker *shrinker)
>   	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
>   }
>   EXPORT_SYMBOL_GPL(shrinker_free);
> +
> +void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
> +{
> +	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> +
> +	seq_buf_puts(out, shrinker->name);
> +	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
> +
> +	if (shrinker->to_text) {
> +		shrinker->to_text(out, shrinker);
> +		seq_buf_puts(out, "\n");
> +	}
> +}
> +
> +/**
> + * shrinkers_to_text - Report on shrinkers with highest usage
> + *
> + * This reports on the top 10 shrinkers, by object counts, in sorted order:
> + * intended to be used for OOM reporting.
> + */
> +void shrinkers_to_text(struct seq_buf *out)
> +{
> +	struct shrinker *shrinker;
> +	struct shrinker_by_mem {
> +		struct shrinker	*shrinker;
> +		unsigned long	mem;
> +	} shrinkers_by_mem[10];
> +	int i, nr = 0;
> +
> +	if (!mutex_trylock(&shrinker_mutex)) {
> +		seq_buf_puts(out, "(couldn't take shrinker lock)");
> +		return;
> +	}

I remember I pointed out that the RCU + refcount method should be used
here. Otherwise you will block other shrinkers from 
registering/unregistering, etc.

> +
> +	list_for_each_entry(shrinker, &shrinker_list, list) {
> +		struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
> +		unsigned long mem = shrinker->count_objects(shrinker, &sc);
> +
> +		if (!mem || mem == SHRINK_STOP || mem == SHRINK_EMPTY)
> +			continue;
> +
> +		for (i = 0; i < nr; i++)
> +			if (mem < shrinkers_by_mem[i].mem)
> +				break;
> +
> +		if (nr < ARRAY_SIZE(shrinkers_by_mem)) {
> +			memmove(&shrinkers_by_mem[i + 1],
> +				&shrinkers_by_mem[i],
> +				sizeof(shrinkers_by_mem[0]) * (nr - i));
> +			nr++;
> +		} else if (i) {
> +			i--;
> +			memmove(&shrinkers_by_mem[0],
> +				&shrinkers_by_mem[1],
> +				sizeof(shrinkers_by_mem[0]) * i);
> +		} else {
> +			continue;
> +		}
> +
> +		shrinkers_by_mem[i] = (struct shrinker_by_mem) {
> +			.shrinker = shrinker,
> +			.mem = mem,
> +		};
> +	}
> +
> +	for (i = nr - 1; i >= 0; --i)
> +		shrinker_to_text(out, shrinkers_by_mem[i].shrinker);
> +
> +	mutex_unlock(&shrinker_mutex);
> +}

