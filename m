Return-Path: <linux-fsdevel+bounces-59569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F2B3AE2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350EC3B171A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2562C2368;
	Thu, 28 Aug 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OakzR+m3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39872F0C5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422496; cv=none; b=jWp7LZopa+11VGe4CJ+pTVHGQjNwNi/ZLofLz4wSv8D1844zJzN0b8QiilDxOIXhiULOfzEWgOINMuX5MBTrZIBtAI+xSqdpY/k2xkaLyjixOuXyLsYhvFqS3017P1gQxNCQhBpwZQFmDPcvARYiuBpou/2in1ACfYk7ooBgTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422496; c=relaxed/simple;
	bh=yI35ysIIGa+Cxrwx0TJXKG2znJQksHq7MQm4e4T5GFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d73MbsTe6SgeZukOIo2el6RlT1DO02DOcn9OiyUciKdo+Vp3lrSY4R1A8Au0JzDA2PpsfE11iV78t/xQkoq2C4515LK8aOzwLpgyCgILbhcF7ptfRyZzewSZxUOMQDyTtw6ZooRn1cRKIgSiwscLnYMfU2Q4NSv4ufYqVGjJm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OakzR+m3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tlyJM1r8YwEE4PJiTyNjhetAKskZvQ5k6/jCoJWzHu8=; b=OakzR+m3vb5/pC5KYHd+fH5cnY
	zp0ZF9LMDf9oJUY0C8B8Zmp3Y60ZGXOdsq1RkFjENU3Y01Mk12FADmp2jNCIpIutuBsCjlPtSWfj6
	8I8qSCOqHYtV45hbSnPYDp2togMTneUAxWcG6rQltzpmtWidmE+DOjoj6ELbKDaqIWC+T1+3Bk+MM
	JKV3L1Q/HXhFCZtFIfTPbK42xNf7S+DTDIzVLzBVg8Xq+Q570P9TBo3Jq7gW5ajqI9mAX001PoZhq
	9Zh+EyXcWwaXdWecLSIyQwYj7gxrpOaTzQKhEJGWloeu8dMchyFpUeNbqgzslFVoIQzNGGlteduoS
	Mn0enqpQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F283-08Qe;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 43/63] do_new_mount{,_fc}(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:46 +0100
Message-ID: <20250828230806.3582485-43-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7c840371a7f..8ff54e0da446 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3704,7 +3704,7 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
  * Create a new mount using a superblock configuration and request it
  * be added to the namespace tree.
  */
-static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
+static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct super_block *sb;
@@ -3735,8 +3735,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
  */
-static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
-			int mnt_flags, const char *name, void *data)
+static int do_new_mount(const struct path *path, const char *fstype,
+			int sb_flags, int mnt_flags,
+			const char *name, void *data)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
-- 
2.47.2


