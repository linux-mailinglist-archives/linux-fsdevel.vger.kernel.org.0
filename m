Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B06393FEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhE1J2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 05:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbhE1J2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 05:28:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CFD5613BA;
        Fri, 28 May 2021 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622194016;
        bh=0k6g2gHE0dRV1ZrMbkEqahaJxKklXJYTVkqkk5RG7g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUZ87ZQHOtlyOiehdAaKuXZEIKctcrw7xWbx2k1mz/PMv8xLEg0D1iodbLiUdSCf4
         rOgW9pLq6bPyxfI5Qlzkh8Ff93dac+HT/AUc5OseacSOl9wv0IIjaUq9bIjDTmxOq1
         M8A9TjY9LMTAxfa7feTTD8f6EbrXUEgzyi73uvSY1QlOejg4JWJNvpydPZ3aAsOqIh
         SJJaLQzgsuTvsVLNH0OuKHylkQLDAG5oerEI1Mm+RmMCKnSMzaDGGc9SGWWLPzELXj
         D1EGtxJTe+KsCq2xurwHFvLRmLvKBibtpm48ryyzRGD+VKUlLzoDdVl9wIL+VyWehT
         Jowar5xHt3I6g==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 3/3] test: add openat2() test for invalid upper 32 bit flag value
Date:   Fri, 28 May 2021 11:24:17 +0200
Message-Id: <20210528092417.3942079-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528092417.3942079-1-brauner@kernel.org>
References: <20210528092417.3942079-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=6+RcscGOaXAinCRHaVNgdgAhifNJThafX6rt6a5+G6o=; m=a8Z5yvitPlTc1wDJHiW3AeQQyNAKS1bSJsa+KhPte/o=; p=6oO9ik0D/L1xvPW5nYylukIuVEyidZo07Ee0r+icx+U=; g=3474661330a38188012545f0e98d8ae92b615a50
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYLC2egAKCRCRxhvAZXjcogP8AP4tsXM w0OFYevZ+PE9bfIu535Ij1Ik+m+/Ogw8fkgA7lQD/fgPwHzOTt+xiKKsAfMlw7lh6zkR7wC/zZIBy 5CRDwwk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Test that openat2() rejects unknown flags in the upper 32 bit range.

Cc: Richard Guy Briggs <rgb@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Richard Guy Briggs <rgb@redhat.com>:
  - Rename test to clarify what it actually tests.
---
 tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 381d874cce99..d7ec1e7da0d0 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -155,7 +155,7 @@ struct flag_test {
 	int err;
 };
 
-#define NUM_OPENAT2_FLAG_TESTS 24
+#define NUM_OPENAT2_FLAG_TESTS 25
 
 void test_openat2_flags(void)
 {
@@ -229,6 +229,11 @@ void test_openat2_flags(void)
 		{ .name = "invalid how.resolve and O_PATH",
 		  .how.flags = O_PATH,
 		  .how.resolve = 0x1337, .err = -EINVAL },
+
+		/* currently unknown upper 32 bit rejected. */
+		{ .name = "currently unknown bit (1 << 63)",
+		  .how.flags = O_RDONLY | (1ULL << 63),
+		  .how.resolve = 0, .err = -EINVAL },
 	};
 
 	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
-- 
2.27.0

