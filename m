Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921B6FE277
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjEJQ2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjEJQ2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 12:28:54 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D07DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 09:28:53 -0700 (PDT)
Date:   Wed, 10 May 2023 12:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683736131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYcJ9BZ1mxYTmW6a8/38gfY091GqMcL8DJ8glX2OZQM=;
        b=ZYe80aIKHQFU6hSAnJo2ZOlHsjm4xX3rHplLPiNn21AGUtOPosTr4ICG+ZcNJqHqfFBJ6k
        AM6pIJZQlYs536/8A80yRxHX1/mhn7F0jQaGfENHZrCoWKR0zVyfPzoD/iKV6aRwBbccwM
        Gma38xXl1JcPxsrMlN929YPlxFobjmQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
Message-ID: <ZFvGP211N+CuGEUT@moria.home.lan>
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:28:21PM +0200, Vlastimil Babka wrote:
> On 2/22/23 20:31, Suren Baghdasaryan wrote:
> > We would like to continue the discussion about code tagging use for
> > memory allocation profiling. The code tagging framework [1] and its
> > applications were posted as an RFC [2] and discussed at LPC 2022. It
> > has many applications proposed in the RFC but we would like to focus
> > on its application for memory profiling. It can be used as a
> > low-overhead solution to track memory leaks, rank memory consumers by
> > the amount of memory they use, identify memory allocation hot paths
> > and possible other use cases.
> > Kent Overstreet and I worked on simplifying the solution, minimizing
> > the overhead and implementing features requested during RFC review.
> 
> IIRC one large objection was the use of page_ext, I don't recall if you
> found another solution to that?

Hasn't been addressed yet, but we were just talking about moving the
codetag pointer from page_ext to page last night for memory overhead
reasons.

The disadvantage then is that the memory overhead doesn't go down if you
disable memory allocation profiling at boot time...

But perhaps the performance overhead is low enough now that this is not
something we expect to be doing as much?

Choices, choices...
