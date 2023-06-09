Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141BD72A509
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjFIU6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFIU6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EFA35A2
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686344250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRWAxWtLa8sVDkpC/yUUut28G8oap18QNpE8UHzdaio=;
        b=SrDJyUY6amUIZdaiqGVttFvhf1pvaTAGEU/lquj8RWRkcDHx3CTsOV6uxl8bhy9ov8l4rx
        3nCWcRz8z4uSyPKy6JyH1K6hbJ78X3GXiwjvyRKoKxQ+0Ez7j4VvcS/GsI110l4HQizsx2
        Oqt2DHqALoVbG/+h3HyHiLE+W2mpjxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-7pvheUS7NMenBLh1B5L8AQ-1; Fri, 09 Jun 2023 16:57:28 -0400
X-MC-Unique: 7pvheUS7NMenBLh1B5L8AQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8BBA101B04E;
        Fri,  9 Jun 2023 20:57:27 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1AF7492B0B;
        Fri,  9 Jun 2023 20:57:27 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id ACFC030C0502; Fri,  9 Jun 2023 20:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A9E133F7CF;
        Fri,  9 Jun 2023 22:57:27 +0200 (CEST)
Date:   Fri, 9 Jun 2023 22:57:27 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
cc:     linux-bcachefs@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: fuzzing bcachefs with dm-flakey
In-Reply-To: <ZHaGvAvFB3wWPY17@moria.home.lan>
Message-ID: <e0ad5e2c-48d0-0fe-a2d3-afcfa5f51d1e@redhat.com>
References: <alpine.LRH.2.21.2305260915400.12513@file01.intranet.prod.int.rdu2.redhat.com> <ZHUcmeYrUmtytdDU@moria.home.lan> <alpine.LRH.2.21.2305300809350.13307@file01.intranet.prod.int.rdu2.redhat.com> <ZHaGvAvFB3wWPY17@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 30 May 2023, Kent Overstreet wrote:

> On Tue, May 30, 2023 at 05:00:39PM -0400, Mikulas Patocka wrote:
> > I'd like to know how do you want to do coverage analysis? By instrumenting 
> > each branch and creating a test case that tests that the branch goes both 
> > ways?
> 
> Documentation/dev-tools/gcov.rst. The compiler instruments each branch
> and then the results are available in debugfs, then the lcov tool
> produces annotated source code as html output.
> 
> > I know that people who write spacecraft-grade software do such tests, but 
> > I can't quite imagine how would that work in a filesystem.
> > 
> > "grep -w if fs/bcachefs/*.[ch] | wc -l" shows that there are 5828 
> > conditions. That's one condition for every 15.5 lines.
> 
> Most of which are covered by existing tests - but by running the
> existing tests with code coverage analylis we can see which branches the
> tests aren't hitting, and then we add fault injection points for those.
> 
> With fault injection we can improve test coverage a lot without needing
> to write any new tests (or simple ones, for e.g. init/mount errors) 

I compiled the kernel with gcov, I ran "xfstests-dev" on bcachefs and gcov 
shows that there is 56% coverage on "fs/bcachefs/*.o".

So, we have 2564 "if" branches (of total 5828) that were not tested. What 
are you going to do about them? Will you create a filesystem image for 
each branch that triggers it? Or, will you add 2564 fault-injection points 
to the source code?

It seems like extreme amount of work.

Mikulas

