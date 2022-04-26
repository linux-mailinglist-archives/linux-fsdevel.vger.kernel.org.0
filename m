Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78650FCB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349909AbiDZMT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350039AbiDZMTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:19:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BA01118;
        Tue, 26 Apr 2022 05:15:46 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220426121544epoutp023d4a47c7253b8e148e35e01c8dfca890~pcVQvJ7SA1189711897epoutp02T;
        Tue, 26 Apr 2022 12:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220426121544epoutp023d4a47c7253b8e148e35e01c8dfca890~pcVQvJ7SA1189711897epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975344;
        bh=WSP771IGNKVC6Bi5A3FA+JWtjotATxJ9HybAAr3/Z3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+rTlSTs3Vd01esw2G4KB65hbJSvXCzC7DXIdPRRhXZVweGNAqSFlG3m2afIntTL8
         WRB+Ebh41/zIlDeCObKovr1avKbAsRp6pnxbwUGc/jhyZuSZszb6LLuylGYo7i9dan
         9rpYqnoIP6AK/1+zpowSZdf8kN/fjNK+eYjTbTSM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220426121544epcas5p3e0af99d7a9b14fd41b06061a4f524197~pcVQIL9T80902809028epcas5p3f;
        Tue, 26 Apr 2022 12:15:44 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kngnm2lbGz4x9Pp; Tue, 26 Apr
        2022 12:15:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.33.10063.C62E7626; Tue, 26 Apr 2022 21:15:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220426102033epcas5p137171ff842e8b0a090d2708cfc0e3249~pawsPKyj51103811038epcas5p15;
        Tue, 26 Apr 2022 10:20:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426102033epsmtrp1dd5a60b96661707779518939e7adba16~pawsNt80p2263822638epsmtrp1c;
        Tue, 26 Apr 2022 10:20:33 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-00-6267e26ccb6c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.DA.08924.177C7626; Tue, 26 Apr 2022 19:20:33 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426102027epsmtip186cc016ae7c8201df031be9faf3b2758~pawm2aWcX1140711407epsmtip1g;
        Tue, 26 Apr 2022 10:20:27 +0000 (GMT)
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
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
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
Subject: [PATCH v4 09/10] dm kcopyd: use copy offload support
Date:   Tue, 26 Apr 2022 15:42:37 +0530
Message-Id: <20220426101241.30100-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUdRSe+9i7F2rxgpQ/oYZtHWxAXluAPwzKJqSb9gcOw6jNFF7guhCw
        u7OPQLMCiYcoEpQ7upCQEZvAQLDxfkyAiEAIRCDQ8FiFwdwEFCawBbZdLpT/fec75zvPOSTm
        MMJ3ImOlKlYhZeJFhC1e2+Hm7hl/TxLp8+2MAFb23MJg89gSD5ZN5BBQs/gUgwtt93kwL+cK
        H5r6+jE4NGMHW+bzeXBgNQWF96vNKBz7pQGFzdfzUHijrBOFc7rvEdj03WMUrhnE0LA8jsO8
        9hEEzg5rUdgyvg82t3TjcKixgICFJbN8eOFuPQFbjS0Y1HVtoPCOdo2AuV16HqyfSUFgrakQ
        gx2TwzisMC7g0LjaTcDb484w7eJTPuxf7+IddKWHfj9Ca6f6CDo3dZ5PN2gn+HT/ZBVOD/Wp
        6erS8wStL/6C/npUh9BNY8kEfe7XToy+8mSZoLNT5wm6IW2KRz+eHcfphdZhInTXB3GBMSwT
        zSqErDRKFh0rlQSJjoRFvBPh5+8j9hQHwP0ioZRJYINEwe+HeobExlu2KRJ+wsSrLVQoo1SK
        vN8MVMjUKlYYI1OqgkSsPDpe7iv3UjIJSrVU4iVlVQfEPj6v+VkCT8bF/DY3yJc/ECbld98j
        kpHzzlmIDQkoXzCbk4lnIbakA9WEALMpi88ZTxCQ988AxhlLCHh4uwbblmQPj6OcoxEBc5qS
        LSMNBef6UizJSJKg9oFeM2kVOFI4uLGyslkDo66SYP0vM8/q2EkFAUNLFWGNxylXUHnN1koL
        qDeAca1+Mw2gvEHOlL2VtrHQP3TOo1yIPei+OoNbMUa5gNSa/M1GAZVlC0zFeoTTBoMCA8v1
        vBM87PqZz2En8GdO+hZOBHXpRSin/RIBWT09OOd4Cww2r6PWPBjlBiobvTn6ZXC5pwLl6tqB
        bNMMyvECUH9tG+8B5ZVFBId3g5GVlC1MA0OGeWu7lxBQoTHgXyFC7TPzaJ+ZR/t/6SIEK0V2
        s3JlgoRV+snFUjbxvyNHyRKqkc0Hc3+vHpmYXvRqR1ASaUcAiYkcBZddT0U6CKKZ02dYhSxC
        oY5nle2In2XduZjTC1Eyy4dKVRFi3wAfX39/f9+A1/3Fol2CXslPjAMlYVRsHMvKWcW2DiVt
        nJLRsGBZSEb7weqK8YTMZXtmWlTp6J4QVHErwMZDfb6NydE8P3p4tiEucjpoR3RmeMD+heMe
        RonZPdao2ztZl+F91C7w0E3RSwayuNRG1+WiFu8VhLYFHnIzLJZ5lm98jtX9rffofG6VFX7U
        rpms1XffOUblvqgbXHIqb1wZ1I586sJEGK/XPNCmkM5nlktOa9KPfYZpX9GcBWF7dCOPmFDb
        0eiBhoIO18Rp28wfg0+0ne3I1LTm8y88itKnH1Z+6OrTv2rSF120af0G9la5uWGxRarkEzs+
        bgufDtaH3H03KRydP3DUYOg9JU5qSy/v2qgo7Dg58Xbo8clXeX/czDak+IlwZQwjdscUSuZf
        OL7eR+kEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTdxiHcz96vTbBHNXhF5DNNOl+IKII6juGzsiWXWaWkS1Z5pKtnvQo
        YltKDzbYzEQLf4CaThzqWlTmhggoBtRSJiUbWGuVClKrUINYhOBAqQgLOlqYlSzxv0+e58n7
        10sTsn2iGHqHLp836DiNnJKS1k756yvznOrtq4/1xcC5a1cIaOufEkHDgImCw0+eExD464EI
        KkxHxTDr7ibAM7wI7BMWEfQ824PDg+Z5HPr/bMWh7WQFDnUNDhxGa3/D4NKvkzgE/Ungn/aR
        UNFxG4MRrxkHu28FtNldJHj+qKLgxKkRMey7Y6OgfdxOQK1zDocb5iAFB53nRWAb3oOBdfYE
        AZ33vCQ0jgdIGH/mouCqLxZK9z8XQ3fIKdqkYD23trDmQTfFHjROiNlW84CY7b7XRLIedwHb
        XF9Gsed/380e6qvF2Ev9xRS7t8tBsEefTlPsAeMExbaWDorYyREfyQbavVTG0q+kaSpes+Nb
        3rBq4zZpdu/oTbH+4fJCi2uIKsbKYssxCY2YFHTA68PLMSktY2wY8g+FRAsiGp0KXSYW9mJU
        NzcqXoiMOAr0B18ImqaYFej6PB1uljAkqpuZIcMNwXTSaP+Fxy8PLWY2IL+9iQr3JKNA545L
        wziCeQ+NB21kGCNmFTINRoax5AWucUzgYSxjUlHfbOFCHYlcvwyT4U0wbyDjRQvxE8aYX1Hm
        V1Q1htdj0bxe0Kq1QpJ+jY7/LlHgtEKBTp2Ymattxl7+S3y8DWurf5LYgeE01oEhmpAviahU
        ZG2XRai4ou95Q67SUKDhhQ4sliblSyN6yl1KGaPm8vmdPK/nDf9bnJbEFOPk/YHjd3usVq8s
        mD6X9dambcBWbYaaI3FnVdmWssov1kXXarSjk6rXejWVqTmNTnXX5753L48Mfr0OlH3vBzz/
        /JBoTBeSqw7/nB53syjv0Fxx/Lw8WVJ+rPrMR8q8klu7Htotn1JpjxUBa1a1pIVO+FKTUERd
        6BxOc3OO5f/eYU5/8OORiqlpzzty3d/tky3JY28SWz5ryNVECyau5PTUWOsjtGvR3rXXSq9e
        DJXlzk+Rb5c0j93OaQx98/HufGdkVEFy3Mn1M2eVCam9zqFQ1saelsycMxtUm8dq/E97o7a2
        dF1xGGFl1NZPMt0Zs9x9U9P6ZRkp8rU+fRFdmPKhQk4K2VxSPGEQuP8AZHO9ap4DAAA=
