Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA98E78D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 19:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfJ1S4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 14:56:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfJ1S4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:56:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SIuPuA174521;
        Mon, 28 Oct 2019 18:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=IOAXWhMYWeGKeUi81PtSJEzWNZH3zKwPPKw7ido2V8A=;
 b=NoaPRHCehlflv67d4iE86rQ4l6vO3auOolY56GTk4Yqga/Xf6CIe2o2VMU7Rb0i99okq
 qTYlcsjBbcszvKpJ46LJ7KCD03CvHO1mRVMhYyeVJuHajw6yIYe55JkZpipALqESunQ0
 7zblOV8TW//x/EiHaLjH2qsrSiKXSWWZWedNqOOBrtgxWT0qwA/QcNKixbV9QMYb/wKc
 CdjsYCkvGQ2gaEPzJRvNgnnc561YDtP6oFMJ07TAcX+Ks0y4Q1UP0OjEQOnS0X31mNG1
 snO5eS10bUTUVFJ3W0ChqgLZU7J5xzDqe13h7fO72HYYpu9SaFglIbuzZ64oZElk2D+G PQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vve3q40cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 18:56:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SIrjBv183375;
        Mon, 28 Oct 2019 18:56:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vw09g9cfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 18:56:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9SIuMKB000701;
        Mon, 28 Oct 2019 18:56:23 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 11:56:22 -0700
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
To:     Piotr Sarna <p.sarna@tlen.pl>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8a037fea-cb19-8f18-3ada-34e9fcb723fc@oracle.com>
Date:   Mon, 28 Oct 2019 11:56:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280180
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Andrew

On 10/15/19 2:01 AM, Piotr Sarna wrote:
> With hugetlbfs, a common pattern for mapping anonymous huge pages
> is to create a temporary file first. Currently libraries like
> libhugetlbfs and seastar create these with a standard mkstemp+unlink
> trick, but it would be more robust to be able to simply pass
> the O_TMPFILE flag to open(). O_TMPFILE is already supported by several
> file systems like ext4 and xfs. The implementation simply uses the existing
> d_tmpfile utility function to instantiate the dcache entry for the file.

Let's drop the mention of anonymous mapping to avoid any confusion.  If
we include use cases, the above paragraph could be rewritten as:

O_TMPFILE is an option used to create an unnamed temporary regular
file.  Currently, libhugetlbfs and Seastar use a combination of
mkstemp and unlink to accomplish similar functionality on hugetlbfs.
Add O_TMPFILE support to hugetlbfs so that it can potentially be used
by existing users (Seastar) and new users (Oracle DB).  Support is
added by simply using the d_tmpfile utility function to instantiate
the dcache entry for a temporary file.

> Tested manually by successfully creating a temporary file by opening
> it with (O_TMPFILE|O_RDWR) on mounted hugetlbfs and successfully
> mapping 2M huge pages with it. Without the patch, trying to open
> a file with O_TMPFILE results in -ENOSUP.
> 
> Signed-off-by: Piotr Sarna <p.sarna@tlen.pl>

The code looks good,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  fs/hugetlbfs/inode.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 1dcc57189382..277b7d231db8 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -815,8 +815,11 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  /*
>   * File creation. Allocate an inode, and we're done..
>   */
> -static int hugetlbfs_mknod(struct inode *dir,
> -			struct dentry *dentry, umode_t mode, dev_t dev)
> +static int do_hugetlbfs_mknod(struct inode *dir,
> +			struct dentry *dentry,
> +			umode_t mode,
> +			dev_t dev,
> +			bool tmpfile)
>  {
>  	struct inode *inode;
>  	int error = -ENOSPC;
> @@ -824,13 +827,22 @@ static int hugetlbfs_mknod(struct inode *dir,
>  	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
>  	if (inode) {
>  		dir->i_ctime = dir->i_mtime = current_time(dir);
> -		d_instantiate(dentry, inode);
> +		if (tmpfile)
> +			d_tmpfile(dentry, inode);
> +		else
> +			d_instantiate(dentry, inode);
>  		dget(dentry);	/* Extra count - pin the dentry in core */
>  		error = 0;
>  	}
>  	return error;
>  }
>  
> +static int hugetlbfs_mknod(struct inode *dir,
> +			struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
> +}
> +
>  static int hugetlbfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  {
>  	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
> @@ -844,6 +856,12 @@ static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mo
>  	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
>  }
>  
> +static int hugetlbfs_tmpfile(struct inode *dir,
> +			struct dentry *dentry, umode_t mode)
> +{
> +	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
> +}
> +
>  static int hugetlbfs_symlink(struct inode *dir,
>  			struct dentry *dentry, const char *symname)
>  {
> @@ -1102,6 +1120,7 @@ static const struct inode_operations hugetlbfs_dir_inode_operations = {
>  	.mknod		= hugetlbfs_mknod,
>  	.rename		= simple_rename,
>  	.setattr	= hugetlbfs_setattr,
> +	.tmpfile	= hugetlbfs_tmpfile,
>  };
>  
>  static const struct inode_operations hugetlbfs_inode_operations = {
> 
