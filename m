Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B406D778D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjHKLVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbjHKLUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EB1718
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:36 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230811112033epoutp0475b9a159b020dfe475adce0df9785a59~6UD02IIJA1280312803epoutp04P
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230811112033epoutp0475b9a159b020dfe475adce0df9785a59~6UD02IIJA1280312803epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752833;
        bh=zcZNECiRVLUz6kLQ0aORLlf+XCJDTvu9EB90O/f7EvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j6Drf3CTqdOcdQRXs1rVG5DNMgJbBCqoJbOZhbC8SMk5f3D3P1JubI9hsdY4DBMMY
         4EW4I1tQ/xgt9bjhAe9MiwpqNhN/yuFHD40kcOAl0pGRSCn+7YdRZ37PXT+Oy7ITEg
         ujxOdDs7OvwcOVdV4tpfoJJ1Tc9I5Igr1Llj5x4s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811112033epcas5p138d0a7351d2d793caac5ae25c6a5f3c2~6UD0ZgJuR2673926739epcas5p1b;
        Fri, 11 Aug 2023 11:20:33 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RMhDJ0wJmz4x9Q0; Fri, 11 Aug
        2023 11:20:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.DE.55173.F7916D46; Fri, 11 Aug 2023 20:20:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105808epcas5p4a9f9573d15f642a73bac46153bb935d2~6TwPq6i6i1667116671epcas5p4G;
        Fri, 11 Aug 2023 10:58:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105808epsmtrp1d7a70559864cd4e9a4233017510ce330~6TwPpkqOr0371503715epsmtrp13;
        Fri, 11 Aug 2023 10:58:08 +0000 (GMT)
X-AuditID: b6c32a50-e61c07000001d785-e4-64d6197fcf88
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.61.14748.04416D46; Fri, 11 Aug 2023 19:58:08 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105801epsmtip285c4782886a3ede423c54dfc89daebef~6TwJxRyLq1354813548epsmtip2v;
        Fri, 11 Aug 2023 10:58:01 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 09/11] dm: Add support for copy offload
