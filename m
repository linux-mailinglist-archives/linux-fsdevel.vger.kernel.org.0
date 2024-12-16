Return-Path: <linux-fsdevel+bounces-37565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D70C9F3DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 23:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D94188626F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 22:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB51D89EF;
	Mon, 16 Dec 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLYZv18H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701D1D8E16;
	Mon, 16 Dec 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389121; cv=none; b=AXQ2dpetPOB9mYAzpTu0sW5PHEX+YaJ/K71M4IxV3ZP1EDFLCpkHYeJ41V4HZ73i4bhBVUgvjDdyPH0kOuQOqjhdFExAZf2Ul/oqiEvHeaRZfEPrk41s5HcWZ0dlS5Acz/mrso/plZysyaiGsyDKggvKFz3PW1mEyGzq0sjm3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389121; c=relaxed/simple;
	bh=e9KQqpj/sEwKdaCNmKMD0QnmSVljvgmzt9ByIs11ScE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IpCgq31mnKXiWyvOBezn/C7HpAWD/yduJQVFDn92vbOUWZijwPgZpeWO82MfpjAOa81WTvkKzMBW68DsNKumy1MLFSXqrcPuPohQNlDgJ2QIex5JiFUzO4JJtxikdoIqkrmp8Paa6jtKzM0LF162JxUpFwOLxxvCoJeWwQ4Ve88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLYZv18H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACD5C4CED0;
	Mon, 16 Dec 2024 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734389120;
	bh=e9KQqpj/sEwKdaCNmKMD0QnmSVljvgmzt9ByIs11ScE=;
	h=From:To:Cc:Subject:Date:From;
	b=iLYZv18HqsqQnRBtWClA6oKbzOuu9uvcWwWXgEmVVi/BBtSJtsbrDbjgY9mQ/gEb9
	 xI2w9J8nb+i40n0xHDVR+vtDFIPEj4xPCckTpxEl9LvIRTtXEio69xpRtQNC4bdmNR
	 iYuVCI4Q7ovhT5vz8CCH2NTwI3g4UCypBwWzp0H/T6kgESZDiqUH+eLQ12lWaQCDqZ
	 BOutENXKARpA/WFnv0Ywm6JJCaQigADjQhbvtWvrHJ+lAbGxxsBRiTCaH94y6/REqb
	 iRlaCVegLS18TYD/JJfZMuI3MgA6u3WGBRItl1g1caGja9hkJGk3tFhF2y6/aLHAvp
	 N4Z7YWgHKDXKA==
From: Kees Cook <kees@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] inotify: Use strscpy() for event->name copies
Date: Mon, 16 Dec 2024 14:45:15 -0800
Message-Id: <20241216224507.work.859-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=kees@kernel.org; h=from:subject:message-id; bh=e9KQqpj/sEwKdaCNmKMD0QnmSVljvgmzt9ByIs11ScE=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkJa6seChXKdd7qZjgw1ynxvMylO97NgaVhen9qT255f Oas2xn9jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkEXGRkuPrg35zdf68erFHe ojiTb2GXqdOaR9fruZNirG0eticZ/2BkWLT8+WFORt1Z2mknhENeSS1Z8eC2iGvhIr3DLNx9c3P dGAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since we have already allocated "len + 1" space for event->name, make sure
that name->name cannot ever accidentally cause a copy overflow by calling
strscpy() instead of the unbounded strcpy() routine. This assists in
the ongoing efforts to remove the unsafe strcpy() API[1] from the kernel.

Link: https://github.com/KSPP/linux/issues/88 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 993375f0db67..cd7d11b0eb08 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
 	event->sync_cookie = cookie;
 	event->name_len = len;
 	if (len)
-		strcpy(event->name, name->name);
+		strscpy(event->name, name->name, event->name_len + 1);
 
 	ret = fsnotify_add_event(group, fsn_event, inotify_merge);
 	if (ret) {
-- 
2.34.1


