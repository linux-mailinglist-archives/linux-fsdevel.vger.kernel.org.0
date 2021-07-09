Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D23C1F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGIGXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 02:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGIGXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 02:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C874C0613DD;
        Thu,  8 Jul 2021 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HT//2LQAI8VE3MBPY2Os3p78rwK+p3/pXCdflg7T7Xo=; b=U6Rgv0Ltf9nxaWCae3o6ATg1Lh
        ZEE+MJ8z4k/7hk+LvWO9PiUgFhv6OG4QgcFD7xyAkjy3+XRXhApXDllupQNUo749sUSiYnQng4QOd
        337BfjmBCFPwnWxuPfKjAuo6CY1sabmNXa9pgsS5j0Za3z1AmH1+RPlflIXLZFMsJ1KQobDql1l1h
        8By1EQ8f9ENo2108BYfv8xh2Df1ZzVgEU70wbKI0ODdoQSCMiu3a7VUZMS4iTZNoFH1yEOKG+tQOK
        9nVepP8X60Gft4AysMwxVvjRdeZ+uxSIsTASzUS5EcVoAfLPOL08AsG3H9RhU1VJjBrULxiZvJhao
        yPgIWk1A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1jrt-00EDRr-6w; Fri, 09 Jul 2021 06:20:12 +0000
Date:   Fri, 9 Jul 2021 07:20:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH v3 2/3] iomap: Don't create iomap_page objects for inline
 files
Message-ID: <YOfqmXtSI2qJHhtB@infradead.org>
References: <20210707115524.2242151-1-agruenba@redhat.com>
 <20210707115524.2242151-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707115524.2242151-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 01:55:23PM +0200, Andreas Gruenbacher wrote:
> In iomap_readpage_actor, don't create iop objects for inline inodes.
> Otherwise, iomap_read_inline_data will set PageUptodate without setting
> iop->uptodate, and iomap_page_release will eventually complain.
> 
> To prevent this kind of bug from occurring in the future, make sure the
> page doesn't have private data attached in iomap_read_inline_data.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Ok, given that you want a quick fix this looks good for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
