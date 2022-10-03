Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E45F39E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJCXh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJCXhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:37:24 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB43AB16;
        Mon,  3 Oct 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QaXhKfiYb2wJS1cY8/i43OfjDz29G/pG08gdTRtzOvY=; b=Ya1R14PzsJf4UAzejQPot5jf68
        Guea09dRURyQZwSWLqVaBddRpqh+b0OYZADH+u9t91s21U6uzjdsG9hIusf6+yKM+LsFHMj7vs1YD
        qPhimBkoqG/udxerNZl/gWoyF9yNNKkQgiskgQrhLfzXCvIR/N55sfunr9NZlJ98O6VyBLoeTcHz3
        C/ZDOJqu6+d7V+P2DWDOJ2kurAuo0EgM9EsMShYLsR680uPBv/pGNmte9Wmkwww8+2k8znJai+sqq
        Ugrhh4AJ9U0Mr3eA81mxbtO+dYYsnqtxEBkAHljAdNKf/FGcYjLLW6KTh3SZrMUrc94rCXfHqee0p
        oW3ozh9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ofUzs-006ePP-31;
        Mon, 03 Oct 2022 23:37:17 +0000
Date:   Tue, 4 Oct 2022 00:37:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YztyLFZJKKTWcMdO@ZenIV>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
 <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV>
 <4011.1664837894@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4011.1664837894@jrobl>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:58:14AM +0900, J. R. Okajima wrote:
> Al Viro:
> > Argh....  Try this:
> >
> > fix coredump breakage caused by badly tested "[coredump] don't use __kernel_write() on kmap_local_page()"
> 
> Thanx, it passed my local test.
> 
> 
> > * fix for problem that occurs on rather uncommon setups (and hadn't
> > been observed in the wild) sent very late in the cycle.
> 
> If the commit was merged in RC versions, I guess someone found the
> problem earlier.

Most likely - the breakage is really not hard to trigger ;-/

	Linus, which way would you prefer to handle that?  It's
a brown paperbag stuff - the worst I had in quite a while.
Mea maxima culpa ;-/

One variant would be to revert the original patch, put its
(hopefully) fixed variant into -next and let it sit there for
a while.  Another is to put this incremental into -next and
merge it into mainline once it gets a sane amount of testing.

	Up to you...
