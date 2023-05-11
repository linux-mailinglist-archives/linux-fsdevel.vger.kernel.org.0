Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15586FEDD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjEKIZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjEKIZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 04:25:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472510C9;
        Thu, 11 May 2023 01:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wZpbxpR/RwY9sqwxsSyrWRiWe8/6Lg93oKafl0bZX8E=; b=Qg/LWjpBqHOBF3P7TcpTYxs4F9
        6JKjmU8x1TYMlI7RYZ0EtAdx6mvXg1xgmS2dk5LJp8cna5pg0yf42UXSMQXQ5481DXZC3qeLtKEXT
        8KGxZAtU7p3Xf0JtELvcMjxQg2r7aE99P/jpvSa/NNbH6wbUkG94QZcioNtzZdw/KfDh9D8QMOvqv
        8ICM2QQr84c1Xl5WiMR5jIsWaXA2DNnv4xRZA8u+IxU3E09XUJKihEXSdmKx4tbh47v8MhfjExx3Z
        /9ff6/2ug8Y3buZuATxa105RCSQaJ1jglJ9NoSvivv29PduL1m6tcCFUgos4BYvqfghkg2J4j/tVE
        zm7PCaWg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1px1cP-00H1wb-NZ; Thu, 11 May 2023 08:25:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2343C300338;
        Thu, 11 May 2023 10:25:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01D10235CC450; Thu, 11 May 2023 10:25:44 +0200 (CEST)
Date:   Thu, 11 May 2023 10:25:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <20230511082544.GS4253@hirez.programming.kicks-ass.net>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
 <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
 <ZFqqsyDpatgb77Vh@moria.home.lan>
 <20230510085905.GJ4253@hirez.programming.kicks-ass.net>
 <ZFwAtwIrKyJ9GJ/U@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFwAtwIrKyJ9GJ/U@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 04:38:15PM -0400, Kent Overstreet wrote:
> On Wed, May 10, 2023 at 10:59:05AM +0200, Peter Zijlstra wrote:

> > Have you read the ww_mutex code? If not, please do so, it does similar
> > things.
> > 
> > The way it gets around the self-nesting check is by using the nest_lock
> > annotation, the acquire context itself also has a dep_map for this
> > purpose.
> 
> This might work.
> 
> I was confused for a good bit when reading tho code to figure out how
> it works - nest_lock seems to be a pretty bad name, it's really not a
> lock. acquire_ctx?

That's just how ww_mutex uses it, the annotation itself comes from
mm_take_all_locks() where mm->mmap_lock (the lock formerly known as
mmap_sem) is used to serialize multi acquisition of vma locks.

That is, no other code takes multiple vma locks (be it i_mmap_rwsem or
anonvma->root->rwsem) in any order. These locks nest inside mmap_lock
and therefore by holding mmap_lock you serialize the whole thing and can
take them in any order you like.

Perhaps, now, all these many years later another name would've made more
sense, but I don't think it's worth the hassle of the tree-wide rename
(there's a few other users since).
