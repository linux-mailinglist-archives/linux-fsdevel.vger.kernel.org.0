Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58211A6913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgDMPqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 11:46:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54662 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgDMPqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:46:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFh1R3160819;
        Mon, 13 Apr 2020 15:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=AHrJxL4X55srYQ+/3yvE8f7O6waLCDsvPFXc6+i5JFI=;
 b=k+Hrf5//t57+qcRZXt48Z0JhBsNs9FAH4NYnt8sHRHCWrsdI8ZBkqKEHnf+iGG3icxJQ
 gOLdvSp6IjtUUWD63qIARZmJDrphbOh09n3galr0d/kFKFUfUwBH61Eetu4q7mpCDQp6
 JBtve1Vp7+UaPFAOhG8mKujfuU7fKppwpAW9kB5m0+mWxo4B/2/xw8S1ML5BQZRhFeaD
 NkAtfSvbl4wQmkfnRfvUnOdIyFc7oR47rBtfmibejr9ksMN84qKG6z05xddf3hyqDlRw
 m2sJDCzZN+EJzbKxeLsX0v+PSs+BKrwauhfBF5J2NcNJrOpYHA4iMH4JXCrREYPuiV5s ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30b5aqy9hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:46:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFfhAC158885;
        Mon, 13 Apr 2020 15:46:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30bqceerwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:46:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03DFkOE3003326;
        Mon, 13 Apr 2020 15:46:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 08:46:24 -0700
Date:   Mon, 13 Apr 2020 08:46:19 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 4/9] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200413154619.GT6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-5-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-5-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:41PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> As agreed upon[1].  We make the dax mount option a tri-state.  '-o dax'
> continues to operate the same.  We add 'always', 'never', and 'inode'
> (default).
> 
> [1] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v6:
> 	Use 2 flag bits rather than a field.
> 	change iflag to inode
> 
> Changes from v5:
> 	New Patch
> ---
>  fs/xfs/xfs_mount.h |  3 ++-
>  fs/xfs/xfs_super.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 88ab09ed29e7..d581b990e59a 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -233,7 +233,8 @@ typedef struct xfs_mount {
>  						   allocator */
>  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
>  
> -#define XFS_MOUNT_DAX		(1ULL << 62)	/* TEST ONLY! */
> +#define XFS_MOUNT_DAX		(1ULL << 62)
> +#define XFS_MOUNT_NODAX		(1ULL << 63)
>  
>  /*
>   * Max and min values for mount-option defined I/O
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 2094386af8ac..d7bd8f5e00c9 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -47,6 +47,32 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
>  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
>  #endif
>  
> +enum {
> +	XFS_DAX_INODE = 0,
> +	XFS_DAX_ALWAYS = 1,
> +	XFS_DAX_NEVER = 2,
> +};
> +
> +static void xfs_mount_set_dax_mode(struct xfs_mount *mp, u32 val)
> +{
> +	if (val == XFS_DAX_INODE) {
> +		mp->m_flags &= ~(XFS_MOUNT_DAX | XFS_MOUNT_NODAX);
> +	} else if (val == XFS_DAX_ALWAYS) {
> +		mp->m_flags &= ~XFS_MOUNT_NODAX;
> +		mp->m_flags |= XFS_MOUNT_DAX;
> +	} else if (val == XFS_DAX_NEVER) {
> +		mp->m_flags &= ~XFS_MOUNT_DAX;
> +		mp->m_flags |= XFS_MOUNT_NODAX;
> +	}
> +}
> +
> +static const struct constant_table dax_param_enums[] = {
> +	{"inode",	XFS_DAX_INODE },
> +	{"always",	XFS_DAX_ALWAYS },
> +	{"never",	XFS_DAX_NEVER },
> +	{}

I think that the dax_param_enums table (and the unnamed enum defining
XFS_DAX_*) probably ought to be part of the VFS so that you don't have
to duplicate these two pieces whenever it's time to bring ext4 in line
with XFS.

That probably doesn't need to be done right away, though...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


> +};
> +
>  /*
>   * Table driven mount option parser.
>   */
> @@ -59,7 +85,7 @@ enum {
>  	Opt_filestreams, Opt_quota, Opt_noquota, Opt_usrquota, Opt_grpquota,
>  	Opt_prjquota, Opt_uquota, Opt_gquota, Opt_pquota,
>  	Opt_uqnoenforce, Opt_gqnoenforce, Opt_pqnoenforce, Opt_qnoenforce,
> -	Opt_discard, Opt_nodiscard, Opt_dax,
> +	Opt_discard, Opt_nodiscard, Opt_dax, Opt_dax_enum,
>  };
>  
>  static const struct fs_parameter_spec xfs_fs_parameters[] = {
> @@ -103,6 +129,7 @@ static const struct fs_parameter_spec xfs_fs_parameters[] = {
>  	fsparam_flag("discard",		Opt_discard),
>  	fsparam_flag("nodiscard",	Opt_nodiscard),
>  	fsparam_flag("dax",		Opt_dax),
> +	fsparam_enum("dax",		Opt_dax_enum, dax_param_enums),
>  	{}
>  };
>  
> @@ -129,7 +156,6 @@ xfs_fs_show_options(
>  		{ XFS_MOUNT_GRPID,		",grpid" },
>  		{ XFS_MOUNT_DISCARD,		",discard" },
>  		{ XFS_MOUNT_LARGEIO,		",largeio" },
> -		{ XFS_MOUNT_DAX,		",dax" },
>  		{ 0, NULL }
>  	};
>  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> @@ -185,6 +211,13 @@ xfs_fs_show_options(
>  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
>  		seq_puts(m, ",noquota");
>  
> +	if (mp->m_flags & XFS_MOUNT_DAX)
> +		seq_puts(m, ",dax=always");
> +	else if (mp->m_flags & XFS_MOUNT_NODAX)
> +		seq_puts(m, ",dax=never");
> +	else
> +		seq_puts(m, ",dax=inode");
> +
>  	return 0;
>  }
>  
> @@ -1244,7 +1277,10 @@ xfs_fc_parse_param(
>  		return 0;
>  #ifdef CONFIG_FS_DAX
>  	case Opt_dax:
> -		mp->m_flags |= XFS_MOUNT_DAX;
> +		xfs_mount_set_dax_mode(mp, XFS_DAX_ALWAYS);
> +		return 0;
> +	case Opt_dax_enum:
> +		xfs_mount_set_dax_mode(mp, result.uint_32);
>  		return 0;
>  #endif
>  	default:
> @@ -1451,7 +1487,7 @@ xfs_fc_fill_super(
>  		if (!rtdev_is_dax && !datadev_is_dax) {
>  			xfs_alert(mp,
>  			"DAX unsupported by block device. Turning off DAX.");
> -			mp->m_flags &= ~XFS_MOUNT_DAX;
> +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
>  		}
>  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
>  			xfs_alert(mp,
> -- 
> 2.25.1
> 
