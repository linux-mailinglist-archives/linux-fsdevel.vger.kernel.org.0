Return-Path: <linux-fsdevel+bounces-39612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB936A1626C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D416503A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053611DF754;
	Sun, 19 Jan 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="co0KK1vR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A01DF745;
	Sun, 19 Jan 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298833; cv=none; b=gvxCykcO0nnR8lsBlgvNVX/IH8CMqrOF5XskchR1GDr5sAYoULmSEoVhGQG99/0/gwPwlo0ChGW1BmOKyWHRnh9eBeR+rQMqmV9XrU8ddE2rJj7UTF3m5Gd4OegoOderJZMydTpBIlWT+TBOMOMNoWwiUVORSO8sAoqfJIBgZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298833; c=relaxed/simple;
	bh=vC6nggagNIPCbGST7/KjfgSPmydDZKqgJkjztWHJjuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXoRiltdUO12APmniuHlDsqHikLQjMejTJ69c/eUjLPPWZ3R0xvtsQpPfXKKcz4K04FETa0MkQF11pIn9jgu6Qa9DJRN3hVlcB2xVGCVuigOgDr8ykGtzlHtY4Mvvq4zr2b8OSmgY8X4M0sH0SEaEJixrtj5TMdFZFs9pCumB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=co0KK1vR; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737298831;
	bh=vC6nggagNIPCbGST7/KjfgSPmydDZKqgJkjztWHJjuc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=co0KK1vR2Ta8U18CJSuFyQwrnsqG1sYmLz8E5EK2DR5HuTVi1FKK5RTzPHVPsr7Jh
	 iNC4oasl/cdo8WO19FnGUVClTdv2erhnYCkUSLdx+fKunzweSTp2AmGBRt5LmLU2vC
	 bCOhd2VgLlrDAw2oZmJGMWN9cWi8zZH8ih4uIzvo=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5929B128651F;
	Sun, 19 Jan 2025 10:00:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id L04O14ehuK5U; Sun, 19 Jan 2025 10:00:31 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 724F2128651D;
	Sun, 19 Jan 2025 10:00:30 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/2] selftests/efivarfs: add check for disallowing file truncation
Date: Sun, 19 Jan 2025 09:59:41 -0500
Message-Id: <20250119145941.22094-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
References: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the ability of arbitrary writes to set the inode size is
fixed, verify that a variable file accepts a truncation operation but
does not change the stat size because of it.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 tools/testing/selftests/efivarfs/efivarfs.sh | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/efivarfs/efivarfs.sh b/tools/testing/selftests/efivarfs/efivarfs.sh
index d374878cc0ba..96677282789b 100755
--- a/tools/testing/selftests/efivarfs/efivarfs.sh
+++ b/tools/testing/selftests/efivarfs/efivarfs.sh
@@ -202,6 +202,28 @@ test_invalid_filenames()
 	exit $ret
 }
 
+test_no_set_size()
+{
+	local attrs='\x07\x00\x00\x00'
+	local file=$efivarfs_mount/$FUNCNAME-$test_guid
+	local ret=0
+
+	printf "$attrs\x00" > $file
+	[ -e $file -a -s $file ] || exit 1
+	chattr -i $file
+	: > $file
+	if [ $? != 0 ]; then
+		echo "variable file failed to accept truncation"
+		ret=1
+	elif [ -e $file -a ! -s $file ]; then
+		echo "file can be truncated to zero size"
+		ret=1
+	fi
+	rm $file || exit 1
+
+	exit $ret
+}
+
 check_prereqs
 
 rc=0
@@ -214,5 +236,6 @@ run_test test_zero_size_delete
 run_test test_open_unlink
 run_test test_valid_filenames
 run_test test_invalid_filenames
+run_test test_no_set_size
 
 exit $rc
-- 
2.35.3


