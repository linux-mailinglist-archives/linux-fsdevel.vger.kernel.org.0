Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9CF226C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbgGTQtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgGTQtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:49:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E71C061794;
        Mon, 20 Jul 2020 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SMaxWhwAegvetyWQHJzr2iSeRVKWInsDa9ht3IdzAJE=; b=jKU73cfBY8hjKJ+jOGtnVQYdiv
        tpvcuG2saC1Mh+jzmMArY69tlNIb76Mftum0Mz3M04j3/+Qr+wlSczz+gksG807GoB8HOjv+3wwK2
        TL8uf++3Gm+lglg6jrlEDt0yTtIkrQzJWlOkqkvM0joh5Zh9yCq1/wd+tp7XaqVHz+ZprcVsqOKZe
        d4MrIAIWZGHJ89JsjqjdYwn/tSmQrcLOKiOsoFZdmi8evTDiLOUM8wO59BXAPgsrHsl1tuEIf97ux
        MIUaF4Kauhrk3/f4UJkMKxkuzFigWbGZRelDsf8GLxFdtfp+WLKTI6a4pE5WQ4kyIEIF/E59O471y
        hhqqbiGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYyD-00048y-Kj; Mon, 20 Jul 2020 16:48:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFB43307A6B;
        Mon, 20 Jul 2020 18:48:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE8C723426BA2; Mon, 20 Jul 2020 18:48:50 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:48:50 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dave Chinner <david@fromorbit.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Message-ID: <20200720164850.GF119549@hirez.programming.kicks-ass.net>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
 <20200720160433.GQ9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720160433.GQ9247@paulmck-ThinkPad-P72>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:04:34AM -0700, Paul E. McKenney wrote:
> 2.	If we were to say "unlock" instead of "release", consistency
> 	would demand that we also say "lock" instead of "acquire".
> 	But "lock" is subtlely different than "acquire", and there is
> 	a history of people requesting further divergence.

This, acquire/release are RCpc, while (with the exception of Power)
LOCK/UNLOCK are RCsc.

( Or did we settle on RCtso for our release/acquire order? I have vague
memories of a long-ish thread, but seem to have forgotten the outcome,
if any. )

Lots of subtlety and head-aches right about there. Anyway, it would be
awesome if we can get Power into the RCsc locking camp :-)
