Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E28745AA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 12:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGCK4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCK4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:56:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31213BE
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 03:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B94A060ECA
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 10:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C525C433C9;
        Mon,  3 Jul 2023 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688381772;
        bh=JcSZaMuu9LH/CZwR0FvWrfVo7dMB/pwfu3IZSczSvh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn0Tylw/m+HS91oTUx11W3SZCUk93HwG/gX25HMfThZY2/UerLRDdmT/3w+E8QoJD
         DQ9u+78L/STEcu2GUzkGSkFuX8rCJRSWXsQmXfocj+NVPp0SG2QSqbtvdJrFLRnC1U
         SpcjsD/NSkXmBT1/vsh/lF5TUl9L46MjEByScJkwszTb+eL0/DLC1mWj8Jga75gl+8
         8RnDAVRmMPCCRV+4GMgw91CWSbMlruY1fewWu29I6hGH43ZWb1DwgWKqn4n2Q4PztS
         bcNU3JYVUVCAY0KZDdpTeuLXchnUfR2IwumitAmK1nQMfsYZcv2Sel2AYEQ6VTJQvD
         XOQnob+QcwpHg==
Date:   Mon, 3 Jul 2023 12:56:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, Chuck Lever <chuck.lever@oracle.com>,
        jlayton@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] libfs: Add directory operations for stable offsets
Message-ID: <20230703-semester-geklagt-227cd899b31e@brauner>
References: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
 <168814732984.530310.11190772066786107220.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168814732984.530310.11190772066786107220.stgit@manet.1015granger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 01:48:49PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Create a vector of directory operations in fs/libfs.c that handles
> directory seeks and readdir via stable offsets instead of the
> current cursor-based mechanism.
> 
> For the moment these are unused.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  Documentation/filesystems/locking.rst |    2 
>  Documentation/filesystems/vfs.rst     |    6 +
>  fs/libfs.c                            |  247 +++++++++++++++++++++++++++++++++
>  include/linux/fs.h                    |   18 ++
>  4 files changed, 272 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index ed148919e11a..6a928fee3400 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -85,6 +85,7 @@ prototypes::
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>  	struct posix_acl * (*get_acl)(struct mnt_idmap *, struct dentry *, int);
> +	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>  
>  locking rules:
>  	all may block
> @@ -115,6 +116,7 @@ atomic_open:	shared (exclusive if O_CREAT is set in open flags)
>  tmpfile:	no
>  fileattr_get:	no or exclusive
>  fileattr_set:	exclusive
> +get_offset_ctx: no
>  ==============	=============================================
>  
>  
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index cb2a97e49872..898d0b43109e 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -515,6 +515,7 @@ As of kernel 2.6.22, the following members are defined:
>  		int (*fileattr_set)(struct mnt_idmap *idmap,
>  				    struct dentry *dentry, struct fileattr *fa);
>  		int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
> +	        struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
>  	};
>  
>  Again, all methods are called without any locks being held, unless
> @@ -675,7 +676,10 @@ otherwise noted.
>  	called on ioctl(FS_IOC_SETFLAGS) and ioctl(FS_IOC_FSSETXATTR) to
>  	change miscellaneous file flags and attributes.  Callers hold
>  	i_rwsem exclusive.  If unset, then fall back to f_op->ioctl().
> -
> +``get_offset_ctx``
> +	called to get the offset context for a directory inode. A
> +        filesystem must define this operation to use
> +        simple_offset_dir_operations.
>  
>  The Address Space Object
>  ========================
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 5b851315eeed..68b0000dc518 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -239,6 +239,253 @@ const struct inode_operations simple_dir_inode_operations = {
>  };
>  EXPORT_SYMBOL(simple_dir_inode_operations);
>  
> +static void offset_set(struct dentry *dentry, unsigned long offset)
> +{
> +	dentry->d_fsdata = (void *)offset;
> +}
> +
> +static unsigned long dentry2offset(struct dentry *dentry)
> +{
> +	return (unsigned long)dentry->d_fsdata;
> +}

This looks fine to me and tmpfs xfstests seem happy too. Currently we
use unsigned long in some places, and u32 in some other places. It's not
a big deal but I would prefer if we kept this consistent and made it
clear everywhere that the offset is a 32 bit unsigned and that the
xarray's limit is U32_MAX. So I would like to fold the following change
into this series unless there are objections:

diff --git a/fs/libfs.c b/fs/libfs.c
index 68b0000dc518..a7e56baf8bbd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,14 +239,14 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);

-static void offset_set(struct dentry *dentry, unsigned long offset)
+static void offset_set(struct dentry *dentry, u32 offset)
 {
-       dentry->d_fsdata = (void *)offset;
+       dentry->d_fsdata = (void *)((uintptr_t)(offset));
 }

-static unsigned long dentry2offset(struct dentry *dentry)
+static u32 dentry2offset(struct dentry *dentry)
 {
-       return (unsigned long)dentry->d_fsdata;
+       return (u32)((uintptr_t)(dentry->d_fsdata));
 }

 /**
@@ -296,12 +296,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-       unsigned long index = dentry2offset(dentry);
+       u32 offset;

-       if (index == 0)
+       offset = dentry2offset(dentry);
+       if (offset == 0)
                return;

-       xa_erase(&octx->xa, index);
+       xa_erase(&octx->xa, offset);
        offset_set(dentry, 0);
 }

@@ -322,8 +323,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 {
        struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
        struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
-       unsigned long old_index = dentry2offset(old_dentry);
-       unsigned long new_index = dentry2offset(new_dentry);
+       u32 old_index = dentry2offset(old_dentry);
+       u32 new_index = dentry2offset(new_dentry);
        int ret;

        simple_offset_remove(old_ctx, old_dentry);
@@ -414,7 +415,7 @@ static struct dentry *offset_find_next(struct xa_state *xas)

 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-       loff_t offset = dentry2offset(dentry);
+       u32 offset = dentry2offset(dentry);
        struct inode *inode = d_inode(dentry);

        return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,

