Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE1173B57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgB1PZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:25:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46474 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgB1PZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:25:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFMoaq164697;
        Fri, 28 Feb 2020 15:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wi/nyYcNez5XtXpVTXFLo1tv6ClnI6MdPLSLILuS0NA=;
 b=pQfGutnVZzMX20n9BTCM6h9ghMt2s/LL92vULDxDuUpVSI70C4o5j0gm5/oY91FZPcyo
 o4pKNMci5dftu4zF/H+CcalQMOKBxK+B2HGdWXn0Gmi4970Ti27b5Lc7XXfznJbM5sx2
 oKaLuDKTyYfWP4J7g3NLFFRTrt18pUH3ZprOo/4jLoZ0mVqy3WLdKKuh7VA41SlXWik6
 u8YcuwjSzeuNWn8lyDSSnuvKPhDujlV7yAnBIH2/t4LtX/RpLlkWd6xKL4SZ5FtVb7P2
 Y4/OSNEtVzVay8kTByq9ch5WErzgvxwJ6GCub1Ob2mtgU2dSa2x4X9q7N7zdNbfTWqFc Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct3kfqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:25:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SFMLL7169382;
        Fri, 28 Feb 2020 15:25:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ydcs8rkfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 15:25:26 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SFPPoV012644;
        Fri, 28 Feb 2020 15:25:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 07:25:24 -0800
Date:   Fri, 28 Feb 2020 07:25:24 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200228152524.GE8036@magnolia>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:56PM +0530, Ritesh Harjani wrote:
> ext4_iomap_begin is already implemented which provides ext4_map_blocks,
> so just move the API from generic_block_bmap to iomap_bmap for iomap
> conversion.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6cf3b969dc86..81fccbae0aea 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3214,7 +3214,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
>  			return 0;
>  	}
>  
> -	return generic_block_bmap(mapping, block, ext4_get_block);
> +	return iomap_bmap(mapping, block, &ext4_iomap_ops);

/me notes that iomap_bmap will filemap_write_and_wait for you, so one
could optimize ext4_bmap to avoid the double-flush by moving the
filemap_write_and_wait at the top of the function into the JDATA state
clearing block.

OTOH it's bmap, who cares... :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  }
>  
>  static int ext4_readpage(struct file *file, struct page *page)
> -- 
> 2.21.0
> 
