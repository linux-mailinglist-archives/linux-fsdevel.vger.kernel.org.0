Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56BE562536
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiF3V2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbiF3V2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F1F51B23;
        Thu, 30 Jun 2022 14:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B26623AA;
        Thu, 30 Jun 2022 21:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2B8C341C8;
        Thu, 30 Jun 2022 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656624471;
        bh=NvqzBC09/Y80e2KCCsJMnIUOFz9YdwiZ8n8imT3Xf0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBnuqmNq9c697lusQeu8grTz767jz7CF7+OCqwXp0lfM27tk6sDfDWJff4BSEj+uV
         t+l/lxthKKe2CFd7EjDGBozodGo3nuc81zyI5CS/JfRJA7NERgu1YM1muQv1V00KCn
         DOSCx6LgT3MxQVCRsMvOsih4PkQPgPpjh8ruXHKpi2HF5nFCTbzTneuGT/W70dODmC
         74s4jSk9sERp6B02J8gPVmpQ/WAGLgQ52gWGBdUSaigHZ8s7r9WJBX/YvkoluFwvSI
         GyLnkgod+yj9geRTSfXIeEWaT+1ULoU4Bsm/Nu7IDTyLljykR6Epph/gxiPwrTCpAH
         cOktWuenPSVQA==
Date:   Thu, 30 Jun 2022 14:27:50 -0700
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
Subject: Re: [PATCH v2 4/9] mm/mshare: Add a read operation for msharefs files
Message-ID: <Yr4VVuCzCp50cu0O@magnolia>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <05649b455e2191642e85cc5522ef39ad49fdeca3.1656531090.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05649b455e2191642e85cc5522ef39ad49fdeca3.1656531090.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:53:55PM -0600, Khalid Aziz wrote:
> When a new file is created under msharefs, allocate a new mm_struct
> that will hold the VMAs for mshare region. Also allocate structure
> to defines the mshare region and add a read operation to the file
> that returns this information about the mshare region. Currently
> this information is returned as a struct:
> 
> struct mshare_info {
> 	unsigned long start;
> 	unsigned long size;
> };
> 
> This gives the start address for mshare region and its size.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
>  include/uapi/linux/mman.h |  5 +++
>  mm/mshare.c               | 64 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index f55bc680b5b0..56fe446e24b1 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -41,4 +41,9 @@
>  #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
>  
> +struct mshare_info {
> +	unsigned long start;
> +	unsigned long size;

You might want to make these explicitly u64, since this is userspace
ABI and you never know when someone will want to do something crazy like
run 32-bit programs with mshare files.

Also you might want to add some padding fields for flags, future
expansion, etc.

> +};
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/mm/mshare.c b/mm/mshare.c
> index 2d5924d39221..d238b68b0576 100644
> --- a/mm/mshare.c
> +++ b/mm/mshare.c
> @@ -22,8 +22,14 @@
>  #include <uapi/linux/magic.h>
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/mman.h>
> +#include <linux/sched/mm.h>
>  
>  static struct super_block *msharefs_sb;
> +struct mshare_data {
> +	struct mm_struct *mm;
> +	refcount_t refcnt;
> +	struct mshare_info *minfo;
> +};
>  
>  static const struct inode_operations msharefs_dir_inode_ops;
>  static const struct inode_operations msharefs_file_inode_ops;
> @@ -34,8 +40,29 @@ msharefs_open(struct inode *inode, struct file *file)
>  	return simple_open(inode, file);
>  }
>  
> +static ssize_t
> +msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
> +{
> +	struct mshare_data *info = iocb->ki_filp->private_data;
> +	size_t ret;
> +	struct mshare_info m_info;
> +
> +	if (info->minfo != NULL) {
> +		m_info.start = info->minfo->start;
> +		m_info.size = info->minfo->size;
> +	} else {
> +		m_info.start = 0;
> +		m_info.size = 0;

Hmmm, read()ing out the shared mapping information.  Heh.

When does this case happen?  Is it before anybody mmaps this file into
an address space?

> +	}
> +	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
> +	if (!ret)
> +		return -EFAULT;
> +	return ret;
> +}
> +
>  static const struct file_operations msharefs_file_operations = {
>  	.open		= msharefs_open,
> +	.read_iter	= msharefs_read,
>  	.llseek		= no_llseek,
>  };
>  
> @@ -73,12 +100,43 @@ static struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +static int
> +msharefs_fill_mm(struct inode *inode)
> +{
> +	struct mm_struct *mm;
> +	struct mshare_data *info = NULL;
> +	int retval = 0;
> +
> +	mm = mm_alloc();
> +	if (!mm) {
> +		retval = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		retval = -ENOMEM;
> +		goto err_free;
> +	}
> +	info->mm = mm;
> +	info->minfo = NULL;
> +	refcount_set(&info->refcnt, 1);
> +	inode->i_private = info;
> +
> +	return 0;
> +
> +err_free:
> +	if (mm)
> +		mmput(mm);
> +	kfree(info);
> +	return retval;
> +}
> +
>  static struct inode
>  *msharefs_get_inode(struct super_block *sb, const struct inode *dir,
>  			umode_t mode)
>  {
>  	struct inode *inode = new_inode(sb);
> -
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
>  		inode_init_owner(&init_user_ns, inode, dir, mode);
> @@ -89,6 +147,10 @@ static struct inode
>  		case S_IFREG:
>  			inode->i_op = &msharefs_file_inode_ops;
>  			inode->i_fop = &msharefs_file_operations;
> +			if (msharefs_fill_mm(inode) != 0) {
> +				discard_new_inode(inode);
> +				inode = ERR_PTR(-ENOMEM);

Is it intentional to clobber the msharefs_fill_mm return value and
replace it with ENOMEM?

--D

> +			}
>  			break;
>  		case S_IFDIR:
>  			inode->i_op = &msharefs_dir_inode_ops;
> -- 
> 2.32.0
> 
