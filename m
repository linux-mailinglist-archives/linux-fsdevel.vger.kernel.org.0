Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094A66BA55B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 03:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCOCxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 22:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCOCxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:53:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6894F28D35
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 19:53:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32F2r3nQ001093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 22:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678848785; bh=J2lVUPoIz1nGYzwa1ZCqgo7rhP2Z54xdTsDxHZ9Xm0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QpsvQ/84K+pIxR/1exfKLHzemZi3amvI/fa6gSHhrrkadMbAb28lsslazJta+N+AA
         S0p/3SWTJqqgDfcf6ZS+fJ0+3PmAMVNEF6qpz1jKRR2amESgOquw4/1h2Hjj4xqMFc
         80jRleWu1NNA0AZTtYa8hYA2w2kVV67gnwvyQ9NnX4ETbr5F2RKFbCPAdC8RODodmx
         3bgMGXHs5YsAA94Iiyr3ZP4+gxm67ZBxcaQOO/IA2JPNRoKZVck3AcBJy80OVmlENT
         FWlNVoluseG8ae44yc+MacIo3ha4c2bdEqPq4/q1Ext1ivia41nKndvAsh10lr2TNB
         PfJO6fgf+0SIw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2180E15C5830; Tue, 14 Mar 2023 22:53:02 -0400 (EDT)
Date:   Tue, 14 Mar 2023 22:53:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <20230315025302.GI860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
 <Y9P4MYXE9NcC8+gv@casper.infradead.org>
 <20230314220551.GQ860405@mit.edu>
 <ZBD/Z5Yvs0LavNms@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBD/Z5Yvs0LavNms@sol.localdomain>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:12:39PM -0700, Eric Biggers wrote:
> 
> I think large folio support for fscrypt and fsverity is not that far away.  I
> already made the following changes in 6.3:
> 
>     51e4e3153ebc ("fscrypt: support decrypting data from large folios")
>     5d0f0e57ed90 ("fsverity: support verifying data from large folios")

Cool!  I was thinking that fscrypt and fsverity might end up lagging
as far as the large folio support was concerned, but I'm glad that
this might not be the case.

> AFAICT, absent actual testing of course, the only major thing that's still
> needed is that fscrypt_encrypt_pagecache_blocks() needs to support large folios.
> I'm not sure how it should work, exactly.  Matthew gave a couple options.
> Another option is to just continue to use bounce *pages*, and keep track of all
> the bounce pages for each folio.

We don't have to solve that right away; it is possible to support
reads of large folios, but not writes.  If someone reads in a 128k
folio, and then modifies a 4k page in the middle of the page, we could
just split up the 128k folio and then writing out either the single 4k
page that was modified.  (It might very well be that in that case, we
*want* to break up the folio anyway, to avoid the write amplification
problem.)

In any case, I suspect that how we would support large folios for ext4
by first is to support using iomap for buffer I/O --- but only for
file systems where page size == block size, with no fscrypt, no
fsverity, no data=journal, and only for buffered reads.  And for
buffered writes, we'll break apart the folio and then use the existing
ext4_writepages() code path.

We can then gradually start relying on iomap and using large folios
for additional scenarios, both on the read and eventually, on the
write side.  I suspect we'll want to have a way of enabling and
disabling large folios on a fine-grained manner, as well has
potentially proactively breaking up large folios in page_mkwrite (so
that a 4k random page modification doesn't get amplified into the
entire contents of a large folio needing to be written back).

       		     	   	 	    - Ted
