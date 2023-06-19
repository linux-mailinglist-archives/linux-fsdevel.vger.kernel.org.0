Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE1735731
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjFSMr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFSMr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:47:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CA31113;
        Mon, 19 Jun 2023 05:47:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E311112FC;
        Mon, 19 Jun 2023 05:48:08 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FF033F64C;
        Mon, 19 Jun 2023 05:47:23 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:47:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619104717.3jvy77y3quou46u3@moria.home.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 06:47:17AM -0400, Kent Overstreet wrote:
> On Mon, Jun 19, 2023 at 10:19:00AM +0100, Mark Rutland wrote:
> > On Tue, May 09, 2023 at 12:56:32PM -0400, Kent Overstreet wrote:
> > > From: Kent Overstreet <kent.overstreet@gmail.com>
> > > 
> > > This is needed for bcachefs, which dynamically generates per-btree node
> > > unpack functions.
> > 
> > Much like Kees and Andy, I have concerns with adding new code generators to the
> > kernel. Even ignoring the actual code generation, there are a bunch of subtle
> > ordering/maintenance/synchronization concerns across architectures, and we
> > already have a fair amount of pain with the existing cases.
> 
> Look, jits are just not that unusual. I'm not going to be responding to
> vague concerns that don't have any actual engineering rational.

Sorry, but I do have an engineering rationale here: I want to make sure that
this actually works, on architectures that I care about, and will be
maintanable long-term.

We've had a bunch of problems with other JITs ranging from JIT-local "we got
the encoding wrong" to major kernel infrastructure changes like tasks RCU rude
synchronization. I'm trying to figure out whether any of those are likely to
apply and/or whether we should be refactoring other infrastructure for use here
(e.g. the factoring the acutal instruction generation from arch code, or
perhaps reusing eBPF so this can be arch-neutral).

I appreciate that's not clear from my initial mail, but please don't jump
straight to assuming I'm adversarial here.

> > Can you share more detail on how you want to use this?
> > 
> > From a quick scan of your gitweb for the bcachefs-for-upstream branch I
> > couldn't spot the relevant patches.
> 
> I've already written extensively in this thread.

Sorry, I hadn't seen that.

For the benefit of others, the codegen is at:

  https://lore.kernel.org/lkml/ZFq7JhrhyrMTNfd%2F@moria.home.lan/
  https://evilpiepirate.org/git/bcachefs.git/tree/fs/bcachefs/bkey.c#n727

... and the rationale is at:

  https://lore.kernel.org/lkml/ZF6HHRDeUWLNtuL7@moria.home.lan/

One thing I note mmediately is that HAVE_BCACHEFS_COMPILED_UNPACK seems to be
x86-only. If this is important, that'll need some rework to either be
arch-neutral or allow for arch-specific implementations.

Thanks,
Mark.
