Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA7249ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHSM5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 08:57:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23696 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728525AbgHSM4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597841785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NikvSouUV0hUDKCqhWTIlZU+t6Vx2BaHoXzoDwd88Bw=;
        b=PusQ538LvdaZdMP5eVcJp93zXbCRNM25POG57TFwoJm4H65tCId+N10kNToYBv8EhL1ppN
        pVfYWUKI2t+sl6ExvGgsG22YncAxbD1oNIPi+pQQi9zJjQyYzT/3bJzLrF7oahYYWOZbj+
        j0gjUnC4lKlpXcu2QODOi6EkVrTQYUU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-aiUJpIPhNh2tZ0RwLhPlmw-1; Wed, 19 Aug 2020 08:56:21 -0400
X-MC-Unique: aiUJpIPhNh2tZ0RwLhPlmw-1
Received: by mail-pf1-f199.google.com with SMTP id 19so15074362pfu.20
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2020 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NikvSouUV0hUDKCqhWTIlZU+t6Vx2BaHoXzoDwd88Bw=;
        b=ui7WStWVeoqJp6jmXJoyFf6UJ/A3oJzb7vdaS2uGmbf87DpmExqh2nqRtcFi1ZP5Gt
         +Ry2G/7rT7hH24P2HVHJ7hQPGjqH9GASOhPGmTiGrVFcWyNpy6+1AgL90ZTmn9U62mD8
         g4qxMmtd5pF0NlsQJocsUvHJb72vlUIVtVu0HfAH5tWwyoCeBVjj3pQj4SrIfsqWbIGG
         JEtzDKaNcMexF+ZVCBp9uCAF7j4ajBN/5ioJfgiD+1n2hu42nZ7FdZJykeYpch3wI2G0
         3kSOFsocq5bRU0cj4OGPLL3hYDUGHgqnIm03mLGO2sWLEJL5FfVO67IMAA2eOnJ3/OU0
         Rurg==
X-Gm-Message-State: AOAM533vXfc5odKK1PoWyAny88uRzXvajoB1+lzkEaRrJYC15apgEbAQ
        XGhveg5zss11GSFA5+vYy5N/LWMiUT8DlSNFsP+aBzsrYkgeJcG9nyoytfQop65DEGxwSkPYl4X
        mHad2uLB9vdNC6jXtgdiM6X5s8A==
X-Received: by 2002:a62:d10a:: with SMTP id z10mr19729317pfg.7.1597841780727;
        Wed, 19 Aug 2020 05:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKMvJu2W6zuenKGKGyYePa2IlXshPfXmDEyEQ0xqmP3T9rQWDHYkR2+7L1tPr4a/TCVvO07g==
X-Received: by 2002:a62:d10a:: with SMTP id z10mr19729289pfg.7.1597841780387;
        Wed, 19 Aug 2020 05:56:20 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a7sm29385606pfd.194.2020.08.19.05.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:56:19 -0700 (PDT)
Date:   Wed, 19 Aug 2020 20:56:08 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com, willy@infradead.org,
        david@fromorbit.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [RFC PATCH V3] iomap: add support to track dirty state of sub
 pages
Message-ID: <20200819125608.GA24051@xiangao.remote.csb>
References: <20200819120542.3780727-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819120542.3780727-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 08:05:42PM +0800, Yu Kuai wrote:

...

> +static void
> +iomap_iop_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	struct iomap_page *iop = to_iomap_page(page);
> +	struct inode *inode = page->mapping->host;
> +	unsigned int first = DIRTY_BITS(off >> inode->i_blkbits);
> +	unsigned int last = DIRTY_BITS((off + len - 1) >> inode->i_blkbits);
> +	unsigned long flags;
> +	unsigned int i;
> +
> +	spin_lock_irqsave(&iop->state_lock, flags);
> +	for (i = first; i <= last; i++)
> +		set_bit(i, iop->state);
> +
> +	if (last >= first)
> +		iomap_set_page_dirty(page);

set_page_dirty() in the atomic context?

> +
> +	spin_unlock_irqrestore(&iop->state_lock, flags);
> +}
> +
> +static void
> +iomap_set_range_dirty(struct page *page, unsigned int off,
> +		unsigned int len)
> +{
> +	if (PageError(page))
> +		return;
> +
> +	if (page_has_private(page))
> +		iomap_iop_set_range_dirty(page, off, len);


I vaguely remembered iomap doesn't always set up PagePrivate.


@@ -705,7 +770,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	iomap_set_range_dirty(page, offset_in_page(pos), len);
 	return copied;
 }

so here could be suspectable, but I might be wrong here since
I just take a quick look.

Thanks,
Gao Xiang

