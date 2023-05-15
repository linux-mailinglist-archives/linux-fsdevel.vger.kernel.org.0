Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED636702451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjEOGSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 02:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjEOGSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 02:18:23 -0400
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [IPv6:2001:41d0:1004:224b::17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58210E54
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 May 2023 23:18:19 -0700 (PDT)
Date:   Mon, 15 May 2023 02:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684131498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9g4atnH114wwIREvS7FQpq8AT+DoOchnOh70popS5b4=;
        b=ls7qJyNMnqFIDPENsNB+6BCWOE7+PK2EihntRVfbtXnaMP2H48XTUeJw/pT3TeHklLu2QM
        oNMGN8jcwYnpeL46T/OXzf4sSOPvZuMY4TzkYy2BLeG3czZwZdLrPejKvonjkBYlvKoUOA
        EDcEoKkjiz0gJpijRB+sfmNlKdsHcx4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGHOppBFcKEJkzCe@moria.home.lan>
References: <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
 <20230515061346.GB15871@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515061346.GB15871@sol.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 14, 2023 at 11:13:46PM -0700, Eric Biggers wrote:
> On Mon, May 15, 2023 at 01:38:51AM -0400, Kent Overstreet wrote:
> > On Sun, May 14, 2023 at 11:43:25AM -0700, Eric Biggers wrote:
> > > I think it would also help if the generated assembly had the handling of the
> > > fields interleaved.  To achieve that, it might be necessary to interleave the C
> > > code.
> > 
> > No, that has negligable effect on performance - as expected, for an out
> > of order processor. < 1% improvement.
> > 
> > It doesn't look like this approach is going to work here. Sadly.
> 
> I'd be glad to take a look at the code you actually tried.  It would be helpful
> if you actually provided it, instead of just this "I tried it, I'm giving up
> now" sort of thing.

https://evilpiepirate.org/git/bcachefs.git/log/?h=bkey_unpack

> I was also hoping you'd take the time to split this out into a userspace
> micro-benchmark program that we could quickly try different approaches on.

I don't need to, because I already have this:
https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/perf.ktest

> BTW, even if people are okay with dynamic code generation (which seems
> unlikely?), you'll still need a C version for architectures that you haven't
> implemented the dynamic code generation for.

Excuse me? There already is a C version, and we've been discussing it.
Your approach wasn't any faster than the existing C version.
