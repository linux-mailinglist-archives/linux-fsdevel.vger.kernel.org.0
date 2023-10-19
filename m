Return-Path: <linux-fsdevel+bounces-747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717AA7CF826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F8BB21A10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D7225AE;
	Thu, 19 Oct 2023 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JDl4vw1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B7225A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:05:00 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66DF212B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:35 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019120422epoutp018c266eb20fa2721f9848f723ab801671~PgKxZOTMz2720827208epoutp01F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019120422epoutp018c266eb20fa2721f9848f723ab801671~PgKxZOTMz2720827208epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717062;
	bh=zohq6qFcyNQPlL9CW1gp72Nbdr99RwoaaLJ8/DxbinM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDl4vw1LaT2LyinfulQYW6csi/HhxvNaCruB4fMxU2JB9Sp2yqzg4uwWbwmmz3FOl
	 0Po/tS0qLhKvFyq/RjO7iraHxyGCobJbG4YWXzHmD+6bwNTtb1KGF8zjdKH/TFDL/0
	 Bs0Q/ifOnlEV5WeKSJfHbEp3Vi2B1Gpbp8DvzixM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120421epcas5p2ca9ad98c31f6d0eb8fdfe0d602c01635~PgKw7Ku2B1623216232epcas5p2p;
	Thu, 19 Oct 2023 12:04:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SB5x04FSzz4x9Py; Thu, 19 Oct
	2023 12:04:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.73.08567.44B11356; Thu, 19 Oct 2023 21:04:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231019110945epcas5p3760e2ce59477ab804b05248a54f107c9~PfbFu3DLz0645906459epcas5p3z;
	Thu, 19 Oct 2023 11:09:45 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110945epsmtrp2f0b61f4e94ea6e37abaf3e68083fd493~PfbFt7v-Q1629616296epsmtrp2s;
	Thu, 19 Oct 2023 11:09:45 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-54-65311b44fb8c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.17.18939.97E01356; Thu, 19 Oct 2023 20:09:45 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110941epsmtip1fbaf6e8874504f8fef365afa997ee3ce~PfbCS2Oja2755327553epsmtip1i;
	Thu, 19 Oct 2023 11:09:41 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 09/12] dm: Add support for copy offload
