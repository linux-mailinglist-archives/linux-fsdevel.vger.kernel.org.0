Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84D7A7699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjITI7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjITI64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:58:56 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B11AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:32 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230920085830epoutp039d98f6712dcc3a638dd38822ca89279f~Gj7N2HpBG1762417624epoutp034
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230920085830epoutp039d98f6712dcc3a638dd38822ca89279f~Gj7N2HpBG1762417624epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200310;
        bh=dWjB1X4Tkq4QWW6+lZPmoLyOTu3O/nojmE7xPmrQSyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVjsMIzWvxdI2pC+susV0lQgNsUvVzZ5neePmjnbm/HeuD9pwu7vQ6B2rtlGX7lja
         KqdA6OigmsfjJ7/5rFxRGlRBa6hUCV9BPYonkngFYBeRsre6xFqwBSvaq6z2xey/9e
         GlNrzpB9jAXU3zHtB6+5oSs6xO9kGy7SQy8g5KDc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230920085830epcas5p39ebd476d89a1e542215c8f140a2b0c3d~Gj7NSewOC0420204202epcas5p3J;
        Wed, 20 Sep 2023 08:58:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RrC9w2LQZz4x9Ps; Wed, 20 Sep
        2023 08:58:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.25.09635.434BA056; Wed, 20 Sep 2023 17:58:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230920081519epcas5p24e047589278635b45aab3b260cb447f0~GjVgWL6Y43141931419epcas5p2E;
        Wed, 20 Sep 2023 08:15:19 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081519epsmtrp1157ed79642ad55184f926482f8ada941~GjVgVHWKB2250122501epsmtrp1S;
        Wed, 20 Sep 2023 08:15:19 +0000 (GMT)
X-AuditID: b6c32a4b-2f5ff700000025a3-96-650ab4348e01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.6C.08649.61AAA056; Wed, 20 Sep 2023 17:15:19 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081515epsmtip15e8c3592b5843f13f663f32c55b96f38~GjVcov2vD0185801858epsmtip1K;
        Wed, 20 Sep 2023 08:15:15 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date:   Wed, 20 Sep 2023 13:37:43 +0530
