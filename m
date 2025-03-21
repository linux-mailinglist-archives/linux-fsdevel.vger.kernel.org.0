Return-Path: <linux-fsdevel+bounces-44708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C6A6BB14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB72B1796BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD722AE76;
	Fri, 21 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bByBrO2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904C221DBA;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561291; cv=none; b=uBlVZwqLEzMDDUuUwkgK1+pTUX/scT6QInoZc3P0gAyEo8wUBkUeDmZVE4CmLBV0ocdTbJ/XkPQ1A2hxESWTyRPeLYuDTjU5zb83EQFpTftLhgZ2jDfxJWQgrzQFIu9RZa6iy+Fza49AiJSR3/ZKUuK0Ra45AgpcA4nJslhyQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561291; c=relaxed/simple;
	bh=pDm2RKtKMseczShscO8UmtOM+OBDdzP3KgppVzDVCvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MK/nzLijTTDps4JDkX7Dzi8gqRCc6zcWuaZ9wRbJ2ttw8iVGKnPnozK1ObY1RvFA1abE0/qbolqpkcZPIxUlb9LCK2KC5lkM4RGPByk7/Uni3KAHRAN2JzTDusn9BdFdMoz+BNxZcIM2k8x1dMnNuiAk4KUhb3w85wJpF92hmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bByBrO2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A67AC4CEEE;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742561291;
	bh=pDm2RKtKMseczShscO8UmtOM+OBDdzP3KgppVzDVCvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bByBrO2ANh2P4dqRXAaJcOmhFrq9JNnH5YA+kUVAmpYSaYPmJ+ZoYP3omul3CtumW
	 ++6E3vwSoRKCEQqTmur1Lnm2afgwVy8++s85en/GMzFazNtLFS7Z7RRFoyQjfoBvej
	 yWjITLcV0+MzcWaYAAVlFJxTmd58niGXnRHHN9RiY0drFLP/9zK2UZ84bzyRZrFRWK
	 YivS0yb3qqIADS3ZDmgSvzxDT1e3/3+QOkAg62XuRHLhRZpId5jrsy1Aowxn8BfVwl
	 F5LvZ1mThMi/V9pJ5O5ua1OxsmOOyPgQ66M3nKKhGlsUWeAMxaxfDjhPZ5pyfIkJij
	 gNGyH70IJ8reg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFD4C36007;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 21 Mar 2025 13:47:26 +0100
Subject: [PATCH 3/4] sysctl: call sysctl tests with a for loop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-jag-test_extra_val-v1-3-a01b3b17dc66@kernel.org>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
In-Reply-To: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=pDm2RKtKMseczShscO8UmtOM+OBDdzP3KgppVzDVCvA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfdYAj1VTNzzhCdo4uFhBpVgJh0tmg7KFxvR
 b25NxXekUiLW4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn3WAIAAoJELqXzVK3
 lkFP4RAL/jj/ahISU6Y7eCrqcrae6/t3XdMoNHXWa/1AXf0bWTJCKp+jVm1H3HErHsntU8SZ0Hw
 8MBxVCRSsDiX6l3MQyg3S5Q3DrMflT1ESSMvUyzdDLENq5n/yCYZ/1IqVJ60IeQt/ZJ1OjPPVMd
 AMOVr1iDpO5m+7fghdVqlnup+6izSRaL3dGG9EBDh7zMIm2dOb5RZ4qSZBjcgDoYq5MwuNyrIdo
 cl88YqbSb8oCH53zCIdq42tzwOl2d+rkb3myetz/oC1Wix+DMCD3fUJNwOs4Yk6rSCR25QeGgEg
 GIzcTZfEP2at2C4sCj9sO6pOEB4sQHg6J3e7y8fMkr6zKqII2a+3a8OFZf7+kkDytmqOjHPRpvy
 8nUI2OLJdikgn8hN6w0/Vf06GS9bAkOqItENFXr2T7GSLOQt7bRlY2EB1a6z15LGLVSVvtrpkRg
 768mNcGn33dQR6RqT80A1lbCf5gXqu+UaZ1LFOfqv2pmFW2cn6UZNRHJWMPxnvFGYE3nkKs5rA5
 2w=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

As we add more test functions in lib/tests_sysctl the main test function
(test_sysctl_init) grows. Condense the logic to make it easier to
add/remove tests.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 lib/test_sysctl.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 54a22e4b134677e022af05df3c75268e7a4a79e7..4b3d56de6269b93220ecbeb3d3d4e42944b0ca78 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -301,27 +301,19 @@ static int test_sysctl_register_u8_extra(void)
 
 static int __init test_sysctl_init(void)
 {
-	int err;
+	int err = 0;
 
-	err = test_sysctl_setup_node_tests();
-	if (err)
-		goto out;
+	int (*func_array[])(void) = {
+		test_sysctl_setup_node_tests,
+		test_sysctl_run_unregister_nested,
+		test_sysctl_run_register_mount_point,
+		test_sysctl_run_register_empty,
+		test_sysctl_register_u8_extra
+	};
 
-	err = test_sysctl_run_unregister_nested();
-	if (err)
-		goto out;
+	for (int i = 0; !err && i < ARRAY_SIZE(func_array); i++)
+		err = func_array[i]();
 
-	err = test_sysctl_run_register_mount_point();
-	if (err)
-		goto out;
-
-	err = test_sysctl_run_register_empty();
-	if (err)
-		goto out;
-
-	err = test_sysctl_register_u8_extra();
-
-out:
 	return err;
 }
 module_init(test_sysctl_init);

-- 
2.47.2



