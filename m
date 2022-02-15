Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5486C4B75DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiBOUM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 15:12:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiBOUM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:12:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A6C6249
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 12:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sXm/DHXdyNxnI4eHPXlB/RiETdyus6Zo0rV31LImf4Y=; b=Y3b2//SuYlBMtEXImCJWF+qfQa
        M3BX60KtpXmwLzD9lSOomVBmbK80p0PpN/4/uM81Oai3uySyxtzK6+UsIb5q43fAZFjot/4GZoS4N
        gBXPzM5IkshUpF/Hs9hjL0txrRSbu2OLBIHK8uZ66p1kwns2eQtRmqrIYAESyUm5zAbYpqyt9Hx8I
        aYZhHwwk4wyGbXh9KkHrR84xTEh2pGdf6HVydU6GbDCE97qPHgRQzJdDuDm8lUAXmhG7WFzZKrFC3
        6QeYkKVbL8zBUrdNm+oJ9EPvY2b0UF6F0L7HH90nCZJHQe6BShT7cNQfUZeMrB6N5UuA5+vqjAyw+
        osylwXVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK4BJ-00E8rS-2b; Tue, 15 Feb 2022 20:12:13 +0000
Date:   Tue, 15 Feb 2022 20:12:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 04/10] mm/truncate: Replace page_mapped() call in
 invalidate_inode_page()
Message-ID: <YgwJHdm6g2t80OZ/@casper.infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-5-willy@infradead.org>
 <YgtT+hpds6ViIeEE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgtT+hpds6ViIeEE@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:19:22PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 14, 2022 at 08:00:11PM +0000, Matthew Wilcox (Oracle) wrote:
> > folio_mapped() is expensive because it has to check each page's mapcount
> > field.  A cheaper check is whether there are any extra references to
> > the page, other than the one we own and the ones held by the page cache.
> > The call to remove_mapping() will fail in any case if it cannot freeze
> > the refcount, but failing here avoids cycling the i_pages spinlock.
> 
> I wonder if something like this should also be in a comment near
> the check in the code.

        /* The refcount will be elevated if any page in the folio is mapped */

is what I've added for now.
