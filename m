Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4FE6FEEE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjEKJch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjEKJcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 05:32:33 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C51755B6
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 02:32:29 -0700 (PDT)
Date:   Thu, 11 May 2023 05:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683797547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnpK2EQat/Ff2KEBV71odomLn6KPTIV5+P/7fITBQhY=;
        b=Ey1KdQotjaQR2+EzlA3MPQ6M81s96sZA66yvMsBaAI0FOSARyHtWvwB74GkAYD0TCcGKGs
        2VRZPsWRDRjhqsYegKW+MmI4fxDbjfM/uF+K/eFWRmXuBcaZG/40kxbelv4JGCe7lb1EKL
        w1dq9zwbGcMCiskQgaydjx+yPpKhpG8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <ZFy2JqL/xkvIn+O1@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
 <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
 <ZFqqsyDpatgb77Vh@moria.home.lan>
 <20230510085905.GJ4253@hirez.programming.kicks-ass.net>
 <ZFwAtwIrKyJ9GJ/U@moria.home.lan>
 <20230511082544.GS4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511082544.GS4253@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 10:25:44AM +0200, Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 04:38:15PM -0400, Kent Overstreet wrote:
> > On Wed, May 10, 2023 at 10:59:05AM +0200, Peter Zijlstra wrote:
> 
> > > Have you read the ww_mutex code? If not, please do so, it does similar
> > > things.
> > > 
> > > The way it gets around the self-nesting check is by using the nest_lock
> > > annotation, the acquire context itself also has a dep_map for this
> > > purpose.
> > 
> > This might work.
> > 
> > I was confused for a good bit when reading tho code to figure out how
> > it works - nest_lock seems to be a pretty bad name, it's really not a
> > lock. acquire_ctx?
> 
> That's just how ww_mutex uses it, the annotation itself comes from
> mm_take_all_locks() where mm->mmap_lock (the lock formerly known as
> mmap_sem) is used to serialize multi acquisition of vma locks.
> 
> That is, no other code takes multiple vma locks (be it i_mmap_rwsem or
> anonvma->root->rwsem) in any order. These locks nest inside mmap_lock
> and therefore by holding mmap_lock you serialize the whole thing and can
> take them in any order you like.
> 
> Perhaps, now, all these many years later another name would've made more
> sense, but I don't think it's worth the hassle of the tree-wide rename
> (there's a few other users since).

Thanks for the history lesson :)
