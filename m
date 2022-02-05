Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCA4AAA60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 18:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380535AbiBEREy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 12:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380519AbiBEREy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:04:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAB4C061348;
        Sat,  5 Feb 2022 09:04:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C90C5B80B0F;
        Sat,  5 Feb 2022 17:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F92C340ED;
        Sat,  5 Feb 2022 17:04:50 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/7] NFSD: Fix offset type in I/O trace points
Date:   Sat,  5 Feb 2022 12:04:49 -0500
Message-Id:  <164408068923.3707.10673224104877827331.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.35.0
In-Reply-To:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
References:  <164408013367.3707.1739092698555505020.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; h=from:subject:message-id; bh=kOvp2gyNzLt2NM6Eqtt34OIlG/FKm/CYAEE71D+71MM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh/q4xOBmUCF0roANFEY7wLQsUPHPLJa5PmS9sX1No X7kfaaaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYf6uMQAKCRAzarMzb2Z/l1vpEA CMT2pi2Vj18oem5IyUwTujQB3HOGmVYgc7XJKAiu02G0WquNIKTbgG12TuTn9KMMxCiIL6fR38Vtit kU/thF6tHeevZJPQWfxe1DXIWBQTnJUBoLfBEOJ+xZLeoDbkblHVoj/ENj02rKDaLz3UBsGHVUj6wq GB/BwARr+lZxaL+f3R+Bmt0yiFSBQg+HJjUiVgxb6yDDBtso6d3Vf5E41r0ftf7efe5/UEd3qwF3mE q9y3TETUSIigE9uuEZ5AoxwAVJDiMjKfBbQo4bzkg2rLBw1eLqWvdu+SzqL954hPoOYU8d0eQ1cHUX kcJTzAZUYfXzHGoFzc6m2XPWlqvB3OoWQkSwhZUtZxMdRrcNBAPj4579NAtgZ71PYouOd4UnvTQIX0 lIXZf3drml1VAu4OSXSy5/E7TxntzQDp/BXqX0DHtaKyQl6kTEpRH3xORAm7SPYTvAtcRDv7XF1xq7 ThjQR54k3X0YVpqN3oDP1lcF+F0RGdEI+vZiUOs17rn5qi8dWWEewTjq7/DsT9oOso63E+3zH8CRrk ewxxGIYoko+fTGSZhl12Ng7SzqKHvCQstPYLQypNBj7YZRyx0nd1gWdqmdqnvKBdvl7M3cP9XLoaqk xW9TNYo8kC+8vsHrzBVt+hBfofKwOfDfzKn9ePiVegH4Oa0ACisTrX3gT1ew==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NFSv3 and NFSv4 use u64 offset values on the wire. Record these values
verbatim without the implicit type case to loff_t.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c4cf56327843..5889db66409d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -306,14 +306,14 @@ TRACE_EVENT(nfsd_export_update,
 DECLARE_EVENT_CLASS(nfsd_io_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
-		 loff_t		offset,
-		 unsigned long	len),
+		 u64		offset,
+		 u32		len),
 	TP_ARGS(rqstp, fhp, offset, len),
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(u32, fh_hash)
-		__field(loff_t, offset)
-		__field(unsigned long, len)
+		__field(u64, offset)
+		__field(u32, len)
 	),
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
@@ -321,7 +321,7 @@ DECLARE_EVENT_CLASS(nfsd_io_class,
 		__entry->offset = offset;
 		__entry->len = len;
 	),
-	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%lld len=%lu",
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u",
 		  __entry->xid, __entry->fh_hash,
 		  __entry->offset, __entry->len)
 )
@@ -330,8 +330,8 @@ DECLARE_EVENT_CLASS(nfsd_io_class,
 DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
 	TP_PROTO(struct svc_rqst *rqstp,	\
 		 struct svc_fh	*fhp,		\
-		 loff_t		offset,		\
-		 unsigned long	len),		\
+		 u64		offset,		\
+		 u32		len),		\
 	TP_ARGS(rqstp, fhp, offset, len))
 
 DEFINE_NFSD_IO_EVENT(read_start);

