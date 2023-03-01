Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F396A70A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCAQQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCAQQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:16:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E572CC5B
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 08:16:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CECE21959;
        Wed,  1 Mar 2023 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677687382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdWWyYnoXZBxgvFCPe5SIKaaH1S9TEnizR9aeJiU2cA=;
        b=AO1yI6B+b+aiPtd7aMbGFpsY6SqNLSO9VQ6ZCZgJmdEs00cnGezSzJU6SD1qxJiB8Iwcvb
        Y7/8WTAW8HvAm4TPBtcfemHL4ysF5khmNVo/42+thQabhwcE4tBY2L/9kep/fVP12j2kOV
        AMkV7bgwUNPMIfl+9aD51LQLvDEjyS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677687382;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdWWyYnoXZBxgvFCPe5SIKaaH1S9TEnizR9aeJiU2cA=;
        b=iBLhlzMM6pkEsV4xU/QJR+PsH9CJPnrYSrnH8ld6WfJQGXQv1UY1e8atPVu+3gl3s/SnnK
        RmyToRCZp8YJ+HCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 878F213A3E;
        Wed,  1 Mar 2023 16:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1Q0AIVV6/2MXeQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 16:16:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ED683A06E5; Wed,  1 Mar 2023 17:16:16 +0100 (CET)
Date:   Wed, 1 Mar 2023 17:16:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] udf: Fix lost writes in udf_adinicb_writepage()
Message-ID: <20230301161616.b5je5zkjzsl4tiwa@quack3>
References: <20230301133937.24267-1-jack@suse.cz>
 <20230301134641.11819-1-jack@suse.cz>
 <Y/943PNn3gOKGALv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/943PNn3gOKGALv@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-03-23 16:10:04, Matthew Wilcox wrote:
> On Wed, Mar 01, 2023 at 02:46:35PM +0100, Jan Kara wrote:
> > The patch converting udf_adinicb_writepage() to avoid manually kmapping
> > the page used memcpy_to_page() however that copies in the wrong
> > direction (effectively overwriting file data with the old contents).
> > What we should be using is memcpy_from_page() to copy data from the page
> > into the inode and then mark inode dirty to store the data.
> > 
> > Fixes: 5cfc45321a6d ("udf: Convert udf_adinicb_writepage() to memcpy_to_page()")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Oops.  Now you're copying in the right direction, we have a folio
> function for that, so we could just folio-ise the entire function?
> Maybe you'd rather keep the fix minimal and apply this later.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks! Yes, I had this in mind but wanted to fix the corruption first so
that I can push it quickly to rc2... But I'll queue your patch for later.

								Honza

> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index f7a9607c2b95..890be63ddd02 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -188,14 +188,14 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
>  static int udf_adinicb_writepage(struct folio *folio,
>  				 struct writeback_control *wbc, void *data)
>  {
> -	struct page *page = &folio->page;
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  
> -	BUG_ON(!PageLocked(page));
> -	memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
> +	BUG_ON(!folio_test_locked(folio));
> +	BUG_ON(folio->index != 0);
> +	memcpy_from_file_folio(iinfo->i_data + iinfo->i_lenEAttr, folio, 0,
>  		       i_size_read(inode));
> -	unlock_page(page);
> +	folio_unlock(folio);
>  	mark_inode_dirty(inode);
>  
>  	return 0;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
