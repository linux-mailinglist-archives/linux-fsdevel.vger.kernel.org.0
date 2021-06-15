Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E33A7954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFOIuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFOIuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:50:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE181C061574;
        Tue, 15 Jun 2021 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ewaQ0uVDHyF24zdop2deubSxXdGfzaIXdpCh01W+00g=; b=jpJR3X0+Gm7ws+kDjkHlqoT4Za
        lQjBOdiOv3theTd9xclOXr0+zRsCpF6btI8d2vfaPeTDKCxMB98tN6OkyeZ5LziIZUSfllQSIBkrM
        hYXjCm2yB/SD6kfHwMiwtfiLyrs3ayYVeJjWEeaTmM8ccW8mHkG5iS2eHTB0nYJukBnTbKIKqoxD+
        hFmXMrP1UwA+vqSRyAtwk/hPV04fACwT+7OBSfsgp0eMdPj9F7tfjnGor5v9Ydbk0lcYX7vxGEZC1
        ibfxKV9fricZQ/WdsAdszhqwSIUtXoLI6uY4Zl9c/DxeYFO1CenhFcKkK8QVQHAikF7DWb0Yd+Ic6
        La2j3dHw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt4jD-006Fl8-ET; Tue, 15 Jun 2021 08:47:28 +0000
Date:   Tue, 15 Jun 2021 09:47:23 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, smfrench@gmail.com,
        stfrench@microsoft.com, willy@infradead.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        senozhatsky@chromium.org, sandeen@sandeen.net, aaptel@suse.com,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, hch@lst.de, dan.carpenter@oracle.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v4 08/10] cifsd: add file operations
Message-ID: <YMhpG/sAjO3WKKc3@infradead.org>
References: <20210602034847.5371-1-namjae.jeon@samsung.com>
 <CGME20210602035820epcas1p3c444b34a6b6a4252c9091e0bf6c0c167@epcas1p3.samsung.com>
 <20210602034847.5371-9-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602034847.5371-9-namjae.jeon@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:48:45PM +0900, Namjae Jeon wrote:
> +#include <linux/rwlock.h>
> +
> +#include "glob.h"
> +#include "buffer_pool.h"
> +#include "connection.h"
> +#include "mgmt/ksmbd_ida.h"
> +
> +static struct kmem_cache *filp_cache;
> +
> +struct wm {
> +	struct list_head	list;
> +	unsigned int		sz;
> +	char			buffer[0];

This should use buffer[];

> +};
> +
> +struct wm_list {
> +	struct list_head	list;
> +	unsigned int		sz;
> +
> +	spinlock_t		wm_lock;
> +	int			avail_wm;
> +	struct list_head	idle_wm;
> +	wait_queue_head_t	wm_wait;
> +};

What does wm stand for?

This looks like arbitrary caching of vmalloc buffers.  I thought we
decided to just make vmalloc suck less rather than papering over that?

> +static LIST_HEAD(wm_lists);
> +static DEFINE_RWLOCK(wm_lists_lock);

Especially as this isn't going to scale at all using global loists and
locks.

> +void ksmbd_free_file_struct(void *filp)
> +{
> +	kmem_cache_free(filp_cache, filp);
> +}
> +
> +void *ksmbd_alloc_file_struct(void)
> +{
> +	return kmem_cache_zalloc(filp_cache, GFP_KERNEL);
> +}

These are only ued in vfs_cache.c . So I'd suggest to just move
filp_cache there and drop these wrappers.

> +}
> +
> +static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
> +				    struct inode *parent_inode,
> +				    struct inode *inode)
> +{
> +	if (!test_share_config_flag(work->tcon->share_conf,
> +				    KSMBD_SHARE_FLAG_INHERIT_OWNER))
> +		return;
> +
> +	i_uid_write(inode, i_uid_read(parent_inode));
> +}

Can you explain this a little more?  When do the normal create/mdir
fail to inherit the owner?