Date:   Fri, 11 Aug 2023 16:22:52 +0530
Message-Id: <20230811105300.15889-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxTffa+81xLKHhWySzexefswlhXaWboLWJXMkGckEQXJ3Eewo2+U
        AW1tizonsYTCwCigTNECgoHhAEexg84pKEE+hMVhMHxIopKFGpFQFCdzYbK1PNn873d+9/zO
        Ob9z7+Xjoj8IMT9Db2FNek0WTfjzXNfXrZUdDh3Vyk/ZYpFjsA9HzXdLCTRzfR6gqa5vAZq8
        tgl1eir90J2uXzDU2NyLoRPdowC5R+wY6pwIR+cK63moo3OAh25friJQTYObROf7lzA0XuYG
        yLVYg6OWmTkeujHxJhp60e+3OYQZuneRx9y+mcM4m4oJ5qf6w8yVO1aCqSsp92OO5XsI5ol7
        gsfMXR0hmJK2JsA8dYYxzqlZLDHgk8wNOlajZU0SVp9m0Gbo09X0tqTUj1KjVHKFTBGNPqQl
        ek02q6a3JCTK4jOyvFZpyT5NVo6XStSYzXTkxg0mQ46FlegMZouaZo3aLKPSGGHWZJtz9OkR
        etYSo5DLP4jyJu7J1Fl7R4CxJ/SA5/kYsIIHwUeAgA8pJeytb8SPAH++iOoAsLCnmeSCeQCX
        7rpIX5aIWgCw27FjRTF/qwXjkjoBPP/M5ccFBRhsuH/aG/D5BBUOf/2H7+ODKSsOW6/UAZ8a
        p2ow2OnZ7cOrqFh4ui6P8GEe9S48+6xiuZvQy5/M78F9dSAVCUvvB/logZeecw4TXEoQHDgz
        xeNKroH57ZXLFiCVL4DOH1t4nHYLLGvy54ZeBR/1t5EcFsPp0sKXeD9s/O4HgtPaALSP2QF3
        sAkWDJYuz4BT66DjciRHr4YnB33mfX0D4bHFKYzjhfDS2RX8NrzgqCU4HApH/8x7iRk4NtQH
        uF2VAFjgGiLLgMT+ih/7K37s/7euBXgTELNGc3Y6mxZlVMj07P7/bjnNkO0Ey89fmngJNLe+
        iOgGGB90A8jH6WChOmlYKxJqNV8fZE2GVFNOFmvuBlHehR/HxSFpBu//0VtSFcpouVKlUimj
        16sU9BvCmYJqrYhK11jYTJY1sqYVHcYXiK1Y+Ot1dLKz6Nyt1357v9ZzQVRQ4dQVbVz9Vtc2
        9b7KlB0LftKlitw9IpcUzL6TorOVe4orfy8m+2yjLddinjqE9kVD6/r6pKM3lXGP5HHvPW4d
        XzvZoNq7gI1IFLryoTySnzbGxIuDosk17u0J4+MjHZrUaJK56hyW9nyztWTp+1zTzirX9kBa
        19bzRbUpwDFgjDTl922eKSwqOfFxHLl1EshC/i4NI58X7rYfyH2Y7rZOtB9qCZyO/RIe3Tn5
        pEJ8xm4TfDawS+epTlDKqsyVEZ8/Hs7clSwX3GtKMQRos78SyMMGp4NDTv3cfujiX5/eiE8m
        Hz7Yi2zqmNmD5ro5mmfWaRRS3GTW/AsZFDFXhwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK6DyLUUg85XHBbrTx1jtlh9t5/N
        4vXhT4wWTw60M1o82G9vsffdbFaLmwd2MlmsXH2UyWLSoWuMFk+vzmKy2HtL22Jh2xIWiz17
        T7JYXN41h81i/rKn7BbLj/9jsrgx4Smjxbbf85kt1r1+z2Jx4pa0xfm/x1kdRD3O39vI4nH5
        bKnHplWdbB6bl9R77L7ZwOaxuG8yq0dv8zs2j49Pb7F4vN93lc2jb8sqRo/Pm+Q8Nj15yxTA
        E8Vlk5Kak1mWWqRvl8CV0XD0KmPBEcmKdz+uMzYwPhPpYuTkkBAwkfh0YR1TFyMXh5DAbkaJ
        7X3bmCASkhLL/h5hhrCFJVb+e84OUdTMJPFi1XKgIg4ONgFtidP/OUDiIgJdzBKdO9+xgDjM
        AiuZJHYenskI0i0sYC0xY3EjG4jNIqAqMe/rdHYQmxcoPrUZZAMH0AZ9if77giBhTqDw+02X
        wMqFBKwkPiw7yAhRLihxcuYTFhCbWUBeonnrbOYJjAKzkKRmIUktYGRaxSiZWlCcm56bbFhg
        mJdarlecmFtcmpeul5yfu4kRHJ9aGjsY783/p3eIkYmD8RCjBAezkgivbfClFCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8hjNmpwgJpCeWpGanphakFsFkmTg4pRqYHK8tDq/knK2Va6IadUVt
        LX+eXLrbhb4yff4K9rSgGbct9716nyE+J+jG96d1j0SWsez4/Wr5DPPODR0aRgYxKzaz7K94
        vvy55303sWUMnz0WpfXLLJ7ke7CiQ+vKxpO7lba+2vtVf4mqjaJ3pdbvJUUq2/LOx2ofdglc
        11ax/BNbfYfypE9sLHYFtWtNjnwtmcHV3J14tvdPzaHQJc4MJwqMT69o55I54f74b0HSu7u7
        LtV/z1Zlnvveqq19gprUAgvmDRb9F1/dmLzq8IdTt2wmcQaaVluqyPnP7GW+eH5dofwbj9gP
        Vse2TZ72fNmbiz8fl7A+8b5ywf/tJOW/jb7z70c0JJ2/6vZt/+cgVyWW4oxEQy3mouJEAM+Y
        kks+AwAA
X-CMS-MailID: 20230811105808epcas5p4a9f9573d15f642a73bac46153bb935d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105808epcas5p4a9f9573d15f642a73bac46153bb935d2
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105808epcas5p4a9f9573d15f642a73bac46153bb935d2@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 37 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 +++++++
 include/linux/device-mapper.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7d208b2b1a19..a192c19b68e4 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1862,6 +1862,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !q->limits.max_copy_sectors;
+}
+
+static bool dm_table_supports_copy(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_offload_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_offload_supported')
+		 * and it relies on _all_ data devices having copy support.
+		 */
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1944,6 +1976,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_hw_sectors = 0;
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..f9d6215e6d4d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1732,6 +1732,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+	    max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+		      ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..98db52d1c773 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -396,6 +396,9 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/* copy offload is supported */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

