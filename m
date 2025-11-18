Return-Path: <linux-fsdevel+bounces-68967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BEC6A6DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CE924F4BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5EC368260;
	Tue, 18 Nov 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc91gmXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A0F368268
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480994; cv=none; b=U0DY70YH6teuLDLZeyNan3VPNCIsDCbTMD39DxZHW4/vsl+7UfcTcusG/u4GCc/q5MPuS5dvzYjta/06PIL228x9BAgfSDHeLfXEMANb/Hw+n09abf40FoVipQoo7s1RmU8D3Ky/2ubUb68n/Cm+MNBgrjQVpTU805Acg4/KtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480994; c=relaxed/simple;
	bh=SXv0WnHeWxOaWXqJ0DGTF1sMZw3zpt+Lo/9HWPQFmf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7bxhUYQ8oucLwc20OL/MPRmvdTie4biJ65b1p7vSImRwETzphpKqxvAJ07pHBDE4Mm5lTqE5lxabx+ZS6YvQiT71IHfmG3IHv7qSJOS5l/MCVKQHEhicz0rKBDen+aQ5G7CAcJ4SA+uQonKxjXvGQlQpbkwyLoPUOPB8JQlHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc91gmXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C903C2BCB0;
	Tue, 18 Nov 2025 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480993;
	bh=SXv0WnHeWxOaWXqJ0DGTF1sMZw3zpt+Lo/9HWPQFmf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Kc91gmXCujo+cgZ1TAYQEuvDEtpXEj5Bc53QDVOiks+HG5G6/SsusfAamAduEdT81
	 aoGjw+CBxMywjIcawCPzGVFDyruwi8TFLf177NlE1RRujAfBG7AnMQ2jZhEV5VOAE/
	 RUByI3pzi7GuMnu9ZqVo1JoclBuiqhdlNE7lyswYwGCDxlxOZLO2gpwj2yr4dnrDCo
	 /GsHYAAQEML5zRgqvyg7FuLiClz9THcHWxUaMF6Tyth9Lr3AwCdZs55rc8M/XipuQ3
	 F8MAh0lG6/RO4N0JKqyao+KAc7Vx9L4VNiQLOqAy+vJks8ptVcmWtmxDk4pUwvyZp3
	 cTeIwTCQDWUvw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:48 +0100
Subject: [PATCH DRAFT RFC UNTESTED 08/18] fs: nsfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-8-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SXv0WnHeWxOaWXqJ0DGTF1sMZw3zpt+Lo/9HWPQFmf4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO1v1c5bMvm8X73TvmjrWx9jn+rUinTqvZ0/V9TjS
 ZTQROlJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZP4uR4X7etZuPt+lv23jn
 wgHHvL+KDJki53Z851K4VLvzhN4izk0Mv1kPCERenqd85Wx4aJjJ39r6Jd+OqXu1Tzxlnab6Nur
 3fgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a80f8d2a4122..cf20fba0ecd2 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -110,7 +110,6 @@ int ns_get_path(struct path *path, struct task_struct *task,
 int open_namespace(struct ns_common *ns)
 {
 	struct path path __free(path_put) = {};
-	struct file *f;
 	int err;
 
 	/* call first to consume reference */
@@ -118,16 +117,12 @@ int open_namespace(struct ns_common *ns)
 	if (err < 0)
 		return err;
 
-	CLASS(get_unused_fd, fd)(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdprep, O_CLOEXEC,
+		   dentry_open(&path, O_RDONLY, current_cred()));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-	f = dentry_open(&path, O_RDONLY, current_cred());
-	if (IS_ERR(f))
-		return PTR_ERR(f);
-
-	fd_install(fd, f);
-	return take_fd(fd);
+	return fd_publish(fdprep);
 }
 
 int open_related_ns(struct ns_common *ns,

-- 
2.47.3


