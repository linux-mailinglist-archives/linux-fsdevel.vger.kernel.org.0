Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D553444BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCVNFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhCVNED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:04:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AFBC061756;
        Mon, 22 Mar 2021 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0JBjeWyjhSFrKTKJO4lwg4PnWP3NbPeMlvDqUV3159w=; b=HeYsUbcmAYNz575uDB1kdZw8+G
        0OUFPH/q99s3mFwZM/wKTbsbbMGE9K3gE/uue/WEtux2YchdR7ZPjQ/BxkMFe2L5IP7Hogv8P2PXH
        KwFceNsqE0J/TQNvJLHXcZPE51SWua8qgu+K381d4hGYdIAOILPDGZY2d67vdaqdju8eUwfWc5TNY
        DfPe+zQMVCF1wkxcaDfTF6H8IHLEUUi+7ikk+3/KBhTlfsxlmdowf5Px3G4Adlnwe+oXshiMmwZRZ
        XNkYnT/TgPe4jTYxmJbBVcIpPsGAowuHJwUVwkYoeNOBSRlYWDjCf9F5Cc3GQS8N24wbz7BczLliI
        l0yiWqQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOKCg-008XPh-Ma; Mon, 22 Mar 2021 13:02:46 +0000
Date:   Mon, 22 Mar 2021 13:02:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-mm@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <20210322130242.GL1719932@casper.infradead.org>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
 <20210322081512.GI1719932@casper.infradead.org>
 <YFhdWeedjQQgJdbi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhdWeedjQQgJdbi@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 06:03:21PM +0900, Sergey Senozhatsky wrote:
> On (21/03/22 08:15), Matthew Wilcox wrote:
> > 
> > What's the scenario for which your allocator performs better than slub
> > 
> 
> IIRC request and reply buffers can be up to 4M in size. So this stuff
> just allocates a number of fat buffers and keeps them around so that
> it doesn't have to vmalloc(4M) for every request and every response.

That makes a lot more sense; I was thrown off by the kvmalloc, which
is usually used for allocations that might be smaller than PAGE_SIZE.

So what this patch is really saying is that vmalloc() should include
some caching, so it can defer freeing until there's memory pressure
or it's built up a large (percpu) backlog of freed areas.

Vlad, have you thought about this?
