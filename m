Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E289D4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfHLLt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 07:49:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfHLLt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XNp+BSJilDINySgCBj9MtCkIaQawaKj67Bf0DqunY7M=; b=LfRNP5XNQ4/n1ww9jQM6XkjJK
        sb2ZpLr2Zen16uMsGYKqk+Q7TAEGmHF2Jybt1KhZruzWYqGl17KgIbHL5tRKLp+BD0f/pZp9TU2+/
        FHTxFX2QowI81dAs8Uw2njZ0wQ8HRcatH1KLHNwjkMvpfk673nD/htxB5QIGPstspxHQLXyJCJl1D
        CC+Dy7Yv9vTxMS8Fo7JeOsrMmuWL4bFW/X3L+pgcDWlMMLTNlvZZb9J0WUHPv3YW/+SxEwqpMmxNd
        mvoHFw2+0SpS9AJGV3oLMdQOKKl/o/ctR0WJE0Pqvo2RNr0pkGj/+3AZZKcxWUspsBy8jE51zorGX
        SkGLNSbjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hx8pK-00083k-LH; Mon, 12 Aug 2019 11:49:26 +0000
Date:   Mon, 12 Aug 2019 04:49:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 resend] fs: Add VirtualBox guest shared folder
 (vboxsf) support
Message-ID: <20190812114926.GB21901@infradead.org>
References: <20190811163134.12708-1-hdegoede@redhat.com>
 <20190811163134.12708-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811163134.12708-2-hdegoede@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple comments from a quick look:

> index 000000000000..fcbd488f9eec
> --- /dev/null
> +++ b/fs/vboxsf/Makefile
> @@ -0,0 +1,3 @@
> +obj-$(CONFIG_VBOXSF_FS) += vboxsf.o
> +
> +vboxsf-objs := dir.o file.o utils.o vboxsf_wrappers.o super.o

All new files, including the build system should have a SPDX tag.

Also please use the modern "foo-y +=" synax instead of "foo-objs :="

> +
> +/**
> + * sf_dir_open - Open a directory
> + * @inode:	inode
> + * @file:	file
> + *
> + * Open a directory. Read the complete content into a buffer.
> + *
> + * Returns:
> + * 0 or negative errno value.
> + */

Nitpick: I don't think verbose kerneldoc comments on functions
implementing VFS or other core kernel methods calls are useful. In
many ways they actually are harmful, as they are almost guranteed
to be out of date eventually, e.g. in this case if someone finally
decided to kill the pointless inode argument using a script.

> +static int sf_dir_open(struct inode *inode, struct file *file)

Why is this a sf_ prefix instead of vboxsf?

> +{
> +	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);

Any chance to use a more normal naming scheme here, e.g.:

	struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);

> +	err = vboxsf_create_at_dentry(file_dentry(file), &params);
> +	if (err == 0) {
> +		if (params.result == SHFL_FILE_EXISTS) {
> +			err = vboxsf_dir_read_all(sf_g, sf_d, params.handle);
> +			if (!err)
> +				file->private_data = sf_d;
> +		} else
> +			err = -ENOENT;
> +
> +		vboxsf_close(sf_g->root, params.handle);
> +	}
> +
> +	if (err)
> +		vboxsf_dir_info_free(sf_d);
> +
> +	return err;

Why not normal goto based unwinding here:

	err = vboxsf_create_at_dentry(file_dentry(file), &params);
	if (err)
		goto out_free_dir_info;
	if (params.result == SHFL_FILE_EXISTS) {
		err = -ENOENT;
		goto out_close;
	}

	err = vboxsf_dir_read_all(sf_g, sf_d, params.handle);
	if (err)
		goto out_close;

	file->private_data = sf_d;
	return 0;
out_close:
	vboxsf_close(sf_g->root, params.handle);
out_free_dir_info:
	vboxsf_dir_info_free(sf_d);
	return err;

> +static int sf_getdent(struct file *dir, loff_t pos,
> +		      char d_name[NAME_MAX], unsigned int *d_type)

Array sizing in parameters in C is ignored, so this is a bit mislead.
I'd just use a normal char pointer.  But more importantly it would
seem saner to pass down the dir context, so that we can just call
dir_emit on the original string and avoid a pointless memcpy for the
non-nls case.


> +static int sf_dentry_revalidate(struct dentry *dentry, unsigned int flags)
> +{
> +	if (flags & LOOKUP_RCU)
> +		return -ECHILD;
> +
> +	if (d_really_is_positive(dentry))
> +		return vboxsf_inode_revalidate(dentry) == 0;
> +	else
> +		return vboxsf_stat_dentry(dentry, NULL) == -ENOENT;
> +}
> +
> +const struct dentry_operations vboxsf_dentry_ops = {
> +	.d_revalidate = sf_dentry_revalidate
> +};

I'd really like to see Al look over all the dentry stuff, and the
by path operations later on, as some of this looks rather odd, but
It's been a while since I have been fluent in that area.

> +	sf_i = GET_INODE_INFO(inode);

The normal name for this would be VOXSF_I.

