Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52398036C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2019 02:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfHCAWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 20:22:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHCAWB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:22:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730IulL186644;
        Sat, 3 Aug 2019 00:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=l6k5vbqxlOwwNcx4bcNLwKkAOS5/N5An/BJQaH1qloo=;
 b=eEvwiM3t7rYsp8QKaTs5+arCg67drDgHL9yTuqboJONpsyilnDc9rGNJldw+Op66IcEQ
 qvKrGVNjdEBNvRlVBMpmrv+OnrMuh91mkcdARm923xbv+OCWnpVSiS/PnF/W9l28QRN8
 KlXLlTAcnTjN1Pg015axoT70FdmR3pjCpP5T6VyOZ7EsC2iVmwLbUGfzY+AS6zr6848I
 IsraF8vJZmTi5hHLd0fcjjQkpJ5hXFCXDNaeb31cpsKExE8qJxBJBo5xynd4xc5BoJle
 aNsshB5B7a1cdD5tc0VXczmUWohqD8tHwXwOgtj3X/88Qw/vkmFQLNRZzA3+5e3IzJKC kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u0e1ud68u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:21:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x730IKlY019903;
        Sat, 3 Aug 2019 00:21:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2u49huqrn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 00:21:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x730Lgqc020882;
        Sat, 3 Aug 2019 00:21:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Aug 2019 17:21:41 -0700
Date:   Fri, 2 Aug 2019 17:21:40 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        hch@lst.de, ruansy.fnst@cn.fujitsu.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190803002140.GA7129@magnolia>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802220048.16142-11-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908030001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9337 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908030001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:00:45PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This helps filesystems to perform tasks on the bio while
> submitting for I/O. Since btrfs requires the position
> we are working on, pass pos to iomap_dio_submit_bio()

What /does/ btrfs_submit_direct do, anyway?  Looks like it's a custom
submission function that ... does something related to setting
checksums?  And, uh, RAID?

> The correct place for submit_io() is not page_ops. Would it
> better to rename the structure to something like iomap_io_ops
> or put it directly under struct iomap?

Seeing as the ->iomap_begin handler knows if the requested op is a
buffered write or a direct write, what if we just declare a union of
ops?

e.g.

struct iomap_page_ops;
struct iomap_directio_ops;

struct iomap {
	<usual stuff>
	union {
		const struct iomap_page_ops *page_ops;
		const struct iomap_directio_ops *directio_ops;
	};
};

--D

> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/direct-io.c  | 16 +++++++++++-----
>  include/linux/iomap.h |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 5279029c7a3c..a802e66bf11f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
>  EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
>  
>  static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
> -		struct bio *bio)
> +		struct bio *bio, loff_t pos)
>  {
>  	atomic_inc(&dio->ref);
>  
> @@ -67,7 +67,13 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		bio_set_polled(bio, dio->iocb);
>  
>  	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
> -	dio->submit.cookie = submit_bio(bio);
> +	if (iomap->page_ops && iomap->page_ops->submit_io) {
> +		iomap->page_ops->submit_io(bio, file_inode(dio->iocb->ki_filp),
> +				pos);
> +		dio->submit.cookie = BLK_QC_T_NONE;
> +	} else {
> +		dio->submit.cookie = submit_bio(bio);
> +	}
>  }
>  
>  static ssize_t iomap_dio_complete(struct iomap_dio *dio)
> @@ -195,7 +201,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	get_page(page);
>  	__bio_add_page(bio, page, len, 0);
>  	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
> -	iomap_dio_submit_bio(dio, iomap, bio);
> +	iomap_dio_submit_bio(dio, iomap, bio, pos);
>  }
>  
>  static loff_t
> @@ -301,11 +307,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		iov_iter_advance(dio->submit.iter, n);
>  
>  		dio->size += n;
> -		pos += n;
>  		copied += n;
>  
>  		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> -		iomap_dio_submit_bio(dio, iomap, bio);
> +		iomap_dio_submit_bio(dio, iomap, bio, pos);
> +		pos += n;
>  	} while (nr_pages);
>  
>  	/*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5b2055e8ca8a..6617e4b6fb6d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -92,6 +92,7 @@ struct iomap_page_ops {
>  			struct iomap *iomap);
>  	void (*page_done)(struct inode *inode, loff_t pos, unsigned copied,
>  			struct page *page, struct iomap *iomap);
> +	dio_submit_t 		*submit_io;
>  };
>  
>  /*
> -- 
> 2.16.4
> 
