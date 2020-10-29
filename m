Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4902029E2E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgJ2Cn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391088AbgJ2CmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:42:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B615C0613CF;
        Wed, 28 Oct 2020 19:42:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXxtG-00B2L9-DW; Thu, 29 Oct 2020 02:42:14 +0000
Date:   Thu, 29 Oct 2020 02:42:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Zou Cao <zoucao@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs:regfs: add register easy filesystem
Message-ID: <20201029024214.GN3576660@ZenIV.linux.org.uk>
References: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:30:07PM +0800, Zou Cao wrote:
> +ssize_t regfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file->f_mapping->host;
> +	ssize_t ret;
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret > 0)
> +		ret = __generic_file_write_iter(iocb, from);
> +	inode_unlock(inode);
> +
> +	if (ret > 0)
> +		ret = generic_write_sync(iocb, ret);
> +	return ret;
> +}

Huh?  How is that different from generic_file_write_iter()?  And who's
using it, anyway?

> +	struct regfs_inode_info  *info = REGFS_I(mapping->host);
> +	char str[67];
> +	unsigned long val = 0;
> +	loff_t pos = *ppos;
> +	size_t res;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= len || len > 66)
> +		return 0;

This is completely bogus.  "If current position is greater than the
length of string we are asking to write, quietly return 0"?

> +	res = copy_from_user(str, buf, len);
> +	if (res)
> +		return -EFAULT;
> +	str[len] = 0;
> +
> +	if (kstrtoul(str, 16, &val) < 0)
> +		return -EINVAL;

Where does 67 come from?  If you are expecting a hexadecimal representation
of a unsigned long on arm64, you should have at most 16 digits.  67 looks
rather odd...

> +	writel_relaxed(val, info->base + info->offset);

... and you are promptly discarding the upper 32 bits, since writel_relaxed()
takes u32:
	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
is going to truncate to 32bit, no matter what.  Quietly truncate, at that...

> +const struct address_space_operations regfs_aops = {
> +	.readpage   = simple_readpage,
> +	.write_begin    = simple_write_begin,
> +	.write_end  = simple_write_end,
> +	.set_page_dirty = __set_page_dirty_buffers,
> +};

Again, huh?  What would use the page cache there, anyway?

> +static LIST_HEAD(regfs_head);

Protected by...?

> +static const struct inode_operations regfs_dir_inode_operations;
> +int regfs_debug;
> +module_param(regfs_debug, int, S_IRUGO);
> +MODULE_PARM_DESC(regfs_debug, "enable regfs debug mode");
> +
> +struct inode *regfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode, dev_t dev)
> +{
> +	struct inode *inode = new_inode(sb);
> +
> +	if (inode) {
> +		inode->i_ino = get_next_ino();
> +		inode_init_owner(inode, dir, mode);
> +		inode->i_mapping->a_ops = &regfs_aops;
> +		//inode->i_mapping->backing_dev_info = &regfs_backing_dev_info;
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +		mapping_set_unevictable(inode->i_mapping);
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		switch (mode & S_IFMT) {
> +		default:
> +			init_special_inode(inode, mode, dev);
> +			break;
> +		case S_IFREG:
> +			inode->i_op = &regfs_file_inode_operations;
> +			inode->i_fop = &regfs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &regfs_dir_inode_operations;
> +			inode->i_fop = &simple_dir_operations;
> +
> +			/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +			inc_nlink(inode);
> +			break;
> +		case S_IFLNK:
> +			inode->i_op = &page_symlink_inode_operations;
> +			break;
> +		}
> +	}
> +
> +	return inode;
> +}

Seriously?  Where would symlinks, device nodes, FIFOs and sockets come from?
And you are open-coding the regular file case in the new_dentry_create() anyway,
so the only thing this is actually used for is the root directory.

> +static const struct inode_operations regfs_dir_inode_operations = {
> +	.lookup		= simple_lookup,
> +};

... and simple_dir_inode_operations is wrong, because...?

