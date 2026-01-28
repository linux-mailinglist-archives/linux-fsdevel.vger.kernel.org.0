Return-Path: <linux-fsdevel+bounces-75723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHpWMQAOemmS2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:24:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF8A2132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE5AA300679D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301B352F8D;
	Wed, 28 Jan 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OShHKG5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E96350D79
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606655; cv=none; b=jtZtLtRboB51JGmJqCZvtU6zENIS3WhjqGWrxd+llqIBVDPBqHVywX/pKigr8PJMZFoXoN7o+PAsH6/V2eYBQOLaVUtkAS0/FKEA6qINQAd66tlEtSvCz8/Twk7ZBjzrpwPK4O/wbfyVaultDgmK9u9xuHJ6DC1OQBrHviqgUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606655; c=relaxed/simple;
	bh=Og0yUsffNdz+0Ckbusdu1EaznuC6uspuTdFy0bPsuf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbLGDQ2cagz9+gF6iQyFtqFBdnYyAqvtfczoTfK8/524WMzacYBDyTP+rRn8DfEOZWIz1Wb5R4kPk59SwK1XuKdLK1m6CCGkSp/uaD9EodOxwTL8iVZk17Bj/Rz02QfvcGyDEqxwGHIDFyP4j/r5tVvPs1JOnserjUdSq8OyGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OShHKG5C; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso9744077a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 05:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769606652; x=1770211452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7bTbQqX4By4dCHLXfdzqYTwBL6gPTmqwLaEkWBU140=;
        b=OShHKG5C57u9tZplHFBWQ1sSuhbzven8rAy9PmSVk2jeYYriRFT/9C7HIPDMcFG6O9
         Zu2IF7SZ2ckBtCaClZBD7Um75WFwMt/W2A9M6hFVqyt57Zu3BEL08iq0nkh/wON8bIKy
         K3Oe5Vhvtw0mKk20wtvy5e22GnHjDjVio+v3QOFPi3AEL8aMAayhcUqkI8AzcC/a22zS
         18VKVJBm2CIk9lTi+3EY0BCNrI9vRQ2xKSJNcmSx5iIseYFUdIeuBWWes3Ozwdc8lW2a
         ciC3r4c6FTR9kIxVVYpTdaPmlUBTng+K7H8BmfiqxdludldCAy1YHo9bSHgA8tDgr1ZJ
         mKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606652; x=1770211452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7bTbQqX4By4dCHLXfdzqYTwBL6gPTmqwLaEkWBU140=;
        b=YvxHvFlXZIzalFBvVjdyKcuxdmCzZoYaCmOLMWoIr/iW8Rou2ouot4NHLAIWaB7PWP
         sHPo2Sc7esC+KFwmQeZduQK2tAfFX/73gGebbDxGAcD/UFsTm/gL4T0SVDTTC/kHg9QJ
         tMu7CG8hDe17MTsocJQGW8sPkVNgiDf6wjto5lRnzxw96P5K0Ht+hklHActWpjf2rYM9
         FIWLk8qPcf0JuQggnjUN+L1LGs7zGROBjYjvGoWUgaBM33S5mtn7tYh1bXDeJHQwXdPA
         cBuL905XLzdf4p6AF0g1hVB+I9h0lK44CDh+cxOl+U7EShYWdU6k2vLQbC+wXOUlMkru
         YfWw==
X-Forwarded-Encrypted: i=1; AJvYcCXlyw73WyJNiUUEDV4uju7x6omN4qk8tYqcqW/oR4Y8qTMxk4Xq/yLOz4t7nlb+/0Xb6LfJ4hv3WBIbSCpb@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDeidWlJcPcZ77FRa0+5/oCCfj8D8yuANsPUxwdmC1ALrrlwN
	zLOSwD+hjbeP4euprlHLKpIy3K2RKfj4WzgU4IZsWKvCJvOIT2ytJi8+
X-Gm-Gg: AZuq6aKNr/VuolWeU+D3KclOnyQ2KC4WK9fKcAX/3+1K99zVUCrH58AQwWgJxpPgf2W
	RPGSdBH8mdp33Em46UeEFJiglB0T8vOsvSqAFQ4lWbQ2xJSEibqqElqy15g1BUY6F4vt9MOj5IC
	8ApGy7hvBe9VxOGb16HL5dxz6PFb1BnG1IdsAbq+G4i7Tg2smUJAMm3tJOSCzEDHmrXbOpDfedM
	Q0n6PsfXcS9HFOYGsDShbR16ixGB4UX1zfXRy4FTwUsqW7MylfkTkqXeTG6t3LPvRh5X2F711WY
	LQ2l+BKg/kG5xgxM5GdEPnTVyzXwBKsrjgdJZ9VJAkz/+RjT7mbDIrRGJUjUeyhT7QECo1Ai9PD
	6ph5UG0G4R9dauy4xiPj3hY4ySaGsFeEKI6y7cRAKES9FuusLFVjQ85iLXKYobxhLI7EhWFVZJv
	hACCcIFO17Tcu4QugXsF+9Xi4Y/ny4kz/lnGtgiLkq8a2ucT+e3Ut2svQsvqVV1Z44qe/8R0D3R
	h7fqUmIXuRemAyaDV8MLnckCBg=
