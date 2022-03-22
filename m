Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B234E40D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiCVOPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiCVOP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1073CA71;
        Tue, 22 Mar 2022 07:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFB6615BC;
        Tue, 22 Mar 2022 14:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C6C340EC;
        Tue, 22 Mar 2022 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958428;
        bh=GE1ZnX85Iy+ymqFAnhOo/aBTKjWtnGziTMzXZRUiQJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prQxvh3JUQ1INqa5NUso5P3ZIJmgOiV6fY6PpE3DaqppCwtBZGnfF8HEOMSgEODwF
         zvPlSt5AP5GN9Vt8/H+WuIvRFr1q8ov7WhC8R03SdUNinZmllPkqZiE4UMkdQEe26B
         GtbqV1gfgN9KXqTEMcIOSqlsjV8zsVk0uVrVRdQsQBXm1jjlBNj12ukOSDnNpuAKIC
         85kf31IGukxucGvTDUUPXHXiGJFHABqrfnUkzEHECu4gAXjz5rdCSTrtXxIVme8llh
         UzLbJ0a6PbjL5gXMdMNIritg9atv8PQ7l+gDdW/2KHElczdAoDGGmf/BipU0NJ60yd
         JoMqb/hOBdDhg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 31/51] libceph: add CEPH_OSD_OP_ASSERT_VER support
Date:   Tue, 22 Mar 2022 10:12:56 -0400
Message-Id: <20220322141316.41325-32-jlayton@kernel.org>
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

...and record the user_version in the reply in a new field in
ceph_osd_request, so we can populate the assert_ver appropriately.
Shuffle the fields a bit too so that the new field fits in an
existing hole on x86_64.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ceph/osd_client.h | 6 +++++-
 include/linux/ceph/rados.h      | 4 ++++
 net/ceph/osd_client.c           | 5 +++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index cf663423d51f..df092b678d58 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -196,6 +196,9 @@ struct ceph_osd_req_op {
 			u32 src_fadvise_flags;
 			struct ceph_osd_data osd_data;
 		} copy_from;
+		struct {
+			u64 ver;
+		} assert_ver;
 	};
 };
 
@@ -250,6 +253,7 @@ struct ceph_osd_request {
 	struct ceph_osd_client *r_osdc;
 	struct kref       r_kref;
 	bool              r_mempool;
+	bool		  r_linger;           /* don't resend on failure */
 	struct completion r_completion;       /* private to osd_client.c */
 	ceph_osdc_callback_t r_callback;
 
@@ -262,9 +266,9 @@ struct ceph_osd_request {
 	struct ceph_snap_context *r_snapc;    /* for writes */
 	struct timespec64 r_mtime;            /* ditto */
 	u64 r_data_offset;                    /* ditto */
-	bool r_linger;                        /* don't resend on failure */
 
 	/* internal */
+	u64 r_version;			      /* data version sent in reply */
 	unsigned long r_stamp;                /* jiffies, send or check time */
 	unsigned long r_start_stamp;          /* jiffies */
 	ktime_t r_start_latency;              /* ktime_t */
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 43a7a1573b51..73c3efbec36c 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -523,6 +523,10 @@ struct ceph_osd_op {
 		struct {
 			__le64 cookie;
 		} __attribute__ ((packed)) notify;
+		struct {
+			__le64 unused;
+			__le64 ver;
+		} __attribute__ ((packed)) assert_ver;
 		struct {
 			__le64 offset, length;
 			__le64 src_offset;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3e3a9d0aa74d..b67c56ddade7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1042,6 +1042,10 @@ static u32 osd_req_encode_op(struct ceph_osd_op *dst,
 		dst->copy_from.src_fadvise_flags =
 			cpu_to_le32(src->copy_from.src_fadvise_flags);
 		break;
+	case CEPH_OSD_OP_ASSERT_VER:
+		dst->assert_ver.unused = cpu_to_le64(0);
+		dst->assert_ver.ver = cpu_to_le64(src->assert_ver.ver);
+		break;
 	default:
 		pr_err("unsupported osd opcode %s\n",
 			ceph_osd_op_name(src->op));
@@ -3804,6 +3808,7 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 	 * one (type of) reply back.
 	 */
 	WARN_ON(!(m.flags & CEPH_OSD_FLAG_ONDISK));
+	req->r_version = m.user_version;
 	req->r_result = m.result ?: data_len;
 	finish_request(req);
 	mutex_unlock(&osd->lock);
-- 
2.35.1

