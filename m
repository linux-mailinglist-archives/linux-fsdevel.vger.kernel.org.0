Return-Path: <linux-fsdevel+bounces-51201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE14AD45D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC0C3A6B52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A928BA8A;
	Tue, 10 Jun 2025 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6RVJ23g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750B289E3A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594170; cv=none; b=k9w21TBXdDFmpqlzWxvHZ2ru2OxlIZxLRom2ChnudvPytQHFUlZE9UwVJil9/0VOpMHIe16PHwFJ7kIlPgtj2LSc6K3z/Bv3RtuYQmSc0m5sTpdxrYX9k8mLZxmzD5ovkPlFlNkjg+dlq3cbCIWOGdPjy1o9jqRpovTu8pbcrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594170; c=relaxed/simple;
	bh=XjgsdEhFvFB0B+RbA+5aNhRmFbtruOCW5OEOXUP/KY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVBE6aYiZpDPqQdZVO1WXhUTSNMeRLO9cRTqHWis9Xs6ik/lgO6VR4ErfHP2bJmSKXWVvQ4fFk50rw7CwZKTvyn2AiLrSnYPtASbTLp/r4zTpHW3Bocfk1hc9qbGZ4PzjmHrSoDypTuX3ce6tSrpwNlptVjdSS3TZ7Ill3GioiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6RVJ23g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749594167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hLuQnm8GtR1mcurBIw5pIZijzYYYehwuFe+H/mrbon4=;
	b=E6RVJ23gIL8PxFKzspRBcfOhnGQIb5012IJynfz4aqBGS3WPnAi95z346c0vB/uTSs6YNh
	b6JwKIvzemqqG+q50ExrfoEyYft3DCTtI1AUTMPWKCCbBceY939xUGkDGtpc4uz40Jxh0N
	YgJX4mvzuX15zyrrOoVCD08wzQDRJb8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-rYuZe-FoOyCAIdJSf4KzYw-1; Tue, 10 Jun 2025 18:22:43 -0400
X-MC-Unique: rYuZe-FoOyCAIdJSf4KzYw-1
X-Mimecast-MFC-AGG-ID: rYuZe-FoOyCAIdJSf4KzYw_1749594163
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-404ee80e492so5680788b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594161; x=1750198961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLuQnm8GtR1mcurBIw5pIZijzYYYehwuFe+H/mrbon4=;
        b=BAFB8SrLsBs+rE6ld7M/12VqsC2fAN/BN6oxpJc1YFzX6uTrG074AQdBQbyABQ4SYQ
         kgszWKVv39xJlxOTh9E79ejDu5bPDBhde6DSe/YbCi42917CyHtSmZWs2keHqgF9q+DV
         x8fxYR/adwxoeHxXE1yy2D3sZajydsuSD26GZf+EIwk8DoP6br9ngkbJmK4QclXQ51Vc
         ByDiciF/tdqeoG0O/BIONH3cIY8Ze0bw9jleFEDogrUdwt3iyBdd58+O6IrQfdTbu+LK
         P67FhomWAt6aVa0UMUuS/VPxW/KiZOCtDtjpUm1yZC+Kb+g9fPmszCib7a/7pENKicn1
         COCw==
X-Forwarded-Encrypted: i=1; AJvYcCWl6XROdV3HlUpKGcDs2mnR5KB1XlWILe/Y6zUktVw9b6DTCaoX+io/ya71J8UnYU1AxWeishoyvJkPoowB@vger.kernel.org
X-Gm-Message-State: AOJu0YzQznTPUgQa9Kd4ykhjrSv8+rhIwUAz88rH99UMLqlSw6gNAON/
	GGlk2Xx4un785LLNk+oVFx96D+WikrdAXGkffibWdLFdilctjn0hyk3sJNBPfOlB1nAFK7vDp5s
	U4KYRfoCCWW+Hn63EsoogaRy38raBdZ0p+Xpj74qyLIj5g62Cq40uqpFZRRidJqXOdlUIrsnBaM
	4=
X-Gm-Gg: ASbGncs4WYMtVyAbdLwX6uk6vFPA78gMNRjjiQl87jFcgs7bCw/71IKR9pLHYDnMZjz
	DhW8ZGK3a+ZKs76tNcDgBN3Sr7IwktuO4h2mby6lHsAxG3n8P/iTdYW2yJzoRhA6r1u+yNI3wol
	fp7zAY46KsZY/cotdH2rS+PM1wnhIowxOU4GYYnGi2P8UqFgXhFY60aQNnMSsGyUquihcqM61Xn
	y78F6l8sn8HzaofnG3tFyWEtKHqWy6zccBnz7Zfowc3oOU1jcNpNyJpF5cLX1hMcMhnKwueL0Zv
	jgU86cwp08Ih9g==
X-Received: by 2002:a05:6808:250f:b0:406:72ad:bb6b with SMTP id 5614622812f47-40a5d24f1afmr899765b6e.37.1749594161617;
        Tue, 10 Jun 2025 15:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZPFHzLV7Sg4ZkCQBoFbsxw1VThpMG4z5lPpBVju0VP9CmUB6NZzQ74WH9fhjymqKd3HA8wA==
X-Received: by 2002:a05:622a:a18:b0:494:b924:1374 with SMTP id d75a77b69052e-4a713c4544cmr20646161cf.43.1749594147540;
        Tue, 10 Jun 2025 15:22:27 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a611150cb0sm78624171cf.11.2025.06.10.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:22:26 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:22:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
Message-ID: <aEiwHjl4tsUt98sh@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-2-kalyazin@amazon.com>

On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
> non-huge pages by calling vm_ops->fault().  A new VMF flag,
> FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
> handle_userfault().

It's not clear yet on why this is needed to be generalized out of the blue.

Some mentioning of guest_memfd use case might help for other reviewers, or
some mention of the need to introduce userfaultfd support in kernel
modules.

> 
> Suggested-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  include/linux/mm_types.h |  4 ++++
>  mm/hugetlb.c             |  2 +-
>  mm/shmem.c               |  9 ++++++---
>  mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
>  4 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 0234f14f2aa6..2f26ee9742bf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
>   * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>   *                        We should only access orig_pte if this flag set.
>   * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
> + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
> + *                                 minor handler as it is being called by the
> + *                                 userfaultfd code itself.

We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
as it's not easy to follow when without userfault minor context.  It might
be better to use generic terms like NO_USERFAULT.

Said that, I wonder if we'll need to add a vm_ops anyway in the latter
patch, whether we can also avoid reusing fault() but instead resolve the
page faults using the vm_ops hook too.  That might be helpful because then
we can avoid this new FAULT_FLAG_* that is totally not useful to
non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
struct below just to suite the current fault() interfacing.

Thanks,

-- 
Peter Xu


