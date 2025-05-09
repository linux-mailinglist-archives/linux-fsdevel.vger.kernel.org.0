Return-Path: <linux-fsdevel+bounces-48629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC9AB1939
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE087BD1B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99227230BE0;
	Fri,  9 May 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7ODV1q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C3230BFC
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805778; cv=none; b=ADRFZdaakerIEzk8OG9ktneyNyMcMjCTZBNurmvajp+qRqi4hXb5xwyJDmxVKXvn5gJ28uR+3vWWYzT5plAc1vsMHAl40XXwtMNqbaMwcDkKQn6kkm2V7Fsn4J4DjjM1Ev34DN6R2aXlRSOHaMYKP76RUYRyp/EmcuqfBlYijV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805778; c=relaxed/simple;
	bh=iWnuHZ1c6WWRfLUTfyVlkUtx3F8YoEu/5kxSnDTmjaw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FYEvNnk+IJxIJwauTvJLWC/25VMJfZUs7ZVJOWA3n3y7HqABsd/ay2UpvaYdbP+4GEAWZd1ou0Ce0lW3or98YC/nxm5DVd44v4129SDMxlqHIXTdN4gJYGiRwBSmQ3dgI2Co17rpSa0P0HDYNviGR9iA1fWY2ZUlImJYz0a8Y3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7ODV1q6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746805774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTgQu7bXXJwDyG63O7O6nk0DUKrmaXIkhDqMVuS1nM8=;
	b=I7ODV1q6PX1cLJD/nFyuIuUAB1EqyPriYOiEdQeLkTpxdpl52fZJH25hclmMaHPAO+ubTi
	NG5+4K9P8mJ19n5+27hG9VAfJi7CG7O7bycO7ZFXeUvFTrRz6WyWWWYEkPer1jQzKHEvHV
	zkRHlF6zvTRqNEn1xt/lHSr3P0P/P5A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-SEQ__q_FMYGzuAgmHbXrSQ-1; Fri, 09 May 2025 11:49:33 -0400
X-MC-Unique: SEQ__q_FMYGzuAgmHbXrSQ-1
X-Mimecast-MFC-AGG-ID: SEQ__q_FMYGzuAgmHbXrSQ_1746805772
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5e28d0cc0so371473685a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 08:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805772; x=1747410572;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTgQu7bXXJwDyG63O7O6nk0DUKrmaXIkhDqMVuS1nM8=;
        b=bG8tuki5Zq6Sj0sapLd/ZpbjUTJxLgGOF/YVSpZE8UWidNV4vTNz2qbLrAW4v8HZDM
         vKL+hg4khG4Z3C9R4If8ZEB9u18tt9gs2WsSHf1JyghdeW3aut493ntf8ICXTrBgKseN
         AuPQ/fDp5hosi2n2YVh7+JT5AnC++n9OiV1wS6v+3QZf7pCe9XdFFOKMWarRI8zXm26i
         L1Dk1U59p9sBSh6U2HbtR205D8h3eWi3axgfTGc9y+QnHpGzJZ4NQlV5lHXj+/OoBHAo
         R9EwraOagRVKEOnYUpsAK3rThT5RfhGtK538S/kc4A0lE8qnjafsPz0jLqP9aVYiBcbi
         W6zA==
X-Forwarded-Encrypted: i=1; AJvYcCVLOcZx9MsrI0UaSrF8WFuX3S0casU0VS4dRkCXEWu59uwtfPc4TXL1AbJ67GTOTqrcQ7I8ToGedcYrGT4d@vger.kernel.org
X-Gm-Message-State: AOJu0YzpMEmdQps4J0Lm/eil0sP0oZ/m1Dppio1q9/aMOK9Ts+HBEq9L
	STOyjwDXoTTbAnWKBbeU5XQLMQh6EqPKn39EUwp0O7J6RrbwDApzWLz3wrnZwmukQFOfCw2IvJk
	iYIWKvjRP42FNkK3SN2YBzKJFtlhot8QwgVGzDtBknw/T6ccIW7jcBZ/lWrfQXdc=
X-Gm-Gg: ASbGnctH1OmXvKtM5V2T0mCVJWnEy5EvWWUQOxtBSfmhi/DFlTV0cypKcaSw14fH+wS
	KpK3tyUYpAKD4XPBNhHx/zEGcM8wwRXDmK1Kn1UITb7svgGs5lMZ1vqQoIvb6y2/siA8trw1T0N
	Ir/iXW29cDVcDiyJm03aR5ROX7w/YCXFE0mqMD9d34fllfrd7J1EKCFbkH3uLT6DjHh46C0EMYw
	Jzqo4HL8uLz74tK9wBYJpBzaG6GG5KiI4PobKHJa3hceIxMf3KOP9mMqzVlDiv980mkH/jjVDo/
	j+msWNTbtWR9ywBYzNi6dtrIeVAFbtNBhqDMooRjE+CC3gqmvkwB9CewrQ==
