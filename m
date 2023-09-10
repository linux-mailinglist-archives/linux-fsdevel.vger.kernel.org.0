Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9001799D9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344299AbjIJKOk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 06:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjIJKOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:14:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAB1B9;
        Sun, 10 Sep 2023 03:14:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16153C433C8;
        Sun, 10 Sep 2023 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694340875;
        bh=FcbyUTC8LwbVO6fXxkjxNDRy4yluvy9SqC6820WKn7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G32gfl1F0gvB0j9yuJ4msecfFMZqYrIKINC2z4TOfcW0tnwiAM2HhTaVU8W1wMOwH
         zOj7gXx2zM7/unXYC8VN6r3ZfrH/zIhuT5+JdZB+/+PFlXaTJZHLHBmW2LkrgmRCu+
         DRERt+3JX+wMGsGt+WjMzUrGpUx+/VPwHdVGybMc/ERbQhgO/DDDBIawklF8OYUdKu
         /BMs41GKaTYvUAtLQwn1pj9zSmf/7qx550FBnlJIQ8UUmo8yWmGlRWhP/MFcgKLt3m
         jRSD83I6P6DFRH0eTZosD94RiuOVURdDeJYWB6ZOOSP9EF0xTuRG60ebgX33okCbg/
         IF4+wJ4UzUgBw==
Date:   Sun, 10 Sep 2023 12:14:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: fix regression querying for ACL on fs's that don't
 support them
Message-ID: <20230910-gingen-maulkorb-918c8c2ce6bf@brauner>
References: <20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:05:27PM -0400, Jeff Layton wrote:
> In the not too distant past, the VFS ACL infrastructure would return
> -EOPNOTSUPP on filesystems (like NFS) that set SB_POSIXACL but that
> don't supply a get_acl or get_inode_acl method. On more recent kernels
> this returns -ENODATA, which breaks one method of detecting when ACLs
> are supported.
> 
> Fix __get_acl to also check whether the inode has a "get_(inode_)?acl"
> method and to just return -EOPNOTSUPP if not.
> 
> Reported-by: Ondrej Valousek <ondrej.valousek.xm@renesas.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This patch is another approach to fixing this issue. I don't care too
> much either way which approach we take, but this may fix the problem
> for other filesystems too. Should we take a belt and suspenders
> approach here and fix it in both places?
> ---
>  fs/posix_acl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index a05fe94970ce..4c7c62040c43 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -130,8 +130,12 @@ static struct posix_acl *__get_acl(struct mnt_idmap *idmap,
>  	if (!is_uncached_acl(acl))
>  		return acl;
>  
> -	if (!IS_POSIXACL(inode))
> -		return NULL;
> +	/*
> +	 * NB: checking this after checking for a cached ACL allows tmpfs
> +	 * (which doesn't specify a get_acl operation) to work properly.
> +	 */
> +	if (!IS_POSIXACL(inode) || (!inode->i_op->get_acl && !inode->i_op->get_inode_acl))
> +		return ERR_PTR(-EOPNOTSUPP);

Hmmm, I think that'll cause issues for permission checking during
lookup:

generic_permission()
-> acl_permission_check()
   -> check_acl()
      -> get_inode_acl()
         -> __get_acl()
            // return ERR_PTR(-EOPNOTSUPP) instead of NULL

Before this change this would've returned NULL and thus check_acl()
would've returned EAGAIN which would've informed acl_permission_check()
to continue with non-ACL based permission checking.

Now you're going to error out with EOPNOTSUPP and cause permission
checking to fallback to CAP_DAC_READ_SEARCH/CAP_DAC_OVERRIDE.

So if you want this change you'll either need to change check_acl() as well.
Unless I'm misreading.
