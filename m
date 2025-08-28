Return-Path: <linux-fsdevel+bounces-59535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB368B3ADFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CD57A2235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65DA2D8799;
	Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H97LJp+I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D32D0621
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=RVKJlmK17VvcVged0htLRQSmyPx2H/rzWUiGn3she7RCtSDHQIwG1KEhO0RknsJSPjj+6wblqmft5hjBbCcTSaEn7TaNB2vgzLxVNpHskdn5vjgMFgp7don9C69xRflqvFRxQ+OUweXbTLxiX5QyjL0NibQEent4DNGdQXVkTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=PQXX/Kcj9l+WkrFPDEBT+tr/60dmys/ff4mqeoYFwjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6cvkP4g2lYrvOKpEA2vJDuJzZX2oSU1V7af/PwtL4po5Zj+2Icyjn7J0cl4zEW3xu7ZBwebTb7MJzaZQJoToAAEEDlFQUV5H7mjXaCc2FV3rlfVCT44PXcc66htvs6Ta2g5XtSqIx6G+R4koL/9CliUnDWXKOVVezX+WlNDh+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H97LJp+I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hJHroDDz1lOT6aJfo8xM1wgESKO1dNPYmMVo4DS1KeI=; b=H97LJp+IrXXGYZVJmLk+791Qi2
	vF3+rJlgdonQP0O1A/BJjY4YJ8kIJLy7Cyj1HwqLhV5GdVNaq+/n7OzPeo6auR03jTngKuUsF4wxT
	AXkmX5CY70v6cWJHERwc7+q/NA51erMICXzoA14rjlfPTDQMusUGydF2wovbz2Xwkl52xGEu0O+eS
	b0026cK10gQ6BEqvczv5t7JUgT5FZlR1z5StnYLnCXL6dLLAskLo2R3fssj4U7HKHzEdoItWtA1TC
	thsaFO8UhwS8tZD1RfkcycohddCIyaUXY/kUMHZ74x9RJoyJr6IgxDLXWlGweCC3ONLxir7D1Xaxv
	Qwin5J3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F21w-3yJZ;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 09/63] put_mnt_ns(): use guards
Date: Fri, 29 Aug 2025 00:07:12 +0100
Message-ID: <20250828230806.3582485-9-viro@zeniv.linux.org.uk>
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

clean fit; guards can't be weaker due to umount_tree() call.
Setting emptied_ns requires namespace_excl, but not anything
mount_lock-related.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 898a6b7307e4..86a86be2b0ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6153,12 +6153,10 @@ void put_mnt_ns(struct mnt_namespace *ns)
 {
 	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
-	namespace_lock();
+	guard(namespace_excl)();
 	emptied_ns = ns;
-	lock_mount_hash();
+	guard(mount_writer)();
 	umount_tree(ns->root, 0);
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)
-- 
2.47.2


