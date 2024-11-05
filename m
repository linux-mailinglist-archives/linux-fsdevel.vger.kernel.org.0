Return-Path: <linux-fsdevel+bounces-33645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D08C9BC292
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 02:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F951C21FF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D791E1804A;
	Tue,  5 Nov 2024 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GG94bynq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDF8847C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Nov 2024 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770260; cv=none; b=kGsQBMhvyOtc0dK6bTsEtEwFi2Gf6h9VkjWXRvLj2Oo5CLvW8IBiKFB9WkRfEK01nBQCJYmfUaJ65lfuH6KSbvL55Ns499P0A1S3R0lT4Mj8QTKtr7j2CuQHyrz2+RPefB8BWKG3nPxQu/7oqqsGP/1gIaixQAeYmQJkql86Rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770260; c=relaxed/simple;
	bh=sCDROmFOVh7aicv5iSCF+yGA3OIKUFkblVGrRI4DIxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSuIHmQbLqvXq3JI9S3Msxs2O3eryKHekM0VRgoBzpMhBU3Uss5X2s2+oot5Pv5iaqHKi1YtEQOIRhDL9zo9yIyUlhLcr/llw8fbOi//tHQKI2iiw3t9l1G4NbqErdmCLQY5b5vu7EWi/qCT4kU7XpAKQCgAfcMk/rqlhgrjyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GG94bynq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UFdmOQllpjVb9JxQDWbi1eXpx0ZOuDf1XvB3m/AZOiU=; b=GG94bynqg9n1V2sVVqFQyCumGb
	8ktS/tY6nOJxV3pR947n7gqxY4xG57zZEygm/ygA8116ZlmbHuN25fZ9p6utL51reS1N42aIiymFC
	N8Jdimz7782lqkYbdj5s2Do89LlYM1GSIl+xCFX+Nx+n9oEFa0YTE4M4WmlAxdxXUrsUpbu/rezH1
	Iq1TQzBdb90AwWxk2gXnQDY0K2SxfubITlNZaa0su08A5FYeFs8vb8AAOBT1+0/lVYh4X5YWSFu+h
	gdtaeJJoczhu0+DDW73sbz8FtmCEJfZkcHLWMB36rTiRu7P+OGKAoVraJcTBXvvLCamPdemiF2zIt
	AL+OQt2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t88PJ-0000000FZW7-1bX1;
	Tue, 05 Nov 2024 01:30:57 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org,
	russ.weight@linux.dev,
	dakr@redhat.com
Cc: mcgrof@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests/firmware/fw_namespace.c: sanity check on initialization
Date: Mon,  4 Nov 2024 17:30:56 -0800
Message-ID: <20241105013056.3711427-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

From: Luis Chamberlain <mcgrof@kernel.org>

The fw_namespace.c test runs in a pretty self contained environment.
It can easily fail with false positive if the DUT does not have the
/lib/firmware directory created though, and CI tests will use minimal
guests which may not have the directory created. Although this can
be fixed by the test runners, it is also easy to just ensure the
directory is created by the test itself.

While at it, clarify that the test is expected to run in the same
namespace as the first process, this will save folks trying to debug
this test some time in terms of context. The mounted tmpfs later will
use the same init namespace for some temporary testing for this test.

Fixes: 901cff7cb9614 ("firmware_loader: load files from the mount namespace of init")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../testing/selftests/firmware/fw_namespace.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..9f4199a54a38 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -112,6 +112,40 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 	exit(EXIT_SUCCESS);
 }
 
+static void verify_init_ns(void)
+{
+    struct stat init_ns, self_ns;
+
+    if (stat("/proc/1/ns/mnt", &init_ns) != 0)
+        die("Failed to stat init mount namespace: %s\n",
+            strerror(errno));
+
+    if (stat("/proc/self/ns/mnt", &self_ns) != 0)
+        die("Failed to stat self mount namespace: %s\n",
+            strerror(errno));
+
+    if (init_ns.st_ino != self_ns.st_ino)
+        die("Test must run in init mount namespace\n");
+}
+
+static void ensure_firmware_dir(void)
+{
+    struct stat st;
+
+    if (stat("/lib/firmware", &st) == 0) {
+        if (!S_ISDIR(st.st_mode))
+            die("/lib/firmware exists but is not a directory\n");
+        return;
+    }
+
+    if (errno != ENOENT)
+        die("Failed to stat /lib/firmware: %s\n", strerror(errno));
+
+    if (mkdir("/lib/firmware", 0755) != 0)
+        die("Failed to create /lib/firmware directory: %s\n",
+            strerror(errno));
+}
+
 int main(int argc, char **argv)
 {
 	const char *fw_name = "test-firmware.bin";
@@ -119,6 +153,9 @@ int main(int argc, char **argv)
 	if (argc != 2)
 		die("usage: %s sys_path\n", argv[0]);
 
+	verify_init_ns();
+	ensure_firmware_dir();
+
 	/* Mount tmpfs to /lib/firmware so we don't have to assume
 	   that it is writable for us.*/
 	if (mount("test", "/lib/firmware", "tmpfs", 0, NULL) == -1)
-- 
2.43.0


