Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53489FC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfHLNfq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 09:35:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41149 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfHLNfp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:35:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so2320963wrr.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 06:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vn0SeCD4BXs6eJ6fUjS91GpFSutNCUDJii+nkcHcsY8=;
        b=kIuMyV2RD429eWFzAoAJqLGyH+APlW8/59Ki/VZ5LoIexXIQucbZnvGi1cTi+E8Tx1
         Z+txWX89CbD8QClKkXOFbpHRi4Xyh+w2l45x8t+fu8QwREggQqaVcOLf55DHZqDoxdo8
         nfYtVENAFxyTV7+BjMz6+CdOl60HuA4FturqFDJyD0OduizZn5+Y1fNEJvpxI2ovyGRl
         fk/JJs0/qHleVNpPHrsHLfbp2VId0+07XDHAvnlDyvuezw4Kso88+p8RrVxWb+F0bpDu
         6WOnxyuxRT1hxbseEIRN/QKZ0x8nz8hvsCnaXwemrthF6iTWK0cx5aEYjvyAF/oiuXgZ
         6Q+Q==
X-Gm-Message-State: APjAAAXxUCLIFWZlZ4Si2w7WNdGGT8NzYX4BXShF1TTAFhyBQdU/TioE
        LBVRy3nhe9h4ia6v3LRMUZCzfyEis2k=
X-Google-Smtp-Source: APXvYqzP2V4ynQGSPFkTf/DgnWZaSaUQmSyazK2JiTnLDpK0LkJkVLBxrOhplqNmGAT7IbnXUyHuJw==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr42518285wrj.256.1565616941388;
        Mon, 12 Aug 2019 06:35:41 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h97sm30709324wrh.74.2019.08.12.06.35.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 06:35:40 -0700 (PDT)
Subject: Re: [PATCH v12 resend] fs: Add VirtualBox guest shared folder
 (vboxsf) support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
References: <20190811163134.12708-1-hdegoede@redhat.com>
 <20190811163134.12708-2-hdegoede@redhat.com>
 <20190812114926.GB21901@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b95eaa46-098d-0954-34b4-a96c7ed7ffa2@redhat.com>
Date:   Mon, 12 Aug 2019 15:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812114926.GB21901@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On 12-08-19 13:49, Christoph Hellwig wrote:
> A couple comments from a quick look:

Thank you for taking the time to take a look at this.

>> index 000000000000..fcbd488f9eec
>> --- /dev/null
>> +++ b/fs/vboxsf/Makefile
>> @@ -0,0 +1,3 @@
>> +obj-$(CONFIG_VBOXSF_FS) += vboxsf.o
>> +
>> +vboxsf-objs := dir.o file.o utils.o vboxsf_wrappers.o super.o
> 
> All new files, including the build system should have a SPDX tag.
> 
> Also please use the modern "foo-y +=" synax instead of "foo-objs :="

Ok, I will fix both for the next version.

>> +
>> +/**
>> + * sf_dir_open - Open a directory
>> + * @inode:	inode
>> + * @file:	file
>> + *
>> + * Open a directory. Read the complete content into a buffer.
>> + *
>> + * Returns:
>> + * 0 or negative errno value.
>> + */
> 
> Nitpick: I don't think verbose kerneldoc comments on functions
> implementing VFS or other core kernel methods calls are useful. In
> many ways they actually are harmful, as they are almost guranteed
> to be out of date eventually, e.g. in this case if someone finally
> decided to kill the pointless inode argument using a script.
> 
>> +static int sf_dir_open(struct inode *inode, struct file *file)
> 
> Why is this a sf_ prefix instead of vboxsf?

This case is based on the out-of-tree vboxsf driver which VirtualBox
upstream has been shipping for years (as out of tree code) together
as part of their Linux guest-additions. I've been working on getting
all the guest-drivers mainlined (vboxsf is the last one mmissing) so
that distros can integrate properly as vbox guest without needing
out of tree modules.

