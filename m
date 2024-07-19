Return-Path: <linux-fsdevel+bounces-23994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79822937739
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0502BB2147B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73912BEBE;
	Fri, 19 Jul 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewNfkBay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED54A1E871
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389353; cv=none; b=mjKkKqe+uUpMUFUo65My1Me0ofHYiCXOD3QPHfXL7xfoYsIbfqilWPGsnCdFVbBTHn3ql7slKFvQqw74tE+Swb4vZHKBkfY1deeNVZr6aQPI7ih8yYutv/L85B8axfPDydnATE2pOPQXoCv4yEHGAuyCPjNJkXJ4UPqPYvvUqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389353; c=relaxed/simple;
	bh=/UKV6eRiJx+RO3FmnB52Qrdd8JuCnRCdyfSUmERu0Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HnYA5RVpX3i6BZYEVUHX+/w4JNiHsh46uOfkTMTAmWQWuAcn3ZbKeRpP66uUY4mobRJSs61cRjoRoUa9EEv06G2Lx5SuMBtu4Mvsh6U1OgUfbvfL/l9x+9MPf3+z6Yg/ZmhZIcCMFK+ZTjJcue90AJNylxxdVgrBc/+wrRiLQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewNfkBay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F351C32782;
	Fri, 19 Jul 2024 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389352;
	bh=/UKV6eRiJx+RO3FmnB52Qrdd8JuCnRCdyfSUmERu0Io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ewNfkBayxkna3D1pU+CIqu/78kJAyETd55KNqIP/zZojIOxnRx93R5tQRtOjXWqaT
	 1aBkmO0fO9v+WhfhlJxmxZMNPdQrqEuTmfBmT8RV3gWfZbEBU5FU8L+UBFslAFn8Pf
	 f7CZRjZX1EIGRJqlcTRTvSvELt36z6S4CBpaf4WdyvvKtadqY8CqrseZMdlS03qsZy
	 FWYG0G2s6h415iAEso0eziGYLlIZ47CMZstWqcmWxKgW5Kd/LTrb7FptAmM9++Af2k
	 oZicOH43Jrc8aAzoO6cwtOUhiHwR3ey2b1tXLr+flGR3hf8KltJw1JGTqPdw3bi6pf
	 b9IwtTcGMzOpg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Jul 2024 13:41:50 +0200
Subject: [PATCH RFC 3/5] fs: add put_mnt_ns() cleanup helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-work-mount-namespace-v1-3-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/UKV6eRiJx+RO3FmnB52Qrdd8JuCnRCdyfSUmERu0Io=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClTw2bH1xZsW7xwjhwa3LWtsJdMvHfm/5ZrqxI9qD
 0+ntbxs6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+H6Gf7bPDk93nZ4/uW45
 m4H62xsf1vf/sOeaV/PBUSZU5+SB1VsZGXrCXxVlvsjcoGXWKuNwmrvhku3u9m3JW8XTc3X1Hlj
 EcwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple helper to put a mount namespace reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/mnt_namespace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 8f882f5881e8..70b366b64816 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -3,6 +3,9 @@
 #define _NAMESPACE_H_
 #ifdef __KERNEL__
 
+#include <linux/cleanup.h>
+#include <linux/err.h>
+
 struct mnt_namespace;
 struct fs_struct;
 struct user_namespace;
@@ -11,6 +14,7 @@ struct ns_common;
 extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
 extern void put_mnt_ns(struct mnt_namespace *ns);
+DEFINE_FREE(put_mnt_ns, struct mnt_namespace *, if (!IS_ERR_OR_NULL(_T)) put_mnt_ns(_T))
 extern struct ns_common *from_mnt_ns(struct mnt_namespace *);
 
 extern const struct file_operations proc_mounts_operations;

-- 
2.43.0


