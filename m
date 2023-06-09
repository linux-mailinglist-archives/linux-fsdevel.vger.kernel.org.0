Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47572A633
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jun 2023 00:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjFIWRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFIWRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:17:06 -0400
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70E358E
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 15:17:05 -0700 (PDT)
Date:   Fri, 9 Jun 2023 18:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686349024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/faff7ciPHrXU0YBTRHO8FDbb7z7LJWbx1HGgXc9hBU=;
        b=RpHGergUpf/+bfzqxiqGg09d3NTtvQ/5VYyDDvFw8Uclq3TYaxMOnvejEyGFmcqox0TivQ
        vNwd1aG+TIDghbz9wY+u+I3no4Z1iUy50SHNh6RM/8MEXIrtR9eEPmdUZtclxp56reKgVQ
        4/ZfgQ9fACNYVv3cFM49ySAhAE0Ed1M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
Message-ID: <ZIOk3ANoGxkcl+u7@moria.home.lan>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com>
 <ZHUcmeYrUmtytdDU@moria.home.lan>
 <alpine.LRH.2.21.2305300809350.13307@file01.intranet.prod.int.rdu2.redhat.com>
 <ZHaGvAvFB3wWPY17@moria.home.lan>
 <e0ad5e2c-48d0-0fe-a2d3-afcfa5f51d1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ad5e2c-48d0-0fe-a2d3-afcfa5f51d1e@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:57:27PM +0200, Mikulas Patocka wrote:
> 
> 
> On Tue, 30 May 2023, Kent Overstreet wrote:
> 
> > On Tue, May 30, 2023 at 05:00:39PM -0400, Mikulas Patocka wrote:
> > > I'd like to know how do you want to do coverage analysis? By instrumenting 
> > > each branch and creating a test case that tests that the branch goes both 
> > > ways?
> > 
> > Documentation/dev-tools/gcov.rst. The compiler instruments each branch
> > and then the results are available in debugfs, then the lcov tool
> > produces annotated source code as html output.
> > 
> > > I know that people who write spacecraft-grade software do such tests, but 
> > > I can't quite imagine how would that work in a filesystem.
> > > 
> > > "grep -w if fs/bcachefs/*.[ch] | wc -l" shows that there are 5828 
> > > conditions. That's one condition for every 15.5 lines.
> > 
> > Most of which are covered by existing tests - but by running the
> > existing tests with code coverage analylis we can see which branches the
> > tests aren't hitting, and then we add fault injection points for those.
> > 
> > With fault injection we can improve test coverage a lot without needing
> > to write any new tests (or simple ones, for e.g. init/mount errors) 
> 
> I compiled the kernel with gcov, I ran "xfstests-dev" on bcachefs and gcov 
> shows that there is 56% coverage on "fs/bcachefs/*.o".

Nice :) I haven't personally looked at the gcov output in ages, you
might motivate me to see if I can get the kbuild issue for ktest
integration sorted out.

Just running xfstests won't exercise a lot of the code though - our own
tests are written as ktest tests, and those exercise e.g. multiple
devices (regular raid mode, tiering, erasure coding),
subvolumes/snapshots, all the compression/checksumming/encryption modes,
etc.

No doubt our test coverage will still need improving :)

> So, we have 2564 "if" branches (of total 5828) that were not tested. What 
> are you going to do about them? Will you create a filesystem image for 
> each branch that triggers it? Or, will you add 2564 fault-injection points 
> to the source code?

Fault injection points will be the first thing to look at, as well as
any chunks of code that just have missing tests.

We won't have to manually add individual fault injection points in every
case: once code tagging and dynamic fault injection go in, that will
give us distinct fault injection points for every memory allocation, and
then it's a simple matter to enable a 1% failure rate for all memory
allocations in the bcachefs module - we'll do this in
bcachefs_antagonist in ktest/tests/bcachefs/bcachefs-test-libs, which
runs after mounting.

Similarly, we'll also want to add fault injection for transaction
restart points.

Fault injection is just the first, easiest thing I want people looking
at, it won't be the best tool for the job in all situations. Darrick's
also done cool stuff with injecting filesystem errors into the on disk
image - he's got a tool that can select which individual field to
corrupt - and I want to copy that idea. Our kill_btree_node test (in
single_device.ktest) is some very initial work along those lines, we'll
want to extend that.

And we will definitely want to still be testing with dm-flakey because
no doubt those techniques won't catch everything :)

> It seems like extreme amount of work.

It is a fair amount of work - but it's a more focused kind of work, with
a benchmark to look at to know when we're done. In practice, nobody but
perhaps automotive & aerospace attains full 100% branch coverage. People
generally aim for 80%, and with good, easy to use fault injection I'm
hoping we'll be able to hit 90%.

IIRC when we were working on the predecessor to bcachefs and had fault
injection available, we were hitting 85-88% code coverage. Granted the
codebase was _much_ smaller back then, but it's still not a crazy
unattainable goal.
