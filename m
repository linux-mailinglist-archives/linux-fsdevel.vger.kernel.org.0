Return-Path: <linux-fsdevel+bounces-24992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929579478A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C591C20EBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA4155A53;
	Mon,  5 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EjghtQti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BC1514C8;
	Mon,  5 Aug 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850831; cv=none; b=eWY3s6pmu8MTPTp3U7NAcNQn9AUU31YgororhmCNKMl/cw7CoGBShbFDLnK+qcn35BC1VtwRT5XLgFA7oPb83QwxYKa4XRHTcKf4yggv3ww4VnbfQLhkSser/Vgx7F5AYKTzSmprMP7RaYtEH8q/MuJRe2mIRPSkRllpJxN6alA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850831; c=relaxed/simple;
	bh=sYgXbuAakfwcEWfFa7hRpS+UDd+V5VwsrPZWs4c0MYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRR8Q22b49ciR5KkV4iwzxG4Se2DHpCXrBKe0yJkAui32+pjRS/URiEF9d/f8abQK1t9Y6YE4cYRRVXnS64/hkJ4LOfeMMYQWYit06DiLJH4yBVgK+UyQhUEcXcrUBEHQGIY5urVUXv/l6kOiccDeY1JQ+mqM6Whw0cU5Br0tUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EjghtQti; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=sYgXbuAakfwcEWfFa7hRpS+UDd+V5VwsrPZWs4c0MYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EjghtQtiKtCR+Ucp1DSrqpKL+pmRD14NiMyVsnofneY2pOynzO20CiuMCCIMeGKG3
	 bf3ZhbMEKkS8dOoBh3wkHfn4V+bLEeUBzMEOsYJNnop9Ox6xX0w19xKJ5gkB+udNOQ
	 QZ2cn6UiqrdSpmf3WUwMY3IbI/R8mrYPDvof2RFI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 05 Aug 2024 11:39:38 +0200
Subject: [PATCH v2 4/6] sysctl: allow registration of const struct
 ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-sysctl-const-api-v2-4-52c85f02ee5e@weissschuh.net>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=3585;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sYgXbuAakfwcEWfFa7hRpS+UDd+V5VwsrPZWs4c0MYg=;
 b=PqK4Z0y5K3CQwqPhV9j4PB7rRVoJqPyP+5N2OsiJ6tFFgbkinzKKN+AkEJgLrtm/cFk9Ap2Fw
 ieLXYaf/qmBBJWcNqNwy5ED9wfF/Bt6ZDQQFR4k3BxNdzzmAMItiuGX
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
index 713abccbfcf9..968f8dcffd8f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1359,7 +1359,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  */
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table, size_t table_size)
+	const char *path, const struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
@@ -1420,7 +1420,7 @@ struct ctl_table_header *__register_sysctl_table(
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size)
 {
 	return __register_sysctl_table(&sysctl_table_root.default_set,
@@ -1449,7 +1449,7 @@ EXPORT_SYMBOL(register_sysctl_sz);
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
2.46.0


