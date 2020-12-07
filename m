Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECA2D1042
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgLGMQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbgLGMQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607343292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6fm4taHsrhx0FnfLCsnkIMNxG4dB07e6BZ5aWQtaC+4=;
        b=KUD0lxGkwioON9hwQAQnw0Qo5Hh/vGHHMoXasFsPbH2AnT8wPPyV6A/DTymy1RtJon4UiN
        W4iwEEU4GkNBmNl9AegRrh6AGPTc29uTCNbbzP31py7c96lJS76T5tQ5gV06drLBgebaS+
        L9Aog/4gSaOAGUc50CEZ+4/EYbr4Y08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-8TjYEKcmNzeQSizoH8iGCA-1; Mon, 07 Dec 2020 07:14:49 -0500
X-MC-Unique: 8TjYEKcmNzeQSizoH8iGCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1A2800D62;
        Mon,  7 Dec 2020 12:14:45 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7EBF60BE2;
        Mon,  7 Dec 2020 12:14:35 +0000 (UTC)
Subject: Re: [PATCH v7 02/15] mm/memory_hotplug: Move {get,put}_page_bootmem()
 to bootmem_info.c
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
 <20201130151838.11208-3-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <3840b0eb-bc65-6ad4-9ef9-f6e1603d1473@redhat.com>
Date:   Mon, 7 Dec 2020 13:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130151838.11208-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.11.20 16:18, Muchun Song wrote:
> In the later patch, we will use {get,put}_page_bootmem() to initialize
> the page for vmemmap or free vmemmap page to buddy. So move them out of
> CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code movement without any
> functional change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/x86/mm/init_64.c          |  2 +-
>  include/linux/bootmem_info.h   | 13 +++++++++++++
>  include/linux/memory_hotplug.h |  4 ----
>  mm/bootmem_info.c              | 25 +++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 27 ---------------------------
>  mm/sparse.c                    |  1 +
>  6 files changed, 40 insertions(+), 32 deletions(-)
> 

I'd squash this into the previous patch and name it like

"mm/memory_hotplug: Factor out bootmem core functions to bootmem_info.c"


-- 
Thanks,

David / dhildenb

