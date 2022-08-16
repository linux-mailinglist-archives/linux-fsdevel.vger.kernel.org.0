Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74463596486
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 23:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiHPVUf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 17:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiHPVUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:20:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E08605B
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8eJL/aS1ZwOvGBE4cawP4RIM21qXx0crCgcCX0J5isQ=; b=JeAZyw7ja03C8ABS/ZDPmhiwq0
        luxhkuCw+P9Rv0WreAX2aHitVaHm1vAZ7+9PycXjZpysMlazK5zpQItFt9jcbqig+dEj1t9mzQ595
        j7bvh1bzar0QRbzkyFgNX8eWnkkW0EoOFO0Tio0ek95ly0h7vmMR63as1249dksKuc/ECd7f92E9D
        2QZm/aF0wD9s9qqE4MxSVlBggHVeq5xsuWKyIphTpLeXkG9XrJ2fSTmNjUaGsP2VgnPCJaaBPY1le
        +3cS6g/SaiRTNICZdc6sCzPIfVm7HlCiWZPtxigEu+Cv2qs/eiXV4qcIjI8RlRgbMcL0a5HfiaGCD
        eQ0z/9YQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO3yz-007O5j-TL; Tue, 16 Aug 2022 21:20:17 +0000
Date:   Tue, 16 Aug 2022 22:20:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Switching to iterate_shared
Message-ID: <YvwKEfNch6iu787x@casper.infradead.org>
References: <YvvBs+7YUcrzwV1a@ZenIV>
 <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org>
 <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816201438.66v4ilot5gvnhdwj@cs.cmu.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:14:38PM -0400, Jan Harkes wrote:
> On Tue, Aug 16, 2022 at 03:35:46PM -0400, Matthew Wilcox wrote:
> > fs/coda/dir.c:  .iterate        = coda_readdir,
> > 
> > Would anyone notice if we broke CODA?  Maintainers cc'd anyway.
> 
> Ha, yes I think I would notice, but probably not until after the changes
> got released and trickled down to the distributions ;)

I'm sorry about that.  I got confused with Intermezzo, which we already
deleted in 2004.

> So good to know in advance a change like this is coming. I'll have to
> educate myself on this shared vs non-shared filldir.

From Documentation/filesystems/porting.rst:

->iterate_shared() is added; it's a parallel variant of ->iterate().
Exclusion on struct file level is still provided (as well as that
between it and lseek on the same struct file), but if your directory
has been opened several times, you can get these called in parallel.
Exclusion between that method and all directory-modifying ones is
still provided, of course.

Often enough ->iterate() can serve as ->iterate_shared() without any
changes - it is a read-only operation, after all.  If you have any
per-inode or per-dentry in-core data structures modified by ->iterate(),
you might need something to serialize the access to them.  If you
do dcache pre-seeding, you'll need to switch to d_alloc_parallel() for
that; look for in-tree examples.

Old method is only used if the new one is absent; eventually it will
be removed.  Switch while you still can; the old one won't stay.

---

That's probably the best documentation we have about it.
