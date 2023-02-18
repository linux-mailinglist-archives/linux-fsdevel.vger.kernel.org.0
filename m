Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EE69B8C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBRIia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRIi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:38:29 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4612A6C3;
        Sat, 18 Feb 2023 00:38:28 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 12C33C01F; Sat, 18 Feb 2023 09:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676709531; bh=6nGYl4ejl2yh1QxdThtP9LlS0BqHmw+97k9eUDdQAZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5C7J7gpZXN8ykRW8xUMfu42nIDzGdbo2sYRoYTUjNn8I4287KdBp+aMo8jaFn+a+
         7IFiHtVATQnDHRL59eojmQLlX1uIKuqSWoQowGuO6n5xpFfjLC4R9q/t7gz46qFpi0
         NVhoGiPHCoH7LI8iykaWtAxm41Pfse/ayRZfsJMuhk4WrZwZSljjz5eIYSIjct5xVm
         FSepyZR2EQUH48Fv7iVyE9QLtHltOzeuhrDPw8j1XVA5kyVtvkslRLmG+q1jBn+CmT
         NU6FnMuDpHWWqSQ0vfIpgbIDPR8qfAh2PT0AXDg6Oaa0t58xTtZpdMR3AvMOgBHpOU
         didHFpfMD0C8A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7251FC009;
        Sat, 18 Feb 2023 09:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676709529; bh=6nGYl4ejl2yh1QxdThtP9LlS0BqHmw+97k9eUDdQAZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCXyXZ5HJplA4zxCLnbvG+69kgYc+r1fvx0ob7kNc+oeizj3bYMCk6yvb4xlBAj8l
         BrLaETACkLt1iaFCCToVS99jS7dxr+abePVGxIxJSvaZnlAaCrWvoqkc+9mkxgEX8n
         RPz1Nf0OcdFHmO0ItdHDT2xNOSF9CHWgM50ogjq2jIUwDABemUKTsHpsdO4XQWTMtJ
         /QG3ld/BdNGIoETiygulWZ5eFWext6QyawMQHHOCZOYt91zmnvNkvSx3TEcvkf2w34
         zVyDuq4LwU7jQUR44Ox3t0GJXvNPxy1BUwmHYzzNxVQqICeFxALVuCDoYO0vT052LS
         3gpmU4+EEkylA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id eab71d22;
        Sat, 18 Feb 2023 08:38:21 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:38:06 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 10/11] fs/9p: writeback mode fixes
Message-ID: <Y/CObgqBJT/xq3LU@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-11-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-11-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(not reviewed this yet, just a kerneldoc warning first before I forget)

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:22AM +0000:
> diff --git a/fs/9p/fid.c b/fs/9p/fid.c
> index 805151114e96..8c1697619f3d 100644
> --- a/fs/9p/fid.c
> +++ b/fs/9p/fid.c
> @@ -41,14 +40,24 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
>  	*pfid = NULL;
>  }
>  
> +static bool v9fs_is_writeable(int mode)
> +{
> +	if ((mode & P9_OWRITE) || (mode & P9_ORDWR))
> +		return true;
> +	else
> +		return false;
> +}
> +
>  /**
>   * v9fs_fid_find_inode - search for an open fid off of the inode list
>   * @inode: return a fid pointing to a specific inode
> + * @writeable: only consider fids which are writeable

`make M=fs/9p W=1` complains about doc discreptancy here,
writeable vs. want_writeable.

These are a pain, but let's make sure new ones don't creep in...
(I just wish we could make W=1 the default for part of the subtree, but
I didn't find an easy way to do so last time I checked -- perhaps you'll
have more luck if you have time to look)

>   * @uid: return a fid belonging to the specified user
> + * @any: ignore uid as a selection criteria
>   *
>   */
> -
> -static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
> +struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
> +	kuid_t uid, bool any)

-- 
Dominique
