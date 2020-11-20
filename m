Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720BC2BA619
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKTJ1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbgKTJ1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605864441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlxOBewGXWN3HOKYRRw+C3ApbHJeGd+c+gin3g9QdWQ=;
        b=gEplfDzJMkN/ktgWKK1aZ7m6N6mOZ03ttF4E2Bu+lHJCZIwHEVR9w3lasZH9T696McohOw
        eovfYZC6St9RppJYxNrTlC6wLO2FEQqbLgGSAS5UZmikVMFsDzRgv7tL3cTGfZWVnhtQsV
        f2QXCa7xs0ZM8TTve7FjaHTdWfnvzeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-hPIF7dlKMGinxX5_bH1DLw-1; Fri, 20 Nov 2020 04:27:16 -0500
X-MC-Unique: hPIF7dlKMGinxX5_bH1DLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A686E85B67D;
        Fri, 20 Nov 2020 09:27:12 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C168210016DB;
        Fri, 20 Nov 2020 09:27:06 +0000 (UTC)
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
To:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120084202.GJ3200@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6b1533f7-69c6-6f19-fc93-c69750caaecc@redhat.com>
Date:   Fri, 20 Nov 2020 10:27:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201120084202.GJ3200@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.20 09:42, Michal Hocko wrote:
> On Fri 20-11-20 14:43:04, Muchun Song wrote:
> [...]
> 
> Thanks for improving the cover letter and providing some numbers. I have
> only glanced through the patchset because I didn't really have more time
> to dive depply into them.
> 
> Overall it looks promissing. To summarize. I would prefer to not have
> the feature enablement controlled by compile time option and the kernel
> command line option should be opt-in. I also do not like that freeing
> the pool can trigger the oom killer or even shut the system down if no
> oom victim is eligible.
> 
> One thing that I didn't really get to think hard about is what is the
> effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
> invalid when racing with the split. How do we enforce that this won't
> blow up?

I have the same concerns - the sections are online the whole time and 
anybody with pfn_to_online_page() can grab them

I think we have similar issues with memory offlining when removing the 
vmemmap, it's just very hard to trigger and we can easily protect by 
grabbing the memhotplug lock. I once discussed with Dan using rcu to 
protect the SECTION_IS_ONLINE bit, to make sure anybody who did a 
pfn_to_online_page() stopped using the page. Of course, such an approach 
is not easy to use in this context where the sections stay online the 
whole time ... we would have to protect vmemmap table entries using rcu 
or similar, which can get quite ugly.

To keep things easy, maybe simply never allow to free these hugetlb 
pages again for now? If they were reserved during boot and the vmemmap 
condensed, then just let them stick around for all eternity.

Once we have a safe approach on how to modify an online vmemmap, we can 
enable this freeing, and eventually also dynamically manage vmemmaps for 
runtime-allocated huge pages.

-- 
Thanks,

David / dhildenb

