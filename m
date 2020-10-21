Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F85294C35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440005AbgJUMFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439997AbgJUMFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:05:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A61C0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 05:05:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lw2so1036929pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLn1x0a229/WkcL7/dHpbssMTZU0rXgDdf1xqdaPV3Q=;
        b=GxJ3G4RDlax+CMWklzAbiprEUD+1G2uWIJmvVWDLA/XN7EHQ8OSVGo06rSs0k7M0H8
         nEkZhQpI6AXtct80ms0hra9wJOf4R4ldgfSAPS1p7dwhgayvynUrndILReguMrHxD+Gq
         rtYMTAN3Iql7l5vYUN/mIgJGGHp8sH39yxPm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLn1x0a229/WkcL7/dHpbssMTZU0rXgDdf1xqdaPV3Q=;
        b=ZOP+2xA3Q3gaqDDn+KbmzyFitUwN0Zvd9cQO8p7UYkOjDEy9RtGvSHKiaIzzGBPXks
         f/YrotvmYR0u1BkYLYx64upn91SRv2zaeXTbeEI8a6IsSUGZtiYKMmKcQeHl2nXxzu8r
         +wCwBDheYs4PuXlXFj+ME7vIfeuISEau4t7F9gp/l0MedBb+WiUZDgvAIWB2mk9wi6tD
         XcUVZgGiJVVwVRe2tuD2HDls9MFguiVGe0WeCkIUb4qeZukNAbiDz9w4c19QtdlaI8x1
         IdwAkDpZicBa0gLH36NVw6CPBeUc2rWhX8V97a8V9mP1rR8my99kopc30P+7Cziv8YV3
         S0yA==
X-Gm-Message-State: AOAM533Ll0+7kYzVg+Tk/pdvSo77l7LBrU7s+WfsXbkc/sFk6f5t5nDr
        Vx3A0kyQF0tJihM5L79rsFiYYQ==
X-Google-Smtp-Source: ABdhPJwbJOHDfZc9DluTXh1hC3PF30lFHtcQ8YvHY2EPqNGCPlk96//ypyM34ATIq9vWGH5taROkkQ==
X-Received: by 2002:a17:902:7798:b029:d5:d3b6:2526 with SMTP id o24-20020a1709027798b02900d5d3b62526mr3424428pll.2.1603281944284;
        Wed, 21 Oct 2020 05:05:44 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b5sm2276392pfo.64.2020.10.21.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:05:43 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, kylea@netflix.com
Subject: [PATCH v3 3/3] NFSv4: Refactor NFS to be use user namespaces
Date:   Wed, 21 Oct 2020 05:05:29 -0700
Message-Id: <20201021120529.7062-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021120529.7062-1-sargun@sargun.me>
References: <20201021120529.7062-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In several patches work has been done to enable NFSv4 to use user
namespaces: 58002399da65: NFSv4: Convert the NFS client idmapper to use the
container user namespace 3b7eb5e35d0f: NFS: When mounting, don't share
filesystems between different user namespaces

Unfortunately, the userspace APIs were only such that the userspace facing side of the
filesystem (superblock s_user_ns) could be set to a non init user namespace. This furthers
the fs_context related refactoring, and piggybacks on top of that logic, so the superblock
user namespace, and the NFS user namespace are the same.

This change only allows those users whom are not using ID mapping to use user namespaces
because the upcall mechanism still needs to be made fully namespace aware. Currently,
it is only network namespace aware (and this patch doesn't impede that behaviour).
Also, there is currently a limitation that enabling / disabling ID mapping can only
be done on a machine-wide basis.

Eventually, we will need to at least:
  * Separate out the keyring cache by namespace
  * Come up with an upcall mechanism that can be triggered inside of the container,
    or safely triggered outside, with the requisite context to do the right mapping.
  * Handle whatever refactoring needs to be done in net/sunrpc.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/nfs4client.c | 27 ++++++++++++++++++++++++++-
 fs/nfs/nfs4idmap.c  |  2 +-
 fs/nfs/nfs4idmap.h  |  3 ++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index daacc78a3d48..0811e9540bf5 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1151,7 +1151,19 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (!server)
 		return ERR_PTR(-ENOMEM);
 
-	server->cred = get_cred(current_cred());
+	/*
+	 * current_cred() must have CAP_SYS_ADMIN in init_user_ns. All non
+	 * init user namespaces cannot mount NFS, but the fs_context
+	 * can be created in any user namespace.
+	 */
+	if (fc->cred->user_ns != &init_user_ns) {
+		dprintk("%s: Using creds from non-init userns\n", __func__);
+	} else if (fc->cred != current_cred()) {
+		dprintk("%s: Using creds from fs_context which are different than current_creds\n",
+			__func__);
+	}
+
+	server->cred = get_cred(fc->cred);
 
 	auth_probe = ctx->auth_info.flavor_len < 1;
 
@@ -1164,6 +1176,19 @@ struct nfs_server *nfs4_create_server(struct fs_context *fc)
 	if (error < 0)
 		goto error;
 
+	/*
+	 * nfs4idmap is not fully isolated by user namespaces. It is currently
+	 * only network namespace aware. If upcalls never happen, we do not
+	 * need to worry as nfs_client instances aren't shared between
+	 * user namespaces.
+	 */
+	if (idmap_userns(server->nfs_client->cl_idmap) != &init_user_ns &&
+		!(server->caps & NFS_CAP_UIDGID_NOMAP)) {
+		error = -EINVAL;
+		errorf(fc, "Mount credentials are from non init user namespace and ID mapping is enabled. This is not allowed.");
+		goto error;
+	}
+
 	return server;
 
 error:
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 8d8aba305ecc..33dc9b76dc17 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -73,7 +73,7 @@ struct idmap {
 	struct user_namespace	*user_ns;
 };
 
-static struct user_namespace *idmap_userns(const struct idmap *idmap)
+struct user_namespace *idmap_userns(const struct idmap *idmap)
 {
 	if (idmap && idmap->user_ns)
 		return idmap->user_ns;
diff --git a/fs/nfs/nfs4idmap.h b/fs/nfs/nfs4idmap.h
index de44d7330ab3..2f5296497887 100644
--- a/fs/nfs/nfs4idmap.h
+++ b/fs/nfs/nfs4idmap.h
@@ -38,7 +38,7 @@
 
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs_idmap.h>
-
+#include <linux/user_namespace.h>
 
 /* Forward declaration to make this header independent of others */
 struct nfs_client;
@@ -50,6 +50,7 @@ int nfs_idmap_init(void);
 void nfs_idmap_quit(void);
 int nfs_idmap_new(struct nfs_client *);
 void nfs_idmap_delete(struct nfs_client *);
+struct user_namespace *idmap_userns(const struct idmap *idmap);
 
 void nfs_fattr_init_names(struct nfs_fattr *fattr,
 		struct nfs4_string *owner_name,
-- 
2.25.1

