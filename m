Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A524A14EC02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 12:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgAaLuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 06:50:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39244 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728532AbgAaLuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580471422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQ17yO5W5w5qlWY/ou9U5Zs/oUqInXzTRAcl/4EyG5I=;
        b=RjlB8fh2PCaMYb2YmYFSWQk5wgV7CKxrXtTCJWs1Q4xMTzIcrkvrex9N0ugiQQ7D9Rdgl7
        bnML/4OtPz58gnhxSk8Ydu3Meck6YD73DtQyIOUVbMFTMgVPxXFIl14cDWLG24QkxtjIgh
        Cp5C0cEc+FmByBtjkDfSVNf/nRVEHIA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-kWuHB4ZwM6e9BjdZ3BQBgQ-1; Fri, 31 Jan 2020 06:50:18 -0500
X-MC-Unique: kWuHB4ZwM6e9BjdZ3BQBgQ-1
Received: by mail-wr1-f69.google.com with SMTP id u8so2242214wrp.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 03:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQ17yO5W5w5qlWY/ou9U5Zs/oUqInXzTRAcl/4EyG5I=;
        b=q0POZ5jKBVgicu9XTK8dp6NV8+SA56SOZgMvZrscW2X+AoKq+zTc3tXtqiW7rFheX0
         ergy6npIncTckvN8CbqIhNbxiShUFmlL8ZRQ/FWigkawL6wYMj4gVvM5fbW2TPhP6Ss2
         yapSEvs7Lhip5PLHc7HjI+wWenej/vNhzHgLUElPbczt4T36MlqEdCP4MZbJcI+V5MLO
         BhyNj61Z8z4wbecF3uMXgop5poFnNzaU/dJJjSbdAXllH4+4XCi9xjiyKqZuL5EdpHLc
         EFXzhHyerkQkHCp0Y3sbRxb7+nt8x4ROEthqeZpshdsFQ352/4sLSEHNdLov/ZbkZJ+G
         nOrA==
X-Gm-Message-State: APjAAAU388jo/SAUTD1rF4gnbv1OgdWLNLFUFcp0SDzPHzIX4wc9HZhA
        e2uenDU/kbyjA5K3h2IbwKwafz0JUzj9ykl6G3vW03B4xtUpfbCRWlJhLl7Ik/BT4f6kGyx71kE
        c9szdXKWXDDQrxLZEGA3SHseXvQ==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr11697472wmj.169.1580471417371;
        Fri, 31 Jan 2020 03:50:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqywPWhJTRUZpBkOIsW+lcecG5d1oMkcsu1k0suFAsbAcNAiz2UC4Oc6MWvdVzVLHNED2OGdiQ==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr11697450wmj.169.1580471417132;
        Fri, 31 Jan 2020 03:50:17 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (84-236-74-45.pool.digikabel.hu. [84.236.74.45])
        by smtp.gmail.com with ESMTPSA id s1sm2746622wro.66.2020.01.31.03.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 03:50:16 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-unionfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 4/4] ovl: alllow remote upper
Date:   Fri, 31 Jan 2020 12:50:04 +0100
Message-Id: <20200131115004.17410-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200131115004.17410-1-mszeredi@redhat.com>
References: <20200131115004.17410-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No reason to prevent upper layer being a remote filesystem.  Do the
revalidation in that case, just as we already do for lower layers.

This lets virtiofs be used as upper layer, which appears to be a real use
case.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c | 3 +--
 fs/overlayfs/super.c | 8 ++++++--
 fs/overlayfs/util.c  | 2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 76e61cc27822..0db23baf98e7 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -845,8 +845,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (err)
 			goto out;
 
-		if (upperdentry && (upperdentry->d_flags & DCACHE_OP_REAL ||
-				    unlikely(ovl_dentry_remote(upperdentry)))) {
+		if (upperdentry && upperdentry->d_flags & DCACHE_OP_REAL) {
 			dput(upperdentry);
 			err = -EREMOTE;
 			goto out;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 26d4153240a8..ed3a11db9039 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -135,9 +135,14 @@ static int ovl_dentry_revalidate_common(struct dentry *dentry,
 					unsigned int flags, bool weak)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
+	struct dentry *upper;
 	unsigned int i;
 	int ret = 1;
 
+	upper = ovl_dentry_upper(dentry);
+	if (upper)
+		ret = ovl_revalidate_real(upper, flags, weak);
+
 	for (i = 0; ret > 0 && i < oe->numlower; i++) {
 		ret = ovl_revalidate_real(oe->lowerstack[i].dentry, flags,
 					  weak);
@@ -747,8 +752,7 @@ static int ovl_mount_dir(const char *name, struct path *path)
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
 
-		if (!err && (ovl_dentry_remote(path->dentry) ||
-			     path->dentry->d_flags & DCACHE_OP_REAL)) {
+		if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
 			pr_err("filesystem on '%s' not supported as upperdir\n",
 			       tmp);
 			path_put_init(path);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 3ad8fb291f7d..c793722739e1 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -96,6 +96,8 @@ void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
 	struct ovl_entry *oe = OVL_E(dentry);
 	unsigned int i, flags = 0;
 
+	if (upperdentry)
+		flags |= upperdentry->d_flags;
 	for (i = 0; i < oe->numlower; i++)
 		flags |= oe->lowerstack[i].dentry->d_flags;
 
-- 
2.21.1

