Return-Path: <linux-fsdevel+bounces-41448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1417EA2F947
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D128188A3C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B224C680;
	Mon, 10 Feb 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnoQv4LO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9424C673
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216722; cv=none; b=JSBFt31VU94pbLp05yqPgry/4BC+Dr8+VS0W8c7DOLgzFlAFqZLY9sjMvLseCCZcIhM4QsHYdxiXOD6MAEKYBrb8f1+io6JynfY2BkjtKzVVozk4WT+uJyaLYzTkDUWDZsvkGnlIAwGselIJEB0tVLlDdl8SLPxMt+riNtceHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216722; c=relaxed/simple;
	bh=6I3nvrty6mIsXbdzuMVgchvm2WTK3+v1V3YGpFXZSsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuPr/yeeYnPD9ytou3jD0WHgIz/TiKf+EWBDFfG5X8FAoTq9/PrrkpHq2Lj7ma38h4+hfcs6yHxD439HXaQyiV6HlMBX8pMNm6JtQvSHMC2iuQGMeKNjoq3r1rinZtOSPQRmTpLpwbtaU30NeYRFKEr+x6iovGPl0fFm33dqN/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnoQv4LO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OxMWC3XA5FgD49oXcSz1TwT0Kbb0QMAHeVEoh+RJ7k=;
	b=AnoQv4LOQ5cMWCZ8Ms9IfZN1uLhX++dM5GMM8eBJDVVP+ZVPfChyVBFQloWyOni7eIgAaa
	cUhfSZR5gWDmRU4W3Wrzx5qUOlxjpjeJRk7sn2aA+8ULig2BXu6cb/bU2XCPdzzPgXXSHz
	sGafhDVxQTlWxf1bgocrciFvjO/Qmeg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-iCUPVHWhO6mDXKPPBRprRw-1; Mon, 10 Feb 2025 14:45:18 -0500
X-MC-Unique: iCUPVHWhO6mDXKPPBRprRw-1
X-Mimecast-MFC-AGG-ID: iCUPVHWhO6mDXKPPBRprRw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab79e8c2ee0so201350766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216717; x=1739821517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OxMWC3XA5FgD49oXcSz1TwT0Kbb0QMAHeVEoh+RJ7k=;
        b=WGmWHzZpwbgt4GhAInZpOEPK7oHqdvVZX0tb0lJ9a4sfFIXaI2IHntlZPBW9O7A5ct
         P6d/ikCAJfU1MNTLNbVOB2xrR5GdfEhCe4nM9d9QSoBQoWmNjsKP7o9VE7ykhYJwDbHL
         FtOIWS4PmPTSlwtZHTXlBrvsorn429PXrl8DMUqJjxHezxEkNEa7JYBOwrgNk413EqD6
         w7jliIgxpG1ZCH4BwYVBG6f8g1ZgLOUZj50IhaH5MP5HXTbBV6kQrlEHL5kJQsLIFEOn
         g28JoEMhXzHILDWJT8/rDFkYhYGRVhMiTRGvqk+pW13UQ4tn4jZd8jlrb/UglF5buFZj
         YPrA==
X-Forwarded-Encrypted: i=1; AJvYcCULdJ9wjEx7nGm0Vu3AdFd4mY8UFLEf6zZnX9k74lxpUZGcq7A0rrFh/rCAUNZa9bbc48KhajFuOjrkmrvX@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXyOeVbMsgd0fRoSwrKsA1m6SkMmPLc076cypaaVS+9MLmQwe
	jv8JyRcoHnNwC6gPdTWtQeGhRmiglu/UPsfZ/2e6mUX4tlpWiCpNgzJFz8lMTu3LPRN+cDRYWgx
	sLdL/7xow349s4GkTlXh+7q47TjH0gyxCHxvFAt2w11nUB0D8mI45yYMiIiH3oTqW5NqUvrnwew
	==
X-Gm-Gg: ASbGncvCS9GeO/aty/rT1XVWZ13s/nBU729TaEBRqrsICIsmIZw0nvxdhiT7jyHfQ5m
	/rjzYn3O/NBfDz0MGlX6utk/RfwLxcUpet20xgN9o664vtez8Zts+kkNSnbmgjSanmFzV8Q2JV7
	IKFK665HkorKuJH/wkJiJSVCEW4u45NfvAG9NzzsLm66owtxZNFci9du8M50Fyk/2sFKsyB5RTB
	sEMWls39jc5l7ox6yCXHktWvzhgXmkGM0t0uOTMJMMGkUBjFAva7i4zfb5oQJmxcQjsjIZQt+Uv
	0bH26260Zy/s90XLPHBKfCMsKCYo3ueJoDS9V34/+Fj3VzKErBvYSg==
