Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D954C3BB5E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEDqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGEDqu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:46:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809CC061574;
        Sun,  4 Jul 2021 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4o5tfg2f6wq0QKtKB8wvjOg8+C7xXJHO/n2lfXPHDyU=; b=AqE1/vmAJ6tdS7Ev0ruzPhbZEq
        YB5VbmK2xN1iLnPdmgkkrbtbuadMyBWgWoWV4OnSSUoo/wFjSqpp/O1PaCwSwQUM9TqtmliRmm78K
        Ir13iSB7ZhlWQzmd8EKIBeBkjUTACPOnrEaNXrht72b/4p34X41G8i++MjhCjNSnh1XYNQ/qDuR4h
        FkraGWFwDd/VnspmRx/xYKgucB/7p5tja6ErCeoGwL+8/LvRmOfcw8DFRqzbYOSmjBIsEB/UxsCJO
        a72k7QkijjFXlq8CKoKPT28OhT7qf9GhZ13R6z7jCXlWTN8qY/rv4lZT/sW/eUrbCOsybDOupPeWO
        /fyQ1CyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0FVz-009rO9-Im; Mon, 05 Jul 2021 03:43:32 +0000
Date:   Mon, 5 Jul 2021 04:43:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YOJ/2xrQ75Ttp6R3@casper.infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN7dn08eeUXfixJ7@infradead.org>
 <2ce02a7f-4b8b-5a86-13ee-097aff084f82@huawei.com>
 <9a619cb0-e998-83e5-8e42-d3606ab682e0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a619cb0-e998-83e5-8e42-d3606ab682e0@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 05, 2021 at 11:29:44AM +0800, Leizhen (ThunderTown) wrote:
> I've thought about it, and that "if" statement can be removed as follows:

I think this really misses Christoph's point.  He's looking for
something more like this:

@@ -83,27 +83,23 @@ loff_t
 iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 {
        loff_t size = i_size_read(inode);
-       loff_t length = size - offset;
        loff_t ret;

        /* Nothing to be found before or beyond the end of the file. */
        if (offset < 0 || offset >= size)
                return -ENXIO;

-       while (length > 0) {
+       while (offset < size) {
                ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
                                  &offset, iomap_seek_data_actor);
                if (ret < 0)
                        return ret;
                if (ret == 0)
-                       break;
+                       return offset;

                offset += ret;
-               length -= ret;
        }

-       if (length <= 0)
-               return -ENXIO;
-       return offset;
+       return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(iomap_seek_data);

(not even slightly tested)
