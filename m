Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD06716F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 23:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjE3VBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjE3VBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 17:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3599
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685480444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cp30+9V5tdaydKDJszS2Neag0z6DAVVA+CZQ7skAvSo=;
        b=EKHZCNen4bYloCy0rWqeMHOCyHuXPE4pIVw+caDugDTb0OqkjAEUR4AsQIrzKweLSvXzt8
        GUhyPqwahGFihLjRCCZduHkBfoI59aYVsd5hr8wOP6InTijNSW24GSAvuGOX1oh8M27OW4
        cASdE18qmiWOTGuRegrxt8H3R6brZcA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-AKerYhTON2iK5nOXcU1vow-1; Tue, 30 May 2023 17:00:40 -0400
X-MC-Unique: AKerYhTON2iK5nOXcU1vow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D418027F5;
        Tue, 30 May 2023 21:00:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E1640C1437;
        Tue, 30 May 2023 21:00:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 34UL0d5h028698;
        Tue, 30 May 2023 17:00:39 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 34UL0dCe028695;
        Tue, 30 May 2023 17:00:39 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 May 2023 17:00:39 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
In-Reply-To: <ZHUcmeYrUmtytdDU@moria.home.lan>
Message-ID: <alpine.LRH.2.21.2305300809350.13307@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com> <ZHUcmeYrUmtytdDU@moria.home.lan>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 29 May 2023, Kent Overstreet wrote:

> On Mon, May 29, 2023 at 04:59:40PM -0400, Mikulas Patocka wrote:
> > Hi
> > 
> > I improved the dm-flakey device mapper target, so that it can do random 
> > corruption of read and write bios - I uploaded it here: 
> > https://people.redhat.com/~mpatocka/testcases/bcachefs/dm-flakey.c
> > 
> > I set up dm-flakey, so that it corrupts 10% of read bios and 10% of write 
> > bios with this command:
> > dmsetup create flakey --table "0 `blockdev --getsize /dev/ram0` flakey /dev/ram0 0 0 1 4 random_write_corrupt 100000000 random_read_corrupt 100000000"
> 
> I've got some existing ktest tests for error injection:
> https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest#n200
> https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/replication.ktest#n491
> 
> I haven't looked at dm-flakey before, I take it you're silently
> corrupting data instead of just failing the IOs like these tests do?

Yes, silently corrupting.

When I tried to simulate I/O errors with dm-flakey, bcachefs worked 
correcly - there were no errors returned to userspace and no crashes.

Perhaps, it should treat metadata checksum errors in the same way as disk 
failures?

> Let's add what you're doing to ktest, and see if we can merge it with
> the existing tests.

> Good catches on all of them. Darrick's been on me to get fuzz testing
> going, looks like it's definitely needed :)
> 
> However, there's two things I want in place first before I put much
> effort into fuzz testing:
> 
>  - Code coverage analysis. ktest used to have integrated code coverage
>    analysis, where you'd tell it a subdirectory of the kernel tree
>    (doing code coverage analysis for the entire kernel is impossibly
>    slow) and it would run tests and then give you the lcov output.
> 
>    However, several years ago something about kbuild changed, and the
>    method ktest was using for passing in build flags for a specific
>    subdir on the command line stopped working. I would like to track
>    down someone who understands kbuild and get this working again.
> 
>  - Fault injection
> 
>    Years and years ago, when I was still at Google and this was just
>    bcache, we had fault injection that worked like dynamic debug: you
>    could call dynamic_fault("type of fault") anywhere in your code,
>    and it returned a bool indicating whether that fault had been enabled
>    - and faults were controllable at runtime via debugfs, we had tests
>    that iterated over e.g. faults in the initialization path, or memory
>    allocation failures, and flipped them on one by one and ran
>    $test_workload.
> 
>    The memory allocation profiling stuff that Suren and I have been
>    working on includes code tagging, which is for (among other things) a
>    new and simplified implementation of dynamic fault injection, which
>    I'm going to push forward again once the memory allocation profiling
>    stuff gets merged.
> 
> The reason I want this stuff is because fuzz testing tends to be a
> heavyweight, scattershot approach.
> 
> I want to be able to look at the code coverage analysis first to e.g.
> work on a chunk of code at a time and make sure it's tested thoroughly,
> instead of jumping around in the code at random depending on what fuzz
> testing finds, and when we are fuzz testing I want to be able to add
> fault injection points and write unit tests so that we can have much
> more targeted, quicker to run tests going forward.
> 
> Can I get you interested in either of those things? I'd really love to
> find someone to hand off or collaborate with on the fault injection
> stuff in particular.

I'd like to know how do you want to do coverage analysis? By instrumenting 
each branch and creating a test case that tests that the branch goes both 
ways?

I know that people who write spacecraft-grade software do such tests, but 
I can't quite imagine how would that work in a filesystem.

"grep -w if fs/bcachefs/*.[ch] | wc -l" shows that there are 5828 
conditions. That's one condition for every 15.5 lines.

Mikulas

