Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE42DE52D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLROzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 09:55:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgLROzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:55:21 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kqH9T-0006v9-Iu; Fri, 18 Dec 2020 14:54:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/4] selftests/core: fix close_range_test build after XFAIL removal
Date:   Fri, 18 Dec 2020 15:54:12 +0100
Message-Id: <20201218145415.801063-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/linux-fsdevel/20201217213303.722643-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tobias Klauser <tklauser@distanz.ch>

XFAIL was removed in commit 9847d24af95c ("selftests/harness: Refactor
XFAIL into SKIP") and its use in close_range_test was already replaced
by commit 1d44d0dd61b6 ("selftests: core: use SKIP instead of XFAIL in
close_range_test.c"). However, commit 23afeaeff3d9 ("selftests: core:
add tests for CLOSE_RANGE_CLOEXEC") introduced usage of XFAIL in
TEST(close_range_cloexec). Use SKIP there as well.

Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 23afeaeff3d9 ("selftests: core: add tests for CLOSE_RANGE_CLOEXEC")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/20201218112428.13662-1-tklauser@distanz.ch
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/core/close_range_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 9625d2f2188a..c97dd1a7abd6 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -241,7 +241,7 @@ TEST(close_range_cloexec)
 		fd = open("/dev/null", O_RDONLY);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -250,9 +250,9 @@ TEST(close_range_cloexec)
 	ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
 	if (ret < 0) {
 		if (errno == ENOSYS)
-			XFAIL(return, "close_range() syscall not supported");
+			SKIP(return, "close_range() syscall not supported");
 		if (errno == EINVAL)
-			XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
 	}
 
 	/* Ensure the FD_CLOEXEC bit is set also with a resource limit in place.  */
-- 
2.29.2

