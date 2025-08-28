Return-Path: <linux-fsdevel+bounces-59570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01FB3AE27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AB65838C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8A2D5C92;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h6IxN3x6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82022D1920
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422496; cv=none; b=ijbsBISZHE5U6j3lk/JoYf+icBNJy/fLDNgDUBzXf0KFlw97iwE4cZp8mqwbgxRf//r6RsH5cLv1tfRS2xfOmi5Pb/ZyIu0zZwhSLLJdloG8HsnI0oCoYahC2zZInd/Dqp+159VfDtRHObilrixe0fgJQPkSosTPpW7ECoUKyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422496; c=relaxed/simple;
	bh=7aeR/Tu7Z3LjFMHDsnSkdgikaoEJ1/xIUKUBo/yPSLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRpMza+o+8Ap6+bQX5w+7eiG0ttR2faISNM8Xd/Ac/Y67n+qWOr0fCDi65dYIHCYxm2XOREHo+IxA0xepARjpPUx+pe5m+CIjVwjREk68+FdetrcklPNTuNTUD7chaMrQZQWN5bFQyZ86j6DERjEpOl8n3wxRGRaGGR0IMm7lWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h6IxN3x6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rPs2/1ATL5WDkM7MBT31PFlq4+kF6bnJ7nSBuYiFOIQ=; b=h6IxN3x67NRFwE3re7jMnEQQju
	34kl9lQu3r/vJnvdcSgzCOBbH/jXtEiemhpi2fu0+ynC5aR/mE0P+5BLGBsAN/FQgj2b8Sp/84emX
	ArFr6Ftvm+JJ6ED7v0kuMrhDVC/2G5ahUgUMWDHYemzabm5ctxhvTHst9rH6YwdcPju1UUNRn8q5X
	lZ3LpvhDGl6XLvDnzlErlUqwdbKlCMm7Jb86JX2EEGwKGXligYcQ2LRmezgLSNEIdadJ2gnV1ZNLg
	VNX8153LHErRXWmyZyaCAQnYsca5+n0lRkdh8GbDkZ8rJF1md2g+bJxPe7GtixymbyHLH6Nj6sBV+
	iNrMxrHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F28G-1IcR;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 44/63] do_{loopback,change_type,remount,reconfigure_mnt}(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:47 +0100
Message-ID: <20250828230806.3582485-44-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8ff54e0da446..6ae42f3a9f10 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2914,7 +2914,7 @@ static int flags_to_propagation_type(int ms_flags)
 /*
  * recursively change the type of the mountpoint.
  */
-static int do_change_type(struct path *path, int ms_flags)
+static int do_change_type(const struct path *path, int ms_flags)
 {
 	struct mount *m;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3034,8 +3034,8 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 /*
  * do loopback mount.
  */
-static int do_loopback(struct path *path, const char *old_name,
-				int recurse)
+static int do_loopback(const struct path *path, const char *old_name,
+		       int recurse)
 {
 	struct path old_path __free(path_put) = {};
 	struct mount *mnt = NULL;
@@ -3265,7 +3265,7 @@ static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
  * to mount(2).
  */
-static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
+static int do_reconfigure_mnt(const struct path *path, unsigned int mnt_flags)
 {
 	struct super_block *sb = path->mnt->mnt_sb;
 	struct mount *mnt = real_mount(path->mnt);
@@ -3302,7 +3302,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
  * If you've mounted a non-root directory somewhere and want to do remount
  * on it - tough luck.
  */
-static int do_remount(struct path *path, int ms_flags, int sb_flags,
+static int do_remount(const struct path *path, int ms_flags, int sb_flags,
 		      int mnt_flags, void *data)
 {
 	int err;
-- 
2.47.2


