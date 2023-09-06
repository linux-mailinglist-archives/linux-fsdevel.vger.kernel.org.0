Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90075794272
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbjIFRzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbjIFRzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:55:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864EC1724
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:34 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230906175432epoutp0193e5ed5fbfc5a9aef758eedd180726fa~CYNPZXeoK0734607346epoutp01m
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230906175432epoutp0193e5ed5fbfc5a9aef758eedd180726fa~CYNPZXeoK0734607346epoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022872;
        bh=MHmyRUx5RVJdIB9gEFILwhLjfKDekiDvssNA72vWuUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoQhlVhA506srdBAE8VZV0C7o8gMs9V6uDPpQTgtA5LCE/U4kmrqFEns29WIjl9hP
         OksSyYydCDOJwqunvotZC2w/YwqSGjqwMPNgPQmnjSXlezdFQnq9hMxa2hL7nkD2JB
         YJJMXOhCCBzufbmtGl3mcKy1mUN474CvRcYe4nQY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230906175431epcas5p4caef517db715554fb2030354050b0b27~CYNOd4nfJ1892318923epcas5p4O;
        Wed,  6 Sep 2023 17:54:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rgqkt10Lyz4x9Pt; Wed,  6 Sep
        2023 17:54:30 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.E9.09638.5DCB8F46; Thu,  7 Sep 2023 02:54:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230906164340epcas5p11ebd2dd93bd1c8bdb0c4452bfe059dd3~CXPW-OFCf0674706747epcas5p1L;
        Wed,  6 Sep 2023 16:43:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906164340epsmtrp15603d6d755b27809f79e6df03f2a9d47~CXPW_WxJb0347103471epsmtrp18;
        Wed,  6 Sep 2023 16:43:40 +0000 (GMT)
X-AuditID: b6c32a4a-92df9700000025a6-69-64f8bcd5368f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.D9.18916.C3CA8F46; Thu,  7 Sep 2023 01:43:40 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164337epsmtip2793af6b075dc36212bac0a20406c77d8~CXPUJ56dx1829618296epsmtip2c;
        Wed,  6 Sep 2023 16:43:37 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date:   Wed,  6 Sep 2023 22:08:31 +0530
