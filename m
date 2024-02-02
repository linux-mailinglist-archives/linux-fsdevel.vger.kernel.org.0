Return-Path: <linux-fsdevel+bounces-10032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D928472EE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB2B1C21388
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AF145B20;
	Fri,  2 Feb 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j85XMo5p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533D13D509;
	Fri,  2 Feb 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887061; cv=none; b=HECebzP3f9ryLyqJ7QtgEeO0uHV5xMBOXwHsEdm2krNyfpPLE5PCt5G8PJkEpzC5++FKs1Au7l8E4ScvA7jcodFzNOgNyNGmvEP6bPDF3iVIlOaBp4CDLpoF3rYB+w9YUQY0SFWMWJdccHThvGga4MDQmifpgb1EVji9H3rvHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887061; c=relaxed/simple;
	bh=Qj6RFHzGCtyQ3s/1CUNpHqWDXe+I0Ydgjdi9NzAXhq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOthnSFp8HNCTN5onctlcGLoCApsR0ruprGUE1VUtrGh8J6YBuERvCVCZV8O7rcCKfABFhsW1gvrNG4g0+zlan/Cc6AX8fQ7M+T7mP1+5Y26iWl2gn166e+sW4klVk2cxZqyrM1UpXot2IRZz8sUhId/RehBfzkebyzJCMjpVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j85XMo5p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412ExhBR016214;
	Fri, 2 Feb 2024 15:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1ereFQbPV6oTCdYo/qMNrsWmjswlJzn5BUjci1wggcI=;
 b=j85XMo5p23BDbfaHXV/S7UeeHgoob2/KUz2MMTIGhFdtqSKga6oX0rIlOq9J54tcnzey
 e1Mpj0Io5y7Ub2haApn1Yc1IJG192m7/7yKm+gngGU20qDWBP5t/Le3hTuPg/hU+8q8x
 qcOIsPcXD3zC8v0Fwa8AnbzGgX3ytU2vaEnuWs9KeOW+RTX4O3oPYzW1UbnpeVPrwczu
 5jdCrh1SWrr2VmTvYHvrHzPVRPSpo6vvJZQdWiG97fiFXha7TL7qMJNlhaRP2o4M7vm1
 tvx1fR5rwc8j3jkXTi9Y31Or7iwMJWPRX3x9cVXRDeiMv/bZp6exP73EEcluqX6/1g7Y 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11ybhn5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:17:29 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412EeDbf021064;
	Fri, 2 Feb 2024 15:17:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11ybhn50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:17:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412CIGBK010511;
	Fri, 2 Feb 2024 15:17:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pc199-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:17:28 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412FHRGb4784874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 15:17:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43555805D;
	Fri,  2 Feb 2024 15:17:27 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D9258059;
	Fri,  2 Feb 2024 15:17:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 15:17:27 +0000 (GMT)
Message-ID: <0bfb559c-5b35-480f-99f6-c3b7552244e1@linux.ibm.com>
Date: Fri, 2 Feb 2024 10:17:27 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240202110132.1584111-3-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eBDgJv6QZHK8uRcr-0gmTOcbgxVgFLps
X-Proofpoint-ORIG-GUID: b0NkIyAqWIQO6Qy3b8L1pJc3dUeh4PQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=954 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020111



