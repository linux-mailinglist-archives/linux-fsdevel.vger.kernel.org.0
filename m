Return-Path: <linux-fsdevel+bounces-57154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A30B1EFFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA33D3B0A44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFF3242D89;
	Fri,  8 Aug 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JoeyDXpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A921D00D;
	Fri,  8 Aug 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686762; cv=none; b=BZUbWNN+RAd86xjpoxszzS9ISGYPrQV6VIGANdt5JeA4y8EfPfOd1x3FDOsaeF21joc+zkoHiVO+A0HBLhmdXE0+XpDON1jzcOH1S6Jk/ACR3aixWsJMcJYu6lHQKX6gFxq385MUsdMzuW9sRUp4CU0koortqDSIPdwgwwJBaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686762; c=relaxed/simple;
	bh=lts1u80SMMqa4/xe940q6JwSTiF+tO19ClFEbfS7cyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7b7/YmFYUCJAgONUVzpK6aSs4TKNzrYZ5jmjBDBAx9BGrmlqLZmNoUENCrRcwLqql8c1691LI2QFqqKwngwEl5PzPT4tlfYCAXq6fqsQjxEEOySsSduCsoBx3FB/n88PvIFt4wKmwIosM+MqjQWQwd1EtUInBGe853C6N28HIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JoeyDXpD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I3x2BitoREkICs8gzrBGPPrHzXqLRXwM+o5AKkH5M1I=; b=JoeyDXpDULr2w9e0KvI9CJkMwn
	T881InFYWW9bLjWhlXEXjL4ot7JrvOrjCyry50+fA4WPbbXo2hE3xKqtGmjjzj/s5VGDr8RWw4+cR
	t0bLpRlLQ4XrBxYwLE0Vc5eBjN2iQD/5jY9iYJkbAeL/bY65wgWn4owCAclIztdXWbuOL7567Ls4z
	LfSqNdsjqfhfVg15dZn6uW9/vv5BAf5whofIyq0e4gJ6LaYThJgPLtcAHMs2YKULi/Wz5ZyuN25hc
	nCoxNkbx3Ig4PcaVYWc5Edv2cBM+iTbnOPQcr35MSnyNjUCYVfKKLiF7NyMnlOLK+IRdxEWmiR++h
	XIwlsJMQ==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ukUBG-00BiQh-Mx; Fri, 08 Aug 2025 22:59:14 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 08 Aug 2025 17:58:43 -0300
Subject: [PATCH RFC v3 1/7] ovl: Store casefold name for case-insentive
 dentries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-tonyk-overlayfs-v3-1-30f9be426ba8@igalia.com>
References: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
In-Reply-To: <20250808-tonyk-overlayfs-v3-0-30f9be426ba8@igalia.com>
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
Changes from v3:
 - Guard all the casefolding inside of IS_ENABLED(UNICODE)
---
 fs/overlayfs/readdir.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index b65cdfce31ce27172d28d879559f1008b9c87320..2f42fec97f76c2000f76e15c60975db567b2c6d6 100644
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
@@ -27,6 +29,8 @@ struct ovl_cache_entry {
 	bool is_upper;
 	bool is_whiteout;
 	bool check_xwhiteout;
+	char *cf_name;
+	int cf_len;
 	char name[];
 };
 
@@ -45,6 +49,7 @@ struct ovl_readdir_data {
 	struct list_head *list;
 	struct list_head middle;
 	struct ovl_cache_entry *first_maybe_whiteout;
+	struct unicode_map *map;
 	int count;
 	int err;
 	bool is_upper;
@@ -166,6 +171,31 @@ static struct ovl_cache_entry *ovl_cache_entry_new(struct ovl_readdir_data *rdd,
 	p->is_whiteout = false;
 	/* Defer check for overlay.whiteout to ovl_iterate() */
 	p->check_xwhiteout = rdd->in_xwhiteouts_dir && d_type == DT_REG;
+	p->cf_name = NULL;
+	p->cf_len = 0;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (rdd->map && !is_dot_dotdot(name, len)) {
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
+		ret = utf8_casefold(rdd->map, &str, p->cf_name, OVL_NAME_LEN);
+
+		if (ret < 0) {
+			kfree(p->cf_name);
+			p->cf_name = NULL;
+		} else {
+			p->cf_len = ret;
+		}
+	}
+#endif
 
 	if (d_type == DT_CHR) {
 		p->next_maybe_whiteout = rdd->first_maybe_whiteout;
@@ -223,8 +253,10 @@ void ovl_cache_free(struct list_head *list)
 	struct ovl_cache_entry *p;
 	struct ovl_cache_entry *n;
 
-	list_for_each_entry_safe(p, n, list, l_node)
+	list_for_each_entry_safe(p, n, list, l_node) {
+		kfree(p->cf_name);
 		kfree(p);
+	}
 
 	INIT_LIST_HEAD(list);
 }
@@ -357,12 +389,19 @@ static int ovl_dir_read_merged(struct dentry *dentry, struct list_head *list,
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


