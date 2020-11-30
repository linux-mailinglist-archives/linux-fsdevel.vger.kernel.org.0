Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41E2C8C5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgK3SOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:14:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgK3SOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:14:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUI4qXi098424;
        Mon, 30 Nov 2020 18:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/OJ02YCjmtLXoz74sYzWBWs5+4jEBYC+5Xs+LwXYED8=;
 b=mGo8baEUXAWci5GqXvWKrU1WPoMXVNb5SLM9INfOmFUbxvCPCu+vJgIpAMgJdB9VAn2d
 Qo5w2zt17zlAvVnFVZOt1Ti3YDSNGcj67FsIyYLSkDXuOCu6WHrRfsOYh5CI3uc5T25R
 WMwmlpg0nNSUDApXR6zZwLSEUeHSMFABvTVBX9XlDg3xahaNsJR3LlDm07GEbSJvNmXL
 XCbrO12J/n+Hgx+Pf6OxqyF15sgYJfgXhixldT2p3C/aWZ/JntgVUUTsioY24LZlV9VW
 T3QnEEZovKF6ZRsvGO6v3fZ1P3EABGC8XPpLBKUPPyTVWwgHoTGzmJs4X4MI2K7IgDII LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkegg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 18:13:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AUIAD2D112776;
        Mon, 30 Nov 2020 18:11:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540aqy4cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 18:11:09 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AUIB5qB016810;
        Mon, 30 Nov 2020 18:11:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 10:11:05 -0800
Date:   Mon, 30 Nov 2020 10:11:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201130181104.GA143005@magnolia>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:26:05PM +0900, Naohiro Aota wrote:
> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
> REQ_OP_ZONE_APPEND.
> 
> To utilize it, we need to set the bio_op before calling
> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
> and restricted bio.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Christoph's answers seem reasonable to me, so

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Er... do you want me to take this one via the iomap tree?

--D

> ---
>  fs/iomap/direct-io.c  | 41 +++++++++++++++++++++++++++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..f04572a55a09 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -200,6 +200,34 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	iomap_dio_submit_bio(dio, iomap, bio, pos);
>  }
>  
> +/*
> + * Figure out the bio's operation flags from the dio request, the
> + * mapping, and whether or not we want FUA.  Note that we can end up
> + * clearing the WRITE_FUA flag in the dio request.
> + */
> +static inline unsigned int
> +iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
> +{
> +	unsigned int opflags = REQ_SYNC | REQ_IDLE;
> +
> +	if (!(dio->flags & IOMAP_DIO_WRITE)) {
> +		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
> +		return REQ_OP_READ;
> +	}
> +
> +	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> +		opflags |= REQ_OP_ZONE_APPEND;
> +	else
> +		opflags |= REQ_OP_WRITE;
> +
> +	if (use_fua)
> +		opflags |= REQ_FUA;
> +	else
> +		dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> +
> +	return opflags;
> +}
> +
>  static loff_t
>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
> @@ -278,6 +306,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +		/*
> +		 * Set the operation flags early so that bio_iov_iter_get_pages
> +		 * can set up the page vector appropriately for a ZONE_APPEND
> +		 * operation.
> +		 */
> +		bio->bi_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
> +
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
>  			/*
> @@ -292,14 +327,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		n = bio->bi_iter.bi_size;
>  		if (dio->flags & IOMAP_DIO_WRITE) {
> -			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
> -			if (use_fua)
> -				bio->bi_opf |= REQ_FUA;
> -			else
> -				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
>  			task_io_account_write(n);
>  		} else {
> -			bio->bi_opf = REQ_OP_READ;
>  			if (dio->flags & IOMAP_DIO_DIRTY)
>  				bio_set_pages_dirty(bio);
>  		}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..1bccd1880d0d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -54,6 +54,7 @@ struct vm_fault;
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> +#define IOMAP_F_ZONE_APPEND	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:
> -- 
> 2.27.0
> 
