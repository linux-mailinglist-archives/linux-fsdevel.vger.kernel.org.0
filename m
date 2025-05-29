Return-Path: <linux-fsdevel+bounces-50044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E638BAC7A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C0A4E1345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 08:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9667F21ABAD;
	Thu, 29 May 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="boA9yeXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A6215F7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748508100; cv=none; b=T+HhYpDIwcnJDD5d4KtB0as25/3InBLyIw+If5A1+bip5zNFsEcSyvi29DI17PiTOmBpwo1ybXRi1bb8CRQ/XvjBaZFNnQfi5DjArvj8MaU+8TqsDYZ2xbF8kS65RRg6tH1tLtpEYE4YIEbnqpOeAyqL58CCKpxQTdC20lxrNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748508100; c=relaxed/simple;
	bh=lIWFPMocihGd4xhavo4DX7fFG6dIIspm4AR2T5QA6hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Gc6bF83Tr6H60fimJpwAlnpLMC+zShag9sZm5X6tNXIrUYSIsB9+7tB4hNyKYpdfSq0iAQPWUGAoasXJ0to2YTV6yzADYlLINKW0Ci3fypw09dDvOv3ghzIS4RSGeWuRU1NPajgfnFxiYA8a1vDHzKyNnipo47b//oQFtL6wV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=boA9yeXG; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250529084128epoutp0142a791288ed8339d1bd9b80f19fffa1d~D8tezhR-F3068530685epoutp01Y
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 08:41:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250529084128epoutp0142a791288ed8339d1bd9b80f19fffa1d~D8tezhR-F3068530685epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748508088;
	bh=AK7oIhVkRfsGvDosJq7DDO93hVCWuF6KoUrlr9zRMws=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=boA9yeXGKcQyAvxDTqkVl+x9n6QkmAcbYneXCDz87EVjUj2CRHJwgIMnoSqoOiqI4
	 LPSvyWMeJymW1WXgIKOTxXCH4OGDceY3oD8iqfkI9Di/tIUzUroV7JppQDzo8foQlo
	 sGGAtqxle3O1rq6gknxNkutLKjhDs8hWzPMmv9z4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529084127epcas5p4968340e02f42b25f9913037ee8c1e80b~D8teJwfJC2081020810epcas5p4w;
	Thu, 29 May 2025 08:41:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.180]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7KbV3xbrz3hhT4; Thu, 29 May
	2025 08:41:26 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529071247epcas5p13155bcbe2cfa0e986d6f64dcb097375a~D7gDaBgw41496214962epcas5p1u;
	Thu, 29 May 2025 07:12:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529071247epsmtrp18925543e73783fb175b2bf96e69ca046~D7gDZMT3F2890028900epsmtrp1S;
	Thu, 29 May 2025 07:12:47 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-25-683808ef5deb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.99.07818.FE808386; Thu, 29 May 2025 16:12:47 +0900 (KST)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529071245epsmtip172d6ab4fbeba25a0c4451e4b679781fd~D7gBwKHsu3164431644epsmtip16;
	Thu, 29 May 2025 07:12:45 +0000 (GMT)
