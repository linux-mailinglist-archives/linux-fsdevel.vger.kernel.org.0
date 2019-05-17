Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58321D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfEQShW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:22 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57602 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729364AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000ns-FH; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH 03/22] uapi linux/coda_psdev.h: move upc_req definition from uapi to kernel side headers
Date:   Fri, 17 May 2019 14:36:41 -0400
Message-Id: <9f99f5ce6a0563d5266e6cf7aa9585aac2cae971.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mikko Rapeli <mikko.rapeli@iki.fi>

Only users of upc_req in kernel side fs/coda/psdev.c and fs/coda/upcall.c
already include linux/coda_psdev.h.

Suggested by Jan Harkes <jaharkes@cs.cmu.edu> on lkml message
<20150531111913.GA23377@cs.cmu.edu>.

Fixes these include/uapi/linux/coda_psdev.h compilation errors in userspace:

./linux/coda_psdev.h:12:19: error: field ‘uc_chain’ has incomplete type
  struct list_head    uc_chain;
                   ^
./linux/coda_psdev.h:13:2: error: unknown type name ‘caddr_t’
  caddr_t             uc_data;
  ^
./linux/coda_psdev.h:14:2: error: unknown type name ‘u_short’
  u_short             uc_flags;
  ^
./linux/coda_psdev.h:15:2: error: unknown type name ‘u_short’
  u_short             uc_inSize;  /* Size is at most 5000 bytes */
  ^
./linux/coda_psdev.h:16:2: error: unknown type name ‘u_short’
  u_short             uc_outSize;
  ^
./linux/coda_psdev.h:17:2: error: unknown type name ‘u_short’
  u_short             uc_opcode;  /* copied from data to save lookup */
  ^
./linux/coda_psdev.h:19:2: error: unknown type name ‘wait_queue_head_t’
  wait_queue_head_t   uc_sleep;   /* process' wait queue */
  ^

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: coda@cs.cmu.edu
Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 include/linux/coda_psdev.h      | 11 +++++++++++
 include/uapi/linux/coda_psdev.h | 13 -------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 15170954aa2b..57d2b2faf6a3 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -19,6 +19,17 @@ struct venus_comm {
 	struct mutex	    vc_mutex;
 };
 
+/* messages between coda filesystem in kernel and Venus */
+struct upc_req {
+	struct list_head	uc_chain;
+	caddr_t			uc_data;
+	u_short			uc_flags;
+	u_short			uc_inSize;  /* Size is at most 5000 bytes */
+	u_short			uc_outSize;
+	u_short			uc_opcode;  /* copied from data to save lookup */
+	int			uc_unique;
+	wait_queue_head_t	uc_sleep;   /* process' wait queue */
+};
 
 static inline struct venus_comm *coda_vcp(struct super_block *sb)
 {
diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
index aa6623efd2dd..d50d51a57fe4 100644
--- a/include/uapi/linux/coda_psdev.h
+++ b/include/uapi/linux/coda_psdev.h
@@ -7,19 +7,6 @@
 #define CODA_PSDEV_MAJOR 67
 #define MAX_CODADEVS  5	   /* how many do we allow */
 
-
-/* messages between coda filesystem in kernel and Venus */
-struct upc_req {
-	struct list_head    uc_chain;
-	caddr_t	            uc_data;
-	u_short	            uc_flags;
-	u_short             uc_inSize;  /* Size is at most 5000 bytes */
-	u_short	            uc_outSize;
-	u_short	            uc_opcode;  /* copied from data to save lookup */
-	int		    uc_unique;
-	wait_queue_head_t   uc_sleep;   /* process' wait queue */
-};
-
 #define CODA_REQ_ASYNC  0x1
 #define CODA_REQ_READ   0x2
 #define CODA_REQ_WRITE  0x4
-- 
2.20.1