All the original code used the sf (shared folder) prefix. I've prefixed
most new / cleaned up functions with vboxsf, this is left over from
the old code. I will go over the code and rename the remaining
sf_ prefixed things for the next version.

> 
>> +{
>> +	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
> 
> Any chance to use a more normal naming scheme here, e.g.:
> 
> 	struct vboxsf_sbi *sbi = VBOXSF_SBI(inode->i_sb);

Sure, will fix for the next version.

>> +	err = vboxsf_create_at_dentry(file_dentry(file), &params);
>> +	if (err == 0) {
>> +		if (params.result == SHFL_FILE_EXISTS) {
>> +			err = vboxsf_dir_read_all(sf_g, sf_d, params.handle);
>> +			if (!err)
>> +				file->private_data = sf_d;
>> +		} else
>> +			err = -ENOENT;
>> +
>> +		vboxsf_close(sf_g->root, params.handle);
>> +	}
>> +
>> +	if (err)
>> +		vboxsf_dir_info_free(sf_d);
>> +
>> +	return err;
> 
> Why not normal goto based unwinding here:
> 
> 	err = vboxsf_create_at_dentry(file_dentry(file), &params);
> 	if (err)
> 		goto out_free_dir_info;
> 	if (params.result == SHFL_FILE_EXISTS) {
> 		err = -ENOENT;
> 		goto out_close;
> 	}
> 
> 	err = vboxsf_dir_read_all(sf_g, sf_d, params.handle);
> 	if (err)
> 		goto out_close;
> 
> 	file->private_data = sf_d;
> 	return 0;
> out_close:
> 	vboxsf_close(sf_g->root, params.handle);
> out_free_dir_info:
> 	vboxsf_dir_info_free(sf_d);
> 	return err;

Ack, will fix.


>> +static int sf_getdent(struct file *dir, loff_t pos,
>> +		      char d_name[NAME_MAX], unsigned int *d_type)
> 
> Array sizing in parameters in C is ignored, so this is a bit mislead.
> I'd just use a normal char pointer.  But more importantly it would
> seem saner to pass down the dir context, so that we can just call
> dir_emit on the original string and avoid a pointless memcpy for the
> non-nls case.

Ok, I will rework this as you suggest for the next version.

>> +static int sf_dentry_revalidate(struct dentry *dentry, unsigned int flags)
>> +{
>> +	if (flags & LOOKUP_RCU)
>> +		return -ECHILD;
>> +
>> +	if (d_really_is_positive(dentry))
>> +		return vboxsf_inode_revalidate(dentry) == 0;
>> +	else
>> +		return vboxsf_stat_dentry(dentry, NULL) == -ENOENT;
>> +}
>> +
>> +const struct dentry_operations vboxsf_dentry_ops = {
>> +	.d_revalidate = sf_dentry_revalidate
>> +};
> 
> I'd really like to see Al look over all the dentry stuff, and the
> by path operations later on, as some of this looks rather odd, but
> It's been a while since I have been fluent in that area.

FWIW Al did go over the dentry stuff in an older version.

> 
>> +	sf_i = GET_INODE_INFO(inode);
> 
> The normal name for this would be VOXSF_I.

Ok.


>> +/**
>> + * sf_create_aux - Create a new regular file / directory
>> + * @parent:	inode of the parent directory
>> + * @dentry:	directory entry
>> + * @mode:	file mode
>> + * @is_dir:	true if directory, false otherwise
>> + *
>> + * Returns:
>> + * 0 or negative errno value.
>> + */
>> +static int sf_create_aux(struct inode *parent, struct dentry *dentry,
>> +			 umode_t mode, int is_dir)
> 
> Where does the aux come from?  The name sounds a little weird.

I honestly don't know, I will drop this for the next version.


>> +/**
>> + * sf_unlink_aux - Remove a regular file
>> + * @parent:	inode of the parent directory
>> + * @dentry:	directory entry
>> + *
>> + * Returns:
>> + * 0 or negative errno value.
>> + */
>> +static int sf_unlink(struct inode *parent, struct dentry *dentry)
>> +{
>> +	return sf_unlink_aux(parent, dentry, 0);
>> +}
>> +
>> +/**
>> + * sf_rmdir - Remove a directory
>> + * @parent:	inode of the parent directory
>> + * @dentry:	directory entry
>> + *
>> + * Returns:
>> + * 0 or negative errno value.
>> + */
>> +static int sf_rmdir(struct inode *parent, struct dentry *dentry)
>> +{
>> +	return sf_unlink_aux(parent, dentry, 1);
>> +}
> 
> You can just set both methods to the same function and check S_IDIR
> to handle rmdir vs unlink.

Ok, will fix.

>> +	if (IS_ERR(new_path)) {
>> +		__putname(old_path);
>> +		return PTR_ERR(new_path);
>> +	}
> 
> Use a goto to share the cleanup code?

Ok, will fix.

>> +static ssize_t sf_reg_read(struct file *file, char __user *buf, size_t size,
>> +			   loff_t *off)
>> +{
>> +	struct sf_handle *sf_handle = file->private_data;
>> +	u64 pos = *off;
>> +	u32 nread;
>> +	int err;
>> +
>> +	if (!size)
>> +		return 0;
>> +
>> +	if (size > SHFL_MAX_RW_COUNT)
>> +		nread = SHFL_MAX_RW_COUNT;
>> +	else
>> +		nread = size;
> 
> Use min/min_t, please.

Ok, will fix.

>> +
>> +	err = vboxsf_read(sf_handle->root, sf_handle->handle, pos, &nread,
>> +			  (uintptr_t)buf, true);
>> +	if (err)
>> +		return err;
>> +
>> +	*off += nread;
>> +	return nread;
>> +}
> 
> Please implement read_iter/write_iter for a new file system.

Ok, will fix.

> Also these casts to uintptr_t for a call that reads data look very
> odd.

Yes, as I already discussed with Al, that is because vboxsf_read
can be (and is) used with both kernel and userspace buffer pointers.

In case of a userspace pointer the underlying IPC code to the host takes
care of copy to / from user for us. That IPC code can also be used from
userspace through ioctls on /dev/vboxguest, so the handling of both
in kernel and userspace addresses is something which it must be able
to handle anyways, at which point we might as well use it in vboxsf too.

But since both Al and you pointed this out as being ugly, I will add
2 separate vboxsf_read_user and vboxsf_read_kernel functions for the
next version, then the cast (and the true flag) can both go away.

> 
>> +static ssize_t sf_reg_write(struct file *file, const char __user *buf,
>> +			    size_t size, loff_t *off)
>> +{
>> +	struct inode *inode = file_inode(file);
>> +	struct sf_inode_info *sf_i = GET_INODE_INFO(inode);
>> +	struct sf_handle *sf_handle = file->private_data;
>> +	u32 nwritten;
>> +	u64 pos;
>> +	int err;
>> +
>> +	if (file->f_flags & O_APPEND)
>> +		pos = i_size_read(inode);
>> +	else
>> +		pos = *off;
>> +
>> +	if (!size)
>> +		return 0;
>> +
>> +	if (size > SHFL_MAX_RW_COUNT)
>> +		nwritten = SHFL_MAX_RW_COUNT;
>> +	else
>> +		nwritten = size;
>> +
>> +	/* Make sure any pending writes done through mmap are flushed */
> 
> Why?

I believe that if we were doing everything through the page-cache then a regular
write to the same range as a write done through mmap, with the regular write
happening after (in time) the mmap write, will overwrite the mmap
written data, we want the same behavior here.

>> +	err = filemap_fdatawait_range(inode->i_mapping, pos, pos + nwritten);
>> +	if (err)
>> +		return err;
> 
> Also this whole write function seems to miss i_rwsem.

Hmm, I do not see e.g. v9fs_file_write_iter take that either, nor a couple
of other similar not block-backed filesystems. Will this still
be necessary after converting to the iter interfaces?

>> +
>> +	err = vboxsf_write(sf_handle->root, sf_handle->handle, pos, &nwritten,
>> +			   (uintptr_t)buf, true);
>> +	if (err)
>> +		return err;
>> +
>> +	if (pos + nwritten > i_size_read(inode))
>> +		i_size_write(inode, pos + nwritten);
>> +
>> +	/* Invalidate page-cache so that mmap using apps see the changes too */
>> +	invalidate_mapping_pages(inode->i_mapping, pos >> PAGE_SHIFT,
>> +				 (pos + nwritten) >> PAGE_SHIFT);
> 
> I think you really need to use the page cache for regular writes
> insted of coming up with your own ad-hoc cache coherency scheme.

The problem is that the IPC to the host which we build upon only offers
regular read / write calls. So the most consistent (also cache coherent)
mapping which we can offer is to directly mapping read -> read and
wrtie->write without the pagecache. Ideally we would be able to just
say sorry cannot do mmap, but too much apps rely on mmap and the
out of tree driver has this mmap "emulation" which means not offering
it in the mainline version would be a serious regression.

In essence this is the same situation as a bunch of network filesystems
are in and I've looked at several for inspiration. Looking again at
e.g. v9fs_file_write_iter it does similar regular read -> read mapping
with invalidation of the page-cache for mmap users.

>> +static vm_fault_t sf_page_mkwrite(struct vm_fault *vmf)
>> +{
>> +	struct page *page = vmf->page;
>> +	struct inode *inode = file_inode(vmf->vma->vm_file);
>> +
>> +	lock_page(page);
>> +	if (page->mapping != inode->i_mapping) {
>> +		unlock_page(page);
>> +		return VM_FAULT_NOPAGE;
>> +	}
>> +
>> +	return VM_FAULT_LOCKED;
>> +}
> 
> What is this supposed to help with?

I must admit that I've mostly cargo-culted this from other fs code
such as the 9p code, or the cifs code which has:

/*
  * If the page is mmap'ed into a process' page tables, then we need to make
  * sure that it doesn't change while being written back.
  */
static vm_fault_t
cifs_page_mkwrite(struct vm_fault *vmf)
{
         struct page *page = vmf->page;

         lock_page(page);
         return VM_FAULT_LOCKED;
}

The if (page->mapping != inode->i_mapping) is used in several places
including the 9p code, bit as you can see no in the cifs code. I couldn't
really find a rational for that check, so I'm fine with dropping that check.

>> +	SET_GLOB_INFO(sb, sf_g);
> 
> No need to have a wrapper for this assignment.

Ok.

>> +static void sf_inode_init_once(void *data)
>> +{
>> +	struct sf_inode_info *sf_i = (struct sf_inode_info *)data;
> 
> No need for a cast here.

Ok.

>> +static void sf_i_callback(struct rcu_head *head)
>> +{
>> +	struct inode *inode = container_of(head, struct inode, i_rcu);
>> +	struct sf_glob_info *sf_g = GET_GLOB_INFO(inode->i_sb);
>> +
>> +	spin_lock(&sf_g->ino_idr_lock);
>> +	idr_remove(&sf_g->ino_idr, inode->i_ino);
>> +	spin_unlock(&sf_g->ino_idr_lock);
>> +	kmem_cache_free(sf_inode_cachep, GET_INODE_INFO(inode));
>> +}
>> +
>> +static void sf_destroy_inode(struct inode *inode)
>> +{
>> +	call_rcu(&inode->i_rcu, sf_i_callback);
>> +}
> 
> I think you want to implement the new free_inode callback instead.

I will take a look at this.

Regards,

Hans

