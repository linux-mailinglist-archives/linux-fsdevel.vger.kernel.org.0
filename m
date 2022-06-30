Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4B562586
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiF3VoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiF3VoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:44:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122753EDD;
        Thu, 30 Jun 2022 14:44:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD6DECE30A2;
        Thu, 30 Jun 2022 21:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D54C341C7;
        Thu, 30 Jun 2022 21:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656625450;
        bh=C13rqpZrJRKSzkLJVmPoFoRJvrW7PfIx75bbaWBZjuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bUkDpa6KxvqO7KAXJUDiUPGhkiQY0XsCTOFU2vNZgXqQgGOXj0YasiMIEBVkQi5Ok
         hKcWImpbrPMHQXkW5INFHvc14rQ2+/A+eqtGO5ngo4DB8JGoR1udv/tGRwcrXPzxJ4
         soWH9MVUR1Eve09zTcKPPfsUu9mN4BH2Yw/ncKtvI3rFa+fN6ZjEykfnG8+99aw1zj
         IJRRldK5vD7DK2uR44geaUbCBPoATIDKOjqKnCacOZFxXsO6exs6Ag+YoAoczm1ls7
         OM+gN5BvCYLiPriYaZ3em2M4I6y1JIELI7b0ZxTO1eEjeEhrV6KTWoTOBNlx49oQ/v
         NMCRAApxotWqA==
Date:   Thu, 30 Jun 2022 14:44:09 -0700
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
Subject: Re: [PATCH v2 6/9] mm/mshare: Add mmap operation
Message-ID: <Yr4ZKd2J8ucA/npV@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <d7ae3b880dc3a26129486d5680db672289d2695c.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7ae3b880dc3a26129486d5680db672289d2695c.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:57PM -0600, Khalid Aziz wrote:
> mmap is used to establish address range for mshare region and map the
> region into process's address space. Add basic mmap operation that
> supports setting address range. Also fix code to not allocate new
> mm_struct for files in msharefs that exist for information and not
> for defining a new mshare region.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/mshare.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mshare.c b/mm/mshare.c
> index d238b68b0576..088a6cab1e93 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -9,7 +9,8 @@
>   *
>   *
>   * Copyright (C) 2022 Oracle Corp. All rights reserved.
> - * Author:	Khalid Aziz <khalid.aziz@oracle.com>
> + * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
> + *		Matthew Wilcox <willy@infradead.org>
>   *
>   */
>  
> @@ -60,9 +61,36 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
>  	return ret;
>  }
>  
> +static int
> +msharefs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct mshare_data *info = file->private_data;
> +	struct mm_struct *mm = info->mm;
> +
> +	/*
> +	 * If this mshare region has been set up once already, bail out
> +	 */
> +	if (mm->mmap_base != 0)
> +		return -EINVAL;
> +
> +	if ((vma->vm_start | vma->vm_end) & (PGDIR_SIZE - 1))
> +		return -EINVAL;
> +
> +	mm->mmap_base = vma->vm_start;
> +	mm->task_size = vma->vm_end - vma->vm_start;
> +	if (!mm->task_size)
> +		mm->task_size--;
> +	info->minfo->start = mm->mmap_base;
> +	info->minfo->size = mm->task_size;

So, uh, if the second mmap() caller decides to ignore the mshare_info,
should they get an -EINVAL here since the memory mappings won't be at
the same process virtual address?

> +	vma->vm_flags |= VM_SHARED_PT;
> +	vma->vm_private_data = info;
> +	return 0;
> +}
> +
>  static const struct file_operations msharefs_file_operations = {
>  	.open		= msharefs_open,
>  	.read_iter	= msharefs_read,
> +	.mmap		= msharefs_mmap,
>  	.llseek		= no_llseek,
>  };
>  
> @@ -119,7 +147,12 @@ msharefs_fill_mm(struct inode *inode)
>  		goto err_free;
>  	}
>  	info->mm = mm;
> -	info->minfo = NULL;
> +	info->minfo = kzalloc(sizeof(struct mshare_info), GFP_KERNEL);
> +	if (info->minfo == NULL) {
> +		retval = -ENOMEM;
> +		goto err_free;
> +	}
> +
>  	refcount_set(&info->refcnt, 1);
>  	inode->i_private = info;
>  
> @@ -128,13 +161,14 @@ msharefs_fill_mm(struct inode *inode)
>  err_free:
>  	if (mm)
>  		mmput(mm);
> +	kfree(info->minfo);
>  	kfree(info);
>  	return retval;
>  }
>  
>  static struct inode
>  *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
> -			umode_t mode)
> +			umode_t mode, bool newmm)
>  {
>  	struct inode *inode = new_inode(sb);
>  	if (inode) {
> @@ -147,7 +181,7 @@ static struct inode
>  		case S_IFREG:
>  			inode->i_op = &msharefs_file_inode_ops;
>  			inode->i_fop = &msharefs_file_operations;
> -			if (msharefs_fill_mm(inode) != 0) {
> +			if (newmm && msharefs_fill_mm(inode) != 0) {
>  				discard_new_inode(inode);
>  				inode = ERR_PTR(-ENOMEM);
>  			}
> @@ -177,7 +211,7 @@ msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>  	struct inode *inode;
>  	int err = 0;
>  
> -	inode = msharefs_get_inode(dir->i_sb, dir, mode);
> +	inode = msharefs_get_inode(dir->i_sb, dir, mode, true);
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> @@ -267,7 +301,7 @@ prepopulate_files(struct super_block *s, struct inode *dir,
>  		if (!dentry)
>  			return -ENOMEM;
>  
> -		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
> +		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode, false);

I was wondering why the information files were getting their own
mshare_data.

TBH I'm not really sure what the difference is between mshare_data and
mshare_info, since those names are not especially distinct.

>  		if (!inode) {
>  			dput(dentry);
>  			return -ENOMEM;
> @@ -301,7 +335,7 @@ msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_d_op		= &msharefs_d_ops;
>  	sb->s_time_gran		= 1;
>  
> -	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777);
> +	inode = msharefs_get_inode(sb, NULL, S_IFDIR | 0777, false);

Is it wise to default to world-writable?  Surely whatever userspace
software wraps an msharefs can relax permissions as needed.

--D

>  	if (!inode) {
>  		err = -ENOMEM;
>  		goto out;
> -- 
> 2.32.0
> 