X-CMS-MailID: 20220426102033epcas5p137171ff842e8b0a090d2708cfc0e3249
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426102033epcas5p137171ff842e8b0a090d2708cfc0e3249
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426102033epcas5p137171ff842e8b0a090d2708cfc0e3249@epcas5p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SelvaKumar S <selvakuma.s1@samsung.com>

Introduce copy_jobs to use copy-offload, if supported by underlying devices
otherwise fall back to existing method.

run_copy_jobs() calls block layer copy offload API, if both source and
destination request queue are same and support copy offload.
On successful completion, destination regions copied count is made zero,
failed regions are processed via existing method.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-kcopyd.c | 55 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 37b03ab7e5c9..214fadd6d71f 100644
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
@@ -579,6 +581,42 @@ static int run_io_job(struct kcopyd_job *job)
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
+		r = blkdev_issue_copy(job->source.bdev, 1, &range, job->dests[i].bdev, GFP_KERNEL);
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
@@ -659,6 +697,7 @@ static void do_work(struct work_struct *work)
 	spin_unlock_irq(&kc->job_lock);
 
 	blk_start_plug(&plug);
+	process_jobs(&kc->copy_jobs, kc, run_copy_job);
 	process_jobs(&kc->complete_jobs, kc, run_complete_job);
 	process_jobs(&kc->pages_jobs, kc, run_pages_job);
 	process_jobs(&kc->io_jobs, kc, run_io_job);
