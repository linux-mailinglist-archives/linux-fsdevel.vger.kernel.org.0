Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9570C5383AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiE3Oi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbiE3OdL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 10:33:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E3136423
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OiY2rgRVZOqCidaxajNJLm4/9jAUCwIR4FPAxWy2Dkw=; b=CKyErjZFlP08nqv37BWO212Qxe
        PVg5/e1gISSY/X/5qshOtglb7m0BTOFeaZBjS+jiMuCYJ+umqqv0nGbwt1i+IeQI4V+l+RHWgdlz4
        AwAeA5R8VOy/kG6mVS9fpVGuapZVWvvUAcUOWBEBYdOjusfyA7bSOmErRoejdBu5u6qGg3jF5qLGl
        v3Z0nnygaaGS14GAZDFbUXM9ygDOjq1n+ThDO/9TS13H+UYOmgkS3AWzcir7oV4YRZk51X3ZSE27y
        /5ZnWLvUPY9KAq5L0N0R4b3pKfmIJCRUEvSmrvmCJn5lcqUaC36rmdlfuAcTDZgmwgZ3QlAj/CuIT
        ggo0H0AQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvfpj-004WKH-M8; Mon, 30 May 2022 13:53:23 +0000
Date:   Mon, 30 May 2022 14:53:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     manualinux@yahoo.es,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ntfs3: provide block_invalidate_folio to fix memory leak
Message-ID: <YpTMU0zutHgxPI45@casper.infradead.org>
References: <20220524113314.71fe17f0@yahoo.es>
 <20220525130538.38fd3d35@yahoo.es>
 <20220527072629.332b078d@yahoo.es>
 <20220527080211.15d631be@yahoo.es>
 <alpine.LRH.2.02.2205271338250.20527@file01.intranet.prod.int.rdu2.redhat.com>
 <20220528061836.22230f86@yahoo.es>
 <20220530131524.7fb5640d@yahoo.es>
 <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
 <YpS2EX+lHkqaxh0d@casper.infradead.org>
 <alpine.LRH.2.02.2205300830220.28067@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205300830220.28067@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 08:57:15AM -0400, Mikulas Patocka wrote:
> In the kernel 5.17 and before, if the "invalidatepage" method is NULL, the 
> kernel will use block_invalidatepage (see do_invalidatepage). So, we don't 
> have to provide explicit "invalidatepage" in 5.17 and before and we don't 
> have to backport this bugfix there.
> 
> Note that the commit 7ba13abbd31e contains this piece of code:
> -#ifdef CONFIG_BLOCK
> -	if (!invalidatepage)
> -		invalidatepage = block_invalidatepage;
> -#endif
> 
> So, it explicitly breaks filesystems that have NULL invalidatepage and 
> NULL invalidate_folio and that relied on block_invalidatepage being called 
> implicitly. So, I believe this commit is the root cause of this bug.

Oh, right, I missed ntfs3 in that commit.  Oops.

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

