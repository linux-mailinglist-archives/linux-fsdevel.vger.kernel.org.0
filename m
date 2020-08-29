Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818E256880
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 17:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgH2PCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2PC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:02:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D74C061236;
        Sat, 29 Aug 2020 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d39SAF7s8f7x8GH2CWPNw/ILaZKmyMdbqFWhwl2+LCs=; b=ZH44e5BY2MtmgIjPdcAcIdaIuG
        zfEVVciaLe1Qx7dnPvqoozMtOR/geSvdpKnVHGxSw4OCNeRl1NH+lPPokB2G9dL/lyTQYaBVP+90G
        0jncSypl+gJsj5cr41TTGUIAcBefNavmzH5n3pDoDKhjMhW8o5/e2xeqPYKlFTjO8UdytOVdo7o9Q
        UkFxf8ApBwKT/ssP+9OxuNkpEUixe5d0bw4EMDY/5R8CATcX+6bCz17YHze82TQOuvRKh2S+0DjYD
        PDm2GlmECVBHFEsbXDv+Adm9Yu2bZLll73UdTrLi9JMkDKgRjJPCuwrPZsnGk7ukdi3fykniJlVJE
        rNMf17Sw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC2N6-0003rR-1V; Sat, 29 Aug 2020 15:02:24 +0000
Date:   Sat, 29 Aug 2020 16:02:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] bio: convert get_user_pages_fast() -->
 pin_user_pages_fast()
Message-ID: <20200829150223.GC12470@infradead.org>
References: <20200829080853.20337-1-jhubbard@nvidia.com>
 <20200829080853.20337-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829080853.20337-4-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> +	size = iov_iter_pin_user_pages(iter, pages, LONG_MAX, nr_pages, &offset);

This is really a comment to the previous patch, but I only spotted it
here:  I think the right name is iov_iter_pin_pages, as bvec, kvec and
pipe aren't usually user pages.  Same as iov_iter_get_pages vs
get_user_pages.  Same for the _alloc variant.

> + * here on.  It will run one unpin_user_page() against each page
> + * and will run one bio_put() against the BIO.

Nit: the ant and the will still fit on the previous line.
