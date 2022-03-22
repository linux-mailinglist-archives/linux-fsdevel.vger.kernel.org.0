Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B684E4078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiCVOQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbiCVOPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4CB6B;
        Tue, 22 Mar 2022 07:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42645B81D07;
        Tue, 22 Mar 2022 14:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E503C340EE;
        Tue, 22 Mar 2022 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958437;
        bh=TFpslucr0MvoQQPC3IwpQcVR+/+2Tk10A5LMcyCYzX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yte3rpwSe7jJQr8qVXO7JxNoibm2rZUQXJAbWVM+R0poPaXwAjprY0B6BJ1m9KJNt
         +CFAWqJdgzUdx4muKgDvS5pWddtwy54+piEjWwqaITlvjXLipkQbLJBaYZMFUW/7jf
         ZLQYphoVT3CctnIaabGhx7MvqIvLwo0H4f8rGLYsSj5auu2y+cbWkwMAJTO8Uz9Atn
         EtlT8sFSdO8maB0xOQY3G21+X0qbU9cC7BEoXQKMjOL13SXVd/3M4NWXHKWoBuhLz2
         k6I2Kx1e4kTSbpOUO7gG3dh3zWSjc46WuWpyIR3wOw3Coe4MlV5EiRt87rLcfGh3Oe
         dL4+XI72r8X9g==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 41/51] libceph: allow ceph_osdc_new_request to accept a multi-op read
Date:   Tue, 22 Mar 2022 10:13:06 -0400
Message-Id: <20220322141316.41325-42-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we have some special-casing for multi-op writes, but in the
case of a read, we can't really handle it. All of the current multi-op
callers call it with CEPH_OSD_FLAG_WRITE set.

Have ceph_osdc_new_request check for CEPH_OSD_FLAG_READ and if it's set,
allocate multiple reply ops instead of multiple request ops. If neither
flag is set, return -EINVAL.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/ceph/osd_client.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b67c56ddade7..5df1450cd30f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1130,15 +1130,30 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 	if (flags & CEPH_OSD_FLAG_WRITE)
 		req->r_data_offset = off;
 
-	if (num_ops > 1)
+	if (num_ops > 1) {
+		int num_req_ops, num_rep_ops;
+
 		/*
-		 * This is a special case for ceph_writepages_start(), but it
-		 * also covers ceph_uninline_data().  If more multi-op request
-		 * use cases emerge, we will need a separate helper.
+		 * If this is a multi-op write request, assume that we'll need
+		 * request ops. If it's a multi-op read then assume we'll need
+		 * reply ops. Anything else and call it -EINVAL.
 		 */
-		r = __ceph_osdc_alloc_messages(req, GFP_NOFS, num_ops, 0);
-	else
+		if (flags & CEPH_OSD_FLAG_WRITE) {
+			num_req_ops = num_ops;
+			num_rep_ops = 0;
+		} else if (flags & CEPH_OSD_FLAG_READ) {
+			num_req_ops = 0;
+			num_rep_ops = num_ops;
+		} else {
+			r = -EINVAL;
+			goto fail;
+		}
+
+		r = __ceph_osdc_alloc_messages(req, GFP_NOFS, num_req_ops,
+					       num_rep_ops);
+	} else {
 		r = ceph_osdc_alloc_messages(req, GFP_NOFS);
+	}
 	if (r)
 		goto fail;
 
-- 
2.35.1

