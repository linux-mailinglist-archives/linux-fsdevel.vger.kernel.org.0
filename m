Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C852E476
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfE2S21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:28:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2S20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:28:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIO8Yd061601;
        Wed, 29 May 2019 18:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=RfT9gW7Er1J9xZP6JAugF9XglalP0IO7010HA6GYdY8=;
 b=oCB+8Q7L13xCHMnHr4S1raaHq9+IKuJMcJ6ycuAbjU6hJiaj3YtzZyCS5lDLIRf7CLDB
 vvg0yBNVNPRzOsz/AAZMFjljmjXWYG6jAGiB3cTTmYxBiJ0vbZPWjDen1Dp7NvgQJqdw
 j6Qa1NcIROw1c3GD3h5VXN9++s2HHZrUrCvhIE7UJYdBvXv0fOCek9WqdR7qcljTJH6Y
 rRC+wsyM6P6dUiD/uRSG1V5vVfSHQnvsJKoLAEUPK0ICIANDr2xgx8Y1kWLC1RqTri4v
 l9+IQWa+Bxe/+aTBCt587MUnLOGowN+ZyGszsAN3kvAXtgyiksJcd/gUbw01Ub3HxCDj Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dkytd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:27:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIRZbl026260;
        Wed, 29 May 2019 18:27:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh73veh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:27:52 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TIRoFn005377;
        Wed, 29 May 2019 18:27:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:27:50 -0700
Date:   Wed, 29 May 2019 11:27:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH v3 06/13] vfs: introduce file_modified() helper
Message-ID: <20190529182748.GF5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529174318.22424-7-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290119
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 08:43:10PM +0300, Amir Goldstein wrote:
> The combination of file_remove_privs() and file_update_mtime() is
> quite common in filesystem ->write_iter() methods.
> 
> Modelled after the helper file_accessed(), introduce file_modified()
> and use it from generic_remap_file_range_prep().
> 
> Note that the order of calling file_remove_privs() before
> file_update_mtime() in the helper was matched to the more common order by
> filesystems and not the current order in generic_remap_file_range_prep().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/inode.c         | 20 ++++++++++++++++++++
>  fs/read_write.c    | 21 +++------------------
>  include/linux/fs.h |  2 ++
>  3 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index df6542ec3b88..2885f2f2c7a5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1899,6 +1899,26 @@ int file_update_time(struct file *file)
>  }
>  EXPORT_SYMBOL(file_update_time);
>  
> +/* Caller must hold the file's inode lock */
> +int file_modified(struct file *file)
> +{
> +	int err;
> +
> +	/*
> +	 * Clear the security bits if the process is not being run by root.
> +	 * This keeps people from modifying setuid and setgid binaries.
> +	 */
> +	err = file_remove_privs(file);
> +	if (err)
> +		return err;
> +
> +	if (likely(file->f_mode & FMODE_NOCMTIME))

I would not have thought NOCMTIME is likely?

Maybe it is for io requests coming from overlayfs, but for regular uses
I don't think that's true.

--D

> +		return 0;
> +
> +	return file_update_time(file);
> +}
> +EXPORT_SYMBOL(file_modified);
> +
>  int inode_needs_sync(struct inode *inode)
>  {
>  	if (IS_SYNC(inode))
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b0fb1176b628..cec7e7b1f693 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1980,25 +1980,10 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  		return ret;
>  
>  	/* If can't alter the file contents, we're done. */
> -	if (!(remap_flags & REMAP_FILE_DEDUP)) {
> -		/* Update the timestamps, since we can alter file contents. */
> -		if (!(file_out->f_mode & FMODE_NOCMTIME)) {
> -			ret = file_update_time(file_out);
> -			if (ret)
> -				return ret;
> -		}
> +	if (!(remap_flags & REMAP_FILE_DEDUP))
> +		ret = file_modified(file_out);
>  
> -		/*
> -		 * Clear the security bits if the process is not being run by
> -		 * root.  This keeps people from modifying setuid and setgid
> -		 * binaries.
> -		 */
> -		ret = file_remove_privs(file_out);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL(generic_remap_file_range_prep);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e4d382c4342a..79ffa2958bd8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2177,6 +2177,8 @@ static inline void file_accessed(struct file *file)
>  		touch_atime(&file->f_path);
>  }
>  
> +extern int file_modified(struct file *file);
> +
>  int sync_inode(struct inode *inode, struct writeback_control *wbc);
>  int sync_inode_metadata(struct inode *inode, int wait);
>  
> -- 
> 2.17.1
> 
