Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBF22BA5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgKTJQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727707AbgKTJQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605863816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITZXc1TXvVFkkNpcVLTYs8BZNWT7SU+qlHrGasDetMo=;
        b=OK68O1v94Z0x+4hiG6TKq4tHsivtd7GNNDtskageJTFYZBYZct2Tdks+PbHBhnNnkMaTiI
        ny89x1F0lYD492Ta28Ki4kKMrHGXi25gQxywdywdKlM+xmxS/oAKeTQuuc2P0WWo3kf1Q7
        TckIFf0++gAHbZaO65G2ylf30f5jAYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-y8ps-3dMPUGoeQojge184g-1; Fri, 20 Nov 2020 04:16:54 -0500
X-MC-Unique: y8ps-3dMPUGoeQojge184g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0CD1DDF2;
        Fri, 20 Nov 2020 09:16:49 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A02919725;
        Fri, 20 Nov 2020 09:16:44 +0000 (UTC)
Subject: Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-22-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dc77d433-b5f0-0f4a-a4e9-f888b079618a@redhat.com>
Date:   Fri, 20 Nov 2020 10:16:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201120064325.34492-22-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.20 07:43, Muchun Song wrote:
> We only can free the unused vmemmap to the buddy system when the
> size of struct page is a power of two.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/hugetlb_vmemmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c3b3fc041903..7bb749a3eea2 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -671,7 +671,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>   	unsigned int order = huge_page_order(h);
>   	unsigned int vmemmap_pages;
>   
> -	if (hugetlb_free_vmemmap_disabled) {
> +	if (hugetlb_free_vmemmap_disabled ||
> +	    !is_power_of_2(sizeof(struct page))) {
>   		pr_info("disable free vmemmap pages for %s\n", h->name);
>   		return;
>   	}
> 

This patch should be merged into the original patch that introduced 
vmemmap freeing.

-- 
Thanks,

David / dhildenb

