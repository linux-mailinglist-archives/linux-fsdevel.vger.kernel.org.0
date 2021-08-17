Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8A3EEBAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHQL35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:29:57 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23579 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbhHQL3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:29:52 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210817112918epoutp046ad405f0ebb050eb04718fd60cbdf818~cFIxOhZCZ1039810398epoutp04t
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 11:29:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210817112918epoutp046ad405f0ebb050eb04718fd60cbdf818~cFIxOhZCZ1039810398epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629199758;
        bh=8k4v8Wc22T8Nl4fGkl2T3OtUvUqtjnmyhgGSjr7Uuqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXALpCP40dUOXWiE9lkcxp2jMrUYb0j8TfVy6eK0ti6NKD7ST/PWccaB7mOrH4Aev
         fYwj5EVop2J2XX8L0gHkV1d+MVYkaoruIwNb6VZQ6OIz6I9pdGNk2wong9H0f+NIh1
         NvxoUEwHQcc9CwJVwaD2E9GEW8kTzLSuwE80IRdo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210817112917epcas5p17eb00a14b2416924d18537aae51021fe~cFIwQ4GbS0075100751epcas5p1V;
        Tue, 17 Aug 2021 11:29:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GpphP5ngcz4x9Pt; Tue, 17 Aug
        2021 11:29:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.AD.41701.58D9B116; Tue, 17 Aug 2021 20:29:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b~cEKkbCg8f0725807258epcas5p1E;
        Tue, 17 Aug 2021 10:18:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210817101803epsmtrp21b0f42eda6731a61723b78dc17c2ae6c~cEKkZtkPw2821228212epsmtrp2R;
        Tue, 17 Aug 2021 10:18:03 +0000 (GMT)
X-AuditID: b6c32a4b-0c1ff7000001a2e5-09-611b9d85ad8f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.19.32548.BDC8B116; Tue, 17 Aug 2021 19:18:03 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210817101759epsmtip29d696043a21492e64b762aeb5d3a4451~cEKgr5htn3169331693epsmtip2i;
        Tue, 17 Aug 2021 10:17:59 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH 4/7] block: Introduce a new ioctl for simple copy
