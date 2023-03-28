Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F06CC89B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 18:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjC1Qz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjC1Qz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:55:57 -0400
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C83B746
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 09:55:56 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680022554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxBJnNBm/cNkHCZcwSILQF6wnG9ilV9aQydMGT1rWvc=;
        b=VkJqDZG+29d//8LLQh/wx5LDGNqIe/T2Z+MMrUsnWdQTtA3opKIdt/us+IYc7a1GHMTVQG
        cTx67DsHRe2UY5fIl8hBB9LNV0MF5SoMWxOhsPuEjr35k2K+zviAiWLCJ25s1q5Yv9gJmQ
        IlXq1BeUjhk4eys036gB7dm6q8f5GkM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Memory profiling using code tagging
Message-ID: <ZCMcEquI4Imgv818@moria.home.lan>
References: <CAJuCfpHJX8zeQY6t5rrKps6GxbadRZBE+Pzk21wHfqZC8PFVCA@mail.gmail.com>
 <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115288f8-bd28-f01f-dd91-63015dcc635d@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

No, page_ext is really the thing that makes the most sense here. It's
per-page allocation information, so the only other place it could go is
in struct page itself - but that doesn't make any sense with the boot
time option we've got now, page_ext works perfectly with that.
