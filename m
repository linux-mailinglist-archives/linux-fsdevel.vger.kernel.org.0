Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9FF667359
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjALNiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjALNhW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:37:22 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9B496F6
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:20 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230112133719epoutp03be41ab238d1de231bd772cfd48337729~5kz-dzlBr1682216822epoutp03M
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230112133719epoutp03be41ab238d1de231bd772cfd48337729~5kz-dzlBr1682216822epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530639;
        bh=03mtfZ0KyaknfOoQAQSi8hDKEjbikutk8J2fRbEhzmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wu/RuSKWLyD4M6PLltsxBZMfrqP7MyiEAS7C3gqYh/Rj5ZvJkadjDEolBz1L/iJCK
         01sgsVczntc3ft61T8P1H+bOO0qvdxMxCiA4K4jmW7x6s7Wrh8eeu1XLb8nX69EDXP
         x5nkUHcW86sXpaydBVhYIzvyyHuI04KpoanCQLOA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230112133718epcas5p437bad450396846e909113f3d0d882a48~5kz_0tOX52984229842epcas5p4k;
        Thu, 12 Jan 2023 13:37:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nt5FS5GFhz4x9Px; Thu, 12 Jan
        2023 13:37:16 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.66.03362.C0D00C36; Thu, 12 Jan 2023 22:37:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230112120131epcas5p4374e6add89990dd546bd0ae38f4386f0~5jgWZWF5v0983009830epcas5p4V;
        Thu, 12 Jan 2023 12:01:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112120131epsmtrp2e60d5d391c6f729215e19237dc753b83~5jgWT-6i73008330083epsmtrp2h;
        Thu, 12 Jan 2023 12:01:31 +0000 (GMT)
X-AuditID: b6c32a4b-4e5fa70000010d22-d9-63c00d0c30b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.33.10542.A96FFB36; Thu, 12 Jan 2023 21:01:31 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120128epsmtip2f6dd2b1d2e6ed1351ebe40f693614486~5jgTeUo3b0767707677epsmtip2c;
        Thu, 12 Jan 2023 12:01:27 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 4/9] block: Introduce a new ioctl for copy
