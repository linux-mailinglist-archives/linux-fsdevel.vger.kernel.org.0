Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674636111C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ1Mm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJ1Mm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:42:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346441C5A51;
        Fri, 28 Oct 2022 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LDn51qkGPjR8MN2I2yUFwggc/IMkVhqq76lLfkbgdCo=; b=UA/ggtlO3O2LCil8nRiUE0OCcu
        HI4mDGUOVs2jDBZciPkNhrdrAa6KyChCF3pntIr2parrhTE35uAzECM67vluwjpfSdUwPo9FzYUfz
        GFuxMHqlY7NaD/DTpNXNEHLgpA/seB7qN+mZgdcZW4Q01vUsnzdYWc1yE47R/LEBQpns4MAMJ6aNi
        l0pYAtd8zE75IHTh150zf5LsOxO13VctEjADW9EgDebpnCIkNGwVA2lX1kuGMbSQtAXp/gqJcrEKf
        FidRVdrITtyminl3C+a627CZl/dEAEAhxJ9oikO/p/2N7drVZuTZC8rAAMj2MPe+kIabyq92bvEJR
        /95ZjQag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooOhK-001EUU-PB; Fri, 28 Oct 2022 12:42:54 +0000
Date:   Fri, 28 Oct 2022 13:42:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <Y1vOTsRzI0GMosaN@casper.infradead.org>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> @@ -1354,7 +1399,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	 * invalid, grab a new one.
>  	 */
>  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (iop && !test_bit(i, iop->state))
> +		if (iop && (!test_bit(i, iop->state) ||
> +			    !test_bit(i + nblocks, iop->state)))
>  			continue;
>  
>  		error = wpc->ops->map_blocks(wpc, inode, pos);

Why do we need to test both uptodate and dirty?  Surely we only need to
test the dirty bit?  How can a !uptodate block ever be marked as dirty?

More generally, I think open-coding this is going to lead to confusion.
We need wrappers like 'iop_block_dirty()' and 'iop_block_uptodate()'.
(iop is still a bad name for this, but nobody's stepped up with a better
one yet).
