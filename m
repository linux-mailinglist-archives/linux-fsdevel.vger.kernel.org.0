Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8229539AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiFABMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiFABMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:12:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643AD15FE7
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:57 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKcwEQ028601
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=TpziWEpW3IfDujaL3QArtHCzgYKE3+ynSFIUCWk+0cM=;
 b=Z1I0+Bw0w4igkfpyFFIls319QJmXK/BYtvP3kkczn8GCzP448K3QLvHKzSwz8RRVzJq/
 UIoHw43dlGb/T8gzO+Frol96YtXKVrZ+n0vbiDEWJ0/KPce2X4BMzhZXBEji48MRHG2o
 8foBvW5m/gOhyPNSGmu5hidCZUMfxveBsXA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gdt5jhbrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:56 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 18:11:56 -0700
Received: by devbig003.nao1.facebook.com (Postfix, from userid 8731)
        id 32DC94AA431D; Tue, 31 May 2022 18:11:51 -0700 (PDT)
From:   Chris Mason <clm@fb.com>
To:     <djwong@kernel.org>, <hch@infradead.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <hannes@cmpxchg.org>
Subject: [PATCH RFC] iomap: invalidate pages past eof in iomap_do_writepage()
Date:   Tue, 31 May 2022 18:11:17 -0700
Message-ID: <20220601011116.495988-1-clm@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7dE4orUwEHLnD96Aye-Zv3tIpIi9vABV
X-Proofpoint-ORIG-GUID: 7dE4orUwEHLnD96Aye-Zv3tIpIi9vABV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_08,2022-05-30_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_do_writepage() sends pages past i_size through
folio_redirty_for_writepage(), which normally isn't a problem because
truncate and friends clean them very quickly.

When the system a variety of cgroups, we can end up in situations where
one cgroup has almost no dirty pages at all.  This is especially common
in our XFS workloads in production because they tend to use O_DIRECT for
everything.

We've hit storms where the redirty path hits millions of times in a few
seconds, on all a single file that's only ~40 pages long.  This ends up
leading to long tail latencies for file writes because the page reclaim
workers are hogging the CPU from some kworkers bound to the same CPU.

That's the theory anyway.  We know the storms exist, but the tail
latencies are so sporadic that it's hard to have any certainty about the
cause without patching a large number of boxes.

There are a few different problems here.  First is just that I don't
understand how invalidating the page instead of redirtying might upset
the rest of the iomap/xfs world.  Btrfs invalidates in this case, which
seems like the right thing to me, but we all have slightly different
sharp corners in the truncate path so I thought I'd ask for comments.

Second is the VM should take wbc->pages_skipped into account, or use
some other way to avoid looping over and over.  I think we actually want
both but I wanted to understand the page invalidation path first.

Signed-off-by: Chris Mason <clm@fb.com>
Reported-by: Domas Mituzas <domas@fb.com>
---
 fs/iomap/buffered-io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8ce8720093b9..4a687a2a9ed9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1482,10 +1482,8 @@ iomap_do_writepage(struct page *page, struct write=
back_control *wbc, void *data)
 		pgoff_t end_index =3D isize >> PAGE_SHIFT;
=20
 		/*
-		 * Skip the page if it's fully outside i_size, e.g. due to a
-		 * truncate operation that's in progress. We must redirty the
-		 * page so that reclaim stops reclaiming it. Otherwise
-		 * iomap_vm_releasepage() is called on it and gets confused.
+		 * invalidate the page if it's fully outside i_size, e.g.
+		 * due to a truncate operation that's in progress.
 		 *
 		 * Note that the end_index is unsigned long.  If the given
 		 * offset is greater than 16TB on a 32-bit system then if we
@@ -1499,8 +1497,10 @@ iomap_do_writepage(struct page *page, struct write=
back_control *wbc, void *data)
 		 * offset is just equal to the EOF.
 		 */
 		if (folio->index > end_index ||
-		    (folio->index =3D=3D end_index && poff =3D=3D 0))
-			goto redirty;
+		    (folio->index =3D=3D end_index && poff =3D=3D 0)) {
+			folio_invalidate(folio, 0, folio_size(folio));
+			goto unlock;
+		}
=20
 		/*
 		 * The page straddles i_size.  It must be zeroed out on each
@@ -1518,6 +1518,7 @@ iomap_do_writepage(struct page *page, struct writeb=
ack_control *wbc, void *data)
=20
 redirty:
 	folio_redirty_for_writepage(wbc, folio);
+unlock:
 	folio_unlock(folio);
 	return 0;
 }
--=20
2.30.2

