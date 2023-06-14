Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93672F4B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 08:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbjFNGXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjFNGXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:23:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42864195;
        Tue, 13 Jun 2023 23:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/237Jd7ln6xMv4l66dVHFcgKFsuublPEznkGLEXUzo=; b=Tji2iYkElPyo5dB3xXWyTj8Gi/
        gVm4pEMT4188VSrQO5QbDATCEZHEibdHPW8nbwvpBNrlb5MeNaiF6GvdOu2+1Q5FUC48EqW4w5/oi
        jZSar9WmBMn7M/hmapwGV4tbqE/BsjenCppqIunVwlnkKf7549DO2Kvqa2C4moVy2LQFWMlxetgdk
        TAmeNkQacQYKRvNdAV4ahGvbXPaFgD5ZB3Tz5gzBo0CpZLpH5UP9+IMZ1+b4q9TM3f8/YXG+au0C6
        zt8hx3RawgF9nXDBZRccHwDGbhLAXys1+WWjN5SzuAbNemIjEbd+JJjYYMTI34Fe3zTPTI+ZoeNG1
        tXV3gtmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9Juf-00AQ6q-2g;
        Wed, 14 Jun 2023 06:23:25 +0000
Date:   Tue, 13 Jun 2023 23:23:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix dio_cleanup() to advance the head index
Message-ID: <ZIlc3Z8Sbgd4Vk6o@infradead.org>
References: <1193485.1686693279@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1193485.1686693279@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:54:39PM +0100, David Howells wrote:
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -459,6 +459,7 @@ static inline void dio_cleanup(struct dio *dio, struct dio_submit *sdio)
>  	if (dio->is_pinned)
>  		unpin_user_pages(dio->pages + sdio->head,
>  				 sdio->tail - sdio->head);
> +	sdio->head = sdio->tail;

So looking at the original patch, it does:

-       while (sdio->head < sdio->tail)
-               put_page(dio->pages[sdio->head++]);
+       if (dio->is_pinned)
+               unpin_user_pages(dio->pages + sdio->head,
+                                sdio->tail - sdio->head);

so yes, we're this looks correct:

Reviewed-by: Christoph Hellwig <hch@lst.de>
