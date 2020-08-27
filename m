Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D362540C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgH0I0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH0I0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:26:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C58C061264;
        Thu, 27 Aug 2020 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6YVOoqzwTlckg/PNbF867wxnwUJFXoSme6f6Yt+mow=; b=Ow/iU5CfLqY1ciE8rv01JdZ/mE
        AjAOqYOAmWLUqBopr/QulUYZJh3jS39U4nTR8Vt6Xa81V1HBII8Kvd02XA9HLuFgPpfn/keVhYytK
        kVq7hIGC+vYqgfNeqAi3DYZETLqtCfaZoJhxTiM7Yk6r7VeBTwKQKc+mw+B2eEzuz+B94XDjLzJdL
        vX3pvwTmI/n2moHRdQzBjVdkIGJiHZlwXDspqjwFRMyYPJYvjEOrSLRW5Agi5Lgtyf093OQ6Ir6Zg
        5RE4nce6CHzX6Ykc7dcVE3zZ+axlfae2zVgIxna1mRtnNHV4GK1+6ZVRWi+R7grvNDwqEvdU614IO
        00zfb0Eg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBDEy-0003Bb-Sc; Thu, 27 Aug 2020 08:26:36 +0000
Date:   Thu, 27 Aug 2020 09:26:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200827082636.GB11067@infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-6-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  static inline struct iomap_page *to_iomap_page(struct page *page)
>  {
> +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
>  	if (page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;

Nit: can you add an empty line after the VM_BUG_ON_PGFLAGS assert to
keep the function readable?  Maybe also add a comment on the assert,
as it isn't totally obvious.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
