Return-Path: <linux-fsdevel+bounces-60999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92938B54359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36493168096
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD5B298CA3;
	Fri, 12 Sep 2025 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FFgW18gD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF4289E30
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660042; cv=none; b=K7r674pTz5zm0ai+2Abw3b0VsagXmd5WAJZyLOg1vzCZCkyITwu6kYMj2jR95HET8Vztm1u27d95bhQEZLc4EUSb1PQRuiF9ARRj8rQepyPIYDcwLEZMQSFv63O9V3a6YUQdttpurqLW6EXBEKsGnhPZE+KKu9beXXojFzDrDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660042; c=relaxed/simple;
	bh=OjsJP0wG/kajLofxyj8kSYc0iG5mJMxL1sKq28khJbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoqrcL69umlvIATpd+O301F7Lex0BraIoVTkKoGaeIqIHVOIxS+NBoRJNEW9DjNIhz/L0NlEu1Po86HbcMaFgEPBj1APMoadwQTaZIVN57YeXW0JvFlRrxB63VSZI7tLE/pJ8KFen00c/J8Em+T7/XPZHpm4VtlVFXcAQFKTIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FFgW18gD; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757660038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SruVcrA59jsUkTkaIv8NfRQXhFvmwY/gMcsDUgYo30A=;
	b=FFgW18gDgiD2lqLwh2EObwpUJMcivcilvesFsmEhzmbKhiK7IOc5P8uWzAuNUzdEyUxgHA
	pZs+y5XuluJhzx77cCrZ1pgAwKSOHbTbwzxUuD0o/SNz0qas6uXNAZ9v88UlFT7K4rDi0D
	0pOdJwv9XAFWrrD55D8Z8HL3qR1l8+Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: Use struct_size() helper to improve dir_add()
Date: Fri, 12 Sep 2025 08:52:57 +0200
Message-ID: <20250912065256.1486112-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the number of bytes to allocate for a new
directory entry.  No functional changes.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/initramfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6745e3fbc7ab..6ddbfb17fb8f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -19,6 +19,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
 #include <linux/security.h>
+#include <linux/overflow.h>
 
 #include "do_mounts.h"
 #include "initramfs_internal.h"
@@ -152,7 +153,7 @@ static void __init dir_add(const char *name, size_t nlen, time64_t mtime)
 {
 	struct dir_entry *de;
 
-	de = kmalloc(sizeof(struct dir_entry) + nlen, GFP_KERNEL);
+	de = kmalloc(struct_size(de, name, nlen), GFP_KERNEL);
 	if (!de)
 		panic_show_mem("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
-- 
2.51.0


