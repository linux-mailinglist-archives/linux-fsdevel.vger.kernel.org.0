Return-Path: <linux-fsdevel+bounces-71530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16CBCC67A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C6A305133A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991EA337BBD;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVhgVtF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54CB22F76F;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=T5tk6omgSWium/b5D0bADHdxdvC61MHfYRrcwf+d7WHsOzX+hbWj7jmjXNsBdKIG8uD5q070FXwPja/xKPB/G+dp+SffGrBGSCCAUlKCYwuQHrFiKYOrzYpD2xBSLc7JaypN16er0b8uclizt3RvaP758wV7f4636cTgVM3nkqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=ONjskDJSnMc2NvXpXHulyVNB4siKX2n/8tf9NPapg1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gi0BwoK/KqlUhs2rEjKzPWBeA+afo8S07l5FhR/0fCCqgXS1v/HPzzJvbMmwBVHT3nDoOK5Ej76PO/dleOIzMBXPr3Y3zhJUg3G6c4+5qH45bg11dQq8LXdVOjqMMhvS2iR2Fw9eRvEOF3Khf2de/aeoP99MO6Ms6FXjbtxBjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVhgVtF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93E68C19421;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=ONjskDJSnMc2NvXpXHulyVNB4siKX2n/8tf9NPapg1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bVhgVtF1al5XdTz4osunZzDcFSkPWDnxcdjF7me8Kt1xIrsk06NCPZYAEtzBes6Vn
	 3AtcVp/lvZ7t1+M1N/EQyjen93Nn3k2rffk3i5n6nWD8JtMniv+FCKkzYqLB+EyQb6
	 oWd5H3Cf3jOMoZ/6xIjY+OxlQr+TLczj1oEumlLewiHCfcfO4/OPGKEgOrc/REVPxc
	 XsYN/bfQrUlrtKSEsWA11/JrntjPh06DRjSGlJ1fGnhn+ZI80dev76oc4J5H/d9pR8
	 DVvIpzBaa57h+JQKUGhzcl+idYYJUUgDGVsFk9GfQrdrMBQ2AkYPHbujGknRZLml03
	 J6+sIYyiUC8Ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A9D6408A;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:39 +0100
Subject: [PATCH 1/7] sysctl: Return -ENOSYS from proc_douintvec_conv when
 CONFIG_PROC_SYSCTL=n
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-1-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=928;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ONjskDJSnMc2NvXpXHulyVNB4siKX2n/8tf9NPapg1M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEnD3wipew55YC8O32lYsa+eP0IUJsDCH
 472Y7oCRrOCu4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRJAAoJELqXzVK3
 lkFPPaQL/A4Smb3BpiMugKxIpE6/bf9WqLUYniX/SQ/1PIyHP8+oUDg9sAu4LzybYpfqrxoaqhF
 rH9CKy+7RQizNZdj+/tXEKko7aka2URX4t6/4R1WVMQIv6WVuHhwznxSHf+UuiN5nC/5dIp5XVB
 PylQUfhKyx3Sygufu4x4wj5IVgJTf1ve8hyxrHWbM5ZfyAT/aYOVJr3pr+Ly9++XYDFJBUHipKo
 A5Jq2gwFStCKQPSPv26rBd4IiKAM2ivDQRcLEHwb7c1rGCuBVao9u8EE7sJQ74gnDrvn31RwAs2
 UIjeaeGmkOq7bK0mKKHDTDk17HKJaS9uL373t0vz/X35noRWrzzKjMbUrXkJ9zSzuPW2ncmJ7Zv
 TpC5E4VFjQh4dGkbjKFA3zrugebeXiv+XAmLL8PBtQAzyvz9sDotq/6fW9E/GzJWGVBtefPS4hR
 czbcYP/tZYlQtKJR+w1o+u2GPsj0aKH575bxgureyIhOiSIccuLdOPkfEKpWfkCLEPsqMUXJfG5
 d0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Ensure an error if prco_douintvec_conv is erroneously called in a system
with CONFIG_PROC_SYSCTL=n

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2cd767b9680eb696efeae06f436548777b1b6844..84ca24fb1965e97dc9e6f71f42a6c99c01aca3ee 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1055,6 +1055,14 @@ int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
+int proc_douintvec_conv(const struct ctl_table *table, int write, void *buffer,
+			size_t *lenp, loff_t *ppos,
+			int (*conv)(unsigned long *lvalp, unsigned int *valp,
+				    int write, const struct ctl_table *table))
+{
+	return -ENOSYS;
+}
+
 int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {

-- 
2.50.1