Message-Id: <20230906163844.18754-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta1BTRxTHZ++9uQQ0egnQrrTWGHXqo4EEAixofOG0t9oPtM6odSbElNwJ
        CCQxCQWctgYloaK8BKQERUTGGsiAUqXKqwxMeU5LCxhLpiBtYeRRIqVjYcaiJVy0fvud/56z
        /z1nd7k4/wnpz43TGBm9RpkgJL2IurYtm0WOxnmV2OyNarrbcXQ6dwFHVUM5JJpqmwVotCUD
        oCZXCQcNttzDkK3qewxdaHUANHbfiqEm5zZ01VJBoMamLgL1118i0ZXrYx7o645nGPoldwyg
        uqdXcFQ99ZhAnc43UO9CB2e3H907fIug+39Iomsrz5L0NxWn6IZBE0lfy87n0FlnXCT915iT
        oB833yfp7NuVgP679i26dnQai1p5NH5HLKNUMXoBo4nRquI0apnwwEFFpCIkVCwRScJRmFCg
        USYyMuG+D6JE78YlLLYqFHyqTEhalKKUBoMwcOcOvTbJyAhitQajTMjoVAk6qS7AoEw0JGnU
        ARrGGCERi4NCFhOPxcfOudowXdnqFIfFhZnAzZWZwJMLKSm02Uc8MoEXl081AFgyM0yywSyA
        D2bsHi+DyrxJLBNwl0rqRw+w+j0AL43nLleYMWiqblxKIqltsOc51637UiYc3my4BtwBTlVj
        sLiiD3eb+1AKaMoa4LiZoDbBiQvVpJt5VAQ863xGsG6BMOeht1v2pLbD02k/AzbFG3YVjxJu
        xql18MydEty9P6Sec2G3awBjm9sH+6qGPVj2gZMdt5fZH07kWJY5GdoKbpBscTqA1gdWwC7s
        gubuHNx9CJzaAmvqA1l5LSzsrsZY41Uw6+noshcP3i19wRugvaaMZHkNdMylLTMN7T2lGDut
        bADNhUNELhBYX2nI+kpD1v+tywBeCdYwOkOimjGE6II0TPLLa47RJtaCpfe/df9d8NvITEAr
        wLigFUAuLvTludb9o+LzVMrUk4xeq9AnJTCGVhCyOPA83N8vRrv4gTRGhUQaLpaGhoZKw4ND
        JcLXeVPmyyo+pVYamXiG0TH6F3UY19PfhMWkTMpkYOf5i0dSDubttV3dKCt89KG88uHCVzVZ
        n7yX3x6m/em4XdQmt/B6HSumbw21cxRT7wi+zUwvnjzcefzGr56lOJ6hffPRR5HJk+VrZ+OK
        xpMDd3022/g59SSPc6Jvo/TiVNiet0PeT11xLqM53bQQ+VqVDtUOb+r9wnJiM3dAfkfauaEl
        umL/4X5+ubPJXpQsUUR4aQv6ROYGedDJ4LlYv6Onflyduz0tbP3lc+3tf/4b5lwv+vLYiKGw
        /A+fPbvbehLHpXvnS/jBvrrm77pmP55w9cujrwtaRorqIvPEdPQqBerOVx8anLZ1FfCHUw+p
        f/fxtc3EW4845gMa/FMtQsIQq5RsxfUG5X/BryaXiAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHfc85Ho/m6rhlvik5nGWhNBsVvaSUFsiBpMLCD2WXQzvNaOo6
        c1EhNLWUWV5QxDtbZYoaWrPMS5bNbhpmZk5dFz+0oWXNzEtROHNK0Lff87/AHx4KF1YTvtSp
        xGSOT2SVEtKDaOqUiDeG3/ol36TvFaCG7mc4Ssubw1Hdh1wSjXf+AMjakQlQu73MFQ13tGCo
        pu4phvJNZoBsA6UYareEoGsZlQR60N5FoP7WchLpq2xuqPq5A0NDeTaAmv7ocVQ/PkGgFxY/
        1Dv33DXCm+n9eIdg+ns0jLFWRzKNlReZtmEtydzIKXBlstPtJDNpsxDMxMMBksm5WwuYKaM/
        Y7R+w/Z7HvIIl3PKU2c5PnTHcY/4n/ZOTGVYcc6cYce04LZnFqAoSG+BrdY9WcCDEtL3Afxk
        +g2ygPuCvhpWzT3Bl1gEaxyjbkuhdAyOTD1zdZZJOgS+nKec+ko6C4e6FjvhPHC6GYOj8xlu
        zraIPgINr3sWmaDXwc/59aSTBfR2qLM4iKUVoTB3xMspu9NhMC21b3GEcCHyvnYcLMW9YFeJ
        lXAyToth+r0yPA/Qpf9Zpf9ZBoDVAm9OpU5QJJxQyaRqNkGtSVRITyQlGMHiL4NjmkFVw5zU
        BDAKmACkcMlKgV08KxcK5Oz5CxyfdIzXKDm1CfhRhMRHEKjUyYW0gk3mTnOciuP/uRjl7qvF
        Dm7oblN8731VdazC21vDvzk51WCInhZ/MJ8Z2R36rg8lNTq+FDzFWX562Kj6Gkc/ku0cKdln
        1wfxfgH7vSziFFlcYKxpYCrK8/Jo3tGwwgAfa//Y7Qz1INVXva8E77puXquUpNoycc3VnEOX
        ZLv8ReKiWIOjI/g9qxIdrfCJeFygH4/aODOwZszcZnjc3IG9jazZGwwKUzYXi2J7SjYFLg/S
        DgrZxLj+liHtyYiA6MyIKx/DXdZnbyucVG292diqOZAaU2SemAlhJPbicumdsfxoaZFLikK3
        anAZtbnrlckwtmo+VV6+9Qqddng2bjCwTRiZfLx0Bhev89QNSQh1PCsLxnk1+xeh4Ot/OgMA
        AA==
X-CMS-MailID: 20230906164340epcas5p11ebd2dd93bd1c8bdb0c4452bfe059dd3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164340epcas5p11ebd2dd93bd1c8bdb0c4452bfe059dd3
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164340epcas5p11ebd2dd93bd1c8bdb0c4452bfe059dd3@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, and fallback to generic_copy_file_range incase
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index a24a624d3bf7..2d96459f3277 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -739,6 +739,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t copied = 0;
+
+	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
+	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
+	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
+		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
+					     NULL, NULL, GFP_KERNEL);
+		if (copied < 0)
+			copied = 0;
+	}
+	if (copied != len)
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -832,6 +856,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2

