Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB4E779C94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjHLCPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 22:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHLCPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:15:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7AC10D;
        Fri, 11 Aug 2023 19:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35CBA6119B;
        Sat, 12 Aug 2023 02:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B880C433C8;
        Sat, 12 Aug 2023 02:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691806552;
        bh=KRiuSZ+g+fA52so2sUF9SK35HMY9HSY0nSS7XM1qPgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSq8ZX2ujqo46WGhRXpCETugPT/Q4qr5QAEG0EHPYPxqV7UKVaBd0zbqV6y3YwMYK
         h5kw/3IVRl00qubfBum/O07XD5Wa6UQCLUedj+xLvRAHDtI9p9jLlq5e7p2Qt7DB1Y
         59Lqrg5CfFzakIXzHJckj1ZOVSSQNgG62iDfaIoEQYOL2xUBRIZv4Mtq9wC0z6oXLg
         K6gjmWBsD4oRhXk4dGiGw+hHg76oaWLs/5Hk7tjpXAt2LBIH83hdNZRKO63SXmOyib
         KEMoh5nAiUgBMoL0DttOirqLBTDRUW9UI10orCLh/IATs9AAPFRcIfAqZ+50ZJTme0
         R1+LITZEICTxw==
Date:   Fri, 11 Aug 2023 19:15:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate
 hooks
Message-ID: <20230812021550.GB971@sol.localdomain>
References: <20230812004146.30980-1-krisman@suse.de>
 <20230812004146.30980-5-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-5-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:41:40PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index cb2a97e49872..ddd542c2a722 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1251,7 +1251,8 @@ defined:
>  .. code-block:: c
>  
>  	struct dentry_operations {
> -		int (*d_revalidate)(struct dentry *, unsigned int);
> +		int (*d_revalidate)(struct dentry *, const struct qstr *,
> +				    unsigned int);
>  		int (*d_weak_revalidate)(struct dentry *, unsigned int);
>  		int (*d_hash)(const struct dentry *, struct qstr *);
>  		int (*d_compare)(const struct dentry *,
> @@ -1284,6 +1285,14 @@ defined:
>  	they can change and, in d_inode case, even become NULL under
>  	us).
>  
> +	Filesystems shouldn't rely on the name under lookup, unless
> +	there are particular filename encoding semantics to be handled
> +	during revalidation.  Note the name under lookup can change from
> +	under d_revalidate, so it must be protected with ->d_lock before
> +	accessing.  The exception is when revalidating negative dentries
> +	for creation, in which case the parent inode prevents it from
> +	changing.

Actually, the "name under lookup" can never change.  It's passed as the 'name'
argument, newly added by this patch.  What this paragraph is actually about is
the ->d_name of the dentry being revalidated.  The documentation should make it
clear when it means ->d_name and when it means name, how they differ from each
other, and what the purpose of each is.

- Eric
