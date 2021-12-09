Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAD46EBC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbhLIPlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:41:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbhLIPko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46810B82504;
        Thu,  9 Dec 2021 15:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342DC341C3;
        Thu,  9 Dec 2021 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064229;
        bh=CJSzdTbJRQtaj6nqHH0ZH8qn9akYqk4WHhusRggPi4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AefoCUWqg9tmfFAaOthzX7aZRYJCXG46ug6d22jL1AuELo83M6LzN+dQpJTQKHeuQ
         kFJfyVOKJdoWsxY6FtH8C4QOCAm+WHuLD3M//HPY3YBB2hq1kPUCQVaiXfY08pH4Rl
         Wbtwmi7uVwsXoKQv/u88yNCFIqJh7OSBMCmI+NFu/vCtUAHKjx2dfmgBjpAhhdSe7G
         DEGgYzlNb3701JWSVEAUel4akL5wZue27SStw32cD0ouELwC68Pl5OxL7kXqmtYKJV
         YCvLre05p3tS0sdOUZvoRpsQY/Rlg52znPOEfI+Uhp8OMwtggzOWjGdmSRqdkJVJq1
         GxmUCCdRFQO7Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 28/36] libceph: add CEPH_OSD_OP_ASSERT_VER support
Date:   Thu,  9 Dec 2021 10:36:39 -0500
Message-Id: <20211209153647.58953-29-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 3431011f364d..90ee000b0124 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -145,6 +145,9 @@ struct ceph_osd_req_op {
 			u32 src_fadvise_flags;
 			struct ceph_osd_data osd_data;
 		} copy_from;
+		struct {
+			u64 ver;
+		} assert_ver;
 	};
 };
 
@@ -199,6 +202,7 @@ struct ceph_osd_request {
 	struct ceph_osd_client *r_osdc;
 	struct kref       r_kref;
 	bool              r_mempool;
+	bool		  r_linger;           /* don't resend on failure */
 	struct completion r_completion;       /* private to osd_client.c */
 	ceph_osdc_callback_t r_callback;
 
@@ -211,9 +215,9 @@ struct ceph_osd_request {
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
index 1c5815530e0d..8a9416e4893d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1038,6 +1038,10 @@ static u32 osd_req_encode_op(struct ceph_osd_op *dst,
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
@@ -3763,6 +3767,7 @@ static void handle_reply(struct ceph_osd *osd, struct ceph_msg *msg)
 	 * one (type of) reply back.
 	 */
 	WARN_ON(!(m.flags & CEPH_OSD_FLAG_ONDISK));
+	req->r_version = m.user_version;
 	req->r_result = m.result ?: data_len;
 	finish_request(req);
 	mutex_unlock(&osd->lock);
-- 
2.33.1

