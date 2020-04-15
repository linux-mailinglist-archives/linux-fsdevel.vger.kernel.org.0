Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D851AAB82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414635AbgDOPLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:11:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49366 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgDOPLn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:11:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FF3gY5073535;
        Wed, 15 Apr 2020 15:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MOfRD5Cwea5AiSC2Q578nXPPlxyjV7Yye8pgBK2f8w8=;
 b=FeKL6UhPMQbqcyY7ee3CsyLWbT39OUkh2vC+AQ4j6iStWi5nZNdQk/tF5wUs82V07zuI
 KUjkaLMX36ovwLFQWfpVVmJasYIzugob0YYaPqJn/GY0Tm9rLKZTVX8KWlpeWk5r+toW
 jPBsA/Oo2FtA7V5eDCS8lzF1cEdY85CJa9X9sGXQeadoJPUYxmqObu/s0lsBt/3CupEm
 nT7PL3G+Kbh0/x663X20kuMfxp5X+tF3H/3TQZtOgYEOqGv32EsA5xtAEp613TUdTKfS
 kasQzEo4dGDfKIgTTlt79Rn0DD30pONcmKnP2zJvxIxOk5adq4a6iG6wBacuu1smDjeL vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30e0aa1h95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:11:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FF7Axu112260;
        Wed, 15 Apr 2020 15:11:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30dyveyqjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:11:27 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03FFBPIm031474;
        Wed, 15 Apr 2020 15:11:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:11:24 -0700
Date:   Wed, 15 Apr 2020 08:11:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 04/11] fs/xfs: Change XFS_MOUNT_DAX to
 XFS_MOUNT_DAX_ALWAYS
Message-ID: <20200415151123.GM6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-5-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=1 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:16PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In prep for the new tri-state mount option which then introduces
> XFS_MOUNT_DAX_NEVER.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks straightforward,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iops.c  | 2 +-
>  fs/xfs/xfs_mount.h | 2 +-
>  fs/xfs/xfs_super.c | 8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..a6e634631da8 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1248,7 +1248,7 @@ xfs_inode_supports_dax(
>  		return false;
>  
>  	/* DAX mount option or DAX iflag must be set. */
> -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> +	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
>  	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
>  		return false;
>  
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 88ab09ed29e7..54bd74088936 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -233,7 +233,7 @@ typedef struct xfs_mount {
>  						   allocator */
>  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
>  
> -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> +#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */
>  
>  /*
>   * Max and min values for mount-option defined I/O
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2094386af8ac..3863f41757d2 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -129,7 +129,7 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX,		",dax" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
>  		{ 0, NULL }
>  	};
>  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> @@ -1244,7 +1244,7 @@ xfs_fc_parse_param(
>  		return 0;
>  #ifdef CONFIG_FS_DAX
>  	case Opt_dax:
> -		mp->m_flags |= XFS_MOUNT_DAX;
> +		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
>  		return 0;
>  #endif
>  	default:
> @@ -1437,7 +1437,7 @@ xfs_fc_fill_super(
>  	if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
>  		sb->s_flags |= SB_I_VERSION;
>  
> -	if (mp->m_flags & XFS_MOUNT_DAX) {
> +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS) {
>  		bool rtdev_is_dax = false, datadev_is_dax;
>  
>  		xfs_warn(mp,
> @@ -1451,7 +1451,7 @@ xfs_fc_fill_super(
>  		if (!rtdev_is_dax && !datadev_is_dax) {
>  			xfs_alert(mp,
>  			"DAX unsupported by block device. Turning off DAX.");
> -			mp->m_flags &= ~XFS_MOUNT_DAX;
> +			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
>  		}
>  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
>  			xfs_alert(mp,
> -- 
> 2.25.1
> 
