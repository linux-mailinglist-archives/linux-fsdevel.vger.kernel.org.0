Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4613D52569E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358455AbiELUzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358452AbiELUzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 16:55:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823964BED
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YA1cDGpFFJSqloLayCUCKn0nstXcZ43lg1pMoX0HvTk=; b=KBVkmD5ngM2fMHixgZw6aS95Ai
        mRAbSGZ0a5/p/blPr2WVPfy2DZ1vf5fqdbyquLfuDoWwOKF83C4In8GE+aSu9ckGwoEsp/T2+UqJ2
        DYhprPMDyCz+n7kLLERjv85H9CQtmLE/Sf9Nam+Wwj3sYruLDzw+ixFwFkv0naXQP16OnZJFnY4iB
        ZZfwSThC6JV/SzbbNfEHRAJcwIiI/dbFxNyPzSrA3DdKhmepa/2L89Qlk2UjhHf6WzcfwH+MaBnkH
        5Z7t/5q6qGlRiDcEKPsNNLgaFL1t03z2re6+Ctxl3KZxVvFOOKzkH6tCagH/T/W5OY7VQbspG3MDj
        Udu8SSmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npFpr-006jx0-FJ; Thu, 12 May 2022 20:54:59 +0000
Date:   Thu, 12 May 2022 21:54:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Freeing page flags
Message-ID: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The LWN writeup [1] on merging the MGLRU reminded me that I need to send
out a plan for removing page flags that we can do without.

1. PG_error.  It's basically useless.  If the page was read successfully,
PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
doesn't use PG_error.  Some filesystems do, and we need to transition
them away from using it.

2. PG_private.  This tells us whether we have anything stored at
page->private.  We can just check if page->private is NULL or not.
No need to have this extra bit.  Again, there may be some filesystems
that are a bit wonky here, but I'm sure they're fixable.

3. PG_mappedtodisk.  This is really only used by the buffer cache.
Once the filesystems that use bufferheads have been converted, this can
go away.

4. I think I can also consolidate PG_slab and PG_reserved into a "single
bit" (not really, but change the encoding so that effectively they only
take a single bit).

That gives us 4 bits back, which should relieve the pressure on page flag
bits for a while.  I have Thoughts on PG_private_2 and PG_owner_priv_1,
as well as a suspicion that not all combinations of referenced, lru,
active, workingset, reclaim and unevictable are possible, and there
might be scope for a better encoding.  But I don't know that we need to
do that work; gaining back 4 bits is already a Big Deal.

I'm slowly doing the PG_private transition as part of the folio work.
For example, eagle eyed reviewers may have spotted that there is no
folio_has_buffers().  Converted code calls folio_buffers() and checks
if it's NULL.  Help from filesystem maintainers on removing the uses of
PG_error gratefully appreciated.

[1] https://lwn.net/Articles/894859/
