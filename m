Return-Path: <linux-fsdevel+bounces-51466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E058AD71F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10DB3AF3E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B3255F3C;
	Thu, 12 Jun 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWDRfOMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE5255E23
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734740; cv=none; b=T/Wkmo8DhKX7gzcWtEvZ42thnBOAjnajmwOXRtuuvGB6saZzeIPKB5gqCZRCHVqrSqlyxhw41mMNlk/axx8PZ5wAhVbzTvBFxisiqu6KUhZ46XmpTgtORVMfcQhBUJ0yo52bm+7CAPPprkX06c+3A7/kYOSTyiD8/Qy+ArelDfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734740; c=relaxed/simple;
	bh=NKwfKo1+MqVc28rCYNr62HGH1qV0jeEKHHXYRyYsZUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdfhyWHEn+TlyOKt+qTubD6O5hdAwKsWNrJlf5O51y4hG5OQ5H3ZA8+6sirHr8TnAg+2luauu8d+SRI0be4HpgFG3AjR8/oVCwDn9eyF3TnRjbg89+R3aOeJwMpZUxHDoO0kOE6MevMYGB45fZ4wv2ie5HcHQDkCXnqSr2k4oeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWDRfOMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB0C4CEF1;
	Thu, 12 Jun 2025 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734740;
	bh=NKwfKo1+MqVc28rCYNr62HGH1qV0jeEKHHXYRyYsZUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YWDRfOMyIEPcDSl/cjalhpZANTOnwDfiHKz63DmlKAhtH1i5egdU8z6MAUbcbMr+2
	 NzDfTiDuCHNhVahXP4Dg806OuCq281hbC/cEwfjkg6F92yB3la8UFzJvjAnz9NWL8M
	 sTM/ur7pNRtmDxDBJ4HxI5f7nfzvQAsQNga0RNWwYi5+z3Fgc6AJ/V2K2Dw/9+B2xs
	 i6SvHYWKTcWWKI7F/l07AKyMFpT6qTFkxoejlL3s3PnEjmh4ONQYnptAa8FOa0oiaP
	 PFGpO8Zy9GEv3Yg8TTOCauw6+3EXbP2ZEpTku2Tqc1wxlKqZ9VQouSns0qDvmgAMGI
	 QnK2t3GgMdeIw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:19 +0200
Subject: [PATCH 05/24] fs: move name_contains_dotdot() to header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-5-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NKwfKo1+MqVc28rCYNr62HGH1qV0jeEKHHXYRyYsZUM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXUzuc3C2xx9d+VUlswrse9YpALjM/vbZ9i+2jV/L
 X+yNP+njlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsTGBkmLnk8/HyGPYwsUlx
 c4UUS/T9P85X2aincGdnfpMp1wrd1YwMl+5yypU2rVmgqFtSPH17/Yr7UuvE9HLn/k2zXBS1YKI
 /AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move the helper from the firmware specific code to a header so we can
reuse it for coredump sockets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c | 31 +++++++++++--------------------
 include/linux/fs.h                  | 16 ++++++++++++++++
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 44486b2c7172..6942c62fa59d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -822,26 +822,6 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name,
 {}
 #endif
 
-/*
- * Reject firmware file names with ".." path components.
- * There are drivers that construct firmware file names from device-supplied
- * strings, and we don't want some device to be able to tell us "I would like to
- * be sent my firmware from ../../../etc/shadow, please".
- *
- * Search for ".." surrounded by either '/' or start/end of string.
- *
- * This intentionally only looks at the firmware name, not at the firmware base
- * directory or at symlink contents.
- */
-static bool name_contains_dotdot(const char *name)
-{
-	size_t name_len = strlen(name);
-
-	return strcmp(name, "..") == 0 || strncmp(name, "../", 3) == 0 ||
-	       strstr(name, "/../") != NULL ||
-	       (name_len >= 3 && strcmp(name+name_len-3, "/..") == 0);
-}
-
 /* called from request_firmware() and request_firmware_work_func() */
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
@@ -862,6 +842,17 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		goto out;
 	}
 
+
+	/*
+	 * Reject firmware file names with ".." path components.
+	 * There are drivers that construct firmware file names from
+	 * device-supplied strings, and we don't want some device to be
+	 * able to tell us "I would like to be sent my firmware from
+	 * ../../../etc/shadow, please".
+	 *
+	 * This intentionally only looks at the firmware name, not at
+	 * the firmware base directory or at symlink contents.
+	 */
 	if (name_contains_dotdot(name)) {
 		dev_warn(device,
 			 "Firmware load for '%s' refused, path contains '..' component\n",
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..18fdbd184eea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3264,6 +3264,22 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
 		(len == 1 || (len == 2 && name[1] == '.'));
 }
 
+/**
+ * name_contains_dotdot - check if a file name contains ".." path components
+ *
+ * Search for ".." surrounded by either '/' or start/end of string.
+ */
+static inline bool name_contains_dotdot(const char *name)
+{
+	size_t name_len;
+
+	name_len = strlen(name);
+	return strcmp(name, "..") == 0 ||
+	       strncmp(name, "../", 3) == 0 ||
+	       strstr(name, "/../") != NULL ||
+	       (name_len >= 3 && strcmp(name + name_len - 3, "/..") == 0);
+}
+
 #include <linux/err.h>
 
 /* needed for stackable file system support */

-- 
2.47.2