Message-ID: <fec86763-dd0e-4099-9347-e85aa4a22277@samsung.com>
Date: Thu, 29 May 2025 12:42:45 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fs: add ioctl to query protection info capabilities
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: jack@suse.cz, anuj1072538@gmail.com, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSnO57DosMgwcX1S0+fv3NYrH6bj+b
	xevDnxgtTk9YxGQxe3ozk8XR/2/ZLPbe0rbYs/cki8Xy4/+YLM7/Pc7qwOWxc9Zddo/NK7Q8
	Lp8t9di0qpPN4+PTWywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRnHZpKTmZJalFunbJXBlLOv7
	xl7wzaeie3o/awPjGdsuRk4OCQETiQ8Xl7GD2EICuxklzmwwhohLSJx6uYwRwhaWWPnvOVAN
	F1DNW0aJh4/bmEASvAJ2EvcufmQGsVkEVCUaFn5ng4gLSpyc+YQFxBYVkJe4f2sG2AJhATeJ
	/70NYL0iAqYSkz9tZQMZyixwnlFi8coJzBAbtjJKzJizGqybWUBc4taT+WAdbAJGEnceHAEq
	4uDgFDCWuHpJHKLETKJraxcjhC0vsf3tHOYJjEKzkNwxC8mkWUhaZiFpWcDIsopRMrWgODc9
	N9mwwDAvtVyvODG3uDQvXS85P3cTIzjutDR2ML771qR/iJGJg/EQowQHs5IIb5O9WYYQb0pi
	ZVVqUX58UWlOavEhRmkOFiVx3pWGEelCAumJJanZqakFqUUwWSYOTqkGJt/7cfKCD6IYQ/RE
	VJtDauYkb/7q+HZCWUEe93eRzn8z1preM1l/JfvZhHOZR4y0eIPjH5Wn/FOXuFca/VKPVfxG
	2oM645Nui/qnLz5U8fHRquoEccl2n4fcbbbKE9is9jQx6mrVdESct/22jsNez8SwKqwg9Vn5
	gw1nFI0LAjJeCGRfnCZuevWMYLeG6j+PyUkOH062bFc7WvmSK/Dt/wkqH5/P+SB/9wqzXh53
	XZjMcqmI4z+/Fes/Db83686+9PfLxBPete3MljPak/Es5oP/z62ibXNPpi+JZuR9MKutiE2n
	bfasx05poS9D3t5gO5Lsv8SnN9O2cf39pbeELuaHrVr5iPuDzqq2gthzSizFGYmGWsxFxYkA
	TSs9hSoDAAA=
X-CMS-MailID: 20250529071247epcas5p13155bcbe2cfa0e986d6f64dcb097375a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263
References: <CGME20250527105950epcas5p1b53753ab614bf6bde4ffbf5165c7d263@epcas5p1.samsung.com>
	<20250527104237.2928-1-anuj20.g@samsung.com>
	<yq1jz60gmyv.fsf@ca-mkp.ca.oracle.com>

On 5/29/2025 8:32 AM, Martin K. Petersen wrote:
> 
> Hi Anuj!
> 
> Thanks for working on this!
> 
Hi Martin,
Thanks for the feedback!

>> 4. tuple_size: size (in bytes) of the protection information tuple.
>> 6. pi_offset: offset of protection info within the tuple.
> 
> I find this a little confusing. The T10 PI tuple is <guard, app, ref>.
> 
> I acknowledge things currently are a bit muddy in the block layer since
> tuple_size has been transmogrified to hold the NVMe metadata size.
> 
> But for a new user-visible interface I think we should make the
> terminology clear. The tuple is the PI and not the rest of the metadata.
> 
> So I think you'd want:
> 
> 4. metadata_size: size (in bytes) of the metadata associated with each interval.
> 6. pi_offset: offset of protection information tuple within the metadata.
> 

Yes, this representation looks better. Will make this change.

>> +#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
>> +#define	FILE_PI_CAP_REFTAG		(1 << 1)
> 
> You'll also need to have corresponding uapi defines for:
> 
> enum blk_integrity_checksum {
>          BLK_INTEGRITY_CSUM_NONE         = 0,
>          BLK_INTEGRITY_CSUM_IP           = 1,
>          BLK_INTEGRITY_CSUM_CRC          = 2,
>          BLK_INTEGRITY_CSUM_CRC64        = 3,
> } __packed ;
>

