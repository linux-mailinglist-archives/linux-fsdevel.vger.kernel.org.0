Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A055276FC82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjHDIum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjHDItk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4464C27
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:37 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4AEDE417B9
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138976;
        bh=vA7Z34zBj4jzvwwxICC6DC+yM3ZqeVgNJDmT3zJBPQ8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ci2CMG3ncGg0IP9U/609DPvQt4Pgj4bbyeLT5R6FJ4R2H8mAcvLRCyj9MtpEgd2+J
         LlfysVhxwidJcKpKR01MY5nAgILNP+wYytWvBe9EQVmWvqEqFlDkaoIhCtZ+dVC9lT
         W1BNrABfg416RqhgRX+oVP88nFt4Z7LIAImcJohKl43lRJbk5L/k87uhoxtsHcb7zC
         xl592aKEBkYPa+40tN/zuzAGhQKHAX1QL8R20inRpNEsqslsZ7XTJgkKL3pjO2kJRU
         DVoUxIV1xvoFDe4njpQ9jTR+00USjCkRIfKkpHVGyn7xQwjjICdM2fvKH4V3XJ09UB
         RNMHUe1xQUfFg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bdee94b84so243390866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138975; x=1691743775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA7Z34zBj4jzvwwxICC6DC+yM3ZqeVgNJDmT3zJBPQ8=;
        b=B+aDHrf5Px/gEjZ2/8blmw1g4+5rGI7RhDbk24Xt7HEIepC2NEgOm+iSbjKOGTt2TN
         pE7eM/AFrtQFaXCss50LeAiurhB8fHkLIYSWYr63hOkmNIh3IFqYmAr3Y0aII4mi24TR
         zCRP1MS9q1go8MQkHDQjwIxAmkJIjhpY59V4KaaIWn/lKbs96brReSFRKzE3PZU6c86e
         mjkYiehTxgzNfIISZ5PF2pet1vion/uzGt3YEdZ0rCyLkf2/6+WZEDZ5WagvJV8BFLdx
         taa4Cn0ZUnt6x+ArC0xfJB4/vji3hqcvTjb6Or25fnvBi97kNIRavo7bmi+4AbRVeqVa
         P2vA==
X-Gm-Message-State: AOJu0YyGVCTNdH77twFsSvqiSGFEBC/bxZqi8pg96UG8SArf0f+2GLx5
        1Z+NhNuVe2o0bgV9se4XwsRQZSoBD1WmtSrUUV4PED8jcOdu6rxYn1B3DyTiObR4jll/mHxw82N
        L/VhJHMwURfMJ0i9Clw+Nu4e0NvxzqFBKJ9h8kY80e3W/Qfi9fxc=
X-Received: by 2002:a17:907:1ca5:b0:96f:9cea:a34d with SMTP id nb37-20020a1709071ca500b0096f9ceaa34dmr1440492ejc.21.1691138975510;
        Fri, 04 Aug 2023 01:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaLHd/m8ShBoFoitgZ3ppJ4N/JTnjCwUDlUN77awev8PwhYvcw899vgUcnvDYDfWuRJ/FGTg==
X-Received: by 2002:a17:907:1ca5:b0:96f:9cea:a34d with SMTP id nb37-20020a1709071ca500b0096f9ceaa34dmr1440479ejc.21.1691138975358;
        Fri, 04 Aug 2023 01:49:35 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:34 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/12] ceph: add enable_unsafe_idmap module parameter
Date:   Fri,  4 Aug 2023 10:48:50 +0200
Message-Id: <20230804084858.126104-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This parameter is used to decide if we allow
to perform IO on idmapped mount in case when MDS lacks
support of CEPHFS_FEATURE_HAS_OWNER_UIDGID feature.

In this case we can't properly handle MDS permission
checks and if UID/GID-based restrictions are enabled
on the MDS side then IO requests which go through an
idmapped mount may fail with -EACCESS/-EPERM.
Fortunately, for most of users it's not a case and
everything should work fine. But we put work "unsafe"
in the module parameter name to warn users about
possible problems with this feature and encourage
update of cephfs MDS.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Suggested-by: Stéphane Graber <stgraber@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/mds_client.c | 28 +++++++++++++++++++++-------
 fs/ceph/mds_client.h |  2 ++
 fs/ceph/super.c      |  5 +++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 41e4bf3811c4..42c0afbb6376 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2949,6 +2949,8 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	int ret;
 	bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
 	u16 request_head_version = mds_supported_head_version(session);
+	kuid_t caller_fsuid = req->r_cred->fsuid;
+	kgid_t caller_fsgid = req->r_cred->fsgid;
 
 	ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
 			      req->r_parent, req->r_path1, req->r_ino1.ino,
@@ -3044,12 +3046,24 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 
 	if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
 	    !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
-		pr_err_ratelimited_client(cl,
-			"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
-			" is not supported by MDS. Fail request with -EIO.\n");
+		if (enable_unsafe_idmap) {
+			pr_warn_once_client(cl,
+				"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
+				" is not supported by MDS. UID/GID-based restrictions may"
+				" not work properly.\n");
+
+			caller_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
+						   VFSUIDT_INIT(req->r_cred->fsuid));
+			caller_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
+						   VFSGIDT_INIT(req->r_cred->fsgid));
+		} else {
+			pr_err_ratelimited_client(cl,
+				"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
+				" is not supported by MDS. Fail request with -EIO.\n");
 
-		ret = -EIO;
-		goto out_err;
+			ret = -EIO;
+			goto out_err;
+		}
 	}
 
 	/*
@@ -3095,9 +3109,9 @@ static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
 	lhead->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
 	lhead->op = cpu_to_le32(req->r_op);
 	lhead->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
-						  req->r_cred->fsuid));
+						  caller_fsuid));
 	lhead->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
-						  req->r_cred->fsgid));
+						  caller_fsgid));
 	lhead->ino = cpu_to_le64(req->r_deleg_ino);
 	lhead->args = req->r_args;
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 8f683e8203bd..0945ae4cf3c5 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -619,4 +619,6 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
 extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
 extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
 extern int ceph_restore_deleg_ino(struct ceph_mds_session *session, u64 ino);
+
+extern bool enable_unsafe_idmap;
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 49fd17fbba9f..18bfdfd48cef 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1680,6 +1680,11 @@ static const struct kernel_param_ops param_ops_mount_syntax = {
 module_param_cb(mount_syntax_v1, &param_ops_mount_syntax, &mount_support, 0444);
 module_param_cb(mount_syntax_v2, &param_ops_mount_syntax, &mount_support, 0444);
 
+bool enable_unsafe_idmap = false;
+module_param(enable_unsafe_idmap, bool, 0644);
+MODULE_PARM_DESC(enable_unsafe_idmap,
+		 "Allow to use idmapped mounts with MDS without CEPHFS_FEATURE_HAS_OWNER_UIDGID");
+
 module_init(init_ceph);
 module_exit(exit_ceph);
 
-- 
2.34.1