X-Received: by 2002:a05:620a:29c8:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7cd01178f38mr647782585a.56.1746805772430;
        Fri, 09 May 2025 08:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJkQOqWjGp1exWeBQyTD+TGxOr9R3jwYtLHE0ov1mymITAbAKVgPbavKihGj+3kArRZ7+/Mw==
X-Received: by 2002:a05:620a:29c8:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7cd01178f38mr647778385a.56.1746805772038;
        Fri, 09 May 2025 08:49:32 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f9a35dsm153891385a.54.2025.05.09.08.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:49:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9490adcb-de88-4ff9-9548-1fe4c246ea86@redhat.com>
Date: Fri, 9 May 2025 11:49:29 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] locking/rtmutex: Move max_lock_depth into rtmutex.c
To: Joel Granados <joel.granados@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-2-d0ad83f5f4c3@kernel.org>
Content-Language: en-US
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-2-d0ad83f5f4c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/9/25 8:54 AM, Joel Granados wrote:
> Move the max_lock_depth sysctl table element and variable into
> rtmutex.c. Make the variable static as it no longer needs to be
> exported. Removed the rtmutex.h include from sysctl.c.
>
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>   include/linux/rtmutex.h      |  2 --
>   kernel/locking/rtmutex.c     | 23 +++++++++++++++++++++++
>   kernel/locking/rtmutex_api.c |  5 -----
>   kernel/sysctl.c              | 12 ------------
>   4 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
> index 7d049883a08ace049384d70b4c97e3f4fb0e46f8..dc9a51cda97cdb6ac8e12be5209071744101b703 100644
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -18,8 +18,6 @@
>   #include <linux/rbtree_types.h>
>   #include <linux/spinlock_types_raw.h>
>   
> -extern int max_lock_depth; /* for sysctl */
> -
>   struct rt_mutex_base {
>   	raw_spinlock_t		wait_lock;
>   	struct rb_root_cached   waiters;
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index c80902eacd797c669dedcf10966a8cff38524b50..705a0e0fd72ab8da051e4227a5b89cb3d1539524 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -29,6 +29,29 @@
>   #include "rtmutex_common.h"
>   #include "lock_events.h"
>   
> +/*
> + * Max number of times we'll walk the boosting chain:
> + */
> +static int max_lock_depth = 1024;
> +
> +static const struct ctl_table rtmutex_sysctl_table[] = {
> +	{
> +		.procname	= "max_lock_depth",
> +		.data		= &max_lock_depth,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +	},
> +};
> +
> +static int __init init_rtmutex_sysctl(void)
> +{
> +	register_sysctl_init("kernel", rtmutex_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_rtmutex_sysctl);
> +
>   #ifndef WW_RT
>   # define build_ww_mutex()	(false)
>   # define ww_container_of(rtm)	NULL
> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index 191e4720e546627aed0d7ec715673b1b8753b130..2b5da8af206da6ee72df1234a4db94f5c4f6f882 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -8,11 +8,6 @@
>   #define RT_MUTEX_BUILD_MUTEX
>   #include "rtmutex.c"
>   
> -/*
> - * Max number of times we'll walk the boosting chain:
> - */
> -int max_lock_depth = 1024;
> -
>   /*
>    * Debug aware fast / slowpath lock,trylock,unlock
>    *
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 473133d9651eac4ef44b8b63a44b77189818ac08..a22f35013da0d838ef421fc5d192f00d1e70fb0f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -59,9 +59,6 @@
>   #include <asm/nmi.h>
>   #include <asm/io.h>
>   #endif
> -#ifdef CONFIG_RT_MUTEXES
> -#include <linux/rtmutex.h>
> -#endif
>   
>   /* shared constants to be used in various sysctls */
>   const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
> @@ -1709,15 +1706,6 @@ static const struct ctl_table kern_table[] = {
>   		.proc_handler	= proc_dointvec,
>   	},
>   #endif
> -#ifdef CONFIG_RT_MUTEXES
> -	{
> -		.procname	= "max_lock_depth",
> -		.data		= &max_lock_depth,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>   #ifdef CONFIG_TREE_RCU
>   	{
>   		.procname	= "panic_on_rcu_stall",
>
Acked-by: Waiman Long <longman@redhat.com>


