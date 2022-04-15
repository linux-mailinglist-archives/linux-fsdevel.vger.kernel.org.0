Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE58502BA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354362AbiDOOUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 10:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiDOOUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:20:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7CACF486;
        Fri, 15 Apr 2022 07:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55517B82E33;
        Fri, 15 Apr 2022 14:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4C3C385A5;
        Fri, 15 Apr 2022 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650032266;
        bh=L1loXxXsShKFYfH6N3c8VKq+/adfk8vKEkNsvVLMshg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2sFtsftOgvF6scuQt+Fpj3FCZP5Bx6m8dXOl0q/5gpDeYcHNlW8s6i55Vhcffh/o
         /CfEyF7fDIUzvyuX4Knp+CPrAr3mAUIWUAcrl26+ZQ9CtscM2df3raGyVxk7BAn1W7
         WVC/ZzKfLzo8OUgAB7RHtJeAnIG9xOqhbixOiY/Fv93VexW7I95nl/s2J6TTtRKjmk
         7CmO8/WN9Lw56YZ+8T7OfW7moLVObtqY87GQaiemdduaU12dF9zq9OR4FggvLtqwoG
         rDgIY70FWfbEbX7sbqnl5nnpt3KnFdXBCkp/1abh8Bu4m8aJqnr6ztZcYBFmpnWYj/
         GRu3mSOAlrkaw==
Date:   Fri, 15 Apr 2022 16:17:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, jlayton@kernel.org
Subject: Re: [PATCH v3 2/7] fs/namei.c: Add missing umask strip in vfs_tmpfile
Message-ID: <20220415141741.q7i7wwcmuzo5dgav@wittgenstein>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650020543-24908-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650020543-24908-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:02:18PM +0800, Yang Xu wrote:
> If underflying filesystem doesn't enable own CONFIG_FS_POSIX_ACL, then
> posix_acl_create can't be called. So we will miss umask strip, ie
> use ext4 with noacl or disblae CONFIG_EXT4_FS_POSIX_ACL.

Hm, maybe:

"All creation paths except for O_TMPFILE handle umask in the vfs
directly if the filesystem doesn't support or enable POSIX ACLs. If the
filesystem does then umask handling is deferred until
posix_acl_create().
Because, O_TMPFILE misses umask handling in the vfs it will not honor
umask settings. Fix this by adding the missing umask handling."

> 
> Reported-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

>  fs/namei.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..bbc7c950bbdc 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3521,6 +3521,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  	child = d_alloc(dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> +	if (!IS_POSIXACL(dir))
> +		mode &= ~current_umask();
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
>  	if (error)
>  		goto out_err;
> -- 
> 2.27.0
> 
