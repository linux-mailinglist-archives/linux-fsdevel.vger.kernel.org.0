Return-Path: <linux-fsdevel+bounces-52818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C44AE72D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 01:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34181189DDA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851F25BF10;
	Tue, 24 Jun 2025 23:07:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A417201032;
	Tue, 24 Jun 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750806438; cv=none; b=fpbDSxLZemIKX9f+/OHWGofEmrGvgUFlAIRjVKHHeBh07IWVzew+yDi/vRSHeTRRjzmWDak5SdoOygTANuEz2mwNVJgwxEZhC6V4LTA34hHb/ewQ73vGmHqQhiAYJe+uE89Ry0vWBE+piC35sVWqfAzxdbCxaCh3W1j3YStzdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750806438; c=relaxed/simple;
	bh=+sB7/BMUIu0FUgsQ3sQeXtB1XEe0Ae7Q3A+j642tTd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hogcqL+09D0UhRxbo6lIXWdvoON4qxw0NB5fqnIdG9iWAdrN+dsVENIFyfuForFO7W+GO5XWst2kfe8rEN+8nNzVqq6tEIlYTzy5DV7aEnRlmfzPO6KvB4dcBXhAoR0moGmwi0zS2cDgH2wpu1DX79U2iEXI0lY1DADKINbT+bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uUCjQ-0045c8-My;
	Tue, 24 Jun 2025 23:07:12 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] ovl: use is_subdir() for testing if one thing is a subdir of another
Date: Wed, 25 Jun 2025 08:54:57 +1000
Message-ID: <20250624230636.3233059-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624230636.3233059-1-neil@brown.name>
References: <20250624230636.3233059-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using lock_rename(), use the more obvious is_subdir() for
ensuring that neither upper nor workdir contain the other.
Also be explicit in the comment that the two directories cannot be the
same.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/super.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index cf99b276fdfb..db046b0d6a68 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -438,18 +438,12 @@ static int ovl_lower_dir(const char *name, struct path *path,
 	return 0;
 }
 
-/* Workdir should not be subdir of upperdir and vice versa */
+/* Workdir should not be subdir of upperdir and vice versa, and
+ * they should not be the same.
+ */
 static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
 {
-	bool ok = false;
-
-	if (workdir != upperdir) {
-		struct dentry *trap = lock_rename(workdir, upperdir);
-		if (!IS_ERR(trap))
-			unlock_rename(workdir, upperdir);
-		ok = (trap == NULL);
-	}
-	return ok;
+	return !is_subdir(workdir, upperdir) && !is_subdir(upperdir, workdir);
 }
 
 static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
-- 
2.49.0


