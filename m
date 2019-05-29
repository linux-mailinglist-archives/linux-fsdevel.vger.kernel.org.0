Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB52E488
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfE2Sdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 14:33:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51394 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2Sdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 14:33:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIXQbG069667;
        Wed, 29 May 2019 18:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=R/+z/tc0/SAWa0SjP7BukZGNCOg4xR/nOoG03j4CVHg=;
 b=AY8+x7YT5IsFJdGZ5yEg28P8Pb5Qq/PkwNyzpit66iScBYI8KWtUggNJkRFYLyVuhQLF
 pCbL/mCVeHwD20P3DIaRf3HKGDJ89gAaxQZY7xTv2JLGBeBH800nXwE2bNDcj2r2nW3G
 bdntXgcbue4dGK0ymRGzSLMrsIXn2RlQE121bBtu7KXY5EqvR7oFCEeWyA2IYg4oVkOR
 JJRFvWk21dLb8a26pK01BG1F7Dn9YKKobLZ0SOyjFutNg45Piw+Pn8g3lTpg1gnAN89Z
 fhuhNxN/94S2WapfAhE/q+Eb07dctpUtHjtCoqb5yhQ+ChZfjgnYTHuerWyLq5YxWrQ7 dQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dm0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:33:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIX2rG031915;
        Wed, 29 May 2019 18:33:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sr31ve6aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:33:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4TIXZWE000659;
        Wed, 29 May 2019 18:33:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:33:35 -0700
Date:   Wed, 29 May 2019 11:33:33 -0700
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
Subject: Re: [PATCH v3 08/13] vfs: copy_file_range needs to strip setuid bits
 and update timestamps
Message-ID: <20190529183333.GH5231@magnolia>
References: <20190529174318.22424-1-amir73il@gmail.com>
 <20190529174318.22424-9-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529174318.22424-9-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 08:43:12PM +0300, Amir Goldstein wrote:
> Because generic_copy_file_range doesn't hold the destination inode lock
> throughout the copy, strip setuid bits before and after copy.
> 
> The destination inode mtime is updated before and after the copy and the
> source inode atime is updated after the copy, similar to
> generic_file_read_iter().
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks reasonable,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/read_write.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index cec7e7b1f693..706ea5f276a7 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1590,8 +1590,27 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
>  				struct file *file_out, loff_t pos_out,
>  				size_t len, unsigned int flags)
>  {
> -	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> -				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> +	struct inode *inode_out = file_inode(file_out);
> +	int ret, err;
> +
> +	/* Should inode_out lock be held throughout the copy operation? */
> +	inode_lock(inode_out);
> +	err = file_modified(file_out);
> +	inode_unlock(inode_out);
> +	if (err)
> +		return err;
> +
> +	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
> +			       len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
> +
> +	file_accessed(file_in);
> +
> +	/* To be on the safe side, remove privs also after copy */
> +	inode_lock(inode_out);
> +	err = file_modified(file_out);
> +	inode_unlock(inode_out);
> +
> +	return err ?: ret;
>  }
>  EXPORT_SYMBOL(generic_copy_file_range);
>  
> -- 
> 2.17.1
> 
