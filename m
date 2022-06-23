Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C517355884A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiFWTCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiFWTCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:02:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D867A19E
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 11:08:16 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25NHup69020497
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 11:08:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+IYV+ohWMnP9Z2WqVp2E+CnW9cqqI1fK3UacqUP+NEU=;
 b=A7gR5Xw2SOdP/LhUFKnTV5QpJ4jfbl81LezZhYpt5cGZi0n3B5/q0zVgMKm6Mc7Qjn4H
 DbdOyKNIUkfTWsh0KoxMZZBB7IsZtGD1eEfEEY6cCnsJylDhKS6Lp+Vw+uGV+UsknpJZ
 cORUIQehKoaQ/xU3BhIBsi2gbhJ+88DQo3s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gvce7wk0g-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 11:08:15 -0700
Received: from twshared1457.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 23 Jun 2022 11:08:14 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 53F3710C5DC48; Thu, 23 Jun 2022 10:52:00 -0700 (PDT)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <shr@fb.com>, <david@fromorbit.com>, <jack@suse.cz>,
        <hch@infradead.org>, <axboe@kernel.dk>, <willy@infradead.org>
Subject: [RESEND PATCH v9 01/14] mm: Move starting of background writeback into the main balancing loop
Date:   Thu, 23 Jun 2022 10:51:44 -0700
Message-ID: <20220623175157.1715274-2-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623175157.1715274-1-shr@fb.com>
References: <20220623175157.1715274-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4txqgqxkIdXnv9ld9o5xqIUWW_aGlitY
X-Proofpoint-ORIG-GUID: 4txqgqxkIdXnv9ld9o5xqIUWW_aGlitY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-23_07,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

We start background writeback if we are over background threshold after
exiting the main loop in balance_dirty_pages(). This may result in
basing the decision on already stale values (we may have slept for
significant amount of time) and it is also inconvenient for refactoring
needed for async dirty throttling. Move the check into the main waiting
loop.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Stefan Roesch <shr@fb.com>
---
 mm/page-writeback.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 55c2776ae699..e59c523aed1a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1627,6 +1627,19 @@ static void balance_dirty_pages(struct bdi_writeba=
ck *wb,
 			}
 		}
=20
+		/*
+		 * In laptop mode, we wait until hitting the higher threshold
+		 * before starting background writeout, and then write out all
+		 * the way down to the lower threshold.  So slow writers cause
+		 * minimal disk activity.
+		 *
+		 * In normal mode, we start background writeout at the lower
+		 * background_thresh, to keep the amount of dirty memory low.
+		 */
+		if (!laptop_mode && nr_reclaimable > gdtc->bg_thresh &&
+		    !writeback_in_progress(wb))
+			wb_start_background_writeback(wb);
+
 		/*
 		 * Throttle it only when the background writeback cannot
 		 * catch-up. This avoids (excessively) small writeouts
@@ -1657,6 +1670,7 @@ static void balance_dirty_pages(struct bdi_writebac=
k *wb,
 			break;
 		}
=20
+		/* Start writeback even when in laptop mode */
 		if (unlikely(!writeback_in_progress(wb)))
 			wb_start_background_writeback(wb);
=20
@@ -1823,23 +1837,6 @@ static void balance_dirty_pages(struct bdi_writeba=
ck *wb,
=20
 	if (!dirty_exceeded && wb->dirty_exceeded)
 		wb->dirty_exceeded =3D 0;
-
-	if (writeback_in_progress(wb))
-		return;
-
-	/*
-	 * In laptop mode, we wait until hitting the higher threshold before
-	 * starting background writeout, and then write out all the way down
-	 * to the lower threshold.  So slow writers cause minimal disk activity=
.
-	 *
-	 * In normal mode, we start background writeout at the lower
-	 * background_thresh, to keep the amount of dirty memory low.
-	 */
-	if (laptop_mode)
-		return;
-
-	if (nr_reclaimable > gdtc->bg_thresh)
-		wb_start_background_writeback(wb);
 }
=20
 static DEFINE_PER_CPU(int, bdp_ratelimits);
--=20
2.30.2

