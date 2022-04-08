Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDB4F9571
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiDHMR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 08:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiDHMRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:17:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D911D67C9
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Apr 2022 05:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IOiIDp88q9Cj2CU0MGNIro2Es0FaRA585xgljk4Ydbo=; b=Txg/1GK/wDAgBGJtO8tQrSNh2D
        idASD7kylC6xXEyyAKtEekWjTD04nRF+zg2M0FWkLM/QEYdUUY3w9dj2gVgVYFapqlR3HfAlXj8Vi
        UynX+TbJZ7EvDqRvINkbh2TdlT09NvEdiCWPzeWsAXu5XxXjpkQkzV4h3zNMqSBA2BkSzpY4Igvnj
        ZCr7V1PXrPiP9wPv7Iy8AHlOddqcjhG0zY3e8jy17ULHKNzR6SGzwqealIeCnyxvZPHXXoxapPmRW
        DZTNE4sxIR0yBCnKhZkaeNcH+G3IRB3s0CZK5re1j9+dyxm8t1w+Kg1HEK+3hEXDO6BICVS4XGBbj
        5jpj/LFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncnWl-009nn2-2B; Fri, 08 Apr 2022 12:15:47 +0000
Date:   Fri, 8 Apr 2022 13:15:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] writeback: expired dirty inodes can lead to a NULL
 dereference kernel panic issue in 'move_expired_inodes' function
Message-ID: <YlAnc3CcS8A5Echt@casper.infradead.org>
References: <20220408120001.GA3113@DESKTOP-S4LJL03.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408120001.GA3113@DESKTOP-S4LJL03.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 09:00:01PM +0900, Paran Lee wrote:
> +++ b/fs/fs-writeback.c
> @@ -1357,12 +1357,14 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  	LIST_HEAD(tmp);
>  	struct list_head *pos, *node;
>  	struct super_block *sb = NULL;
> -	struct inode *inode;
> +	struct inode *inode = NULL;

Not needed; in fact I would move the definition of inode to inside the
while loop.

>  	int do_sb_sort = 0;
>  	int moved = 0;
>  
>  	while (!list_empty(delaying_queue)) {
>  		inode = wb_inode(delaying_queue->prev);
> +		if (!inode)
> +			continue;

Did you look at the definition of wb_inode?  It can't possibly return a
NULL pointer.

>  	/* Move inodes from one superblock together */
>  	while (!list_empty(&tmp)) {
> -		sb = wb_inode(tmp.prev)->i_sb;
> +		inode = wb_inode(tmp.prev);
> +		if (!inode)
> +			continue;
> +		sb = inode->i_sb;
> +		if (!sb)
> +			continue;

Can you explain how inode might have a NULL i_sb?

