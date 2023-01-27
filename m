Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7211167DC80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 04:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjA0DCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 22:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjA0DCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 22:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F32ED41;
        Thu, 26 Jan 2023 19:02:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 614CEB81F7C;
        Fri, 27 Jan 2023 03:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C8DC433EF;
        Fri, 27 Jan 2023 03:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674788536;
        bh=51mW/NQ2bd0bv1LqSRI7nTF1Ig/hdRT08p+ujYepq5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzU5k8KAOj/5bMbzX7z9ycu8Q0cvEmSIUXgSssWOP5vuN9b5vdYO1XTGxq7Ek/J+Z
         uBThIoCskiT4FZ/tZTxC/0yjBIrF0UI13V94nwfQ0LEg4W6AEka2mh1WsaUb1pYsef
         OVwxtzLT7yX97kX/7eMFDiwCF1bi6cN+8HOJUq5eTKZqOTqcOydPK0Hhbwxb9CyP3m
         TgZAj+QV6nXswBWwkM9jbQEaOYq4AvdUeQfRtvUkRRm2lL84ZRnmdngdObOFiIMfG+
         4xaOaSCyLgflPN+bCX1QI2OFzUYCLF4wm46WecbIh67lbgtpal0yz5SbbrSDew1If9
         PinY5U4fPgAGw==
Date:   Thu, 26 Jan 2023 19:02:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <Y9M+tl5CcNfRScds@sol.localdomain>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-3-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:23:46PM +0000, Matthew Wilcox (Oracle) wrote:
> fscrypt_is_bounce_folio() is the equivalent of fscrypt_is_bounce_page()
> and fscrypt_pagecache_folio() is the equivalent of fscrypt_pagecache_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/fscrypt.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 4f5f8a651213..c2c07d36fb3a 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -273,6 +273,16 @@ static inline struct page *fscrypt_pagecache_page(struct page *bounce_page)
>  	return (struct page *)page_private(bounce_page);
>  }
>  
> +static inline bool fscrypt_is_bounce_folio(struct folio *folio)
> +{
> +	return folio->mapping == NULL;
> +}
> +
> +static inline struct folio *fscrypt_pagecache_folio(struct folio *bounce_folio)
> +{
> +	return bounce_folio->private;
> +}

ext4_bio_write_folio() is still doing:

	bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page, ...);

Should it be creating a "bounce folio" instead, or is that not in the scope of
this patchset?

- Eric
