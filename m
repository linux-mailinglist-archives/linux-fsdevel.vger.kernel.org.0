Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9934C2BA5B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKTJPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgKTJPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605863743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwuP1reil3EHDjEAdkxJz3A0u+9v93EU1GsEwtmmEUI=;
        b=V1v8aBFAJmQcGmJWbXs3RudZ87M098c7DNpvrDHqEPigw957Rj7ZibtkHEEYNO1k+ok8K6
        hzoXsKUTL6ash/CKmmzJPmPqNDHFNUNfDw7AL6o47WOl13TZm8JOzH1SMzGfZ/j1jRGidt
        ytbckQb8WyNr20zQTPO0DzCv3cF1qxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-XqBTzF7ZPumVNm0YPi5lsg-1; Fri, 20 Nov 2020 04:15:41 -0500
X-MC-Unique: XqBTzF7ZPumVNm0YPi5lsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69A038797DA;
        Fri, 20 Nov 2020 09:15:37 +0000 (UTC)
Received: from [10.36.114.78] (ovpn-114-78.ams2.redhat.com [10.36.114.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 589225D6AD;
        Fri, 20 Nov 2020 09:15:31 +0000 (UTC)
Subject: Re: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct
 page size is not power of two
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
 <20201120064325.34492-22-songmuchun@bytedance.com>
 <20201120082552.GI3200@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9b26c749-3bb6-4b16-d1fc-da7ec5d1e8a5@redhat.com>
Date:   Fri, 20 Nov 2020 10:15:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201120082552.GI3200@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.11.20 09:25, Michal Hocko wrote:
> On Fri 20-11-20 14:43:25, Muchun Song wrote:
>> We only can free the unused vmemmap to the buddy system when the
>> size of struct page is a power of two.
> 
> Can we actually have !power_of_2 struct pages?

AFAIK multiples of 8 bytes (56, 64, 72) are possible.


-- 
Thanks,

David / dhildenb