On 2/2/24 06:01, Amir Goldstein wrote:
> The only remaining user of ->d_real() method is d_real_inode(), which
> passed NULL inode argument to get the real data dentry.
> 
> There are no longer any users that call ->d_real() with a non-NULL
> inode argument for getting a detry from a specific underlying layer.
> 
> Remove the inode argument of the method and replace it with an integer
> 'type' argument, to allow callers to request the real metadata dentry
> instead of the real data dentry.
> 
> All the current users of d_real_inode() (e.g. uprobe) continue to get
> the real data inode.  Caller that need to get the real metadata inode
> (e.g. IMA/EVM) can use d_inode(d_real(dentry, D_REAL_METADATA)).
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   Documentation/filesystems/locking.rst |  2 +-
>   Documentation/filesystems/vfs.rst     | 16 ++++-----
>   fs/overlayfs/super.c                  | 52 ++++++++++++---------------
>   include/linux/dcache.h                | 18 ++++++----
>   4 files changed, 41 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index d5bf4b6b7509..453039a2e49b 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -29,7 +29,7 @@ prototypes::
>   	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
>   	struct vfsmount *(*d_automount)(struct path *path);
>   	int (*d_manage)(const struct path *, bool);
> -	struct dentry *(*d_real)(struct dentry *, const struct inode *);
> +	struct dentry *(*d_real)(struct dentry *, int type);
>   
>   locking rules:
>   
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index eebcc0f9e2bc..2a39e718fdf8 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1264,7 +1264,7 @@ defined:
>   		char *(*d_dname)(struct dentry *, char *, int);
>   		struct vfsmount *(*d_automount)(struct path *);
>   		int (*d_manage)(const struct path *, bool);
> -		struct dentry *(*d_real)(struct dentry *, const struct inode *);
> +		struct dentry *(*d_real)(struct dentry *, int type);
>   	};
>   
>   ``d_revalidate``
> @@ -1419,16 +1419,14 @@ defined:
>   	the dentry being transited from.
>   
>   ``d_real``
> -	overlay/union type filesystems implement this method to return
> -	one of the underlying dentries hidden by the overlay.  It is
> -	used in two different modes:
> +	overlay/union type filesystems implement this method to return one
> +	of the underlying dentries of a regular file hidden by the overlay.
>   
> -	Called from file_dentry() it returns the real dentry matching
> -	the inode argument.  The real dentry may be from a lower layer
> -	already copied up, but still referenced from the file.  This
> -	mode is selected with a non-NULL inode argument.
> +	The 'type' argument takes the values D_REAL_DATA or D_REAL_METADATA
> +	for returning the real underlying dentry that refers to the inode
> +	hosting the file's data or metadata respectively.
>   
> -	With NULL inode the topmost real underlying dentry is returned.
> +	For non-regular files, the 'dentry' argument is returned.
>   
>   Each dentry has a pointer to its parent dentry, as well as a hash list
>   of child dentries.  Child dentries are basically like files in a
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 2eef6c70b2ae..938852a0a92b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -28,41 +28,38 @@ MODULE_LICENSE("GPL");
>   
>   struct ovl_dir_cache;
>   
> -static struct dentry *ovl_d_real(struct dentry *dentry,
> -				 const struct inode *inode)
> +static struct dentry *ovl_d_real(struct dentry *dentry, int type)
>   {
> -	struct dentry *real = NULL, *lower;
> +	struct dentry *upper, *lower;
>   	int err;
>   
> -	/*
> -	 * vfs is only expected to call d_real() with NULL from d_real_inode()
> -	 * and with overlay inode from file_dentry() on an overlay file.
> -	 *
> -	 * TODO: remove @inode argument from d_real() API, remove code in this
> -	 * function that deals with non-NULL @inode and remove d_real() call
> -	 * from file_dentry().
> -	 */
> -	if (inode && d_inode(dentry) == inode)
> -		return dentry;
> -	else if (inode)
> +	switch (type) {
> +	case D_REAL_DATA:
> +	case D_REAL_METADATA:
> +		break;
> +	default:
>   		goto bug;
> +	}
>   
>   	if (!d_is_reg(dentry)) {
>   		/* d_real_inode() is only relevant for regular files */
>   		return dentry;
>   	}
>   
> -	real = ovl_dentry_upper(dentry);
> -	if (real && (inode == d_inode(real)))
> -		return real;
> +	upper = ovl_dentry_upper(dentry);
> +	if (upper && (type == D_REAL_METADATA ||
> +		      ovl_has_upperdata(d_inode(dentry))))
> +		return upper;
>   
> -	if (real && !inode && ovl_has_upperdata(d_inode(dentry)))
> -		return real;
> +	if (type == D_REAL_METADATA) {
> +		lower = ovl_dentry_lower(dentry);
> +		goto real_lower;
> +	}
>   
>   	/*
> -	 * Best effort lazy lookup of lowerdata for !inode case to return
> +	 * Best effort lazy lookup of lowerdata for D_REAL_DATA case to return
>   	 * the real lowerdata dentry.  The only current caller of d_real() with
> -	 * NULL inode is d_real_inode() from trace_uprobe and this caller is
> +	 * D_REAL_DATA is d_real_inode() from trace_uprobe and this caller is
>   	 * likely going to be followed reading from the file, before placing
>   	 * uprobes on offset within the file, so lowerdata should be available
>   	 * when setting the uprobe.
> @@ -73,18 +70,13 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
>   	lower = ovl_dentry_lowerdata(dentry);
>   	if (!lower)
>   		goto bug;
> -	real = lower;
>   
> -	/* Handle recursion */
> -	real = d_real(real, inode);
> +real_lower:
> +	/* Handle recursion into stacked lower fs */
> +	return d_real(lower, type);
>   
> -	if (!inode || inode == d_inode(real))
> -		return real;
>   bug:
> -	WARN(1, "%s(%pd4, %s:%lu): real dentry (%p/%lu) not found\n",
> -	     __func__, dentry, inode ? inode->i_sb->s_id : "NULL",
> -	     inode ? inode->i_ino : 0, real,
> -	     real && d_inode(real) ? d_inode(real)->i_ino : 0);
> +	WARN(1, "%s(%pd4, %d): real dentry not found\n", __func__, dentry, type);
>   	return dentry;
>   }
>   
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 1666c387861f..019ad02f2b7e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -139,7 +139,7 @@ struct dentry_operations {
>   	char *(*d_dname)(struct dentry *, char *, int);
>   	struct vfsmount *(*d_automount)(struct path *);
>   	int (*d_manage)(const struct path *, bool);
> -	struct dentry *(*d_real)(struct dentry *, const struct inode *);
> +	struct dentry *(*d_real)(struct dentry *, int type);
>   } ____cacheline_aligned;
>   
>   /*
> @@ -543,27 +543,31 @@ static inline struct inode *d_backing_inode(const struct dentry *upper)
>   	return inode;
>   }
>   
> +enum d_real_type {
> +	D_REAL_DATA,
> +	D_REAL_METADATA,
> +};
> +
>   /**
>    * d_real - Return the real dentry
>    * @dentry: the dentry to query
> - * @inode: inode to select the dentry from multiple layers (can be NULL)
> + * @type: the type of real dentry (data or metadata)
>    *
>    * If dentry is on a union/overlay, then return the underlying, real dentry.
>    * Otherwise return the dentry itself.
>    *
>    * See also: Documentation/filesystems/vfs.rst
>    */
> -static inline struct dentry *d_real(struct dentry *dentry,
> -				    const struct inode *inode)
> +static inline struct dentry *d_real(struct dentry *dentry, int type)
>   {
>   	if (unlikely(dentry->d_flags & DCACHE_OP_REAL))
> -		return dentry->d_op->d_real(dentry, inode);
> +		return dentry->d_op->d_real(dentry, type);
>   	else
>   		return dentry;
>   }
>   
>   /**
> - * d_real_inode - Return the real inode
> + * d_real_inode - Return the real inode hosting the data
>    * @dentry: The dentry to query
>    *
>    * If dentry is on a union/overlay, then return the underlying, real inode.
> @@ -572,7 +576,7 @@ static inline struct dentry *d_real(struct dentry *dentry,
>   static inline struct inode *d_real_inode(const struct dentry *dentry)
>   {
>   	/* This usage of d_real() results in const dentry */
> -	return d_backing_inode(d_real((struct dentry *) dentry, NULL));
> +	return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>   }
>   
>   struct name_snapshot {

