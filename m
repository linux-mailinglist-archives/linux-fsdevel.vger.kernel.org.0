Return-Path: <linux-fsdevel+bounces-51276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8480AD5184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07AF1893622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9ED261585;
	Wed, 11 Jun 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD0EZiaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A5233722;
	Wed, 11 Jun 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637386; cv=none; b=dwOKrNFeSDPuMfADJlxr+6q4ZNZDGbDkSdCffc3QLGUIgk7Jde7gXTTKdfdiY6wnE8L31VfF+pkEmaWfv9EbytQYkjfRns7GHG1c3k8Eb0r84jRzK92J9ONtUq5oslWjlOLgo3TbAyWl2YThv1Wuiu6kKIw0Cqic1lNF1giojtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637386; c=relaxed/simple;
	bh=6fVHvu/auEC2tD06DiG+ItwJ7PutMs/j2VBSG49t15s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc7sBIDAajFdqxEoDT6TYS5cHoGlX7CsU/N3AELMlD2bupNaNVBC4RUUewhRzMQwVQxDaA96LLYwFPrICCaSadHZLQbbPCIUgESddjD15FFKFuByWZ3ujUuwpIPdyc49YUZsGvIze0X5Ji+zzv3y6EA7zL2v3jgYptGdXWOI2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD0EZiaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9860DC4CEEE;
	Wed, 11 Jun 2025 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749637385;
	bh=6fVHvu/auEC2tD06DiG+ItwJ7PutMs/j2VBSG49t15s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sD0EZiafG7/e8giZbQd8qs2JQUrBjZ42Pvbijd0agZzEOG2+kn48A6cBTSlQMWLBM
	 IUTxbBJFwTnTeqhRTtMWae2nwyx+XWGPPV6tfsquoJh5aheMfbq3BYydVkoQBP7msT
	 TiXnY1OhewxV85ACi/+OC4wkjeHwWMuxqA2a4Nt6l4ZgDsNHj7VjiKml3JbuKSzI2l
	 nW9kyI4F1gR6wJuJqWO1hk39Z9j7bjmtVmtl3nZqZAuJWpwWRRMn3ZxjhpCBEOU0X3
	 d2rEK9bJI74m6ZAfNAjxacObFpupfcxIV0nSQqoLHZ7xyXyOdxlrCMMKnGsJR1Wt8L
	 zdLr5nSkrNh+Q==
Date: Wed, 11 Jun 2025 12:23:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, hch@infradead.org, 
	martin.petersen@oracle.com, ebiggers@kernel.org, adilger@dilger.ca, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v3 2/2] fs: add ioctl to query metadata and
 protection info capabilities
Message-ID: <20250611-saufen-wegfielen-487ca3c70ba6@brauner>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
 <CGME20250610132317epcas5p442ce20c039224fb691ab0ba03fcb21e7@epcas5p4.samsung.com>
 <20250610132254.6152-3-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610132254.6152-3-anuj20.g@samsung.com>

