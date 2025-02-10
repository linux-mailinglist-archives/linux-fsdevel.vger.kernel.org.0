Return-Path: <linux-fsdevel+bounces-41449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F9A2F94C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E74169173
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B028724E4AD;
	Mon, 10 Feb 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjBXQSbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55A24E4A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216724; cv=none; b=OtaXtFNROj1fQYj8rGHbW8XsG5ynLVsdDKCqWmuxgCKKsRRiAUW+FFJCsgK1urnGSAaiQO/mTDf7h5Gg2RElwExldv7j0mt+b9y3o9nKyZ3TZHUr7jMRy2mN2N+o39eq5moSsov1eWBb+qCiMLCa1Y03USFTiWdFli9v/LNON68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216724; c=relaxed/simple;
	bh=Ies27slIx7y5bS+79REFQuLISv5S8LEGT4gTm7hMPok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5X6QAc2KocJC7ewmHvuuV+vU27j4RwVGNGvBpBsECi1nfqtP+q2LhQ23ro1ykK8T2TTFS+5K7EjSe8zsjJV9WOw2XZNXsjQZmUO1+uNFjPvb/7S28/mQfTBWNpEYYexLwArZCgoLTOk/MPoSO28t4ZasTuH4GyAY0Xy6ErqrI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjBXQSbA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbxSyQKCwGb3XWtxBoCXOpxbOFNoI50Hl3Y8KXWUH0A=;
	b=XjBXQSbAXv8j68c0MXiftaDHfaxYgonNb9lZFTfFCY20AYwFcayEk7xQyEmi+NxsRssG6g
	atPO8VZZyNVkmBVBprSdq61wdp/sGkTIjxkFnr6xVksYwkymH/I1hHqsgkohE8XanB5Ug5
	14/MyhKb9XH5UpAva4O7XuvuV1JqTYs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-URZO_Cd0Nxu6rw8mG8_Urw-1; Mon, 10 Feb 2025 14:45:19 -0500
X-MC-Unique: URZO_Cd0Nxu6rw8mG8_Urw-1
X-Mimecast-MFC-AGG-ID: URZO_Cd0Nxu6rw8mG8_Urw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab79bb57279so225236866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 11:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216718; x=1739821518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbxSyQKCwGb3XWtxBoCXOpxbOFNoI50Hl3Y8KXWUH0A=;
        b=WTgxBWljA0ihwa6jlyph8Wc1Z/6IbIpezy0Dq9WlhxRzFbuTCnr0cmCCnErfCEYhm4
         xEb2+kb8+lgeTS5NpyS59xRdW7DKV3FyfvShhXbZkB1PFOitBWkc+nE2uSs/i6qxPrym
         h4HNJQ/hCTVOr28/D7+jnKMy/OrSPtkKxfUyBqlej9kIY8w8pD2rX/h/oDFavPZFdEld
         YiIgj9+x/ydhOKbIIlc1KHXcqsS/S2FDj78mjjifdBlstvNlZg0MJzoNLwYSuQ3ONut/
         hvRrlpU6lNm+4g61AqcOlLWpvDEY1x7KNnWAotptwuqazwrSP4Jr4mLMUKg+bZRApgCu
         cEuw==
X-Forwarded-Encrypted: i=1; AJvYcCVMv+XGSc2QcW3YjrwgKEwczqKErHB4TiGf7q+ANEWSd0RBiuKSV5qxl/BAiKH0gN9yaLHYixQLvqBHM3x7@vger.kernel.org
X-Gm-Message-State: AOJu0YyARrvKo7FBW1kQ0HEPrjQAkshC2aJO99vSnki3Bh7CZd/o3YPe
	Y0OfUWmNhSd42biEY/LxA1phVJIP/BGswimAn7Zl+r8I0h2BjYx4/000zZiie8dd8tkrey3Ov9I
	/ndq7521WWOaQ7j+pYzAYOGy90StbCaiv0iMEMGz37k/9fpyTEgceQrCes6EGnf0=
X-Gm-Gg: ASbGnct+kWrtuJnngDS+7GerNidgn8nYCM0tNsyZ5u57iquyb1+ef3c8MlHqdJX5ax4
	SKVSnw5QXkGqqKE2acVkfCYfj4t1VcXvKEPioE+afxZRbiy4m5qCz3CkMSkFc0nNyF1DfigwyfU
	LMX8RXN8sl/Gsk5BbFthbNulIelTjgqQToVWSBOIKZM1AbE4OE8NyFBd+K/Jo+E5MOU9kEnHs2o
	ttlmLc9nCqrW0mDKFn9ct8Z+H6nvB29E0iBfM2YcALPeRal1f13T0nQLo/9S8lXYh/kUFRK93jt
	5smuQMaTXafwdwiK26rHX4cq6zHNal6hH3xteZWw0b/jLS8NplpcpQ==
