Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF73C0DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 03:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbfFKBQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 21:16:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38406 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbfFKBQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:16:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B19VBh021984;
        Tue, 11 Jun 2019 01:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dZ4SAJZhd5Q4WV4dut65+JOCXVTYUBOJtQZE5FULqOo=;
 b=NGZnBarjtpLycFtuBYdrL7fFhxMB6u+5fG+44RmoSfdy6nwgcyqjONOlZLnec8vxsb6J
 1cDnMk54QTiblSR0lq5E0VtxaEP1jqjhXiwWlgdd6AetqNyq01TLWhHvIk8DVqT22Meq
 sYjD2wi2sGXJlsZDOp1KTxwcGVqIFLOdhhkM00w4TtX0OzrskV+ID2IE6PnHOqXFmdmJ
 3YS3ashw3HXpNKlDewalGWkyC+LcHi2P+/p+r8Dqpszm5skIF4o1FiuzA1wZWJnwboDO
 m0OKuHaGqC/SNSVZB8Cgcw52JXRqfpsb9zyP9fSOFdvGtiF7Vx8Rj6Xd4lEfOf4jJpc1 9Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nqhy2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 01:16:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B1FFXg165134;
        Tue, 11 Jun 2019 01:16:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t024u4gen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 01:16:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B1GGnN018615;
        Tue, 11 Jun 2019 01:16:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 18:16:16 -0700
Date:   Mon, 10 Jun 2019 18:16:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org
Subject: Re: [PATCH] vfs: allow copy_file_range from a swapfile
Message-ID: <20190611011612.GQ1871505@magnolia>
References: <20190610172606.4119-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610172606.4119-1-amir73il@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 08:26:06PM +0300, Amir Goldstein wrote:
> read(2) is allowed from a swapfile, so copy_file_range(2) should
> be allowed as well.
> 
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Fixes: 96e6e8f4a68d ("vfs: add missing checks to copy_file_range")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Darrick,
> 
> This fixes the generic/554 issue reported by Ted.

Frankly I think we should go the other way -- non-root doesn't get to
copy from or read from swap files.

--D

> I intend to remove the test case of copy from swap file from
> generic/554, so test is expected to pass with or without this fix.
> But if you wait for next week's xfstests update before applying
> this fix, then at lease maintainer that run current xfstests master
> could use current copy-file-range-fixes branch to pass the tests.
> 
> Thanks,
> Amir.
> 
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index aac71aef4c61..f74e5ce7ca50 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3081,7 +3081,7 @@ int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	if (IS_IMMUTABLE(inode_out))
>  		return -EPERM;
>  
> -	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
> +	if (IS_SWAPFILE(inode_out))
>  		return -ETXTBSY;
>  
>  	/* Ensure offsets don't wrap. */
> -- 
> 2.17.1
> 
