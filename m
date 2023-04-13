Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4186E0C83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDMLcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 07:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDMLcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CA9751
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681385503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HIm5iNvrLIrBpXBxl0Ffwy4XMhjO0OH42kfpLYYOzdU=;
        b=Nq3rbDXZFLmF40Mm+Uy+8tUyzMgRXc0t0UuIa23TYS10epegkc90AuoPsajyyXITKn8SFv
        J2ZiEO/EVtoHqcTOaCk22U6CwkRPKYR7hKe2qcluTWmxqL1UndDJ1TWRBxqyClde8HM7nK
        tePQisBx4H+iUAtpus5nEnazhMp0F1k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Jhr8-YIbNr6NUGWfmLlYOw-1; Thu, 13 Apr 2023 07:31:42 -0400
X-MC-Unique: Jhr8-YIbNr6NUGWfmLlYOw-1
Received: by mail-wr1-f72.google.com with SMTP id d30-20020adfa35e000000b002f53b0a3377so689538wrb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 04:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681385501; x=1683977501;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIm5iNvrLIrBpXBxl0Ffwy4XMhjO0OH42kfpLYYOzdU=;
        b=DHb54d88Cf6DAF3zclS5EK5wzGQBSOXwmZY5bcahJHjAGNcL/hkeEDaLg/UNgE6S07
         eLHTa6hUpOj0oE7KC/XNj11Ye4l55EOfBRn5nvEGcZBN9R0lt0R6kvHBUuMF93XqhPQ7
         4jpaC3nPySa8e5r2OhA2EUFQjE5wjalyu4IRgL8ISW2MIFLS/uhdiSRmBRnlk3xA5xmQ
         wrLxAJ61h0lG3HnPKi3K00M4IguzxlWOv5nkKZjeO0M4JorOHM6owea+yo3u2jCOeJPv
         +P0pCZRO3waJTHicKQ3UDbw6uEolsoH9ky2AZHj5+4LboVMxhvSHJP6VhC2e5fwIQcQ8
         TnHA==
X-Gm-Message-State: AAQBX9dSNPGN52bWY3gMArUi5X6+3uyONYWeThekSCtszc9yvrLp9z+o
        72XqBrvSP/yk+eF3+LnZEhtsrQbKWgp5v11JgY4mVvh2oMcGkiQouUFsngKe7Dd4DYu0af3+JqE
        v7PaHAX1fCgtGr5ow9Y5eIlxhcg==
X-Received: by 2002:a05:600c:298:b0:3f0:7147:2ed7 with SMTP id 24-20020a05600c029800b003f071472ed7mr1687519wmk.16.1681385501424;
        Thu, 13 Apr 2023 04:31:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4H8/rhGt4xGxQ9IGJbZT1v8VC/SsnmagiAuFB3KrJE6ARurMSfQvfmVWRsSDoFSctJZW2Ag==
X-Received: by 2002:a05:600c:298:b0:3f0:7147:2ed7 with SMTP id 24-20020a05600c029800b003f071472ed7mr1687487wmk.16.1681385501058;
        Thu, 13 Apr 2023 04:31:41 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c204d00b003ee0d191539sm1590363wmg.10.2023.04.13.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:31:40 -0700 (PDT)
Message-ID: <57be0df8-e7a8-acda-4422-d4502a8b08b7@redhat.com>
Date:   Thu, 13 Apr 2023 13:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 3/3] mm: vmscan: refactor updating
 current->reclaim_state
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
References: <20230413104034.1086717-1-yosryahmed@google.com>
 <20230413104034.1086717-4-yosryahmed@google.com>
 <b7fe839d-d914-80f7-6b96-f5f3a9d0c9b0@redhat.com>
 <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJD7tkae0uDuRG77nQEtzkV1abGstjF-1jfsCguR3jLNW=Cg5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.04.23 13:29, Yosry Ahmed wrote:
> On Thu, Apr 13, 2023 at 4:21 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 13.04.23 12:40, Yosry Ahmed wrote:
>>> During reclaim, we keep track of pages reclaimed from other means than
>>> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
>>> which we stash a pointer to in current task_struct.
>>>
>>> However, we keep track of more than just reclaimed slab pages through
>>> this. We also use it for clean file pages dropped through pruned inodes,
>>> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
>>
>> Would "reclaimed_non_lru" be more expressive? Then,
>>
>> mm_account_reclaimed_pages() -> mm_account_non_lru_reclaimed_pages()
>>
>>
>> Apart from that LGTM.
> 
> Thanks!
> 
> I suck at naming things. If you think "reclaimed_non_lru" is better,
> then we can do that. FWIW mm_account_reclaimed_pages() was taken from
> a suggestion from Dave Chinner. My initial version had a terrible
> name: report_freed_pages(), so I am happy with whatever you see fit.
> 
> Should I re-spin for this or can we change it in place?

Respin would be good, but maybe wait a bit more on other comments. I'm 
bad at naming things as well :)

-- 
Thanks,

David / dhildenb

