Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6222DE52E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbgLROzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 09:55:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgLROzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:55:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqH9U-0006v9-3F; Fri, 18 Dec 2020 14:54:40 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/4] selftests/core: handle missing syscall number for close_range
Date:   Fri, 18 Dec 2020 15:54:13 +0100
Message-Id: <20201218145415.801063-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This improves the syscall number handling in the close_range()
selftests. This should handle any architecture.

Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 .../testing/selftests/core/close_range_test.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index c97dd1a7abd6..bc592a1372bb 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -17,7 +17,23 @@
 #include "../clone3/clone3_selftests.h"
 
 #ifndef __NR_close_range
-#define __NR_close_range -1
+	#if defined __alpha__
+		#define __NR_close_range 546
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_close_range (436 + 4000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_close_range (436 + 6000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_close_range (436 + 5000)
+		#endif
+	#elif defined __ia64__
+		#define __NR_close_range (436 + 1024)
+	#else
+		#define __NR_close_range 436
+	#endif
 #endif
 
 #ifndef CLOSE_RANGE_UNSHARE
-- 
2.29.2