Date:   Thu, 12 Jan 2023 17:28:58 +0530
Message-Id: <20230112115908.23662-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPfeW21tCl0sROSLDeolbkACt9HFBGLiR7W7UrAmLSzQGu/ZC
        CaVt2oIPslksmoBB1IFKFZGXUR6y8RqvKtahAkE0PgZGhoOyGBU6eUwCMkcpbP73+f3O93t+
        j5ODo7x/MH88VWtiDFqFhsQ8WS03gz8O9eJ2KQUnyz6i6ntvodThE4soVTNcgFG2yXMe1FBX
        G0J1lp9CqCs13QjVUfYaocaeTrOp7ncTGHXK/hhQ44+sCGV7EkJ12npY1IP28xhVemmcTbU6
        sgHVslCKUtNVOWzq6ksni7rzZAM1sHjbI24dbR3px+g26zCbHvj9Zxb9oD+DbqjOxejGykN0
        x5AZo/MtkxjtvPYIo483VQO6sS+Lnm4IpBscE4icuystWs0oVIyBz2iVOlWqNiWGTEhM+ixJ
        LBEIQ4WRlJTkaxXpTAwZL5OHfp6qWRqa5GcqNBlLKbnCaCTDP4k26DJMDF+tM5piSEav0uhF
        +jCjIt2YoU0J0zKmKKFAsFW8JNybpq6+bkH0h4P2l5grWWZwKyAPcHBIiGDn2RkkD3jiPKID
        wOYLs5g7mAJwLP9PD3cwDaCt8Tyyahnv70XdB+0Anp4rZrsDCwK7RgZYeQDHMSIE9r3DXYa1
        xFMEtvUFuTQosYDAZzfngUvjQ8TAxrx0l4ZFbIaW7kIPF3OJKFj89o6HSwKJcFgw4u1Kc4ht
        sHZwhuWWeMOeYscyo8RGaGk+t9wPJCo4sL28DrgbjYeXnxeibvaBL243sd3sD6cnbZib98Er
        hZcxtzkHQOtv1hVzLDzSW4C6mkCJYFjfHu5OfwiLeq8i7sIfwPwFx8pSuLD1wioHwdr6iyv3
        r4eP32SvMA1zxhZXNnocwKb+n9gnAN/63kDW9way/l/6IkCrwXpGb0xPYYxifYSW2fffKyt1
        6Q1g+SNsSWgFo8/+CrMDBAd2AHGUXMvt7L6u5HFVigMHGYMuyZChYYx2IF5a+EnU31epW/pJ
        WlOSUBQpEEkkElFkhERI+nGZ5lIlj0hRmJg0htEzhlUfgnP8zcgw0iv6rj5fM3+solY5WDeH
        F3h3+GzaMf460fKp15pGvXPvYpPs5ZTYl3DmfjlVE8XamJA225G9eyBf7WmG28m4/Qc4c7uP
        RgTw+Kc5fpm+39pG9J6gVnoo+EhQVXXLjfkqxxqlbI+5wssuPqYJKRGfKS/f9iJgCPbvxJ1f
        V5V9Exs7GP3q7N+JXiV3i+5f2pGlqoyGGOC/GvfJipNF/bAzabPcsT1Z9GY+7yG5aUNaUKYE
        8I6mth2MVfvff7tVbj+Tn7xONhtl/TXw+d349mTZaJZXsPSP73fF51z7cXRGKrg3UReoqnfK
        v5go+kqzx6+H+xBR9dwzt93o+SXXIJWSLKNaIdyCGoyKfwE8GgRjkQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWy7bCSvO7sb/uTDZYuYbJYf+oYs0XThL/M
        Fqvv9rNZ7H03m9Xi5oGdTBZ7Fk1isli5+iiTxe6FH5ksHt/5zG5x9P9bNotJh64xWjy9OovJ
        Yu8tbYs9e0+yWFzeNYfNYv6yp+wWO540Mlps+z2f2eLz0hZ2i3Wv37NYnLglbXH+73FWBzGP
        WffPsnnsnHWX3eP8vY0sHpfPlnpsWtXJ5rF5Sb3H7psNbB69ze/YPN7vu8rm0bdlFaPH5tPV
        Hp83yXlsevKWKYA3issmJTUnsyy1SN8ugStj1f5mpoIm5Yq5DUtYGhiPyXQxcnJICJhIPD17
        irmLkYtDSGAHo8Sr/ulMEAlJiWV/jzBD2MISK/89Z4coamSSWLXnAJDDwcEmoC1x+j8HSFxE
        4BmTxNl7j8AmMQu0M0tc6j3PDFIkLGArsbkrF2QQi4CqRPPRKawgNq+AlcTMPydYQUokBPQl
        +u8LgoQ5Bawl1tz4wgJiCwGVzNpzlQmiXFDi5MwnLCDlzALqEuvnCYGEmQXkJZq3zmaewCg4
        C0nVLISqWUiqFjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5uLa0djHtWfdA7
        xMjEwXiIUYKDWUmEd8/R/clCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0t
        SC2CyTJxcEo1MJ2Zdn+/3p422fncrnnGM9Uj87MOBBs68vz40TArbMok1it9W0SDk98853zI
        tGgH4+fEXcfZmm792sL7L+U/p6po/5oDEZZtAcqP9h9giJl1KNxcafs2AfvnIQtFW1p1QkI/
        9IlXux9oNfNT+WkpeKHdUXovg96dVSmu/XLFfg9YvKb8frffKFg7sTtlzoqwxPXvL69NlPCa
        sKTtZ4jN3+kWgpXzHD3mSpaaCendb7N3XcIiWcW2W+ZaUK/d4l9/pfxnP9u8yjWl73ZltWH/
        hNvHTnaHzfDdcWEll+SbpSxHO1JXfr125P3MmxKPbhz4W3oxMKlj1SZ7qxDPvMCnt5QKmIq+
        qjyKPZv/aa2egxJLcUaioRZzUXEiAHdQi11dAwAA
