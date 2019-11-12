Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E64D8F988A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 19:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLSXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 13:23:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51926 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLSXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:23:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACIIn2T042133;
        Tue, 12 Nov 2019 18:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=gNQDayv4/6vSaE3ZOq4DNXB6lT/PH93bkXGOaNWGu20=;
 b=JTZwx1veX8A2Jl5RB6ahp+wnSC1suS3PcTN10DafY40jg/3ppS1tn4SQIt57upV+AzXK
 IVfNxzlMs4vkoXFKfGr48Y7FcMwa16ZB9lGgpIMADmGaqtdm1OWTG1HcGSAiWuTYK0vv
 FXNETtswG1oIQcWBXrKERB+czXc2VIksWqYcdPkvF5H3bRq4ZZTf+FWRCIZAIPhOGBVw
 6ssZo8b8iWa1nYK1QnbBgEe7jG0UrDtswZJwf9rWtfR8RU6teYi+pl9TskeSRrTW269Y
 /Ap+6PbLIVzgPjhZjoFALfmUwcNxLrlAuA9BHtrPSVp2gxBvRaYyKdc6+sV7un4/hB6Z hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w5p3qpnes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 18:23:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACIN03o033380;
        Tue, 12 Nov 2019 18:23:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w7vpmqpp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 18:23:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xACIMrt9002418;
        Tue, 12 Nov 2019 18:22:56 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 10:22:53 -0800
Subject: Re: [PATCH v2] hugetlbfs: add O_TMPFILE support
To:     Piotr Sarna <p.sarna@tlen.pl>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, mhocko@kernel.org,
        syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <bc9383eff6e1374d79f3a92257ae829ba1e6ae60.1573285189.git.p.sarna@tlen.pl>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <603fc4b5-92c9-1ccf-82d3-699e24af97d9@oracle.com>
Date:   Tue, 12 Nov 2019 10:22:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bc9383eff6e1374d79f3a92257ae829ba1e6ae60.1573285189.git.p.sarna@tlen.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Andrew

On 11/8/19 11:50 PM, Piotr Sarna wrote:
> With hugetlbfs, a common pattern for mapping anonymous huge pages
> is to create a temporary file first. Currently libraries like
> libhugetlbfs and seastar create these with a standard mkstemp+unlink
> trick, but it would be more robust to be able to simply pass
> the O_TMPFILE flag to open(). O_TMPFILE is already supported by several
> file systems like ext4 and xfs. The implementation simply uses the existing
> d_tmpfile utility function to instantiate the dcache entry for the file.
> 
> Tested manually by successfully creating a temporary file by opening
> it with (O_TMPFILE|O_RDWR) on mounted hugetlbfs and successfully
> mapping 2M huge pages with it. Without the patch, trying to open
> a file with O_TMPFILE results in -ENOSUP.
> 
> v2 changes:
>  * syzkaller thankfully discovered a bug during unmount - tmpfile
> erroneously called dget() on a dentry when creating a tmpfile,
> and it was never countered by a dput(), because tmpfile is never
> explicitly unlinked. In v2, dget() is simply not called for tmpfile.
> Verified manually, and also with the reproducer provided by syzkaller.
> Reported-by: syzbot+136d2439a4e6561ea00c@syzkaller.appspotmail.com
> 
> Signed-off-by: Piotr Sarna <p.sarna@tlen.pl>

My apologies for not catching the extra dget().

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  fs/hugetlbfs/inode.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a478df035651..a39d7a0a158e 100644
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
> @@ -824,13 +827,23 @@ static int hugetlbfs_mknod(struct inode *dir,
>  	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
>  	if (inode) {
>  		dir->i_ctime = dir->i_mtime = current_time(dir);
> -		d_instantiate(dentry, inode);
> -		dget(dentry);	/* Extra count - pin the dentry in core */
> +		if (tmpfile) {
> +			d_tmpfile(dentry, inode);
> +		} else {
> +			d_instantiate(dentry, inode);
> +			dget(dentry);/* Extra count - pin the dentry in core */
> +		}
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
> @@ -844,6 +857,12 @@ static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mo
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
> @@ -1102,6 +1121,7 @@ static const struct inode_operations hugetlbfs_dir_inode_operations = {
>  	.mknod		= hugetlbfs_mknod,
>  	.rename		= simple_rename,
>  	.setattr	= hugetlbfs_setattr,
> +	.tmpfile	= hugetlbfs_tmpfile,
>  };
>  
>  static const struct inode_operations hugetlbfs_inode_operations = {
> 
