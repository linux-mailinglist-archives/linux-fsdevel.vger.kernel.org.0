Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DE53F5E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 08:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiFGGJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 02:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:09:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F43A7E3A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 23:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1WewuiiNJnj7c2oS3OjnniLNWZ+YQwmFd9YXnAQvIR4=; b=hllmm5GNyy43wdaRVnBxQai159
        fcguIwtaK9pyV2buO1+dYiLj3+q2sVsCyxplEjv3pVHVsPBr4SReKtKcn/Ugj0PZHKaM7xjtEwWzv
        3quNJ6UgfUsptRiU8sIEHzRTiHo1Mcm8LJOXKPXLuXvTAy5QlXRrRzEOyW4wrMUlceHsR/hQunACW
        R3ahRkJWPTQxF0nnlHKdK9yeaecvj0NkdIjKp6IV8E1RBroI/53EcstZMnt7cgY5jLumuR7rQey4A
        GmOrS/uF4D7Q6T0iYg0f3ws9Nv0utjJ93nD3kll9VbmNLA1QBr8m+MDV4BWzim/Da1jAMtHUY2NSZ
        XPGHuxeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nySPL-004wq2-Ky; Tue, 07 Jun 2022 06:09:39 +0000
Date:   Mon, 6 Jun 2022 23:09:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 3/3] zonefs: fix zonefs_iomap_begin() for reads
Message-ID: <Yp7rox7SRvKcsZPT@infradead.org>
References: <20220603114939.236783-1-damien.lemoal@opensource.wdc.com>
 <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603114939.236783-4-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 03, 2022 at 08:49:39PM +0900, Damien Le Moal wrote:
> If a read operation (e.g. a readahead) is issued to a sequential zone
> file with an offset exactly equal to the current file size, the iomap
> type will be set to IOMAP_UNWRITTEN, which will prevent an IO, but the
> iomap length is always calculated as 0. This causes a WARN_ON() in
> iomap_iter():

Is there a testsuite somewhere with a reproducer?

> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 123464d2145a..64f4ceb6f579 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -144,7 +144,7 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		iomap->type = IOMAP_MAPPED;
>  	if (flags & IOMAP_WRITE)
>  		length = zi->i_max_size - offset;
> -	else
> +	else if (offset < isize)
>  		length = min(length, isize - offset);

So you still report an IOMAP_UNWRITTEN extent for the whole size of
the requst past EOF?  Looking at XFS we do return the whole requested
length, but do return it as HOLE.  Maybe we need to clarify the behavior
here and document it.
