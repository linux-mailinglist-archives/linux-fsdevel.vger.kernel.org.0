Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3A6A982A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 14:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCCNL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 08:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCCNL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:11:58 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99A93F7;
        Fri,  3 Mar 2023 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677849112;
        bh=hr2srA7lr1NS/bcOuwoy15lE9j7MbrTWwn/RCZPWv0o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f1Pdx1vzcijeNa0004rr3e9cC1SjXfOWCFM+NrWJGrr/TWHQ+3B49wbGzwv6Udf40
         CxF6io8nWu/84nFNe/89vnDHQreJehCaxJd/gvEzK2WXET7NW/0JH4ZjuSs9eIrzyf
         aYqH9XtLmM1PUmqrdGYZfaFLzEDHpHFUHYcdGvtc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EFFB212860A2;
        Fri,  3 Mar 2023 08:11:52 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h_qcRum7Wm9d; Fri,  3 Mar 2023 08:11:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677849111;
        bh=hr2srA7lr1NS/bcOuwoy15lE9j7MbrTWwn/RCZPWv0o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Gr1jV7AuEfHPRgmsMNt1lw07RRz25rhs0sLbhYiOU/KoJypM3unmCLMeCNKkqWgXJ
         elpVW6j/eU4OARWHw58u709qNvR+D8RPFahxs06foKJ/0HWQENbFBrv7gB20K9vze9
         WUj6f27ybv5mwJs+1Z2/LCXn1vHuKWU9VatnZlu8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D8DB31285ED5;
        Fri,  3 Mar 2023 08:11:50 -0500 (EST)
Message-ID: <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Fri, 03 Mar 2023 08:11:47 -0500
In-Reply-To: <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
         <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
         <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-03-03 at 03:49 +0000, Matthew Wilcox wrote:
> On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> > That said, I was hoping you were going to suggest supporting 16k
> > logical block sizes. Not a problem on some arch's, but still
> > problematic when PAGE_SIZE is 4k. :)
> 
> I was hoping Luis was going to propose a session on LBA size >
> PAGE_SIZE. Funnily, while the pressure is coming from the storage
> vendors, I don't think there's any work to be done in the storage
> layers.  It's purely a FS+MM problem.

Heh, I can do the fools rush in bit, especially if what we're
interested in the minimum it would take to support this ...

The FS problem could be solved simply by saying FS block size must
equal device block size, then it becomes purely a MM issue.  The MM
issue could be solved by adding a page order attribute to struct
address_space and insisting that pagecache/filemap functions in
mm/filemap.c all have to operate on objects that are an integer
multiple of the address space order.  The base allocator is
filemap_alloc_folio, which already has an apparently always zero order
parameter (hmmm...) and it always seems to be called from sites that
have the address_space, so it could simply be modified to always
operate at the address_space order.

The above would be a bit suboptimal in that blocks are always mapped to
physically contiguous pages, but it should be enough to get the concept
working.

James

