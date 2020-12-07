Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8112D102F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLGMNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726921AbgLGMNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607343142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeGXrgbBAqivlbgR9BOGvDUNYBjdxLs+JyLWyHyfkw8=;
        b=Ox3rVSGz3LeVZFnB309hcYgzuIwIDqFdnu7lrP7G2EIvotzs40qVHDgK/H5RSD1g/G1MMS
        Sr/T05p3eayIPDcRtzIWfo4ibPpcyDsQxsEjeaHNNgGziL7w78NFhnXMezVeYXNPH2eg7J
        AZJ8aO96AyDhFA2ESA1/Kx885nWZ3KA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-ssD7CJweNkmbIGLSt-eXyw-1; Mon, 07 Dec 2020 07:12:19 -0500
X-MC-Unique: ssD7CJweNkmbIGLSt-eXyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1E310054FF;
        Mon,  7 Dec 2020 12:12:16 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2396760BD8;
        Mon,  7 Dec 2020 12:12:08 +0000 (UTC)
Subject: Re: [PATCH v7 01/15] mm/memory_hotplug: Move bootmem info
 registration API to bootmem_info.c
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
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ea9ea78e-ffa2-fc81-616b-31c29e17ff99@redhat.com>
Date:   Mon, 7 Dec 2020 13:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130151838.11208-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.11.20 16:18, Muchun Song wrote:
> Move bootmem info registration common API to individual bootmem_info.c
> for later patch use. This is just code movement without any functional
> change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/x86/mm/init_64.c          |  1 +
>  include/linux/bootmem_info.h   | 27 ++++++++++++
>  include/linux/memory_hotplug.h | 23 ----------
>  mm/Makefile                    |  1 +
>  mm/bootmem_info.c              | 99 ++++++++++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 91 +-------------------------------------
>  6 files changed, 129 insertions(+), 113 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

