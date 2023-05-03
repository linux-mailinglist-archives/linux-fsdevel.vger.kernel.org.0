Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF826F50B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 09:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjECHJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjECHJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 03:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A14269D
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 00:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683097741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHJN0MwZt1Qkyg0FwWKVsL71HOfF8cRCNsnTVzqCki0=;
        b=R+2bgSgN/kg5ZSsBlOzzhEnim05LeudqWvRUxRDerR3LX9plwKewYwOWQanyuYSl02V8F5
        SEKccR3ByCNN0679MhOIZKQFG4ZOuCUjenCgyCKz3vfWpdfTVFb4RCubiqc2UcZBTOi14i
        YR2TCV3EhTl4qPS5RWv1QtNR6IZh5D0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-fKA2CBY3O6-yT9PgF1ux1A-1; Wed, 03 May 2023 03:08:57 -0400
X-MC-Unique: fKA2CBY3O6-yT9PgF1ux1A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30479c17304so1358441f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 00:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683097736; x=1685689736;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHJN0MwZt1Qkyg0FwWKVsL71HOfF8cRCNsnTVzqCki0=;
        b=QtqkhvVYTD03i0LhHeo6O1s8nK1Djr7ISy7/vgsicd5KtpZo/UyWeM6AvJ8ZH1wHkO
         Z4+bB4pL47X1ujjEAOHp0oSStadAjGRynKcF4fNupJ2PHkVTHnN0TAiCIk0J+LZINxBd
         BOO3guT96DaIIVxq8ht1wYyHR8jpftjihmRDXggxEQq8MbRdlRjLsbHv07qInIrWB9j9
         WwbfvjVpGVzhn4iK1/9zYxTumLa9fg+fAfiR2aoXHEi4+ADklHpIt46Vl08UQ1WT8w4k
         NqDDH4gbQOJQrICCbeX46uRf9luwG2imWWl3bnde3ZcJD/zXd9sXFQtrcRsSyxMT2/wE
         d00w==
X-Gm-Message-State: AC+VfDweSe6WllW6dukDVd6/f0e8S0Hq725QNcl9z5f/FFMrMnXhUPcA
        E7xDPR+q1I4rSZHGCoqJRmvFEvdRyfSBSwhBzojkQkdrt/tVzbleTZE4BRNxn0jrNRvZnNG6tV5
        Ajv1x/COL3ymKHiIoUKJEQb+izg==
X-Received: by 2002:a5d:6410:0:b0:306:3a28:f950 with SMTP id z16-20020a5d6410000000b003063a28f950mr3061902wru.7.1683097735920;
        Wed, 03 May 2023 00:08:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NT02o8A0M+QHO4dvjy7p83osecccZDAuDP/z0mhC15FeHFbBpxcPnSHMrIpl83AzT6cM6xQ==
X-Received: by 2002:a5d:6410:0:b0:306:3a28:f950 with SMTP id z16-20020a5d6410000000b003063a28f950mr3061838wru.7.1683097735470;
        Wed, 03 May 2023 00:08:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c711:6a00:9109:6424:1804:a441? (p200300cbc7116a00910964241804a441.dip0.t-ipconnect.de. [2003:cb:c711:6a00:9109:6424:1804:a441])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003f32f013c3csm962580wmh.6.2023.05.03.00.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:08:54 -0700 (PDT)
Message-ID: <1b34e9a4-83c0-2f44-1457-dd8800b9287a@redhat.com>
Date:   Wed, 3 May 2023 09:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 0/3] mm/gup: disallow GUP writing to file-backed
 mappings by default
In-Reply-To: <20d078c5-4ee6-18dc-d3a5-d76b6a68f64e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 03.05.23 02:31, Matthew Rosato wrote:
> On 5/2/23 6:51 PM, Lorenzo Stoakes wrote:
>> Writing to file-backed mappings which require folio dirty tracking using
>> GUP is a fundamentally broken operation, as kernel write access to GUP
>> mappings do not adhere to the semantics expected by a file system.
>>
>> A GUP caller uses the direct mapping to access the folio, which does not
>> cause write notify to trigger, nor does it enforce that the caller marks
>> the folio dirty.
>>
>> The problem arises when, after an initial write to the folio, writeback
>> results in the folio being cleaned and then the caller, via the GUP
>> interface, writes to the folio again.
>>
>> As a result of the use of this secondary, direct, mapping to the folio no
>> write notify will occur, and if the caller does mark the folio dirty, this
>> will be done so unexpectedly.
>>
>> For example, consider the following scenario:-
>>
>> 1. A folio is written to via GUP which write-faults the memory, notifying
>>     the file system and dirtying the folio.
>> 2. Later, writeback is triggered, resulting in the folio being cleaned and
>>     the PTE being marked read-only.
>> 3. The GUP caller writes to the folio, as it is mapped read/write via the
>>     direct mapping.
>> 4. The GUP caller, now done with the page, unpins it and sets it dirty
>>     (though it does not have to).
>>
>> This change updates both the PUP FOLL_LONGTERM slow and fast APIs. As
>> pin_user_pages_fast_only() does not exist, we can rely on a slightly
>> imperfect whitelisting in the PUP-fast case and fall back to the slow case
>> should this fail.
>>
>> v8:
>> - Fixed typo writeable -> writable.
>> - Fixed bug in writable_file_mapping_allowed() - must check combination of
>>    FOLL_PIN AND FOLL_LONGTERM not either/or.
>> - Updated vma_needs_dirty_tracking() to include write/shared to account for
>>    MAP_PRIVATE mappings.
>> - Move to open-coding the checks in folio_pin_allowed() so we can
>>    READ_ONCE() the mapping and avoid unexpected compiler loads. Rename to
>>    account for fact we now check flags here.
>> - Disallow mapping == NULL or mapping & PAGE_MAPPING_FLAGS other than
>>    anon. Defer to slow path.
>> - Perform GUP-fast check _after_ the lowest page table level is confirmed to
>>    be stable.
>> - Updated comments and commit message for final patch as per Jason's
>>    suggestions.
> 
> Tested again on s390 using QEMU with a memory backend file (on ext4) and vfio-pci -- This time both vfio_pin_pages_remote (which will call pin_user_pages_remote(flags | FOLL_LONGTERM)) and the pin_user_pages_fast(FOLL_WRITE | FOLL_LONGTERM) in kvm_s390_pci_aif_enable are being allowed (e.g. returning positive pin count)

At least it's consistent now ;) And it might be working as expected ...

In v7:
* pin_user_pages_fast() succeeded
* vfio_pin_pages_remote() failed

But also in v7:
* GUP-fast allows pinning (anonymous) pages in MAP_PRIVATE file
   mappings
* Ordinary GUP allows pinning pages in MAP_PRIVATE file mappings

In v8:
* pin_user_pages_fast() succeeds
* vfio_pin_pages_remote() succeeds

But also in v8:
* GUP-fast allows pinning (anonymous) pages in MAP_PRIVATE file
   mappings
* Ordinary GUP allows pinning pages in MAP_PRIVATE file mappings


I have to speculate, but ... could it be that you are using a private 
mapping?

In QEMU, unfortunately, the default for memory-backend-file is 
"share=off" (private) ... for memory-backend-memfd it is "share=on" 
(shared). The default is stupid ...

If you invoke QEMU manually, can you specify "share=on" for the 
memory-backend-file? I thought libvirt would always default to 
"share=on" for file mappings (everything else doesn't make much sense) 
... but you might have to specify
	<access mode="shared"/>
in addition to
	<source type="file"/>

-- 
Thanks,

David / dhildenb