Right, I'll add these definitions to the UAPI.
>> +
>> +/*
>> + * struct fs_pi_cap - protection information(PI) capability descriptor
>> + * @flags:			Bitmask of capability flags
>> + * @interval:		Number of bytes of data per PI tuple
>> + * @csum_type:		Checksum type
>> + * @tuple_size:		Size in bytes of the PI tuple
>> + * @tag_size:		Size of the tag area within the tuple
>> + * @pi_offset:		Offset in bytes of the PI metadata within the tuple
>> + * @rsvd:			Reserved for future use
> 
> See above for distinction between metadata and PI tuple. The question is
> whether we need to report the size of those two separately (both in
> kernel and in this structure). Otherwise how do we know how big the PI
> tuple is? Or do we infer that from the csum_type?
> 

The block layer currently infers this by looking at the csum_type (e.g.,
in blk_integrity_generate). I assumed userspace could do the same, so I
didn't expose a separate pi_tuple_size field. Do you see this
differently?

As you mentioned, the other option would be to report the PI tuple size
explicitly in both the kernel and in the uapi struct.

> Also, for the extended NVMe PI types we'd probably need to know the size
> of the ref tag and the storage tag.
>

Makes sense, I will introduce ref_tag_size and storage_tag_size in the
UAPI struct to account for this.
I did a respin based on your feedback here [1]. If this looks good to
you, I'll roll out a v2.

Thanks,
Anuj Gupta

[1]

[PATCH] fs: add ioctl to query protection info capabilities

Add a new ioctl, FS_IOC_GETPICAP, to query protection info (PI)
capabilities. This ioctl returns information about the files integrity
profile. This is useful for userspace applications to understand a files
end-to-end data protection support and configure the I/O accordingly.

For now this interface is only supported by block devices. However the
design and placement of this ioctl in generic FS ioctl space allows us
to extend it to work over files as well. This maybe useful when
filesystems start supporting  PI-aware layouts.

A new structure struct fs_pi_cap is introduced, which contains the
following fields:
1. flags: bitmask of capability flags.
2. interval: the data block interval (in bytes) for which the protection
information is generated.
3. csum type: type of checksum used.
4. metadata_size: size (in bytes) of the metadata associated with each
interval.
5. tag_size: size (in bytes) of tag information.
6. pi_offset: offset of protection information tuple within the
metadata.
7. ref_tag_size: size in bytes of the reference tag.
8. storage_tag_size: size in bytes of the storage tag.
9. rsvd: reserved for future use.

The internal logic to fetch the capability is encapsulated in a helper
function blk_get_pi_cap(), which uses the blk_integrity profile
associated with the device. The ioctl returns -EOPNOTSUPP, if
CONFIG_BLK_DEV_INTEGRITY is not enabled.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
  block/blk-integrity.c         | 38 +++++++++++++++++++++++++++++++++++
  block/ioctl.c                 |  3 +++
  include/linux/blk-integrity.h |  6 ++++++
  include/uapi/linux/fs.h       | 36 +++++++++++++++++++++++++++++++++
  4 files changed, 83 insertions(+)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index a1678f0a9f81..9bd2888a85ce 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -13,6 +13,7 @@
  #include <linux/scatterlist.h>
  #include <linux/export.h>
  #include <linux/slab.h>
+#include <linux/t10-pi.h>

  #include "blk.h"

@@ -54,6 +55,43 @@ int blk_rq_count_integrity_sg(struct request_queue 
*q, struct bio *bio)
  	return segments;
  }

+int blk_get_pi_cap(struct block_device *bdev, struct fs_pi_cap __user 
*argp)
+{
+	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+	struct fs_pi_cap pi_cap = {};
+
+	if (!bi)
+		goto out;
+
+	if (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)
+		pi_cap.flags |= FILE_PI_CAP_INTEGRITY;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		pi_cap.flags |= FILE_PI_CAP_REFTAG;
+	pi_cap.csum_type = bi->csum_type;
+	pi_cap.tuple_size = bi->tuple_size;
+	pi_cap.tag_size = bi->tag_size;
+	pi_cap.interval = 1 << bi->interval_exp;
+	pi_cap.pi_offset = bi->pi_offset;
+	switch (bi->csum_type) {
+		case BLK_INTEGRITY_CSUM_CRC64:
+			pi_cap.ref_tag_size = sizeof_field(struct crc64_pi_tuple
+							   , ref_tag);
+			break;
+		case BLK_INTEGRITY_CSUM_CRC:
+		case BLK_INTEGRITY_CSUM_IP:
+			pi_cap.ref_tag_size = sizeof_field(struct t10_pi_tuple,
+							   ref_tag);
+			break;
+		default:
+			break;
+	}
+
+out:
+	if (copy_to_user(argp, &pi_cap, sizeof(struct fs_pi_cap)))
+		return -EFAULT;
+	return 0;
+}
+
  /**
   * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
   * @rq:		request to map
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c6..53b35bf3e6fa 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -13,6 +13,7 @@
  #include <linux/uaccess.h>
  #include <linux/pagemap.h>
  #include <linux/io_uring/cmd.h>
+#include <linux/blk-integrity.h>
  #include <uapi/linux/blkdev.h>
  #include "blk.h"
  #include "blk-crypto-internal.h"
@@ -643,6 +644,8 @@ static int blkdev_common_ioctl(struct block_device 
*bdev, blk_mode_t mode,
  		return blkdev_pr_preempt(bdev, mode, argp, true);
  	case IOC_PR_CLEAR:
  		return blkdev_pr_clear(bdev, mode, argp);
+	case FS_IOC_GETPICAP:
+		return blk_get_pi_cap(bdev, argp);
  	default:
  		return -ENOIOCTLCMD;
  	}
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c7eae0bfb013..6118a0c28605 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -29,6 +29,7 @@ int blk_rq_map_integrity_sg(struct request *, struct 
scatterlist *);
  int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
  int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
  			      ssize_t bytes);
+int blk_get_pi_cap(struct block_device *bdev, struct fs_pi_cap __user 
*argp);

  static inline bool
  blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -92,6 +93,11 @@ static inline struct bio_vec rq_integrity_vec(struct 
request *rq)
  				 rq->bio->bi_integrity->bip_iter);
  }
  #else /* CONFIG_BLK_DEV_INTEGRITY */
