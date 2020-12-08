Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C72D1FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgLHA5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:57:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47522 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLHA5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:57:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B80YKjn038668;
        Tue, 8 Dec 2020 00:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=U/dyakwiWc7+xAZiW+3Ap9OtSNcPA2QXU4eEN25gH28=;
 b=Iu/FMq6qDfhJLvaOP0dbEPkUf0nYcQ9kAzxKh9/cPvI6Bv0r3mGmZhdHPwabVPSehkU0
 5QuqGaXEE4dDzLKkmw7ILVSPJOMG1ttU7nhOULExcn/HzrQ2Wvwygy2sSKN2aPmKecPb
 /HcleIWMU7xUG2w+kkAdgY+1hliyDuCr9+VQS7fgHcFnBBNGg5uRyy54Ox/EC+SR+1Le
 Xy0AIW8WZMz1488//fXFR9PKU1gwYt+QCsrEvOa6cX1egWsns8n/37c/xjklpQ8vruTx
 Pf8lSdAfs1sW6zKGOdMihm9RRGYXv6HY5B88S6iSzRO2QpcrGO24M8XO2wHOTQiRWd49 uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mqra8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Dec 2020 00:56:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B80Zg7i194232;
        Tue, 8 Dec 2020 00:56:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 358m4x1u4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Dec 2020 00:56:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B80ug53013520;
        Tue, 8 Dec 2020 00:56:42 GMT
Received: from localhost (/10.159.240.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 16:56:42 -0800
Date:   Mon, 7 Dec 2020 16:56:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, tytso@mit.edu,
        khazhy@google.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 4/8] vfs: Add superblock notifications
Message-ID: <20201208005640.GB106255@magnolia>
References: <20201208003117.342047-1-krisman@collabora.com>
 <20201208003117.342047-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208003117.342047-5-krisman@collabora.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=1
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:31:13PM -0300, Gabriel Krisman Bertazi wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Add a superblock event notification facility whereby notifications about
> superblock events, such as I/O errors (EIO), quota limits being hit
> (EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
> process asynchronously.  Note that this does not cover vfsmount topology
> changes.  watch_mount() is used for that.

<being a lazy reviewer and skipping straight to the data format>

> diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
> index c3d8320b5d3a..937363d9f7b3 100644
> --- a/include/uapi/linux/watch_queue.h
> +++ b/include/uapi/linux/watch_queue.h
> @@ -14,7 +14,8 @@
>  enum watch_notification_type {
>  	WATCH_TYPE_META		= 0,	/* Special record */
>  	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
> -	WATCH_TYPE__NR		= 2
> +	WATCH_TYPE_SB_NOTIFY	= 2,
> +	WATCH_TYPE__NR		= 3
>  };
>  
>  enum watch_meta_notification_subtype {
> @@ -101,4 +102,35 @@ struct key_notification {
>  	__u32	aux;		/* Per-type auxiliary data */
>  };
>  
> +/*
> + * Type of superblock notification.
> + */
> +enum superblock_notification_type {
> +	NOTIFY_SUPERBLOCK_READONLY	= 0, /* Filesystem toggled between R/O and R/W */
> +	NOTIFY_SUPERBLOCK_ERROR		= 1, /* Error in filesystem or blockdev */
> +	NOTIFY_SUPERBLOCK_EDQUOT	= 2, /* EDQUOT notification */
> +	NOTIFY_SUPERBLOCK_NETWORK	= 3, /* Network status change */
> +};
> +
> +#define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
> +
> +/*
> + * Superblock notification record.
> + * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
> + * - watch.subtype = enum superblock_notification_subtype
> + */
> +struct superblock_notification {
> +	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
> +	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
> +};
> +
> +struct superblock_error_notification {
> +	struct superblock_notification s; /* subtype = notify_superblock_error */
> +	__u32	error_number;
> +	__u32	error_cookie;
> +	__u64	inode;
> +	__u64	block;

Is this a file offset?  In ... i_blocksize() units?  What about
filesystems that have multiple file offset mapping structures, like xfs?

IOWs can we make a structure that covers enough of the "common"ly
desired features that we don't just end up with the per-fs but then
duplicated everywhere mess that is GETFLAGS/FSGETXATTR?

> +	char	desc[0];

If the end of this is a VLA then I guess we can't add new fields by
bumping the size and hoping userspace notices.  I guess that implies the
need for some padding and a flags field that we can set bits in when we
start using that padding...

--D

> +};
> +
>  #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index f27ac94d5fa7..3e97984bc4c8 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -51,6 +51,9 @@ COND_SYSCALL_COMPAT(io_pgetevents);
>  COND_SYSCALL(io_uring_setup);
>  COND_SYSCALL(io_uring_enter);
>  COND_SYSCALL(io_uring_register);
> +COND_SYSCALL(fsinfo);
> +COND_SYSCALL(watch_mount);
> +COND_SYSCALL(watch_sb);
>  
>  /* fs/xattr.c */
>  
> -- 
> 2.29.2
> 
