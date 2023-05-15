Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F47025CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjEOHOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjEOHN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFA171E;
        Mon, 15 May 2023 00:13:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E456F61048;
        Mon, 15 May 2023 07:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156D9C433D2;
        Mon, 15 May 2023 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684134825;
        bh=Blp9UTVwqWg3TA5Q/aNLyv7una68PusuriG4Cx6TJ1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cb1/nGDInJgxvoRAiPafNqmATmMoBlsuo3AOYZmbnMEWUu9D+/GzhbjwxdSL7KZgC
         poCnKGNOC6I2NebFqG89wbQBuyFdlzYsHlmL0tIzbvDH/YvmHuXrgODI1SREFX9L4s
         r7F8kHdWUCYiDtn8Nyxv3siipSh9+93pil61u1IpNHXbL8/N5Gb1dpQ/qb1Q17f1Jg
         djZaDbecgKuQZqXSVhkqwtOU+4e75+6S1PLqVYW3fQJXh2V7wo33rBp4rungohG/fO
         5SByQ8uiE1Y2wRDoEYxnSuhpjAwRnM9zuRuGbWbXRIG/uXpG2+FRauo0FtweydTfxZ
         59Mbo2AG7dWbA==
Date:   Mon, 15 May 2023 00:13:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230515071343.GD15871@sol.localdomain>
References: <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
 <20230515061346.GB15871@sol.localdomain>
 <ZGHOppBFcKEJkzCe@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGHOppBFcKEJkzCe@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 02:18:14AM -0400, Kent Overstreet wrote:
> On Sun, May 14, 2023 at 11:13:46PM -0700, Eric Biggers wrote:
> > On Mon, May 15, 2023 at 01:38:51AM -0400, Kent Overstreet wrote:
> > > On Sun, May 14, 2023 at 11:43:25AM -0700, Eric Biggers wrote:
> > > > I think it would also help if the generated assembly had the handling of the
> > > > fields interleaved.  To achieve that, it might be necessary to interleave the C
> > > > code.
> > > 
> > > No, that has negligable effect on performance - as expected, for an out
> > > of order processor. < 1% improvement.
> > > 
> > > It doesn't look like this approach is going to work here. Sadly.
> > 
> > I'd be glad to take a look at the code you actually tried.  It would be helpful
> > if you actually provided it, instead of just this "I tried it, I'm giving up
> > now" sort of thing.
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bkey_unpack
> 
> > I was also hoping you'd take the time to split this out into a userspace
> > micro-benchmark program that we could quickly try different approaches on.
> 
> I don't need to, because I already have this:
> https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/perf.ktest

Sure, given that this is an optimization problem with a very small scope
(decoding 6 fields from a bitstream), I was hoping for something easier and
faster to iterate on than setting up a full kernel + bcachefs test environment
and reverse engineering 500 lines of shell script.  But sure, I can look into
that when I have a chance.

> Your approach wasn't any faster than the existing C version.

Well, it's your implementation of what you thought was "my approach".  It
doesn't quite match what I had suggested.  As I mentioned in my last email, it's
also unclear that your new code is ever actually executed, since you made it
conditional on all fields being byte-aligned...

- Eric
