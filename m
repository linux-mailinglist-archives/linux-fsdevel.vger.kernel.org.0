Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F556742F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjF2V0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjF2V0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:26:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF02D4E;
        Thu, 29 Jun 2023 14:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bQS0PiE1k5TMzQa6AP3znnR0sMcdBZTuUSLtC+nP2cw=; b=PdzRD67YmTAnA/wX7Gu0GM1sNl
        xasvLLa8EB4oxixlkiy792Su9qU5uS723FW1i6lmttfd5CUH8sNBdujDho/fWj/VmiycfTuNW64zZ
        hc3tGO9Z/9RXIhapvVpy7X4HL6qFx75MO52b5w/0r7EIW2HFdxoCImsQboW/TXKM7lZqU5xp27vnJ
        VcK4RxJ8Z+chUT4GEw6KBUJ4HzKSUH7AnoECTEWUWpMp3B1ubKwdjIpa/ASHkbChuYCZ+WgWu5MV1
        RwuS7f2jYcL5lpf1eldnXpQg8VvhPOn2pn5+sGhh54Bl10kcBTKMEcnw1LxsWv3iIarnW8n1wE7+E
        Das9QysQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEz9d-005Bk1-Ff; Thu, 29 Jun 2023 21:26:17 +0000
Date:   Thu, 29 Jun 2023 22:26:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Subject: Re: [PATCH] reiserfs: Check the return value from __getblk()
Message-ID: <ZJ32+b+3O8Z6cuRo@casper.infradead.org>
References: <20230605142335.2883264-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605142335.2883264-1-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I was expecting Jan to pick this one up, but it's not in his pull
request that just got merged.  Looking at patches to reiserfs over the
last few cycles, patches go in a few different ways; there doesn't seem
to be a defined path.  Anyone want to take this one?

On Mon, Jun 05, 2023 at 03:23:34PM +0100, Matthew Wilcox (Oracle) wrote:
> __getblk() can return a NULL pointer if we run out of memory or if
> we try to access beyond the end of the device; check it and handle it
> appropriately.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Link: https://lore.kernel.org/lkml/CAFcO6XOacq3hscbXevPQP7sXRoYFz34ZdKPYjmd6k5sZuhGFDw@mail.gmail.com/
> Tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") # probably introduced in 2002
> ---
>  fs/reiserfs/journal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 4d11d60f493c..dd58e0dca5e5 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2326,7 +2326,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
>  	int i, j;
>  
>  	bh = __getblk(dev, block, bufsize);
> -	if (buffer_uptodate(bh))
> +	if (!bh || buffer_uptodate(bh))
>  		return (bh);
>  
>  	if (block + BUFNR > max_block) {
> @@ -2336,6 +2336,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
>  	j = 1;
>  	for (i = 1; i < blocks; i++) {
>  		bh = __getblk(dev, block + i, bufsize);
> +		if (!bh)
> +			break;
>  		if (buffer_uptodate(bh)) {
>  			brelse(bh);
>  			break;
> -- 
> 2.39.2
> 
