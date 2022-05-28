Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9491536AFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 May 2022 07:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiE1F5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 May 2022 01:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiE1F47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 May 2022 01:56:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD195DBDF
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 22:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dQyv3eHL6CJ2dCoh+2jN3ynYnY2ODDo+v2cNgQYrw+U=; b=GU8o6f1zYwaqd1DdI8cPMthpT2
        hOfT3xnUtclp5nOBzz5GPOIUpn+aARunUv5ukBnLZfLUlNHYZffDx5UNneUHNPO/cFH70CQk0x+EQ
        7Flm49fs45Vwd78c4ok9wdVxi7XL4Oj9fWhBKv+ftnO34wfOt5ph1FjzYaa8rPWEtJSaZ4BzLQ7S7
        pi0/kcZrv0mZGR8CXaYMz9bBAdPyPNkyWSwMnc4X6G4STl14+5LMdX6BeDFPoZmfrl2RvZPvQE5jq
        MamEWRvsWIgpWXLvgFRf0TKBjySahSoRqf++wvKx7ncsu0UDYwgbR+e27dbtkufyGAUjQ+uRqFoEi
        umhcVQdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nupRU-001WQY-AK; Sat, 28 May 2022 05:56:52 +0000
Date:   Fri, 27 May 2022 22:56:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 13/24] ufs: Remove checks for PageError
Message-ID: <YpG5pOzUw3eeAO09@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
 <20220527155036.524743-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527155036.524743-14-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -193,7 +193,7 @@ static struct page *ufs_get_page(struct inode *dir, unsigned long n)
>  	if (!IS_ERR(page)) {
>  		kmap(page);
>  		if (unlikely(!PageChecked(page))) {
> -			if (PageError(page) || !ufs_check_page(page))
> +			if (!ufs_check_page(page))
>  				goto fail;
>  		}

Unrelated note:  doing the PageChecked check inside of ufs_check_page
wuld really help readability for the casual reader.

>  	}
> diff --git a/fs/ufs/util.c b/fs/ufs/util.c
> index 4fa633f84274..08ddf41eaaad 100644
> --- a/fs/ufs/util.c
> +++ b/fs/ufs/util.c
> @@ -264,17 +264,6 @@ struct page *ufs_get_locked_page(struct address_space *mapping,
>  			put_page(page);
>  			return NULL;
>  		}
> -
> -		if (!PageUptodate(page) || PageError(page)) {
> -			unlock_page(page);
> -			put_page(page);
> -
> -			printk(KERN_ERR "ufs_change_blocknr: "
> -			       "can not read page: ino %lu, index: %lu\n",
> -			       inode->i_ino, index);
> -
> -			return ERR_PTR(-EIO);
> -		}

This looks good.  But this code could use some more love nd a removal
of the find_lock_page call by always just using read_mapping_page.
Especially a the truncate protection should apply equally to cached
pages and not just those freshly read off the disk.

But I guess for now this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