Date: Thu, 19 Oct 2023 16:31:37 +0530
Message-Id: <20231019110147.31672-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O+dwaEkgBwr6AZs2ZyEbMKAdUL+qbIsSPBv9wXQ/trmMdfSs
	rUBb2yJsiQGHwAbj4pA4CgoTNxTRTkBSLIymchlsQAiTmxZdAMdtMOSyS4Wttej897zP9zzv
	7cvLwX1y3QM4SpWe1aqkKTTpQTTfCg4Oiw0UsoJmUyAy9nbhaHnNTqArtmISzd96CNCUJQ+g
	6gvnCDRmacHQ5SudGPrKOgzQ9G0DhtrGQ9E3uRcJ1NrWQ6Chm5Ukqvpu2h0VjJhIVNu9iaHR
	kmmATFMnAWq2V+Ho2vwSgX4cD0QDG91ur+9gWgw2d2Zg4jrBDPWlMQ11X5BM48VMZqaxHDDm
	sSySqSkqdWMKsxdJZnl6nGCWfrhNMkVNdYBZadjJNEz9jiV4vZe8T8FKZayWz6qS1DKlSh5D
	xx9OPJAYLRIIw4RitJvmq6SpbAwdK0kIi1OmOOan+celKWkOKkGq09ERr+7TqtP0LF+h1ulj
	aFYjS9FEacJ10lRdmkoermL1e4QCwSvRDuGHyYrP+xdxTYd/Rv3kIJ4FHvjmAw4HUlFw7jqd
	Dzw4PpQZwNU+M+YKHgK4NtFOPg2GO3rxJ46r9c/lA66DbwHwjx6eS5ODwa6ODcKpIalQ+NO/
	HCfvS+XgsP3uAnAGODWGwb72Zszp5lF7YY29ws2JCSoIzpavk07s6eDryrq3ikXA4nveTprr
	oL8vuIC7JN6wp3yKcGKc2gWzb1TgzvyQquDC+skF0uWNhRPW3U4NpHhwrrvJ3YUD4MpiG+nC
	6fDymUuky3sKQMOIAbgeXoM5vcWPe8CpYGi8GeGin4dlvdcwV10vWGifwly8JzSdf4JfgPXG
	6q38/nD4z5Nb7TBwrmBrn0UALpXMkCWAb3hmHMMz4xj+r1wN8Drgz2p0qXI2KVojVLHpT784
	SZ3aAB4fREisCYxWbYZbAcYBVgA5OO3rGcQIWB9PmfSTT1mtOlGblsLqrCDase7TeIBfktpx
	USp9ojBKLIgSiURR4kiRkN7hOZ9zTuZDyaV6NpllNaz2iQ/jcAOysIKjh3oNf7UU3Vjttxjf
	Gn15PLJNbhTb/N9Y0t1fzz6yXgnfMZW28awV1X7udbYHf8fZznbGHfqNe/DbDz7y2n7Vu6+r
	JFovZixhHZVW5ZDRi2taHZGYm+x3WrMGuxdm6PXlsMlHyo8Lc2dfmpesUn4Zh5ODAs8M7a/J
	aF8bivBiEgYP8GL6FZv3cZFsM+TLnz9LrKj95+s4xYuxrZKsg5Hb7r1feYo80T9ruBNvt8ST
	ysa7e47S4jw8qTivwzw2vqto535bpqTUQ1z7Zujxjc6z2QPbQo4FmR7x5LFrOfHvZp5ozL/0
	S32/odCywDdvnz5Sdj7z170rErPk2NudGkVVOk3oFFJhCK7VSf8DGJSVg5kEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSnG4ln2GqwZK7MhbrTx1jtvj49TeL
	xeq7/WwWrw9/YrR4cqCd0WLBorksFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
	9p5ksbi8aw6bxfxlT9ktuq/vYLNYfvwfk8WNCU8ZLXY8aWS02PZ7PrPFutfvWSxO3JK2OP/3
	OKuDuMfOWXfZPc7f28jicflsqcemVZ1sHpuX1Hu82DyT0WP3zQY2j8V9k1k9epvfsXl8fHqL
	xeP9vqtsHn1bVjF6fN4k57HpyVumAL4oLpuU1JzMstQifbsEroyOc++YC45IVqx5fJG5gfGZ
	SBcjB4eEgInE2jUyXYxcHEIC2xklVrT0sXUxcgLFJSWW/T3CDGELS6z895wdoqiZSaLvfQcT
	SDObgLbE6f8cIHERgX5miXd/pzOBOMwCT5kkPv78xgjSLSxgLbH492xWEJtFQFXi5cxvYBt4
	geKrph5nhrhCX6L/viBImBMovKF7EdhiIQEriQcLHrNDlAtKnJz5hAXEZhaQl2jeOpt5AqPA
	LCSpWUhSCxiZVjGKphYU56bnJhcY6hUn5haX5qXrJefnbmIEx69W0A7GZev/6h1iZOJgPMQo
	wcGsJMKr6mGQKsSbklhZlVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp
	1cA0IeS2M/dbgwuNn6xZF6wyehPxxWLf7ZdnlE8/fa99OLSzalGIw63n03R52qMlIs6JMiz9
	8X3HpYXf0qQ1OF5pXmU8rPGu4Jnnpc27FLM2+oqtfbxsyu+XAoc8fVXuzbVuKOI7bv6Yt+r9
	hRs1lv7l6895OL46utpuPY+zysEC3RJRnycTpoR3ykdrvdtrfuNapc7uovAA2ayjbN5tX9ZK
	52lyuM63ubH2ZOjnqsMJVWGJvmxXtrd1mx2fq5McMTm6/9MW079yaz7fW/pdYekNTd0Y/dgW
	9gkzJqpeXKJpKz/FINPiiLDUVJ6/H09OuXu251NT2u+aqAd79k/ua/54ZpWxYMa0RS4rVxSt
	DJ01RYmlOCPRUIu5qDgRACRDesFOAwAA
X-CMS-MailID: 20231019110945epcas5p3760e2ce59477ab804b05248a54f107c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110945epcas5p3760e2ce59477ab804b05248a54f107c9
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110945epcas5p3760e2ce59477ab804b05248a54f107c9@epcas5p3.samsung.com>

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
index 37b48f63ae6a..8803c351624c 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1878,6 +1878,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
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
@@ -1960,6 +1992,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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
index 64a1f306c96c..eca336487d44 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1714,6 +1714,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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


