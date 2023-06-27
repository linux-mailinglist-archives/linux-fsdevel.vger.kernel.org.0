Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADC7740A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjF1IGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:06:05 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35473 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjF1ICd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:33 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230628064450epoutp04acb63abe271ce8ee2cc61129ec237bab~sv6iMnU052912729127epoutp04Z
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 06:44:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230628064450epoutp04acb63abe271ce8ee2cc61129ec237bab~sv6iMnU052912729127epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687934691;
        bh=HaM5wl7d6XlAT/Tg8+7Uibwdp6IRklJIPzVlJl8O1BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s54d1LujHUFBcUdjgIC0OYg7Gh+sKKoOyaPXMQnxP++sNbaXZ3tsMeSWaqWTFlzvv
         /udaIDrvOsCaUQDLVfmX6zG23k2GJrKmyECAZJ+JzA3xNQ0sbdt61tmMx8FPP3YLHe
         UvGsxRPVhAkzSwhj5Gk5f4nXJ+pZFGo+8RAdGR2Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230628064450epcas5p27072c59c3f70a29396a8ecdc75477e06~sv6hUlEmG1602616026epcas5p2A;
        Wed, 28 Jun 2023 06:44:50 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QrXBS6H7Lz4x9Q6; Wed, 28 Jun
        2023 06:44:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.28.55173.0E6DB946; Wed, 28 Jun 2023 15:44:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184058epcas5p2226835b15381b856859b162e58572d63~smCgdzRC72124021240epcas5p2b;
        Tue, 27 Jun 2023 18:40:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627184058epsmtrp1a67c7afb9091feee7c469eb5c89a9c8e~smCgcr4Fd1856518565epsmtrp1Y;
        Tue, 27 Jun 2023 18:40:58 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-66-649bd6e04566
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.18.30535.A3D2B946; Wed, 28 Jun 2023 03:40:58 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184054epsmtip2c141669cc20c09e0780a9f2f3970ed70~smCc5nDIq0374003740epsmtip2p;
        Tue, 27 Jun 2023 18:40:54 +0000 (GMT)
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
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 7/9] dm: Add support for copy offload
Date:   Wed, 28 Jun 2023 00:06:21 +0530
Message-Id: <20230627183629.26571-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230627183629.26571-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeube9LWR116Lu2CprLi4RWKXVgqcoYjKid3HZyPyDzU1Zbe8A
        oY/1gW5mG4g8rOExQBzVWBGC1KogD1MF1BQQKVMTQRhM0JAyM2WoOBFkwigXNv/7vu/3/k4O
        HxdW8ET8JJ2ZMepUKRThz7nYEhwifdBzTCPrfyFD1Z7rOHIO5BPoccsYQCVPJ3HkvZYNUJd3
        EXpwNRo1jx7jor5rlzDUdKoQQw5nG4YK3T0ADd+1Yai5PxSVZVVwUFNzBwd1XT5OIHvlMA8d
        7nUR6HT7NIbcRRkYcnnTAbo4ZcfR+cdPOOhGvxjdft3ORVMTx4nNYrqrext9yTbAo28PXuDQ
        dVUhdNdNC1175hBB11X8RDf2pRF0eV4Rl87NGCXoZ8P9HPrJlbsEnVd/BtB1nfvp57WBdK33
        LyyW3JG8MZFRaRijhNGp9ZokXUIUtW17/Ifx4REyuVSuROspiU6lZaKomI9jpVuSUmaNoSSp
        qhTLrBSrMpmosE0bjXqLmZEk6k3mKIoxaFIMCsMak0prsugS1ugYc6RcJlsbPpv4dXJi3vgw
        MNSL9tlzCkEauLzUCvz4kFTAAvsgbgX+fCHZBOCrO93zZAzAUecRjCXjALpeTmILJZPTExw2
        0Axg8VgrlyWZGOzwXABWwOcTZCjsnOH79CVkGg5rGsuBj+BkBQ4dI0+5vlYBpBKWdQ/NYQ75
        PjzryCZ8WEBGwoLxwrlGkAyD+fcX+2Q/cgNsvN3KZVMWw45SL8eHcfI9mNFwbG5vSHr84K2G
        AYytjYEPO35ktw6Aj9rreSwWwT/zs+bxXugoriLY2oMA2nptgA1Ew0xPPu7rg5PBsPpyGCuv
        hEc85zF27iKYO+Wdd0UAXScWcBA8W32SYPFy2PMyfR7T8MnNXsCalQegx2rFC4DE9sY9tjfu
        sf0/+iTAzwARYzBpExh1uEEu1TF7/3tntV5bC+a+S0isCzhrXq9xA4wP3ADycWqJYNnEUY1Q
        oFF99z1j1McbLSmMyQ3CZw3/GRctVetn/5vOHC9XKGWKiIgIhXJdhJx6VzC49ZBGSCaozEwy
        wxgY40IdxvcTpWFlDaKZ1GSeqrf8s9/Lb+TmnLBetZJnd9d9mXWuovYAlU2lcoIt4gdBXEvc
        6j1xfs5Bc1GZI2PI9cGrd0bUzAmFfjpq/0frbKmXYtafcxxsFd9rJir7JaWSTx7+HSy4yg+q
        2emMu8J7K1JbTFM5Vdc2D10PHabWtu9aFQjGxwQxhcoB93FhZTp52m7/avAbqee3pWFVkQ47
        f98K5TKq1Foz1JpI/vC5MbbE8Kv0+Z57zz59++SqDRHRp3oOl9xq27rpn1/62r7wKAN45kqb
        eKc4c4U6cnp3S8mLgEe77si224V1lUcD+7TqEXfJjpVZ/vdXf4sfQBKxcOiP5V3PvN2dM1EU
        x5SokofgRpPqX9IKRJW3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSvK6V7uwUgyctghbrTx1jtlh9t5/N
        4vXhT4wW0z78ZLZ4cqCd0eLyEz6LB/vtLfa+m81qcfPATiaLPYsmMVmsXH2UyWLSoWuMFk+v
        zmKy2HtL22Jh2xIWiz17T7JYXN41h81i/rKn7Bbd13ewWSw//o/J4tDkZiaLHU8aGS22/Z7P
        bLHu9XsWixO3pC3O/z3OavH7xxw2B2mPy1e8PXbOusvucf7eRhaPzSu0PC6fLfXYtKqTzWPz
        knqP3Tcb2DwW901m9ehtfsfm8fHpLRaP9/uusnn0bVnF6LH5dLXH501yHpuevGUKEIjisklJ
        zcksSy3St0vgyuj79pSxYItUxfyOSYwNjLtEuxg5OSQETCR+/vvB0sXIxSEksJtR4tq1S+wQ
        CUmJZX+PMEPYwhIr/z1nhyhqZpK4e+sqkMPBwSagLXH6PwdIXESgi1mic+c7sEnMAtuYJT58
        +AI2SVjAUmLhlUesIDaLgKrEmpXtbCA2r4CVxIRvkxhBBkkI6Ev03xcECXMKWEvsPn+EFSQs
        BFTy/ngARLWgxMmZT1hAbGYBeYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFhgVFearle
        cWJucWleul5yfu4mRnDka2ntYNyz6oPeIUYmDsZDjBIczEoivGI/pqcI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnVwCT5bv3ug4VinW5rP7WddnaO0FBe
        WHRx2bsrulfDX2w+q/XVqdpcz0YkxIJ/ibeZcND5iBrxvmfymkzmLeJz3yyYVJaYz6Zo3CNu
        pSQ+f8OqhP87T0W2nPLU+7rpnu6N0trEhz+mFAcpVFvJmSp4hGXO//1R60XZoYfnNWsFXOS1
        DieIFtz957U1bU+N5wzHA4XRjvfTT6zfd+T6n2m6kyJO2Tt+qHxiEjb3r+gKP6uk4oP13yWM
        LiX1rTZPcIndaiw9oXWVl5Tkgbu81/OOqN65xNBR/i006xW3/qV95dXXJ5zz6g6f4nSb/dvP
        Bwm/pr5adl3llvHvU49M3wfc2+G1p1O9xvLMTmfmK3b3bimxFGckGmoxFxUnAgD68nK/awMA
        AA==
X-CMS-MailID: 20230627184058epcas5p2226835b15381b856859b162e58572d63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184058epcas5p2226835b15381b856859b162e58572d63
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184058epcas5p2226835b15381b856859b162e58572d63@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7d208b2b1a19..2d08a890d7e1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1862,6 +1862,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_copy(q);
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
+		     ti->type->iterate_devices(ti,
+			     device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1944,6 +1977,14 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_sectors_hw = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f0f118ab20fa..6245e16bf066 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1732,6 +1732,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+			max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+			ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..8ffee7e8cd06 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -396,6 +396,11 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/*
+	 * copy offload is supported
+	 */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

