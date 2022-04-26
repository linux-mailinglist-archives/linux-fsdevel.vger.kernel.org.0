Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC150FCA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349864AbiDZMSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiDZMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:18:18 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05EF51;
        Tue, 26 Apr 2022 05:15:08 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220426121506epoutp0259208e927a4b192598ff5b13901a900c~pcUspQRP_1557515575epoutp02E;
        Tue, 26 Apr 2022 12:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220426121506epoutp0259208e927a4b192598ff5b13901a900c~pcUspQRP_1557515575epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975306;
        bh=Aw/eZeQwqDIFGLFSvcbd3db7NUyv8o6zR/cHud6bu0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFTxyiVo0uQbSCvnSAAZPovYkorcIrqkOTwng0EERSfWnDlWDR7IFmrfh7hNSB2Zu
         n+i44pGgFgrXKhKHQukD2KbHuTW58+blv7zbfmESeLAz/8yRRcFvlB3+v2u0X8cHVB
         ZWUV88y1kT3zgmttOCNTw1Ay5m0pp3D/jaLtlUts=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220426121505epcas5p28f1533d8e7a8ba2c0aa0f1f34e3145c7~pcUrxxzqD1792317923epcas5p2i;
        Tue, 26 Apr 2022 12:15:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Kngn06WMBz4x9Py; Tue, 26 Apr
        2022 12:15:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.13.10063.442E7626; Tue, 26 Apr 2022 21:15:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296~pav4xODFD0348903489epcas5p24;
        Tue, 26 Apr 2022 10:19:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426101938epsmtrp13afcc873554906dc561017b6e9ca4c13~pav4vqRwT2220522205epsmtrp1I;
        Tue, 26 Apr 2022 10:19:38 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-ae-6267e24452ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.49.08853.A37C7626; Tue, 26 Apr 2022 19:19:38 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426101932epsmtip17cfd9cf53a0ae8b9d0dafb6e571d64c4~pavzUoAnQ3271432714epsmtip1Z;
        Tue, 26 Apr 2022 10:19:32 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] block: Introduce a new ioctl for copy
Date:   Tue, 26 Apr 2022 15:42:31 +0530
Message-Id: <20220426101241.30100-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTfd297byHBXCvOD9hYU4YJOB5VKB8gKqLbNZpIpmaZxuAVroUB
        bdMWdEs2gYJmjIfgMFhEUTcJoBbBIchDngIVLFBAYeMhD5W58Q7IeDhKYfO/3/md8zvPHB7O
        7ySteSFSFauQMmFCwpxTVOPg4LRnQHLS9cKkCGl1j3FU1jXFRXk9yQS6ND6Ho7GqQS5KTU4n
        0XyzHkeGoXWofDSDi1reRmNosOAdhroqSzBUdiMVQzl5dRh6lX0ToNLrE8veP6ZItPBChF5M
        d3NQanUnQMMdGgyVd29BZeWNHGR4eIVA124Nk+inZ8UEqnhTjqPs+iUMPdUsECilvpCLioei
        ASqav4ajmt4ODrr7ZoyDGrptUFzCHIn0i/XcXfa0oX0/relrJugU9ShJl2h6SFrfe49DG5oj
        6ILcHwm68Jez9MXn2YAu7Yoi6JimOpxOn5wm6ET1KEGXxPVx6Ynhbg49VtFB+G86Gro9mGWC
        WIWAlQbKgkKkEh/h/kMBfgHuYleRk8gTeQgFUiac9RHuOeDv9HlI2PI2hYJIJiximfJnlEqh
        y47tClmEihUEy5QqHyErDwqTu8mdlUy4MkIqcZayKi+Rq+tW9+XAE6HBRSOb5dHCM4spTWQU
        eGkTD8x4kHKDUU35nHhgzuNTpQA2VGdxTcYkgG1tLaTJmAGwX1vBWZMkJNSsSsoBbDwfu+Lg
        U3EYvJPkEw94PILaAp+84xlpS4oDc2ZnV+JxKp8Hh6YTMKNjA7UT9mf2AyPmUPbwfrthBVtQ
        XvBW4QJpzAMpF5jct95Im1He8Ne6UcwUsh42Xh5aKYtTn0D1bxm4MT+kLpvDV2UvcVOje2BM
        ychq0xvgn/X3SRO2hiPJ51bxafjgXBZmEscCGK/TrQp2wtayRczYBE45QO1DFxP9MUzT3cVM
        hdfBxPkhzMRbwOKra9gO3tZmESZsBTtno1cxDRf+qQamxSUBqGnvIi8Agea9gTTvDaT5v3QW
        wHOBFStXhktYpbtcJGVP/3fkQFl4AVh5MMd9xaCnf9y5GmA8UA0gDxdaWqTZnzrJtwhivv2O
        VcgCFBFhrLIauC8vPAW33hgoW/5QqSpA5Obp6iYWi908t4lFwk0WTyT5DJ+SMCo2lGXlrGJN
        h/HMrKMwvmeN17i/79yufReLHkT6FU+8TtZN6CWGhsOJP3hmBPeLPHyb4lvyBc44vfXvY9e7
        HEeuftBGnJ2UH1JHHo2prT3org/jOXk/wlUnfmc+eyvqsMjMPNZdrD2fIa+xGpDsFjqJ1bYi
        xn1WNTB4SuylOPjR02jm01Jl6k3vHQce51/6MilnaarvuHTYdluoj8D/iNZLG4wmR6/c4X+9
        u5ZIi9QODP9c9U3Ko+eH99okzVh15qOFI3n6GGdL9Yd2nbKlG1803PNrdbDL5ffHRCQ7VG68
        7XGGr51psD3+fVBLbFprZGxRia4wXO6a01uZ61u4ubmqdQItfZVO6kr1MX89e00IOcpgRuSI
        K5TMvz9S7fTpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxzGfc8dxlkORcOLzXTpBnKHEre9Q6YmW5bjzOauH3SJrsxDNXJp
        Whi4bKNdJdMOg2WBYEHwUiAFpwEUC7RuwmpFhOIKo22UQigQNSlyMYxRdBayzG9Pfs/v/3z6
        M7joLLmROZybLyhzZdkSKpRo75FsSkq3yzNTf6th0eXbN3Fkcc+TqPl+GYUqHy/haObGBInK
        y6potNzvwJHT9zKy+qtJNPi3BkMTrc8w5P69A0OW8+UYMjXbMDTdeAGgrnOzz9t78zQKjEvR
        +IKHQOXdfwE0OWzAkNWTgCzWXgI5O2soVNcwSaOfR8wUuv7IiqNG+1MMDRgCFNLb20hk9mkA
        al+uw1HP6DCBLj2aIdAtjxiVlC7RyLFiJ3dG886h3bzB20/xeq2f5jsM92neMdpC8M7+Ar61
        6QTFtxmL+V9cjYDvcqsp/sc7Npyvmlug+JNaP8V3lHhJfnbSQ/Az14epjyP3hWYcFLIPfyMo
        U7Z/FXqo/UGMQiMpWtHfodVgSqwDIQzktsLS0h5CB0IZEdcFYHvzSWqtiIINK3/gazkCmp5O
        08Es4rQYdGslOsAwFJcA+54xQbyeI6BpcXF1B+dcDLw25V+9jeB2wLEzYyCYCS4aXhlyrmaW
        S4cNbQE6uAO5FFjmDQ/iEG4brLf5sSAWPVdcy0VrdjjsPe0jghjntsDLtaIgxrnNUHu1Gj8F
        wg0vWIb/LcML1lmAN4EoQaHKkeeopApprlCYrJLlqApy5clf5+W0gtUnio8zg2tNj5O7AcaA
        bgAZXLKerYjOyhSxB2VHvxWUeQeUBdmCqhuIGUISyQ7qeg+IOLksXzgiCApB+V+LMSEb1dhn
        Ldt31NVPzhr7TB/e3RSfOMV23R7JIn+aJ1zvp3x+y/FKoJx4r6n0on9LCf2dsfBT3+s/VLa4
        j28L+OVPxEtvVL2TmEZe7IsQbbB9GRfIlBRuuFp7xOKP05gT0lJHAmF3Y1rTrBUS6a+x9Zl9
        HsPOMbXz4brKvXSs62b07hMfvDr+9rE/B3Tv3jhjLNl8fFei8cGbmrcGFa958yPJIlt6f/HC
        TMau89NbLansBGkq0jxxS7NUDpZ9GDk0/dLRT2q+uDQ3ELv3o32dYXHVc6eOxSBqUSyOMnfu
        uVIRFpaEJdm8+03C93tMIer9CaP6dffGM+Zr/8nzyU8zDs5X3Kbn7RJCdUgmjceVKtm/AyOj
        iLMDAAA=
