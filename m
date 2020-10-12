Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175D828C43D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgJLVn5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgJLVn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:43:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6962C0613D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 14:43:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w11so1676431pll.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SblYN1e37CL9JdaGLQ5Y/6gLdI5UbuRc4P5/Ws+FaE0=;
        b=trBiP6d4fYRQAfCdkqfM2hxAOmzzL+Ns2poC/dNnkAOtywmreZp1ZPUisBbEl43Q0b
         XCCJX6j3+KcWMzUSVnqkKEL4WKhOxK2eb95cqKCWqOzssj5Gwi9Gt3kwY6jKSYEvNEKZ
         1c8JLeN+t3UeVSfmoMB6wpOEHRQoCnoUTvVGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SblYN1e37CL9JdaGLQ5Y/6gLdI5UbuRc4P5/Ws+FaE0=;
        b=d7LqPbzZX6OKZXgPTYmhEGTUBuLs97c5JjOJQwcVlKF1BCC1yE8Sf7NdOjx0HezfsR
         DvM5R/HcIkRUTkr8CdAe88JZDKsPQ19QGWYMpyP6Q7uqkfKupOn+qN/33RHP80CS5leZ
         GeQ2RhM2xvV2zwowHhRDQb80VPUNk05IjgVb8R7X6a9rrAaLJQFSEtpOdOij67dqtfEV
         FrAj22+h+vHeYbCAE/ly004mYNphR2aiD9Eb+Vm+Yx8jBWgFqlQPlIQ1RT4wynct3+wz
         a6SmYffJuui7oSuj8eK+bae/09y735FIOu3mrAeJcGaPI6Zhqlt39iiSFnZZOc8BWaqw
         8iGA==
X-Gm-Message-State: AOAM531wjXcLyd1t0vERxPrAZNZN7PROPNPNnjf7man5lVpY7T8XPbMv
        HoEEUrZy2/8i6gEUSLy0Xx7gcg==
X-Google-Smtp-Source: ABdhPJze2pu/LKw8phRCCUQRAYxhYqKPdK6K3HHpTH98lUUyjsv8/goN67o4aAofFpjme7TAcbslYQ==
X-Received: by 2002:a17:902:8d86:b029:d1:9237:6dfd with SMTP id v6-20020a1709028d86b02900d192376dfdmr25060401plo.22.1602539035925;
        Mon, 12 Oct 2020 14:43:55 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id x5sm21284370pfp.113.2020.10.12.14.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 14:43:55 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Only reference user namespace from nfs4idmap struct instead of cred
Date:   Mon, 12 Oct 2020 14:43:39 -0700
Message-Id: <20201012214339.6070-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nfs4idmapper only needs access to the user namespace, and not the
entire cred struct. This replaces the struct cred* member with
struct user_namespace*. This is mostly hygiene, so we don't have to
hold onto the cred object, which has extraneous references to
things like user_struct. This also makes switching away
from init_user_ns more straightforward in the future.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 fs/nfs/nfs4idmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 62e6eea5c516..8d8aba305ecc 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -46,6 +46,7 @@
 #include <keys/user-type.h>
 #include <keys/request_key_auth-type.h>
 #include <linux/module.h>
+#include <linux/user_namespace.h>
 
 #include "internal.h"
 #include "netns.h"
@@ -69,13 +70,13 @@ struct idmap {
 	struct rpc_pipe		*idmap_pipe;
 	struct idmap_legacy_upcalldata *idmap_upcall_data;
 	struct mutex		idmap_mutex;
-	const struct cred	*cred;
+	struct user_namespace	*user_ns;
 };
 
 static struct user_namespace *idmap_userns(const struct idmap *idmap)
 {
-	if (idmap && idmap->cred)
-		return idmap->cred->user_ns;
+	if (idmap && idmap->user_ns)
+		return idmap->user_ns;
 	return &init_user_ns;
 }
 
@@ -286,7 +287,7 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	if (!idmap->cred || idmap->cred->user_ns == &init_user_ns)
+	if (!idmap->user_ns || idmap->user_ns == &init_user_ns)
 		rkey = request_key(&key_type_id_resolver, desc, "");
 	if (IS_ERR(rkey)) {
 		mutex_lock(&idmap->idmap_mutex);
@@ -462,7 +463,7 @@ nfs_idmap_new(struct nfs_client *clp)
 		return -ENOMEM;
 
 	mutex_init(&idmap->idmap_mutex);
-	idmap->cred = get_cred(clp->cl_rpcclient->cl_cred);
+	idmap->user_ns = get_user_ns(clp->cl_rpcclient->cl_cred->user_ns);
 
 	rpc_init_pipe_dir_object(&idmap->idmap_pdo,
 			&nfs_idmap_pipe_dir_object_ops,
@@ -486,7 +487,7 @@ nfs_idmap_new(struct nfs_client *clp)
 err_destroy_pipe:
 	rpc_destroy_pipe_data(idmap->idmap_pipe);
 err:
-	put_cred(idmap->cred);
+	get_user_ns(idmap->user_ns);
 	kfree(idmap);
 	return error;
 }
@@ -503,7 +504,7 @@ nfs_idmap_delete(struct nfs_client *clp)
 			&clp->cl_rpcclient->cl_pipedir_objects,
 			&idmap->idmap_pdo);
 	rpc_destroy_pipe_data(idmap->idmap_pipe);
-	put_cred(idmap->cred);
+	put_user_ns(idmap->user_ns);
 	kfree(idmap);
 }
 
-- 
2.25.1