X-CMS-MailID: 20230112120131epcas5p4374e6add89990dd546bd0ae38f4386f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120131epcas5p4374e6add89990dd546bd0ae38f4386f0
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120131epcas5p4374e6add89990dd546bd0ae38f4386f0@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
to one or more destination in a device. COPY ioctl accepts a 'copy_range'
structure that contains no of range, a reserved field , followed by an
array of ranges. Each source range is represented by 'range_entry' that
contains source start offset, destination start offset and length of
source ranges (in bytes)

MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.

Example code, to issue BLKCOPY:
/* Sample example to copy three entries with [dest,src,len],
* [32768, 0, 4096] [36864, 4096, 4096] [40960,8192,4096] on same device */

int main(void)
{
	int i, ret, fd;
	unsigned long src = 0, dst = 32768, len = 4096;
	struct copy_range *cr;

	cr = (struct copy_range *)malloc(sizeof(*cr)+
					(sizeof(struct range_entry)*3));
	cr->nr_range = 3;
	cr->reserved = 0;
	for (i = 0; i< cr->nr_range; i++, src += len, dst += len) {
		cr->ranges[i].dst = dst;
		cr->ranges[i].src = src;
		cr->ranges[i].len = len;
		cr->ranges[i].comp_len = 0;
	}

	fd = open("/dev/nvme0n1", O_RDWR);
	if (fd < 0) return 1;

	ret = ioctl(fd, BLKCOPY, cr);
	if (ret != 0)
	       printf("copy failed, ret= %d\n", ret);

	for (i=0; i< cr->nr_range; i++)
		if (cr->ranges[i].len != cr->ranges[i].comp_len)
			printf("Partial copy for entry %d: requested %llu,
				completed %llu\n",
				i, cr->ranges[i].len,
				cr->ranges[i].comp_len);
	close(fd);
	free(cr);
	return ret;
}

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/ioctl.c           | 36 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  9 +++++++++
 2 files changed, 45 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 96617512982e..d636bc1f0047 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -120,6 +120,40 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	struct copy_range ucopy_range, *kcopy_range = NULL;
+	size_t payload_size = 0;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&ucopy_range, (void __user *)arg,
+				sizeof(ucopy_range)))
+		return -EFAULT;
+
+	if (unlikely(!ucopy_range.nr_range || ucopy_range.reserved ||
+				ucopy_range.nr_range >= MAX_COPY_NR_RANGE))
+		return -EINVAL;
+
+	payload_size = (ucopy_range.nr_range * sizeof(struct range_entry)) +
+				sizeof(ucopy_range);
+
+	kcopy_range = memdup_user((void __user *)arg, payload_size);
+	if (IS_ERR(kcopy_range))
+		return PTR_ERR(kcopy_range);
+
+	ret = blkdev_issue_copy(bdev, bdev, kcopy_range->ranges,
+			kcopy_range->nr_range, NULL, NULL, GFP_KERNEL);
+	if (copy_to_user((void __user *)arg, kcopy_range, payload_size))
+		ret = -EFAULT;
+
+	kfree(kcopy_range);
+	return ret;
+}
+
 static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
 		void __user *argp)
 {
@@ -482,6 +516,8 @@ static int blkdev_common_ioctl(struct file *file, fmode_t mode, unsigned cmd,
 		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
 		return blk_ioctl_secure_erase(bdev, mode, argp);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 9248b6d259de..8af10b926a6f 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -82,6 +82,14 @@ struct range_entry {
 	__u64 comp_len;
 };
 
+struct copy_range {
+	__u64 nr_range;
+	__u64 reserved;
+
+	/* Ranges always must be at the end */
+	struct range_entry ranges[];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -203,6 +211,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.35.1.500.gb896f729e2

