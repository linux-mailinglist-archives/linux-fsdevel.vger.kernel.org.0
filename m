Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92F401AFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbhIFMLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 08:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbhIFMLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:11:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1FFC061575;
        Mon,  6 Sep 2021 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rCmh1KfC0hUsWI8m+mOwABNgKJfWxkdKYiq+H56M0BI=; b=ufiQMk8bZfkG/iYyy5zcmQBoC6
        G+OXykPBnP9uwZNhQ1dlHMEu9C1VGHgnCkEws2jkLqMEDDI/8Xk6ZK1q65QvTfIhaAME0TzSA4+ZM
        yRHoKXzkKUqvyP++yPGRrqfqavRiASeddqYMprOSu2tJ7fYBYskpZX1ro5X8j/yP7o4z+XSVEa2+w
        kzGnLSolTb+z7hUg35HtLr/0bUzaBrUcHLP/VsZCeOt62g3ZLH2r7U0fHN4UNMTQnN0eNUC0+3eAJ
        V38lTXHRSj33yW5ZEtyGhN+kerZpCW3GU84X/Gge80mrApUsrt05PzLV81lF6gx7wGZvsU0TqHPAh
        oUmS4bCA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNDRC-006vSd-In; Mon, 06 Sep 2021 12:09:36 +0000
Date:   Mon, 6 Sep 2021 13:09:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jlayton@kernel.org, bfields@fieldses.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        song.bao.hua@hisilicon.com, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [RFC PATCH] fs/exec: Add the support for ELF program's NUMA
 replication
Message-ID: <YTYE8tBNAhK0MXsY@casper.infradead.org>
References: <20210906161613.4249-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906161613.4249-1-shijie@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 06, 2021 at 04:16:13PM +0000, Huang Shijie wrote:
> This patch adds AT_NUMA_REPLICATION for execveat().
> 
> If this flag is set, the kernel will trigger COW(copy on write)
> on the mmapped ELF binary. So the program will have a copied-page
> on its NUMA node, even if the original page in page cache is
> on other NUMA nodes.

This does absolutely nothing for programs which run on multiple NUMA
nodes at the same time.

Also, I dislike the abuse of the term "COW" for this.  It's COF --
Copy On Fault.
