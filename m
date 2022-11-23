Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FD635025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiKWGNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbiKWGNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:48 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A77F3906
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:28 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221123061327epoutp0491c05baa4364328d2b663c515cc8f429~qIgLG_VbV2231722317epoutp04g
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221123061327epoutp0491c05baa4364328d2b663c515cc8f429~qIgLG_VbV2231722317epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184007;
        bh=kSJ3dOFoktYoCaNlIORYzBMHiA2ANyobnZ0zDKBDF0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irJJ08ZsN3oEw9hD9aN4LE/GRqVev9eqr5PfEF0Qrhglj/x9CtN4ASUwmM+oRznwc
         C4dg1nN1KdYHhnawh+88tmfa8g+WRIDTsQlg1tWdlwd0IxOGFqL/PimqlJUU2t0lPf
         ff4h8pRJcAy62beqThmpoLTr2RgVGQPll2UKiS/c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221123061326epcas5p1885bf1308a88e8eff224df73c203fb5d~qIgKc2Z0n0806708067epcas5p1V;
        Wed, 23 Nov 2022 06:13:26 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NH9mN24Txz4x9Pp; Wed, 23 Nov
        2022 06:13:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.17.56352.40ABD736; Wed, 23 Nov 2022 15:13:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123061024epcas5p28fd0296018950d722b5a97e2875cf391~qIdhHT_sF0604106041epcas5p2s;
        Wed, 23 Nov 2022 06:10:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123061024epsmtrp256f8d5870cea901380bcaafd9741ed60~qIdhGOQih0451404514epsmtrp2V;
        Wed, 23 Nov 2022 06:10:24 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-db-637dba0497f2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.B2.18644.059BD736; Wed, 23 Nov 2022 15:10:24 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061021epsmtip1ff00839ccb85553e37f8279ede1fac88~qIdd9k6Z32063320633epsmtip1C;
        Wed, 23 Nov 2022 06:10:21 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH v5 04/10] block: Introduce a new ioctl for copy
