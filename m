Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC9B47DF35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbhLWG53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 01:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLWG52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:57:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8BC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 22:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WPo3rUtHdmaW1U0F0Pgab9Jp9oFcpx/AjX/YBliZmQY=; b=iWxhfs7vGbZhl/9PmwIJAilm8F
        XzFirwn6J7N4I7cWYsyqP7TOQljwCRsNg+2C4oMkyyUI/ubAC1vAZjY/kIUQlmiAZJzUekm6Bo4SN
        s3gfQKO/9gL0+JQ+tz6Hg0iWC21jVIoJD2cdDMeI+V3/pFYZ6UN0tOaZBJ0hRaFMyoKpUR+Sp3vgv
        3dyw0sHWOK6+p7sMCJFJ3B9aRsjPKRUMzFisn68kyfu5fcVPPVVEi4QUXHQJhnlIK+YB62jvoQhnj
        494qgTtGy8xca95UB7HqyUpo6/7BHIsCtamyjgx8HK7gn3ytlWtfmmHfJQxk2u7VXKSNk1XdUs7+q
        kHbEthJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0I2a-00BwyF-BV; Thu, 23 Dec 2021 06:57:28 +0000
Date:   Wed, 22 Dec 2021 22:57:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/48] iov_iter: Convert iter_xarray to use folios
Message-ID: <YcQd2Fw7atXoU3Dn@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-8-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +		size_t offset = offset_in_folio(folio, start + __off);	\
> +		if (xas_retry(&xas, folio))			\
>  			continue;				\
> +		if (WARN_ON(xa_is_value(folio)))		\
>  			break;					\
> +		if (WARN_ON(folio_test_hugetlb(folio)))		\
>  			break;					\
> +		while (offset < folio_size(folio)) {		\

Nit: I'd be tempted to use a for loop on offset here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
