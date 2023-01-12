Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2213667365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjALNjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjALNic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:38:32 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA550F64
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:41 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230112133740epoutp02cd362d4838bf78b281fc9c5fc21c3994~5k0TDbtd12559025590epoutp02X
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230112133740epoutp02cd362d4838bf78b281fc9c5fc21c3994~5k0TDbtd12559025590epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530660;
        bh=SaeKrlDyh6fhEVghEF1v9Ec1Wl/S+jtnq86cAYk6FMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmlp4lo/qYbxQ3eDquSUj4HE4Nj9KWRjg2i3Mp4jxcXp6pcH7USVZR6rypqRnt+2b
         S7oVonTKwUsC03gkzxIoQpRjLiWrWGAC2x9MEX8yZofRdGHM5UpvNwi8aguYkefJmP
         GkkxQQ/WPoEg1ItvEKp7dAUrMBvPi/sgNcg2bMiw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230112133739epcas5p206af3cc1f5dec226c2cbae46ae12620e~5k0SefRfj0471004710epcas5p2i;
        Thu, 12 Jan 2023 13:37:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Nt5Fs5pj2z4x9Pq; Thu, 12 Jan
        2023 13:37:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.E4.02301.12D00C36; Thu, 12 Jan 2023 22:37:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230112120229epcas5p38a07a42302d823422960eb11de5d685b~5jhMvmI8a1350713507epcas5p3t;
        Thu, 12 Jan 2023 12:02:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230112120229epsmtrp219acd6ff30d1e478e4572c00456c771e~5jhMuw5Oq3008330083epsmtrp2_;
        Thu, 12 Jan 2023 12:02:29 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-43-63c00d213f98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.C5.02211.5D6FFB36; Thu, 12 Jan 2023 21:02:29 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120226epsmtip266a12aa2937ea1ba7ca4953b1e3b4fa2~5jhKEUpPU0963109631epsmtip2M;
        Thu, 12 Jan 2023 12:02:26 +0000 (GMT)
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
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 9/9] dm kcopyd: use copy offload support
Date:   Thu, 12 Jan 2023 17:29:03 +0530
Message-Id: <20230112115908.23662-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+4tlwuh5g5QD8hYd5kxQHh0K/WgPFzc5p0Yg5uJijN4Uy7P
        0tY+RDQGGCObwCgwJqGQAjoXBtuACoRXHdTgWAeyhDcbK0xIEMd7Ax1ObCno/vuez/l+z/n9
        zoPEXRcJTzJJpuaUMlZKE868lp99fQP287skwZeG/VG9+RccnS58iqO6SS2BjIvlDmi8qw1D
        V+p6MNRRvYKhnq0FAhWbRgCaHdZhyDjhjzqNt3hosL2CQJWXZx1R60wWQC2blTha++GMI7r+
        xxIP9U68hAae3nR4w53RWfoJpk036cgM3G/kMYP9GsZQ+w3B/Hgpg+kYzySY89mLBLP00zDB
        FDTVAmbN4M0YZhawaJeYlLBEjo3jlAJOJpHHJckSwumok7FvxoaIg4UBwlD0Ki2QsalcOH3k
        neiAY0lSa5u04HNWqrGiaFalooMiwpRyjZoTJMpV6nCaU8RJFSJFoIpNVWlkCYEyTv2aMDj4
        YIjV+GlK4oPSSIVW8EXWcBOWCZo9c4ETCSkRzK/Id8gFzqQr1QHgXfNDwj5YBTCv4KKjzeVK
        rQNYnyfdTfT9Po3bTUYATRf0mH2QjUFLTxbIBSRJUP7w9hZpC7hT9zDYdtvH5sGpcgz2Lkw7
        2CbcqNfhSm0JbvPzqJfh8pDIhvlWfG+jcBtDKghqLXts2MmKr4494tkte+CtspltjVP7YHZz
        +XY9kNoiYWnRn8Be6BHYPfiro127wfmbTTvaE64tGgm7ToNXSmoIe/gMgLpR3U44EuaYtdtF
        4JQvrG8PsuO98KL5Ombf+Dl4fnMGs3M+bNXvah94tb5qZ30POLKRtaMZ2Jxj2jmrAgD7Govx
        QiDQPdOQ7pmGdP9vXQXwWuDBKVSpCZwqRCGUcWn/3bFEnmoA2w/f73grmJxaDjQBjAQmAEmc
        dud39tyQuPLj2PQvOaU8VqmRcioTCLGedxHu+bxEbv05MnWsUBQaLBKLxaLQQ2Ih/SKfa66U
        uFIJrJpL4TgFp9zNYaSTZyZ2+ISPU0NxUMfExr7kqPS2d/vP9unnvPMP5H5oiDk4F/9VUP7H
        5s/WD3nVTN09ER/xfcMHQzUb1zTSZu/W44ed9Y80tZUe42elob8ZrmVEhbj5BY4UTLxdHOFg
        UXJLf82Jk13MOXUyL+n8WFnJnZG0o4kNYZalU7zqbwdWohrPVffNeL8/9512Svk3+8r8Ucle
        nvLG+uon5odFl++IQEuVU5+ih9Dv73qv0r9ic3Y0vltS/Hg05QXG5Yn/cnvnWoxwone1/f5H
        3ckB8sKTB9K8pocynS1p/R7aDN4pTS5/rKjfg27Xnk5vGBoulUSiwa/PSR8/iDMa/tFTF8re
        2nyiq4/Mo3mqRFbohytV7L8w+CsmgQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvO7Vb/uTDa7MkLRYf+oYs0XThL/M
        Fqvv9rNZ7H03m9Xi5oGdTBYrVx9lsti98COTxdH/b9ksJh26xmjx9OosJou9t7Qt9uw9yWJx
        edccNov5y56yW+x40shose33fGaLz0tb2C3WvX7PYnHilrTF+b/HWR1EPGbdP8vmsXPWXXaP
        8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB59Da/Y/N4v+8qm0ffllWMHp83yXlsevKWKYAnissm
        JTUnsyy1SN8ugSvj0XT7gn6FisarW5gaGLdKdTFyckgImEicefmQuYuRi0NIYDejxPN715kg
        EpISy/4eYYawhSVW/nvODlHUyCQx92k7YxcjBwebgLbE6f8cIHERgWdMEmfvPQKbxCywlEli
        wb5GVpBuYQFriY+rpjCDNLAIqEp8uGICEuYFCt/5PgEsLCGgL9F/XxAkzAkUXnPjCwuILSRg
        JTFrz1UmiHJBiZMzn4DFmQXkJZq3zmaewCgwC0lqFpLUAkamVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwTGppbmDcfuqD3qHGJk4GA8xSnAwK4nw7jm6P1mINyWxsiq1KD++qDQn
        tfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpqTXS/ZdDtjwomRrgceVivAQM++J
        P3hF9F6UX6rJFTCq6pC+8VaWuzS4w7R06g9GK8MnYiX/GFZPdpyb4hNZFjkzPIxny80Hskd7
        Dr2fb8c5jTUsdkqWy7qz1vdDebboMV93v7qmIjCgbFrveZ8Tf6tinxYvUdtQ2NJ03v/8yVr2
        w0ePXda+s5F/15aGLh+35rebZBSbtHX7RAXaKr03Lw82WeAyM27Fj22rC2LqHXRUfwsLTbvi
        5pU54671m5XHVMRf1hie5JmyMupRQPfG953nvq7/OPfK0hkf78+Z+G/DzIfr9ieJxd26M8l8
        IZvmComQ3DgVrz+b1u/48WTtEqeyd4Ihf/7c4JrLk5r+jFWJpTgj0VCLuag4EQA/0NL8OAMA
        AA==
