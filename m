Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116896BA56A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 04:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCODAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 23:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCODAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:00:51 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Mar 2023 20:00:49 PDT
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAAB4C6F4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 20:00:48 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:54:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678848853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctapMItOIZsfzFhEc3JvdA9EOk3B6vYmM+FXjmAeKQk=;
        b=S85qHME5d8VThaKta/6fehQVWG3p4FqIiHEZ7d34QmY87G/pcECtJJwFnb0GrNF1AcFsGK
        mOIwaeJhFDmW5x9+foUp2O4Gx7CkBTROL7SDa8DENrRKpqTR2cfxh5sVlbFUXfPoHe1SEB
        /JNZs5CcbaqBFFxZIlUzCloMej+ZUr4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] SLOB+SLAB allocators removal and future SLUB
 improvements
Message-ID: <ZBEzUN35gOK5igmT@P9FQF9L96D>
References: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 09:05:13AM +0100, Vlastimil Babka wrote:
> As you're probably aware, my plan is to get rid of SLOB and SLAB, leaving
> only SLUB going forward. The removal of SLOB seems to be going well, there
> were no objections to the deprecation and I've posted v1 of the removal
> itself [1] so it could be in -next soon.
> 
> The immediate benefit of that is that we can allow kfree() (and kfree_rcu())
> to free objects from kmem_cache_alloc() - something that IIRC at least xfs
> people wanted in the past, and SLOB was incompatible with that.
> 
> For SLAB removal I haven't yet heard any objections (but also didn't
> deprecate it yet) but if there are any users due to particular workloads
> doing better with SLAB than SLUB, we can discuss why those would regress and
> what can be done about that in SLUB.
> 
> Once we have just one slab allocator in the kernel, we can take a closer
> look at what the users are missing from it that forces them to create own
> allocators (e.g. BPF), and could be considered to be added as a generic
> implementation to SLUB.

I guess eventually we want to merge the percpu allocator too.
