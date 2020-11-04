Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC752A5CC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 03:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgKDCgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 21:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgKDCgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 21:36:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BEC061A4D;
        Tue,  3 Nov 2020 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hx1MzWTXdeEOxgEkbR+wZtVBswYPWYPzzP51xACphZ8=; b=wHXo56TLGfXXsvN4PGIA7lqw1L
        mlc2SznGv7CFGKAMLwOc0i5Lz/H1P3HznLlV9ambuv03R0MCBafKRUSRe8gdLAlxBkVcPU79kTJBP
        +mUtdmocJcUsakQQxxKwrvXN1K1Db6Ke3eV6xH8L0Yijnt/cr+o7x5QkMtOWydK1LmtWeZuwWH63Z
        9f4ZvCbP4odCFBBwP5wyZpbL61BusKMmnYgxIWMD+FkrdQGCzFFUvMYkcIG2XvEx4XsGK9hqC/sTW
        LeljmphmCrtR7UTSGPOfGj/ihC/XECI2l5rKqE4yg2uKQ4sccJUqN5MdIxkLpsmfjlV9EILQTy0lS
        Gy7Oh96A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ka8ee-0002tw-El; Wed, 04 Nov 2020 02:36:08 +0000
Date:   Wed, 4 Nov 2020 02:36:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        yanxiaofeng7@jd.com
Subject: Re: [PATCH 1/2] [xarry]:Fixed an issue with memory allocated using
 the GFP_KERNEL flag in spinlocks
Message-ID: <20201104023608.GK27442@casper.infradead.org>
References: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:32:12AM +0800, xiaofeng.yan wrote:
>  	xa_lock_irq(xa);
> -	curr = __xa_store(xa, index, entry, gfp);
> +	curr = __xa_store(xa, index, entry, GFP_ATOMIC);
>  	xa_unlock_irq(xa);

You haven't actually seen a bug, have you?  You just read the code
wrongly.

void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
...
        } while (__xas_nomem(&xas, gfp));
...
        if (gfpflags_allow_blocking(gfp)) {
                xas_unlock_type(xas, lock_type);
                xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
                xas_lock_type(xas, lock_type);

