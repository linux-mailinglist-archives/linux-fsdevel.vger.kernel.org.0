Return-Path: <linux-fsdevel+bounces-59533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087BB3ADFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD58258371A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40E2D6E58;
	Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DLKHHjcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9812D0606
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422490; cv=none; b=KVbw/HmYpp8elC2kzl7xF0wkT5jcXNcp1oVa4UU4+ovg4YnSD1uK+cNlWSQAeAM0m+sbjXN0AgYa76w/5qw3s9mJhFw0GpneU6RHRm7ivOBwNfGhIXyjQ6Nnx+/1T2oHxzb4XCaaN4dnXgbHNZi/DAeIdoWwnF0bPdRTXg4krIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422490; c=relaxed/simple;
	bh=PKmc3FbUQjTUYy6SY+ce3KB6JTIGjEtZmGp7zzlLEY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9b8NrAdBxN4BGw7iRtGwfC7FY00UJ7cfFCOgnOC+F6thajI3TU+7URDC/AgBbJr/cH3iivBm64qSyeyaSNiMMJ8UJXp3RN4rliuHO9XXoVmOJM25gTTRcKz9k8RXHqaee9qNX08t/QDxQzKBdrgC7x9xxCuSC4uC1k+XXKa8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DLKHHjcM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ie3WjbHVzwJ3BMk7ywP55q4UVjfXeya3Oim2h3C5d5w=; b=DLKHHjcMR2qxM6DcmMAEGOCnNW
	8WQ6BUaiWimgNmLhytC+wATd7zsh4UW3FQd16G1nUBPz2zG52ELGUvFj2QvccHvxScZitKpxVkqBG
	aNc+b8U23kOPTe7Oglc9I3JENr95vOgPxcsmMXYse2+8U0QeI68ZrO2hIAPoq9/Wh4r9a5iFqnpPJ
	OgA94pTvmG4//nCA0NkfSN3TthnbM20GtbBYum1ZDvjXyeyrTK0kNGHk9Ln8rarMIjn5Z5ZCuDAzX
	O7N7vUUU0suTVX7HTj55MHUkN3D2KFcJTrrUbH+G3OAPhcJQIRocHtPjUCSWc4mvDxE3nckjFrc8F
	Wr4giJNg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F21R-28sx;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 06/63] do_change_type(): use guards
Date: Fri, 29 Aug 2025 00:07:09 +0100
Message-ID: <20250828230806.3582485-6-viro@zeniv.linux.org.uk>
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

clean fit; namespace_excl to modify propagation graph

Reviewed-by: Christian Brauner <brauner@kernel.org>
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


