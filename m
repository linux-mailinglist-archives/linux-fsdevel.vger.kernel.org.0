Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692AF5A4C96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiH2M4Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiH2M4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0DF82D19;
        Mon, 29 Aug 2022 05:46:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6F1F611F3;
        Mon, 29 Aug 2022 12:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6686C433C1;
        Mon, 29 Aug 2022 12:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661777208;
        bh=J0mcC7UYfMKVxofSYv/hrMFUt+y1yW9b2NCEnvYuWoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYy2atP3SBIZ2iQhFKKewooxWCWsXAo8D7Nq3ypb63jukUTB9UucmCgFuzcHh8RnC
         SVxPn79KUzSPFosb0fj6GdFggmXvZeVdblp40sZD6iSpg6tjCROFdM12mb2Qsw6tjw
         GlOVrXcus5VGMY2lLPJtNaka6mNV3VSrk3+JCbeGsQpv5ifR6zzkSz6BSZK0Pm3nco
         P7qM/wi93mYiFGdJPd6VIg3l5CngeO1x+xw5bB4zwx79Gj2HZOkD6jVhNVrgcES/eW
         H8ho/yI9s1rtTsE9iYSYygClzWNQ9eLZ3e46lKOfrkZTzFkaRP05pgJEQEUrvNp39x
         V8YUlql/kMqYQ==
Date:   Mon, 29 Aug 2022 14:46:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 5/6] ovl: use vfs_set_acl_prepare()
Message-ID: <20220829124638.ur7sv4kectw6xgaz@wittgenstein>
References: <20220829123843.1146874-1-brauner@kernel.org>
 <20220829123843.1146874-6-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829123843.1146874-6-brauner@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Sorry, forgot to Cc ovl developers on accident.]

On Mon, Aug 29, 2022 at 02:38:44PM +0200, Christian Brauner wrote:
> The posix_acl_from_xattr() helper should mainly be used in
> i_op->get_acl() handlers. It translates from the uapi struct into the
> kernel internal POSIX ACL representation and doesn't care about mount
> idmappings.
> 
> Use the vfs_set_acl_prepare() helper to generate a kernel internal POSIX
> ACL representation in struct posix_acl format taking care to map from
> the mount idmapping into the filesystem's idmapping.
> 
> The returned struct posix_acl is in the correct format to be cached by
> the VFS or passed to the filesystem's i_op->set_acl() method to write to
> the backing store.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ec746d447f1b..5da771b218d1 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1022,7 +1022,20 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
>  
>  	/* Check that everything is OK before copy-up */
>  	if (value) {
> -		acl = posix_acl_from_xattr(&init_user_ns, value, size);
> +		/* The above comment can be understood in two ways:
> +		 *
> +		 * 1. We just want to check whether the basic POSIX ACL format
> +		 *    is ok. For example, if the header is correct and the size
> +		 *    is sane.
> +		 * 2. We want to know whether the ACL_{GROUP,USER} entries can
> +		 *    be mapped according to the underlying filesystem.
> +		 *
> +		 * Currently, we only check 1. If we wanted to check 2. we
> +		 * would need to pass the mnt_userns and the fs_userns of the
> +		 * underlying filesystem. But frankly, I think checking 1. is
> +		 * enough to start the copy-up.
> +		 */
> +		acl = vfs_set_acl_prepare(&init_user_ns, &init_user_ns, value, size);
>  		if (IS_ERR(acl))
>  			return PTR_ERR(acl);
>  	}
> -- 
> 2.34.1
> 
