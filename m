Return-Path: <linux-fsdevel+bounces-44712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF42AA6BB12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3B83B6B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC022B598;
	Fri, 21 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgSIn16C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F575225387;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561291; cv=none; b=nuKxhVgqb6FUiTZVNv+P/sVmwPHRNTdXL63JJDHh4TWiWP/YT5Tea3To3OVDCaZjr2kF4A1LGLO1gpQoarMS4O9r/sR7I5D3ngqW8UIQxBABoPEkZ3+J4Gb/cUtQG3XPveOeQ3ZK54kM4jEeEahptoiovMfcw7mMSmywUTqAQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561291; c=relaxed/simple;
	bh=tPclanPxc2LJNZ+LffzKz/MsVwoWY65M+jCqO4MmhRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbUsgzwTsqfy4whqVCi937E3G+FUaANqSJ2Tm9cjoN9sE7a71H8qxsCFrphkS9rwKnxiPfClM/UwFFvkK9CNJ6+urw/I/jbjOyVwdxC5gDckhaiVSnqrItOqPuHc6CBYbiICq71awYiljVPIiAoi4ZimVcaMmCuORm8XCyOsA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgSIn16C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FC72C4CEF1;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742561291;
	bh=tPclanPxc2LJNZ+LffzKz/MsVwoWY65M+jCqO4MmhRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dgSIn16C83G2CD1JFSlDVbxLgm4ekt4AFNJC+XqxoV64Hgo+xIpgWWvguEtK0kpEH
	 FcaIwbXrNUrQR1D/vSeMk9bVg+rxuFuCNN4kxTVY96mhjy3G1X3Pdm80AJfz/yQGVt
	 CvEyyc5Hb+8zTKnsqKG1rPyruahgvhFucLpEO4+vtQhKGEBIIda8ZYyNY/nmrNnTVE
	 sd43kgNchtIvJ+Z7Ewt+P87j8VIKZXCy8wxnpNyu+rvmCU4oL9Y5IWQYv8UEES7MfS
	 pTRcuvPmCW5oS2+0guIx1G2kWJhJw13dgYfOyJkNnl1HwBtz1J4z23d0UA7HXmGHno
	 GF5VKZeaIfgxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A5C3600A;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 21 Mar 2025 13:47:27 +0100
Subject: [PATCH 4/4] sysctl: Close test ctl_headers with a for loop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-jag-test_extra_val-v1-4-a01b3b17dc66@kernel.org>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
In-Reply-To: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4809;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=tPclanPxc2LJNZ+LffzKz/MsVwoWY65M+jCqO4MmhRM=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfdYAmcBP428RNEZK9+DxFx/XWo1HWrXCkYx
 1mIYMzHtpVKg4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn3WAJAAoJELqXzVK3
 lkFPldcL/3Q+mTYV2tiKx/akRMoNAII46ZkMXn0pX8wC33X6kFjgRHi2H99XUdtueb4itHmdcQR
 g0zo+z8PyAqv+1XfJOsCEy4ilUP106towob7bUHVLBVhiPGiw0XCTmEjne92Wfgk8lh2O25n7dX
 bgIJEKP1pb+aNPkCPJwcx9/Px8W98BcD+Az0yqO52SnPjInsjDJ8xfgS6GpotB4PIRCnLyiB8jW
 qBBsIjnTs9mPToF8e0qevpvgXGboSlWYmb/ELe7dQz4xlPdra+OI8CH+3aC9UrYyy2mzkOWItnp
 rV+Bek/HYMFWGXZpgG/ZR74kPDv4avI0Q1xlJl7y8AWeXbaor6BwN0NUBFgxZeqMlb3YLqCF7XX
 +m4peyWpyZp/NqtKfh9/G0IWxdhdQPh/G6FP8wdTD42t6WSad5o0dC8zoFrp/k1dFAsSlFU8A/H
 2qjI62P+1Ef35Esy4U3d5qk0pgr+l/C0E5Sni69ArHnLxPcyEJX53aXB7pQ1HqWupHfZbpSlM38
 kE=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

As more tests are added, the exit function gets longer than it should
be. Condense the un-register calls into a for loop to make it easier to
add/remove tests.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 lib/test_sysctl.c | 65 +++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 4b3d56de6269b93220ecbeb3d3d4e42944b0ca78..c02aa9c868f2117606b24f114326bf1c396cd584 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -30,16 +30,17 @@ static int i_zero;
 static int i_one_hundred = 100;
 static int match_int_ok = 1;
 
+enum {
+	TEST_H_SETUP_NODE,
+	TEST_H_MNT,
+	TEST_H_MNTERROR,
+	TEST_H_EMPTY_ADD,
+	TEST_H_EMPTY,
+	TEST_H_U8,
+	TEST_H_SIZE /* Always at the end */
+};
 
