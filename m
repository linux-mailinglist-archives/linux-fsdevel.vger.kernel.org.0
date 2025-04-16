Return-Path: <linux-fsdevel+bounces-46559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FAA9043E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6201D3AB491
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF771DE4CA;
	Wed, 16 Apr 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUqaS0B6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04F1BC07A
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809466; cv=none; b=Tr8HG6skFwRS8gNkxvU1o7Y92RjipYaVLrm0tzk2fODFH+jB/Rip/LvDIiu88sIPJhcJERbpKG9I1RQDVFPwSHkiGYlua85HYd9S7KwtQKbNnflt9Pp1sLITIYMyuE6+WfNA7MClm/u9COhtgVyt+zOozI+OoWg80qKH6Ibq0xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809466; c=relaxed/simple;
	bh=we5F9y+12G5ioorWPSE8WE8Y3WemBLh+b3ZiiWrpCxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvePvNIm4dAu1lBnAZXBqamUAKdnTFgGLlSP3UFpVaPyBV23hraJDyuZZCqW5bfD+ZmeWBhA+8y7fN0Eh9bKTBkqB+HXCcp6veytu6oa2oyR8NQARcg9OYlnKCEakDkNZY/o+lm29uTXFdNlIJI8BYr9ZQfQpN1pxNgUQScZal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUqaS0B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAABC113CF;
	Wed, 16 Apr 2025 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744809466;
	bh=we5F9y+12G5ioorWPSE8WE8Y3WemBLh+b3ZiiWrpCxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUqaS0B6BJdcsxjqHX7g/hyBKuFf/SYtMyHNWonEb68qkA9v81pLHsqE1sEinqKLp
	 B58R0nvRpwqiATOjhLV2eoJB70a8Pp21AhcvZvauc3cTOBZYZi/IQqrPr6hV5cy2Vk
	 /D3PuilPIh1d32yN9yRpRxXnPeMW4FOiP1zRM3Av1a4eT0KQOK8lpVHBA5Seb5KHJ9
	 PPPDs+dX3YOBjmDFkRXpByj77emN86OoqomBwt1BxO19L1W54WIBphTJXOeuoJnhm4
	 57f6ycEDbfnY5INZj0GSxMNp0JtXorCxTGX0E9WuZFV2kXDTXLsbaLFiiO51J9iwS+
	 w2y7YWkEAMBmA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 2/3] mnt_idmapping: add struct mnt_idmap to header
Date: Wed, 16 Apr 2025 15:17:23 +0200
Message-ID: <20250416-work-mnt_idmap-s_user_ns-v1-2-273bef3a61ec@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3213; i=brauner@kernel.org; h=from:subject:message-id; bh=we5F9y+12G5ioorWPSE8WE8Y3WemBLh+b3ZiiWrpCxI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/X/tkw5k167x2Fx5ua1rP/Msg2Caj7tShDz6ZQUcj4 muKfDbs7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIHDVGhhWBTwoSJc57yB4P Wshi1mf9vWv/dzUrpfeZD6fE/NjHbMzI8Dhlwvvfd+tqF25+6Cu7avLEvgquZzOX2C6skJDaF73 ZhQ0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The next patch will inline all current helpers for that we need access
to struct mnt_idmap internals from the header. Not my favorite but
whatever.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mnt_idmapping.c             |  6 ------
 include/linux/mnt_idmapping.h  |  7 +++++++
 include/linux/uidgid.h         | 23 ++++++++++++++++++++++-
 include/linux/user_namespace.h | 23 +----------------------
 4 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 8f7ae908ea16..5c7e1db8fef8 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -17,12 +17,6 @@
 #define VFSUIDT_INIT_RAW(val) (vfsuid_t){ val }
 #define VFSGIDT_INIT_RAW(val) (vfsgid_t){ val }
 
-struct mnt_idmap {
-	struct uid_gid_map uid_map;
-	struct uid_gid_map gid_map;
-	refcount_t count;
-};
-
 /*
  * Carries the initial idmapping of 0:0:4294967295 which is an identity
  * mapping. This means that {g,u}id 0 is mapped to {g,u}id 0, {g,u}id 1 is
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 85553b3a7904..4410672c2828 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -8,6 +8,13 @@
 struct mnt_idmap;
 struct user_namespace;
 
+/* Don't touch directly! All fields private. */
+struct mnt_idmap {
+	struct uid_gid_map uid_map;
+	struct uid_gid_map gid_map;
+	refcount_t count;
+};
+
 extern struct mnt_idmap nop_mnt_idmap;
 extern struct mnt_idmap invalid_mnt_idmap;
 extern struct user_namespace init_user_ns;
diff --git a/include/linux/uidgid.h b/include/linux/uidgid.h
index 2dc767e08f54..5696c870fd0b 100644
--- a/include/linux/uidgid.h
+++ b/include/linux/uidgid.h
@@ -17,7 +17,28 @@
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
-struct uid_gid_map;
+
+#define UID_GID_MAP_MAX_BASE_EXTENTS 5
+#define UID_GID_MAP_MAX_EXTENTS 340
+
+struct uid_gid_extent {
+	u32 first;
+	u32 lower_first;
+	u32 count;
+};
+
+struct uid_gid_map { /* 64 bytes -- 1 cache line */
+	union {
+		struct {
+			struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
+			u32 nr_extents;
+		};
+		struct {
+			struct uid_gid_extent *forward;
+			struct uid_gid_extent *reverse;
+		};
+	};
+};
 
 #define KUIDT_INIT(value) (kuid_t){ value }
 #define KGIDT_INIT(value) (kgid_t){ value }
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index a0bb6d012137..6feae94c3661 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -12,28 +12,7 @@
 #include <linux/rwsem.h>
 #include <linux/sysctl.h>
 #include <linux/err.h>
-
-#define UID_GID_MAP_MAX_BASE_EXTENTS 5
-#define UID_GID_MAP_MAX_EXTENTS 340
-
-struct uid_gid_extent {
-	u32 first;
-	u32 lower_first;
-	u32 count;
-};
-
-struct uid_gid_map { /* 64 bytes -- 1 cache line */
-	union {
-		struct {
-			struct uid_gid_extent extent[UID_GID_MAP_MAX_BASE_EXTENTS];
-			u32 nr_extents;
-		};
-		struct {
-			struct uid_gid_extent *forward;
-			struct uid_gid_extent *reverse;
-		};
-	};
-};
+#include <linux/uidgid.h>
 
 #define USERNS_SETGROUPS_ALLOWED 1UL
 

-- 
2.47.2


