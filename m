Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5743202C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBTCCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 21:02:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:35056 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhBTCCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:31 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210220020148epoutp0335aad3fed55a041b64fc7f7e9b73031d~lUkeRMscu1468514685epoutp03s
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 02:01:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210220020148epoutp0335aad3fed55a041b64fc7f7e9b73031d~lUkeRMscu1468514685epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613786508;
        bh=RMGlT+b+xhqEcJeYfx7u7ifTzQXNK42RFfvFPpOCLFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFk2xTb/Rt0FJ6ZtSwM9ah/GRXa6WX4CJGwS/IGl5uzh9Y2Nf9rAaVDhja0RfZG+u
         A/Dr0XtClUulU1LPVLLy8oxb2QMZDYZ+muS7wlh7UAS0+b8vmBHWxkgV/WuB1qXPMS
         UTqWgyLjj3JLunNm6tKeF1jUYXfSSmzhaHg5udxk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210220020148epcas5p151a785b7b609b7f8a20fe6fc035514a7~lUkdppwM50602606026epcas5p1M;
        Sat, 20 Feb 2021 02:01:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.C4.15682.C8D60306; Sat, 20 Feb 2021 11:01:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210219124611epcas5p1c775b63b537e75da161556e375fcf05e~lJtz0JO_60207202072epcas5p1p;
        Fri, 19 Feb 2021 12:46:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210219124611epsmtrp23f2c2f78140d23a8056425889adeec3d~lJtzyneid0558405584epsmtrp2V;
        Fri, 19 Feb 2021 12:46:11 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-a4-60306d8c60b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.7A.13470.313BF206; Fri, 19 Feb 2021 21:46:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124609epsmtip2151dbf1ea005f7888f9954720b9d444a~lJtxRfto21677916779epsmtip25;
        Fri, 19 Feb 2021 12:46:09 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v5 4/4] dm kcopyd: add simple copy offload support
Date:   Fri, 19 Feb 2021 18:15:17 +0530
Message-Id: <20210219124517.79359-5-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmlm5PrkGCwbI/zBar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGWc/S1Y
        cEG+4u7sPywNjC1SXYycHBICJhLHXm5l7GLk4hAS2M0oMWPpWSjnE6PEi5bfjCBVQgLfGCW+
        XUyA6fjQ+RUqvpdRonlbNUTDZ0aJjj3HWUASbAK6EteWbAKzRQSUJP6ub2IBKWIWmMAs0Xt9
        LjNIQljATaL/Wz/YJBYBVYmDT44zgdi8ArYSa5tbWCG2yUvMvPSdHcTmFLCT2PbmGjNEjaDE
        yZlPwBYwA9U0b53NDLJAQuAGh8S209eZIJpdJA7uuc8IYQtLvDq+hR3ClpL4/G4vG4RdLvGs
        cxpUfQOjRN/7cgjbXuLinr9AcQ6gBZoS63fpQ4RlJaaeWscEsZdPovf3E6hWXokd856AlUsI
        qEmc2m4GEZaR+HB4F9QmD4k/3yYxQQJuIqPEtTV2ExgVZiH5ZhaSb2YhLF7AyLyKUTK1oDg3
        PbXYtMAwL7Vcrzgxt7g0L10vOT93EyM4IWp57mC8++CD3iFGJg7GQ4wSHMxKIrzbn+slCPGm
        JFZWpRblxxeV5qQWH2KU5mBREufdYfAgXkggPbEkNTs1tSC1CCbLxMEp1cDkHX5E4OO/ENNp
        a8327p/3dvmyDxw9dss2Tqtka9zeutnvnHCKgHDLNf9y5VPLJy54oTSd8SfzqQ8bdE/1v/1y
        ZcpOI5n2z/OtV8TK7/97br7QIU67WDtB9rUGGo+lf1V27j61Y8Zs/jeLwk9qzulJTvx8+OGt
        jUcfB1j+jugNW6bCu2BL08Lm6swDbka+Otf67/j43eW2eFptG7djqcDqutr514/5bfJlvJli
        4M5goa7jmXzlb3Umz48mmadHJwRweyi+W3trqs2bT4X9F8NN5Z52nsnafEApftHS3LarkS9j
        Wh59W5LF4FLzUroyQ37Bpc/TmbPvOUXELhB5t8Fi6vuzyc81l+U1PX/CnqeXosRSnJFoqMVc
        VJwIANk2cbf3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvK7wZv0Eg+f9Rhar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGWc/S1Y
        cEG+4u7sPywNjC1SXYycHBICJhIfOr8ygthCArsZJW5dNoKIy0isvdvJBmELS6z895wdouYj
        o8SN+Z4gNpuArsS1JZtYQGwRASWJv+ubwGxmgWXMEo9mKoLYwgJuEv3f+sHmswioShx8cpwJ
        xOYVsJVY29zCCjFfXmLmpe9g8zkF7CS2vbnGDLHLVuLD92lsEPWCEidnPoGaLy/RvHU28wRG
        gVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOOi3NHYzbV33QO8TI
        xMF4iFGCg1lJhHf7c70EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQW
        wWSZODilGpgiuZYYzzfntTKXfXPnqAxXoc9+ro/btq7uV567Xk/hRbeTpkTdN9EDlQuOf99/
        1/avamhk6Snz80+s7fK/p3sfLFTlsvD1dyoOsrpSevf53siHfx9lBh1NMaqYstr1V1qmjLWO
        WWoY9yntA5vO98/5rvH31r4nT97ernvAv/qzgNDFhE1dUor7hVnW32d7ZnkrueJQd4KG+7UT
        28LmyVg9vb65Y0FTzutnBebPbi6QtDMWyWe5IlO1h+Ex65LfUup35n7+w6bU5rL4149tryaa
        vpr++/HR37fP/J2iuPz8VOYPa8riJpc1hP++suX6X+ZrWy/v073UaTz3gXDdlMiJmWkLqh6K
        88/1OCPZWj6tQImlOCPRUIu5qDgRADXe98IpAwAA
