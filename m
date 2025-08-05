Return-Path: <linux-fsdevel+bounces-56714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E0B1ACE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F327AD792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC91F7586;
	Tue,  5 Aug 2025 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="j+oVwIlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8421F4C98;
	Tue,  5 Aug 2025 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754365715; cv=none; b=MuTAnSDZacakEHVNRfHs2KcUfjjB2kCGGUuXNlJARAXcvbH+tdgCQOdsz/tRWMPkHK2FUgv8/nsl24BkgofndoBWRHfB7aNOMoEtbK2ShfUjMP9ENgYqIHzX2r6WJuEC+cMHL//YkmHSaITv8Q+CFBsZKLSJkswbAfBEEmjd/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754365715; c=relaxed/simple;
	bh=EYVcJJ8bfz3bNTOwkL5RV1S1s/hR28agLQ7wpNzKsP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWH1GHaD+rz8NLx9DflKqU10+d4fXSlVL3Akv+GvBou5Ov7KgLqulvW+ZQAc+cEMNvMkkFEYLfIcPv4Jn8V624UqIjUYjv2xHBmRjPFosCNbFlMFu7Q4kbwI9owfHOsdOanlqL0Wi9NyGiq6nwxrEHpxru4e61NmAKhsJB6/FZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=j+oVwIlc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pUYS2ar/dZ4GwLjmvmUrrILIiZNezw9UlzI6p1tNZ2w=; b=j+oVwIlcycL3fosiHoQNZEDLqo
	TNGxKb87OoMBS414e+GFSF/rZFfhpNlThH7B1D49DIbHLdpemy7pp+9ookYKWQZ1J3LtnqG0gc6OX
	cRuEujziN6uiNulMp6kv0qU71l9oyGOQeSR++Knm6EZb4BnZX7JhQOohH4pBuaxNNVis6xAx4ou6M
	xPUH9kWvtUK5VaoZx6ybyZZtF097d9CNQJtJ1i7lrMqTMxGomV8Ns35Gnbu7dpoL6WackMg/j/Jez
	etIFo1/v/6g3e9hhnJ8/ccM+Qru5auXQk9egxA1qHwWPvUE5wf4KtJTZ531qHq3fIE+QaE7HIPO9X
	+bcPgJ0g==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uj83E-009TiJ-2H; Tue, 05 Aug 2025 05:09:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 05 Aug 2025 00:09:06 -0300
Subject: [PATCH RFC v2 2/8] ovl: Create ovl_strcmp() with casefold support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
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

To add overlayfs support casefold filesystems, create a new function
ovl_strcmp() with support for casefold names.

If the ovl_cache_entry have stored a casefold name, use it and create
a casfold version of the name that is going to be compared to.

For the casefold support, just comparing the strings does not work
because we need the dentry enconding, so make this function find the
equivalent dentry for a giving directory, if any.

As this function is used for search and insertion in the red-black tree,
that means that the tree node keys are going to be the casefolded
version of the dentry's names. Otherwise, the search would not work for
case-insensitive mount points.

For the non-casefold names, nothing changes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
I wonder what should be done here if kmalloc fails, if the strcmp()
should fail as well or just fallback to the normal name?
---
 fs/overlayfs/readdir.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 83bca1bcb0488461b08effa70b32ff2fefba134e..1b8eb10e72a229ade40d18795746d3c779797a06 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -72,6 +72,44 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
 	return rb_entry(n, struct ovl_cache_entry, node);
 }
 
+/*
+ * Compare a string with a cache entry, with support for casefold names.
+ */
+static int ovl_strcmp(const char *str, struct ovl_cache_entry *p, int len)
+{
+
+	const struct qstr qstr = { .name = str, .len = len };
+	const char *p_name = p->name, *name = str;
+	char *dst = NULL;
+	int cmp, cf_len;
+
+	if (p->cf_name)
+		p_name = p->cf_name;
+
+	if (p->map && !is_dot_dotdot(str, len)) {
+		dst = kmalloc(OVL_NAME_LEN, GFP_KERNEL);
+
+		/*
+		 * strcmp can't fail, so we fallback to the use the original
+		 * name
+		 */
+		if (dst) {
+			cf_len = utf8_casefold(p->map, &qstr, dst, OVL_NAME_LEN);
+
+			if (cf_len > 0) {
+				name = dst;
+				dst[cf_len] = '\0';
+			}
+		}
+	}
+
+	cmp = strncmp(name, p_name, cf_len);
+
+	kfree(dst);
+
+	return cmp;
+}
+
 static bool ovl_cache_entry_find_link(const char *name, int len,
 				      struct rb_node ***link,
 				      struct rb_node **parent)
@@ -85,7 +123,7 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
 
 		*parent = *newp;
 		tmp = ovl_cache_entry_from_node(*newp);
-		cmp = strncmp(name, tmp->name, len);
+		cmp = ovl_strcmp(name, tmp, len);
 		if (cmp > 0)
 			newp = &tmp->node.rb_right;
 		else if (cmp < 0 || len < tmp->len)
@@ -107,7 +145,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
 	while (node) {
 		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
 
-		cmp = strncmp(name, p->name, len);
+		cmp = ovl_strcmp(name, p, len);
 		if (cmp > 0)
 			node = p->node.rb_right;
 		else if (cmp < 0 || len < p->len)

-- 
2.50.1