X-CMS-MailID: 20230112120229epcas5p38a07a42302d823422960eb11de5d685b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120229epcas5p38a07a42302d823422960eb11de5d685b
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120229epcas5p38a07a42302d823422960eb11de5d685b@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce copy_jobs to use copy-offload, if supported by underlying devices
otherwise fall back to existing method.

run_copy_jobs() calls block layer copy offload API, if both source and
destination request queue are same and support copy offload.
On successful completion, destination regions copied count is made zero,
failed regions are processed via existing method.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/md/dm-kcopyd.c | 56 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 4d3bbbea2e9a..2f9985f671ac 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -74,18 +74,20 @@ struct dm_kcopyd_client {
 	atomic_t nr_jobs;
 
 /*
- * We maintain four lists of jobs:
+ * We maintain five lists of jobs:
  *
- * i)   jobs waiting for pages
- * ii)  jobs that have pages, and are waiting for the io to be issued.
- * iii) jobs that don't need to do any IO and just run a callback
- * iv) jobs that have completed.
+ * i)	jobs waiting to try copy offload
+ * ii)   jobs waiting for pages
+ * iii)  jobs that have pages, and are waiting for the io to be issued.
+ * iv) jobs that don't need to do any IO and just run a callback
+ * v) jobs that have completed.
  *
- * All four of these are protected by job_lock.
+ * All five of these are protected by job_lock.
  */
 	spinlock_t job_lock;
 	struct list_head callback_jobs;
 	struct list_head complete_jobs;
+	struct list_head copy_jobs;
 	struct list_head io_jobs;
 	struct list_head pages_jobs;
 };
