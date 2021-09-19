Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16A410BF1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhISOmr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 10:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhISOmr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:42:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9819C061574;
        Sun, 19 Sep 2021 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0djtDXf3dJy/0lRte8xIBcRhbg0XM0G45oEvLEXQ+H8=; b=V0amxD60xFkrGsyAX78oTr++Gm
        eR01oM6mn6MtyYVDE4lcV5l3HbG5R9QqszmHEsXV074ebgN+zWpOpjwOhopBW7QPWPYWdNAWSeNw9
        +qViji5amXdnG0UR2QlkclJ4kBw+Ki6KhLid8HLcy0CnDmfZv1iNdXn7a383NOcjZL7Y00oPzzRek
        ah6FwicMt8WaCYPK3ZP8hJ93d5uGVeAiSJO2DP31h52uvtP0enxf3FGVIs/fkbc5pN0gBdozZLyCr
        8dFMvsHoAOZ7Sxe1EmO3oi4bt2XNqKZrdJaoz6oicJA4nZOmt1VoQ0eZqL1Pq6zhE2SR4RfsjeFj+
        lZOoWvSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRxza-001w2N-QO; Sun, 19 Sep 2021 14:40:37 +0000
Date:   Sun, 19 Sep 2021 15:40:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        song@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
Message-ID: <YUdL3lFLFHzC80Wt@casper.infradead.org>
References: <20210917205731.262693-1-shy828301@gmail.com>
 <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 05:07:03PM -0700, Yang Shi wrote:
> > The debugging showed the page passed to invalidatepage is a huge page
> > and the length is the size of huge page instead of single page due to
> > read only FS THP support.  But block_invalidatepage() would throw BUG if
> > the size is greater than single page.

Things have already gone wrong before we get to this point.  See
do_dentry_open().  You aren't supposed to be able to get a writable file
descriptor on a file which has had huge pages added to the page cache
without the filesystem's knowledge.  That's the problem that needs to
be fixed.