Message-Id: <20230920080756.11919-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59y73N1lAi6vOqDCzjJaQLC7uGyHl9pAcJNqaJpKS4IV7rAE
        +2B3YUtmEuRRorJAgrAoIg9FFJHnACspoOJCBROjPJJHstQkAyokikjFslj+9/l9z+87v8eZ
        Hwu3K2A6s+JlalopEydyCUtGa4+7u5ew2ZLmT4yxUX3fTRw9erzCQIfyVnF0YVxLoNmeBYCM
        174FqHO+1AKNXmvH0JWKAgydv3ADQwXddwCaua3DUOeYJzqTXcVAVzoNDDTUcZJAp8/OMNGR
        4TYCnev9G0MjeTMAtRnTAWpdOY2jS7MPGOjW2CY0sNprscuJateNM6mBiQYGNfRTMtVYe5ig
        mqoOUvrRNIKqzP3egjqWMU9Qj2bGGNSDH24TVG5zLaCa+lOpxUYXqtE4h0VYf5YQKKHFsbSS
        Q8ti5LHxsrggbvhHUcFRviK+wEvgh97icmRiKR3EDXkvwis0PnFtEVxOijgxeU2KEKtUXN6O
        QKU8WU1zJHKVOohLK2ITFUKFt0osVSXL4rxltNpfwOf7+K4lRidIau/+aqHQ23x1arWckQZ6
        X8kBbBYkhVCftoLnAEuWHakHcOz5pIU5WABweb56I1gCsDU/H+QA1rpluijErHcCWKNd2LBn
        YfD63F9MUxJBesL+f1gm3YFMw+FlfSUwBThZhsOme72YKcmejIKFv+8x9cEgt0LDH+m4ia1I
        fzjd0b9RjAe1k7YmmU0GwMWqYaY5xRYaSowME+OkK8xoKV3vAZKVbLhwdYlhni0EfldSjJvZ
        Ht7vbWaa2Rn+qc3eYA08f7yGMJszAdQN64D5YSfM6tPipiZw0h3Wd/DM8hZY2HcJMxe2hsdW
        jJhZt4JtZS/YDV6sLyfM7ATvPEnfYAoa67I2NpoL4EjOFJEHOLqXBtK9NJDu/9LlAK8FTrRC
        JY2jVb6K7TJa898vx8iljWD9ODzC28C9qYfe3QBjgW4AWTjXwUq6zZK2s4oVf32AVsqjlMmJ
        tKob+K4tPB93doyRr12XTB0lEPrxhSKRSOi3XSTgvmY1m3Uq1o6ME6vpBJpW0MoXPozFdk7D
        Bve1H6oL19m+utvFkBrqb2jvyq7Wf/nBb0/984wHGmpSDjacYL9rM/8hMf72681yx4mdDzWN
        VqvB45MD6qYT07zcMnveYc+znptDihNW1T0B0Z8Epnc0JIqfdZXcP7Jv9Nk3PtscBzkdT6jI
        7oqwG9G4nWSP2k+w43nSls9LU3dFLneBUr0mu9A9VGPj63LUKeOmz2ap9V6Qkbl3aqY0k/ej
        y1aNdDDS/839TfuLDbL8jxerKwN+GdW6LU1vkrf8fLemqE7iajgXuDzhluT6+GLCyPG5osPX
        K0S3tENi+6VaXpjjmcufBnuMp/ScfOr0ha7qalhYUgO/731r6p0Wd47DG7uXuQyVRCzwwJUq
        8b+AeRKepQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02ReUiTYRzHe9733bt3q+nrsnxmUDBoiab2UsjTbWD1/hESERXmNdqbmm6N
        vVpWUtqoaFauE/Oammk70JxmHhmi6TLtwDJ1pQZql2SH3UurZUH/ffhe/OBH4VIH4UslaJI5
        nUaZJCfFRE2LfG6gj0XMLWpoxVHFnTYcvf/kItBh4wSOrP1ZJBpt+QDQcNMxgBrHcgWor6kO
        QzeKz2DIbG3F0JnmxwCNdOdgqNEZgIqOlhDoRmM7gR7W55HIVDoiRJk9tSQqc0xiqNc4AlDt
        cAZANS4TjspH3xLotnMOuj/hEITK2LqcfiF7f6CSYB/eTWHtluMkW1VyiG3oSyfZS6fOCtiT
        +jGSfT/iJNi3N7tJ9lS1BbBVHQfYcftc1j78BtvoESFeoeKSEvZwuuBVseJ4y9MnAm2DZ2r+
        RCGRDhwzDICiIL0EDl0IMwAxJaUbAGw6UkQagOi3LoOlE7fwKZ4JzZMvhFMhPQadg3qBu0zS
        AbDjJ+XWvWkDDo/XjRHuAk7bcFidL3HzTDoKDunzMDcT9HzY/iLjz6iEXgaH6jvA1BHBMGvQ
        yy2L6OVwvKRH6Gbp70jHA5NwKu4F2y8O/52fB/XXcnEjoHP+s3L+swoBZgEyTsur49Q7GC2j
        4fYG8Uo1n6KJC9qxW20Hf37t71cLBkyTQc0Ao0AzgBQu95aoFWJOKlEp9+3ndLtjdClJHN8M
        5lCE3EfCZOeqpHScMplL5Dgtp/vnYpTINx2rD+njuxyLC6aPmzqfZtoW+0e2Zn63WTwXhBNY
        ZclBgXRFhk+sH+Md/GmQPMfXdO8UGz02L7PR2ert52tgttnOtDguZY0yvmXrtJ6JO/c5DV2l
        ZQVcNG/eNC1VFVn1aFcifP1MeC9tVlHymihwOXroa4HCY715g+vbwt7C2SEuhfm08bMt+0rX
        wKOLk37XvtxiUleBaDzDKzym+MlaRcR25aGr02NCr4dubTtKJq8u3Lb6hLVpLPFV2NewWCsT
        /pzq7+sJCLTUdWoDVRELY1Y6QqSilKVF+eUnCs6Naq6f1KW1pXW2WjfI7OZ3r2QvL1srMPVH
        kaGqWPRjyyZpr5zg45WMP67jlb8AEnlxkFoDAAA=
X-CMS-MailID: 20230920081519epcas5p24e047589278635b45aab3b260cb447f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081519epcas5p24e047589278635b45aab3b260cb447f0
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081519epcas5p24e047589278635b45aab3b260cb447f0@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, or use generic_copy_file_range in case
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index acff3d5d22d4..6aa537c0e24f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -735,6 +735,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
+	} else {
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+	}
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -828,6 +852,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2

