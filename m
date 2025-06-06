Return-Path: <linux-fsdevel+bounces-50837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D59AD010A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A33AE575
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35192045AD;
	Fri,  6 Jun 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HPcX9IJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9F2857CB
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208105; cv=none; b=vAJKfpp+EkW+t/rzbwDpu3zjBjv3spAQpqG+7Fp6OzXKeAF7+3JfV6oik5h0kOJVhQ7R+eFSiCSH/V+9xu77nmEWwmV3TsfW3cMfFqrt5wL+XZKPnafeusxC0a2SjTdNE3SB2bUYAl0KkptfIDU1cqwdeZUEVTgEYlmtsuwmkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208105; c=relaxed/simple;
	bh=CHP7ew/Et+ERAnaK25+q8VWiodq15pXg+mMICzBovxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VzfCk+Q/0XA12aOaFJyqzIjYSHa3U/k7FO1YjusTdSk6KkF/8dVb9Hp3NkiY5R4D8NtryZjLYE9AohM9WC2EuUrara91sPlLiq7rrkgHveEwZPAAJJ8+7xWacmmFfKo5ZI4jf4iPjPPwuFVAu7RFXeiBgTpmK+Tagw45O0X5aMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HPcX9IJv; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bDJTG19vWz7Th;
	Fri,  6 Jun 2025 13:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1749208098;
	bh=Zvrk4HYUoozthbO1/0n4L3/NA+73B6AAfyt++Mv471c=;
	h=From:To:Cc:Subject:Date:From;
	b=HPcX9IJvIEjkGIMAijSxJIYitR9OgUidYDUXcHQDAN3uNijVjax8Bmm0/PIEM4moz
	 5EfvYPc/mGNGs3FkGwcTpCzf8yL9/DuwRUH64sS3HoVxeJr0hm97HxrpqeAtqu0ve4
	 nGtuuNaK0OHMgKONTQn3TTau2lmKCCD3gua97UoI=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4bDJTF4mnpzp5L;
	Fri,  6 Jun 2025 13:08:17 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v1] selftests/landlock: Add test to check rule tied to covered mount point
Date: Fri,  6 Jun 2025 13:08:09 +0200
Message-ID: <20250606110811.211297-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This test checks that a rule on a directory used as a mount point does
not grant access to the mount covering it.  It is a generalization of
the bind mount case in layout3_fs.hostfs.release_inodes [1] that tests
hidden mount points.

Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/20250606.zo5aekae6Da6@digikod.net [1]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 73729382d40f..fa0f18ec62c4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1832,6 +1832,46 @@ TEST_F_FORK(layout1, release_inodes)
 	ASSERT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
 }
 
+/*
+ * This test checks that a rule on a directory used as a mount point does not
+ * grant access to the mount covering it.  It is a generalization of the bind
+ * mount case in layout3_fs.hostfs.release_inodes that tests hidden mount points.
+ */
+TEST_F_FORK(layout1, covered_rule)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s3d2,
+			.access = LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	/* Unmount to simplify FIXTURE_TEARDOWN. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, umount(dir_s3d2));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	/* Creates a ruleset with the future hidden directory. */
+	ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Covers with a new mount point. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that access to the new mount point is denied. */
+	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+}
+
 enum relative_access {
 	REL_OPEN,
 	REL_CHDIR,
-- 
2.49.0


