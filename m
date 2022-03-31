Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DAE4EDD16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiCaPf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiCaPeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD62261E3;
        Thu, 31 Mar 2022 08:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B24B82011;
        Thu, 31 Mar 2022 15:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B989FC36AE2;
        Thu, 31 Mar 2022 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740716;
        bh=VuAetinbMIJ3jeBAT3F1PDyYDvpSu4GO847Nw/6AauI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4MWJvh6ds+IrKlFMGmHD7v+FLhl3vXLqjMm859lh+jU+4K7Q+cSb93a+OKPGuv/0
         nfN+GQBgNbmcFRSqc6hTaliUm8Pdf4/u5aZcQoigU8b9K7F+AV4tJz/d79+sYqldNx
         ZAk/Xnrx5KrcDtFPpdASDQTAAulcMj1aI3vcZOfuyxwtyFXQCA76zsKw6frbJwgPDA
         jcuyK2lDIbIkbspoXwsa7S79NR3Lx/kO/OfCUiEpyDoL0mYW0hF/mXpprsZen3iQJ/
         5ML+gpyb4sog5jPiRpBB1/ZDwNsxdJm6FlqykMR7wYlJWPKBXDhfeaCnGZOsKnYrZy
         kKabbAcV/7oOg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 26/54] ceph: pass the request to parse_reply_info_readdir()
Date:   Thu, 31 Mar 2022 11:31:02 -0400
Message-Id: <20220331153130.41287-27-jlayton@kernel.org>
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

From: Xiubo Li <xiubli@redhat.com>

Instead of passing just the r_reply_info to the readdir reply parser,
pass the request pointer directly instead. This will facilitate
implementing readdir on fscrypted directories.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 750a67643850..0a7f18d4df73 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -406,9 +406,10 @@ static int parse_reply_info_trace(void **p, void *end,
  * parse readdir results
  */
 static int parse_reply_info_readdir(void **p, void *end,
-				struct ceph_mds_reply_info_parsed *info,
-				u64 features)
+				    struct ceph_mds_request *req,
+				    u64 features)
 {
+	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	u32 num, i = 0;
 	int err;
 
@@ -650,15 +651,16 @@ static int parse_reply_info_getvxattr(void **p, void *end,
  * parse extra results
  */
 static int parse_reply_info_extra(void **p, void *end,
-				  struct ceph_mds_reply_info_parsed *info,
+				  struct ceph_mds_request *req,
 				  u64 features, struct ceph_mds_session *s)
 {
+	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	u32 op = le32_to_cpu(info->head->op);
 
 	if (op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
 	else if (op == CEPH_MDS_OP_READDIR || op == CEPH_MDS_OP_LSSNAP)
-		return parse_reply_info_readdir(p, end, info, features);
+		return parse_reply_info_readdir(p, end, req, features);
 	else if (op == CEPH_MDS_OP_CREATE)
 		return parse_reply_info_create(p, end, info, features, s);
 	else if (op == CEPH_MDS_OP_GETVXATTR)
@@ -671,9 +673,9 @@ static int parse_reply_info_extra(void **p, void *end,
  * parse entire mds reply
  */
 static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
-			    struct ceph_mds_reply_info_parsed *info,
-			    u64 features)
+			    struct ceph_mds_request *req, u64 features)
 {
+	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	void *p, *end;
 	u32 len;
 	int err;
@@ -695,7 +697,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
 		ceph_decode_need(&p, end, len, bad);
-		err = parse_reply_info_extra(&p, p+len, info, features, s);
+		err = parse_reply_info_extra(&p, p+len, req, features, s);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -3440,14 +3442,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	}
 
 	dout("handle_reply tid %lld result %d\n", tid, result);
-	rinfo = &req->r_reply_info;
 	if (test_bit(CEPHFS_FEATURE_REPLY_ENCODING, &session->s_features))
-		err = parse_reply_info(session, msg, rinfo, (u64)-1);
+		err = parse_reply_info(session, msg, req, (u64)-1);
 	else
-		err = parse_reply_info(session, msg, rinfo, session->s_con.peer_features);
+		err = parse_reply_info(session, msg, req, session->s_con.peer_features);
 	mutex_unlock(&mdsc->mutex);
 
 	/* Must find target inode outside of mutexes to avoid deadlocks */
+	rinfo = &req->r_reply_info;
 	if ((err >= 0) && rinfo->head->is_target) {
 		struct inode *in = xchg(&req->r_new_inode, NULL);
 		struct ceph_vino tvino = {
-- 
2.35.1

