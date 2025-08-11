Return-Path: <linux-fsdevel+bounces-57248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB0B1FE82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3171898DB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 05:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659ED26FA4E;
	Mon, 11 Aug 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcqhyHqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445D3FE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889964; cv=none; b=l1/1pKEmuFmwdTsqgD0/6mUViQH6epTVB223EGrUeYeUggX+QHZnGZMuV2TrJ4n/qcXXgGEG3p5w4UtG89jW2qvkR8klHCVQU5Phz9L7xtc3sOzN3yHo6RmrRBajifUVjmEkhaQK9XGdG+4gcxEPVXLaN6U+hfGB8c39oPHK2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889964; c=relaxed/simple;
	bh=NNDGtBLpnRoQigFULzNfJgs80+9RGRJEtrbVf7zpZ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngkYXw0RXXxmvUsdBKVQ4rcWM2E8yRoFlosR9ds4cjX2fC4B6gPFO23hnyjjIz0C2cHkyDjAUCJuO1qFq9eRg1ln4zfstFFGf0ae9EJdw+KKwNY8VRj1Ze782isdXf8k2QCO+RXJsO3Bu6/dfOPovAxWaJDBrqSnHknNHEzngDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcqhyHqk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754889956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TIdC7jAQgd8cJ46AKFrFCkfnkGDYD5aUIIx17ql8cuI=;
	b=xcqhyHqkI91jlA+iYThKGWRbFwm5w0+OJ4nBb1Up2XQS6zeBBxyk28S7/B+2h8Xya5Yxk2
	H/sJMs5y7EkV8S08sCakQAIGFgGbIx3QZqGd0HVLyXJChVTfOUz9cm+NDfdP2CevsJl6mX
	TaI5krVFH5xpqDBUAf+osIaPoT/34Y8=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] fs: fix incorrect lflags value in the move_mount syscall
Date: Mon, 11 Aug 2025 13:24:26 +0800
Message-ID: <20250811052426.129188-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The lflags value used to look up from_path was overwritten by the one used
to look up to_path.

In other words, from_path was looked up with the wrong lflags value. Fix it.

Fixes: f9fde814de37 ("fs: support getname_maybe_null() in move_mount()")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 fs/namespace.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..43665cb6df28 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4551,20 +4551,13 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_SET_GROUP)	mflags |= MNT_TREE_PROPAGATION;
 	if (flags & MOVE_MOUNT_BENEATH)		mflags |= MNT_TREE_BENEATH;
 
-	lflags = 0;
-	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
-	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
-	uflags = 0;
-	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
-	from_name = getname_maybe_null(from_pathname, uflags);
-	if (IS_ERR(from_name))
-		return PTR_ERR(from_name);
-
 	lflags = 0;
 	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
 	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+
 	uflags = 0;
 	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+
 	to_name = getname_maybe_null(to_pathname, uflags);
 	if (IS_ERR(to_name))
 		return PTR_ERR(to_name);
@@ -4582,6 +4575,17 @@ SYSCALL_DEFINE5(move_mount,
 			return ret;
 	}
 
+	lflags = 0;
+	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
+	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
+
+	uflags = 0;
+	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	uflags = AT_EMPTY_PATH;
+
+	from_name = getname_maybe_null(from_pathname, uflags);
+	if (IS_ERR(from_name))
+		return PTR_ERR(from_name);
+
 	if (!from_name && from_dfd >= 0) {
 		CLASS(fd_raw, f_from)(from_dfd);
 		if (fd_empty(f_from))
-- 
2.50.1


