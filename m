Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44372A118F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 00:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJ3XX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 19:23:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44390 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgJ3XX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:23:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNJTs0180708;
        Fri, 30 Oct 2020 23:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LKM5YE/4S0vq+r+ScmSiY8Sc2ha9E0VPkHqFfunlD/8=;
 b=UzGdmJCVGL5d5Gk3ZkH5k+SPaN1Lb1y2OrycImQY56hT2kkh4QXx7SXffxsvAuOJ4yOy
 PoMPTcafDJc+GBEQMU5K1mcFEYl0BlnD0Gy5sdBv6I0gcfsLWdlMixAOwVS8ads2nF6C
 oogA7QS3aylZWyPjg71hqvOiVz3ZUkKbNRTb1EDQl2jOkkLZpbKJDD+V54nGlADHOMAV
 zIu1i0hR07dJQcO3c8uWFAx3GJfpwRGFQvLaEBCU6Djl0PyoMImsv3mVn6AO6r9VM7YE
 gdp0E8jGiZ4sLSLSg1wnkBKBySCQsr3yQ9ABJ/FoydYmV95JoC4XVAcngyELzTpwjUwG Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm4hk5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Oct 2020 23:23:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09UNKS3P188202;
        Fri, 30 Oct 2020 23:23:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34cx1v0w48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 23:23:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09UNNr9x004272;
        Fri, 30 Oct 2020 23:23:53 GMT
Received: from [192.168.1.226] (/67.1.244.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Oct 2020 16:23:53 -0700
Subject: Re: [PATCH v2 1/3] xfs: flush new eof page on truncate to avoid
 post-eof corruption
To:     Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-2-bfoster@redhat.com>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <3fb87b6a-93d7-b9ba-9394-f3821cad3950@oracle.com>
Date:   Fri, 30 Oct 2020 16:23:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029132325.1663790-2-bfoster@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9790 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010300176
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/29/20 6:23 AM, Brian Foster wrote:
> It is possible to expose non-zeroed post-EOF data in XFS if the new
> EOF page is dirty, backed by an unwritten block and the truncate
> happens to race with writeback. iomap_truncate_page() will not zero
> the post-EOF portion of the page if the underlying block is
> unwritten. The subsequent call to truncate_setsize() will, but
> doesn't dirty the page. Therefore, if writeback happens to complete
> after iomap_truncate_page() (so it still sees the unwritten block)
> but before truncate_setsize(), the cached page becomes inconsistent
> with the on-disk block. A mapped read after the associated page is
> reclaimed or invalidated exposes non-zero post-EOF data.
> 
> For example, consider the following sequence when run on a kernel
> modified to explicitly flush the new EOF page within the race
> window:
> 
> $ xfs_io -fc "falloc 0 4k" -c fsync /mnt/file
> $ xfs_io -c "pwrite 0 4k" -c "truncate 1k" /mnt/file
>    ...
> $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> 00000400:  00 00 00 00 00 00 00 00  ........
> $ umount /mnt/; mount <dev> /mnt/
> $ xfs_io -c "mmap 0 4k" -c "mread -v 1k 8" /mnt/file
> 00000400:  cd cd cd cd cd cd cd cd  ........
> 
> Update xfs_setattr_size() to explicitly flush the new EOF page prior
> to the page truncate to ensure iomap has the latest state of the
> underlying block.
> 
Ok, makes sense
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>   fs/xfs/xfs_iops.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 5e165456da68..1414ab79eacf 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -911,6 +911,16 @@ xfs_setattr_size(
>   		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
>   				&did_zeroing, &xfs_buffered_write_iomap_ops);
>   	} else {
> +		/*
> +		 * iomap won't detect a dirty page over an unwritten block (or a
> +		 * cow block over a hole) and subsequently skips zeroing the
> +		 * newly post-EOF portion of the page. Flush the new EOF to
> +		 * convert the block before the pagecache truncate.
> +		 */
> +		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> +						     newsize);
> +		if (error)
> +			return error;
>   		error = iomap_truncate_page(inode, newsize, &did_zeroing,
>   				&xfs_buffered_write_iomap_ops);
>   	}
> 
