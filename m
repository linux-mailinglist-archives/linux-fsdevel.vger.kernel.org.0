Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E030E72FFFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjFNN0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjFNN0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D61BEF;
        Wed, 14 Jun 2023 06:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77AB364247;
        Wed, 14 Jun 2023 13:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01795C433C0;
        Wed, 14 Jun 2023 13:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686749206;
        bh=nPNRrMeXI1rGe6CmC5fnrg+eHs1DY5z0cl/EbfjndVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XCaqMDjv1V+TLzxklaM9RIBrUWbptvN+ZKs8US/UCssImMMGmBEtjRJz8gTE9uOvb
         wUmRNKxQYjI4qlzEPHqA9JyBGLIJgFqr0UX8N0oRDALhAJD47wDhQ1uwsyk+6MozGy
         IuBnuyFOZvk1nW1Bhhj/3hiW8GIsD5ggHVeadQniF3UbIrvQ01jtQLfZTqzDuWQ1+v
         KNotEDu7qFRqRthl1F7ufQ2JnqwItJlLS3JTgPB/WHzPjFrruUvdGahLBEtNx5jwOi
         dGPLQKplRjGoVqVTxuNR1rk0Po5PnP9mduN/9Nh39zEFDFVF8UVQkxchM8EVGkU0v4
         AN+CdaVlFnIKg==
Date:   Wed, 14 Jun 2023 15:26:41 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs: use backing_file container for internal files
 with "fake" f_path
Message-ID: <20230614-kilowatt-kindgerecht-46c7210ee82e@brauner>
References: <20230614074907.1943007-1-amir73il@gmail.com>
 <20230614074907.1943007-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614074907.1943007-2-amir73il@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:49:06AM +0300, Amir Goldstein wrote:
> Overlayfs and cachefiles use open_with_fake_path() to allocate internal
> files, where overlayfs also puts a "fake" path in f_path - a path which
> is not on the same fs as f_inode.
> 
> Allocate a container struct backing_file for those internal files, that
> is used to hold the "fake" ovl path along with the real path.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/cachefiles/namei.c |  4 +--
>  fs/file_table.c       | 74 +++++++++++++++++++++++++++++++++++++------
>  fs/internal.h         |  5 +--
>  fs/open.c             | 30 +++++++++++-------
>  fs/overlayfs/file.c   |  4 +--
>  include/linux/fs.h    | 24 +++++++++++---
>  6 files changed, 109 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 82219a8f6084..283534c6bc8d 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -560,8 +560,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>  	 */
>  	path.mnt = cache->mnt;
>  	path.dentry = dentry;
> -	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
> -				   d_backing_inode(dentry), cache->cache_cred);
> +	file = open_backing_file(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
> +				 &path, cache->cache_cred);
>  	if (IS_ERR(file)) {
>  		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
>  					   PTR_ERR(file),
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 372653b92617..138d5d405df7 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -44,18 +44,40 @@ static struct kmem_cache *filp_cachep __read_mostly;
>  
>  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
>  
> +/* Container for backing file with optional real path */
> +struct backing_file {
> +	struct file file;
> +	struct path real_path;
> +};
> +
> +static inline struct backing_file *backing_file(struct file *f)
> +{
> +	return container_of(f, struct backing_file, file);
> +}
> +
> +struct path *backing_file_real_path(struct file *f)
> +{
> +	return &backing_file(f)->real_path;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_real_path);
> +
>  static void file_free_rcu(struct rcu_head *head)
>  {
>  	struct file *f = container_of(head, struct file, f_rcuhead);
>  
>  	put_cred(f->f_cred);
> -	kmem_cache_free(filp_cachep, f);
> +	if (unlikely(f->f_mode & FMODE_BACKING))
> +		kfree(backing_file(f));
> +	else
> +		kmem_cache_free(filp_cachep, f);
>  }
>  
>  static inline void file_free(struct file *f)
>  {
>  	security_file_free(f);
> -	if (!(f->f_mode & FMODE_NOACCOUNT))
> +	if (unlikely(f->f_mode & FMODE_BACKING))
> +		path_put(backing_file_real_path(f));
> +	else
>  		percpu_counter_dec(&nr_files);

I think this needs to be:

if (unlikely(f->f_mode & FMODE_BACKING))
        path_put(backing_file_real_path(f));

if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
        percpu_counter_dec(&nr_files);

as we do have FMODE_NOACCOUNT without FMODE_BACKING.

No need to resend though.
