Return-Path: <linux-fsdevel+bounces-45996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11589A81070
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91C2170478
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1EC22ACF1;
	Tue,  8 Apr 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HikNtb5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE61862BB
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126819; cv=none; b=KzyHxr4nL9CpJU+v3BHnvbdg4D41IcScsji7XNNjiL0pgETyS8adztycEDmCbKT3wkFCQyA3rDk1j64AJ5t5oQcDIqM3lR9FnImyY4YJUWrdAL6wvptkh9S2fjdR7WAYWnxp4y4ucrNnu08S6yC3ydWPM3hsICyp4VFu7asfZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126819; c=relaxed/simple;
	bh=1shebuS/I8nfl+A8U/rqE5CB+Bo+kQaPVbYV4UrP2ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJqD9yOh+F7royRC0cJvnVCETeOmtF3ejwARKbaL5H7vZ33K00asMjI3OFzgiuKCy0Q57GtnIT6XptO8pc+YpJlA4uXKKUZ9UEom7LYrVkX3VQPkFMWsuwp4OOD5xYe/M/bVKH9R0WXue+kTl5s0LwUUyEJSAqzbC4PWM8w+/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HikNtb5Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744126816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU8555WnOzv750rqynKzUgdgvOm7EFlOP9S2jBeJHFk=;
	b=HikNtb5ZczNs1CUKWz4dqZMzQr8y2QErK/GtjYhK0weEZ75giAua3U/8lgKGqtWfGrbYvK
	KuFL5WG6bjvwX4y9yE1SiOrmfDU+BOmQ4TndV1QJGt73CePQwVzD14wN34vzdcv17NMfrj
	vCpFKDYceQLqkrwbLCVi5I+YOKvDPJE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-w8athDFTPaqMbGhGeCW-lg-1; Tue, 08 Apr 2025 11:40:15 -0400
X-MC-Unique: w8athDFTPaqMbGhGeCW-lg-1
X-Mimecast-MFC-AGG-ID: w8athDFTPaqMbGhGeCW-lg_1744126814
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso482782366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 08:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126814; x=1744731614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU8555WnOzv750rqynKzUgdgvOm7EFlOP9S2jBeJHFk=;
        b=uyTm9M4mne3OspMhCUIBI4GB8Bd74JKjulrKFM5dZxPxnGrRxlKSaOzegfWgf9gF7h
         B+QLlxwta7+0Pu0T6BzNRnmJK2m9qr3hxOktKupQ9jLlvEUIaBWic8wNdPx20tcK912+
         oNtFXdXwxDvpIDa0x7bMmkxW7uF6raCuYayIqkcr33l1oSRodMoq/WfiyZa+J/932PJG
         96Mzk+msfI3l1qQ86oBOVCxKzhQMetyk4qFOSh4lXCpumf426oy5LI2LomnpqYsoW0WF
         5vrqbAOr+bi1b2fZ57cD0qPlPeiVq+klcS2EIXPFHLI0FOf1CTlypAgm7x90I5Zk9Zk6
         cE6A==
X-Forwarded-Encrypted: i=1; AJvYcCUT99VBNueAXQ8hoedAENGHyX/96IwpOvbcEZ+bO2HU3GtWG3tEIAJN70JHGXj9kjfzdkD7jGkayS7cYaJH@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTOcOB/z9j/Flp+SBbfnV5cwuDH5/YvsWYszbF8ksNq4U+QN9
	0lIC+VahbbsblFvv5IZdKFNohL8IKfTV3jLoSWn/BbOWjo9Br7tbc2kKgjFPO4FF/lgNcfdabeh
	AuFuKqKsW6J/uD+FWgcs0yHJXwYUzSF5B+tPrH70J7VYnOOUj7liS/9nlbbfE4C4=
X-Gm-Gg: ASbGncv1P/XXvgSbpyfOUFuEoEVZRE9HTT36D1ep30JJJmmsft1Zky5wJZQCLW45EXK
	P+f+0pqynj/H+zhIbDQiMvC3G6+mE3LpZ10gKu3TlN77JtJa7sZn3Td1B2qi1h1dXhUWawOzhWu
	psjKcBf0e32ZP0DU6uTOY7dZyqi1LbIB6FoQsvN7TX59Hl+8TYxgDCxf0o1fD3qxc3/toGDsbyI
	7s6U8qqlBpUMwFhW9flVtgjb6+t7sUJlrFNBHmhEHyLO20+b2qHKlkDS3Y+QCnR66ZNHZhqDb/0
	YkmhsiFyRwHRkoSYbtQcZTX0nSh+HR7aPj2pHOQ9uOXOdniH0bHEC9O6rsvO/x+wVSvOAuj9
X-Received: by 2002:a17:907:7f0b:b0:abf:fb78:673a with SMTP id a640c23a62f3a-ac7e72e01aamr1500405366b.29.1744126814148;
        Tue, 08 Apr 2025 08:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWxeAIbybuLCoyKlplBW3tR5GZppFnRO0zdv3nkxn3JB0iJTR4sxrdGMa3XEZWrPfA10vK6g==
X-Received: by 2002:a17:907:7f0b:b0:abf:fb78:673a with SMTP id a640c23a62f3a-ac7e72e01aamr1500403366b.29.1744126813782;
        Tue, 08 Apr 2025 08:40:13 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-212-63.pool.digikabel.hu. [193.226.212.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bb793sm927553766b.161.2025.04.08.08.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:40:13 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 1/3] ovl: make redirect/metacopy rejection consistent
