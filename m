Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD49635031
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiKWGOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiKWGNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:50 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F063AF2C26
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:47 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221123061346epoutp02e14915c4f10c5bee87cf8eb510d03794~qIgdBzVR81913519135epoutp02Y
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221123061346epoutp02e14915c4f10c5bee87cf8eb510d03794~qIgdBzVR81913519135epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184026;
        bh=SaeKrlDyh6fhEVghEF1v9Ec1Wl/S+jtnq86cAYk6FMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lzp5Z7USiJTRfYzEKWFPBCWra+bGxZoBDtQ6C2XrbSbBEpgH+tsMqKs2Ti3Fpl3Bq
         oS/te5lCcQ3LdXdAwLzrFUUwT2/cQAf0BXU+cbtT/Q2qwgIreA6nC+5JC3AUZxZlNa
         aO44iuBnPjq1lc0DFP5zOWgU2FBj5aLd6wcn3UZ0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221123061345epcas5p32825de06abfc15b772f3e9db9375f0d3~qIgcbof_M0072800728epcas5p3c;
        Wed, 23 Nov 2022 06:13:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NH9mm12ZWz4x9Q1; Wed, 23 Nov
        2022 06:13:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.60.39477.71ABD736; Wed, 23 Nov 2022 15:13:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221123061041epcas5p4413569a46ee730cd3033a9025c8f134a~qIdwfmK_k1387613876epcas5p4R;
        Wed, 23 Nov 2022 06:10:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123061041epsmtrp18e13c583f63f524392e30d1f5cc61af2~qIdweb_Fy1974919749epsmtrp1I;
        Wed, 23 Nov 2022 06:10:41 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-93-637dba17073c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.C2.18644.169BD736; Wed, 23 Nov 2022 15:10:41 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061037epsmtip1c482a1a6bc4b461f55d5956fc9d20346~qIdtgYz_41981819818epsmtip1j;
        Wed, 23 Nov 2022 06:10:37 +0000 (GMT)
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
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v5 09/10] dm kcopyd: use copy offload support
Date:   Wed, 23 Nov 2022 11:28:26 +0530
Message-Id: <20221123055827.26996-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOvbe9Lc6yS2XwAhNLFxJAgVYLe1EQtiG5m8tCsoQluqRr2ruW
        UdraluEcKkw+WiZUBw52MYLD4QRHJxQGxRIGCsiGbDOV2ciXw2Ww8DUIU5Gxlgub/573ec45
        zznnzeFi/CJOIDddY6T0GplaiG9htfaEh0UC+3G5aPx5aB3oxeAnZ1Yx2DBiweHK4BAGHbNV
        bHivqx2FVxpuorDj4gIKb67N4HBiycWCn3XfReBDJ41Ch2snvO64xYJ37OdxWF33kAPP9jWz
        YdtkHgJbV6oxuPhVPgc2/jnHgv2uIDi02sdO8ifpsUGcbKdHOOTQ6DUWeWcwi2yqN+Nk86WT
        ZMe9XJwsOTXrDigYY5NznU6cLLXVI+RiUzBZ1PUpSjZNzqCp3ocy4lWUTEHpBZRGrlWka5QJ
        woNvS1+TxsSKxJHiOPiyUKCRZVIJwuQ3UyNT0tXu8YWCD2XqLDeVKjMYhNH74/XaLCMlUGkN
        xgQhpVOodRJdlEGWacjSKKM0lHGvWCTaHeMOfC9D9aAiUWcRHM1z2tBcpCWwGPHiAkIC2juK
        sGJkC5dPdCBgwFzA9gh84i8EtFxQMMIiAhZ6avDNjM6RJygj2BHwgLZymEcBCqw1i6xihMvF
        iZ3ghzWuh/clSlFg6uha98CIKhTM1D3leEptIxJAy3UT6sEsIhSULny7bsEj9oHh06fZnkKA
        iAaWMR8P7eWmf/zZjjIhPuDWF5MsD8aIHeBUS9V6fUBUeQF7+RLGtJoMnI96OAzeBqb7bBs4
        EExZCjdwNrhS/jXOJOcjgB6mEUZIBAUDFszTBEaEA6s9mqG3g3MDjShj7A1KViZRhueBtgub
        +CVw1bq5rgBw9++8DUwC5/lcDrPfUgTcPi09gwjoZ+ahn5mH/t+5BsHqkQBKZ8hUUoYY3W4N
        lf3fJ8u1mU3I+kVEvNGGTIzPR3UjKBfpRgAXE/ryTr6eI+fzFLKPjlF6rVSfpaYM3UiMe99n
        scAX5Fr3SWmMUrEkTiSJjY2VxO2JFQv9ebWVEXI+oZQZqQyK0lH6zTyU6xWYi+IGxaB/fU9K
        il+jX+eqXTKSNuY7aA79Rf+7ZnZ+AY8yVe8vOtrvl5F97PYTe+3UcOX7ywf8KKskbGGrT+P0
        1qvehTd+06nIX8E3w6M3DoQpTCcevdtrumTrNU84g/NFOZXXziX8FNJg7Xtn7+euiv7lXWmu
        XRkVR9K6Lz/m7Qi3PJZfDJH9cegfUgk+eDrV3FobVCZ5sXLP9hap7svwj/lBCtV3kcvlFWn5
        fckwKf5wWUROk+2w3uholAaXFB5XcilRkklde+TV+/RbIwdda/Ro2bh23wnxc73m5lfKVr8P
        nU6le5yXHSXmacfSnK05D69pSLRMxGfOC6V1ATP3Q6RClkElE0dgeoPsX8rOOwiaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnG7iztpkg3+/2CzWnzrGbNE04S+z
        xeq7/WwWv8+eZ7bY+242q8XNAzuZLFauPspksXvhRyaLo//fslk8/HKLxWLSoWuMFk+vzmKy
        2HtL22LP3pMsFpd3zWGzmL/sKbvFxOObWS12PGlktNj2ez6zxeelLewW616/Z7E4cUva4vzf
        46wO4h6z7p9l89g56y67x/l7G1k8Lp8t9di0qpPNY/OSeo/dNxvYPHqb3wEVtN5n9Xi/7yqb
        R9+WVYwenzfJebQf6Gby2PTkLVMAXxSXTUpqTmZZapG+XQJXxqPp9gX9ChWNV7cwNTBulepi
        5OSQEDCR2Hf3F1MXIxeHkMAORokPTw8zQSQkJZb9PcIMYQtLrPz3nB2iqJlJYn3zEdYuRg4O
        NgFtidP/OUDiIgILmCQu33vFDOIwCyxlkph95S4bSLewgK3E1j0dYFNZBFQl+j5uAIvzClhL
        XO/pARskIaAv0X9fECTMCRQ+c3EXE0hYSMBKYs8yHYhqQYmTM5+wgNjMAvISzVtnM09gFJiF
        JDULSWoBI9MqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgKNbS2sG4Z9UHvUOMTByM
        hxglOJiVRHjrPWuShXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl
        4uCUamCaKZEc/lmw8aPhTY/S/88qjky+J3slqSjhIGu1lPTm46dS+SZK8gu0e/T/r1CcnFDj
        yTlXYMWpHV42iQ5erNl/vc1OTpizWEP08A0tY3bLRK5Nnj/P5Rh3JwHdlDQvw3L/gXvnn1Vm
        cract0j5f/bTiUnBv7eZycwNU2fdGrEpMe29Y8jMh2IFRlOVHcWOXypuNfzw6c/+L1Pe6T34
        9Xhfc/2zGsY3HxkaW83Z9Qyj1ITzhHnqTn+/k7rPui5H8tNG6atmezWE7n1nZE4OrQ6ITfqt
        pSsvxvR22S/vhqDbPZv6kkum6jBFJL1wFcvaGHpj7ttCxsyNUfUWYvfyo1Ly9rUwiJ6u33Kb
        JzVGiaU4I9FQi7moOBEAOVdKqlEDAAA=
X-CMS-MailID: 20221123061041epcas5p4413569a46ee730cd3033a9025c8f134a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061041epcas5p4413569a46ee730cd3033a9025c8f134a
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061041epcas5p4413569a46ee730cd3033a9025c8f134a@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

