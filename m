Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF3562552
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbiF3Vej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiF3Vei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:34:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D2D4475B;
        Thu, 30 Jun 2022 14:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E02B82D5A;
        Thu, 30 Jun 2022 21:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FEAC34115;
        Thu, 30 Jun 2022 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656624874;
        bh=QUYChKIH5jkJFejFJhzaJZW9GlRUXUy7m5NnF5YR/lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwitmLFyVG60TsbdfkulminJEZ5nwrrVqfhExwyOd1V/eLDLP47GZgDwPDeM+/ecX
         eNLwcJOjpCL69OuFrCkZqHOt2OeRonCXj6FXZNjcP9Ul1sbHMZ5XC9ZVXz21HyFpl2
         q0K/kQiTaCtKMJ7ET3Ig85OfB55/wiwm/wXtCOl8ZJuGxVu5RKyZ+Yjj5HOfCJ012t
         PA8x9pKw9HK6MD9BrAGD5eQKHY6qQspVCA+jZl1/p5TX+pROVwKdzavdOJ4tlICE1R
         I8kIVcE9EITqs6NBdLwO59vF2OEtGHmkb7B+dWSFzu++FPZrLKUZC2H2P8CgXxSR6v
         aIv/cqvlbR93Q==
Date:   Thu, 30 Jun 2022 14:34:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v2 3/9] mm/mshare: make msharefs writable and support
 directories