@@ -676,6 +715,8 @@ static void dispatch_job(struct kcopyd_job *job)
 	atomic_inc(&kc->nr_jobs);
 	if (unlikely(!job->source.count))
 		push(&kc->callback_jobs, job);
+	else if (job->source.bdev->bd_disk == job->dests[0].bdev->bd_disk)
+		push(&kc->copy_jobs, job);
 	else if (job->pages == &zero_page_list)
 		push(&kc->io_jobs, job);
 	else
@@ -916,6 +957,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 	spin_lock_init(&kc->job_lock);
 	INIT_LIST_HEAD(&kc->callback_jobs);
 	INIT_LIST_HEAD(&kc->complete_jobs);
+	INIT_LIST_HEAD(&kc->copy_jobs);
 	INIT_LIST_HEAD(&kc->io_jobs);
 	INIT_LIST_HEAD(&kc->pages_jobs);
 	kc->throttle = throttle;
@@ -971,6 +1013,7 @@ void dm_kcopyd_client_destroy(struct dm_kcopyd_client *kc)
 
 	BUG_ON(!list_empty(&kc->callback_jobs));
 	BUG_ON(!list_empty(&kc->complete_jobs));
+	WARN_ON(!list_empty(&kc->copy_jobs));
 	BUG_ON(!list_empty(&kc->io_jobs));
 	BUG_ON(!list_empty(&kc->pages_jobs));
 	destroy_workqueue(kc->kcopyd_wq);
-- 
2.35.1.500.gb896f729e2

