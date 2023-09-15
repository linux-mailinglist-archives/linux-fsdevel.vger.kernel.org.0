Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD417A2489
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjIORUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjIORUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:20:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FA2709;
        Fri, 15 Sep 2023 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BIb7Fd8PNS8g64wJ6WvlCHk7CZEDWMMUD4WYiGWzQwE=; b=FsepcEq4tz7169aMZLao5tnyOz
        PylzKgX5Xi62iLy63EWxnHz+HN4N/Uad8TScWYY9P+2II1bBTESM/svJN/iLt/8LUNAGPNKcqCEXC
        NYGKO6TcKP/7GMiQ7z5sBT3y3snZ7P1SN/u8oBAcczRKXz1CM6M7pc/owm6DD0wFdaxD9BdUELhDd
        Ypc4LzguqZ5MqeRPpLw27JKUaDgoiHZy+CAFwt0SnlXXCVYS+OqtVV16ihpG4cGDlK51b6BfKwWrN
        3iG/RiDDTKH5JbpD2dcRDTrPFut36ytTIsdM7MejE/7AnnpZoMldWfou+XM7aDy8EhNMmSoYzaZyI
        23wM28SA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhCST-00B0EC-44; Fri, 15 Sep 2023 17:18:21 +0000
Date:   Fri, 15 Sep 2023 18:18:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] proc: nommu: fix empty /proc/<pid>/maps
Message-ID: <ZQSR3W9WKBbs5JSr@casper.infradead.org>
References: <20230915160055.971059-2-ben.wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915160055.971059-2-ben.wolsieffer@hefring.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 12:00:56PM -0400, Ben Wolsieffer wrote:
> On no-MMU, /proc/<pid>/maps reads as an empty file. This happens because
> find_vma(mm, 0) always returns NULL (assuming no vma actually contains
> the zero address, which is normally the case).

Your patch is correct, but this is a deeper problem.  find_vma() on
MMU architectures returns the first VMA which is >= addr.

 * Returns: The VMA associated with addr, or the next VMA.
 * May return %NULL in the case of no VMA at addr or above.

But that's not how find_vma() behaves on nommu!  And I'd be tempted to
blame the maple tree conversion, but this is how it looked before the
maple tree:

-       /* trawl the list (there may be multiple mappings in which addr
-        * resides) */
-       for (vma = mm->mmap; vma; vma = vma->vm_next) {
-               if (vma->vm_start > addr)
-                       return NULL;
-               if (vma->vm_end > addr) {
-                       vmacache_update(addr, vma);
-                       return vma;
-               }
-       }

So calling find_vma(0) always returned NULL.  Unless there was a VMA
at 0, which there probably wasn't.

Why does nommu behave differently?  Dave, you introduced it back in 2005
(yes, I had to go to the git history tree for this one)