X-Received: by 2002:a17:906:ba85:b0:ab7:5a5c:93f6 with SMTP id a640c23a62f3a-ab7da3a2454mr56535766b.32.1739216718489;
        Mon, 10 Feb 2025 11:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCBnxz+7o+tbwuhbZ8LviiIfX4+7f0WxuabH4upSUITZu0Vxc+nXqR+bHtd2Lw/e7hgTGg5g==
X-Received: by 2002:a17:906:ba85:b0:ab7:5a5c:93f6 with SMTP id a640c23a62f3a-ab7da3a2454mr56533866b.32.1739216718092;
        Mon, 10 Feb 2025 11:45:18 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (84-236-3-29.pool.digikabel.hu. [84.236.3.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7922efbb7sm702006666b.2.2025.02.10.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:45:16 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] ovl: don't require metacopy=on for lower -> data redirect
Date: Mon, 10 Feb 2025 20:45:08 +0100
Message-ID: <20250210194512.417339-4-mszeredi@redhat.com>
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

Allow the special case of a redirect from a lower layer to a data layer
without having to turn on metacopy.  This makes the feature work with
userxattr, which in turn allows data layers to be usable in user
namespaces.

Minimize the risk by only enabling redirect from a single lower layer to a
data layer iff a data layer is specified.  The only way to access a data
layer is to enable this, so there's really no reason no to enable this.

This can be used safely if the lower layer is read-only and the
user.overlay.redirect xattr cannot be modified.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.rst |  7 ++++++
 fs/overlayfs/namei.c                    | 32 ++++++++++++++-----------
 fs/overlayfs/params.c                   |  5 ----
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 6245b67ae9e0..5d277d79cf2f 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -429,6 +429,13 @@ Only the data of the files in the "data-only" lower layers may be visible
 when a "metacopy" file in one of the lower layers above it, has a "redirect"
 to the absolute path of the "lower data" file in the "data-only" lower layer.
 
+Instead of explicitly enabling "metacopy=on" it is sufficient to specify at
+least one data-only layer to enable redirection of data to a data-only layer.
+In this case other forms of metacopy are rejected.  Note: this way data-only
+layers may be used toghether with "userxattr", in which case careful attention
+must be given to privileges needed to change the "user.overlay.redirect" xattr
+to prevent misuse.
+
 Since kernel version v6.8, "data-only" lower layers can also be added using
 the "datadir+" mount options and the fsconfig syscall from new mount api.
 For example::
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index da322e9768d1..f9dc71b70beb 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1042,6 +1042,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	char *upperredirect = NULL;
 	bool nextredirect = false;
 	bool nextmetacopy = false;
+	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
 	struct dentry *this;
 	unsigned int i;
 	int err;
@@ -1053,7 +1054,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		.is_dir = false,
 		.opaque = false,
 		.stop = false,
-		.last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
+		.last = check_redirect ? false : !ovl_numlower(poe),
 		.redirect = NULL,
 		.metacopy = 0,
 	};
@@ -1141,7 +1142,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_put;
 		}
 
-		if (!ovl_redirect_follow(ofs))
+		if (!check_redirect)
 			d.last = i == ovl_numlower(poe) - 1;
 		else if (d.is_dir || !ofs->numdatalayer)
 			d.last = lower.layer->idx == ovl_numlower(roe);
@@ -1222,21 +1223,24 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		}
 	}
 
-	/* Defer lookup of lowerdata in data-only layers to first access */
+	/*
+	 * Defer lookup of lowerdata in data-only layers to first access.
+	 * Don't require redirect=follow and metacopy=on in this case.
+	 */
 	if (d.metacopy && ctr && ofs->numdatalayer && d.absolute_redirect) {
 		d.metacopy = 0;
 		ctr++;
-	}
-
-	if (nextmetacopy && !ofs->config.metacopy) {
-		pr_warn_ratelimited("refusing to follow metacopy origin for (%pd2)\n", dentry);
-		err = -EPERM;
-		goto out_put;
-	}
-	if (nextredirect && !ovl_redirect_follow(ofs)) {
-		pr_warn_ratelimited("refusing to follow redirect for (%pd2)\n", dentry);
-		err = -EPERM;
-		goto out_put;
+	} else {
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
 	}
 
 	/*
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..54468b2b0fba 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1000,11 +1000,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		 */
 	}
 
-	if (ctx->nr_data > 0 && !config->metacopy) {
-		pr_err("lower data-only dirs require metacopy support.\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
2.48.1