X-CMS-MailID: 20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426101938epcas5p291690dd1f0e931cd9f8139daaf3f9296@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
		cr->range_list[i].dst = dst;
		cr->range_list[i].src = src;
		cr->range_list[i].len = len;
		cr->range_list[i].comp_len = 0;
	}
	fd = open("/dev/nvme0n1", O_RDWR);
	if (fd < 0) return 1;
	ret = ioctl(fd, BLKCOPY, cr);
	if (ret != 0)
	       printf("copy failed, ret= %d\n", ret);
	for (i=0; i< cr->nr_range; i++)
		if (cr->range_list[i].len != cr->range_list[i].comp_len)
			printf("Partial copy for entry %d: requested %llu, completed %llu\n",
								i, cr->range_list[i].len,
								cr->range_list[i].comp_len);
	close(fd);
	free(cr);
	return ret;
}

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/ioctl.c           | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/fs.h |  9 +++++++++
 2 files changed, 41 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 46949f1b0dba..58d93c20ff30 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -120,6 +120,36 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	return err;
 }
 
+static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
+		unsigned long arg)
+{
+	struct copy_range crange, *ranges = NULL;
+	size_t payload_size = 0;
+	int ret;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
+		return -EFAULT;
+
+	if (unlikely(!crange.nr_range || crange.reserved || crange.nr_range >= MAX_COPY_NR_RANGE))
+		return -EINVAL;
+
+	payload_size = (crange.nr_range * sizeof(struct range_entry)) + sizeof(crange);
+
+	ranges = memdup_user((void __user *)arg, payload_size);
+	if (IS_ERR(ranges))
+		return PTR_ERR(ranges);
+
+	ret = blkdev_issue_copy(bdev, ranges->nr_range, ranges->range_list, bdev, GFP_KERNEL);
+	if (copy_to_user((void __user *)arg, ranges, payload_size))
+		ret = -EFAULT;
+
+	kfree(ranges);
+	return ret;
+}
+
 static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
 		void __user *argp)
 {
@@ -481,6 +511,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
 		return blk_ioctl_secure_erase(bdev, mode, argp);
+	case BLKCOPY:
+		return blk_ioctl_copy(bdev, mode, arg);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 822c28cebf3a..a3b13406ffb8 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -78,6 +78,14 @@ struct range_entry {
 	__u64 comp_len;
 };
 
+struct copy_range {
+	__u64 nr_range;
+	__u64 reserved;
+
+	/* Range_list always must be at the end */
+	struct range_entry range_list[];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -199,6 +207,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+#define BLKCOPY _IOWR(0x12, 129, struct copy_range)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.35.1.500.gb896f729e2

