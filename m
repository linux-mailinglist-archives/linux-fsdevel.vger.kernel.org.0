Return-Path: <linux-fsdevel+bounces-60118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F0B41411
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8A46815A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E92DECA7;
	Wed,  3 Sep 2025 04:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pZDr6wi6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE052DC321
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875359; cv=none; b=YxafO5oxZ+bHrLdOPt9goCpC702T0G0FTVU823kvYkFv1etGR8k5M6QqLO5QH0wVbak+we1kdbcDrqZxCg/3lfizFMKnQ2yOijSXzy7tQsJs5hFyjy5R4RouULzlQEXf52bni3sV+r/2Ibst88WNdkz+nFpsxxEus40FvSv5iLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875359; c=relaxed/simple;
	bh=7cECSn8F6pgUFIf4cZjWqsOPXb4cuYpG88B+W7vApXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWLax9/tOCMRbapfpraNncFjlTKt+2JsX/Av+Bm7e35sP9h8O+mawv2AyHnYLX6vjEfZzuCYkQYHZGaBYVeH+KJiUvO4xMUQfg/MIlmIvMFjHxvcsNsIzBynTdXF/VZi31eNr/GpvNwz+rlt4aiWwQ4DLSE+FCARhgmmSr8w/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pZDr6wi6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0j5xj+WHPJuVVmtQvkfjP+NxJ/KyI06DFl14iFivEGA=; b=pZDr6wi6wytcCkBC4LGcVjmxv5
	Q+Iw1hUUweyBPCzPpyFI5C+rO+Y651o9UflxmjX1LhSSRb10zXID2C6SvPZXqTGFjMBN/se5tCclT
	+60DyClMJDjm2CW9cIDErjYWhSv7lA1a0S55/CTjmJdmtTEagVC6skeNACgY9tOsmNJCnZktkmUW9
	9VraDX+pb3QuaI2Q9tR+mSn046jdCR3THLBbFy3+gA+8cVFlT0wmVoduUcRCU1BLsAlr1vZg5A8nA
	KFPX4l9ovNVE3RCqiAobjrr6Eqlyuz4SdJCDuZid6ARFNUW1PUSEs9H6bqIPhx9NLTkrX6RbSE29n
	Drvk3JFA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXI-0000000ApNX-2Tqo;
	Wed, 03 Sep 2025 04:55:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 65/65] constify {__,}mnt_is_readonly()
Date: Wed,  3 Sep 2025 05:55:37 +0100
Message-ID: <20250903045537.2579614-76-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        | 4 ++--
 include/linux/mount.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9eef4ca6d36a..c88fe350b550 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -428,7 +428,7 @@ static struct mount *alloc_vfsmnt(const char *name)
  * mnt_want/drop_write() will _keep_ the filesystem
  * r/w.
  */
-bool __mnt_is_readonly(struct vfsmount *mnt)
+bool __mnt_is_readonly(const struct vfsmount *mnt)
 {
 	return (mnt->mnt_flags & MNT_READONLY) || sb_rdonly(mnt->mnt_sb);
 }
@@ -468,7 +468,7 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 #endif
 }
 
-static int mnt_is_readonly(struct vfsmount *mnt)
+static int mnt_is_readonly(const struct vfsmount *mnt)
 {
 	if (READ_ONCE(mnt->mnt_sb->s_readonly_remount))
 		return 1;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 85e97b9340ff..acfe7ef86a1b 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -76,7 +76,7 @@ extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern void mnt_make_shortterm(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
-extern bool __mnt_is_readonly(struct vfsmount *mnt);
+extern bool __mnt_is_readonly(const struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
 extern struct vfsmount *clone_private_mount(const struct path *path);
-- 
2.47.2


