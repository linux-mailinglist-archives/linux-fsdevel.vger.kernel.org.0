Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D666558E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Dec 2022 08:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLXHVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Dec 2022 02:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiLXHVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Dec 2022 02:21:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F6712ACF;
        Fri, 23 Dec 2022 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=YgyS9Hi5REvv1K/NGxcEShlxYPQgP5TjuKggBBZ0AXE=; b=EFJCqV3y2QPxOmS8ITM38KaR2P
        uR3WTFMx5W2pVWreyJapHzU5dZPfMwzpB1pjkr59JlE16ozG4ptqVBBynVROPEAGRwGN5EbD2Xkt+
        W00//KiOW2jIe6wM18pQ7qLUcfcYnxg7v+oelGjbAbNk9JrX9N4+HYvFbTtJX18FTVj8gnX4f1/yI
        pdcm40a7+lXBMzvU6SOT0vs33CtsqSUyP2rQGplxXbe9F8cGY78XHwyNYS48cS4b50SFEZTw4hOLq
        tT2rgF3AV1n+0TloFi11auxeXqR9/3mVtQtQS0AUvENgAIgzFFalQ5CIhOIIVC8cLXHOZleL381sL
        PdhYtQ1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8yqS-00FvQQ-7V; Sat, 24 Dec 2022 07:21:24 +0000
Date:   Fri, 23 Dec 2022 23:21:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC v3 1/7] fs: Add folio_may_straddle_isize helper
Message-ID: <Y6aodOf7Q016xSay@infradead.org>
References: <20221216150626.670312-1-agruenba@redhat.com>
 <20221216150626.670312-2-agruenba@redhat.com>
 <Y6XBi/YJ4QV3NK5q@infradead.org>
 <CAHpGcMKJO7HhgyU5NKX3h6vVeNAGp-8xFrOf+nSTEWHC-PekzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKJO7HhgyU5NKX3h6vVeNAGp-8xFrOf+nSTEWHC-PekzA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:04:51PM +0100, Andreas Grünbacher wrote:
> > I find the naming very confusing.  Any good reason to not follow
> > the naming of pagecache_isize_extended an call it
> > folio_isize_extended?
> 
> A good reason for a different name is because
> folio_may_straddle_isize() requires a locked folio, while
> pagecache_isize_extended() will fail if the folio is still locked. So
> this doesn't follow the usual "replace 'page' with 'folio'" pattern.

pagecache also doesn't say page, it says pagecache.  I'd still prepfer
to keep the postfix the same.  And I think the fact that it needs
a locked folio should also have an assert, which both documents this
and catches errors.  I think that's much better than an arbitrarily
different name.

> > Should pagecache_isize_extended be rewritten to use this helper,
> > i.e. turn this into a factoring out of a helper?
> 
> I'm not really sure about that. The boundary conditions in the two
> functions are not identical. I think the logic in
> folio_may_straddle_isize() is sufficient for the
> extending-write-under-folio-lock case, but I'd still need confirmation
> for that. If the same logic would also be enough in
> pagecache_isize_extended() is more unclear to me.

That's another thing that really needs to into the commit log,
why is the condition different and pagecache_isize_extended can't
just be extended for it (if it really can't).
