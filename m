Return-Path: <linux-fsdevel+bounces-58910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCCB33572
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C0F17B928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13ED27D784;
	Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AWlqoKs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEA524EAB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097040; cv=none; b=npNZhpxXNItaDFYVCsflSjYX/LQFg6q/gN5dclCSPwML7BCevE+17Dc9GVBN2FsP7ZvAM86k++IArGLYjCxFm/B30npYnjD2NXxba/CVG0Q+Z0GAW/8YT6WB63kuwM60QJnv18Ui4fJa29EEjeGR97ZgjlcSVFDruqgsooYxs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097040; c=relaxed/simple;
	bh=GUHaRM3AI44KtdubQgrjSbW+YtTy55kL4nGp2Wh40aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Of3Xh44PmqEZI8jVT1B9nCcguqb6iFnfddi6kmdgIA9TS/vwr2WAgranC7ncZpOfCpnTDZxc0G1GVw2jYmFoamIFB6wS6DY6UxmZrHiCisw4UEHYerfp/HpuTj4/u+T0JhWsj7ElEBCXoZcbwTkCqY6Uubtsm+QiKUwJt7FUAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AWlqoKs0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZdXh6Lu4GvwY34+m9fFbgqGzmmzJBwHBOdKEMsyc5Bo=; b=AWlqoKs0HoZplsRREVuMayFOLl
	yHA7ZKaPlDfl8tBSBHOvB5UaYpnGl6K4HCIJRXeM1iMbnP3rsImvz+6EeGzZjnnXFtdsiiGU17TK7
	M7orzNDMuJ4weTaTTX7X6zkqMhEdO0FaAK2cglwqSjJDtJIWQEe81+e491atjCP+EcSPgwQNX7zIa
	1IMfjss3nkqCfWlhi0UlMH85BsgrE8tDi77dANKVXrzGii8ShWp62utkcyXP+F6RVSHAhg3G8Ys0D
	TdkyyHU4Uows6UPoiH7HksYxJPjNhOqzPRBksW5KWT42tOQYCN+5FNNjRySVEEiyr/Zp1n9Xcvfju
	6jvwIN8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T8m-0xWx;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 06/52] do_change_type(): use guards
Date: Mon, 25 Aug 2025 05:43:09 +0100
Message-ID: <20250825044355.1541941-6-viro@zeniv.linux.org.uk>
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

clean fit; namespace_excl to modify propagation graph

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f1460ddd1486..a6a7b068770a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2899,7 +2899,7 @@ static int do_change_type(struct path *path, int ms_flags)
 	struct mount *mnt = real_mount(path->mnt);
 	int recurse = ms_flags & MS_REC;
 	int type;
-	int err = 0;
+	int err;
 
 	if (!path_mounted(path))
 		return -EINVAL;
@@ -2908,23 +2908,22 @@ static int do_change_type(struct path *path, int ms_flags)
 	if (!type)
 		return -EINVAL;
 
-	namespace_lock();
+	guard(namespace_excl)();
+
 	err = may_change_propagation(mnt);
 	if (err)
-		goto out_unlock;
+		return err;
 
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
-			goto out_unlock;
+			return err;
 	}
 
 	for (m = mnt; m; m = (recurse ? next_mnt(m, mnt) : NULL))
 		change_mnt_propagation(m, type);
 
- out_unlock:
-	namespace_unlock();
-	return err;
+	return 0;
 }
 
 /* may_copy_tree() - check if a mount tree can be copied
-- 
2.47.2


