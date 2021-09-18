Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0434107A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhIRQ5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 12:57:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237222AbhIRQ5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:57:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18IAxX8S023528;
        Sat, 18 Sep 2021 12:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9Vo+kxDbch8OaKN7UeClQK8G9XljrlxDk4V82CwxGB0=;
 b=XNiHLn3qJ/PzFBkw94jEB3JANv5Z70ZyvJZglAaqIDg6olnubUloKkba8ZIrxeY704uE
 PHeKCEL8XKe9g+SY3pfAgVi6o6QKkvCaIe+p0OiQ30h2VpboZ/UaVfEQ+SHU25Yqz2oJ
 562RabxBmzkHENpWNNfULTpLRKIzF/FacYhFcfKZYefzy+TVHEx6FUa8oBEPysiSGz/z
 nM5XpPsE5wmeoTER6GShpdzoKVTSxA93RlVZ4TPR4gi9q2wk/0TRY59jyaLHSZrvxdVS
 +bOLQCx8ueMN1XA9uVORQ96DcJvNNN4uwadU1C0GyXqbPQih2qhOFGB82cLS5f63uJ5T AA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b5eumuwpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 12:55:41 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18IGrYUV021727;
        Sat, 18 Sep 2021 16:55:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3b57r8k6s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Sep 2021 16:55:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18IGtaue30540242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 16:55:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8100842047;
        Sat, 18 Sep 2021 16:55:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDCA942042;
        Sat, 18 Sep 2021 16:55:35 +0000 (GMT)
Received: from localhost (unknown [9.43.63.221])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 18 Sep 2021 16:55:35 +0000 (GMT)
Date:   Sat, 18 Sep 2021 22:25:34 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     jane.chu@oracle.com, linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: use accelerated zeroing on a block device to
 zero a file range
Message-ID: <20210918165534.zigbg5aeal4m4zw4@riteshh-domain>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
 <163192865577.417973.11122330974455662098.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192865577.417973.11122330974455662098.stgit@magnolia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L6w7uREipWur-IsE1wGH5IJFAap4kKFU
X-Proofpoint-ORIG-GUID: L6w7uREipWur-IsE1wGH5IJFAap4kKFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-18_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109180117
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/17 06:30PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
>
> Create a function that ensures that the storage backing part of a file
> contains zeroes and will not trip over old media errors if the contents
> are re-read.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/direct-io.c  |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |    3 ++
>  2 files changed, 78 insertions(+)
>
>
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 4ecd255e0511..48826a49f976 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -652,3 +652,78 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> +static loff_t
> +iomap_zeroinit_iter(struct iomap_iter *iter)
> +{
> +	struct iomap *iomap = &iter->iomap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	const u64 start = iomap->addr + iter->pos - iomap->offset;
> +	const u64 nr_bytes = iomap_length(iter);
> +	sector_t sector = start >> SECTOR_SHIFT;
> +	sector_t nr_sectors = nr_bytes >> SECTOR_SHIFT;
> +	int ret;
> +
> +	if (!iomap->bdev)
> +		return -ECANCELED;
> +
> +	/* The physical extent must be sector-aligned for block layer APIs. */
> +	if ((start | nr_bytes) & (SECTOR_SIZE - 1))
> +		return -EINVAL;
> +
> +	/* Must be able to zero storage directly without fs intervention. */
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		return -ECANCELED;
> +	if (srcmap != iomap)
> +		return -ECANCELED;
> +
> +	switch (iomap->type) {
> +	case IOMAP_MAPPED:
> +		ret = blkdev_issue_zeroout(iomap->bdev, sector, nr_sectors,
> +				GFP_KERNEL, 0);
> +		if (ret)
> +			return ret;
> +		fallthrough;
> +	case IOMAP_UNWRITTEN:
> +		return nr_bytes;
> +	}
> +
> +	/* Reject holes, inline data, or delalloc extents. */
> +	return -ECANCELED;

Same comment here as in patch-1 which implements dax_zeroinit_iter().

-ritesh

> +}
> +
> +/*
> + * Use a storage device's accelerated zero-writing command to ensure the media
> + * are ready to accept read and write commands.  FSDAX is not supported.
> + *
> + * The range arguments must be aligned to sector size.  The file must be backed
> + * by a block device.  The extents returned must not require copy on write (or
> + * any other mapping interventions from the filesystem) and must be contiguous.
> + * @done will be set to true if the reset succeeded.
> + *
> + * Returns 0 if the zero initialization succeeded, -ECANCELED if the storage
> + * mappings do not support zero initialization, -EOPNOTSUPP if the device does
> + * not support it, or the usual negative errno.
> + */
> +int
> +iomap_zeroout_range(struct inode *inode, loff_t pos, u64 len,
> +		   const struct iomap_ops *ops)
> +{
> +	struct iomap_iter iter = {
> +		.inode		= inode,
> +		.pos		= pos,
> +		.len		= len,
> +		.flags		= IOMAP_REPORT,
> +	};
> +	int ret;
> +
> +	if (IS_DAX(inode))
> +		return -EINVAL;
> +	if (pos + len > i_size_read(inode))
> +		return -EINVAL;
> +
> +	while ((ret = iomap_iter(&iter, ops)) > 0)
> +		iter.processed = iomap_zeroinit_iter(&iter);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iomap_zeroout_range);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 24f8489583ca..f4b9c6698388 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -339,6 +339,9 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
>  int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
>
> +int iomap_zeroout_range(struct inode *inode, loff_t pos, u64 len,
> +		const struct iomap_ops *ops);
> +
>  #ifdef CONFIG_SWAP
>  struct file;
>  struct swap_info_struct;
>