Date:   Tue, 17 Aug 2021 15:44:20 +0530
Message-Id: <20210817101423.12367-5-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817101423.12367-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO/cuu4sK3gDhuGBuO6IB8VhYlkMjoAPT3AGmoXFyDBzpCjdg
        YB/uI6ImoxzUhdpEBRMfKGrlLiEtD9flEfIStihey2vUrGDHRAHZVDZAW7hY/vc5v/P9nu/8
        fmd+XNztGIfHzZKqaIWUyhGwV7Hq2/y2BBac8aZCFtpfR1fMnTg6rasHSH/rKzYqnbHjqODQ
        YwwNjLuipqlTTuiyvgNDf960cdBi4W0MdTx7wEa/PmjD0NHWIYAaDcdZqObJYTZqGgtAjU3d
        LFT+zQQHFQ0b2ejbG08xVHzYgiHj+GcA1c+X42jweAWO7kwPc9DkXDcbHfzhEUDzc6fZ23zI
        gcEE8lrZLQ5Z850/OdCjJg06DZusufgp2TCazyYfToyxyOlmC5vU1uoAaTO8Qh5qKcKS1iRn
        b82kqXRawaelabL0LGlGlCBhR2psarg4RBgojEQRAr6UktBRgrjEpMA3s3IcwxDwP6By1I5S
        EqVUCoKjtypkahXNz5QpVVECWp6eIxfJg5SURKmWZgRJadUbwpCQ0HCH8L3sTNuUiSPv8Pnw
        7plqp3xQ7FUInLmQEMHK6xbOErsRDQBWmCSFYJWDZwGc7KljMQcbgFMXHmLPHfnWpxzmwgSg
        ZrEIMHaHqndw/xKziUA4dNHAWmIPIgZetuuclgw4YWbBE9MVy3nuxHb4+8IwvsQswhdebSlY
        TnAhouCF9p8Bk7YRnux/4tBzuc5ENDTN+jKSl2H3yfHl93GH5EDdKZyR651h82gew3HwftVB
        FsPu8N6NWg7DPGibamIznAutmtKVxvIB1E7nMhwD+xoXsaVYnPCDV0zBTHkDLDFXYUysK/xy
        fnzF6gKNZ8eX5ZDYDM1XxUzZB860mVaSSDjS0o8zYysGcHD2C+wI4Je90E3ZC92U/Z98DuA6
        sJ6WKyUZtDJcHialc//74jSZxACWt8M/wQj+uDMT1AowLmgFkIsLPFy2cHmUm0s6lfcRrZCl
        KtQ5tLIVhDumXYzz1qXJHOslVaUKRZEhIrFYLIoMEwsFXi67E70pNyKDUtHZNC2nFc99GNeZ
        l481GakMPq/sbLyXa1sVzzfDMz5lz8i+ZHrPP276r0tDU1bXqC32Ttv5dzbsOvKbltpxLu7R
        q31rxtJ3H622l+xUUx/fuy28Vnle27PToEm2b/cLnay5L+o8ILZtI3y6PAMiYsP+TvNXlpd4
        yzb5di3UJZaG9tb2D82IgtcWpLzU9Ut9Xexe97clDTr32nU/ip07qJH3975F/iT6vCq7MTUw
        D67v9oyJTzjht+lxdIFGUhit6ewdiN8VtnHf/k7tXau1SJQZ0Kf9C7ZsG5gyV+jnI4hI62vv
        BrpYJi9ZNhvXzo16CFzbrPrvmy/d/GR1EXZdntZ5jENWTdgtlc/a+Qnm9moBS5lJCf1xhZL6
        F1yxgWOmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfyyUcRzH932ep+eeu3KeLuYJy7qxdBdhqW+/LP+0p+nX+itaXVeesNyx
        O6e0rGtFRz+Jyo/KHOGMdMLFifyonZC4Y5WzcMoyxFWYH+Worf/e+7xe773/+BAorw1zJiKk
        MYxMKo7k4xysspHv5vXphovYx9DKh09bXqMwW1MJYLH5Ng7vfZ9BYcK1XwjssnBh7VjWClhU
        3IzAwV4rC84n9yGw+fcoDt+NNiIwtaEbQL02DYPlUyoc1n4UQn2tAYOPnwyx4PUeHQ4L3iwg
        MEVlQqDOchnAytnHKDSm5aLw83gPC45MG3CY+OwngLPT2fgeV7rLGES/yDSz6PJCAd3VpqC1
        miScLs+7RNd8UOL0xNBHjB5/acLpW881gLZq19HX6q8jh1eFcHaFMpERsYxsc8BJTrh1rJoV
        3ex6fvhh2QolSHFKBmyCIrdQyi8LrGTAIXikDlCTuVNgGbhSJeYkfDmvoYoWvv6VJgD142U6
        YgM46UV152kxW3YgA6m3k5WITULJbxjVZ65BbWDNIuif61nKGOlBVdUnLJXtyN2Uuqn175ob
        ldE5tbhAEGwygKqe9LCdeYtKnT6dtayvpgwZlqUtdFG/UpGF3gFk5n8o8z+UAxANWMtEyyVh
        ErlvtJ+UOectF0vkCmmY9+koiRYsfVwg0AG95rt3A0AI0AAoAuU72G0gnMU8u1Bx3AVGFiWS
        KSIZeQNwITC+k11HskHEI8PEMcxZholmZP8oQrCdlUhpun9xwaib28X5uqMOG/26MwNFE575
        MSp7i3GAc27I4dinXZbJ9e5hg68KB3rt4+mSVH2OsJRfeFPUJG1U55g2HRreGhxy4lRTZ1nv
        Nv8MlSKg6nPsfqFz7MrQB62qkCLli5mgyPA0/nvTprl8r+BuoT7uZ6Dr9v7dNzz3cZEfs6H3
        z2QNbE1lP5TknRG8iZi3+qUlBhvDSbL9+E5RQszdqiOJpS4+/lfbd16agf7WHT31e4bi+6QF
        2mBh4oGkEOtmNbd6YEFXpx7X1HuPO6kddfa93O26oL7L1R3smvuPUlrHcke4a81Zporpg3vj
        vFrm1F8Ud9son7NRjsaCQXc+Jg8X+wpQmVz8B1BWO4dgAwAA
X-CMS-MailID: 20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
        <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
to a destination in the device. COPY ioctl accepts a 'copy_range'
structure that contains destination (in sectors), no of sources and
pointer to the array of source ranges. Each source range is represented by
'range_entry' that contains start and length of source ranges (in sectors)

MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.

Example code, to issue BLKCOPY:
/* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
 * [64,24], on the same device */

int main(void)
{
	int ret, fd;
	struct range_entry source_range[] = {{.src = 0, .len = 8},
		{.src = 16, .len = 8}, {.src = 32, .len = 8},};
	struct copy_range cr;

	cr.dest = 64;
	cr.nr_range = 3;
	cr.range_list = (__u64)&source_range;

	fd = open("/dev/nvme0n1", O_RDWR);
	if (fd < 0) return 1;

	ret = ioctl(fd, BLKCOPY, &cr);
	if (ret < 0) printf("copy failure\n");

	close(fd);

	return ret;
}

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  8 ++++++++
 2 files changed, 41 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index eb0491e90b9a..2af56d01e9fe 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 				    GFP_KERNEL, flags);
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	struct copy_range crange;
+	struct range_entry *rlist;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
+			GFP_KERNEL);
+	if (!rlist)
+		return -ENOMEM;
+
+	if (copy_from_user(rlist, (void __user *)crange.range_list,
+				sizeof(*rlist) * crange.nr_range)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.dest,
+			GFP_KERNEL, 0);
+out:
+	kfree(rlist);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -468,6 +499,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKSECDISCARD:
 		return blk_ioctl_discard(bdev, mode, arg,
 				BLKDEV_DISCARD_SECURE);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 7a97b588d892..4183688ff398 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -76,6 +76,13 @@ struct range_entry {
 	__u64 len;
 };
 
+struct copy_range {
+	__u64 dest;
+	__u64 nr_range;
+	__u64 range_list;
+	__u64 rsvd;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -197,6 +204,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.25.1

