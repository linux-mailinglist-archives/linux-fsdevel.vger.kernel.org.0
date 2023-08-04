Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110F76FC90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHDIvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjHDIts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:48 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F14C04
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:45 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E03434248D
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138983;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kPXWFDv4IaWNdstC8tRD6ftykQZ0hcsdvqVN3fA48GNJBDTmBaxh4X5ucm/Crxo7w
         3xWVR9TV9WLcHPqVmXHFe858m1qWaIAuifPvsWeUFi0Rt0yrx32vkzItQnu/m/1th3
         8+XO/a8mdmT1XO2gPYgHjMUP+8aR9VHL1kRLfvcr6lEXprQgQU3dDJ93Ts9s4Ueel5
         xIyW6+xmKOaWIBLNeWAhQSywywqMM+VnxLbB4AvbwOu5NiNwh45BhMjLUk9NcxCnJ6
         MRr980wphPQX2bl7iE67KCRSLYcokPTy/fw5OwOBS11QppxaFFln/o+P2Tqbms3eCu
         Sg9HBS+RvHg6g==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bc711a20eso132903766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138983; x=1691743783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        b=ZSO4LttLLns0I33m2TJv82gMSBPhcYyhpTS1eQjfMyu4XBC1OG4K8fwAuUejJtKXUY
         RY5y/sI+YR6j6cKUyrrueQHVJiCDoC9vxzS6UUAPKnyb/k1iwVdP5HknmGI4fOyDw7OF
         1TPAFspR336VNRmKwvMXzvQ6T0kBr2ceG27bxFkO/MGdx1RlnDuFYR5XXY+TWtKNLJ/T
         80vrJNMe+gUuK5NkBSkHK4IfZ69BPrU7Q2HJoD4thzvBe+6y9wpJ5MNJ3+nqOmqJLzzw
         p0OatcfxJeJQKRXpn3fox7+br99VGaT04LinYDurp3PE7NHWEiTw8XzDYoJ91MRw5ytU
         Jf9A==
X-Gm-Message-State: AOJu0Yzod/BptndhMrmlUVKiBuPNeq3apgACSPCvQ2Iam7jZN/7xgAPz
        rSww3Y8kI0NevwphntUmrFNflJYgbirZ6Tt6ExTgUXL65ZPvNDsHeadAiZ6fJxgHD99m7poh23j
        pxbHP5Cv05LtyuWCzSaoKjS7aJKg9N60E9sO7p8bPvBc=
X-Received: by 2002:a17:906:3002:b0:99b:f66a:3189 with SMTP id 2-20020a170906300200b0099bf66a3189mr1057460ejz.8.1691138983095;
        Fri, 04 Aug 2023 01:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYz1ENmxKq5uJlqK2BTiCUQ/3Q6puy0cdofBV5YjhsVwU4EydDgdIUCcgv/xVB11YsU0I69w==
X-Received: by 2002:a17:906:3002:b0:99b:f66a:3189 with SMTP id 2-20020a170906300200b0099bf66a3189mr1057451ejz.8.1691138982931;
        Fri, 04 Aug 2023 01:49:42 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:42 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/12] ceph: pass idmap to __ceph_setattr
Date:   Fri,  4 Aug 2023 10:48:54 +0200
Message-Id: <20230804084858.126104-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
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

