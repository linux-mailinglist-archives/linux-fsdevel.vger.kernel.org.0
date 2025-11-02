Return-Path: <linux-fsdevel+bounces-66702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBD5C299A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E973ACB8B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563FF2571C3;
	Sun,  2 Nov 2025 23:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERZX8SeE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE847253957;
	Sun,  2 Nov 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125183; cv=none; b=l6gIqbtzG62d4QIwllpU3X3Y2+j5lx3ScfGW4iUqjwj5dPqn5vD/oPedfBxm5ysziLwWMxjUAABgkIUQuxf35a/Vw/CH3WV57viYJdBvNq3De3RoY4lVVM+ftSZPHrRhfk6Cvz4EphuypLfPDgWe9DaYDeIyn9YvfBY/+UdLYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125183; c=relaxed/simple;
	bh=Xc2qJHO95yzrkGx1QoTwWW8B27tMxD9d8+M41jOGgyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVxy+yyB8VQbV1hJiAPuX/PWaa1Mj4MOklgE8jb1qBV7YxutRGCybjBuiooFxakha4iw97C9xKiYANGgPFm/1LHEUAgG3knctnf5x/ttTmkFi24LS0jeqF/X1fN2fg68DnwQ0ktQhUYHr7MLD9clcCzsdCWy+YLwo1EbI9S95K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERZX8SeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CD9C4CEF7;
	Sun,  2 Nov 2025 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125183;
	bh=Xc2qJHO95yzrkGx1QoTwWW8B27tMxD9d8+M41jOGgyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ERZX8SeEp6D8gALSAiyykqpN3hocLez9EiIdONSqMS9QB0RhFMam2NdkbUIto/g/l
	 YF4WAgWrDz0KFEbksEdnSTGZmBoobNgq5VQXSgcc/LjU97zMrLIRarCks0XhUN6Xs6
	 mK0TxDzz9Yt9TgRo44P7FnrvMezjpVGiRM8nAr/apYcXvqcm26rXk1iow2snACx5Kv
	 5vQn/xJZBBr/nJmPP8J+YHxZfHYD0IhLdewS4xfHWIkzZcf9ateDkByrIGpQRRq/n5
	 8lnRh0pqAO5MJz3MUXxq0XZtBZ30m5flw/SkOn2FpoSYBrgMbtNYdSQCfcEaK7LA76
	 iOjCMndAkLCoQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 00:12:44 +0100
Subject: [PATCH 5/8] firmware: don't copy kernel creds
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-init_cred-v1-5-cb3ec8711a6a@kernel.org>
References: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
In-Reply-To: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xc2qJHO95yzrkGx1QoTwWW8B27tMxD9d8+M41jOGgyk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy3d5eDOf7xmn239ktwtlWfPaS880vps3TQlLT3Lr
 zUf0r4v7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIkyAjww3Nn3KbnKa+awhO
 EriU6rSo7+bPjrLzXYvnb8y7c6Y+7w/DH84ewefHHftlP0Sk2ReXz+2KdDOTcjh34HlSkcGMdVw
 HWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need to copy kernel credentials.

Link: https://patch.msgid.link/20251031-work-creds-init_cred-v1-3-cbf0400d6e0e@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c | 59 ++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 6942c62fa59d..bee3050a20d9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -829,8 +829,6 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw = NULL;
-	struct cred *kern_cred = NULL;
-	const struct cred *old_cred;
 	bool nondirect = false;
 	int ret;
 
@@ -871,45 +869,38 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	 * called by a driver when serving an unrelated request from userland, we use
 	 * the kernel credentials to read the file.
 	 */
-	kern_cred = prepare_kernel_cred(&init_task);
-	if (!kern_cred) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	old_cred = override_creds(kern_cred);
+	scoped_with_kernel_creds() {
+		ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
-	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
-
-	/* Only full reads can support decompression, platform, and sysfs. */
-	if (!(opt_flags & FW_OPT_PARTIAL))
-		nondirect = true;
+		/* Only full reads can support decompression, platform, and sysfs. */
+		if (!(opt_flags & FW_OPT_PARTIAL))
+			nondirect = true;
 
 #ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
-	if (ret == -ENOENT && nondirect)
-		ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
-						 fw_decompress_zstd);
+		if (ret == -ENOENT && nondirect)
+			ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
+							 fw_decompress_zstd);
 #endif
 #ifdef CONFIG_FW_LOADER_COMPRESS_XZ
-	if (ret == -ENOENT && nondirect)
-		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
-						 fw_decompress_xz);
+		if (ret == -ENOENT && nondirect)
+			ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
+							 fw_decompress_xz);
 #endif
-	if (ret == -ENOENT && nondirect)
-		ret = firmware_fallback_platform(fw->priv);
+		if (ret == -ENOENT && nondirect)
+			ret = firmware_fallback_platform(fw->priv);
 
-	if (ret) {
-		if (!(opt_flags & FW_OPT_NO_WARN))
-			dev_warn(device,
-				 "Direct firmware load for %s failed with error %d\n",
-				 name, ret);
-		if (nondirect)
-			ret = firmware_fallback_sysfs(fw, name, device,
-						      opt_flags, ret);
-	} else
-		ret = assign_fw(fw, device);
-
-	revert_creds(old_cred);
-	put_cred(kern_cred);
+		if (ret) {
+			if (!(opt_flags & FW_OPT_NO_WARN))
+				dev_warn(device,
+					 "Direct firmware load for %s failed with error %d\n",
+					 name, ret);
+			if (nondirect)
+				ret = firmware_fallback_sysfs(fw, name, device,
+							      opt_flags, ret);
+		} else {
+			ret = assign_fw(fw, device);
+		}
+	}
 
 out:
 	if (ret < 0) {

-- 
2.47.3


