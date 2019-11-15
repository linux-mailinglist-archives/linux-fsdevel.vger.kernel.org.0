Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7AAFD1FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 01:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKOAbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 19:31:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKOAbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:31:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF0NwPc162409;
        Fri, 15 Nov 2019 00:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9jrL+BhqTPJfGslBLcrIu2gfpEanXTGlkl6dwq3AI5s=;
 b=FAkJB/fkPdwLwF8fI+cc3AEY0b6WrXBX6fm3i4eCPJjFDKMhs8jADyZLQO/WOqP9MRAM
 1U9JW9DSlV6YDhTbTuLGaSSqZfA0y+bkPqmC7PFfqYbGJ9OSGQVczF6uEc9jtvMrwUck
 J5sDuHbVx/0tesYGT2ZE+DknD4PAHILfdfr0r3mM08kBc6ryg36z79AaBdI/TrScBb0i
 YqP7Ye82SYVq1wYoDRg67HMMdxEb67tK0P6s56mCx5+bozBshVbAFe5u3vCT0RLvA0Rp
 R7hVjTVl3KwgOtZ6JLV5xS7gaT2JxKY1RW/xCypn/ocC+NETtGud7EMNQ7rUHbmjDp7m mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w9gxpg3ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 00:29:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF0TBTh006674;
        Fri, 15 Nov 2019 00:29:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2w9h171780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 00:29:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAF0SAK0027264;
        Fri, 15 Nov 2019 00:28:10 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 16:28:09 -0800
Date:   Thu, 14 Nov 2019 16:28:07 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] Documentation/fs: Move swap_[de]activate() to
 file_operations
Message-ID: <20191115002807.GN6219@magnolia>
References: <20191114231943.11220-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114231943.11220-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:19:43PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the documentation for the move of the swap_* functions out of
> address_space_operations and into file_operations.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> Follow on to the V2 series sent earlier.  If I need to spin a V3 I will squash
> this into patch 2/2 "fs: Move swap_[de]activate to file_operations"
> 
>  Documentation/filesystems/vfs.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..03a740d7faa4 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -731,8 +731,6 @@ cache in your filesystem.  The following members are defined:
>  					      unsigned long);
>  		void (*is_dirty_writeback) (struct page *, bool *, bool *);
>  		int (*error_remove_page) (struct mapping *mapping, struct page *page);
> -		int (*swap_activate)(struct file *);
> -		int (*swap_deactivate)(struct file *);
>  	};
>  
>  ``writepage``
> @@ -924,16 +922,6 @@ cache in your filesystem.  The following members are defined:
>  	Setting this implies you deal with pages going away under you,
>  	unless you have them locked or reference counts increased.
>  
> -``swap_activate``
> -	Called when swapon is used on a file to allocate space if
> -	necessary and pin the block lookup information in memory.  A
> -	return value of zero indicates success, in which case this file
> -	can be used to back swapspace.
> -
> -``swap_deactivate``
> -	Called during swapoff on files where swap_activate was
> -	successful.
> -
>  
>  The File Object
>  ===============
> @@ -988,6 +976,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
>  					   struct file *file_out, loff_t pos_out,
>  					   loff_t len, unsigned int remap_flags);
>  		int (*fadvise)(struct file *, loff_t, loff_t, int);
> +		int (*swap_activate)(struct file *);
> +		int (*swap_deactivate)(struct file *);
>  	};
>  
>  Again, all methods are called without any locks being held, unless
> @@ -1108,6 +1098,16 @@ otherwise noted.
>  ``fadvise``
>  	possibly called by the fadvise64() system call.
>  
> +``swap_activate``
> +	Called when swapon is used on a file to allocate space if
> +	necessary and pin the block lookup information in memory.  A
> +	return value of zero indicates success, in which case this file
> +	can be used to back swapspace.
> +
> +``swap_deactivate``
> +	Called during swapoff on files where swap_activate was
> +	successful.
> +
>  Note that the file operations are implemented by the specific
>  filesystem in which the inode resides.  When opening a device node
>  (character or block special) most filesystems will call special
> -- 
> 2.21.0
> 
