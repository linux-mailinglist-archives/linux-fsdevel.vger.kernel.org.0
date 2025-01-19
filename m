Return-Path: <linux-fsdevel+bounces-39620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4ECA1628B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C9D1885D1D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3BE1DF747;
	Sun, 19 Jan 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G5BwpQkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CB1DF738;
	Sun, 19 Jan 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299710; cv=none; b=CaYzqLbJwXNKGaeS++kuuT53N7scZV6BHGJk5a8reB/VcuL3HVGCjqSla+c0ggG7JyM0EczJLaX5+28fXITG0z7Z8omgwwyuDRNIzboZnTLt9ao7n4x0xNWSaNS79WUzKCqmspqS7xWmsNPaGVugFVxy2zccGCeS2Brk/R/gSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299710; c=relaxed/simple;
	bh=FOhEZuJahzY/OP78uZ1cWHE5DQ0X8kQy+/dgQawrX7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B8S1wrCDBdcqM/DvpYfWuYyRFBaE4DvBCqTUSLIQEmPlhKTHijDf2Iwy4ugemkDaB0vcy8QMGZKSDBVDGddb+kRUNHSkM1LWkw6H2PXJ8vgwXRo98VbwcZOxQ7152u9ShaTkBFPyhP/A9YfoQE238mHtrwv7JF8gtyzgrpCDKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=G5BwpQkC; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737299709;
	bh=FOhEZuJahzY/OP78uZ1cWHE5DQ0X8kQy+/dgQawrX7U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=G5BwpQkCqvTq7ZkBibfRvnsd9cLndIGu9zrPfUgZd4YZl3Q3Yihlq1HcPFV6taS6n
	 LPlfmESd83rV7oipePQ+DC571ENjSD2ZcUdqa3rWfM6NUFmn3g1etAd9Ps7/KjDdn0
	 5CY0RftiJyx2zsYckAu8s3cYOy1x3SWWt6x9a69M=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1AC67128635D;
	Sun, 19 Jan 2025 10:15:09 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wIU3HkBWal3O; Sun, 19 Jan 2025 10:15:09 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 52A521286343;
	Sun, 19 Jan 2025 10:15:08 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 7/8] selftests/efivarfs: fix tests for failed write removal
Date: Sun, 19 Jan 2025 10:12:13 -0500
Message-Id: <20250119151214.23562-8-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current self tests expect the zero size remnants that failed
variable creation leaves.  Update the tests to verify these are now
absent.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index 96677282789b..4a84a810dc2c 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -76,11 +76,11 @@ test_create_empty()
 
 	: > $file
 
-	if [ ! -e $file ]; then
-		echo "$file can not be created without writing" >&2
+	if [ -e $file ]; then
+		echo "$file can be created without writing" >&2
+		file_cleanup $file
 		exit 1
 	fi
-	file_cleanup $file
 }
 
 test_create_read()
@@ -89,10 +89,13 @@ test_create_read()
 	./create-read $file
 	if [ $? -ne 0 ]; then
 		echo "create and read $file failed"
+		exit 1
+	fi
+	if [ -e $file ]; then
+		echo "file still exists and should not"
 		file_cleanup $file
 		exit 1
 	fi
-	file_cleanup $file
 }
 
 test_delete()
-- 
2.35.3


