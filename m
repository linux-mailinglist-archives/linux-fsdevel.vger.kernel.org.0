Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88953A6B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhFNQUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhFNQUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:20:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BDC061574;
        Mon, 14 Jun 2021 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5vWKwcu5zXbIS0gqk+gmRAwRmyT4qPUE/hpJYzofpcg=; b=jD8PC2c4jAqYP3BBYSnpaO0JFY
        FkpdHb8tru56FNbInWWf7nQCM6f/s+sl5xm9SvPduA6+Zn99Ia9kMiYa7Ap/sSiZzc7FrqQKsgird
        JMVaPlutN5bfhuqP2tGqQRAUdTHhdtEJi1wWMimTsjtMZQULcK7qWmtSdIFJq0UJaX610LWJEQptx
        tUqkHgSDI7oEZLWLfYq3NAflpVGhL0Z6VHIIxblppLbUDxSNpM6Nm728luSLDLWFbiqoPtYHzUxG5
        H1Q+K+AgRQw7Ht8HDyzptEMNGD1HjknRQHmO/prS5fT5FeY4BY6iBnga1SHHblvzAS5c7EWG87HVK
        iIrEk0/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lspHG-005blJ-Dp; Mon, 14 Jun 2021 16:17:36 +0000
Date:   Mon, 14 Jun 2021 17:17:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove the implicit .set_page_dirty default
Message-ID: <YMeBGiaQUHWeKEFC@casper.infradead.org>
References: <20210614061512.3966143-1-hch@lst.de>
 <YMdKOst/Psnlxh8a@casper.infradead.org>
 <20210614155333.GB2413@lst.de>
 <20210614155530.GA2563@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614155530.GA2563@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:55:30PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 14, 2021 at 05:53:33PM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 14, 2021 at 01:23:22PM +0100, Matthew Wilcox wrote:
> > > i have a somewhat similar series in the works ...
> > > 
> > > https://git.infradead.org/users/willy/pagecache.git/commitdiff/1e7e8c2d82666b55690705d5bbe908e31d437edb
> > > https://git.infradead.org/users/willy/pagecache.git/commitdiff/bf767a4969c0bc6735275ff7457a8082eef4c3fd
> > > 
> > > ... the other patches rather depend on the folio work.
> > 
> > Yes, these looks useful to me as well.
> 
> 
> And in fact I suspect the code in __set_page_dirty_no_writeback should
> really be the default if no ->set_page_dirty is set up.  It is the
> same code as the no-mapping case and really makes sense as the default
> case..

yes; i was even wondering if that should be conditional on one of the
"no writeback" bits in mapping ...
