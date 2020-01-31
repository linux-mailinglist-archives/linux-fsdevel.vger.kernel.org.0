Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952D714EBFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAaLuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 06:50:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728423AbgAaLuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580471418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Gs10o8erqjXnGfNlK1akrFju0qr46cuwrqKnpu2IuE=;
        b=WlU4ydYinuCZgclzT3CGO/IzmuOVjlIIuCX+kp9YTuIH3F2E5wIDmRxTTsDkwa3mNQiigg
        8EdtSroRnnn+Ed+VFfqJPfwvd6azBcC9ogjVwuehVLzEFWu77CJrl2yNUmEcitrVRuX7oR
        /yLhbHNpQs4nI735MKM1q3OB+tePwMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-po4ZvCt1NlyftMAnDiNiJw-1; Fri, 31 Jan 2020 06:50:16 -0500
X-MC-Unique: po4ZvCt1NlyftMAnDiNiJw-1
Received: by mail-wm1-f71.google.com with SMTP id g26so2702654wmk.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 03:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Gs10o8erqjXnGfNlK1akrFju0qr46cuwrqKnpu2IuE=;
        b=O6vablVLuzVPWLIQf76dPtqEUJa9VS9/5J25tEWfsdyH4nQwYa1lb5T0dtolE+MHwg
         Zdp9dxOSo0d4AnWCaGD94oeV8yohuyEGToDs4lfELHK19nIxPfH4HkQufrMSpwaW8c84
         RBVAkPACunZbgD9aEAh5XQfRWiMYXySSzqkQN2k+9MRk2apejPACBhYDeVrF4aghfQn2
         S1dw8kv7Md4rJjlzRDZZXZKfS/p6gY/y/8oqxFINuNB0ZHCP6UhBef53oB8R6rct5KtO
         v1w4HpICgpTsajkRBPwycjVJyCJpVP4pblJ8htG2VNvfALPF6voUBcAempLEVjJAygfF
         PDSA==
X-Gm-Message-State: APjAAAXrVkcW86/vRyd8Prh6cuHHK5154dDsQhu2/utFN9XBFmpyYrfR
        5lDMtwomD9gNOkOWIA7FbedqDmd8BPXAodAp6/bBYUXFlAqpip48nqHwHMn0zNvD0DALyLIylrA
        jMtcgMPdHDrFLFKR7zpBSZgTTDA==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr11335624wmf.113.1580471415541;
        Fri, 31 Jan 2020 03:50:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5XnMHv+48gW8liIrBqG0aVQmKuS27GqhXks1xZLqKou+Dbno3hgisv0P7LNmG0pxMXvfAQA==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr11335605wmf.113.1580471415325;
        Fri, 31 Jan 2020 03:50:15 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (84-236-74-45.pool.digikabel.hu. [84.236.74.45])
        by smtp.gmail.com with ESMTPSA id s1sm2746622wro.66.2020.01.31.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 03:50:14 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-unionfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/4] ovl: separate detection of remote upper layer from stacked overlay
Date:   Fri, 31 Jan 2020 12:50:02 +0100
Message-Id: <20200131115004.17410-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200131115004.17410-1-mszeredi@redhat.com>
References: <20200131115004.17410-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following patch will allow remote as upper layer, but not overlay stacked
on upper layer.  Separate the two concepts.

This patch is doesn't change behavior.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/namei.c |  3 ++-
 fs/overlayfs/super.c | 14 +++++++-------
 fs/overlayfs/util.c  |  3 +--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ed9e129fae04..a5b998a93a24 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -845,7 +845,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		if (err)
 			goto out;
 
-		if (upperdentry && unlikely(ovl_dentry_remote(upperdentry))) {
+		if (upperdentry && (upperdentry->d_flags & DCACHE_OP_REAL ||
+				    unlikely(ovl_dentry_remote(upperdentry)))) {
 			dput(upperdentry);
 			err = -EREMOTE;
 			goto out;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 852a1816fea1..7e294bf719ff 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -752,13 +752,13 @@ static int ovl_mount_dir(const char *name, struct path *path)
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
 
-		if (!err)
-			if (ovl_dentry_remote(path->dentry)) {
-				pr_err("filesystem on '%s' not supported as upperdir\n",
-				       tmp);
-				path_put_init(path);
-				err = -EINVAL;
-			}
+		if (!err && (ovl_dentry_remote(path->dentry) ||
+			     path->dentry->d_flags & DCACHE_OP_REAL)) {
+			pr_err("filesystem on '%s' not supported as upperdir\n",
+			       tmp);
+			path_put_init(path);
+			err = -EINVAL;
+		}
 		kfree(tmp);
 	}
 	return err;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index ea005085803f..67cd2866aaa2 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -93,8 +93,7 @@ struct ovl_entry *ovl_alloc_entry(unsigned int numlower)
 bool ovl_dentry_remote(struct dentry *dentry)
 {
 	return dentry->d_flags &
-		(DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE |
-		 DCACHE_OP_REAL);
+		(DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
 }
 
 bool ovl_dentry_weird(struct dentry *dentry)
-- 
2.21.1

