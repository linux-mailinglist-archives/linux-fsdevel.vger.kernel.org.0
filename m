Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D156D682E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjDDQDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjDDQDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:03:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BD1A8;
        Tue,  4 Apr 2023 09:03:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A50D20258;
        Tue,  4 Apr 2023 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680624188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuCGsnYMiMa4eeDwQP7y5gx95Bxfi3LY8COha+SD3xw=;
        b=0H4UafI3sTZDD0fneaXzmmqJL8Hd/BQ3DOq2WpWAQ7CqD+OpS2cyaSZreiZ1ahbk5DbTEt
        vWcqZhp3TOo09KDe/1DGZvWihR0PGeEiHt7KLd4vRKwnoy6ArjbZFhzIIB2bFQXlnaKiXq
        1efxl2DGlkD7AbYBdwBcQTAK+W9wfBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680624188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuCGsnYMiMa4eeDwQP7y5gx95Bxfi3LY8COha+SD3xw=;
        b=NaRIieVzI5/NC18H0JkKim/Ia/h2tLZHNBp0WFaN6z3RAek6dfYtHu8XUa6xmfgPXwsTU7
        CK144MupDkdFcdBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1963B1391A;
        Tue,  4 Apr 2023 16:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id arpDBTxKLGQfGQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 04 Apr 2023 16:03:08 +0000
Message-ID: <951d364a-05c0-b290-8abe-7cbfcaeb2df7@suse.cz>
Date:   Tue, 4 Apr 2023 18:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Content-Language: en-US
To:     Binder Makin <merimus@google.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
 <CAANmLtwGS75WJ9AXfmqZv73pNdHJn6zfrrCCWjKK_6jPk9pWRg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAANmLtwGS75WJ9AXfmqZv73pNdHJn6zfrrCCWjKK_6jPk9pWRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/23 13:30, Binder Makin wrote:
> Was looking at SLAB removal and started by running A/B tests of SLAB
> vs SLUB.  Please note these are only preliminary results.

Thanks, that's very useful.

> These were run using 6.1.13 configured for SLAB/SLUB.
> Machines were standard datacenter servers.
> 
> Hackbench shows completion time, so smaller is better.
> On all others larger is better.
> https://docs.google.com/spreadsheets/d/e/2PACX-1vQ47Mekl8BOp3ekCefwL6wL8SQiv6Qvp5avkU2ssQSh41gntjivE-aKM4PkwzkC4N_s_MxUdcsokhhz/pubhtml
> 
> Some notes:
> SUnreclaim and SReclaimable shows unreclaimable and reclaimable memory.
> Substantially higher with SLUB, but I believe that is to be expected.
> 
> Various results showing a 5-10% degradation with SLUB.  That feels
> concerning to me, but I'm not sure what others' tolerance would be.
> 
> redis results on AMD show some pretty bad degredations.  10-20% range
> netpipe on Intel also has issues.. 10-17%

I guess one question is which ones are genuine SLAB/SLUB differences and not
e.g. some artifact of different cache layout or something. For example it
seems suspicious if results are widely different between architectures.

E.g. will-it-scale writeseek3_scalability regresses on arm64 and amd, but
improves on intel? Or is something wrong with the data, all columns for that
whole benchmark suite are identical.

hackbench ("smaller is better") seems drastically better on arm64 (30%
median time reduction?) and amd (80% reduction?!?), but 10% slower intel?

redis seems a bit improved on arm64, slightly worse on intel but much worse
on amd.

specjbb similar story, also I thought it was a java focused benchmark,
should it really be exercising kernel slab allocators in such notable way?

I guess netpipe is the least surprising as networking was always mentioned
in SLAB vs SLUB discussions.

> On Tue, Mar 14, 2023 at 4:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
>> only SLUB going forward. The removal of SLOB seems to be going well, there
>> were no objections to the deprecation and I've posted v1 of the removal
>> itself [1] so it could be in -next soon.
>>
>> The immediate benefit of that is that we can allow kfree() (and kfree_rcu())
>> to free objects from kmem_cache_alloc() - something that IIRC at least xfs
>> people wanted in the past, and SLOB was incompatible with that.
>>
>> For SLAB removal I haven't yet heard any objections (but also didn't
>> deprecate it yet) but if there are any users due to particular workloads
>> doing better with SLAB than SLUB, we can discuss why those would regress and
>> what can be done about that in SLUB.
>>
>> Once we have just one slab allocator in the kernel, we can take a closer
>> look at what the users are missing from it that forces them to create own
>> allocators (e.g. BPF), and could be considered to be added as a generic
>> implementation to SLUB.
>>
>> Thanks,
>> Vlastimil
>>
>> [1] https://lore.kernel.org/all/20230310103210.22372-1-vbabka@suse.cz/
>>

