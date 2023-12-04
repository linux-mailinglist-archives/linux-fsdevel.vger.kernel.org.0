Return-Path: <linux-fsdevel+bounces-4745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63B1802D3F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B95E1C209C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C896FBE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hS+KtsOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8471BE;
	Sun,  3 Dec 2023 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=Bgwfb+pVaZrTgWleM6LMFvhfRSLvAMWx6yDuVgjieRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hS+KtsOGw+GkISuRELYWbCR6vRk45wcNHZKHpo4XsB5+XM3eXIrVJpfiK0t8zlEQI
	 mIt3XWEubn3fTpXUeuFj8Yo1pDmok1buwCVfburMkLyYAOmG3cjdeIJ7NzYK4hRJY6
	 UDnZrzYSCHhBMv1pgPXBF30Vu3at8PTzvtgbHQkc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:28 +0100
Subject: [PATCH v2 15/18] sysctl: allow registration of const struct
 ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-15-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=3419;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Bgwfb+pVaZrTgWleM6LMFvhfRSLvAMWx6yDuVgjieRE=;
 b=hS2QmFvAg4VXxquXbstpDfzCkvr3rvB9crvRKmffiTA7i23BVWn4ObMCxEzeZPYrUhn2F4IbL
 N8KOruqBeCPCRkK62ZIkp4Hmw1w2oAsG+SM7NulyfuKFMlSyp2QJtZl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This allows sysctl table to be put into read-only data.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  |  6 +++---
 include/linux/sysctl.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index e7fd1680d479..d09107a5b43f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1356,7 +1356,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  */
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table, size_t table_size)
+	const char *path, const struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
@@ -1417,7 +1417,7 @@ struct ctl_table_header *__register_sysctl_table(
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size)
 {
 	return __register_sysctl_table(&sysctl_table_root.default_set,
@@ -1446,7 +1446,7 @@ EXPORT_SYMBOL(register_sysctl_sz);
  *
  * Context: if your base directory does not exist it will be created for you.
  */
-void __init __register_sysctl_init(const char *path, struct ctl_table *table,
+void __init __register_sysctl_init(const char *path, const struct ctl_table *table,
 				 const char *table_name, size_t table_size)
 {
 	struct ctl_table_header *hdr = register_sysctl_sz(path, table, table_size);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2f4d577f2e93..7c96d5abafc7 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -229,13 +229,13 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 
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
@@ -257,7 +257,7 @@ extern int no_unaligned_warning;
 
 #else /* CONFIG_SYSCTL */
 
-static inline void register_sysctl_init(const char *path, struct ctl_table *table)
+static inline void register_sysctl_init(const char *path, const struct ctl_table *table)
 {
 }
 
@@ -267,7 +267,7 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 }
 
 static inline struct ctl_table_header *register_sysctl_sz(const char *path,
-							  struct ctl_table *table,
+							  const struct ctl_table *table,
 							  size_t table_size)
 {
 	return NULL;

-- 
2.43.0


