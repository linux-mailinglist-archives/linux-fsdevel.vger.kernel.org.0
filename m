Return-Path: <linux-fsdevel+bounces-60048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752EB413C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0675E4834B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CD2D63E4;
	Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="npJp/jxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964B2D4B52
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875342; cv=none; b=hype4kT+S3MD9oqOyMxpWTuqUGho0ECPwjoAlPiDhhB/PCYTPsjsiFFwg/OcYRsXXlJcXeN9UX6dYGhRLA6Ai87k73qOeyDjl8mjyGVNjNDN7FSGcnVQYIWYC8GvwhAsACsJ8JlXbfTwJ09C/x7jyCJLeejMIECvNo0srD94o9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875342; c=relaxed/simple;
	bh=PQXX/Kcj9l+WkrFPDEBT+tr/60dmys/ff4mqeoYFwjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbmA1QMsxjpKYh+qJs2ZieTIVCqzXWsl93t8ZdFZ3VuGwABD9QirKhKvtWvDa9FV3BzrlzzoKVKgYQa5FNw2/W3YpWRZmFc49aKZwSrd95IzB8sHTelrW5TA3pBW448rJiGB9aJvfvQNE8QB4g+5NyjRti3be6rjynFbWWA17rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=npJp/jxw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hJHroDDz1lOT6aJfo8xM1wgESKO1dNPYmMVo4DS1KeI=; b=npJp/jxwjkefNlwOOwrxFYPPC7
	Vwcpb5HXlFH8Nt/EE1Bs+tpU0Y+RQzZxpp7a2xOQ6wtYFD9prPgZdcikOnEUoxvMo+M3bcgS8u3W3
	s2Gu2Kqzx/LLpo6qyODtC6slpyxjhnmUwGBG7niT3/RKWfs5wFevddL7zjLsloCcCE/NVK0SzjIPU
	2B+GDImAw1S8vsDS4OdxBoX0wpxBRHuoPOVQQtLmLkyYtoEBnjPGriCvDJxupdHsRZB+ujOT73dth
	luYkti6b+v52O1fVJ0isQg7q4UCNp8U6CZUfN3P6qV3c8o4u/MFoy6OvD/okOJXoB/hAS4E8tzvWq
	rY1LRfBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap6g-00qU;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 09/65] put_mnt_ns(): use guards
Date: Wed,  3 Sep 2025 05:54:30 +0100
Message-ID: <20250903045537.2579614-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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


