Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009E3B6ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhF1WEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 18:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhF1WEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:04:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745EC0617AD;
        Mon, 28 Jun 2021 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z+7Y81uBW9eVRfZVB1I30CSlW52hSrmu+cpaPYqkA5k=; b=kvLO92xsQI7RbWGirfBeqWzBoT
        x6j/HH7FmDfzMGWgatyaFLWn6zqN9dMiFAXrGOIZwaKDI0RBvw3fFt0fsm44Url2wNuTs9+lfXRzq
        Gr7VUByBcFWZfIsNpBzAxiYvXeqfDlkuEw5q57jibMVNt720hs3C5NJsegVM0//4GkRR2rhp0L3pE
        nQw2ED9hk0OH9p30ywSrwu87lPx7D/FoDGEXk85cHvOr08VBBdKIyX84KoGDdQSYeOcb85DHmzgls
        Kyupeiber/nj8v5i/FTaAXQdcoKx2haxvl55csO0/naL++V4HdQG0tGB+2rhC/z12L/I5uUpia4i7
        RTkex4pA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxzIJ-003Th8-41; Mon, 28 Jun 2021 22:00:08 +0000
Date:   Mon, 28 Jun 2021 22:59:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH 0/2] iomap: small block problems
Message-ID: <YNpGW2KNMF9f77bk@casper.infradead.org>
References: <20210628172727.1894503-1-agruenba@redhat.com>
 <YNoJPZ4NWiqok/by@casper.infradead.org>
 <YNoLTl602RrckQND@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNoLTl602RrckQND@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 06:47:58PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 28, 2021 at 06:39:09PM +0100, Matthew Wilcox wrote:
> > Not hugely happy with either of these options, tbh.  I'd rather we apply
> > a patch akin to this one (plucked from the folio tree), so won't apply:
> 
> > so permit pages without an iop to enter writeback and create an iop
> > *then*.  Would that solve your problem?
> 
> It is the right thing to do, especially when combined with a feature
> patch to not bother to create the iomap_page structure on small
> block size file systems when the extent covers the whole page.

We don't know the extent layout at the point where *this* patch creates
iomap_pages during writeback.  I imagine we can delay creating one until
we find out what our destination layout will be?

