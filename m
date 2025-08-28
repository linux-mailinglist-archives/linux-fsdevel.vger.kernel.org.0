Return-Path: <linux-fsdevel+bounces-59534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0748B3ADFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E2398846E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B012D6418;
	Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Zh8huipL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCE2C2341
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422490; cv=none; b=ZKpLefSRSkdxvz5YDkfY2WPV3SSO7BXehnWCvaaXcjKZU0kDj9224kBIt3rRKPFYi9TjkYddseezQC556pGCO5qtquMt3aACT1LGHyf2TrmIHsxbyWiochsaopZ4m9pcJhdei78NZi/k3nXKNzBRfHervFkei5T//2bKo5Hji4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422490; c=relaxed/simple;
	bh=j56Lz/1ae55amC1kIGJfBot/A/tMiX40HPhe11T+81A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTA6RjZh+1cTnK/YXH31vscTSDe+nrLuPKdqsklciTwk++KosOWbT3QyJUvfyj8LJ0jcliuj0yN3QACcP7Jr4eK82lLlezNLXEFB4ezHREWPbIrDMiSxFCf7WRbhRuDJbrQbJofUvOLo54H/rhiyWmMcUQqsNyJBdeJpFhp8tJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Zh8huipL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AWxRMJ8zKhhDYtKZTmRTBGuLCZH5wsCsFAPM5AArloA=; b=Zh8huipL1RqMBzet90JQvMcIJm
	6uO2H3aeMiq/oy2BvoJaRU2yeGoyLBIm4ZjqaEF6MO7Nm5yb2734r+1gdZzzgtAam8qeqHeBcKRxl
	e/Er8pLYLIZAvdU01JiLkN/pjrAEDyUga5lRVTd1PQKUC1qSfeB4zQUXkI38XthuvTX+cXvUa4U8G
	SaBHoACffXV5yN6C28hRbAuvOc+bj1w0dtyswjtpEg173PlrdLhi/kIyBcjV3hdAdQvU+OV0UopfI
	qt8kMWA9bPe5Wz4x7K3aq0nZRVT/l0AoNkbHC5uhM1g54+Bieo72Oa1fEc74w4hHGx03byJYy84Ce
	7kHyZc4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F21D-1Lnh;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 05/63] __is_local_mountpoint(): use guards
Date: Fri, 29 Aug 2025 00:07:08 +0100
Message-ID: <20250828230806.3582485-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

clean fit; namespace_shared due to iterating through ns->mounts.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1ae1ab8815c9..f1460ddd1486 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -906,17 +906,14 @@ bool __is_local_mountpoint(const struct dentry *dentry)
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mount *mnt, *n;
-	bool is_covered = false;
 
-	down_read(&namespace_sem);
-	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
-		is_covered = (mnt->mnt_mountpoint == dentry);
-		if (is_covered)
-			break;
-	}
-	up_read(&namespace_sem);
+	guard(namespace_shared)();
+
+	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node)
+		if (mnt->mnt_mountpoint == dentry)
+			return true;
 
-	return is_covered;
+	return false;
 }
 
 struct pinned_mountpoint {
-- 
2.47.2


