Return-Path: <linux-fsdevel+bounces-44944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB2A6EE2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6826F3ABB95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B75255227;
	Tue, 25 Mar 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6W5P+rz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F83254B12
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899606; cv=none; b=gMop+NAwf6InsDkLlaO+OtfFJxkYkapCDpw9+Tz+RHaxvcGR15uSAE339iHRmdhGRloe5hbUdCjvlikQN2MLFrRjWgCH4jgaBgQg5Sicw7yVJ4NDV2WP5CC0KpeKcXDgc7TPILg5zfpZbP+qMWzSUiwa22mqCzsgN9cnNF7Fhuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899606; c=relaxed/simple;
	bh=XcE6aF16Cf8zqM2D+v98BhQci6j4B47yoqgwzT6aiuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An4xwa5XsQn8jqZfc51kGSBNkSHw8T7fdOhBVtG1Ds9xOf4/cFZdHUJ413yEHpsiYK2R+rY2f9pl36y6sQ/3pTqjzaGwsa7Nafjqg26o5BO4xSJXeDTb1vFmouxjF3BCcRNf5p7ci2T+Mk+0/QfWMmw9iO3aE6lRvU1OrDrqDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6W5P+rz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhA5kDM5+jcYSJvVRkt3ekAgbNB07vU7STrO48YEDRA=;
	b=F6W5P+rzR6XurlGR8v5JbCLeZ5obctbTX/2wiB+HtIDM26ZsCCBV9FoyQTIGErcDBEyNQE
	IqSh+3jel8ji4yS8zlgyaGlfmoQiutGBAE3DM799btlWOa2G4aRZsyHgh/NMSo6m7OSvWz
	cFRDToHXqx4dLPWT/xo84GoJYo4ybxs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-u32TufyUOzuNFujWlMtCFw-1; Tue, 25 Mar 2025 06:46:42 -0400
X-MC-Unique: u32TufyUOzuNFujWlMtCFw-1
X-Mimecast-MFC-AGG-ID: u32TufyUOzuNFujWlMtCFw_1742899601
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d51bd9b41so35192645e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899600; x=1743504400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhA5kDM5+jcYSJvVRkt3ekAgbNB07vU7STrO48YEDRA=;
        b=hfqYhA7Gn6UmHnYVrlkjLkS6YSJw1bLzF/YLvHXNaoVEoWOqNBrRtTiBG7InEdM19g
         WTnXb9as+3OJNo1nWFb8XfcSjiNScqnDImP1uTlz6n69d+Q5MVHrDHVybiW1JvwLz0ZG
         IIJqfAEUhcCxT2xpnF+zB37AYiKQZ6DVMCtSS9La+abzhOVpesczK0hMWpXCUnuJ5jgr
         uRUMilbKonKg0mQEvN8a/dDEaQMGzdYGVDjndYbnkzBZnpO5wxhhko4z5X7qJmPyqBjX
         CbmdUBrEVR5nyeed8ymOf60MecqNQR/i9vRw+R6QBd6mOg3NakhtmjnT4kePQFGDjR/D
         Fetw==
X-Forwarded-Encrypted: i=1; AJvYcCUnWKr4HxLc1oaSyEUwo9I3VwssNcjljEKFqcdN1W0klN8Ua3Mhb2n50Zezhw5rsc64+xL5rrIOWEw5kFdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMzkkxPzki0tMM+tE+WgwjjeqLoj00NFU9352YMQLzh3hmNVB
	DCUKYSp5stljsVN93MIk8Y6NiRlo/vMBzQGExH6g6MDySwvDXWISZVQE2Z9KsXd6Ze7aAMpwAyJ
	BbPpiNX750LtcPhF9O//xqWNZmwvpWoMr3YNthR4WcXwqHiCiWzniSai+V0RobxhC5f6YOxU=
X-Gm-Gg: ASbGncvH/BQtTkKvSf7ZU7/em/mFyM+D5l9mFIgnyPJeBT7GNbNwEUANOLKOqg6k7ZB
	qnqMm0ArJI+kvhQfZZ6Px9jWiLa+D/aiZOKUBOq4RNk26UyWPhDjSyv4jWOxmusOHFsQlzk4eTa
	8fU6nuli3ezlbqbsAXgLcmU5zQA4B8DdGtKocriaTt0j15I4vyDzSzVsjndzu+XvEWVSX3oNFHQ
	P2+y0Am6ZdIvLfIxxlGt8jv4VH/KclJfsC/M3Lt6zCqYuBI9uZ1u4v5EPQn1FK328kwNJ1KxluA
	XRYFUZWQK6pUQd2lrfWY/tWz3F/VgIuPGJgJVMCG7HeTw6WGaiGTjQUTFizlA5vRY5I=
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3997f9017e3mr13343746f8f.20.1742899600596;
        Tue, 25 Mar 2025 03:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbPPs/nAg4mKC7AwHAR8W+zGH69t5hR9rjVp3HeotKO+cWygs7AM9z/RQvxH00uZ1CSBaciw==
X-Received: by 2002:a05:6000:178c:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3997f9017e3mr13343720f8f.20.1742899600111;
        Tue, 25 Mar 2025 03:46:40 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:39 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 4/5] ovl: relax redirect/metacopy requirements for lower -> data redirect
Date: Tue, 25 Mar 2025 11:46:32 +0100
Message-ID: <20250325104634.162496-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325104634.162496-1-mszeredi@redhat.com>
References: <20250325104634.162496-1-mszeredi@redhat.com>
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
2.49.0