> +static struct dentry *new_dentry_create(struct super_block *sb, struct dentry *parent,
> +		 const char *name, bool is_dir, struct res_data *res)
> +{
> +	struct dentry *dentry;
> +	struct inode *inode;
> +	struct regfs_inode_info *ei;
> +	struct regfs_fs_info *fsi = sb->s_fs_info;
> +
> +	dentry = d_alloc_name(parent, name);
> +	if (!dentry)
> +		return NULL;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	ei = REGFS_I(inode);
> +	inode->i_ino = get_next_ino();;
> +	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_uid =  GLOBAL_ROOT_UID;
> +	inode->i_gid =  GLOBAL_ROOT_GID;
> +	if (is_dir) {
> +		inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR;
> +		inode->i_op = &regfs_dir_inode_operations;
> +		inode->i_fop = &simple_dir_operations;
> +		list_add(&ei->list, &fsi->list);

where's the matching removal from the list?

> +	} else {
> +		inode->i_mode = S_IFREG | S_IRUGO | S_IWUSR;
> +		inode->i_op = &regfs_file_inode_operations;
> +		inode->i_fop = &regfs_file_operations;
> +		inc_nlink(inode);
> +	}
> +	ei->base = (void *)res->base;
> +	ei->offset = res->offset;
> +	ei->type = res->type;
> +
> +	d_add(dentry, inode);
> +
> +	loc_debug("new dentry io base:%llx offset:%llx ei:%llx\n", (u64)ei->base, (u64)ei->offset, (u64)ei);
> +	return dentry;
> +out:
> +	dput(dentry);
> +	return NULL;
> +}
> +
> +static void node_transfer_dentry(struct super_block *sb)
> +{
> +	struct regfs_fs_info *fsi = sb->s_fs_info;
> +	void *blob = fsi->dtb_buf;
> +	const char *pathp;
> +	int node_offset, depth = -1;
> +	struct dentry *parent = NULL;
> +	u64 parent_base;
> +
> +	for (node_offset = fdt_next_node(blob, -1, &depth);
> +		node_offset >= 0 && depth >= 0;
> +		node_offset = fdt_next_node(blob, node_offset, &depth)) {
> +
> +		const struct fdt_property *prop;
> +		struct res_data res;
> +
> +		pathp = fdt_get_name(blob, node_offset, NULL);
> +		prop = (void *)fdt_getprop(blob, node_offset, "reg", NULL);
> +
> +		if (prop) {
> +			unsigned long phys;
> +
> +			phys = fdt32_to_cpu(((const __be32 *)prop)[1]);
> +			res.type = RES_TYPE_RANGE;
> +			res.offset = fdt32_to_cpu(((const __be32 *)prop)[3]);
> +			res.base = (u64)ioremap(phys, res.offset);
> +
> +			if (!res.base) {
> +				parent = NULL;
> +				parent_base = 0;
> +				continue;
> +			}
> +
> +			loc_debug("%s reg:%lx size:%lx map:%llx\n\n", pathp
> +				 , (unsigned long) fdt32_to_cpu(((const __be32 *)prop)[1])
> +				 , (unsigned long) fdt32_to_cpu(((const __be32 *)prop)[3])
> +				 , (u64)res.base);
> +
> +			parent = new_dentry_create(sb, sb->s_root, (const char *)pathp, true, &res);
> +			parent_base = res.base;
> +
> +		} else {
> +			// parent dentry is create failed, igonre all child dentry
> +			if (!parent)
> +				continue;
> +
> +			prop = (void *)fdt_getprop(blob, node_offset, "offset", NULL);
> +			if (prop) {
> +
> +				res.offset = fdt32_to_cpu(*(const __be32 *)prop);
> +				res.base = parent_base;
> +				res.type = RES_TYPE_ITEM;
> +
> +				new_dentry_create(sb, parent, (const char *) pathp, false, &res);
> +				loc_debug("%s offset:%lx\n", pathp, (unsigned long)fdt32_to_cpu(*(const __be32 *)prop));
> +			}
> +		}
> +	}
> +}
> +
> +static int parse_options(char *options, struct super_block *sb)
> +{
> +	char *p;
> +	int ret = -EINVAL;
> +	struct regfs_fs_info *fsi;
> +	size_t msize = INT_MAX;
> +
> +	fsi = sb->s_fs_info;
> +
> +	if (!options)
> +		return -EINVAL;
> +
> +	while ((p = strsep(&options, ",")) != NULL) {
> +		char *name, *name_val;
> +
> +		name = strsep(&p, "=");
> +		if (name == NULL)
> +			goto failed;
> +
> +		name_val = strsep(&p, "=");
> +		if (name_val == NULL)
> +			goto failed;
> +
> +		//get resource address
> +		if (!strcmp(name, "dtb")) {
> +			ret = kernel_read_file_from_path(name_val, &fsi->dtb_buf, &fsi->dtb_len, msize, READING_UNKNOWN);

Why bother doing that in the kernel?

> +struct dentry *regfs_mount(struct file_system_type *fs_type,
> +	int flags, const char *dev_name, void *data)
> +{
> +	struct dentry *root_dentry;
> +	struct super_block *sb;
> +
> +	root_dentry = mount_nodev(fs_type, flags, data, regfs_fill_super);
> +
> +	sb = root_dentry->d_sb;
> +
> +	if (sb->s_root) {
> +		node_transfer_dentry(sb);

Er... Why not do that in regfs_fill_super()?

Al, not going any further for now...