X-CMS-MailID: 20210219124611epcas5p1c775b63b537e75da161556e375fcf05e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210219124611epcas5p1c775b63b537e75da161556e375fcf05e
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
        <CGME20210219124611epcas5p1c775b63b537e75da161556e375fcf05e@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce copy_jobs to use copy-offload if it is natively
supported (by underlying device) or else fall back to original method.

run_copy_jobs() calls block layer copy offload api with
BLKDEV_COPY_NOEMULATION. On successful completion, if only one destination
device was present, then jobs is queued for completion. If multiple
destinations were present, the completed destination is zeroed and
pushed to pages_jobs to process copy offload for other destinations. In
case of copy_offload failure, remaining destinations are processed via
regular copying mechanism.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
---
 drivers/md/dm-kcopyd.c | 49 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 1bbe4a34ef4c..2442c4870e97 100644
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
@@ -581,6 +583,36 @@ static int run_io_job(struct kcopyd_job *job)
 	return r;
 }
 
+static int run_copy_job(struct kcopyd_job *job)
+{
+	int r, i, count = 0;
+	unsigned long flags = 0;
+	struct range_entry srange;
+
+	flags |= BLKDEV_COPY_NOEMULATION;
+	for (i = 0; i < job->num_dests; i++) {
+		srange.src = job->source.sector;
+		srange.len = job->source.count;
+
+		r = blkdev_issue_copy(job->source.bdev, 1, &srange,
+			job->dests[i].bdev, job->dests[i].sector, GFP_KERNEL, flags);
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
@@ -662,6 +694,7 @@ static void do_work(struct work_struct *work)
 	spin_unlock_irqrestore(&kc->job_lock, flags);
 
 	blk_start_plug(&plug);
+	process_jobs(&kc->copy_jobs, kc, run_copy_job);
 	process_jobs(&kc->complete_jobs, kc, run_complete_job);
 	process_jobs(&kc->pages_jobs, kc, run_pages_job);
 	process_jobs(&kc->io_jobs, kc, run_io_job);
@@ -679,6 +712,8 @@ static void dispatch_job(struct kcopyd_job *job)
 	atomic_inc(&kc->nr_jobs);
 	if (unlikely(!job->source.count))
 		push(&kc->callback_jobs, job);
+	else if (job->source.bdev->bd_disk == job->dests[0].bdev->bd_disk)
+		push(&kc->copy_jobs, job);
 	else if (job->pages == &zero_page_list)
 		push(&kc->io_jobs, job);
 	else
@@ -919,6 +954,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 	spin_lock_init(&kc->job_lock);
 	INIT_LIST_HEAD(&kc->callback_jobs);
 	INIT_LIST_HEAD(&kc->complete_jobs);
+	INIT_LIST_HEAD(&kc->copy_jobs);
 	INIT_LIST_HEAD(&kc->io_jobs);
 	INIT_LIST_HEAD(&kc->pages_jobs);
 	kc->throttle = throttle;
@@ -974,6 +1010,7 @@ void dm_kcopyd_client_destroy(struct dm_kcopyd_client *kc)
 
 	BUG_ON(!list_empty(&kc->callback_jobs));
 	BUG_ON(!list_empty(&kc->complete_jobs));
+	BUG_ON(!list_empty(&kc->copy_jobs));
 	BUG_ON(!list_empty(&kc->io_jobs));
 	BUG_ON(!list_empty(&kc->pages_jobs));
 	destroy_workqueue(kc->kcopyd_wq);
-- 
2.25.1

