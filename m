Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C770D4EDD54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiCaPgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiCaPgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D953227C76;
        Thu, 31 Mar 2022 08:32:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107AC61AEF;
        Thu, 31 Mar 2022 15:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D1FC340F3;
        Thu, 31 Mar 2022 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740732;
        bh=gUFRWbjHqjkSx4PNscQI4yP+SbU/eEVbRcFMkpkzrPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lta4Uz1IR2sKAhARQ+Ou28trHcFM22PvxGbLHaEmJWD+uJk+hYF7xNl8eazaDX66N
         QK+rKY0YDqqXYI8qwT4MA8pt49GOkMluehrkdFKkMcgexVAU7F3d/j7o2pleS4UAYu
         rFmVxK4VTaL8AoznxEnqWkgtz5SQeDx8q+CR9vbGumHouSYv3tMFyBBj3Aaba6gS9o
         azI/92jXH3V0IKaxdrBQRbcuNm8xmsEtjwnjhggA3mC7hM6u1clC9hDHM90QOAvVn+
         Gw4VXcvCL22OQ0d1lNuPvoasuBiN5lQQAVOz3N0P4u1qSxxARYa+ls8F//izmbSbgS
         pi+7Y0SaS8mzQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 44/54] libceph: allow ceph_osdc_new_request to accept a multi-op read
Date:   Thu, 31 Mar 2022 11:31:20 -0400
Message-Id: <20220331153130.41287-45-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 47d18e9821d4..cb199a3f3caf 100644
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

