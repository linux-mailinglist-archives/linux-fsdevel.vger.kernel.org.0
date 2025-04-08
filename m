Return-Path: <linux-fsdevel+bounces-45997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CDA8106C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B74189E01C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D91862BB;
	Tue,  8 Apr 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ/D825T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134181553AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126820; cv=none; b=QG501rRpg5I4wGazyXoom9QCCMtQo6BDLvTfk6Kmp6ZefsDU3chGISsEKp+XZbIYfPOYyy8slGRVCZsiHRUZjU7rGgxjkUX0MxfBJ/UGLJlG87DEuL7NyhyPAP+enXbPj0jq7uEDTmvwVRvsrYm44mw6aniiaYZBN4BUa20Pmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126820; c=relaxed/simple;
	bh=6VNMoxYzbFk+VlKL7h88wDZ9Ynzzobrg4jsDJKB20sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKMFkRhrb50JakR2Q3/cKDWwSEKmOrhualQ4HXVa4hUcqMtY6EFf5KQ7VlTP1KLzJ/v/lXK2hbnztAIxT/32yruV9MKtvP0isrboKzzsXyeCWZM3s5V+3RtQl4dp6QIwLRY53cZr6E4zuJRYxpKd0JbY2u9oXE87dOXy6ew+wtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ/D825T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744126817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4xX7nQQJU6qGcbsTCbaOngAfrHbt+AL1BwlUbjEmks=;
	b=eJ/D825TLriWRf7sNx+0nd+GRkDmWNA2fmDX7/7GKlcDsKOjxFAlaXiWPWh/1bywO9rWIj
	fHemjbTWsvdYo5IMI3VQANdsTvIElwoUmT5sH+01dSvp0Goc1fWCHLQm/xTgyGUCZ+55s2
	SsDUs8qVAONl4PUlhAROGToeS0OBy8g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-KC_2NOHWOX62v5FJu-5gBA-1; Tue, 08 Apr 2025 11:40:17 -0400
X-MC-Unique: KC_2NOHWOX62v5FJu-5gBA-1
X-Mimecast-MFC-AGG-ID: KC_2NOHWOX62v5FJu-5gBA_1744126816
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac28f255a36so476735766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 08:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126815; x=1744731615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4xX7nQQJU6qGcbsTCbaOngAfrHbt+AL1BwlUbjEmks=;
        b=V78ZNliEjTwUUd1b3L2cBNroEjADQXSwlfHJeEQd1TQ2L5WFA7G7vREiPyUyNA+fRY
         X8vFwlE5GzmreOzDe9GpSdjeDKSqa2aJ6zUxVejKdsO6P3N+cH/Bh36/JgOQdw/1joIG
         OF4E/oyc3X1vA7rbaarTOTWXhVjISIBmIFA+nrBnoQN0s5gD5ugNxucLbqR/GEv8YpLv
         9q9WrD5zQPi80uXSfaRY7G+gW9QxE4GMGtR6TKtp5+MAnuKlA4qjKbo4JotpBzVTSgqM
         zHyOfrMSEfIsz1JFyU4lTUlWYqEAg3tEzfbe4DkrNnJsdXfGldQf+rXnN0Y7J58AlSAR
         fpLA==
X-Forwarded-Encrypted: i=1; AJvYcCVidhyzwFgSAiSvMxIyQns0L0uAC5fSFRCXsfjZlQx5J4AT3HfVyr4TV10H/7jM+kRtKWfaP/TskMqUGKtX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ka/TIpNzDOFyNO3+wiVsjA04bPMyRqKBpIA+KzmNPtlXoMK9
	9GgY9SdMm2Al8NaS7R4V2wvdbRt8NXKNl3pKRhh/xGiQpV81k6VvFOZlqnhPEBSXzqkH0l0JOcs
	o+RvqJwGEURPfwPrsIXTofiZmT4nHh8k7gxl1xSjaJHovO8fhIKCC6FRnVyaWJXPvUvL8PFo=
