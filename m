Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12DB752322
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjGMNPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjGMNPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884951FD6;
        Thu, 13 Jul 2023 06:15:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 256BE6128D;
        Thu, 13 Jul 2023 13:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B661C433C8;
        Thu, 13 Jul 2023 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689254105;
        bh=GY7YW0NDbyAXhLh7PVs1GqXyunCbjwnqMK2AIPwbOJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kI7PL8ieoLfBKGZIUV2xSTT1Xou4AHqEASuvY3lRim9MU8YQRsFCX+g+3qLkwM2cM
         cQVCc3V9wopZaGepRCt7I1jPk4NQ8g02SKGl02mzslc3lA5wCef02WJQZ+ncPOU/V3
         Y/6hbCwt52JmtlwFlKJTyZ88IQS3jwM2ztGyNiqYH2GqJVFx746FcQY11xhNK/QKBq
         nRK77uVCJ7+/lEVLCmcOvVm8DAhT8qPihADIzSumK8iGUzuDC0cf5C8WfxzjbrRZ9R
         rLH+14UH0ir9GhEfrAld4L3mMzpR1K8afYLiKETL+KeLEq5bKOAa79MkoBzlAVeXtz
         sR1ul9Vds5Xfg==
Date:   Thu, 13 Jul 2023 15:15:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs: Fix error checking for d_hash_and_lookup()
Message-ID: <20230713-weintrauben-unbezahlbar-46ebe352f4da@brauner>
References: <20230713110513.5626-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713110513.5626-1-machel@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:05:00PM +0800, Wang Ming wrote:
> In case of failure, debugfs_create_dir() returns NULL or an error

What on earth does debugfs_create_dir() have to do with this?

> pointer. Most incorrect error checks were fixed, but the one in
> d_add_ci() was forgotten.
> 
> Fixes: d9171b934526 ("parallel lookups machinery, part 4 (and last)")
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 52e6d5fdab6b..2f03e275d2e0 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2220,7 +2220,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
>  	 * if not go ahead and create it now.
>  	 */
>  	found = d_hash_and_lookup(dentry->d_parent, name);
> -	if (found) {
> +	if (!IS_ERR_OR_NULL(found)) {

I don't understand.

If d_hash_and_lookup() fails due to custom hash function failure then
the old code bubbles that upwards. You're changing that so that it now
adds a new dentry under the generic hash. That can't possibly be correct.