X-Received: by 2002:a05:6402:5246:b0:658:3b8c:9f25 with SMTP id 4fb4d7f45d1cf-658a60a03bamr3087593a12.26.1769606651726;
        Wed, 28 Jan 2026 05:24:11 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-c84e-f30e-bdab-df5a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c84e:f30e:bdab:df5a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b46abea5sm1543914a12.31.2026.01.28.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:24:10 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Qing Wang <wangqing7171@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 3/3] ovl: use name_is_dot* helpers in readdir code
Date: Wed, 28 Jan 2026 14:24:06 +0100
Message-ID: <20260128132406.23768-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128132406.23768-1-amir73il@gmail.com>
References: <20260128132406.23768-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75723-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 67BF8A2132
X-Rspamd-Action: no action

Use the helpers in place of all the different open coded variants.
This makes the code more readable and robust.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/readdir.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 9f6b36f3d4cf8..5727948d6566a 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -154,7 +154,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *rdd,
 		return true;
 
 	/* Always recalc d_ino for parent */
-	if (strcmp(p->name, "..") == 0)
+	if (name_is_dotdot(p->name, p->len))
 		return true;
 
 	/* If this is lower, then native d_ino will do */
@@ -165,7 +165,7 @@ static bool ovl_calc_d_ino(struct ovl_readdir_data *rdd,
 	 * Recalc d_ino for '.' and for all entries if dir is impure (contains
 	 * copied up entries)
 	 */
-	if ((p->name[0] == '.' && p->len == 1) ||
+	if (name_is_dot(p->name, p->len) ||
 	    ovl_test_flag(OVL_IMPURE, d_inode(rdd->dentry)))
 		return true;
 
@@ -561,12 +561,12 @@ static int ovl_cache_update(const struct path *path, struct ovl_cache_entry *p,
 	if (!ovl_same_dev(ofs) && !p->check_xwhiteout)
 		goto out;
 
-	if (p->name[0] == '.') {
+	if (name_is_dot_dotdot(p->name, p->len)) {
 		if (p->len == 1) {
 			this = dget(dir);
 			goto get;
 		}
-		if (p->len == 2 && p->name[1] == '.') {
+		if (p->len == 2) {
 			/* we shall not be moved */
 			this = dget(dir->d_parent);
 			goto get;
@@ -666,8 +666,7 @@ static int ovl_dir_read_impure(const struct path *path,  struct list_head *list,
 		return err;
 
 	list_for_each_entry_safe(p, n, list, l_node) {
-		if (strcmp(p->name, ".") != 0 &&
-		    strcmp(p->name, "..") != 0) {
+		if (!name_is_dot_dotdot(p->name, p->len)) {
 			err = ovl_cache_update(path, p, true);
 			if (err)
 				return err;
@@ -756,7 +755,7 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 	struct dir_context *orig_ctx = rdt->orig_ctx;
 	bool res;
 
-	if (rdt->parent_ino && namelen == 2 && !strncmp(name, "..", 2)) {
+	if (rdt->parent_ino && name_is_dotdot(name, namelen)) {
 		ino = rdt->parent_ino;
 	} else if (rdt->cache) {
 		struct ovl_cache_entry *p;
@@ -1097,11 +1096,8 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 			goto del_entry;
 		}
 
-		if (p->name[0] == '.') {
-			if (p->len == 1)
-				goto del_entry;
-			if (p->len == 2 && p->name[1] == '.')
-				goto del_entry;
+		if (name_is_dot_dotdot(p->name, p->len)) {
+			goto del_entry;
 		}
 		err = -ENOTEMPTY;
 		break;
@@ -1146,7 +1142,7 @@ static bool ovl_check_d_type(struct dir_context *ctx, const char *name,
 		container_of(ctx, struct ovl_readdir_data, ctx);
 
 	/* Even if d_type is not supported, DT_DIR is returned for . and .. */
-	if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen))
+	if (name_is_dot_dotdot(name, namelen))
 		return true;
 
 	if (d_type != DT_UNKNOWN)
@@ -1209,11 +1205,8 @@ static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, const struct path *pa
 	list_for_each_entry(p, &list, l_node) {
 		struct dentry *dentry;
 
-		if (p->name[0] == '.') {
-			if (p->len == 1)
-				continue;
-			if (p->len == 2 && p->name[1] == '.')
-				continue;
+		if (name_is_dot_dotdot(p->name, p->len)) {
+			continue;
 		} else if (incompat) {
 			pr_err("overlay with incompat feature '%s' cannot be mounted\n",
 				p->name);
@@ -1278,11 +1271,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 		goto out;
 
 	list_for_each_entry(p, &list, l_node) {
-		if (p->name[0] == '.') {
-			if (p->len == 1)
-				continue;
-			if (p->len == 2 && p->name[1] == '.')
-				continue;
+		if (name_is_dot_dotdot(p->name, p->len)) {
+			continue;
 		}
 		index = ovl_lookup_upper_unlocked(ofs, p->name, indexdir, p->len);
 		if (IS_ERR(index)) {
-- 
2.52.0