On Tue, Jun 10, 2025 at 06:52:54PM +0530, Anuj Gupta wrote:
> Add a new ioctl, FS_IOC_GETLBMD_CAP, to query metadata and protection
> info (PI) capabilities. This ioctl returns information about the files
> integrity profile. This is useful for userspace applications to
> understand a files end-to-end data protection support and configure the
> I/O accordingly.
> 
> For now this interface is only supported by block devices. However the
> design and placement of this ioctl in generic FS ioctl space allows us
> to extend it to work over files as well. This maybe useful when
> filesystems start supporting  PI-aware layouts.
> 
> A new structure struct logical_block_metadata_cap is introduced, which
> contains the following fields:
> 
> 1. lbmd_flags: bitmask of logical block metadata capability flags
> 2. lbmd_interval: the amount of data described by each unit of logical
> block metadata
> 3. lbmd_size: size in bytes of the logical block metadata associated
> with each interval
> 4. lbmd_opaque_size: size in bytes of the opaque block tag associated
> with each interval
> 5. lbmd_opaque_offset: offset in bytes of the opaque block tag within
> the logical block metadata
> 6. lbmd_pi_size: size in bytes of the T10 PI tuple associated with each
> interval
> 7. lbmd_pi_offset: offset in bytes of T10 PI tuple within the logical
> block metadata
> 8. lbmd_pi_guard_tag_type: T10 PI guard tag type
> 9. lbmd_pi_app_tag_size: size in bytes of the T10 PI application tag
> 10. lbmd_pi_ref_tag_size: size in bytes of the T10 PI reference tag
> 11. lbmd_pi_storage_tag_size: size in bytes of the T10 PI storage tag
> 12. lbmd_rsvd: reserved for future use
> 
> The internal logic to fetch the capability is encapsulated in a helper
> function blk_get_meta_cap(), which uses the blk_integrity profile
> associated with the device. The ioctl returns -EOPNOTSUPP, if
> CONFIG_BLK_DEV_INTEGRITY is not enabled.
> 
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/blk-integrity.c         | 53 +++++++++++++++++++++++++++++++++++
>  block/ioctl.c                 |  3 ++
>  include/linux/blk-integrity.h |  7 +++++
>  include/uapi/linux/fs.h       | 43 ++++++++++++++++++++++++++++
>  4 files changed, 106 insertions(+)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index e4e2567061f9..f9ad5bdb84f5 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -13,6 +13,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> +#include <linux/t10-pi.h>
>  
>  #include "blk.h"
>  
> @@ -54,6 +55,58 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
>  	return segments;
>  }
>  
> +int blk_get_meta_cap(struct block_device *bdev,
> +		     struct logical_block_metadata_cap __user *argp)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
> +	struct logical_block_metadata_cap meta_cap = {};
> +
> +	if (!bi)
> +		goto out;
> +
> +	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
> +		meta_cap.lbmd_flags |= LBMD_PI_CAP_INTEGRITY;
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG)
> +		meta_cap.lbmd_flags |= LBMD_PI_CAP_REFTAG;
> +	meta_cap.lbmd_interval = 1 << bi->interval_exp;
> +	meta_cap.lbmd_size = bi->tuple_size;
> +	if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE) {
> +		/* treat entire tuple as opaque block tag */
> +		meta_cap.lbmd_opaque_size = bi->tuple_size;
> +		goto out;
> +	}
> +	meta_cap.lbmd_pi_size = bi->pi_size;
> +	meta_cap.lbmd_pi_offset = bi->pi_offset;
> +	meta_cap.lbmd_opaque_size = bi->tuple_size - bi->pi_size;
> +	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
> +		meta_cap.lbmd_opaque_offset = bi->pi_size;
> +
> +	meta_cap.lbmd_guard_tag_type = bi->csum_type;
> +	meta_cap.lbmd_app_tag_size = 2;
> +
> +	if (bi->flags & BLK_INTEGRITY_REF_TAG) {
> +		switch (bi->csum_type) {
> +		case BLK_INTEGRITY_CSUM_CRC64:
> +			meta_cap.lbmd_ref_tag_size =
> +				sizeof_field(struct crc64_pi_tuple, ref_tag);
> +			break;
> +		case BLK_INTEGRITY_CSUM_CRC:
> +		case BLK_INTEGRITY_CSUM_IP:
> +			meta_cap.lbmd_ref_tag_size =
> +				sizeof_field(struct t10_pi_tuple, ref_tag);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +out:
> +	if (copy_to_user(argp, &meta_cap,
> +			 sizeof(struct logical_block_metadata_cap)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  /**
>   * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
>   * @rq:		request to map
> diff --git a/block/ioctl.c b/block/ioctl.c
> index e472cc1030c6..19782f7b5ff1 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -13,6 +13,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/pagemap.h>
>  #include <linux/io_uring/cmd.h>
> +#include <linux/blk-integrity.h>
>  #include <uapi/linux/blkdev.h>
>  #include "blk.h"
>  #include "blk-crypto-internal.h"
> @@ -643,6 +644,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return blkdev_pr_preempt(bdev, mode, argp, true);
>  	case IOC_PR_CLEAR:
>  		return blkdev_pr_clear(bdev, mode, argp);
> +	case FS_IOC_GETLBMD_CAP:
> +		return blk_get_meta_cap(bdev, argp);
>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> index c7eae0bfb013..b4aff4dff843 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -29,6 +29,8 @@ int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
>  int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
>  int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
>  			      ssize_t bytes);
> +int blk_get_meta_cap(struct block_device *bdev,
> +		     struct logical_block_metadata_cap __user *argp);
>  
>  static inline bool
>  blk_integrity_queue_supports_integrity(struct request_queue *q)
> @@ -92,6 +94,11 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  				 rq->bio->bi_integrity->bip_iter);
>  }
>  #else /* CONFIG_BLK_DEV_INTEGRITY */
> +static inline int blk_get_meta_cap(struct block_device *bdev,
> +				   struct logical_block_metadata_cap __user *argp)
> +{
> +	return -EOPNOTSUPP;
> +}
>  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
>  					    struct bio *b)
>  {
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0098b0ce8ccb..70350d5a4cd6 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -91,6 +91,47 @@ struct fs_sysfs_path {
>  	__u8			name[128];
>  };
>  
> +/* Protection info capability flags */
> +#define	LBMD_PI_CAP_INTEGRITY		(1 << 0)
> +#define	LBMD_PI_CAP_REFTAG		(1 << 1)
> +
> +/* Checksum types for Protection Information */
> +#define LBMD_PI_CSUM_NONE		0
> +#define LBMD_PI_CSUM_IP			1
> +#define LBMD_PI_CSUM_CRC16_T10DIF	2
> +#define LBMD_PI_CSUM_CRC64_NVME		4
> +
> +/*
> + * struct logical_block_metadata_cap - Logical block metadata
> + * @lbmd_flags:			Bitmask of logical block metadata capability flags
> + * @lbmd_interval:		The amount of data described by each unit of logical block metadata
> + * @lbmd_size:			Size in bytes of the logical block metadata associated with each interval
> + * @lbmd_opaque_size:		Size in bytes of the opaque block tag associated with each interval
> + * @lbmd_opaque_offset:		Offset in bytes of the opaque block tag within the logical block metadata
> + * @lbmd_pi_size:		Size in bytes of the T10 PI tuple associated with each interval
> + * @lbmd_pi_offset:		Offset in bytes of T10 PI tuple within the logical block metadata
> + * @lbmd_pi_guard_tag_type:	T10 PI guard tag type
> + * @lbmd_pi_app_tag_size:	Size in bytes of the T10 PI application tag
> + * @lbmd_pi_ref_tag_size:	Size in bytes of the T10 PI reference tag
> + * @lbmd_pi_storage_tag_size:	Size in bytes of the T10 PI storage tag
> + * @lbmd_rsvd:			Reserved for future use
> + */
> +
> +struct logical_block_metadata_cap {
> +	__u32	lbmd_flags;
> +	__u16	lbmd_interval;
> +	__u8	lbmd_size;
> +	__u8	lbmd_opaque_size;
> +	__u8	lbmd_opaque_offset;
> +	__u8	lbmd_pi_size;
> +	__u8	lbmd_pi_offset;
> +	__u8	lbmd_guard_tag_type;
> +	__u8	lbmd_app_tag_size;
> +	__u8	lbmd_ref_tag_size;
> +	__u8	lbmd_storage_tag_size;
> +	__u8	lbmd_rsvd[17];

Don't do this hard-coded form of extensiblity. ioctl()s are inherently
extensible because they encode the size. Instead of switching on the
full ioctl, switch on the ioctl number. See for example fs/pidfs:

        /* Extensible IOCTL. */
        if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
                return pidfd_info(file, cmd, arg);

static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
{
	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
<snip>
	size_t usize = _IOC_SIZE(cmd);
	struct pidfd_info kinfo = {};

	if (!uinfo)
		return -EINVAL;
	if (usize < PIDFD_INFO_SIZE_VER0)
		return -EINVAL; /* First version, no smaller struct possible */

pidfs uses a mask field to allow request-response modification:

	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
		return -EFAULT;

Fill in kinfo struct with the info you know about or that userspace
requested:

	kinfo.ppid = task_ppid_nr_ns(task, NULL);
	kinfo.tgid = task_tgid_vnr(task);
	kinfo.pid = task_pid_vnr(task);
	kinfo.mask |= PIDFD_INFO_PID;

Then copy the portion out that userspace knows about. We have a
dedicated helper for that:

	/*
	 * If userspace and the kernel have the same struct size it can just
	 * be copied. If userspace provides an older struct, only the bits that
	 * userspace knows about will be copied. If userspace provides a new
	 * struct, only the bits that the kernel knows about will be copied.
	 */
	return copy_struct_to_user(uinfo, usize, &kinfo, sizeof(kinfo), NULL);
}

(Only requirement is that a zero value means "no info", i.e., can't be a
valid value. If you want zero to be a valid value then a mask member
might be helpful where the info that was available is raised.)

This whole approach is well-tested and works. You can grow the struct as
needed. If userspace doesn't care about any additional info even if the
struct grows it can just always request the minimal info and nothing
extra will ever be copied.

> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -247,6 +288,8 @@ struct fsxattr {
>   * also /sys/kernel/debug/ for filesystems with debugfs exports
>   */
>  #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
> +/* Get logical block metadata capability details */
> +#define FS_IOC_GETLBMD_CAP		_IOR(0x15, 2, struct logical_block_metadata_cap)
>  
>  /*
>   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)

