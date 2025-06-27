Return-Path: <linux-fsdevel+bounces-53163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5837AEB2E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 11:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490DF7A8C31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF97295DBC;
	Fri, 27 Jun 2025 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig7lhkXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC946293C4E;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016589; cv=none; b=RGtPlzvVJ8jG5JJX4SEy2Z8ZkS2Oqa+vMEjpL5SnEKwrlMYc6BzdO0vzZrURrHPQTBuMsxMBsUqMijr1cvaEpBZ4SrVKmXph6oAyLtn7Yf3TaRYSWKkV37vZHR1jpquLRx4TqGKvRJdaMkNt/PQFbRSFvKJv0h2WJ4UIJnVRbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016589; c=relaxed/simple;
	bh=BfB8j0Uenzx8HLuqS3XAnJOtPTaoOBqEdT3unxo3Qp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYKEOiIGDLJjL4sWsM7ELBCPWG2fObPVnBS4mWR4gtLC0M9LvJLMnaQiB8VzDAsmJqOoEXAk9IxHmbGqlkT5Zpg6S7F9lHwKuwTinP3fltcFrsYf/pWWLImaI+K7HIO794CAdEoedgvIWgWNkLkNF4fxs2FZXul3lH78tmia1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig7lhkXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F63C4CEF4;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751016589;
	bh=BfB8j0Uenzx8HLuqS3XAnJOtPTaoOBqEdT3unxo3Qp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ig7lhkXHgBr59ZA44Mg9QzbxAK6TvPOM/7znf7iVxXeYIlQ79egWn5Ha6LPoIJlY+
	 PQrKEFf3BCxcNivgIoUBFIr+iyVVsUx82CbsaqKjHH7uXdhrfGJReIaooO2pAx/Ypb
	 e6HH+2ZSzXXTjx5uVJAmtLRPB68vhhs2Wm9lpaTcoH/rymK1tgqW0TlJnre7U9E8r5
	 4axMWxEXY+NaIhYX1tWXEDVFQDV7iQGvnDr+yhBIUeGW1DxmRqIwYaYzsKQy2NMZ5u
	 DlO51RDFNHOIdbV0JraIyWmlpRrn9KIZmgtQom91vbERE5Eqr4HTUJfUj0vXU32qbU
	 knRGb27AA/gdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A818C7EE31;
	Fri, 27 Jun 2025 09:29:49 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 27 Jun 2025 11:27:27 +0200
Subject: [PATCH 3/5] uevent: mv uevent_helper into kobject_uevent.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-jag-sysctl-v1-3-20dd9801420b@kernel.org>
References: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
In-Reply-To: <20250627-jag-sysctl-v1-0-20dd9801420b@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BfB8j0Uenzx8HLuqS3XAnJOtPTaoOBqEdT3unxo3Qp4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGheZIpR9w3Poudl1+IA2Xz/6g+srEOImFNlL
 M7P49LWN92qoIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJoXmSKAAoJELqXzVK3
 lkFPHIkL/2fGery5RFEqRkjNFgNIwk4Gy8ErpUzkJp0XG+vzv2iuUaVCeRG55yL7MR6yG/4IF8/
 oAnZucFlsU4dgjAc5cAPVkMu2BYe1ngpdOogZgzQcG4d+oU0aq6j82JfgO+yA1fGqVaGkAb7+ei
 Vuqu7vJ11zrg98sglHgOegaGThXIkBerBWaF4IszVLQ8hMPRvoDFeu580G1Tl2DZ1pSOPG7Hkgx
 od35wzUsD37DTUjm28zuOS0wHcz5fAJ+hpu34mNfWyoIRXD6ZCv5h1iT73AnIHpyKkwGBAmQkDV
 kMmI5pp/sZo1xs29per70D7eBEY+R9h+zf4hP266asUipFzYhiwpJDtqVxRqMx9B9ex4mvH7hRE
 7ghc432YBaqDYpX7mpSoCjDjCwwxYkmPH6NoBIkidxsPc+vfpBEd/+nChBiNqo1GDgxN80AhNRk
 7XQWwqsLZJAhd5BHBZNEKrzb1Bmyu0k2byi6ehR5fPyfOLKnNfQ2WE2peaZao+wGb9AxClCBsR6
 E0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move both uevent_helper table into lib/kobject_uevent.c. Place the
registration early in the initcall order with postcore_initcall.

This is part of a greater effort to move ctl tables into their
respective subsystems which will reduce the merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c      |  9 ---------
 lib/kobject_uevent.c | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0716c7df7243dc38f0a49c7cae78651c3f75f5a3..2df63b69edf6fd21a58584d670e75e6f26a6e5cc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1474,15 +1474,6 @@ static const struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#endif
-#ifdef CONFIG_UEVENT_HELPER
-	{
-		.procname	= "hotplug",
-		.data		= &uevent_helper,
-		.maxlen		= UEVENT_HELPER_PATH_LEN,
-		.mode		= 0644,
-		.proc_handler	= proc_dostring,
-	},
 #endif
 	{
 		.procname	= "overflowuid",
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index b7f2fa08d9c82c2838b703f3fd25f6e43b88b68a..78e16b95d2101a01c442f62ad9b9133f3f8533c2 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -826,3 +826,23 @@ static int __init kobject_uevent_init(void)
 
 postcore_initcall(kobject_uevent_init);
 #endif
+
+#ifdef CONFIG_UEVENT_HELPER
+static const struct ctl_table uevent_helper_sysctl_table[] = {
+	{
+		.procname	= "hotplug",
+		.data		= &uevent_helper,
+		.maxlen		= UEVENT_HELPER_PATH_LEN,
+		.mode		= 0644,
+		.proc_handler	= proc_dostring,
+	},
+};
+
+static int __init init_uevent_helper_sysctl(void)
+{
+	register_sysctl_init("kernel", uevent_helper_sysctl_table);
+	return 0;
+}
+
+postcore_initcall(init_uevent_helper_sysctl);
+#endif

-- 
2.47.2



