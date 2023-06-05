Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10772325A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFEVhF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 5 Jun 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjFEVhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:37:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6082DFA
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 14:37:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CF5486081100;
        Mon,  5 Jun 2023 23:37:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id o2Z4OgpbQyJk; Mon,  5 Jun 2023 23:37:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6443D63CC10C;
        Mon,  5 Jun 2023 23:37:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dphcjNX2YtIR; Mon,  5 Jun 2023 23:37:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 41445609D2C4;
        Mon,  5 Jun 2023 23:37:00 +0200 (CEST)
Date:   Mon, 5 Jun 2023 23:37:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at>
In-Reply-To: <20230605165029.2908304-5-willy@infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org> <20230605165029.2908304-5-willy@infradead.org>
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Convert do_writepage() to take a folio
Thread-Index: dsWwczfD853kFS6dMFwnonvyX+Bcrw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew,

----- Ursprüngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
> -static int do_writepage(struct page *page, int len)
> +static int do_writepage(struct folio *folio, size_t len)
> {
> 	int err = 0, i, blen;
> 	unsigned int block;
> 	void *addr;
> +	size_t offset = 0;
> 	union ubifs_key key;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
> 	struct ubifs_info *c = inode->i_sb->s_fs_info;
> 
> #ifdef UBIFS_DEBUG
> 	struct ubifs_inode *ui = ubifs_inode(inode);
> 	spin_lock(&ui->ui_lock);
> -	ubifs_assert(c, page->index <= ui->synced_i_size >> PAGE_SHIFT);
> +	ubifs_assert(c, folio->index <= ui->synced_i_size >> PAGE_SHIFT);
> 	spin_unlock(&ui->ui_lock);
> #endif
> 
> -	/* Update radix tree tags */
> -	set_page_writeback(page);
> +	folio_start_writeback(folio);
> 
> -	addr = kmap(page);
> -	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
> +	addr = kmap_local_folio(folio, offset);
> +	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
> 	i = 0;
> -	while (len) {
> -		blen = min_t(int, len, UBIFS_BLOCK_SIZE);
> +	for (;;) {

This change will cause a file system corruption.
If len is zero (it can be) then a zero length data node will be written.
The while(len) made sure that upon zero length nothing is written.

Thanks,
//richard
