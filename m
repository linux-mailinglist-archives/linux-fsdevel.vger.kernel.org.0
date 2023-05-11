Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEED6FEB5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 07:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjEKFov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjEKFoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 01:44:25 -0400
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [91.218.175.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1724ED1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 22:44:22 -0700 (PDT)
Date:   Thu, 11 May 2023 01:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683783860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iOiMX6sv+DQehmZI33b0k3P+A/HtVxXVvqqZmBD72U=;
        b=hmSs4gLAmdr54kJa3buCPbG6CRX+mFcsgPHVdenXCmFW9gT1U5PdBV86nHo8lf/4IJnIrh
        WHSvFxFv4OLHOHo80TvgsemT19uXyTS5gEpd3uozGpUwxCGRaoAjaiC5wTrDlhVlvgXIkf
        hGRuujciGhX4BV9JZLntpLgf5lziWFQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZFyAr/9L3neIWpF8@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <20230509214319.GA858791@frogsfrogsfrogs>
 <ZFrBEsjrfseCUzqV@moria.home.lan>
 <ZFx+GOjabJIaJWU8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFx+GOjabJIaJWU8@mit.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 11, 2023 at 01:33:12AM -0400, Theodore Ts'o wrote:
> Seriously, does this mean that bcachefs won't work on Arm systems
> (arm32 or arm64)?  Or Risc V systems?  Or S/390's?  Or Power
> architectuers?  Or Itanium or PA-RISC systems?  (OK, I really don't
> care all that much about those last two.  :-)

No :)

My CI servers are arm64 servers. There's a bch2_bkey_unpack_key()
written in C, that works on any architecture. But specializing for a
particular format is a not-insignificant performance improvement, so
writing an arm64 version has been on my todo list.

> When people ask me why file systems are so hard to make enterprise
> ready, I tell them to recall the general advice given to people to
> write secure, robust systems: (a) avoid premature optimization, (b)
> avoid fine-grained, multi-threaded programming, as much as possible,
> because locking bugs are a b*tch, and (c) avoid unnecessary global
> state as much as possible.
> 
> File systems tend to violate all of these precepts: (a) people chase
> benchmark optimizations to the exclusion of all else, because people
> have an unhealthy obsession with Phornix benchmark articles, (b) file
> systems tend to be inherently multi-threaded, with lots of locks, and
> (c) file systems are all about managing global state in the form of
> files, directories, etc.
> 
> However, hiding a miniature architecture-specific compiler inside a
> file system seems to be a rather blatent example of "premature
> optimization".

Ted, this project is _15_ years old.

I'm getting ready to write a full explanation of what this is for and
why it's important, I've just been busy with the conference - and I want
to write something good, that provides all the context.

I've also been mulling over fallback options, but I don't see any good
ones. The unspecialized, C version of unpack has branches (the absolute
minimum, I took my time when I was writing that code too); the
specialized versions are branchless and _much_ smaller, and the only way
to do that specialization is with some form of dynamic codegen.

But I do owe you all a detailed walkthrough of what this is all about,
so you'll get it in the next day or so.

Cheers,
Kent
