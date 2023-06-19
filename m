Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F7735112
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 11:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFSJ5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFSJ4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:56:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E713D;
        Mon, 19 Jun 2023 02:56:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63C8E1F37C;
        Mon, 19 Jun 2023 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687168603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=muUTjP25aYFmNXaLyBGB13a2mB/gemsyPXw0y/fSJkY=;
        b=tbtiGiX80YAT6jPK+U/vZj+hgHIg9p75BCFi001xezlolDZyipzy07OqrfRefEbf4dV5EM
        qXKCOaiOOm2drgGa2uzkAfBrTMGs0u6y6O+gXdLb9LR8mYoiABphYf2A+3aSuBEeJUSfl0
        080X67FW1yX8DDMW4ffGWuYyUOV+FXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687168603;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=muUTjP25aYFmNXaLyBGB13a2mB/gemsyPXw0y/fSJkY=;
        b=4yj3hR/7cdSaAU6VGtPxoXcyKUVufEHzpM/+ahqqUyabkHOKXKxncQcCLFyPHoWlgf1yyq
        JQEMpcSJZvgYYYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57717138E8;
        Mon, 19 Jun 2023 09:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8edaFVsmkGQRNwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Jun 2023 09:56:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE4CFA0755; Mon, 19 Jun 2023 11:56:42 +0200 (CEST)
Date:   Mon, 19 Jun 2023 11:56:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: Re: [PATCH v1 5/5] udf: No need to check return value of
 block_commit_write()
Message-ID: <20230619095642.vjb5fjyhgnbp2drc@quack3>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
 <20230618213250.694110-6-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618213250.694110-6-beanhuo@iokpp.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 18-06-23 23:32:50, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> Remove unnecessary check on the return value of block_commit_write().
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/udf/file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 8238f742377b..b1a062922a24 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -67,13 +67,13 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
>  	else
>  		end = PAGE_SIZE;
>  	err = __block_write_begin(page, 0, end, udf_get_block);
> -	if (!err)
> -		err = block_commit_write(page, 0, end);
> -	if (err < 0) {
> +	if (err) {
>  		unlock_page(page);
>  		ret = block_page_mkwrite_return(err);
>  		goto out_unlock;
>  	}
> +
> +	block_commit_write(page, 0, end);
>  out_dirty:
>  	set_page_dirty(page);
>  	wait_for_stable_page(page);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
