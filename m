Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80A747959
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 23:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGDVAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGDVAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FB710CA
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688504397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GI5b35dMc1KdLtRTJt9n7EYcXqIPCpvszX0gw0M88kM=;
        b=LLY88/NXBSCRqep9FEH5vkbWRt2UWzJBrJF4lbVm5hbCWpCSrph3cQzTpc81OMoHx8Xhgj
        /CnyA/ONHEOLJ3Ae/DAhxQl1GwjPceJgr7PXMHW/UmQ7n3osU7YOweofAX9seyPMFU/mkZ
        iiIYNWwgJXw4WkG3PQzNJrv8KDciaZ8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-kPxiiZsBP_C1OelR00W9wg-1; Tue, 04 Jul 2023 16:59:54 -0400
X-MC-Unique: kPxiiZsBP_C1OelR00W9wg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62ffa1214edso11600596d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jul 2023 13:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688504394; x=1691096394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI5b35dMc1KdLtRTJt9n7EYcXqIPCpvszX0gw0M88kM=;
        b=haHvHa4osrPDlB6+jJPklii3fgGEj1XegGfAHGRJ4gC66mTZsWsdz3yo4bdqb75F04
         tvMDVR0bC4r6YVDpuEfd+Awj3BY1l48hkDLj9RmRjcnZQ/CtGzxWB7aYNZH8BfFJJce4
         /IJjzwbH+n0+A+187KBBIn1InjuBKZnCucgHVWmoVFLzRPLYLvD1fGfBPm3VmAog3RlJ
         gQUXBgoWVB9XkK0fXPS28S9ejjE85Kymi1e2aYEKQcsbwP/Xlkl/HAGoXF+LSs7UJN92
         VvftpuWW5+Fosc/2Rz98FMmEmLiG6yTkSIQeoUESLcI5+mvX2MHtpQvtmOdVC4IK8fnE
         LjxA==
X-Gm-Message-State: ABy/qLbdgXm9Fq3jflCmylQQgC8RTJDvvz05GWZ66rbm4flM5c8brNp9
        7FasL3f/54lJig94kIzZ/TPbgFh5Tp47Ma0qYb3AJ3lFCq96pjvbcCWf4Cny9Dg1XiO1bLkV2sf
        DCNmLhilXt6OG3u/LXCwajRTZxA==
X-Received: by 2002:a05:6214:3018:b0:635:e528:521a with SMTP id ke24-20020a056214301800b00635e528521amr6683188qvb.5.1688504393761;
        Tue, 04 Jul 2023 13:59:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVt52JWZzoWFGQHmqymAXvJZN3G9/+QeDJK1PcLD/x3FT2CCtjq5RKSQlTptL8VfnXgNioEg==
X-Received: by 2002:a05:6214:3018:b0:635:e528:521a with SMTP id ke24-20020a056214301800b00635e528521amr6683169qvb.5.1688504393448;
        Tue, 04 Jul 2023 13:59:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id y11-20020ad457cb000000b00631eb444e6esm12777291qvx.51.2023.07.04.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:59:53 -0700 (PDT)
Date:   Tue, 4 Jul 2023 16:59:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mm: userfaultfd: support UFFDIO_POISON for
 hugetlbfs
Message-ID: <ZKSIR4zga2A+fdcv@x1n>
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <20230629205040.665834-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629205040.665834-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 01:50:37PM -0700, Axel Rasmussen wrote:
> The behavior here is the same as it is for anon/shmem. This is done
> separately because hugetlb pte marker handling is a bit different.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  mm/hugetlb.c     | 33 +++++++++++++++++++++++++++++++--
>  mm/userfaultfd.c |  6 +-----
>  2 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 38711d49e4db..05abe88986b6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6090,14 +6090,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	}
>  
>  	entry = huge_ptep_get(ptep);
> -	/* PTE markers should be handled the same way as none pte */
> -	if (huge_pte_none_mostly(entry))
> +	if (huge_pte_none_mostly(entry)) {
> +		if (is_pte_marker(entry)) {
> +			unsigned long marker = pte_marker_get(pte_to_swp_entry(entry));
> +
> +			if (marker & PTE_MARKER_UFFD_POISON) {
> +				ret = VM_FAULT_HWPOISON_LARGE;
> +				goto out_mutex;
> +			}
> +		}
>  		/*
> +		 * Other PTE markers should be handled the same way as none PTE.
> +		 *
>  		 * hugetlb_no_page will drop vma lock and hugetlb fault
>  		 * mutex internally, which make us return immediately.
>  		 */
>  		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
>  				      entry, flags);
> +	}
>  
>  	ret = 0;
>  
> @@ -6253,6 +6263,25 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  	int writable;
>  	bool folio_in_pagecache = false;
>  
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> +		ptl = huge_pte_lock(h, dst_mm, dst_pte);
> +
> +		/* Don't overwrite any existing PTEs (even markers) */
> +		if (!huge_pte_none(huge_ptep_get(dst_pte))) {
> +			spin_unlock(ptl);
> +			return -EEXIST;
> +		}
> +
> +		_dst_pte = make_pte_marker(PTE_MARKER_UFFD_POISON);
> +		set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +
> +		/* No need to invalidate - it was non-present before */
> +		update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +
> +		spin_unlock(ptl);
> +		return 0;
> +	}
> +
>  	if (is_continue) {
>  		ret = -EFAULT;
>  		folio = filemap_lock_folio(mapping, idx);
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 87b62ca1e09e..4436cae1c7a8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -381,12 +381,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
>  	 * by THP.  Since we can not reliably insert a zero page, this
>  	 * feature is not supported.
> -	 *
> -	 * PTE marker handling for hugetlb is a bit special, so for now
> -	 * UFFDIO_POISON is not supported.
>  	 */
> -	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> -	    uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> +	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
>  		mmap_read_unlock(dst_mm);
>  		return -EINVAL;

If we have the last patch declaring the feature bits and so on, IIUC we
don'tt need this change back and forth.  Other than that looks good.

Thanks,

>  	}
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
Peter Xu

