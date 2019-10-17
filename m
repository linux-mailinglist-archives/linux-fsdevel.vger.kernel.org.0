Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA2DB688
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503265AbfJQSsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:48:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60472 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503241AbfJQSsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:48:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIiNfI180887;
        Thu, 17 Oct 2019 18:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=GBUBeWjq6gpCZXmY5jRCsCJbNs6+hlvvoe/egHiy1Zw=;
 b=WhAF5/9j5CneTnTNd6HQ1M/m7C+qqDIzkPNDhjn0KkzYgaZMHg/PLzelJH/Vpk/bb77U
 02XmEPdngTeqFuekVHfyAx8hIwFVis/IQgnSZKnjpbJRV0KNuP3XjG9jSPxcz30mnBtc
 IrOAMPT5yqXP+fu78ieiQUJWmffPUQszKliAy85jBTD4ad6JGbOWlYyCBwkUFs0CfXXQ
 ZRAjy1fl//VKe1vevtAZnmg9nQv3YwHE3VALO38vu6ix5Lu/CAV1Nd12MiY/z9+mxs8F
 OLECXbvv0OJJPPwkmIsmcbf/Uzq9aGbNI0tZp6eT/0lbyBm2rQgM6vm3AUERjU9VFcaG FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frr5un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:48:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIm61m095407;
        Thu, 17 Oct 2019 18:48:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vpcm3dvth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:48:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HImPNw026029;
        Thu, 17 Oct 2019 18:48:25 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:48:25 +0000
Date:   Thu, 17 Oct 2019 11:48:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] iomap: lift the xfs writeback code to iomap
Message-ID: <20191017184824.GA13090@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017175624.30305-11-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170168
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:56:20PM +0200, Christoph Hellwig wrote:
> Take the xfs writeback code and move it to fs/iomap.  A new structure
> with three methods is added as the abstraction from the generic writeback
> code to the file system.  These methods are used to map blocks, submit an
> ioend, and cancel a page that encountered an error before it was added to
> an ioend.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

<snip>

> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 24bd227d59f9..71fd12ee5616 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/bitmap.h>
> +#include <linux/blk_types.h>
>  #include <linux/mm.h>
>  #include <linux/types.h>
>  #include <linux/mm_types.h>
> @@ -12,6 +13,7 @@
>  struct address_space;
>  struct fiemap_extent_info;
>  struct inode;
> +struct iomap_writepage_ctx;
>  struct iov_iter;
>  struct kiocb;
>  struct page;
> @@ -185,6 +187,63 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
>  sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  		const struct iomap_ops *ops);
>  
> +/*
> + * Structure for writeback I/O completions.
> + */
> +struct iomap_ioend {
> +	struct list_head	io_list;	/* next ioend in chain */
> +	u16			io_type;
> +	u16			io_flags;	/* IOMAP_F_* */
> +	struct inode		*io_inode;	/* file being written to */
> +	size_t			io_size;	/* size of the extent */
> +	loff_t			io_offset;	/* offset in the file */
> +	void			*io_private;	/* file system private data */
> +	struct bio		*io_bio;	/* bio being built */
> +	struct bio		io_inline_bio;	/* MUST BE LAST! */
> +};
> +
> +struct iomap_writeback_ops {
> +	/*
> +	 * Required, maps the blocks so that writeback can be performed on
> +	 * the range starting at offset.
> +	 */
> +	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +				loff_t offset);
> +
> +	/*
> +	 * Optional, allows the file systems to perform actions just before
> +	 * submitting the bio and/or override the bio end_io handler for complex
> +	 * operations like copy on write extent manipulation or unwritten extent
> +	 * conversions.
> +	 */
> +	int (*submit_ioend)(struct iomap_ioend *ioend, int status);
> +

Looks ok, but I reserve the right to rename this to ->prepare_ioend() or
something. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +	/*
> +	 * Optional, allows the file system to discard state on a page where
> +	 * we failed to submit any I/O.
> +	 */
> +	void (*discard_page)(struct page *page);
> +};
> +
> +struct iomap_writepage_ctx {
> +	struct iomap		iomap;
> +	struct iomap_ioend	*ioend;
> +	const struct iomap_writeback_ops *ops;
> +};
> +
> +void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
> +void iomap_ioend_try_merge(struct iomap_ioend *ioend,
> +		struct list_head *more_ioends,
> +		void (*merge_private)(struct iomap_ioend *ioend,
> +				struct iomap_ioend *next));
> +void iomap_sort_ioends(struct list_head *ioend_list);
> +int iomap_writepage(struct page *page, struct writeback_control *wbc,
> +		struct iomap_writepage_ctx *wpc,
> +		const struct iomap_writeback_ops *ops);
> +int iomap_writepages(struct address_space *mapping,
> +		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
> +		const struct iomap_writeback_ops *ops);
> +
>  /*
>   * Flags for direct I/O ->end_io:
>   */
> -- 
> 2.20.1
> 