@@ -579,6 +581,43 @@ static int run_io_job(struct kcopyd_job *job)
 	return r;
 }
 
+static int run_copy_job(struct kcopyd_job *job)
+{
+	int r, i, count = 0;
+	struct range_entry range;
+
+	struct request_queue *src_q, *dest_q;
+
+	for (i = 0; i < job->num_dests; i++) {
+		range.dst = job->dests[i].sector << SECTOR_SHIFT;
+		range.src = job->source.sector << SECTOR_SHIFT;
+		range.len = job->source.count << SECTOR_SHIFT;
+
+		src_q = bdev_get_queue(job->source.bdev);
+		dest_q = bdev_get_queue(job->dests[i].bdev);
+
+		if (src_q != dest_q || !blk_queue_copy(src_q))
+			break;
+
+		r = blkdev_issue_copy(job->source.bdev, job->dests[i].bdev,
+				&range, 1, NULL, NULL, GFP_KERNEL);
+		if (r)
+			break;
+
+		job->dests[i].count = 0;
+		count++;
+	}
+
+	if (count == job->num_dests) {
+		push(&job->kc->complete_jobs, job);
+	} else {
+		push(&job->kc->pages_jobs, job);
+		r = 0;
+	}
+
+	return r;
+}
+
 static int run_pages_job(struct kcopyd_job *job)
 {
 	int r;
@@ -659,6 +698,7 @@ static void do_work(struct work_struct *work)
 	spin_unlock_irq(&kc->job_lock);
 
 	blk_start_plug(&plug);
+	process_jobs(&kc->copy_jobs, kc, run_copy_job);
 	process_jobs(&kc->complete_jobs, kc, run_complete_job);
 	process_jobs(&kc->pages_jobs, kc, run_pages_job);
 	process_jobs(&kc->io_jobs, kc, run_io_job);
@@ -676,6 +716,8 @@ static void dispatch_job(struct kcopyd_job *job)
 	atomic_inc(&kc->nr_jobs);
 	if (unlikely(!job->source.count))
 		push(&kc->callback_jobs, job);
+	else if (job->source.bdev->bd_disk == job->dests[0].bdev->bd_disk)
+		push(&kc->copy_jobs, job);
 	else if (job->pages == &zero_page_list)
 		push(&kc->io_jobs, job);
 	else
@@ -916,6 +958,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 	spin_lock_init(&kc->job_lock);
 	INIT_LIST_HEAD(&kc->callback_jobs);
 	INIT_LIST_HEAD(&kc->complete_jobs);
+	INIT_LIST_HEAD(&kc->copy_jobs);
 	INIT_LIST_HEAD(&kc->io_jobs);
 	INIT_LIST_HEAD(&kc->pages_jobs);
 	kc->throttle = throttle;
@@ -971,6 +1014,7 @@ void dm_kcopyd_client_destroy(struct dm_kcopyd_client *kc)
 
 	BUG_ON(!list_empty(&kc->callback_jobs));
 	BUG_ON(!list_empty(&kc->complete_jobs));
+	WARN_ON(!list_empty(&kc->copy_jobs));
 	BUG_ON(!list_empty(&kc->io_jobs));
 	BUG_ON(!list_empty(&kc->pages_jobs));
 	destroy_workqueue(kc->kcopyd_wq);
-- 
2.35.1.500.gb896f729e2

