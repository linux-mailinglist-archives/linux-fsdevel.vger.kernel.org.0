Return-Path: <linux-fsdevel+bounces-56715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE9B1ACEB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AD617F255
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353F202960;
	Tue,  5 Aug 2025 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="k1CvXzcu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C131FF60A;
	Tue,  5 Aug 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365720; cv=none; b=hTQXLEe/NUKyCp/nbwbwSUp7WVuR455hgsMwRoNU82+8PgLPSqLTgUTd7X8QkT1ieKQMW3vnbor2Euquwh0RHrbCiwFPBfq+k8G9BI7fVFxkQTViwlIXTG5GwVnN+89/cKEiIe01xb/ekY6Nz5l5EGvcwe5rbRfKxVKM33aVoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365720; c=relaxed/simple;
	bh=FPtU/Ai5R8Lg4jJU5bAB80XGoKwS7ujyhiZIPUUWmik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLzqQceyKB2JJVNJ4b3+Hw+GvpNAWTH6tC94w+XuROWzw56Qbd2AFy7bbjX+TpM3y8i8uq8TYHeZhNPA3LBhD7EEmR5yF3Bp6G9z9nITKMWUfo6JxTMdWJSYGDuae70NVE5v2watH/7FLs4NwHT8dTeG/o1S+XeWPlNXm9zXU7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=k1CvXzcu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u5dqYFffPUWN7EHk6iUKXgaTVbZf4mOJ/Ftz9RBn1Fo=; b=k1CvXzcuULqwgn8QJB4+m1B7Qb
	16+nV4+tpLB5TekWVhB2GcQ84hyeRCnJDvBog+434Jfjm3afgDVM4FJCtG4qnr/CGg7rnXOVC+lrY
	60LOeE2Ceh7Y1UqM2DtFBeNwISE1vubx7xh6CMDI6ZO8y+IdchhNGNHtP63f6jds6ceMLOohsHZa3
	I80o39eUq4AHt7S9O1Ncb2OJr1VPK6bqrt7Pc2XmCrUEK8iWwSFWAN7i6mOJZ37+EvfLlm9KQCVJx
	kIkxLOlxCLaQz3eKQyoEExDidt4eJ/chYQ+Wk8x0jPZxGNkzhT05y7cyCAmVspvwJbm2V33NF7gr0
	+ClwB0+w==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83B-009TiJ-83; Tue, 05 Aug 2025 05:09:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:05 -0300
Subject: [PATCH RFC v2 1/8] olv: Store casefold name for case-insentive
 dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-1-0e54281da318@igalia.com>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
In-Reply-To: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

In order to make case-insentive mounting points work, overlayfs needs
the casefolded version of its dentries so the search and insertion in
the struct ovl_readdir_data's red-black compares the dentry names in a
case-insentive fashion.

If a dentry is casefolded, compute and store it's casefolded name and
it's Unicode map. If utf8_casefold() fails, set it's name pointer as
NULL so it can be ignored and fallback to the original name.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/readdir.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce27172d28d879559f1008b9c87320..83bca1bcb0488461b08effa70b32ff2fefba134e 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -16,6 +16,8 @@
 #include <linux/overflow.h>
 #include "overlayfs.h"
 
+#define OVL_NAME_LEN 255
+
 struct ovl_cache_entry {
 	unsigned int len;
 	unsigned int type;
@@ -27,6 +29,9 @@ struct ovl_cache_entry {
 	bool is_upper;
 	bool is_whiteout;
 	bool check_xwhiteout;
+	struct unicode_map *map;
+	char *cf_name;
+	int cf_len;
 	char name[];
 };
 
@@ -50,6 +55,7 @@ struct ovl_readdir_data {
 	bool is_upper;
 	bool d_type_supported;
 	bool in_xwhiteouts_dir;
+	struct unicode_map *map;
 };
 
 struct ovl_dir_file {
@@ -166,6 +172,29 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	p->is_whiteout = false;
 	/* Defer check for overlay.whiteout to ovl_iterate() */
 	p->check_xwhiteout = rdd->in_xwhiteouts_dir && d_type == DT_REG;
+	p->map = rdd->map;
+	p->cf_name = NULL;
+
+	if (p->map && !is_dot_dotdot(name, len)) {
+		const struct qstr str = { .name = name, .len = len };
+		int ret;
+
+		p->cf_name = kmalloc(OVL_NAME_LEN, GFP_KERNEL);
+
+		if (!p->cf_name) {
+			kfree(p);
+			return NULL;
+		}
+
+		ret = utf8_casefold(p->map, &str, p->cf_name, OVL_NAME_LEN);
+
+		if (ret < 0) {
+			kfree(p->cf_name);
+			p->cf_name = NULL;
+		} else {
+			p->cf_len = ret;
+		}
+	}
 
 	if (d_type == DT_CHR) {
 		p->next_maybe_whiteout = rdd->first_maybe_whiteout;
@@ -223,8 +252,10 @@ void ovl_cache_free(struct list_head *list)
 	struct ovl_cache_entry *p;
 	struct ovl_cache_entry *n;
 
-	list_for_each_entry_safe(p, n, list, l_node)
+	list_for_each_entry_safe(p, n, list, l_node) {
+		kfree(p->cf_name);
 		kfree(p);
+	}
 
 	INIT_LIST_HEAD(list);
 }
@@ -357,12 +388,19 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
 		.list = list,
 		.root = root,
 		.is_lowest = false,
+		.map = NULL,
 	};
 	int idx, next;
 	const struct ovl_layer *layer;
 
 	for (idx = 0; idx != -1; idx = next) {
 		next = ovl_path_next(idx, dentry, &realpath, &layer);
+
+#if IS_ENABLED(CONFIG_UNICODE)
+		if (ovl_dentry_casefolded(realpath.dentry))
+			rdd.map = realpath.dentry->d_sb->s_encoding;
+#endif
+
 		rdd.is_upper = ovl_dentry_upper(dentry) == realpath.dentry;
 		rdd.in_xwhiteouts_dir = layer->has_xwhiteouts &&
 					ovl_dentry_has_xwhiteouts(dentry);

-- 
2.50.1