Date:   Wed, 23 Nov 2022 11:28:21 +0530
Message-Id: <20221123055827.26996-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRT3u/fu3QWkLo/0A8PWTWuAeCws8EEQTVJewwhoDMUmXOEGDMvu
        ug/FiHFNGBaK58SjhQkSI0EH4o2LMLQGyCJSw4hCIFIwBQ5QQYPNytAuF8r/ft/vd875nXO+
        OTzcvozrzEuWqhiFVCwRkNZE+01XVw9CnxHvPVTDQ43Gfhx9WriOo6tTBSQyDY/gqHupgoPG
        e69j6MalYgzVXe3DUNfXf2Lo18kVLurbWCTRzOoEgYoNYwDN3dVhqHvCHd3oHiTQqL6SRFW1
        c1xUNNDCQZ2zFwBqN1XhaOWbTC5qeLRMoFsTe9DI+gDndSdaNz1M0td1U1x65EETQY8Oq+nm
        +hySbrl8nu4a15B03sUlc0DWNIde7rlL0vmt9YBuGUqnV5r30tm9n2F08+wiFvlsbEpwEiNO
        YBR8RhovS0iWJoYIwt+LOxjn5+8t9BAGogABXypOZUIEYUciPd5Klpi3IeCfEUvUZipSrFQK
        vF4LVsjUKoafJFOqQgSMPEEiF8k9leJUpVqa6CllVEFCb28fP3PgyZSk9r+HCPkTQdpjTS2u
        AYbnc4EVD1IiuFZzh8wF1jx7qgvAS6UlmEWwp/4CUHtHxgorAJbd1+LbGdfmezmsoAdw8OFF
        gn1kYbBq/gnIBTweSbnDoQ2ehXek8jGo7erdzMYpEwZLixwt2IEKhf2azE07gjoAtTO3CAu2
        pYKgVnt7sw6kvGDBtJ2FtqJehbd/0mNsiB0c/HKWYEu+AC+2VeAWL0gZraB2NX+r0zA4W2Ak
        WOwAFwZauSx2hitL3SSLz8K6L66QbHImgLp7OsAKoTDLWIBbmsApV9io92JpF1hibMBY42dg
        nmkWY3lb2PnVNn4RXmus3qrvBMfWLmxhGtZX9gJ2WfkAlmRPcAoBX/fUQLqnBtL9b10N8Hrg
        xMiVqYmM0k/uK2XO/vfL8bLUZrB5IW7hneCXh394GgDGAwYAebjA0fb84U/i7W0TxOc+ZhSy
        OIVawigNwM+88CLc+bl4mfnEpKo4oSjQW+Tv7y8K9PUXCnbb1pS7xdtTiWIVk8IwckaxnYfx
        rJw1mI21qS1A+q20Ijpncj5MgrdVlx1f/v5+5ZmpkOb0mFe847wiPgj4cMFxo/Yot/xYsUPq
        jCHaVUuO+xJ9wTYdQL+jiZJk7dh1VLQ/9tAV3/Bj8u9gg9Ok+9wB9O7l+vAHXM97b7u877Pb
        5UgA3271x5bowkGfxQr/feUny3RReWvUKbeIwIyqnj1MeOKhHyIzcsqjag0dMb9vRMR85LqU
        +MbLml39Eq3poElu021sHyrtK+4ZTXvJdmex2mQlHTsd+pvT/GMsrfXRm6cy3zlXNzx7eP1E
        UmjU56NNx9eYggXF6XRPzt5ofF/Qif1YxGRLz828ne4ipUNHyc81sZ3/zGePBGkEhDJJLHTD
        FUrxv4FABlOqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSnG7Aztpkgw/TVS3WnzrGbNE04S+z
        xeq7/WwWv8+eZ7bY+242q8XNAzuZLPYsmsRksXL1USaL3Qs/Mlk8vvOZ3eLo/7dsFg+/3GKx
        mHToGqPF06uzmCz23tK22LP3JIvF5V1z2CzmL3vKbjHx+GZWix1PGhkttv2ez2zxeWkLu8W6
        1+9ZLE7ckrY4//c4q4Okx6z7Z9k8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaP3uZ3
        QAWt91k93u+7yubRt2UVo8fm09UenzfJebQf6Gby2PTkLVMAfxSXTUpqTmZZapG+XQJXxrav
        p1kK/ihV/GhYxtzAeEimi5GTQ0LARGLNywOsILaQwA5GiRmPBSDikhLL/h5hhrCFJVb+e87e
        xcgFVNPMJPHswCLGLkYODjYBbYnT/zlA4iICC5gkLt97xQziMAu0M0t8mbsCrFtYwF7iWEML
        E4jNIqAq0fHwBAuIzStgJdHRcQZskISAvkT/fUGQMKeAtcSZi7uYQMJCQCV7lulAVAtKnJz5
        hAUkzCygLrF+nhBImFlAXqJ562zmCYyCs5BUzUKomoWkagEj8ypGydSC4tz03GLDAqO81HK9
        4sTc4tK8dL3k/NxNjOBkoKW1g3HPqg96hxiZOBgPMUpwMCuJ8NZ71iQL8aYkVlalFuXHF5Xm
        pBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwJQRt4P31NmVVg385ebXH9RNuh0q
        fbN0y5cz0We92IIXMbIc7Y8oVGk/K3Gh87DslpkPJ6x+snL9lRzrBR4b66XZpvF/2PhIXfxO
        pM0USe/z+Yr6SyRmb1A4G62UUrnC1jd855nV4k9DlDZ4zpiq59wSsui6f+zKQ3vn23MY7Kr8
        v/LmkuYsYc/wdbw5jye5O8g9TA3IZ18VU3o8VEX0z4RrFhsE/+/uWpRd/t+X59ZGz0v8UwVj
        xPh3ZrpGufRlnxLvW7RYwvP91t7lxfOzi38qTWPbtnEtw4kbrFVv43aozf108k3+FFmmwwGi
        R6Kbmr5z8nNceCpReTrraEyXzJ31fmeWTMgNetcRnt1lM1OJpTgj0VCLuag4EQDA19x3dQMA
        AA==
X-CMS-MailID: 20221123061024epcas5p28fd0296018950d722b5a97e2875cf391
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061024epcas5p28fd0296018950d722b5a97e2875cf391
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061024epcas5p28fd0296018950d722b5a97e2875cf391@epcas5p2.samsung.com>
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
index 60121e89052b..7daf76199161 100644
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
@@ -481,6 +515,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
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

