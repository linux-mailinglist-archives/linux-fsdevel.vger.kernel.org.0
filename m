Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CE6FDA37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 10:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjEJI73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjEJI7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 04:59:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6135A2;
        Wed, 10 May 2023 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BhBQbjRKMcpCMdX8A1QJANySCjXl12HK+zd5Mpx2Tvo=; b=dJs4fKGrzLv01UXL5cO86flVF9
        c84zgMulooq9vdrMaGWri7wll0LaMC+DYX4KhgUNFbe1fgc2ulDHhwwNziKGiTR846La/yUmNigTK
        wrY+Q49vwfovYHH+IhfClYrqAV4erbJO6GptxQMhz7Nbvidv5m64eivySEVkOXr/b3MBX/u6lHjJl
        PdQyDpisULA2PC3WUNMEH1nUiwMFCSyuzLluA8RnEUoLM3v8sM8QkjU/Jygmtagd0zFPpHHeMDXlt
        aYmncabcz8UNKcNkezJ9a1Si/ZLjXctfrGxR4pKXRWaG7cw891Sd/j9fUE4ZKj92OZLbHJrRbbt3H
        eorLXYWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pwff8-00G7gt-Iw; Wed, 10 May 2023 08:59:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 54929300338;
        Wed, 10 May 2023 10:59:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B39320B04BA9; Wed, 10 May 2023 10:59:05 +0200 (CEST)
Date:   Wed, 10 May 2023 10:59:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <20230510085905.GJ4253@hirez.programming.kicks-ass.net>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
 <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
 <ZFqqsyDpatgb77Vh@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqqsyDpatgb77Vh@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 04:18:59PM -0400, Kent Overstreet wrote:
> On Tue, May 09, 2023 at 09:31:47PM +0200, Peter Zijlstra wrote:
> > On Tue, May 09, 2023 at 12:56:28PM -0400, Kent Overstreet wrote:
> > > This adds a method to tell lockdep not to check lock ordering within a
> > > lock class - but to still check lock ordering w.r.t. other lock types.
> > > 
> > > This is for bcachefs, where for btree node locks we have our own
> > > deadlock avoidance strategy w.r.t. other btree node locks (cycle
> > > detection), but we still want lockdep to check lock ordering w.r.t.
> > > other lock types.
> > > 
> > 
> > ISTR you had a much nicer version of this where you gave a custom order
> > function -- what happend to that?
> 
> Actually, I spoke too soon; this patch and the other series with the
> comparison function solve different problems.
> 
> For bcachefs btree node locks, we don't have a defined lock ordering at
> all - we do full runtime cycle detection, so we don't want lockdep
> checking for self deadlock because we're handling that but we _do_ want
> lockdep checking lock ordering of btree node locks w.r.t. other locks in
> the system.

Have you read the ww_mutex code? If not, please do so, it does similar
things.

The way it gets around the self-nesting check is by using the nest_lock
annotation, the acquire context itself also has a dep_map for this
purpose.
