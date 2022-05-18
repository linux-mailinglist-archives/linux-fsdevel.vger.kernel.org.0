Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435C52BEB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiERPLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 11:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiERPLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 11:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031EE26C9;
        Wed, 18 May 2022 08:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 935C26198B;
        Wed, 18 May 2022 15:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771A2C385A5;
        Wed, 18 May 2022 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652886676;
        bh=dkf7GEao8AI86nB58euIIl4y2hwL/HMgAhrL7Jqi2PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koja2v5EfPv5p8uYwa2nV3BWflBJjkS3mdnxieoyw3NN3tW3uy/W/wmasPSj3G30s
         ajmU8C/CZamVATA9MmWousMT9I3DBTagpsTaq3Qi8LENMhxOT+me4G3pxDOlpTH5SQ
         w4GbT+Yu2yoo124FKiTK9laWV1sqrgXhpaapV8lpCwx1NpwGySKF/PHvAhU0Jq7fPC
         RxOxKp1po61jGXUNGkCYXrEPRihckbDfxs/XnV1wmnkrOKWKozQFnr7IVWc8ttrLiJ
         Aew1xHDRpq5908e46d3N1yyxyaaVVXGftrU73bTQhaaZdfraSiF34+vrkLDqIfGZj1
         6QIHVolLCZp+g==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        xiubli@redhat.com, idryomov@gmail.com
Subject: [PATCH 3/4] ceph: enhance dout messages in issue_read codepaths
Date:   Wed, 18 May 2022 11:11:10 -0400
Message-Id: <20220518151111.79735-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518151111.79735-1-jlayton@kernel.org>
References: <20220518151111.79735-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/addr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d14a9378d120..475df4efd2c7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -190,6 +190,8 @@ static bool ceph_netfs_clamp_length(struct netfs_io_subrequest *subreq)
 	/* Truncate the extent at the end of the current block */
 	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
 				      &objno, &objoff, &xlen);
+	dout("%s: subreq->len=0x%zx xlen=0x%x rsize=0x%x",
+		__func__, subreq->len, xlen, fsc->mount_options->rsize);
 	subreq->len = min(xlen, fsc->mount_options->rsize);
 	return true;
 }
@@ -304,7 +306,9 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		goto out;
 	}
 
-	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
+	dout("%s: pos=%llu orig_len=%zu len=%llu debug_id=%x debug_idx=%hx iter->count=%zx\n",
+		__func__, subreq->start, subreq->len, len, rreq->debug_id,
+		subreq->debug_index, iov_iter_count(&subreq->iter));
 
 	err = iov_iter_get_pages_alloc(&subreq->iter, &pages, len, &page_off);
 	if (err < 0) {
-- 
2.36.1

