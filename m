Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149CD7B0750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 16:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjI0OwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 10:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI0OwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:52:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193BF4
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=57NMsPrfuNnKHOcF2orncjXW67tgAHw0Mk25JVkUc8U=; b=bMOrLwOtNsQ8yJbn+/0aXtypBa
        610PoQUofOPgKwVt4uvtzeRbs/rm/i/mcIJq6lQ9ddTHEjUbUKCecSrm1v6z6uAifpXhhAvhSO60G
        2xFmGNAPj0Y5TRMoFsqEYmYpwF+McsSqbz8PFUAGPj8o6Q7IqHMMg28lD4/TXsv7QwMlpMFl9JGrk
        1YGFP2X8W6IMP5foAhKhkG6LHY+sNk0H8pRPFySCiqFeulTIjYrfVkwnzyLngAxkUC+orRJTUIjP6
        SjAoihY733cc6cvsH04dOeKOYTH0fsc+RT70O6coj4IMI7hnx2zZCJb+2WVaX7IWmJlQPCxJ3elx2
        jf/cQafQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlVtZ-00EU4u-SK; Wed, 27 Sep 2023 14:52:09 +0000
Date:   Wed, 27 Sep 2023 15:52:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] buffer: hoist GFP flags from grow_dev_page() to
 __getblk_gfp()
Message-ID: <ZRRBmfn1H6uTBpOZ@casper.infradead.org>
References: <592d088a-12c7-40e6-9726-65433e2e5a2d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592d088a-12c7-40e6-9726-65433e2e5a2d@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:40:21AM +0300, Dan Carpenter wrote:
> The patch a3c38500d469: "buffer: hoist GFP flags from grow_dev_page()
> to __getblk_gfp()" from Sep 14, 2023 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/buffer.c:1065 grow_dev_page()
> 	warn: NEW missing error code 'ret'

Smatch is right.

> fs/buffer.c
>     1037 static int
>     1038 grow_dev_page(struct block_device *bdev, sector_t block,
>     1039               pgoff_t index, int size, int sizebits, gfp_t gfp)
>     1040 {
>     1041         struct inode *inode = bdev->bd_inode;
>     1042         struct folio *folio;
>     1043         struct buffer_head *bh;
>     1044         sector_t end_block;
>     1045         int ret = 0;
>     1046 
>     1047         folio = __filemap_get_folio(inode->i_mapping, index,
>     1048                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
>     1049         if (IS_ERR(folio))
>     1050                 return PTR_ERR(folio);
>     1051 
>     1052         bh = folio_buffers(folio);
>     1053         if (bh) {
>     1054                 if (bh->b_size == size) {
>     1055                         end_block = folio_init_buffers(folio, bdev,
>     1056                                         (sector_t)index << sizebits, size);
>     1057                         goto done;
>     1058                 }
>     1059                 if (!try_to_free_buffers(folio))
>     1060                         goto failed;
>     1061         }
>     1062 
>     1063         bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
>     1064         if (!bh)
> --> 1065                 goto failed;
> 
> Should this be an error code?  It's kind of complicated because I think
> the other goto failed path deliberately returns zero?

Yes, it's very confusing.  Which is a common refrain in this part of the
VFS.  Thanks for the report, I'll sort it out.

