Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D756F0292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjD0I3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0I3s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:29:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592919B9;
        Thu, 27 Apr 2023 01:29:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA7D821A40;
        Thu, 27 Apr 2023 08:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682584183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5HZTSFrzWtBYnuBYintcvIIAgF3iktWG4WhcixoNBs=;
        b=2VZJLOteCXB5x7qGpePCN15IyixuXEfP/YCclnOkg2okWD9z85poLundXOr+hfQ75Bx8z6
        e2RBBk+rjEmWJL3iKpcO3OVWaPOMZIzK23QTlULfge4tUgwS0Wxgi8SVUr7Z+VgxyVYGHt
        xyKI6uyMt5Tck82tWJbKuExwaEvmJj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682584183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5HZTSFrzWtBYnuBYintcvIIAgF3iktWG4WhcixoNBs=;
        b=7rg0I0z9R1Q5zouAGGyLG9AkNA9quvvz57/VLVxpo722dfm6Og7kn47VZCK2qUvOAa/8xK
        xqxRVzSPb5K5v5AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A0AC138F9;
        Thu, 27 Apr 2023 08:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fKAIIXcySmQJVAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Apr 2023 08:29:43 +0000
Message-ID: <19acbdbb-fc2f-e198-3d31-850ef53f544e@suse.cz>
Date:   Thu, 27 Apr 2023 10:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
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
 <951d364a-05c0-b290-8abe-7cbfcaeb2df7@suse.cz>
 <CAANmLtzQmVN_EWLv1UxXwZu5X=TwpcMQMYArKNUxAJL3PnfO2Q@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAANmLtzQmVN_EWLv1UxXwZu5X=TwpcMQMYArKNUxAJL3PnfO2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/5/23 21:54, Binder Makin wrote:
> I'm still running tests to explore some of these questions.
> The machines I am using are roughly as follows.
> 
> Intel dual socket 56 total cores
> 192-384GB ram
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL2_CACHE_SIZE                  1048576
> LEVEL3_CACHE_SIZE                  40370176
> 
> Amd dual socket 128 total cores
> 1TB ram
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL2_CACHE_SIZE                  524288
> LEVEL3_CACHE_SIZE                  268435456
> 
> Arm single socket 64 total cores
> 256GB rma
> LEVEL1_ICACHE_SIZE                 65536
> LEVEL1_DCACHE_SIZE                 65536
> LEVEL2_CACHE_SIZE                  1048576
> LEVEL3_CACHE_SIZE                  33554432

So with "some artifact of different cache layout" I didn't mean the
different cache sizes of the processors, but possible differences how
objects end up placed in memory by SLAB vs SLUB causing them to collide in
the cache of cause false sharing less or more. This kind of interference can
make interpreting (micro)benchmark results hard.

Anyway, how I'd hope to approach this topic would be that SLAB removal is
proposed, and anyone who opposes that because they can't switch from SLAB to
SLUB would describe why they can't. I'd hope the "why" to be based on
testing with actual workloads, not just benchmarks. Benchmarks are then of
course useful if they can indeed distill the reason why the actual workload
regresses, as then anyone can reproduce that locally and develop/test fixes
etc. My hope is that if some kind of regression is found (e.g. due to lack
of percpu array in SLUB), it can be dealt with by improving SLUB.

Historically I recall that we (SUSE) objected somwhat to SLAB removal as our
distro kernels were using it, but we have switched since. Then networking
had concerns (possibly related to the lack percpu array) but seems bulk
allocations helped and they use SLUB these days [1]. And IIRC Google was
also sticking to SLAB, which led to some attempts to augment SLUB for those
workloads years ago, but those were never finished. So I'd be curious if we
should restart those effors or can just remove SLAB now.

[1] https://lore.kernel.org/all/93665604-5420-be5d-2104-17850288b955@redhat.com/