Date: Tue,  8 Apr 2025 17:40:02 +0200
Message-ID: <20250408154011.673891-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408154011.673891-1-mszeredi@redhat.com>
References: <20250408154011.673891-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When overlayfs finds a file with metacopy and/or redirect attributes and
the metacopy and/or redirect features are not enabled, then it refuses to
act on those attributes while also issuing a warning.

There was an inconsistency in not checking metacopy found from the index.

And also only warning on an upper metacopy if it found the next file on the
lower layer, while always warning for metacopy found on a lower layer.

Fix these inconsistencies and make the logic more straightforward, paving
the way for following patches to change when dataredirects are allowed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 81 +++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index be5c65d6f848..5cebdd05ab3a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -16,6 +16,7 @@
 
 struct ovl_lookup_data {
 	struct super_block *sb;
+	struct dentry *dentry;
 	const struct ovl_layer *layer;
 	struct qstr name;
 	bool is_dir;
@@ -23,6 +24,8 @@ struct ovl_lookup_data {
 	bool xwhiteouts;
 	bool stop;
 	bool last;
+	bool nextredirect;
+	bool nextmetacopy;
 	char *redirect;
 	int metacopy;
 	/* Referring to last redirect xattr */
@@ -1024,6 +1027,31 @@ int ovl_verify_lowerdata(struct dentry *dentry)
 	return ovl_maybe_validate_verity(dentry);
 }
 
+/*
+ * Following redirects/metacopy can have security consequences: it's like a
+ * symlink into the lower layer without the permission checks.
+ *
+ * This is only a problem if the upper layer is untrusted (e.g comes from an USB
+ * drive).  This can allow a non-readable file or directory to become readable.
+ *
+ * Only following redirects when redirects are enabled disables this attack
+ * vector when not necessary.
+ */
+static bool ovl_check_nextredirect(struct ovl_lookup_data *d)
+{
+	struct ovl_fs *ofs = OVL_FS(d->sb);
+
+	if (d->nextmetacopy && !ofs->config.metacopy) {
+		pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", d->dentry);
+		return false;
+	}
+	if (d->nextredirect && !ovl_redirect_follow(ofs)) {
+		pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", d->dentry);
+		return false;
+	}
+	return true;
+}
+
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
@@ -1047,6 +1075,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	int metacopy_size = 0;
 	struct ovl_lookup_data d = {
 		.sb = dentry->d_sb,
+		.dentry = dentry,
 		.name = dentry->d_name,
 		.is_dir = false,
 		.opaque = false,
@@ -1054,6 +1083,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		.last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
 		.redirect = NULL,
 		.metacopy = 0,
+		.nextredirect = false,
+		.nextmetacopy = false,
 	};
 
 	if (dentry->d_name.len > ofs->namelen)
@@ -1087,8 +1118,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			if (err)
 				goto out_put_upper;
 
-			if (d.metacopy)
+			if (d.metacopy) {
 				uppermetacopy = true;
+				d.nextmetacopy = true;
+			}
 			metacopy_size = d.metacopy;
 		}
 
@@ -1099,6 +1132,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 				goto out_put_upper;
 			if (d.redirect[0] == '/')
 				poe = roe;
+			d.nextredirect = true;
 		}
 		upperopaque = d.opaque;
 	}
@@ -1113,6 +1147,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	for (i = 0; !d.stop && i < ovl_numlower(poe); i++) {
 		struct ovl_path lower = ovl_lowerstack(poe)[i];
 
+		if (!ovl_check_nextredirect(&d)) {
+			err = -EPERM;
+			goto out_put;
+		}
+
 		if (!ovl_redirect_follow(ofs))
 			d.last = i == ovl_numlower(poe) - 1;
 		else if (d.is_dir || !ofs->numdatalayer)
@@ -1126,12 +1165,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (!this)
 			continue;
 
-		if ((uppermetacopy || d.metacopy) && !ofs->config.metacopy) {
-			dput(this);
-			err = -EPERM;
-			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
-			goto out_put;
-		}
+		if (d.metacopy)
+			d.nextmetacopy = true;
 
 		/*
 		 * If no origin fh is stored in upper of a merge dir, store fh
@@ -1185,22 +1220,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			ctr++;
 		}
 
-		/*
-		 * Following redirects can have security consequences: it's like
-		 * a symlink into the lower layer without the permission checks.
-		 * This is only a problem if the upper layer is untrusted (e.g
-		 * comes from an USB drive).  This can allow a non-readable file
-		 * or directory to become readable.
-		 *
-		 * Only following redirects when redirects are enabled disables
-		 * this attack vector when not necessary.
-		 */
-		err = -EPERM;
-		if (d.redirect && !ovl_redirect_follow(ofs)) {
-			pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n",
-					    dentry);
-			goto out_put;
-		}
+		if (d.redirect)
+			d.nextredirect = true;
 
 		if (d.stop)
 			break;
@@ -1218,6 +1239,11 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		ctr++;
 	}
 
+	if (!ovl_check_nextredirect(&d)) {
+		err = -EPERM;
+		goto out_put;
+	}
+
 	/*
 	 * For regular non-metacopy upper dentries, there is no lower
 	 * path based lookup, hence ctr will be zero. If a dentry is found
@@ -1307,11 +1333,18 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			upperredirect = NULL;
 			goto out_free_oe;
 		}
+		d.nextredirect = upperredirect;
+
 		err = ovl_check_metacopy_xattr(ofs, &upperpath, NULL);
 		if (err < 0)
 			goto out_free_oe;
-		uppermetacopy = err;
+		d.nextmetacopy = uppermetacopy = err;
 		metacopy_size = err;
+
+		if (!ovl_check_nextredirect(&d)) {
+			err = -EPERM;
+			goto out_free_oe;
+		}
 	}
 
 	if (upperdentry || ctr) {
-- 
2.49.0


