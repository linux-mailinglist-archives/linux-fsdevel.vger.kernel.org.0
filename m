Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA187B4FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjJBJ7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbjJBJ6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:58:46 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E631701;
        Mon,  2 Oct 2023 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696240699;
        bh=0/JUjvNFCrqTLBeZW08iULSeezWaCcDvX52IIMuk8OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbM0R+4xbgFaAb/Nj2sUi5FqA2WuSaT4FRA1gudCZOXzDuDGxMWu8IQiFOMSJoaMA
         ItU+ffnOyrdHSu3RIgmRq6Z/usFV1HcOvMe8F3BOepaF3SmsJeaQSiEj0H4t1okEDN
         L8NivrXvVG2WNkmHvPDG9jkubnLjLvCiB+pzUVXc=
Date:   Mon, 2 Oct 2023 11:58:18 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 01/29] xattr: make the xattr array itself const
Message-ID: <cf669914-8e9e-4eac-b28a-f307bb080bec@t-8ch.de>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-2-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930050033.41174-2-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-09-30 02:00:05-0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> As it is currently declared, the xattr_handler structs are const but the
> array containing their pointers is not. This patch makes it so that fs
> modules can place them in .rodata, which makes it harder for
> accidental/malicious modifications at runtime.

You could also add an entry to scripts/const_structs.checkpatch to make
sure newly introduced usages of the struct are const.

Could be a single dedicated patch after this patch has been applied.

> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  fs/xattr.c         | 6 +++---
>  include/linux/fs.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e7bbb7f57557..1905f8ede13d 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -56,7 +56,7 @@ strcmp_prefix(const char *a, const char *a_prefix)
>  static const struct xattr_handler *
>  xattr_resolve_name(struct inode *inode, const char **name)
>  {
> -	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
> +	const struct xattr_handler * const *handlers = inode->i_sb->s_xattr;
>  	const struct xattr_handler *handler;
>  
>  	if (!(inode->i_opflags & IOP_XATTR)) {
> @@ -162,7 +162,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
>  int
>  xattr_supports_user_prefix(struct inode *inode)
>  {
> -	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
> +	const struct xattr_handler * const *handlers = inode->i_sb->s_xattr;
>  	const struct xattr_handler *handler;
>  
>  	if (!(inode->i_opflags & IOP_XATTR)) {
> @@ -999,7 +999,7 @@ int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
>  ssize_t
>  generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  {
> -	const struct xattr_handler *handler, **handlers = dentry->d_sb->s_xattr;
> +	const struct xattr_handler *handler, * const *handlers = dentry->d_sb->s_xattr;
>  	ssize_t remaining_size = buffer_size;
>  	int err = 0;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 562f2623c9c9..4d8003f48216 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1172,7 +1172,7 @@ struct super_block {
>  #ifdef CONFIG_SECURITY
>  	void                    *s_security;
>  #endif
> -	const struct xattr_handler **s_xattr;
> +	const struct xattr_handler * const *s_xattr;
>  #ifdef CONFIG_FS_ENCRYPTION
>  	const struct fscrypt_operations	*s_cop;
>  	struct fscrypt_keyring	*s_master_keys; /* master crypto keys in use */
> -- 
> 2.34.1
> 
