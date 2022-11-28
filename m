Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2012A63A646
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiK1KlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiK1KlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:41:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87063323
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:41:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4237521B88;
        Mon, 28 Nov 2022 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669632063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CVm6ryaq2N0dSdDXl1W+AalpScybxZa4tkUINqWSzs=;
        b=B+/YdUmazryAH7DO6BMIWE2WqDSy4+WAitWePz41+Vzfk16IC9wjEIwyeIDe8a3wB+XeYP
        1u22UaGzbeN1RyzhdFIezj0mEgaGRTXJNzsd3hyzMKeWDr+Z/7ExwLIZ0VcXN4Sea/qDAA
        YaxGJXzV8FaMxT+jJ3WSGJ4IKSlCIKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669632063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CVm6ryaq2N0dSdDXl1W+AalpScybxZa4tkUINqWSzs=;
        b=gkWA+2Thu6RMSrtlxfVSA9nI+lISBQt17LPaAk4nUDP/qXKO8UtJycfpBenCEU+QZ2ad4/
        YaKlwclrz7ZmAxAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3076D13273;
        Mon, 28 Nov 2022 10:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tZzLCz+QhGNrJQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Nov 2022 10:41:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 91AB0A070F; Mon, 28 Nov 2022 11:41:02 +0100 (CET)
Date:   Mon, 28 Nov 2022 11:41:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] unbugger ext2_empty_dir()
Message-ID: <20221128104102.phypw45xcfrtrw7d@quack3>
References: <Y4GFPajUjIBOa5i2@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4GFPajUjIBOa5i2@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 26-11-22 03:17:17, Al Viro wrote:
> 	In 27cfa258951a "ext2: fix fs corruption when trying to remove
> a non-empty directory with IO error" a funny thing has happened:
> 
> -               page = ext2_get_page(inode, i, dir_has_error, &page_addr);
> +               page = ext2_get_page(inode, i, 0, &page_addr);
>  
>  -               if (IS_ERR(page)) {
>  -                       dir_has_error = 1;
>  -                       continue;
>  -               }
>  +               if (IS_ERR(page))
>  +                       goto not_empty;
> 
> And at not_empty: we hit ext2_put_page(page, page_addr), which does
> put_page(page).  Which, unless I'm very mistaken, should oops
> immediately when given ERR_PTR(-E...) as page.
> 
> OK, shit happens, insufficiently tested patches included.  But when
> commit in question describes the fault-injection test that exercised
> that particular failure exit...
> 
> Ow.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Right. I've clearly missed this when reviewing & merging the fix. And Ye
Bin obviously didn't test this with his reproducer ;). Anyway, thanks for
catching this! I've merged the patch to my tree.

								Honza

> ---
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 8f597753ac12..5202eddfc3c0 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -679,7 +679,7 @@ int ext2_empty_dir (struct inode * inode)
>  		page = ext2_get_page(inode, i, 0, &page_addr);
>  
>  		if (IS_ERR(page))
> -			goto not_empty;
> +			return 0;
>  
>  		kaddr = page_addr;
>  		de = (ext2_dirent *)kaddr;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
