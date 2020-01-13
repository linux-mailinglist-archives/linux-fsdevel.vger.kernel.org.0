Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253BC139C5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAMWW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:22:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMWW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:22:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMIIDR193120;
        Mon, 13 Jan 2020 22:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zPglb8UhbO+chGhG6wk5CJulSpyMF19uAt4IoPjXOk8=;
 b=qRNp3GXO0QymCdwNBUWWWEH5+lsY3l3T6R32GvGpMj9D6zVGI0H8g/YG1mQFyVVA7ZLG
 7eVelb+li75WXODKZxZtZ8kyImuolHGeBB0RBjrP+gHdonkzBjiHZAkLqLPUHFr8Orf0
 ezQXoUxMRwOevMZzYFDUGoybICd55/WyQK9bDLT6GrMlyCqxBr3SHN1mjWfdyPHzcri0
 yG7jDnOw2ZmyGuF5/kjMJEfMzHubWsz2mgWqdYI+N4ihy3kmqSmOo9YR4RwR8cQFFwCz
 458aXN6myy6qQa0FjnG6z0FVIIvJtSkjwgetPOOv80XeDP1jck6vvIO01Iu58Us57Xjn gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xf74s2018-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:22:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DMJYxe005880;
        Mon, 13 Jan 2020 22:22:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xfqvtksq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:22:16 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DMMFae023817;
        Mon, 13 Jan 2020 22:22:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:22:14 -0800
Date:   Mon, 13 Jan 2020 14:22:12 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Message-ID: <20200113222212.GO8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192942.25021-10-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=990
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:29:39AM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Page faults need to ensure the inode mode is correct and consistent with
> the vmf information at the time of the fault.  There is no easy way to
> ensure the vmf information is correct if a mode change is in progress.
> Furthermore, there is no good use case to require a mode change while
> the file is mmap'ed.
> 
> Track mmap's of the file and fail the mode change if the file is
> mmap'ed.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/inode.c         |  2 ++
>  fs/xfs/xfs_ioctl.c |  8 ++++++++
>  include/linux/fs.h |  1 +
>  mm/mmap.c          | 19 +++++++++++++++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 2b0f51161918..944711aed6f8 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -245,6 +245,8 @@ static struct inode *alloc_inode(struct super_block *sb)
>  		return NULL;
>  	}
>  
> +	atomic64_set(&inode->i_mapped, 0);
> +
>  	return inode;
>  }
>  
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index bc3654fe3b5d..1ab0906c6c7f 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1200,6 +1200,14 @@ xfs_ioctl_setattr_dax_invalidate(
>  		goto out_unlock;
>  	}
>  
> +	/*
> +	 * If there is a mapping in place we must remain in our current mode.
> +	 */
> +	if (atomic64_read(&inode->i_mapped)) {

Urk, should we really be messing around with the address space
internals?

> +		error = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	error = filemap_write_and_wait(inode->i_mapping);
>  	if (error)
>  		goto out_unlock;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 631f11d6246e..6e7dc626b657 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -740,6 +740,7 @@ struct inode {
>  #endif
>  
>  	void			*i_private; /* fs or device private pointer */
> +	atomic64_t               i_mapped;

I would have expected to find this in struct address_space since the
mapping count is a function of the address space, right?

--D

>  } __randomize_layout;
>  
>  struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dfaf1130e706..e6b68924b7ca 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -171,12 +171,17 @@ void unlink_file_vma(struct vm_area_struct *vma)
>  static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>  {
>  	struct vm_area_struct *next = vma->vm_next;
> +	struct file *f = vma->vm_file;
>  
>  	might_sleep();
>  	if (vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
> -	if (vma->vm_file)
> -		fput(vma->vm_file);
> +	if (f) {
> +		struct inode *inode = file_inode(f);
> +		if (inode)
> +			atomic64_dec(&inode->i_mapped);
> +		fput(f);
> +	}
>  	mpol_put(vma_policy(vma));
>  	vm_area_free(vma);
>  	return next;
> @@ -1837,6 +1842,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	vma_set_page_prot(vma);
>  
> +	/*
> +	 * Track if there is mapping in place such that a mode change
> +	 * does not occur on a file which is mapped
> +	 */
> +	if (file) {
> +		struct inode		*inode = file_inode(file);
> +
> +		atomic64_inc(&inode->i_mapped);
> +	}
> +
>  	return addr;
>  
>  unmap_and_free_vma:
> -- 
> 2.21.0
> 