> +/**
> + * sf_create_aux - Create a new regular file / directory
> + * @parent:	inode of the parent directory
> + * @dentry:	directory entry
> + * @mode:	file mode
> + * @is_dir:	true if directory, false otherwise
> + *
> + * Returns:
> + * 0 or negative errno value.
> + */
> +static int sf_create_aux(struct inode *parent, struct dentry *dentry,
> +			 umode_t mode, int is_dir)

Where does the aux come from?  The name sounds a little weird.

> +/**
> + * sf_unlink_aux - Remove a regular file
> + * @parent:	inode of the parent directory
> + * @dentry:	directory entry
> + *
> + * Returns:
> + * 0 or negative errno value.
> + */
> +static int sf_unlink(struct inode *parent, struct dentry *dentry)
> +{
> +	return sf_unlink_aux(parent, dentry, 0);
> +}
> +
> +/**
> + * sf_rmdir - Remove a directory
> + * @parent:	inode of the parent directory
> + * @dentry:	directory entry
> + *
> + * Returns:
> + * 0 or negative errno value.
> + */
> +static int sf_rmdir(struct inode *parent, struct dentry *dentry)
> +{
> +	return sf_unlink_aux(parent, dentry, 1);
> +}

You can just set both methods to the same function and check S_IDIR
to handle rmdir vs unlink.

> +	if (IS_ERR(new_path)) {
> +		__putname(old_path);
> +		return PTR_ERR(new_path);
> +	}

Use a goto to share the cleanup code?

> +static ssize_t sf_reg_read(struct file *file, char __user *buf, size_t size,
> +			   loff_t *off)
> +{
> +	struct sf_handle *sf_handle = file->private_data;
> +	u64 pos = *off;
> +	u32 nread;
> +	int err;
> +
> +	if (!size)
> +		return 0;
> +
> +	if (size > SHFL_MAX_RW_COUNT)
> +		nread = SHFL_MAX_RW_COUNT;
> +	else
> +		nread = size;

Use min/min_t, please.

> +
> +	err = vboxsf_read(sf_handle->root, sf_handle->handle, pos, &nread,
> +			  (uintptr_t)buf, true);
> +	if (err)
> +		return err;
> +
> +	*off += nread;
> +	return nread;
> +}

Please implement read_iter/write_iter for a new file system.
Also these casts to uintptr_t for a call that reads data look very
odd.

> +static ssize_t sf_reg_write(struct file *file, const char __user *buf,
> +			    size_t size, loff_t *off)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
> +	struct sf_handle *sf_handle = file->private_data;
> +	u32 nwritten;
> +	u64 pos;
> +	int err;
> +
> +	if (file->f_flags & O_APPEND)
> +		pos = i_size_read(inode);
> +	else
> +		pos = *off;
> +
> +	if (!size)
> +		return 0;
> +
> +	if (size > SHFL_MAX_RW_COUNT)
> +		nwritten = SHFL_MAX_RW_COUNT;
> +	else
> +		nwritten = size;
> +
> +	/* Make sure any pending writes done through mmap are flushed */

Why?

> +	err = filemap_fdatawait_range(inode->i_mapping, pos, pos + nwritten);
> +	if (err)
> +		return err;

Also this whole write function seems to miss i_rwsem.

> +
> +	err = vboxsf_write(sf_handle->root, sf_handle->handle, pos, &nwritten,
> +			   (uintptr_t)buf, true);
> +	if (err)
> +		return err;
> +
> +	if (pos + nwritten > i_size_read(inode))
> +		i_size_write(inode, pos + nwritten);
> +
> +	/* Invalidate page-cache so that mmap using apps see the changes too */
> +	invalidate_mapping_pages(inode->i_mapping, pos >> PAGE_SHIFT,
> +				 (pos + nwritten) >> PAGE_SHIFT);

I think you really need to use the page cache for regular writes
insted of coming up with your own ad-hoc cache coherency scheme.

> +static vm_fault_t sf_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct page *page = vmf->page;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +
> +	lock_page(page);
> +	if (page->mapping != inode->i_mapping) {
> +		unlock_page(page);
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	return VM_FAULT_LOCKED;
> +}

What is this supposed to help with?

> +	SET_GLOB_INFO(sb, sf_g);

No need to have a wrapper for this assignment.

> +static void sf_inode_init_once(void *data)
> +{
> +	struct sf_inode_info *sf_i = (struct sf_inode_info *)data;

No need for a cast here.

> +static void sf_i_callback(struct rcu_head *head)
> +{
> +	struct inode *inode = container_of(head, struct inode, i_rcu);
> +	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
> +
> +	spin_lock(&sf_g->ino_idr_lock);
> +	idr_remove(&sf_g->ino_idr, inode->i_ino);
> +	spin_unlock(&sf_g->ino_idr_lock);
> +	kmem_cache_free(sf_inode_cachep, GET_INODE_INFO(inode));
> +}
> +
> +static void sf_destroy_inode(struct inode *inode)
> +{
> +	call_rcu(&inode->i_rcu, sf_i_callback);
> +}

I think you want to implement the new free_inode callback instead.

