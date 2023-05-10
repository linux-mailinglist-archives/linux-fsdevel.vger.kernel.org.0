Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF86FE540
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbjEJUi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJUiZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 16:38:25 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D55FE7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 13:38:20 -0700 (PDT)
Date:   Wed, 10 May 2023 16:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683751099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Fntx7MeicDCqrqkDflloXBJRcdF7P6Ni3sDbF9MNgY=;
        b=sgO/UEIER2ve69V7tr81qDruo0+4xB0qMuqeM/8cdeT0yaaX6I/u4iRttuOzcQCIkedk7A
        R06RISg+MM0T5Pweyj+u2fbyUVH8fL50g+G1V7Ab/ISM3Pqn248qKrUvNY6tC1cpnhkhwp
        hgvyOqVblL24TSKV1xAEptkKxoz3d6s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/32] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <ZFwAtwIrKyJ9GJ/U@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-4-kent.overstreet@linux.dev>
 <20230509193147.GC2148518@hirez.programming.kicks-ass.net>
 <ZFqqsyDpatgb77Vh@moria.home.lan>
 <20230510085905.GJ4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510085905.GJ4253@hirez.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 10, 2023 at 10:59:05AM +0200, Peter Zijlstra wrote:
> On Tue, May 09, 2023 at 04:18:59PM -0400, Kent Overstreet wrote:
> > On Tue, May 09, 2023 at 09:31:47PM +0200, Peter Zijlstra wrote:
> > > On Tue, May 09, 2023 at 12:56:28PM -0400, Kent Overstreet wrote:
> > > > This adds a method to tell lockdep not to check lock ordering within a
> > > > lock class - but to still check lock ordering w.r.t. other lock types.
> > > > 
> > > > This is for bcachefs, where for btree node locks we have our own
> > > > deadlock avoidance strategy w.r.t. other btree node locks (cycle
> > > > detection), but we still want lockdep to check lock ordering w.r.t.
> > > > other lock types.
> > > > 
> > > 
> > > ISTR you had a much nicer version of this where you gave a custom order
> > > function -- what happend to that?
> > 
> > Actually, I spoke too soon; this patch and the other series with the
> > comparison function solve different problems.
> > 
> > For bcachefs btree node locks, we don't have a defined lock ordering at
> > all - we do full runtime cycle detection, so we don't want lockdep
> > checking for self deadlock because we're handling that but we _do_ want
> > lockdep checking lock ordering of btree node locks w.r.t. other locks in
> > the system.
> 
> Have you read the ww_mutex code? If not, please do so, it does similar
> things.
> 
> The way it gets around the self-nesting check is by using the nest_lock
> annotation, the acquire context itself also has a dep_map for this
> purpose.

This might work.

I was confused for a good bit when reading tho code to figure out how
it works - nest_lock seems to be a pretty bad name, it's really not a
lock. acquire_ctx?
