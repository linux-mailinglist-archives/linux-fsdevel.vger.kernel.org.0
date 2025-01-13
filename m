Return-Path: <linux-fsdevel+bounces-39012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB9A0B295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 10:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE7F166745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69C23979F;
	Mon, 13 Jan 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX4RE89H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571EF231CA3
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736759943; cv=none; b=Vhm5tDy6OU3Gl47UOUNfiZDxqd/9r+jRjabpJW72W2JhkdPWWuT0IO1Zs9cEmpqUfu9Seg/OucTYhy+HCeEtS3IB5kIgi7chEaCpSTWyYFa1qlyaQM5qqJaPFo5nf60p6mKiSSPkA3fU9qsw5S/HVQhRxNAjUoEj/QSNyFolO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736759943; c=relaxed/simple;
	bh=ZbFGYSXOielP5U29i4lsY0yDYt++MFpCtap+dHahnBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTlYPe+/x3zJY7r0Gn3lZcfQZdK+Jt9WbCupvBf/Eu8kAx6GPqbbJx48zk1mi/rmhnDQYXMGy+he9CSfKgjqF4NGH64JQ/s4Qb/87gwxiE7jkGxqTjWpgQAGJIBYdKQI+SZGmm8hW3dSEx+SzwdzTeGOHcSYh3uCbwYOIUiI+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX4RE89H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736759940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fc+76eVhlZVs6X5hrndv9r3LJZZJwfP5vG4uDLn3SMI=;
	b=aX4RE89HAo2IOF1/BYgNaf0gjJN3vLNWWOccVPMb6hamOpFxyluPGYGlfoJcCa1qP56wn3
	u8lTHg2A0vGeoGbGHg4y5V3i13a7C1xxDhyR5ayZ+lxmkB0N2ynrh5lZlbgP0a1r7uuo7i
	aB2yVMOh7sSUiomAfs6d8qY/hfW401E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-AxQtMH5GNiWMjGYBD4yBfQ-1; Mon, 13 Jan 2025 04:18:58 -0500
X-MC-Unique: AxQtMH5GNiWMjGYBD4yBfQ-1
X-Mimecast-MFC-AGG-ID: AxQtMH5GNiWMjGYBD4yBfQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so32521645e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 01:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736759937; x=1737364737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc+76eVhlZVs6X5hrndv9r3LJZZJwfP5vG4uDLn3SMI=;
        b=uBculPojnP/X99Dfwsx1baNEjKTpMFefw1nPxBPGjGKPJGJlb5/HaRsHBUJCiJohEm
         +D69HJTnUxKqn7I6BLLCXyceYtT7/DEA+TVtlzqMKcnpecNTkaRlJDeu6GzJfoz4dTYq
         1Lrv29XZiEJsuEfeU975cO7LpJUfJsUJyWsdSfV9+GQP+WetN87PY4IBjalfUYv13hcq
         Tq+udOMRljMtiobWtqXsxbQWZqVUf+Xms+Mz/GyNaWgpMH27mkLXDr2s16HWPD33GbJ7
         +Vik2k8jSxOqYFCti5JUuxdRVIz5we7hvm7YjER++ZBW5DHiM+X7l/cIRh3QCQpIpVXn
         LZqA==
X-Forwarded-Encrypted: i=1; AJvYcCVZYVwtZ0uJUuKTGNl4SbRR5y445YsZ9vH7XzOuARGqfPv6IN9/L/8aGeAr+kFJVbHGRLTmuFWlUGkMK18O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07CoKB762Drmf454RvajPMwl98C93kALWpbqJNIEAyCETOT2M
	uBBJsnEdSGgsF02ygaZibk4bc9icWeplT6IIjDOYmNyvPg9sogil4UJnM0rljz52UE20sBf31kr
	vdDRQjsUipLhUBljK72YNRA17fuuZvUY7Amjfkf3hYI7UqjiXTO2eWIcByHHxmWg=
X-Gm-Gg: ASbGnct0/noIZJgTR3LDeA5Ia4Ij1S6MhsM/ODZkMdESONteMLUkemVajtJKjfa/l/L
	0nY684K1b6PC+k6FO3gunq3YmNCb4Qfqq37sLxFmhP0xi+WLB2/tFSr75DBGs7fxrhiD44sMhVW
	hPM0EdytkpPkyyuhZfAJJBbMBPD6brz/9NNAF/lNO/6j85f3vUwppHkB/bLfgVQtrw5FQZRVD2U
	W4vWI3KE9IhhVCnVfg63+60KnGjB3gbCh3m/UpHGOqFrOdK1efulWHrqsB6Q9GYFYujxrgqHfNN
	+andG8P2NCBT3F4=
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr131885505e9.12.1736759937382;
        Mon, 13 Jan 2025 01:18:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/gTdzX+My6tvsHge7eZul4d9Dj8kSsnC1Ylj6xW53Ok3ZuhPv0rp1VWvfdJeV5u4Y7B9Kgg==
