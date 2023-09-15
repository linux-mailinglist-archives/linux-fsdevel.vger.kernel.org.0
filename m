Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5467A2753
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjIOToH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjIOTnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:43:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA21FC9;
        Fri, 15 Sep 2023 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0azTSzwIO5wB3GjrjXO4srn8WzFckAJ3B02EBtBBaAM=; b=C9/rSjcoPUh83yvuYT6V9HdPDk
        6NZtX7sEyAlPQ+xzU2EUKDtgrkAYfJ/sDrJ0RRW3Hl7HCLdA/HGZcClVAs+2MrrcwQgSIVqPsqbHn
        kMypNEs/d22C3W1VJp9oSnmdUwXQ8l52qTb4no+CrXXKt4CqRj9uN4IrJ+ku5dsLYxilzy+t6bBtX
        hqcksK4ufOtltzXJepTD3NjIOc0KzbxzYmJPJbxJ5eL9HdOBJLGbnNPOzBgFHbz2G9OS7wRmuRSbs
        D/gBMKLBS1PjL4GRTudevFiq5/W0OkDwgT26S7PaRIZGwQsSKKHmm4A6MWvjR/4qz2uC+9zgoMDDP
        ZS85RvVA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhEiu-00Bfub-Ib; Fri, 15 Sep 2023 19:43:28 +0000
Date:   Fri, 15 Sep 2023 20:43:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 04/23] filemap: set the order of the index in
 page_cache_delete_batch()
Message-ID: <ZQSz4JttC/uTZwGw@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-5-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-5-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:29PM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Similar to page_cache_delete(), call xas_set_order for non-hugetlb pages
> while deleting an entry from the page cache.

Is this necessary?  As I read xas_store(), if you're storing NULL, it
will wipe out all sibling entries.  Was this based on "oops, no, it
doesn't" or "here is a gratuitous difference, change it"?