-static struct {
-	struct ctl_table_header *test_h_setup_node;
-	struct ctl_table_header *test_h_mnt;
-	struct ctl_table_header *test_h_mnterror;
-	struct ctl_table_header *empty_add;
-	struct ctl_table_header *empty;
-	struct ctl_table_header *test_u8;
-} sysctl_test_headers;
-
+static struct ctl_table_header *ctl_headers[TEST_H_SIZE] = {};
 struct test_sysctl_data {
 	int int_0001;
 	int int_0002;
@@ -168,8 +169,8 @@ static int test_sysctl_setup_node_tests(void)
 	test_data.bitmap_0001 = kzalloc(SYSCTL_TEST_BITMAP_SIZE/8, GFP_KERNEL);
 	if (!test_data.bitmap_0001)
 		return -ENOMEM;
-	sysctl_test_headers.test_h_setup_node = register_sysctl("debug/test_sysctl", test_table);
-	if (!sysctl_test_headers.test_h_setup_node) {
+	ctl_headers[TEST_H_SETUP_NODE] = register_sysctl("debug/test_sysctl", test_table);
+	if (!ctl_headers[TEST_H_SETUP_NODE]) {
 		kfree(test_data.bitmap_0001);
 		return -ENOMEM;
 	}
@@ -203,12 +204,12 @@ static int test_sysctl_run_unregister_nested(void)
 
 static int test_sysctl_run_register_mount_point(void)
 {
-	sysctl_test_headers.test_h_mnt
+	ctl_headers[TEST_H_MNT]
 		= register_sysctl_mount_point("debug/test_sysctl/mnt");
-	if (!sysctl_test_headers.test_h_mnt)
+	if (!ctl_headers[TEST_H_MNT])
 		return -ENOMEM;
 
-	sysctl_test_headers.test_h_mnterror
+	ctl_headers[TEST_H_MNTERROR]
 		= register_sysctl("debug/test_sysctl/mnt/mnt_error",
 				  test_table_unregister);
 	/*
@@ -226,15 +227,15 @@ static const struct ctl_table test_table_empty[] = { };
 static int test_sysctl_run_register_empty(void)
 {
 	/* Tets that an empty dir can be created */
-	sysctl_test_headers.empty_add
+	ctl_headers[TEST_H_EMPTY_ADD]
 		= register_sysctl("debug/test_sysctl/empty_add", test_table_empty);
-	if (!sysctl_test_headers.empty_add)
+	if (!ctl_headers[TEST_H_EMPTY_ADD])
 		return -ENOMEM;
 
 	/* Test that register on top of an empty dir works */
-	sysctl_test_headers.empty
+	ctl_headers[TEST_H_EMPTY]
 		= register_sysctl("debug/test_sysctl/empty_add/empty", test_table_empty);
-	if (!sysctl_test_headers.empty)
+	if (!ctl_headers[TEST_H_EMPTY])
 		return -ENOMEM;
 
 	return 0;
@@ -279,21 +280,21 @@ static const struct ctl_table table_u8_valid[] = {
 static int test_sysctl_register_u8_extra(void)
 {
 	/* should fail because it's over */
-	sysctl_test_headers.test_u8
+	ctl_headers[TEST_H_U8]
 		= register_sysctl("debug/test_sysctl", table_u8_over);
-	if (sysctl_test_headers.test_u8)
+	if (ctl_headers[TEST_H_U8])
 		return -ENOMEM;
 
 	/* should fail because it's under */
-	sysctl_test_headers.test_u8
+	ctl_headers[TEST_H_U8]
 		= register_sysctl("debug/test_sysctl", table_u8_under);
-	if (sysctl_test_headers.test_u8)
+	if (ctl_headers[TEST_H_U8])
 		return -ENOMEM;
 
 	/* should not fail because it's valid */
-	sysctl_test_headers.test_u8
+	ctl_headers[TEST_H_U8]
 		= register_sysctl("debug/test_sysctl", table_u8_valid);
-	if (!sysctl_test_headers.test_u8)
+	if (!ctl_headers[TEST_H_U8])
 		return -ENOMEM;
 
 	return 0;
@@ -321,18 +322,10 @@ module_init(test_sysctl_init);
 static void __exit test_sysctl_exit(void)
 {
 	kfree(test_data.bitmap_0001);
-	if (sysctl_test_headers.test_h_setup_node)
-		unregister_sysctl_table(sysctl_test_headers.test_h_setup_node);
-	if (sysctl_test_headers.test_h_mnt)
-		unregister_sysctl_table(sysctl_test_headers.test_h_mnt);
-	if (sysctl_test_headers.test_h_mnterror)
-		unregister_sysctl_table(sysctl_test_headers.test_h_mnterror);
-	if (sysctl_test_headers.empty)
-		unregister_sysctl_table(sysctl_test_headers.empty);
-	if (sysctl_test_headers.empty_add)
-		unregister_sysctl_table(sysctl_test_headers.empty_add);
-	if (sysctl_test_headers.test_u8)
-		unregister_sysctl_table(sysctl_test_headers.test_u8);
+	for (int i = 0; i < TEST_H_SIZE; i++) {
+		if (ctl_headers[i])
+			unregister_sysctl_table(ctl_headers[i]);
+	}
 }
 
 module_exit(test_sysctl_exit);

-- 
2.47.2



