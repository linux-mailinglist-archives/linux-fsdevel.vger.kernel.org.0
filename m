Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06374BBB4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 06:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGHELA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 00:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjGHEK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:10:58 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [IPv6:2001:41d0:203:375::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7E2105
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 21:10:57 -0700 (PDT)
Date:   Sat, 8 Jul 2023 00:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688789454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tua3cusTVAWiQUobwnIpJERruf3dwUSDMjP59oVXpbA=;
        b=GPa5oZizFI9+msR4SXLzcoMgJkBvTt+D93ZbTGPMlJAQMpdoXXkgJLUbYSbxtydyJAa9pX
        9pjJuFDCzcishQaHaAJxvNiBs9GX0r+Opp8+kSD8NI4zmpCHaOtaxGhyMHN/ZVrFYCmCjm
        WriBPdv1lp+dEH+swlj8FNXEi6ULiIs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230708041049.2tdw6fnnjtqwuqlw@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
 <20230707091810.bamrvzcif7ncng46@moria.home.lan>
 <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
 <ZKjd7nQxvzRDA2tK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKjd7nQxvzRDA2tK@casper.infradead.org>
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

On Sat, Jul 08, 2023 at 04:54:22AM +0100, Matthew Wilcox wrote:
> One thing I particularly like about btrfs

:) 

> compared to ntfs3 is that it doesn't use old legacy code like the buffer
> heads, which means that it doesn't add to the technical debt.  From the
> page cache point of view, it's fairly clean.  I wish it used iomap, but
> iomap would need quite a lot of new features to accommodate everything
> bcachefs wants to do.  Maybe iomap will grow those features over time.

My big complaint with iomap is that it's still the old callback based
approach - an indirect function call into the filesystem to get a
mapping, then Doing Stuff, for every walk.

Instead of calling back and forth, we could be filling out a data
structure to represent the IO, then handing it off to the filesystem to
look up the mappings and send to the right place, splitting as needed.
Best part is, we already have such a data structure: struct bio. That's
the approach bcachefs takes.

It would be nice sharing the page cache management code, but like you
mentioned, iomap would have to grow a bunch of features. But, some of
those features other users might like: in particular bcachefs hangs disk
reservations and dirty sector (for i_blocks accounting) off the
pagecache, which to me is a total no brainer, it eliminates looking up
in a second data structure for e.g. the buffered write path.

Also worth noting - bcachefs has had large folio support for awhile now :)