Message-ID: <Yr4W6W1i0WOY6zag@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:54PM -0600, Khalid Aziz wrote:
> Make msharefs filesystem writable and allow creating directories
> to support better access control to mshare'd regions defined in
> msharefs.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  mm/mshare.c | 195 +++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 186 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mshare.c b/mm/mshare.c
> index 3e448e11c742..2d5924d39221 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -21,11 +21,21 @@
>  #include <linux/fileattr.h>
>  #include <uapi/linux/magic.h>
>  #include <uapi/linux/limits.h>
> +#include <uapi/linux/mman.h>
>  
>  static struct super_block *msharefs_sb;
>  
> +static const struct inode_operations msharefs_dir_inode_ops;
> +static const struct inode_operations msharefs_file_inode_ops;
> +
> +static int
> +msharefs_open(struct inode *inode, struct file *file)
> +{
> +	return simple_open(inode, file);
> +}
> +
>  static const struct file_operations msharefs_file_operations = {
> -	.open		= simple_open,
> +	.open		= msharefs_open,
>  	.llseek		= no_llseek,
>  };
>  
> @@ -42,6 +52,113 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
>  	return 0;
>  }
>  
> +static struct dentry
> +*msharefs_alloc_dentry(struct dentry *parent, const char *name)
> +{
> +	struct dentry *d;
> +	struct qstr q;
> +	int err;
> +
> +	q.name = name;
> +	q.len = strlen(name);
> +
> +	err = msharefs_d_hash(parent, &q);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	d = d_alloc(parent, &q);
> +	if (d)
> +		return d;
> +
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static struct inode
> +*msharefs_get_inode(struct super_block *sb, const struct inode *dir,
> +			umode_t mode)
> +{
> +	struct inode *inode = new_inode(sb);
> +
> +	if (inode) {

Not sure why you wouldn't go with the less-indently version:

	if (!inode)
		return ERR_PTR(-ENOMEM);

	inode->i_ino = get_next_ino();
	<etc>

> +		inode->i_ino = get_next_ino();
> +		inode_init_owner(&init_user_ns, inode, dir, mode);
> +
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +
> +		switch (mode & S_IFMT) {

Shouldn't we set the mode somewhere?

> +		case S_IFREG:
> +			inode->i_op = &msharefs_file_inode_ops;
> +			inode->i_fop = &msharefs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &msharefs_dir_inode_ops;
> +			inode->i_fop = &simple_dir_operations;
> +			inc_nlink(inode);
> +			break;
> +		case S_IFLNK:
> +			inode->i_op = &page_symlink_inode_operations;
> +			break;
> +		default:
> +			discard_new_inode(inode);
> +			inode = NULL;
> +			break;
> +		}
> +	}
> +
> +	return inode;
> +}
> +
> +static int
> +msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	struct inode *inode;
> +	int err = 0;
> +
> +	inode = msharefs_get_inode(dir->i_sb, dir, mode);
> +	if (IS_ERR(inode))
> +		return PTR_ERR(inode);

...and if @inode is NULL?

> +
> +	d_instantiate(dentry, inode);
> +	dget(dentry);
> +	dir->i_mtime = dir->i_ctime = current_time(dir);
> +
> +	return err;
> +}
> +
> +static int
> +msharefs_create(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode, bool excl)
> +{
> +	return msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
> +}
> +
> +static int
> +msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
> +		struct dentry *dentry, umode_t mode)
> +{
> +	int ret = msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
> +
> +	if (!ret)
> +		inc_nlink(dir);
> +	return ret;
> +}
> +
> +static const struct inode_operations msharefs_file_inode_ops = {
> +	.setattr	= simple_setattr,
> +	.getattr	= simple_getattr,
> +};
> +static const struct inode_operations msharefs_dir_inode_ops = {
> +	.create		= msharefs_create,
> +	.lookup		= simple_lookup,
> +	.link		= simple_link,
> +	.unlink		= simple_unlink,
> +	.mkdir		= msharefs_mkdir,
> +	.rmdir		= simple_rmdir,
> +	.mknod		= msharefs_mknod,
> +	.rename		= simple_rename,
> +};
> +
>  static void
>  mshare_evict_inode(struct inode *inode)
>  {
> @@ -58,7 +175,7 @@ mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
>  {
>  	char s[80];
>  
> -	sprintf(s, "%ld", PGDIR_SIZE);
> +	sprintf(s, "%ld\n", PGDIR_SIZE);

Changing this already?

>  	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>  }
>  
> @@ -72,6 +189,38 @@ static const struct super_operations mshare_s_ops = {
>  	.evict_inode = mshare_evict_inode,
>  };
>  
> +static int
> +prepopulate_files(struct super_block *s, struct inode *dir,
> +			struct dentry *root, const struct tree_descr *files)
> +{
> +	int i;
> +	struct inode *inode;
> +	struct dentry *dentry;
> +
> +	for (i = 0; !files->name || files->name[0]; i++, files++) {
> +		if (!files->name)
> +			continue;

What ends the array?  NULL name or empty name?
Do we have to erase all of these when the fs gets unmounted?

--D

> +
> +		dentry = msharefs_alloc_dentry(root, files->name);
> +		if (!dentry)
> +			return -ENOMEM;
> +
> +		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
> +		if (!inode) {
> +			dput(dentry);
> +			return -ENOMEM;
> +		}
> +		inode->i_mode = S_IFREG | files->mode;
> +		inode->i_atime = inode->i_mtime = inode->i_ctime
> +			= current_time(inode);
> +		inode->i_fop = files->ops;
> +		inode->i_ino = i;
> +		d_add(dentry, inode);
> +	}
> +
> +	return 0;
> +}
> +
>  static int
>  msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
> @@ -79,21 +228,49 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		[2] = { "mshare_info", &mshare_info_ops, 0444},
>  		{""},
>  	};
> -	int err;
> +	struct inode *inode;
> +	struct dentry *root;
> +	int err = 0;
>  
> -	err = simple_fill_super(sb, MSHARE_MAGIC, mshare_files);
> -	if (!err) {
> -		msharefs_sb = sb;
> -		sb->s_d_op = &msharefs_d_ops;
> -		sb->s_op = &mshare_s_ops;
> +	sb->s_blocksize		= PAGE_SIZE;
> +	sb->s_blocksize_bits	= PAGE_SHIFT;
> +	sb->s_magic		= MSHARE_MAGIC;
> +	sb->s_op		= &mshare_s_ops;
> +	sb->s_d_op		= &msharefs_d_ops;
> +	sb->s_time_gran		= 1;
> +
> +	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777);
> +	if (!inode) {
> +		err = -ENOMEM;
> +		goto out;
>  	}
> +	inode->i_ino = 1;
> +	root = d_make_root(inode);
> +	if (!root) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	err = prepopulate_files(sb, inode, root, mshare_files);
> +	if (err < 0)
> +		goto clean_root;
> +
> +	sb->s_root = root;
> +	msharefs_sb = sb;
> +	return err;
> +
> +clean_root:
> +	d_genocide(root);
> +	shrink_dcache_parent(root);
> +	dput(root);
> +out:
>  	return err;
>  }
>  
>  static int
>  msharefs_get_tree(struct fs_context *fc)
>  {
> -	return get_tree_single(fc, msharefs_fill_super);
> +	return get_tree_nodev(fc, msharefs_fill_super);
>  }
>  
>  static const struct fs_context_operations msharefs_context_ops = {
> -- 
> 2.32.0
> 
