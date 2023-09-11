Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42B79BB54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbjIKU5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjIKNm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:42:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C0CD7;
        Mon, 11 Sep 2023 06:42:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968C7C433C7;
        Mon, 11 Sep 2023 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694439773;
        bh=luUkSGr/g5UNfuIV8IpfxJSLFBmv1BjknPmAkfe143w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPGeJeccNlGflzm50XhI+D9GHgCoPz0c4xogcHZQHW3hZq9r2PkwPIzYvqq4bQGh2
         nhFxz1zufm298bm8DUw+hBsDuyfRNWPYthr1OxWvoBWZ/uHSz8oDU4v0pylZQENvH0
         bMRIQCBCOx2Hl9Omiw4MlsItN0Qab0rtOP/zC3uhI/f6tnK1bE2GrX4DF2WmUP2eYr
         qGaSANvydOe7rmCOAPmIWyMFSmjeK+DXhuitzl9OSx1zvq3IR6AAJgzzXgRd2WgWSw
         KGWL00URM4x+PToxHUwXayntkhxhdOkI6YA9Ip3MNX38+Js1dCBikfVaf588zD+bdb
         SuLNlscZMC3yA==
Date:   Mon, 11 Sep 2023 15:42:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] fs: add a new SB_NOUMASK flag
Message-ID: <20230911-blasen-zieren-4d65d9bc245e@brauner>
References: <20230910-acl-fix-v2-1-38d6caa81419@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230910-acl-fix-v2-1-38d6caa81419@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 10, 2023 at 03:30:48PM -0400, Jeff Layton wrote:
> SB_POSIXACL must be set when a filesystem supports POSIX ACLs, but NFSv4
> also sets this flag to prevent the VFS from applying the umask on
> newly-created files. NFSv4 doesn't support POSIX ACLs however, which
> causes confusion when other subsystems try to test for them.
> 
> Split the umask-stripping opt-out into a separate SB_NOUMASK flag, and
> have NFSv4 set that instead of SB_POSIXACL. Fix the appropriate places
> in the VFS to check for that flag (in addition to SB_POSIXACL) when
> stripping the umask.

Oh, I see you only raised SB_POSIXACL to avoid umask stripping. That's a
bit weird indeed. Hm, since this is an internal, non-user changeable
flag I think it might be better in s_iflags as SB_I_NOUMASK? Also allows
us to avoid wasting an s_flags bit.

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Yet another approach to fixing this issue. I think this way is probably
> the best, since makes the purpose of these flags clearer, and stops NFS
> from relying on SB_POSIXACL to avoid umask stripping.
> ---
> Changes in v2:
> - new approach: add a new SB_NOUMASK flag that NFSv4 can use instead of
>   SB_POSIXACL
> - Link to v1: https://lore.kernel.org/r/20230908-acl-fix-v1-1-1e6b76c8dcc8@kernel.org
> ---
>  fs/init.c          | 4 ++--
>  fs/namei.c         | 2 +-
>  fs/nfs/super.c     | 2 +-
>  include/linux/fs.h | 4 +++-
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/init.c b/fs/init.c
> index 9684406a8416..157404bb7d19 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -153,7 +153,7 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> +	if (!IS_NOUMASK(path.dentry->d_inode))
>  		mode &= ~current_umask();
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (!error)
> @@ -229,7 +229,7 @@ int __init init_mkdir(const char *pathname, umode_t mode)
>  	dentry = kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIRECTORY);
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> +	if (!IS_NOUMASK(path.dentry->d_inode))
>  		mode &= ~current_umask();

Could you please just convert them over to mode_strip_umask()?
Seems I forgot these two places back then.
