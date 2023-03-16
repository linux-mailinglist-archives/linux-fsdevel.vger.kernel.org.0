Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0996BC8C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCPISo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCPISj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:18:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2B25974;
        Thu, 16 Mar 2023 01:18:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 87BCC21A37;
        Thu, 16 Mar 2023 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678954691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hatJpOnSsIAYycIYBXhXmiUf3AaZdss4FBUHrje79BU=;
        b=CEKvMlo86HMsqhsYEvFOx9bJ/4gkgg6ZuenPJbAd5wdNMhB8hnbBqQ8DEi2v3JHGlGVEpO
        v9i1oUizAkiZaF395GqZb51NZ46Re6xz8PWCJYlWzyZHjBU2EZB6Z5qqKcMsxn6P/mplQg
        /Pu5Bka0fMvruR8hGoNVXBf5FoXB9Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678954691;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hatJpOnSsIAYycIYBXhXmiUf3AaZdss4FBUHrje79BU=;
        b=6KYYDi/9xr3de71WiWcvgrBeGMcGacvfhuQUQn7UkSQaEB0gzFdQ6jVHiXr2hBpkpTRtGf
        ycwHGf+9Xyd6/yBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60079133E0;
        Thu, 16 Mar 2023 08:18:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cvzRFsPQEmShGwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 16 Mar 2023 08:18:11 +0000
Message-ID: <c87d4f6c-e947-70b2-f74f-2e5145572123@suse.cz>
Date:   Thu, 16 Mar 2023 09:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
 <ZBEzUN35gOK5igmT@P9FQF9L96D>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZBEzUN35gOK5igmT@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/23 03:54, Roman Gushchin wrote:
> On Tue, Mar 14, 2023 at 09:05:13AM +0100, Vlastimil Babka wrote:
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
> 
> I guess eventually we want to merge the percpu allocator too.

What exactly do you mean here, probably not mm/percpu.c which is too
different from slab, but some kind of per-cpu object cache on top of slab?
