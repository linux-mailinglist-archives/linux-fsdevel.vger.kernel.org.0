Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC12F1BCD0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD1UIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:08:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgD1UIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:08:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SJxG5K007306;
        Tue, 28 Apr 2020 20:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=obAQjQOwpznu0IDV9eQOTSEo+Ud2NPo//XlLR2mtfqI=;
 b=dMLJbQRzQZWDRF9Ts6l5Fvrhd+ZNNDdEjofFnXezDgfUKozOuxsPOI3Sq8zJijwNpEkB
 t/JD51mcNr3bW/Efq8/HZs0hatE6R1YEf/NXkY/6JLUPxAjKE8FFtzXT4n9H5x0gbLHL
 2YiaiH8YgjAVHfFvfMYSZZQ5Y0UCJEqTPasbhruwXSaI9zFTqzv3fJZZ5YfqFfsL+sJQ
 k+nB6E/w6J4MVipn9saVHrvTI3e6ToO7fTSVxf6dtmJaCh5fhXb8GXJ7yYe/XFXERIWv
 vvJCv2thp3Sd8/DqkDLPfIjVMF5HHrgoqTmVrKKK+CoRgDbpsMLsA8UDrQ3hZSf3FAh9 cw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p07hw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:08:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SK84Go194206;
        Tue, 28 Apr 2020 20:08:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30mxx0nj0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 20:08:13 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SK8BHE002188;
        Tue, 28 Apr 2020 20:08:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 13:08:11 -0700
Date:   Tue, 28 Apr 2020 13:08:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V11 06/11] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200428200809.GB6742@magnolia>
References: <20200428002142.404144-1-ira.weiny@intel.com>
 <20200428002142.404144-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428002142.404144-7-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 05:21:37PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> continues to operate the same.  We add 'always', 'never', and 'inode'
> (default).
> 
> [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from V10:
> 	Move show options to xfs_info_set array
> 
> Changes from V9:
> 	Fix indentation in xfs_mount_set_dax_mode()
> 	Do not report dax=inode
> 
> Changes from v8:
> 	Move NEVER bit to 27
> 	Use xfs signature style
> 	use xfs_dax_mode enum
> 
> Changes from v7:
> 	Change to XFS_MOUNT_DAX_NEVER
> 
> Changes from v6:
> 	Use 2 flag bits rather than a field.
> 	change iflag to inode
> 
> Changes from v5:
> 	New Patch
> ---
>  fs/xfs/xfs_mount.h |  1 +
>  fs/xfs/xfs_super.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index f6123fb0113c..37bfb50db809 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -238,6 +238,7 @@ typedef struct xfs_mount {
>  						   allocator */
>  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
>  #define XFS_MOUNT_DAX_ALWAYS	(1ULL << 26)
> +#define XFS_MOUNT_DAX_NEVER	(1ULL << 27)
>  
>  /*
>   * Max and min values for mount-option defined I/O
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index ce169d1c7474..e80bd2c4c279 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -47,6 +47,39 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
>  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
>  #endif
>  
> +enum xfs_dax_mode {
> +	XFS_DAX_INODE = 0,
> +	XFS_DAX_ALWAYS = 1,
> +	XFS_DAX_NEVER = 2,
> +};
> +
> +static void
> +xfs_mount_set_dax_mode(
> +	struct xfs_mount	*mp,
> +	enum xfs_dax_mode	mode)
> +{
> +	switch (mode) {
> +	case XFS_DAX_INODE:
> +		mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
> +		break;
> +	case XFS_DAX_ALWAYS:
> +		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> +		mp->m_flags &= ~XFS_MOUNT_DAX_NEVER;
> +		break;
> +	case XFS_DAX_NEVER:
> +		mp->m_flags |= XFS_MOUNT_DAX_NEVER;
> +		mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> +		break;
> +	}
> +}
> +
> +static const struct constant_table dax_param_enums[] = {
> +	{"inode",	XFS_DAX_INODE },
> +	{"always",	XFS_DAX_ALWAYS },
> +	{"never",	XFS_DAX_NEVER },
> +	{}
> +};
> +
>  /*
>   * Table driven mount option parser.
>   */
> @@ -59,7 +92,7 @@ enum {
>  	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
>  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
>  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
> -	Opt_discard, Opt_nodiscard, Opt_dax,
> +	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
>  };
>  
>  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> @@ -103,6 +136,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
>  	fsparam_flag("discard",		Opt_discard),
>  	fsparam_flag("nodiscard",	Opt_nodiscard),
>  	fsparam_flag("dax",		Opt_dax),
> +	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
>  	{}
>  };
>  
> @@ -129,7 +163,8 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
> +		{ XFS_MOUNT_DAX_ALWAYS,		",dax=always" },
> +		{ XFS_MOUNT_DAX_NEVER,		",dax=never" },
>  		{ 0, NULL }
>  	};
>  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> @@ -1261,7 +1296,10 @@ xfs_fc_parse_param(
>  		return 0;
>  #ifdef CONFIG_FS_DAX
>  	case Opt_dax:
> -		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> +		xfs_mount_set_dax_mode(mp, XFS_DAX_ALWAYS);
> +		return 0;
> +	case Opt_dax_enum:
> +		xfs_mount_set_dax_mode(mp, result.uint_32);
>  		return 0;
>  #endif
>  	default:
> @@ -1468,7 +1506,7 @@ xfs_fc_fill_super(
>  		if (!rtdev_is_dax && !datadev_is_dax) {
>  			xfs_alert(mp,
>  			"DAX unsupported by block device. Turning off DAX.");
> -			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
>  		}
>  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
>  			xfs_alert(mp,
> -- 
> 2.25.1
> 
