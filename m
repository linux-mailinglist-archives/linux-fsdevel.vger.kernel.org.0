Return-Path: <linux-fsdevel+bounces-58929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EBB33585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA6C18898D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850E28315A;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OtqgZDOd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A32797A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=doyCxMnlIurWtQJdLBtY0ivfiDKFQ5VEPKpEcZ3A5wthD9J5apXYdeMjmQQDRlPr9uTiVOiKatuswKuQxB88SvJfkqt7C9G9G1KHD1uiGTH3CWMDc+tqpevoFHMvFnJoD2NFuHRm4JyyaNXRH/tzO7UEz1LuHEaLIbf2Vg4+P2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=axkvnzD8zgXfeG7xPfWTFjQfekKLAt8A/L9atO27SEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guFczs2Tg3VikXW8QImMaWOHantNQtw4L/yz56a5pM5rc4OlIYWBFx/sIbLQf/fTmFco9l4PRkdB5dEmld8IuOljK7C8UfSb6QU5ng4bQRFgSuROitLBSJjFlF3ZprPJOvvd3kXDDgVk52hcDdJlaAArrUuLdhGj/Dvzb/KdVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OtqgZDOd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zD7PiBrM0uyl66GMtGe4/AB9K5Yi/tbGdGRmXai1bA4=; b=OtqgZDOdWy4h48BIP2lwfYPUVb
	DOMwQty+FLPNdUhpb4iMQEA69MdukvMqrTxJ65B7OTGWan1iuidZoeVzRmLJPWA5qm/m0JC+5UUPD
	lxD+09MSqpJO4oZMQ2tNrEIU4BgmdZIOJpheKTq2mRdfrmLqJDDBMdHcz5ApLnhNDNXGOzaYomyZz
	j9sadNrl+XfkFHCatDRFxK+vOOqPZrstITt96/ChZPtYkDYsqf2SjLp+WHNGqH2IWeTOFcL6AiXRf
	LDEdwWZu1I9KZolB00TlrbZsDtjbekTQ+3mFoD8RNQnJLczPra74/X9u9Zy8MxEP2nvTC4+0liufB
	Rj9E25BA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TCt-2Mjz;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 31/52] pivot_root(2): use old_mp.mp->m_dentry instead of old.dentry
Date: Mon, 25 Aug 2025 05:43:34 +0100
Message-ID: <20250825044355.1541941-31-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

That kills the last place where callers of lock_mount(path, &mp)
used path->dentry.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9ffdbb093f57..494433d2e04b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4682,7 +4682,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	if (!mnt_has_parent(new_mnt))
 		return -EINVAL; /* absolute root */
 	/* make sure we can reach put_old from new_root */
-	if (!is_path_reachable(old_mnt, old.dentry, &new))
+	if (!is_path_reachable(old_mnt, old_mp.mp->m_dentry, &new))
 		return -EINVAL;
 	/* make certain new is below the root */
 	if (!is_path_reachable(new_mnt, new.dentry, &root))
-- 
2.47.2