X-Gm-Gg: ASbGnctipSo2cEqK60/w8bjA7Pc1s0/v90CGF7jUPnCF2CgzBGDZM3kkh7MF6F9zQYV
	XcIxafgYowNPXUNzA9R7ktJhr7EPy6wXihruZR0l9G8mBYgN0fux80MhLr7f6q0ofZSIFG2x3TO
	h08hmntXOiAw6RYoAcdPn/ZiGIYCcLAkVlRIJUcV+E7UX8vO9a7ARAXLJgzfIfsebOGDbI44cD6
	NUKOoVrEqEMkAwgUrZrug+etVbsAcSNxxgykpFFU0QS13dPMqRfB75Fn/kKui+ga2DAK36LcVtH
	KTatrtogQCD+9annUGhNguLapZ+qxRa8O98agJAzSEcpEPNDnOYmimkldOUOthDDKEKa4RGd
X-Received: by 2002:a17:907:1ca8:b0:ac1:fa91:2b98 with SMTP id a640c23a62f3a-ac7d6d00dafmr1619424466b.14.1744126815484;
        Tue, 08 Apr 2025 08:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8aLezkLhIOxoF3ubbNutZOtgZSeu+nF9/yCx5dLPuyit/AbsIcKCEyAJEIEGs3zk4DrLqig==
X-Received: by 2002:a17:907:1ca8:b0:ac1:fa91:2b98 with SMTP id a640c23a62f3a-ac7d6d00dafmr1619421266b.14.1744126815056;
        Tue, 08 Apr 2025 08:40:15 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-212-63.pool.digikabel.hu. [193.226.212.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bb793sm927553766b.161.2025.04.08.08.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:40:14 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 2/3] ovl: relax redirect/metacopy requirements for lower -> data redirect
Date: Tue,  8 Apr 2025 17:40:03 +0200
Message-ID: <20250408154011.673891-3-mszeredi@redhat.com>
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

Allow the special case of a redirect from a lower layer to a data layer
without having to turn on metacopy.  This makes the feature work with
userxattr, which in turn allows data layers to be usable in user
namespaces.

Minimize the risk by only enabling redirect from a single lower layer to a
data layer iff a data layer is specified.  The only way to access a data
layer is to enable this, so there's really no reason not to enable this.

This can be used safely if the lower layer is read-only and the
user.overlay.redirect xattr cannot be modified.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/overlayfs.rst |  7 +++++++
 fs/overlayfs/namei.c                    | 14 ++++++++------
 fs/overlayfs/params.c                   |  5 -----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 2db379b4b31e..4133a336486d 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -443,6 +443,13 @@ Only the data of the files in the "data-only" lower layers may be visible
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
index 5cebdd05ab3a..3d99e5fe5cfc 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1068,6 +1068,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	bool upperopaque = false;
 	char *upperredirect = NULL;
+	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
 	struct dentry *this;
 	unsigned int i;
 	int err;
@@ -1080,7 +1081,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		.is_dir = false,
 		.opaque = false,
 		.stop = false,
-		.last = ovl_redirect_follow(ofs) ? false : !ovl_numlower(poe),
+		.last = check_redirect ? false : !ovl_numlower(poe),
 		.redirect = NULL,
 		.metacopy = 0,
 		.nextredirect = false,
@@ -1152,7 +1153,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			goto out_put;
 		}
 
-		if (!ovl_redirect_follow(ofs))
+		if (!check_redirect)
 			d.last = i == ovl_numlower(poe) - 1;
 		else if (d.is_dir || !ofs->numdatalayer)
 			d.last = lower.layer->idx == ovl_numlower(roe);
@@ -1233,13 +1234,14 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
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
-	if (!ovl_check_nextredirect(&d)) {
+	} else if (!ovl_check_nextredirect(&d)) {
 		err = -EPERM;
 		goto out_put;
 	}
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 6759f7d040c8..2468b436bb13 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1025,11 +1025,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
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
2.49.0