int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode, bool delete)
> +{
> +	int mask, ret = 0;
> +
> +	mask = 0;
> +	acc_mode &= O_ACCMODE;
> +
> +	if (acc_mode == O_RDONLY)
> +		mask = MAY_READ;
> +	else if (acc_mode == O_WRONLY)
> +		mask = MAY_WRITE;
> +	else if (acc_mode == O_RDWR)
> +		mask = MAY_READ | MAY_WRITE;

How about already setting up the MAY_ flags in smb2_create_open_flags
and returning them in extra argument?  That keeps the sm to Linux
translation in a single place.

> +
> +	if (inode_permission(&init_user_ns, d_inode(dentry), mask | MAY_OPEN))
> +		return -EACCES;

And this call can be open coded in the only caller.

> +	if (delete) {

And this block could be split into a nice self-contained helper.

> +		struct dentry *child, *parent;
> +
> +		parent = dget_parent(dentry);
> +		inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> +		child = lookup_one_len(dentry->d_name.name, parent,
> +				       dentry->d_name.len);
> +		if (IS_ERR(child)) {
> +			ret = PTR_ERR(child);
> +			goto out_lock;
> +		}
> +
> +		if (child != dentry) {
> +			ret = -ESTALE;
> +			dput(child);
> +			goto out_lock;
> +		}
> +		dput(child);

That being said I do not understand the need for this re-lookup at all.

> +	if (!inode_permission(&init_user_ns, d_inode(dentry), MAY_OPEN | MAY_WRITE))

All these inode_permission lines have overly long lines.  It might be
worth to pass the user_namespace to this function, not only to shorten
the code, but also to prepare for user namespace support.

> +	parent = dget_parent(dentry);
> +	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> +	child = lookup_one_len(dentry->d_name.name, parent,
> +			       dentry->d_name.len);
> +	if (IS_ERR(child)) {
> +		ret = PTR_ERR(child);
> +		goto out_lock;
> +	}
> +
> +	if (child != dentry) {
> +		ret = -ESTALE;
> +		dput(child);
> +		goto out_lock;
> +	}
> +	dput(child);

This is the same weird re-lookup dance as above.  IFF there is a good
rationale for it it needs to go into a self-contained and well
documented helper.

> +int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
> +{
> +	struct path path;
> +	struct dentry *dentry;
> +	int err;
> +
> +	dentry = kern_path_create(AT_FDCWD, name, &path, 0);

Curious:  why is this using absolute or CWD based path instead of
doing lookups based off the parent as done by e.g. nfsd?  Same also
for mkdir and co.

> +{
> +	struct file *filp;
> +	ssize_t nbytes = 0;
> +	char *rbuf;
> +	struct inode *inode;
> +
> +	rbuf = work->aux_payload_buf;
> +	filp = fp->filp;
> +	inode = file_inode(filp);

These can be initialized on the declaration lines to make the code a
little easier to read.

> +	if (!work->tcon->posix_extensions) {
> +		spin_lock(&src_dent->d_lock);
> +		list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
> +			struct ksmbd_file *child_fp;
> +
> +			if (d_really_is_negative(dst_dent))
> +				continue;
> +
> +			child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
> +			if (child_fp) {
> +				spin_unlock(&src_dent->d_lock);
> +				ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
> +				return -EACCES;
> +			}
> +		}
> +		spin_unlock(&src_dent->d_lock);
> +	}

This begs for being split into a self-contained helper.

> +int ksmbd_vfs_lock(struct file *filp, int cmd, struct file_lock *flock)
> +{
> +	ksmbd_debug(VFS, "calling vfs_lock_file\n");
> +	return vfs_lock_file(filp, cmd, flock, NULL);
> +}
> +
> +int ksmbd_vfs_readdir(struct file *file, struct ksmbd_readdir_data *rdata)
> +{
> +	return iterate_dir(file, &rdata->ctx);
> +}
> +
> +int ksmbd_vfs_alloc_size(struct ksmbd_work *work, struct ksmbd_file *fp,
> +			 loff_t len)
> +{
> +	smb_break_all_levII_oplock(work, fp, 1);
> +	return vfs_fallocate(fp->filp, FALLOC_FL_KEEP_SIZE, 0, len);
> +}

Please avoid such trivial wrappers that just make the code hard to
follow.

> +int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
> +			 struct file_allocated_range_buffer *ranges,
> +			 int in_count, int *out_count)

What is fqar?

> +
> +/*
> + * ksmbd_vfs_get_logical_sector_size() - get logical sector size from inode
> + * @inode: inode
> + *
> + * Return: logical sector size
> + */
> +unsigned short ksmbd_vfs_logical_sector_size(struct inode *inode)
> +{
> +	struct request_queue *q;
> +	unsigned short ret_val = 512;
> +
> +	if (!inode->i_sb->s_bdev)
> +		return ret_val;
> +
> +	q = inode->i_sb->s_bdev->bd_disk->queue;
> +
> +	if (q && q->limits.logical_block_size)
> +		ret_val = q->limits.logical_block_size;
> +
> +	return ret_val;

I don't think a CIFS server has any business poking into the block
layer.  What is this trying to do?

> +struct posix_acl *ksmbd_vfs_posix_acl_alloc(int count, gfp_t flags)
> +{
> +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> +	return posix_acl_alloc(count, flags);
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +struct posix_acl *ksmbd_vfs_get_acl(struct inode *inode, int type)
> +{
> +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> +	return get_acl(inode, type);
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +int ksmbd_vfs_set_posix_acl(struct inode *inode, int type,
> +			    struct posix_acl *acl)
> +{
> +#if IS_ENABLED(CONFIG_FS_POSIX_ACL)
> +	return set_posix_acl(&init_user_ns, inode, type, acl);
> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}

Please avoid these pointless wrappers and just use large code block
ifdefs or IS_ENABLED checks.

> +int ksmbd_vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> +			      struct file *file_out, loff_t pos_out, size_t len)
> +{
> +	struct inode *inode_in = file_inode(file_in);
> +	struct inode *inode_out = file_inode(file_out);
> +	int ret;
> +
> +	ret = vfs_copy_file_range(file_in, pos_in, file_out, pos_out, len, 0);
> +	/* do splice for the copy between different file systems */
> +	if (ret != -EXDEV)
> +		return ret;
> +
> +	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
> +		return -EISDIR;
> +	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
> +		return -EINVAL;
> +
> +	if (!(file_in->f_mode & FMODE_READ) ||
> +	    !(file_out->f_mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (len == 0)
> +		return 0;
> +
> +	file_start_write(file_out);
> +
> +	/*
> +	 * skip the verification of the range of data. it will be done
> +	 * in do_splice_direct
> +	 */
> +	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> +			       len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);

vfs_copy_file_range already does this type of fallback, so this is dead
code.

> +#define XATTR_NAME_STREAM_LEN		(sizeof(XATTR_NAME_STREAM) - 1)
> +
> +enum {
> +	XATTR_DOSINFO_ATTRIB		= 0x00000001,
> +	XATTR_DOSINFO_EA_SIZE		= 0x00000002,
> +	XATTR_DOSINFO_SIZE		= 0x00000004,
> +	XATTR_DOSINFO_ALLOC_SIZE	= 0x00000008,
> +	XATTR_DOSINFO_CREATE_TIME	= 0x00000010,
> +	XATTR_DOSINFO_CHANGE_TIME	= 0x00000020,
> +	XATTR_DOSINFO_ITIME		= 0x00000040
> +};
> +
> +struct xattr_dos_attrib {
> +	__u16	version;
> +	__u32	flags;
> +	__u32	attr;
> +	__u32	ea_size;
> +	__u64	size;
> +	__u64	alloc_size;
> +	__u64	create_time;
> +	__u64	change_time;
> +	__u64	itime;
> +};

These looks like on-disk structures.  Any chance you could re-order
the headers so that things like on-disk, on the wire and netlink uapi
structures all have a dedicated and well documented header for
themselves?

> +	read_lock(&ci->m_lock);
> +	list_for_each(cur, &ci->m_fp_list) {
> +		lfp = list_entry(cur, struct ksmbd_file, node);

Please use list_for_each_entry.  There are very few places left where
using list_for_each makes sense.

> +		if (inode == FP_INODE(lfp)) {
> +			atomic_dec(&ci->m_count);
> +			read_unlock(&ci->m_lock);
> +			return lfp;
> +		}
> +	}
> +	atomic_dec(&ci->m_count);
> +	read_unlock(&ci->m_lock);

So a successful find increments m_count, but a miss decreases it?
Isn't this going to create an underflow?

> +	if (!fp->f_ci) {
> +		ksmbd_free_file_struct(fp);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	ret = __open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
> +	if (ret) {
> +		ksmbd_inode_put(fp->f_ci);
> +		ksmbd_free_file_struct(fp);
> +		return ERR_PTR(ret);
> +	}
> +
> +	atomic_inc(&work->conn->stats.open_files_count);
> +	return fp;

Please use goto based unwinding instead of duplicating the resoure
cleanup.

> +static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon, struct ksmbd_file *fp)

Overly long line.

> +{
> +	return fp->tcon != tcon;
> +}
> +
> +static bool session_fd_check(struct ksmbd_tree_connect *tcon, struct ksmbd_file *fp)

Same.
