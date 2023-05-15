Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7F702603
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbjEOH04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjEOH0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:26:54 -0400
Received: from out-22.mta0.migadu.com (out-22.mta0.migadu.com [IPv6:2001:41d0:1004:224b::16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14A310CA
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:26:49 -0700 (PDT)
Date:   Mon, 15 May 2023 03:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684135607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MiMXjQSln0dtBobMFdzPKQ/MVgbhIU/qdMUMXbRpyRs=;
        b=Yo5HQVlC5T/RlG0F1NWP61AQIcCBYkCdSZHYD/8ksY1fzx4GYr8jAZCkCoFZ9mjij8r5wY
        yc+vGtVq6FiqqbQ9ko1zj2ZfyajpGWAh9LjNtlTIgeBjnU9rT7JioXlndCvK44yEqWF6DI
        BpyHKJ5Sa1jkY/phUwXQ4KJRDbYu/wM=
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
Message-ID: <ZGHesxEMsCfOewhy@moria.home.lan>
References: <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
 <20230515061346.GB15871@sol.localdomain>
 <ZGHOppBFcKEJkzCe@moria.home.lan>
 <20230515071343.GD15871@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515071343.GD15871@sol.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 12:13:43AM -0700, Eric Biggers wrote:
> Sure, given that this is an optimization problem with a very small scope
> (decoding 6 fields from a bitstream), I was hoping for something easier and
> faster to iterate on than setting up a full kernel + bcachefs test environment
> and reverse engineering 500 lines of shell script.  But sure, I can look into
> that when I have a chance.

If you were actually wanting to help, that repository is the tool I use
for kernel development and testing - it's got documentation.

It builds a kernel, boots a VM and runs a test in about 15 seconds, no
need for lifting that code out to userspace.

> > Your approach wasn't any faster than the existing C version.
> 
> Well, it's your implementation of what you thought was "my approach".  It
> doesn't quite match what I had suggested.  As I mentioned in my last email, it's
> also unclear that your new code is ever actually executed, since you made it
> conditional on all fields being byte-aligned...

Eric, I'm not an idiot, that was one of the first things I checked. No
unaligned bkey formats were generated in my tests.

The latest iteration of your approach that I looked at compiled to ~250
bytes of code, vs. ~50 bytes for the dynamically generated unpack
functions. I'm sure it's possible to shave a bit off with some more
work, but looking at the generated code it's clear it's not going to be
competitive.
