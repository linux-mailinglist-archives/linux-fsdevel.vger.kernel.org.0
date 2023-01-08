Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8666176E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHR3o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 12:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHR3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:29:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BDECE0C;
        Sun,  8 Jan 2023 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2StZfIJeCsrH27hO2Jch2n7VF4OM7Ialp8rjQ1A9qek=; b=V3pDPx/10tWBkmOqjv/n6J3YvV
        zdvvKMlzXlzUJinuCJqG6S8eKeZAQLwhPA8Vp5z6d+zW8fAQpqK/zQdOm17ZvTAMJn2TdZoMfocEm
        FyTlq9wK7fOC5R3qGVFAYGBGYVBq2QlgiGj+PFQci9CM3QvJjsCSwS7Qz+7IkcHfKZ7IPK/do6s5v
        /bcBYZEeaTZAfEE2WZV+YqhfMccz0m2MJ4Q/F9FDmCm5wgAvap11jrYdvH4hKjlk3poxekHVQCbG/
        eOBvlXp+wVUSUA6Zt+UadKTKCSpJv8ku6QURJApFHwvqeFEDOmGf30Gk8KLsvoYxWaGLdahLtJ2m4
        CHOLL7MQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEZUI-00Ec5Z-CL; Sun, 08 Jan 2023 17:29:38 +0000
Date:   Sun, 8 Jan 2023 09:29:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH v5 5/9] iomap/gfs2: Get page in page_prepare handler
Message-ID: <Y7r9gnn2q3PnQ030@infradead.org>
References: <20221231150919.659533-1-agruenba@redhat.com>
 <20221231150919.659533-6-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231150919.659533-6-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (page_ops && page_ops->page_prepare)
> +		folio = page_ops->page_prepare(iter, pos, len);
> +	else
> +		folio = iomap_get_folio(iter, pos);
> +	if (IS_ERR(folio))
>  		return PTR_ERR(folio);

I'd love to have a iomap_get_folio helper for this sequence so that
we match iomap_put_folio.  That would require renaming the current
iomap_get_folio to __iomap_get_folio.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
