Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489B02AE065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgKJUEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 15:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgKJUEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:04:44 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF1C0613D1;
        Tue, 10 Nov 2020 12:04:43 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcZsB-0031DR-RH; Tue, 10 Nov 2020 20:04:11 +0000
Date:   Tue, 10 Nov 2020 20:04:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yulei.kernel@gmail.com
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguangrong.eric@gmail.com, kernellwp@gmail.com,
        lihaiwei.kernel@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: Re: [PATCH 01/35] fs: introduce dmemfs module
Message-ID: <20201110200411.GU3576660@ZenIV.linux.org.uk>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:53:51PM +0800, yulei.kernel@gmail.com wrote:

> +static struct inode *
> +dmemfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode,
> +		 dev_t dev);

WTF is 'dev' for?

> +static int
> +dmemfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	struct inode *inode = dmemfs_get_inode(dir->i_sb, dir, mode, dev);
> +	int error = -ENOSPC;
> +
> +	if (inode) {
> +		d_instantiate(dentry, inode);
> +		dget(dentry);	/* Extra count - pin the dentry in core */
> +		error = 0;
> +		dir->i_mtime = dir->i_ctime = current_time(inode);
> +	}
> +	return error;
> +}

... same here, seeing that you only call that thing from the next two functions
and you do *not* provide ->mknod() as a method (unsurprisingly - what would
device nodes do there?)

> +static int dmemfs_create(struct inode *dir, struct dentry *dentry,
> +			 umode_t mode, bool excl)
> +{
> +	return dmemfs_mknod(dir, dentry, mode | S_IFREG, 0);
> +}
> +
> +static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
> +			umode_t mode)
> +{
> +	int retval = dmemfs_mknod(dir, dentry, mode | S_IFDIR, 0);
> +
> +	if (!retval)
> +		inc_nlink(dir);
> +	return retval;
> +}

> +int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	return 0;
> +}
> +
> +static const struct file_operations dmemfs_file_operations = {
> +	.mmap = dmemfs_file_mmap,
> +};

Er...  Is that a placeholder for later in the series?  Because as it is,
it makes no sense whatsoever - "it can be mmapped, but any access to the
mapped area will segfault".

> +struct inode *dmemfs_get_inode(struct super_block *sb,
> +			       const struct inode *dir, umode_t mode, dev_t dev)
> +{
> +	struct inode *inode = new_inode(sb);
> +
> +	if (inode) {
> +		inode->i_ino = get_next_ino();
> +		inode_init_owner(inode, dir, mode);
> +		inode->i_mapping->a_ops = &empty_aops;
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +		mapping_set_unevictable(inode->i_mapping);
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		switch (mode & S_IFMT) {
> +		default:
> +			init_special_inode(inode, mode, dev);
> +			break;
> +		case S_IFREG:
> +			inode->i_op = &dmemfs_file_inode_operations;
> +			inode->i_fop = &dmemfs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &dmemfs_dir_inode_operations;
> +			inode->i_fop = &simple_dir_operations;
> +
> +			/*
> +			 * directory inodes start off with i_nlink == 2
> +			 * (for "." entry)
> +			 */
> +			inc_nlink(inode);
> +			break;
> +		case S_IFLNK:
> +			inode->i_op = &page_symlink_inode_operations;
> +			break;

Where would symlinks come from?  Or anything other than regular files and
directories, for that matter...
