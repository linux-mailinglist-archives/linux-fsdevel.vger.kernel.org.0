Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12409D10B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 15:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfHZNtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 09:49:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfHZNtn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:49:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DF8A307CDEA;
        Mon, 26 Aug 2019 13:49:43 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B918608AB;
        Mon, 26 Aug 2019 13:49:39 +0000 (UTC)
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
From:   Waiman Long <longman@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190826132529.GC15933@bombadil.infradead.org>
 <60464cac-6319-c3c1-47b8-d9b5cf586754@redhat.com>
Organization: Red Hat
Message-ID: <18a20b0f-7ceb-94db-b885-e63db45ebaa9@redhat.com>
Date:   Mon, 26 Aug 2019 09:49:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <60464cac-6319-c3c1-47b8-d9b5cf586754@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 26 Aug 2019 13:49:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/26/19 9:43 AM, Waiman Long wrote:
> On 8/26/19 9:25 AM, Matthew Wilcox wrote:
>>
>> Would this not work equally well?
>>
>> +++ b/fs/proc/page.c
>> @@ -46,7 +46,8 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>                         ppage = pfn_to_page(pfn);
>>                 else
>>                         ppage = NULL;
>> -               if (!ppage || PageSlab(ppage) || page_has_type(ppage))
>> +               if (!ppage || PageSlab(ppage) || page_has_type(ppage) ||
>> +                               PagePoisoned(ppage))
>>                         pcount = 0;
>>                 else
>>                         pcount = page_mapcount(ppage);
>>
> That is my initial thought too. However, I couldn't find out where the
> memory of the uninitialized page structures may have been initialized
> somehow. The only thing I found is when vm_debug is on that the page
> structures are indeed poisoned. Without that it is probably just
> whatever the content that the memory have when booting up the kernel.
>
> It just happens on the test system that I used the memory of those page
> structures turned out to be -1. It may be different in other systems
> that can still crash the kernel, but not detected by the PagePoisoned()
> check. That is why I settle on the current scheme which is more general
> and don't rely on the memory get initialized in a certain way.

Actually, I have also thought about always poisoning the page
structures. However, that will introduce additional delay in the boot up
process which can be problematic especially if the system has large
amount of persistent memory.

Cheers,
Longman

