Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95363690E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbhDWLMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 07:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242202AbhDWLL7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 07:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10C4A6147D;
        Fri, 23 Apr 2021 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619176283;
        bh=pjE8XoiOHb5Zd3y1l4Lvg/af6r3WBqGSm9Jo4GLTJ5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ntm5KzXOvweW0nA5Pmhx95BukpLh6raZfy7sI7XVq4D5P7ZyvplgypIXAnrC2607l
         CJPgNRtH8u7fTVET4oQoxcjew9e2BAHU6pBb9Hp8lfekavpv8aSNPE5cSWLW5X4AgD
         I6hf2fBo37FH1a/Raa2a0//ulP3jdXeUz8jya8fF6xHc+sIRu83YRkNIjF2It3vOwF
         5w3e+8Z1IcAcci47VDkL0VjpYQCd5yTSNvzhG5940xRtxL2ZBfOanc1BYiW9LTi1gW
         U8DLs7GLdnmJFOxcPv5hVhcqzqOTjrf94+MXT5iCBmxdzBvpjKxxTy7aILe4AF57pq
         IETq4O/wlbKGQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] test: add openat2() test for invalid upper 32 bit flag value
Date:   Fri, 23 Apr 2021 13:10:37 +0200
Message-Id: <20210423111037.3590242-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210423111037.3590242-1-brauner@kernel.org>
References: <20210423111037.3590242-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=6+RcscGOaXAinCRHaVNgdgAhifNJThafX6rt6a5+G6o=; m=a8Z5yvitPlTc1wDJHiW3AeQQyNAKS1bSJsa+KhPte/o=; p=ymW6tJ+NdmQkM5kg4yHMHlm7HPu+GeA2wFqVftBEchM=; g=88fd5aea8882d7b88e7a2b461c74704af0e83345
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIKrKAAKCRCRxhvAZXjcovSRAQDIBi4 vk1mdK5u3SQ8DUyRWq/iyShGFb1tr65A7CrL5PwD+LR2RiZcOo7ehbDXzcKXDg42wmNm47lzoDJBf 8S3ybAA=
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
 tools/testing/selftests/openat2/openat2_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 381d874cce99..7379e082a994 100644
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
+		/* Invalid flags in the upper 32 bits must be rejected. */
+		{ .name = "invalid flags (1 << 63)",
+		  .how.flags = O_RDONLY | (1ULL << 63),
+		  .how.resolve = 0, .err = -EINVAL },
 	};
 
 	BUILD_BUG_ON(ARRAY_LEN(tests) != NUM_OPENAT2_FLAG_TESTS);
-- 
2.27.0

