Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60965CA99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 01:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjADACi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 19:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjADACh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:02:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9343113CC5
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jan 2023 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TNNR/zoPc6I7wufEnKICiO2nqhp7wSpFpVyOPdHlC60=; b=GO9vTGdj53ux8UhfpGo2TVVO4Y
        IHid7GyLJsEYUMu5xS9U/AvcoBatEv1OvMZ8nHmbEPxWnA2EUxKABw2AepW9L+V+zAIcpoodbfiHz
        elr2eEB7agAloChwbJV0wkHkSWgR8c+A+ysbclz7n4zDXjfe3/vuGyvITljbHa7b/MwXuGY2dm4vd
        cu3NUEBWaBRN1+NCnWWOxWYsI1ozlIiyPnMKIF6wbtZ6YC84BAhlu82Wmf9uzgvwJpG9JWOcvcwGJ
        j/dX46GHZ+9Z1lNtGk7Bz4cSm4C/xYGN5Ek1fibbP2KsnNI8iKVpKuPKdy60mE3Qx4yjEuPdFeNcd
        ZSKBdbTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pCrEm-00H9TX-08;
        Wed, 04 Jan 2023 00:02:32 +0000
Date:   Wed, 4 Jan 2023 00:02:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <Y7TCFz++qFNbGKwU@ZenIV>
References: <20230103104430.27749-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103104430.27749-1-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> When __mpage_writepage() is called for a page beyond EOF, it will go and
> allocate all blocks underlying the page. This is not only unnecessary
> but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> dirty but in the end write fails and i_size is not extended).
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/mpage.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 0f8ae954a579..9f040c1d5912 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -524,6 +524,12 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
>  	 */
>  	BUG_ON(!PageUptodate(page));
>  	block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
> +	/*
> +	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
> +	 * space.
> +	 */
> +	if (block_in_file >= (i_size + (1 << blkbits) - 1) >> blkbits)
> +		goto page_is_mapped;
>  	last_block = (i_size - 1) >> blkbits;

Why not simply

	if (block_in_file > last_block)
		goto page_is_mapped;

after last_block has been calculated?