X-Received: by 2002:a17:907:3f27:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab789aef91amr1549089366b.34.1739216716730;
        Mon, 10 Feb 2025 11:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj+bPdauKCbaejXpaZDhdSfocK61NbRSKwlc7SJwI6g7ThhBURLvAXfYEoXrNhskWnPyPIqw==
X-Received: by 2002:a17:907:3f27:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab789aef91amr1549086866b.34.1739216716303;
        Mon, 10 Feb 2025 11:45:16 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:15 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
Date: Mon, 10 Feb 2025 20:45:07 +0100
Message-ID: <20250210194512.417339-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210194512.417339-1-mszeredi@redhat.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
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

There was a slight inconsistency of only warning on an upper metacopy if it
found the next file on the lower layer, while always warning for metacopy
found on a lower layer.

Fix this inconsistency and make the logic more straightforward, pavig the
way for following patches to change when dataredirects are allowed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 67 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index be5c65d6f848..da322e9768d1 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1040,6 +1040,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	bool upperopaque = false;
 	char *upperredirect = NULL;
+	bool nextredirect = false;
+	bool nextmetacopy = false;
 	struct dentry *this;
 	unsigned int i;
 	int err;
@@ -1087,8 +1089,10 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			if (err)
 				goto out_put_upper;
 
-			if (d.metacopy)
+			if (d.metacopy) {
 				uppermetacopy = true;
+				nextmetacopy = true;
+			}
 			metacopy_size = d.metacopy;
 		}
 
@@ -1099,6 +1103,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 				goto out_put_upper;
 			if (d.redirect[0] == '/')
 				poe = roe;
+			nextredirect = true;
 		}
 		upperopaque = d.opaque;
 	}
@@ -1113,6 +1118,29 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	for (i = 0; !d.stop && i < ovl_numlower(poe); i++) {
 		struct ovl_path lower = ovl_lowerstack(poe)[i];
 
+		/*
+		 * Following redirects/metacopy can have security consequences:
+		 * it's like a symlink into the lower layer without the
+		 * permission checks.
+		 *
+		 * This is only a problem if the upper layer is untrusted (e.g
+		 * comes from an USB drive).  This can allow a non-readable file
+		 * or directory to become readable.
+		 *
+		 * Only following redirects when redirects are enabled disables
+		 * this attack vector when not necessary.
+		 */
+		if (nextmetacopy && !ofs->config.metacopy) {
+			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
+			err = -EPERM;
+			goto out_put;
+		}
+		if (nextredirect && !ovl_redirect_follow(ofs)) {
+			pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", dentry);
+			err = -EPERM;
+			goto out_put;
+		}
+
 		if (!ovl_redirect_follow(ofs))
 			d.last = i == ovl_numlower(poe) - 1;
 		else if (d.is_dir || !ofs->numdatalayer)
@@ -1126,12 +1154,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (!this)
 			continue;
 
-		if ((uppermetacopy || d.metacopy) && !ofs->config.metacopy) {
-			dput(this);
-			err = -EPERM;
-			pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
-			goto out_put;
-		}
+		if (d.metacopy)
+			nextmetacopy = true;
 
 		/*
 		 * If no origin fh is stored in upper of a merge dir, store fh
@@ -1185,22 +1209,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
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
+			nextredirect = true;
 
 		if (d.stop)
 			break;
@@ -1218,6 +1228,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		ctr++;
 	}
 
+	if (nextmetacopy && !ofs->config.metacopy) {
+		pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
+		err = -EPERM;
+		goto out_put;
+	}
+	if (nextredirect && !ovl_redirect_follow(ofs)) {
+		pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", dentry);
+		err = -EPERM;
+		goto out_put;
+	}
+
 	/*
 	 * For regular non-metacopy upper dentries, there is no lower
 	 * path based lookup, hence ctr will be zero. If a dentry is found
-- 
2.48.1


