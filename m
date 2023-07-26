Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF37638B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjGZOMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjGZOL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0423C0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:19 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE81142419
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380654;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=djrM7BUOB5QN8syjbKZkb7GeZo7d0coGbLOVwG0furKKiUUYF+Y4gsCfig7cABDwe
         2DhZIMLAhpJ0hibGnz2aaOmSed7ojA1R9PEJTnDDzQVWBt3xPAhNdlWfTyV+h3pq8e
         t7dclQsUy/aWdzBHp/ngplKkkqBTsRYJ8CdfPSPYV/zyT81mfUs2h2Ej7Qyuz4odOH
         TTEXUU9LIXNgG6OBIx8wC7UrEeWw5nrTUaLLwXyIYclhAfNOjAk0Q5UHBIFEc0R8Mz
         4hs+o1zKPVLfuUt58TrzHSEqknHJ6ZsK4TLxS4GLLr148NHpFTXv27fU0x0PRbxR7c
         YypvQc7mjH4LQ==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc08035926so5446175e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380650; x=1690985450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        b=IgHOolW3C2kaAB2IzFU0/lBfG3AdFyLeN4A91LYaylK8qvJQRGNzCsJq+x/fSBLUyI
         1a+2fdgZjhD1rWz+iORm0Sd83yfcyDk8qxfOk2xDZNxCqFp8VBvvItE1YQ7M+UFSSh82
         NBcyuoMEPWaCTv4e11AFVHOSu4rQGwXqmnqvIWGQcilO5fbdnhJWGFtbjhbo0WHabHUp
         EaOWYgDOu+hf+4qWBw9XsXOvjGUtRvGUHlLXTXNmL9+56g1WtjnAnzUkwGm+WzUQxp3s
         lQ1inR+zG3aWa4sJuU6izLhdMy6aanKxefWC+dGh0t04aW+uJoCX/ru+VZLLKNL924U4
         4SsA==
X-Gm-Message-State: ABy/qLbawFrExiV8Hxhcrvku0IjhmXn2mAO3jMqAx2NYN7N43raT173q
        +UseA+jJQZES1C5wSPBcgVoDfkSpciDmvVF3L3oCE3087oaPLzatIgtyKRGEI4JZ1UemrUeB4xB
        UCECsDr00+T8FuVNOoGxhvBbUDZyiLimAv5Ye0t36K64=
X-Received: by 2002:a05:600c:5187:b0:3fa:821e:1fb5 with SMTP id fa7-20020a05600c518700b003fa821e1fb5mr5126471wmb.5.1690380650030;
        Wed, 26 Jul 2023 07:10:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3vgh1vilw9HPtXuiXsfkEOE9dbE0ckzneQHHB2BWQmWcFwMl6ymv0AAvGdaSctcqacjEDiA==
X-Received: by 2002:a05:600c:5187:b0:3fa:821e:1fb5 with SMTP id fa7-20020a05600c518700b003fa821e1fb5mr5126454wmb.5.1690380649765;
        Wed, 26 Jul 2023 07:10:49 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:49 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/11] ceph: pass idmap to __ceph_setattr
Date:   Wed, 26 Jul 2023 16:10:22 +0200
Message-Id: <20230726141026.307690-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just pass down the mount's idmapping to __ceph_setattr,
because we will need it later.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c    | 4 ++--
 fs/ceph/crypto.c | 2 +-
 fs/ceph/inode.c  | 5 +++--
 fs/ceph/super.h  | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 32b26deb1741..89280c168acb 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -142,7 +142,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		newattrs.ia_ctime = current_time(inode);
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-		ret = __ceph_setattr(inode, &newattrs, NULL);
+		ret = __ceph_setattr(idmap, inode, &newattrs, NULL);
 		if (ret)
 			goto out_free;
 	}
@@ -153,7 +153,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			newattrs.ia_ctime = old_ctime;
 			newattrs.ia_mode = old_mode;
 			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-			__ceph_setattr(inode, &newattrs, NULL);
+			__ceph_setattr(idmap, inode, &newattrs, NULL);
 		}
 		goto out_free;
 	}
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index b9071bba3b08..8cf32e7f59bf 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -112,7 +112,7 @@ static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t l
 
 	cia.fscrypt_auth = cfa;
 
-	ret = __ceph_setattr(inode, &attr, &cia);
+	ret = __ceph_setattr(&nop_mnt_idmap, inode, &attr, &cia);
 	if (ret == 0)
 		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
 	kfree(cia.fscrypt_auth);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9b50861bd2b5..6c4cc009d819 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2466,7 +2466,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	return ret;
 }
 
-int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
+int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+		   struct iattr *attr, struct ceph_iattr *cia)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
@@ -2818,7 +2819,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
 		return -EDQUOT;
 
-	err = __ceph_setattr(inode, attr, NULL);
+	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4e78de1be23e..e729cde7b4a0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1101,7 +1101,8 @@ struct ceph_iattr {
 	struct ceph_fscrypt_auth	*fscrypt_auth;
 };
 
-extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
+extern int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+			  struct iattr *attr, struct ceph_iattr *cia);
 extern int ceph_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct mnt_idmap *idmap,
-- 
2.34.1