+static inline int blk_get_pi_cap(struct block_device *bdev,
+				 struct fs_pi_cap __user *argp)
+{
+	return -EOPNOTSUPP;
+}
  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
  					    struct bio *b)
  {
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index e762e1af650c..c70584b09bed 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -91,6 +91,40 @@ struct fs_sysfs_path {
  	__u8			name[128];
  };

+/* Protection info capability flags */
+#define	FILE_PI_CAP_INTEGRITY		(1 << 0)
+#define	FILE_PI_CAP_REFTAG		(1 << 1)
+
+/* Checksum types for Protection Information */
+#define FS_PI_CSUM_NONE			0
+#define FS_PI_CSUM_IP			1
+#define FS_PI_CSUM_CRC			2
+#define FS_PI_CSUM_CRC64		3
+
+/*
+ * struct fs_pi_cap - protection information(PI) capability descriptor
+ * @flags:			Bitmask of capability flags
+ * @interval:			Number of bytes of data per PI tuple
+ * @csum_type:			Checksum type
+ * @metadata_size:		Size in bytes of the metadata associated with each 
interval
+ * @tag_size:			Size of the tag area within the tuple
+ * @pi_offset:			Offset of protection information tuple within the metadata
+ * @ref_tag_size:		Size in bytes of the reference tag
+ * @storage_tag_size:		Size in bytes of the storage tag
+ * @rsvd:			Reserved for future use
+ */
+struct fs_pi_cap {
+	__u32	flags;
+	__u16	interval;
+	__u8	csum_type;
+	__u8	tuple_size;
+	__u8	tag_size;
+	__u8	pi_offset;
+	__u8	ref_tag_size;
+	__u8	storage_tag_size;
+	__u8	rsvd[4];
+};
+
  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl 
definitions */
  #define FILE_DEDUPE_RANGE_SAME		0
  #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -247,6 +281,8 @@ struct fsxattr {
   * also /sys/kernel/debug/ for filesystems with debugfs exports
   */
  #define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+/* Get protection info capability details */
+#define FS_IOC_GETPICAP			_IOR('f', 3, struct fs_pi_cap)

  /*
   * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
-- 
2.25.1

