Return-Path: <linux-fsdevel+bounces-66809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AEC2CC54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C468420254
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694213148C3;
	Mon,  3 Nov 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alKRJX9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94A32BF25;
	Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181882; cv=none; b=ThckzqQjcKutEnf3sob/wRjb52wjAPUasT/5hFCOZbrlV6erdH5mz6OWmHWbIlJUJFTeC1wZw57t8Ep1Wikb6URfP1fe5KTqAhUVq7dhlp6yOI8/HQ02Dktx5UvIwX2OI1fWcomj8H21c3hQtoTM+SWPKh+7/PaOGC/5hPOlv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181882; c=relaxed/simple;
	bh=ueoshrmp4QkI9SU1ImHUS9AR0CCmoEPF5ceuQmXRIvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXG9CkA3+zdrewFhNx2HVd2edzyZ1/Ve7tCwyeEQCMYy0I5V4OqkUjDQnhYwPzN/R9m5gm0q80YeNu92wcC+wPe5O3nUGqUSGmYzE2nitg+rQmBD2CIwheeg6iIVs8PHMGSgeHMskhKTGIfnpaXLQ9gOiX5Jr9hdxkPqA6ymUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alKRJX9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D09C4CEFD;
	Mon,  3 Nov 2025 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181882;
	bh=ueoshrmp4QkI9SU1ImHUS9AR0CCmoEPF5ceuQmXRIvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=alKRJX9gwXSRLScebUpvPp+WXVLotG0w/uaJLFrECQUZ63vpCvDlosEP2dAxHgLHR
	 kTJvdul0xoSMw5k3Pa5LBRuQdc0/WNZpMy0Wk1X5kyewz0yx46fZhRPZJpPpx0mc2C
	 3HfjCt0y5PQmwMqYrxHSnC8ZNj+knGDQJHg4dplRcZsO7ITLG0EUup06T7Rk+13Wz4
	 Enym8L6irtxbOcxOmMI4vj+2L9YN/9R+4R8/XaSIpQeYitGCSYDZti9Fzq36QP/SPP
	 RgEjzT3poQR4wuhtf0dCe1WHvj9hOX/XesxMCRfrhCMMj4AubqpdHZwmMM+Qvj2CZf
	 uLKVtSgEM3ZXg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:30 +0100
Subject: [PATCH 04/12] sev-dev: use override credential guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-4-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ueoshrmp4QkI9SU1ImHUS9AR0CCmoEPF5ceuQmXRIvA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHoRr9r1hv+5W0WMGeOOLXFW8udvTNFLt9i3+Zfz3
 GpL6/o7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpOcLwT2u3aUiVfWZX55uD
 vY9fmLBIr1j37saKbvHfLSd95+iudWD4H+2SYH7Gq99lz7utyzcsOKF7uEt9x/8oRqNlV0/96rq
 9hxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use override credential guards for scoped credential override with
automatic restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 09e4c9490d58..19422f422a59 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -260,7 +260,6 @@ static int sev_cmd_buffer_len(int cmd)
 static struct file *open_file_as_root(const char *filename, int flags, umode_t mode)
 {
 	struct path root __free(path_put) = {};
-	struct file *fp;
 	struct cred *cred;
 	const struct cred *old_cred;
 
@@ -273,13 +272,9 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 		return ERR_PTR(-ENOMEM);
 
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds(cred);
-
-	fp = file_open_root(&root, filename, flags, mode);
-
-	revert_creds(old_cred);
 
-	return fp;
+	with_creds(cred);
+	return file_open_root(&root, filename, flags, mode);
 }
 
 static int sev_read_init_ex_file(void)

-- 
2.47.3


