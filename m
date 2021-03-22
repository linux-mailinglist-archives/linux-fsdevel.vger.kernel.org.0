Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33A2343A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 07:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCVGzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 02:55:35 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:47032 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCVGza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 02:55:30 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOETD-0084xx-48; Mon, 22 Mar 2021 06:55:23 +0000
Date:   Mon, 22 Mar 2021 06:55:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com, hch@lst.de,
        hch@infradead.org, ronniesahlberg@gmail.com,
        aurelien.aptel@gmail.com, aaptel@suse.com, sandeen@sandeen.net,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        rdunlap@infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 3/5] cifsd: add file operations
Message-ID: <YFg/W4q9PHwTAJtZ@zeniv-ca.linux.org.uk>
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
 <CGME20210322052207epcas1p3f0a5bdfd2c994a849a67b465479d0721@epcas1p3.samsung.com>
 <20210322051344.1706-4-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322051344.1706-4-namjae.jeon@samsung.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:13:42PM +0900, Namjae Jeon wrote:
> This adds file operations and buffer pool for cifsd.

Some random notes:

> +static void rollback_path_modification(char *filename)
> +{
> +	if (filename) {
> +		filename--;
> +		*filename = '/';
What an odd way to spell filename[-1] = '/';...

> +int ksmbd_vfs_inode_permission(struct dentry *dentry, int acc_mode, bool delete)
> +{

> +	if (delete) {
> +		struct dentry *parent;
> +
> +		parent = dget_parent(dentry);
> +		if (!parent)
> +			return -EINVAL;
> +
> +		if (inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE)) {
> +			dput(parent);
> +			return -EACCES;
> +		}
> +		dput(parent);

Who's to guarantee that parent is stable?  IOW, by the time of that
inode_permission() call dentry might very well not be a child of that thing...

> +	parent = dget_parent(dentry);
> +	if (!parent)
> +		return 0;
> +
> +	if (!inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC | MAY_WRITE))
> +		*daccess |= FILE_DELETE_LE;

Ditto.

> +int ksmbd_vfs_mkdir(struct ksmbd_work *work,
> +		    const char *name,
> +		    umode_t mode)


> +	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
> +	if (!err) {
> +		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry),
> +			d_inode(dentry));

->mkdir() might very well return success, with dentry left unhashed negative.
Look at the callers of vfs_mkdir() to see how it should be handled.

> +static int check_lock_range(struct file *filp,
> +			    loff_t start,
> +			    loff_t end,
> +			    unsigned char type)
> +{
> +	struct file_lock *flock;
> +	struct file_lock_context *ctx = file_inode(filp)->i_flctx;
> +	int error = 0;
> +
> +	if (!ctx || list_empty_careful(&ctx->flc_posix))
> +		return 0;
> +
> +	spin_lock(&ctx->flc_lock);
> +	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
> +		/* check conflict locks */
> +		if (flock->fl_end >= start && end >= flock->fl_start) {
> +			if (flock->fl_type == F_RDLCK) {
> +				if (type == WRITE) {
> +					ksmbd_err("not allow write by shared lock\n");
> +					error = 1;
> +					goto out;
> +				}
> +			} else if (flock->fl_type == F_WRLCK) {
> +				/* check owner in lock */
> +				if (flock->fl_file != filp) {
> +					error = 1;
> +					ksmbd_err("not allow rw access by exclusive lock from other opens\n");
> +					goto out;
> +				}
> +			}
> +		}
> +	}
> +out:
> +	spin_unlock(&ctx->flc_lock);
> +	return error;
> +}

WTF is that doing in smbd?

> +	filp = fp->filp;
> +	inode = d_inode(filp->f_path.dentry);

That should be file_inode().  Try it on overlayfs, watch it do interesting things...

> +	nbytes = kernel_read(filp, rbuf, count, pos);
> +	if (nbytes < 0) {
> +		name = d_path(&filp->f_path, namebuf, sizeof(namebuf));
> +		if (IS_ERR(name))
> +			name = "(error)";
> +		ksmbd_err("smb read failed for (%s), err = %zd\n",
> +				name, nbytes);

Do you really want the full pathname here?  For (presumably) spew into syslog?

> +int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
> +{
> +	struct path parent;
> +	struct dentry *dir, *dentry;
> +	char *last;
> +	int err = -ENOENT;
> +
> +	last = extract_last_component(name);
> +	if (!last)
> +		return -ENOENT;

Yeccchhh...

> +	if (ksmbd_override_fsids(work))
> +		return -ENOMEM;
> +
> +	err = kern_path(name, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &parent);
> +	if (err) {
> +		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
> +		ksmbd_revert_fsids(work);
> +		rollback_path_modification(last);
> +		return err;
> +	}
> +
> +	dir = parent.dentry;
> +	if (!d_inode(dir))
> +		goto out;

Really?  When does that happen?

> +static int __ksmbd_vfs_rename(struct ksmbd_work *work,
> +			      struct dentry *src_dent_parent,
> +			      struct dentry *src_dent,
> +			      struct dentry *dst_dent_parent,
> +			      struct dentry *trap_dent,
> +			      char *dst_name)
> +{
> +	struct dentry *dst_dent;
> +	int err;
> +
> +	spin_lock(&src_dent->d_lock);
> +	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
> +		struct ksmbd_file *child_fp;
> +
> +		if (d_really_is_negative(dst_dent))
> +			continue;
> +
> +		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
> +		if (child_fp) {
> +			spin_unlock(&src_dent->d_lock);
> +			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
> +			return -EACCES;
> +		}
> +	}
> +	spin_unlock(&src_dent->d_lock);

Hard NAK right there.  That thing has no business poking at that level.
And I'm pretty certain that it's racy as hell.
