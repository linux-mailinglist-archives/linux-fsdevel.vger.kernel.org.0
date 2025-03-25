Return-Path: <linux-fsdevel+bounces-44943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC80A6EE21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912781891D40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586B255238;
	Tue, 25 Mar 2025 10:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNQi8nAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E3254AED
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899605; cv=none; b=WmfjTGg/zo0UUZHe9IsQDB/70pPoubeiqj448EXj+MnIXuoy6I1ByPQd8A429emX8Kzun0IXtWh4gDMdzMq0KpfebrThBwLhr3h1w6Xn0zEK+wELztxY3XBcrtVlJhmTdHft3iY5xPADAI0gHx1oBP2QXJ068RL4iwvH+2dyvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899605; c=relaxed/simple;
	bh=dAcXi5fAdxGzgjq/JG7eFreFDNKrZcOkDEPNAgtXUSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W218mFoC0o+Ua2sh3vHGGcd6rgDvaZTpK2PbmNeF0Sx4B+t0o9fDTkeA0fyoOQKujcVwOkfm0UpJiJ9ONOn6ymCTg2kUn/PjelMOhw9qdf/IwCRSR9XAYzYOxd/LfDwK141u0QUCpcG0A0ZiQYbmqqY6ekPt5CoBD2N8oPUO6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNQi8nAA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742899602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtuxOK/+soZt5CGwob3MZFUYvqt0G5t0rerQy2j1XuI=;
	b=SNQi8nAArpF5ZPT5wEeOnyhZwje4/7+W3oHgqML3zNquSTRcgGn65hwJ0/9omkrupldXRX
	nVV0u0tdZ12dAxktT/LDvkuDXy7PxI8ptMFiY3to/dzdJ+z7MmxjgfTWXbuuZ0IXEvwkvN
	MCXenmPwHGhiAFMKqMKuHkiCij9T2Y0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xVCd2NFZOAeaROz4l0Lm1A-1; Tue, 25 Mar 2025 06:46:40 -0400
X-MC-Unique: xVCd2NFZOAeaROz4l0Lm1A-1
X-Mimecast-MFC-AGG-ID: xVCd2NFZOAeaROz4l0Lm1A_1742899600
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39142ce2151so2184672f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Mar 2025 03:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899600; x=1743504400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtuxOK/+soZt5CGwob3MZFUYvqt0G5t0rerQy2j1XuI=;
        b=Jk65abQPOeKErJHDSJzWIj66NcoS1zevxrR8dV351IYTo3mLN9EAJNhzBwUkf7w5+Y
         oAO+Ii4W+aVyrMiYjwDktO9NVKTbmD/uOHCoxhfg2QWAWf41MyBFFtRTySkObzOYGNu1
         FQbm4vaXWMO22ZFmizXrWqk1mOY0swN4VYuwu7zJ4Ah1zb6HbUcV3lFeUXbqY0oWkiKB
         kPIHtsVxvwylbZ4M2RlimaCbEe/P/ZEKlK12hccJvJAh21iL9DrlMXOtAtfGGKYp4BaR
         M0+Qg94RAgfvpDQ1wpFAhuZIZ+CM2Re2Mqp3rxK0J0fcvD987rRn7Mnp7kLyJN/Ya3mv
         PbLw==
X-Forwarded-Encrypted: i=1; AJvYcCWo0yNpyPJaISGBPQi1QYOzPAnrc9LVb8ce0Y+Ek9ubYOJHyp/7pdWWjrvvNi63l2RUPiP/WaJ8gx1iuDM1@vger.kernel.org
X-Gm-Message-State: AOJu0YyNHlpB/9cmRTxTyEUgnSdq1lESDolkjUeokugUtBgrlZ+h7TCV
	jlDQjW5xA1upSzIpOZ0br6HEIapXVOAtGjS6xjgNJHaEZupxWW/qUwcaQuAGm+Kqk1X5dYZoG1/
	xPEzIOSLySJZZFtxQZjpLwfjatbPxzpVKlRXOPoFahvMoctV5wvS+hY6ymZHkMag=
X-Gm-Gg: ASbGnctYPFEsPiDxqhgRj+JVRa6Vmhmvoixk8I586Yhx8VANpTVtlwOLMjZUhw3i2mk
	0ty3DFrNfVgqBTlYSIj68LwNg50wKHYKEb8DL6N5XbY5/Ocy8+/Xe+6zpF8IwoFGX+8ioWbikfp
	J0P4Xt/8zCsM4Z/YkJY7TENSJ30KxWxkY5M7GdFuAjf7gWrdZGYQ1TyfTT/8cT2f5lpsW4U/9OI
	pgdHsiSUXkt9qXaRhBw6TvEw8pLacggZZyMFwyXhQvgh/zaHGkM/MOLgItHV9WP/FhV4Ba/t/H6
	LEcuQ+tSctFIVfDM+9XNuXaE3qbrDnuT4b6JI8KygfQZ2XY4FkFpsg4deKsx/woZa8U=
X-Received: by 2002:a5d:64e4:0:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-3997f8fa8f5mr14887691f8f.12.1742899599689;
        Tue, 25 Mar 2025 03:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbKZ4B8bhTCOofTlxaf+tlZNeeNYajiCDudd7iSXdtr0NxTTXTB04kEWPjz7bTK9e4I/Ac9w==
X-Received: by 2002:a5d:64e4:0:b0:38f:3b9b:6f91 with SMTP id ffacd0b85a97d-3997f8fa8f5mr14887665f8f.12.1742899599327;
        Tue, 25 Mar 2025 03:46:39 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (87-97-53-119.pool.digikabel.hu. [87.97.53.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a50c1sm13572203f8f.38.2025.03.25.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 03:46:38 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v2 3/5] ovl: make redirect/metacopy rejection consistent
Date: Tue, 25 Mar 2025 11:46:31 +0100
Message-ID: <20250325104634.162496-4-mszeredi@redhat.com>
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

When overlayfs finds a file with metacopy and/or redirect attributes and
the metacopy and/or redirect features are not enabled, then it refuses to
act on those attributes while also issuing a warning.

There was a slight inconsistency of only warning on an upper metacopy if it
found the next file on the lower layer, while always warning for metacopy
found on a lower layer.

Fix this inconsistency and make the logic more straightforward, paving the
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
2.49.0


