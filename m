Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C69562592
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiF3VuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiF3VuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEAB4F195;
        Thu, 30 Jun 2022 14:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DC7EB82D63;
        Thu, 30 Jun 2022 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E89C34115;
        Thu, 30 Jun 2022 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625817;
        bh=wfSJGrMKqxvbLYGQU0nsffNjn4KCaA4buDdhPQhY4To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPhm8uZPGces1RaLtCvMMal0vcmz7t6lR/r2s9/1IMzG3MIwvr7913wKO1JO1MuID
         Nt57MbT4Jgf6ZcoEeOjnqRrCSVNJLAl1EOffpfBw5Z+yQSAD/VcbAwXr1OKlucX5Vw
         yKMyKCjF07kdXOEswr6FXnCXAeGQ6lNcXc2NBu8m2/CLYXY1LEuh5zFzO8rwmE8b5Q
         Zcgj1JucApy7H7ux4Yj724RHb+fjOBUR6rS2yqG3YxAaafj+qXERMji6I9Pub0OAeq
         G6Nwd5qybMnEfzmhr4ImxffUDjQ5QDJlzEU7TvkVeZrGLLvZDwWR4BxAKTts+1qBCM
         uLfdZKFwPB8bg==
Date:   Thu, 30 Jun 2022 14:50:16 -0700
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
Subject: Re: [PATCH v2 7/9] mm/mshare: Add unlink and munmap support
Message-ID: <Yr4amM9d6HpwH5BW@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <1b0a0e8c9558766f13a64ae93092eb8c9ea7965d.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0a0e8c9558766f13a64ae93092eb8c9ea7965d.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:58PM -0600, Khalid Aziz wrote:
> Number of mappings of an mshare region should be tracked so it can
> be removed when there are no more references to it and associated
> file has been deleted. This add code to support the unlink operation
> for associated file, remove the mshare region on file deletion if
> refcount goes to zero, add munmap operation to maintain refcount
> to mshare region and remove it on last munmap if file has been
> deleted.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  mm/mshare.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mshare.c b/mm/mshare.c
> index 088a6cab1e93..90ce0564a138 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -29,6 +29,7 @@ static struct super_block *msharefs_sb;
>  struct mshare_data {
>  	struct mm_struct *mm;
>  	refcount_t refcnt;
> +	int deleted;
>  	struct mshare_info *minfo;
>  };
>  
> @@ -48,6 +49,7 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>  	size_t ret;
>  	struct mshare_info m_info;
>  
> +	mmap_read_lock(info->mm);
>  	if (info->minfo != NULL) {
>  		m_info.start = info->minfo->start;
>  		m_info.size = info->minfo->size;
> @@ -55,18 +57,42 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>  		m_info.start = 0;
>  		m_info.size = 0;
>  	}
> +	mmap_read_unlock(info->mm);
>  	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
>  	if (!ret)
>  		return -EFAULT;
>  	return ret;
>  }
>  
> +static void
> +msharefs_close(struct vm_area_struct *vma)
> +{
> +	struct mshare_data *info = vma->vm_private_data;
> +
> +	if (refcount_dec_and_test(&info->refcnt)) {
> +		mmap_read_lock(info->mm);
> +		if (info->deleted) {
> +			mmap_read_unlock(info->mm);
> +			mmput(info->mm);
> +			kfree(info->minfo);
> +			kfree(info);

Aren't filesystems supposed to take care of disposing of the file data
in destroy_inode?  IIRC struct inode doesn't go away until all fds are
closed, mappings are torn down, and there are no more references from
dentries.  I could be misremembering since it's been a few months since
I went looking at the (VFS) inode lifecycle.

> +		} else {
> +			mmap_read_unlock(info->mm);
> +		}
> +	}
> +}
> +
> +static const struct vm_operations_struct msharefs_vm_ops = {
> +	.close	= msharefs_close,
> +};
> +
>  static int
>  msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct mshare_data *info = file->private_data;
>  	struct mm_struct *mm = info->mm;
>  
> +	mmap_write_lock(mm);
>  	/*
>  	 * If this mshare region has been set up once already, bail out
>  	 */
> @@ -80,10 +106,14 @@ msharefs_mmap(struct file *file, struct vm_area_struct *vma)
>  	mm->task_size = vma->vm_end - vma->vm_start;
>  	if (!mm->task_size)
>  		mm->task_size--;
> +	mmap_write_unlock(mm);
>  	info->minfo->start = mm->mmap_base;
>  	info->minfo->size = mm->task_size;
> +	info->deleted = 0;
> +	refcount_inc(&info->refcnt);
>  	vma->vm_flags |= VM_SHARED_PT;
>  	vma->vm_private_data = info;
> +	vma->vm_ops = &msharefs_vm_ops;
>  	return 0;
>  }
>  
> @@ -240,6 +270,38 @@ msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  	return ret;
>  }
>  
> +static int
> +msharefs_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct mshare_data *info = inode->i_private;
> +
> +	/*
> +	 * Unmap the mshare region if it is still mapped in
> +	 */
> +	vm_munmap(info->minfo->start, info->minfo->size);
> +
> +	/*
> +	 * Mark msharefs file for deletion so it can not be opened
> +	 * and used for mshare mappings any more
> +	 */
> +	simple_unlink(dir, dentry);
> +	mmap_write_lock(info->mm);
> +	info->deleted = 1;
> +	mmap_write_unlock(info->mm);

What if the file is hardlinked?

--D

> +
> +	/*
> +	 * Is this the last reference? If so, delete mshare region and
> +	 * remove the file
> +	 */
> +	if (!refcount_dec_and_test(&info->refcnt)) {
> +		mmput(info->mm);
> +		kfree(info->minfo);
> +		kfree(info);
> +	}
> +	return 0;
> +}
> +
>  static const struct inode_operations msharefs_file_inode_ops = {
>  	.setattr	= simple_setattr,
>  	.getattr	= simple_getattr,
> @@ -248,7 +310,7 @@ static const struct inode_operations msharefs_dir_inode_ops = {
>  	.create		= msharefs_create,
>  	.lookup		= simple_lookup,
>  	.link		= simple_link,
> -	.unlink		= simple_unlink,
> +	.unlink		= msharefs_unlink,
>  	.mkdir		= msharefs_mkdir,
>  	.rmdir		= simple_rmdir,
>  	.mknod		= msharefs_mknod,
> -- 
> 2.32.0
> 