X-Received: by 2002:a05:600c:5ca:b0:436:ed38:5c7f with SMTP id 5b1f17b1804b1-436ed385da5mr131885305e9.12.1736759936974;
        Mon, 13 Jan 2025 01:18:56 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm170852335e9.9.2025.01.13.01.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 01:18:55 -0800 (PST)
Message-ID: <ba714a36-dc46-49dc-af6d-aeced26295e1@redhat.com>
Date: Mon, 13 Jan 2025 10:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ksm: add ksm involvement information for each process
To: xu.xin16@zte.com.cn, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, wang.yaxin@zte.com.cn, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, yang.yang29@zte.com.cn
References: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110174034304QOb8eDoqtFkp3_t8mqnqc@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 10:40, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> In /proc/<pid>/ksm_stat, Add two extra ksm involvement items including
> KSM_mergeable and KSM_merge_any. It helps administrators to
> better know the system's KSM behavior at process level.
> 
> ksm_merge_any: yes/no
> 	whether the process'mm is added by prctl() into the candidate list
> 	of KSM or not, and fully enabled at process level.
> 
> ksm_mergeable: yes/no
>      whether any VMAs of the process'mm are currently applicable to KSM.
> 
> Purpose
> =======
> These two items are just to improve the observability of KSM at process
> level, so that users can know if a certain process has enable KSM.

s/enable/enabled/

> 
> For example, if without these two items, when we look at
> /proc/<pid>/ksm_stat and there's no merging pages found, We are not sure
> whether it is because KSM was not enabled or because KSM did not
> successfully merge any pages.
> 
> Althrough "mg" in /proc/<pid>/smaps indicate VM_MERGEABLE, it's opaque

s/Althrough/Although/

> and not very obvious for non professionals.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
> ---
> Changelog v4 -> v5:
> 1. Update the documentation.
> 2. Correct a comment sentence and add purpose statment in commit message.
> ---
>   Documentation/filesystems/proc.rst | 66 ++++++++++++++++++++++++++++++++++++++
>   fs/proc/base.c                     | 11 +++++++
>   include/linux/ksm.h                |  1 +
>   mm/ksm.c                           | 19 +++++++++++
>   4 files changed, 97 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 6a882c57a7e7..916f83203de0 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -48,6 +48,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>     3.11	/proc/<pid>/patch_state - Livepatch patch operation state
>     3.12	/proc/<pid>/arch_status - Task architecture specific information
>     3.13  /proc/<pid>/fd - List of symlinks to open files
> +  3.14  /proc/<pid/ksm_stat - Information about the process' ksm status.
> 
>     4	Configuring procfs
>     4.1	Mount options
> @@ -2232,6 +2233,71 @@ The number of open files for the process is stored in 'size' member
>   of stat() output for /proc/<pid>/fd for fast access.
>   -------------------------------------------------------
> 
> +3.14 /proc/<pid/ksm_stat - Information about the process' ksm status
> +--------------------------------------------------------------------
> +When CONFIG_KSM is enabled, each process has this file which displays
> +the information of ksm merging status.
> +
> +Example
> +~~~~~~~
> +
> +::
> +
> +    / # cat /proc/self/ksm_stat
> +    ksm_rmap_items 0
> +    ksm_zero_pages 0
> +    ksm_merging_pages 0
> +    ksm_process_profit 0
> +    ksm_merge_any: no
> +    ksm_mergeable: no
> +
> +Description
> +~~~~~~~~~~~
> +
> +ksm_rmap_items
> +^^^^^^^^^^^^^^
> +
> +The number of ksm_rmap_item structure in use. The structure of

structures

> +ksm_rmap_item is to store the reverse mapping information for virtual

is to store -> stores?

> +addresses. KSM will generate a ksm_rmap_item for each ksm-scanned page
> +of the process.

Is it really each

> +
> +ksm_zero_pages
> +^^^^^^^^^^^^^^
> +
> +When /sys/kernel/mm/ksm/use_zero_pages is enabled, it represent how many
> +empty pages are merged with kernel zero pages by KSM.
> +
> +ksm_merging_pages
> +^^^^^^^^^^^^^^^^^
> +
> +It represents how many pages of this process are involved in KSM merging
> +(not including ksm_zero_pages). It is the same with what
> +/proc/<pid>/ksm_merging_pages shows.
 > +> +ksm_process_profit
> +^^^^^^^^^^^^^^^^^^
> +
> +The profit that KSM brings (Saved bytes). KSM can save memory by merging
> +identical pages, but also can consume additional memory, because it needs
> +to generate a number of rmap_items to save each scanned page's brief rmap
> +information. Some of these pages may be merged, but some may not be abled
> +to be merged after being checked several times, which are unprofitable
> +memory consumed.
> +
> +ksm_merge_any
> +^^^^^^^^^^^^^
> +
> +It specifies whether the process'mm is added by prctl() into the candidate list

Shows whether ... ?

> +of KSM or not, and KSM scanning is fully enabled at process level.
> +
> +ksm_mergeable
> +^^^^^^^^^^^^^
> +
> +It specifies whether any VMAs of the process'mm are currently applicable to KSM.

Shows whether ... ?

"any VMA"



Apart from that LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


