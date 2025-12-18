Return-Path: <linux-fsdevel+bounces-71657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D330CCB998
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFDE6302E147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F430B525;
	Thu, 18 Dec 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRZo0Wa4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDA1C5D6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056941; cv=none; b=hHnuGcirE3/5fRo7uHR8FufwB5oNa8zoA50JInofDyI2aaMws1DFOM4w9zhpoxH22rJQc0kx8lSW2grZjscRc8/5aUwoAmC0dMOsMeUO+ArYidz3DrkeCT2KLYefD8SR9OkgqtdQGSPOVqIylBqBLI2CfOWhEVOPfD5S3mEhhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056941; c=relaxed/simple;
	bh=8s9ID86ToNKjPfHy7R6EK7xgo44vyRv1nviw21SGEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmQofDLcFG3C16nUlEVVSDgxEtD1UTeKemNGFsgKNY5YZuqK60r5Ias8yQsbEy7R3sXfhXArTINI+6Ws4iKynjLfXM6hSZPtvPfKDNeNm5dSYH9VTyJYrnU8U/twjQx/UZvfsT+Tsr8cC4EFcvU6hoVIzPk0pBkUoMRfIBcmdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRZo0Wa4; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766056931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etjK20rY/G4b3a+WqeAgjWrAs++AyA4NRNLHPZ9xUo4=;
	b=jRZo0Wa4SkB6M9Hz5fAOxYaDNBdJiVhnEeZ2EYk4eba6Q/o+q5VII0gtGOjKqnMDTF7DTb
	32EJoJX1KCwhx2ioCjSwHy2lcRXi4YTRV1QPAk1HnuX9SHkwXPmCPhQS6RshR7PzmauRiz
	DpXK+/d82Kh3wbMaHCEFq9c0jp7xVlU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Replace simple_strtoul with kstrtoul in set_ihash_entries
Date: Thu, 18 Dec 2025 12:21:45 +0100
Message-ID: <20251218112144.225301-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtoul() for parsing the
'ihash_entries=' boot parameter.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving behavior for existing valid values,
and removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 521383223d8a..a6df537eb856 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2531,10 +2531,7 @@ static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_lock
 static __initdata unsigned long ihash_entries;
 static int __init set_ihash_entries(char *str)
 {
-	if (!str)
-		return 0;
-	ihash_entries = simple_strtoul(str, &str, 0);
-	return 1;
+	return kstrtoul(str, 0, &ihash_entries) == 0;
 }
 __setup("ihash_entries=", set_ihash_entries);
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


