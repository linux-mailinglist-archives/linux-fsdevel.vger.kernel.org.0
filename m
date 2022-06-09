Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6A545524
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 21:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiFITpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiFITpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:45:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20581258720
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X4Y858EGq63eoeluNm6a0wwORAZoEK4lu6mc5VqMk/o=; b=ef5EY5gKdGb9uf7Iq6breT44Kp
        ZEQuy/2Ou7MyNYabWZReqiz1a5srWAGN9JFC2nWnGLYg+N7qdV9VaoMxNO9rYybPhmeQ0NqYo05Wh
        Fceju/ctXgxzzrF88zsMobsogP82s9C7Qv13jekH0ffFHgBIRBzaNv4sikKO7w6rjM/Gp2qarjrUw
        vyd1R+7mzg2ASxYnrpOi6BjjOwUnzDtaqxJCZjxbyqV2yuvqtovPJW371zb4Sj5zoxwOAAqi9AB0D
        HwWYa2OAwX+wx5Qpb7ANlJzNTabaQEF0jLGdKcyIYxAYwpexMzPiJvejOfxHWd3vMT5Dksi46ciNo
        C7fryUYg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzO5g-005YTg-8F; Thu, 09 Jun 2022 19:45:12 +0000
Date:   Thu, 9 Jun 2022 19:45:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <YqJNyBxXypd6JNFq@zeniv-ca.linux.org.uk>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
 <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
 <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 09, 2022 at 09:10:04PM +0200, Sedat Dilek wrote:

> > So Mel gave me the idea to simply measure how fast the function becomes.
> > ...
> 
> My SandyBridge-CPU has no FSRM feature, so I'm unsure if I really
> benefit from your changes.

What does it have to do with FSRM?

> My test-cases:
> 
> 1. LC_ALL=C dd if=/dev/zero of=/dev/null bs=1M count=1M status=progress
> 
> 2. perf bench mem memcpy (with Debian's perf v5.18 and a selfmade v5.19-rc1)
> 
> First test-case shows no measurable/noticable differences.

No surprise - you hit read() once and write() once per 1Mb worth of clear_user().
If overhead in new_sync_{read,write}() had been _that_ large, the things would've
really sucked.

> The 2nd one I ran for the first time with your changes and did not
> compare with a kernel without them.

????

How could _any_ changes in that series have any impact whatsoever on memcpy()
performance?  Hell, just look at diffstat - nothing in there goes anywhere
near the stuff involved in that test.  Nothing whatsoever in arch/x86; no
changes in lib/ outside of lib/iov_iter.c, etc.

What it does deal with is the overhead of the glue that leads to ->read_iter()
and ->write_iter(), as well as overhead of copy_to_iter()/copy_from_iter()
that becomes noticable on fairly short reads and writes.  It doesn't (and cannot)
do anything for the stuff dominated by the time spent in raw_copy_to_user() or
raw_copy_from_user() - the code responsible for actual copying data between
the kernel and userland memory is completely unaffected by any of that.
