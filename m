Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6F1AAB9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbgDOPQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:16:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58196 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389664AbgDOPQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:16:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFDqV4079901;
        Wed, 15 Apr 2020 15:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=azv6A8fofaaJBqvoTQzO8i+St/tE6gT3+0uEX2GLyaU=;
 b=BP5WqtaID1z19AxeGAKOwEYT9GUJBrFefGFKCMqJR0ClLr6+ywb9nmEafuC2cumWE2Ie
 rrVpo3GhQ9mQqvWIUjRIHuzkN33/8V+F8XTTuyFbLRb+JCkllwQeHvd5H3Z6d30qlYk2
 drGzT0vf/Z+8F3vtfDbyg6e8vjM9ieKtR7VZyouL7qPoWFQBJYFWbD30zvHuoaHFQgSk
 6Okk6scfogYSdW/KpwRuPwxJZ/FOqSEKTNhAGxf2oIroqDdrQxuKwKVm9L8wlHEHuJwi
 T0/7NYVAeW736Fs+KGy3BUb3VDA8ul84AbdLW7K7EaljKGe0Vx3QE1A6/htV+lvmliJf dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30e0bf9h8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:16:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFDEVS043676;
        Wed, 15 Apr 2020 15:16:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30dn8wdnr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:16:16 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03FFGFdf001887;
        Wed, 15 Apr 2020 15:16:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:16:15 -0700
Date:   Wed, 15 Apr 2020 08:16:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 05/11] fs/xfs: Make DAX mount option a tri-state
Message-ID: <20200415151613.GO6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-6-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:17PM -0700, ira.weiny@intel.com wrote:
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
>  fs/xfs/xfs_mount.h |  3 ++-
>  fs/xfs/xfs_super.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 54bd74088936..2e88c30642e3 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -233,7 +233,8 @@ typedef struct xfs_mount {
>  						   allocator */
>  #define XFS_MOUNT_NOATTR2	(1ULL << 25)	/* disable use of attr2 format */
>  
> -#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)	/* TEST ONLY! */
> +#define XFS_MOUNT_DAX_ALWAYS	(1ULL << 62)
> +#define XFS_MOUNT_DAX_NEVER	(1ULL << 63)
>  
>  /*
>   * Max and min values for mount-option defined I/O
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 3863f41757d2..142e5d03566f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -47,6 +47,32 @@ static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
>  static struct xfs_kobj xfs_dbg_kobj;	/* global debug sysfs attrs */
>  #endif
>  
> +enum {

enum xfs_dax_mode {  for the reasons given below?

> +	XFS_DAX_INODE = 0,
> +	XFS_DAX_ALWAYS = 1,
> +	XFS_DAX_NEVER = 2,
> +};
> +
> +static void xfs_mount_set_dax_mode(struct xfs_mount *mp, u32 val)

xfs style, please:

static void
xfs_mount_set_dax_mode(
	struct xfs_mount	*mp,
	u32			val)

or if you give a name to the enum above, you can enforce some type
safety too:

	enum xfs_dax_mode	val)

> +{
> +	if (val == XFS_DAX_INODE) {

and this probably could have been a "switch (val) {", in which case if
the enum ever gets expanded then gcc will whine about missing switch
cases.

The rest of the patch looks good.

--D

> +		mp->m_flags &= ~(XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER);
> +	} else if (val == XFS_DAX_ALWAYS) {
> +		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
> +		mp->m_flags &= ~XFS_MOUNT_DAX_NEVER;
> +	} else if (val == XFS_DAX_NEVER) {
> +		mp->m_flags |= XFS_MOUNT_DAX_NEVER;
> +		mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
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
> -		{ XFS_MOUNT_DAX_ALWAYS,		",dax" },
>  		{ 0, NULL }
>  	};
>  	struct xfs_mount	*mp = XFS_M(root->d_sb);
> @@ -185,6 +211,13 @@ xfs_fs_show_options(
>  	if (!(mp->m_qflags & XFS_ALL_QUOTA_ACCT))
>  		seq_puts(m, ",noquota");
>  
> +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS)
> +		seq_puts(m, ",dax=always");
> +	else if (mp->m_flags & XFS_MOUNT_DAX_NEVER)
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
> -		mp->m_flags |= XFS_MOUNT_DAX_ALWAYS;
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
> -			mp->m_flags &= ~XFS_MOUNT_DAX_ALWAYS;
> +			xfs_mount_set_dax_mode(mp, XFS_DAX_NEVER);
>  		}
>  		if (xfs_sb_version_hasreflink(&mp->m_sb)) {
>  			xfs_alert(mp,
> -- 
> 2.25.1
> 
