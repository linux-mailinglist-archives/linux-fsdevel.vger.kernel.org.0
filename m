Return-Path: <linux-fsdevel+bounces-6318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EF815B2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 20:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1281F23F65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460DD315A7;
	Sat, 16 Dec 2023 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2M+hT1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A31E485;
	Sat, 16 Dec 2023 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NAkZ4YVkVgbfEFAtxtWO+XdMnB8Uq7QYjRzK5VJkzRY=; b=p2M+hT1naSydHdOegm76pwjkV3
	cIoiy33aWBHqNWgekFcNMxeVpqOo0ipJcSnjzDYNxvQeBK3AMRxwSfrBLOsm/R8TNSD1ySixBWHpX
	S+Ykl9xCIiVW8Zh6c/+9FvVGTA3NVEZtk0FnzO/WQHp7DvhCmFuJJDrBVKGFWJoja8rdpOiVeYRpJ
	Ml9F4t5E9FSll5nZH2EXwbPRlE3YEpuQGqB93TCwKZEH9AjMDrfp8wjBdH//b5SsmOVIV3/8b8/ER
	CGdMWRfltmjSt5OWCPDU4T3jx8sRcVRnrgRz7DgL+Kp7OO8bWasI/XyspfauvSbLfyED/+p7RghDl
	znlF08sw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEZyH-006aik-1J;
	Sat, 16 Dec 2023 19:05:11 +0000
Message-ID: <5a5daf77-ba00-49db-a963-e343a0b2b8cf@infradead.org>
Date: Sat, 16 Dec 2023 11:05:08 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/50] rslib: kill bogus dependency on list.h
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: tglx@linutronix.de, x86@kernel.org, tj@kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, keescook@chromium.org,
 dave.hansen@linux.intel.com, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, brauner@kernel.org
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-5-kent.overstreet@linux.dev>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231216032957.3553313-5-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 19:29, Kent Overstreet wrote:
> list_head is defined in types.h, not list.h - this kills a sched.h
> dependency.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/rslib.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/rslib.h b/include/linux/rslib.h
> index 238bb85243d3..a04dacbdc8ae 100644
> --- a/include/linux/rslib.h
> +++ b/include/linux/rslib.h
> @@ -10,7 +10,6 @@
>  #ifndef _RSLIB_H_
>  #define _RSLIB_H_
>  
> -#include <linux/list.h>
>  #include <linux/types.h>	/* for gfp_t */
>  #include <linux/gfp.h>		/* for GFP_KERNEL */
>  

What about line 47?

    47		struct list_head list;

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

