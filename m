Return-Path: <linux-fsdevel+bounces-24514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D482D93FFB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C5F1C22478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189A18D4DA;
	Mon, 29 Jul 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hiPVmPQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4A1891B8;
	Mon, 29 Jul 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285831; cv=none; b=Wk6VLvHplY0HhWpafDu0laXMUbW1ZCn/FhUeZed7UjgTRcyOi+vQRQ+irzJYnN/vzIL5H+wEp2N6Cd1Gmgtx9re9jpDPpJpmHRhGzC2x/NwGJw7MnUGK5iRbdzyIWPZ7TU6DoE/nWXM2a3xUjEEiMHsXmUIvyRflejYkEIViHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285831; c=relaxed/simple;
	bh=eBR9mLKyR+1Vm40w0K6RV+ewAxwcZvcVWHkLIwPlM/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNTrFZPcI/Hc7VMzQUIN0mRbiXERJQn9pHv28ByZOslwz+iGMgJnS9d8IZyAHur81i6XzAD2qu0DBJKoM122FFVBdf+iOP3GDTIq3tdIkXe14iphkGjgl9b5nicuCVgmMOWCCmusn2dD71ZyBH594vOq4tdrcOvkjvi6DaYgJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hiPVmPQQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285818;
	bh=eBR9mLKyR+1Vm40w0K6RV+ewAxwcZvcVWHkLIwPlM/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hiPVmPQQxh3rtvNeRv0hFqYq9KcWd7pJChdrwRIGQOi3A74Qmxk8QKw/RequWo3Xl
	 3jg+isS+iDZj22KdfqnNiBqz7jqYEFJ3CLA653JG1jO102eLbYrhdTMfKafBRJkF0U
	 SLjkTyRVxzIWjYNVtk7ZtAA1svXs0gIHZf0jjCZw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 29 Jul 2024 22:43:32 +0200
Subject: [PATCH 3/5] sysctl: allow registration of const struct ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-sysctl-const-api-v1-3-ca628c7a942c@weissschuh.net>
References: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
In-Reply-To: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=3585;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eBR9mLKyR+1Vm40w0K6RV+ewAxwcZvcVWHkLIwPlM/c=;
 b=gKC2S9/35q9gVhQwvAeGADioL+dzgjlSbKVf6WTY1O/kWKfJD5cjNvyaMKA2nPOL00Tw/jUW7
 TQpFe01SYtQDBFRRtH/ij4kSX8gP+SqfCIuAXy8VoL2K7y2S8ISikCj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Putting structure, especially those containing function pointers,
into read-only memory makes the safer and easier to reason about.
Change the sysctl registration APIs to allow registration of
"const struct ctl_table".

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  |  6 +++---
 include/linux/sysctl.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fa8cf9bf2988..01e006cc1163 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1354,7 +1354,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  */
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table, size_t table_size)
+	const char *path, const struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
@@ -1415,7 +1415,7 @@ struct ctl_table_header *__register_sysctl_table(
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size)
 {
 	return __register_sysctl_table(&sysctl_table_root.default_set,
@@ -1444,7 +1444,7 @@ EXPORT_SYMBOL(register_sysctl_sz);
  *
  * Context: if your base directory does not exist it will be created for you.
  */
-void __init __register_sysctl_init(const char *path, struct ctl_table *table,
+void __init __register_sysctl_init(const char *path, const struct ctl_table *table,
 				 const char *table_name, size_t table_size)
 {
 	struct ctl_table_header *hdr = register_sysctl_sz(path, table, table_size);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index a473deaf5a91..202855befa8b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -223,13 +223,13 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table, size_t table_size);
-struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+	const char *path, const struct ctl_table *table, size_t table_size);
+struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
-extern void __register_sysctl_init(const char *path, struct ctl_table *table,
+extern void __register_sysctl_init(const char *path, const struct ctl_table *table,
 				 const char *table_name, size_t table_size);
 #define register_sysctl_init(path, table)	\
 	__register_sysctl_init(path, table, #table, ARRAY_SIZE(table))
@@ -251,7 +251,7 @@ extern int no_unaligned_warning;
 
 #else /* CONFIG_SYSCTL */
 
-static inline void register_sysctl_init(const char *path, struct ctl_table *table)
+static inline void register_sysctl_init(const char *path, const struct ctl_table *table)
 {
 }
 
@@ -261,7 +261,7 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 }
 
 static inline struct ctl_table_header *register_sysctl_sz(const char *path,
-							  struct ctl_table *table,
+							  const struct ctl_table *table,
 							  size_t table_size)
 {
 	return NULL;

-- 
2.45.2


