Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6236B51EFDE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 21:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiEHTRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 15:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378353AbiEHSlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 14:41:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02FDF40
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3Yca6/1iQCzUNc+slQEtIcY0dlO1SVym3T5ELS/57HY=; b=Ht8JyGmMQa8lUETpZsHeqFsQ6o
        +mJN5bQJ4WlbKtHkDT0tS5A8FlOD5YmQzvYIDg0f+qmnD/u7u07hMEO1Xpm/IWnwuu1Bx3XFCsowt
        3fxF6qd8laB+wxgdiOxEd1fRR3rR7AZfyHc1weW3aIZ0V1nRdcuts3EwFLi02QCfM6ay7ouf9VTmi
        1ve4JxNOPS8HYyHXtGNJOMeE2zkf7lo4awdALVtrvVK55AEzbVeYPmHLimN9UMdENnm4nmQdVG339
        O7b1XIJbfSkcDAVTKAKz4vlxHSzne4iCF+HSUbgepWim8ltQyL/V9UwPUy77IQxIQrvxrPP0OYD4t
        2T9q790Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnlmI-002j6N-OR; Sun, 08 May 2022 18:37:10 +0000
Date:   Sun, 8 May 2022 19:37:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 32/69] buffer: Rewrite nobh_truncate_page() to use folios
Message-ID: <YngN1n4KT2ip8DHS@casper.infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
 <20220429172556.3011843-33-willy@infradead.org>
 <YnE/FOz5fHKAg2zS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnE/FOz5fHKAg2zS@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 07:41:24AM -0700, Christoph Hellwig wrote:
> The changes looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But I wonder if we shouldn't really just drop these nobh helpers
> entirely.  They were added to save lowmem on highmem systems with a lot
> of highmem, but I really don't think we should continue optimizaing for
> that.

They certainly don't have a lot of users:

$ git grep -w nobh_truncate_page
fs/buffer.c:int nobh_truncate_page(struct address_space *mapping,
fs/buffer.c:EXPORT_SYMBOL(nobh_truncate_page);
fs/ext2/inode.c:                error = nobh_truncate_page(inode->i_mapping,
fs/jfs/inode.c: nobh_truncate_page(ip->i_mapping, ip->i_size, jfs_get_block);
include/linux/buffer_head.h:int nobh_truncate_page(struct address_space *, loff_t, get_block_t *);

So just two for this helper.  The other nobh_ helpers are in a similar
position (just ext2 and jfs).  I had a quick look at converting jfs to
iomap, and that seems quite reasonable.  So ... once ext2 is converted
to iomap, all the nobh helpers can go away as being unused?
