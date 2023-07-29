Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699DD767C1F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 06:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjG2Ee0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2EeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE544BB;
        Fri, 28 Jul 2023 21:34:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B244A60C11;
        Sat, 29 Jul 2023 04:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35BAC433C8;
        Sat, 29 Jul 2023 04:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690605264;
        bh=kreUmZhVx1mtOQtL4BLyEky6B76tt7CikJVFHDwTUDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3ACFzB5JU4CZFIy3kz5qW/uEJymTZKy9b8a0ZW6k16Rv+cJORCna0dpWt/V/2PIN
         CcGK8y6VM1KgA2fU/WGBEhbjCepAo7/4KzC268LgpvYlL91cuzE0KN7I1W2BC6o0HK
         69PyzjLspVEBL2ZJ1C83qA4a8scAJXxGtATEH+OP7dTsG4F9GIsrEbEHxUysLaMMjG
         ximW/8wk6s2jgrpkrPgeQWZ+sPVT3ToqMYGOMc8zhNvDc3KA6c+wbhCBiTg5x8tnTi
         ST7BFkCgusvLK0zV0tIF9vbJv8eowSdcQVADWu44x9Dnc5Qy2NbWf6bSJrJaU4zE3b
         jdumDe3n3xakQ==
Date:   Fri, 28 Jul 2023 21:34:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v4 2/7] fs: Add DCACHE_CASEFOLDED_NAME flag
Message-ID: <20230729043422.GC4171@sol.localdomain>
References: <20230727172843.20542-1-krisman@suse.de>
 <20230727172843.20542-3-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727172843.20542-3-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:28:38PM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> This flag marks a negative or positive dentry as being created after a
> case-insensitive lookup operation.  It is useful to differentiate
> dentries this way to detect whether the negative dentry can be trusted
> during a case-insensitive lookup.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v2:
>   -  Rename DCACHE_CASEFOLD_LOOKUP -> DCACHE_CASEFOLDED_NAME (Eric)
> ---
>  fs/dcache.c            | 8 ++++++++
>  include/linux/dcache.h | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 98521862e58a..5791489b589f 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1958,6 +1958,14 @@ void d_set_fallthru(struct dentry *dentry)
>  }
>  EXPORT_SYMBOL(d_set_fallthru);
>  
> +void d_set_casefold_lookup(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	dentry->d_flags |= DCACHE_CASEFOLDED_NAME;
> +	spin_unlock(&dentry->d_lock);
> +}
> +EXPORT_SYMBOL(d_set_casefold_lookup);

d_set_casefolded_name()

> +static inline bool d_is_casefold_lookup(const struct dentry *dentry)
> +{
> +	return dentry->d_flags & DCACHE_CASEFOLDED_NAME;
> +}

d_is_casefolded_name().  Or even better, just write 'dentry->d_flags &
DCACHE_CASEFOLDED_NAME' directly in the one place that actually needs this?

- Eric
