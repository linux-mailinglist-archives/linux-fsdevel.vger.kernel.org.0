Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621C966676B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 01:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjALAKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 19:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjALAKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:10:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F81CCD;
        Wed, 11 Jan 2023 16:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E501ACE1BF8;
        Thu, 12 Jan 2023 00:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE26C433EF;
        Thu, 12 Jan 2023 00:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673482202;
        bh=ALlRTKFHlW5QwyqwTok5YQDFTDeZU3gE8aHLnXq2SLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARBLAiCnbk3/mI2Xo8WsmJSUNVIpJWFairpw2tWVM14BnkskWDa+SL4w1vzbDkivl
         xVL2Zm0PMu3AE8luQwnknvgOZjDgqdi7ea1bgdMvcmchoVDEu63TjG+nI3SKt7XA0M
         dj1K6h8YuHUE7ZxTwA5I1luiWp1TPFG2zVWW0CmhNeq7dbvStj0KIpS1rsgW/hT5j3
         X2zoKt7oEY6ehHGFg15z1i/XA5J9+cThFpH+sWyJVpcnaQ0JkcdcVlK56TUZq9a3vO
         lCC3RPg5c/UMebn/d/U9/TNogG6aX3RZcebjpgDhZyxhEIwmNvNg1qspDoTC0eUUKj
         BZCTCe+jff7sQ==
Date:   Wed, 11 Jan 2023 16:10:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 01/14] xfs: document the motivation for online fsck design
Message-ID: <Y79P2WpMhs/kAnt1@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825174.682859.4770282034026097725.stgit@magnolia>
 <0607e986e96def5ba17bd53ff3f7e775a99d3d94.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0607e986e96def5ba17bd53ff3f7e775a99d3d94.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 07, 2023 at 05:01:54AM +0000, Allison Henderson wrote:

<snip> There was one part of your reply that I wanted to handle
separately:

> Something that I've noticed in my training sessions is that often
> times, less is more.  People really only absorb so much over a
> particular duration of time, so sometimes having too much detail in the
> context is not as helpful as you might think.

I'm very worried about this ^^^ exact problem making it more difficult
to merge online fsck.

As the online fsck patchset grew and grew and grew, I decided that it
was absolutely necessary to write a design document to condense the
information from 1200 patches, for this is the diffstat for the code
changes themselves:

225 files changed, 41244 insertions(+), 4388 deletions(-)
205 files changed, 16802 insertions(+), 3405 deletions(-)
438 files changed, 20123 insertions(+), 446 deletions(-)

That's 78169 insertions and 8239 deletions, or about ~70k new LOC, and
that doesn't include the scrub code that's already upstream (~60000).
It's wild that online fsck is larger than the filesystem.

You might recall that I sent it out for review twice last year, and the
feedback I got from the experienced folk was that I needed to write in
much more detail about the design -- specifically, what I was doing with
the fs hooks, and all the data structures that I was layering atop tmpfs
files to support rebuilds.

Before I even got to /that/ point, the design documentation had reached
4500 lines (or 90 pages) long, at which point I decided that it was
necessary to write a summary to condense the 4500 lines down to a single
chapter.

Hence part 1 about what is a filesystem check.  It's supposed to
introduce the very very broad concepts to a reader before they dive into
successively higher levels of detail in the later parts.

My guess is that the audience for the code deluges and this design doc
fall into roughly these categories:

* Experienced people who have been around XFS and Linux for a very long
  time.  These people, I think, would benefit from scanning parts 2 and
  3 as a refresher.  Then they can scan parts 5 and 6 before moving on
  to the code.

* Intermediate people, who probably need to read parts 2 - 6 and
  understand them thoroughly before reading the code.  The case studies
  in part 5 should be used as a guide to the patchsets.

* People who have no idea what filesystems and fsck are, want to know
  about them, but don't have any pre-existing knowledge.

> A lot of times, paraphrasing excerpts to reflect the same info in a
> more compact format will help you keep audience on track (a little
> longer at least).

Yes, thank you for your help in spotting these kinds of problems.  I've
been too close to the code for years, which means I have severe myopia
about things like "Am I confusing everyone?". :/

Speaking of which, am I confusing everyone?

--D
