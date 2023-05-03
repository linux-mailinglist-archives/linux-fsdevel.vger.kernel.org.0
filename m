Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A256F583A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 14:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjECMyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjECMyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 08:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD040C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 05:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683118413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7omNY6vy02Lp1suD+qs+FsdVxhpMQyx9ZjsBrwK7NY=;
        b=QKjJceLJ/iW84TrXPDatVCC93CdO4fyAG6v4kar+BZz3th030/jQF7VrMnWXJHo0e7wLRO
        2KjJi3s88s+sp+wjNNlfNOZyrPotcRqRX8cQ3Zn0xfD2W/5P6oD5WwKYdNwVlJG4sVgeNQ
        Ux77DNMv0lYWfElTl0/4sZWIbYi5P4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-mk1QkEGGNIuxGonmvgH2sA-1; Wed, 03 May 2023 08:53:32 -0400
X-MC-Unique: mk1QkEGGNIuxGonmvgH2sA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f17afcf99cso16321955e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 05:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118411; x=1685710411;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7omNY6vy02Lp1suD+qs+FsdVxhpMQyx9ZjsBrwK7NY=;
        b=dIXtwaoZ1Lb6oiTUq4V18Tek51KpLvEnHrw6xRp3CROefKDH/Pcl7r7wB/YDcE/hfy
         KsthE/mjvcqldcioHR5R9ov+oEKuqJhkc2P+CbEaocwzABRc+GqIX4D76D7dboxz7CcO
         u7oT1gy8QCvtLS0grGRuH8Y9AHO3HMtFCb2l2a5QNwXiFbcsQH4KQ6ktnii6OPTMd0ji
         ICUC1cSKQ3iGvWg4P5flRu7oH1vnrJIsAR50jVkPj+vhxN9IPSa05XmtMBA5v78Uh+9B
         U4s4mXA9SNHs7lz9kPdDxSkvaSMaxrbXJQietfARAqmKAPm67g73oim3qAEINH8qex25
         jNHQ==
X-Gm-Message-State: AC+VfDyKc5SlFPDo2gnXJ2KGQAwHl/b9r9i3w5dXukigfFfng3aSU70a
        gQWj022Eu4beZwhfkFtdlG2BXnbQl65PfIGvtzcrT9pfNasx2VDhJXW7ss1TRWW3mh41DYozSXj
        ldyurs4Mthdjflwpyl1rBQSwv3g==
X-Received: by 2002:a7b:ce8b:0:b0:3f1:7fc0:4dbc with SMTP id q11-20020a7bce8b000000b003f17fc04dbcmr15191400wmj.38.1683118411268;
        Wed, 03 May 2023 05:53:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zn0nW8Gp1TbS9lzJwairWR12aoba8GxaRMOEMvQIPhrgSVoh91x6yDqo37mi1fS7EneKCbQ==
X-Received: by 2002:a7b:ce8b:0:b0:3f1:7fc0:4dbc with SMTP id q11-20020a7bce8b000000b003f17fc04dbcmr15191354wmj.38.1683118410893;
        Wed, 03 May 2023 05:53:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:6a00:9109:6424:1804:a441? (p200300cbc7116a00910964241804a441.dip0.t-ipconnect.de. [2003:cb:c711:6a00:9109:6424:1804:a441])
        by smtp.gmail.com with ESMTPSA id a24-20020a05600c225800b003f349d14010sm1849938wmm.38.2023.05.03.05.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:53:30 -0700 (PDT)
Message-ID: <976fcec0-d132-3a27-bbd2-01b21571bca2@redhat.com>
Date:   Wed, 3 May 2023 14:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 0/3] mm/gup: disallow GUP writing to file-backed
 mappings by default
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683067198.git.lstoakes@gmail.com>
 <20d078c5-4ee6-18dc-d3a5-d76b6a68f64e@linux.ibm.com>
 <1b34e9a4-83c0-2f44-1457-dd8800b9287a@redhat.com>
 <80e3b8ee-c16d-062f-f483-06e21282e59c@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <80e3b8ee-c16d-062f-f483-06e21282e59c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.05.23 13:25, Matthew Rosato wrote:
> On 5/3/23 3:08 AM, David Hildenbrand wrote:
>> On 03.05.23 02:31, Matthew Rosato wrote:
>>> On 5/2/23 6:51 PM, Lorenzo Stoakes wrote:
>>>> Writing to file-backed mappings which require folio dirty tracking using
>>>> GUP is a fundamentally broken operation, as kernel write access to GUP
>>>> mappings do not adhere to the semantics expected by a file system.
>>>>
>>>> A GUP caller uses the direct mapping to access the folio, which does not
>>>> cause write notify to trigger, nor does it enforce that the caller marks
>>>> the folio dirty.
>>>>
>>>> The problem arises when, after an initial write to the folio, writeback
>>>> results in the folio being cleaned and then the caller, via the GUP
>>>> interface, writes to the folio again.
>>>>
>>>> As a result of the use of this secondary, direct, mapping to the folio no
>>>> write notify will occur, and if the caller does mark the folio dirty, this
>>>> will be done so unexpectedly.
>>>>
>>>> For example, consider the following scenario:-
>>>>
>>>> 1. A folio is written to via GUP which write-faults the memory, notifying
>>>>      the file system and dirtying the folio.
>>>> 2. Later, writeback is triggered, resulting in the folio being cleaned and
>>>>      the PTE being marked read-only.
>>>> 3. The GUP caller writes to the folio, as it is mapped read/write via the
>>>>      direct mapping.
>>>> 4. The GUP caller, now done with the page, unpins it and sets it dirty
>>>>      (though it does not have to).
>>>>
>>>> This change updates both the PUP FOLL_LONGTERM slow and fast APIs. As
>>>> pin_user_pages_fast_only() does not exist, we can rely on a slightly
>>>> imperfect whitelisting in the PUP-fast case and fall back to the slow case
>>>> should this fail.
>>>>
>>>> v8:
>>>> - Fixed typo writeable -> writable.
>>>> - Fixed bug in writable_file_mapping_allowed() - must check combination of
>>>>     FOLL_PIN AND FOLL_LONGTERM not either/or.
>>>> - Updated vma_needs_dirty_tracking() to include write/shared to account for
>>>>     MAP_PRIVATE mappings.
>>>> - Move to open-coding the checks in folio_pin_allowed() so we can
>>>>     READ_ONCE() the mapping and avoid unexpected compiler loads. Rename to
>>>>     account for fact we now check flags here.
>>>> - Disallow mapping == NULL or mapping & PAGE_MAPPING_FLAGS other than
>>>>     anon. Defer to slow path.
>>>> - Perform GUP-fast check _after_ the lowest page table level is confirmed to
>>>>     be stable.
>>>> - Updated comments and commit message for final patch as per Jason's
>>>>     suggestions.
>>>
>>> Tested again on s390 using QEMU with a memory backend file (on ext4) and vfio-pci -- This time both vfio_pin_pages_remote (which will call pin_user_pages_remote(flags | FOLL_LONGTERM)) and the pin_user_pages_fast(FOLL_WRITE | FOLL_LONGTERM) in kvm_s390_pci_aif_enable are being allowed (e.g. returning positive pin count)
>>
>> At least it's consistent now ;) And it might be working as expected ...
>>
>> In v7:
>> * pin_user_pages_fast() succeeded
>> * vfio_pin_pages_remote() failed
>>
>> But also in v7:
>> * GUP-fast allows pinning (anonymous) pages in MAP_PRIVATE file
>>    mappings
>> * Ordinary GUP allows pinning pages in MAP_PRIVATE file mappings
>>
>> In v8:
>> * pin_user_pages_fast() succeeds
>> * vfio_pin_pages_remote() succeeds
>>
>> But also in v8:
>> * GUP-fast allows pinning (anonymous) pages in MAP_PRIVATE file
>>    mappings
>> * Ordinary GUP allows pinning pages in MAP_PRIVATE file mappings
>>
>>
>> I have to speculate, but ... could it be that you are using a private mapping?
>>
>> In QEMU, unfortunately, the default for memory-backend-file is "share=off" (private) ... for memory-backend-memfd it is "share=on" (shared). The default is stupid ...
>>
>> If you invoke QEMU manually, can you specify "share=on" for the memory-backend-file? I thought libvirt would always default to "share=on" for file mappings (everything else doesn't make much sense) ... but you might have to specify
>>      <access mode="shared"/>
>> in addition to
>>      <source type="file"/>
>>
> 
> Ah, there we go.  Yes, I was using the default of share=off.  When I instead specify share=on, now the pins will fail in both cases.
> 

Out of curiosity, how does that manifest?

I assume the VM is successfully created and as Linux tries initializing 
and using the device, we get a bunch of errors inside the VM, correct?

-- 
Thanks,

David / dhildenb

