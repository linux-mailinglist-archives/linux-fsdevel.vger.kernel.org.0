Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12771B4A80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDVQaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 12:30:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35070 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVQaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:30:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGJ3QZ160038;
        Wed, 22 Apr 2020 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vL1WQGTfFoQcm8Nxga5aT5tV4G2eJXdNUImCVFUgisY=;
 b=F1/kBkTBIEp7pe5PWH7FrLOGy44SfdV5MXUL4AtMKGOEEGLmvQccPzK0XTRxwOXm881G
 mmMOrAi/gCE5t3OwoRRZNV8LK+qeGdpLjfT6U1xIO4WqRGTholFn5HIMD/i2ozJPFHhk
 0FBWH/U605x6JynSYAAofhbzPzbBgclmNcZjyQttYJrpjN+PYoPGCkkXdA5oMKSb2PTW
 NZ3G9gPCApyhDAmdmSPOO2RuvSseUVm6+FDfnsgXVwQk0MsxipxowWUw7DuPqypu/3M7
 K92MAWj5KBXqlvDArPNr9RGjA59QctkErefyUbhuJDOdshla8atoKQJICJHgnjeOboq1 iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30fsgm3xq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:29:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGBd1B051303;
        Wed, 22 Apr 2020 16:29:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30gb3u63dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:29:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MGTrqw010298;
        Wed, 22 Apr 2020 16:29:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 09:29:52 -0700
Date:   Wed, 22 Apr 2020 09:29:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 03/11] fs/stat: Define DAX statx attribute
Message-ID: <20200422162951.GE6733@magnolia>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-4-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=1 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:17:45PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order for users to determine if a file is currently operating in DAX
> state (effective DAX).  Define a statx attribute value and set that
> attribute if the effective DAX flag is set.
> 
> To go along with this we propose the following addition to the statx man
> page:
> 
> STATX_ATTR_DAX
> 
> 	The file is in the DAX (cpu direct access) state.  DAX state
> 	attempts to minimize software cache effects for both I/O and
> 	memory mappings of this file.  It requires a file system which
> 	has been configured to support DAX.
> 
> 	DAX generally assumes all accesses are via cpu load / store
> 	instructions which can minimize overhead for small accesses, but
> 	may adversely affect cpu utilization for large transfers.
> 
> 	File I/O is done directly to/from user-space buffers and memory
> 	mapped I/O may be performed with direct memory mappings that
> 	bypass kernel page cache.
> 
> 	While the DAX property tends to result in data being transferred
> 	synchronously, it does not give the same guarantees of O_SYNC
> 	where data and the necessary metadata are transferred together.
> 
> 	A DAX file may support being mapped with the MAP_SYNC flag,
> 	which enables a program to use CPU cache flush instructions to
> 	persist CPU store operations without an explicit fsync(2).  See
> 	mmap(2) for more information.

One thing I hadn't noticed before -- this is a change to userspace API,
so please cc this series to linux-api@vger.kernel.org when you send V10.

Also, I've started to think about commit order sequencing for actually
landing this series.  Usually I try to put vfs and documentation things
before xfs stuff, which means I came up with:

vfs       xfs          I_DONTCACHE
2 3 11    1 4 5 6 7    8 9 10

Note that I separated the DONTCACHE part because it touches VFS
internals, which implies a higher standard of review (aka Al) and I do
not wish to hold up the 2-3-11-1-4-5-6-7 patches if the dontcache part
becomes contentious.

What do you think of that ordering?

(Heck, maybe I'll just put patch 1 in the queue for 5.8 right now...)

--D

> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V2:
> 	Update man page text with comments from Darrick, Jan, Dan, and
> 	Dave.
> ---
>  fs/stat.c                 | 3 +++
>  include/uapi/linux/stat.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 030008796479..894699c74dde 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -79,6 +79,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> +	if (IS_DAX(inode))
> +		stat->attributes |= STATX_ATTR_DAX;
> +
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
>  					    query_flags);
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index ad80a5c885d5..e5f9d5517f6b 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -169,6 +169,7 @@ struct statx {
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
> +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.25.1
> 
