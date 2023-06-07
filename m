Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295F72641B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbjFGPVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjFGPVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520FB1BE5
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:16 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E29A3F15F
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151273;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pJT5VSzQ4Jc8ISxu9rRfZUr2TH9gC3qGbNGviNkm3IYTUg3WY4rifXg0xDnHGyp91
         /d8zeFr9rb5P0tnIKOThMvlus0dIeLzQm46Pwl4a/Uc9BmDqorw00U9Sto29CPLs9E
         kwht5ZOTocrpQXeh5/Mt91sJoV4ysaBu4c4OTMoiSTZxxcpmSHujmBALbEeib+KJK9
         cDJRrBsTCiQIQlVg2n1qbFtWhlJwLE1T362Z4v82hryTUCpSr7UHnKXb/woBikd7ii
         gsot7ALTVlR25/6QBmkJoA3wLMsVWwv+CuyfIA3ovtLTEssbl5nRHBsJkhx0ZoaB7a
         JGI0EShK+fmCw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-514b3b99882so910853a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151272; x=1688743272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=D2+T/Ky5f2Et4pN86JlDU3FSLY56uJXIpgmzO2dPAlktfLRUqplH/vpKvBcz2YNJOa
         0tQjPler07rPfq7irL9BimgS+r46cD7NYwQ0Ur06u4f77n+axW6yXafAl8Koz/TPLpRD
         Bm8KI4pEKHgQyT8w1K4MCEPq35sXbKMBBvnw0enKoq+SRlFbCciY/pMzkRtwGM9DNB9Z
         SZRnZAjf2DAhdcIWiXvb8sKVHqa62d+bH9HiiyEaTj6ZfycnjmfxnY8/xs2R6XuqB16P
         vb/6DhpxOvdVkfGNLiwitTWsIrt7J1hjRIXtzfi1bKFCz96wloRHeeGpIOOK4pT3L6IJ
         ZqAA==
X-Gm-Message-State: AC+VfDwB5MmDP3AnThtCc6L9xZMCE1Aaac1EspxCLRoYhagq7wCZZ0A4
        9K4Ui9A4++I3qk34YsyT7Borvr3VJRZc+bWL8uLHCWrs+QMA1kKHda9cerKKbCE83994PnMgRkY
        1gNID2ryrWjRqR5xmiIYTKyL4g0WM0NShPOROPNzxBms=
X-Received: by 2002:aa7:cd7c:0:b0:516:6779:263e with SMTP id ca28-20020aa7cd7c000000b005166779263emr4537591edb.22.1686151272830;
        Wed, 07 Jun 2023 08:21:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dpYMt3JYto9yLks+ZG+I130K/g+WZgRN6Y3XMwqISsXKgnAW6IDB6O05RQhUDAHLrifqk2Q==
X-Received: by 2002:aa7:cd7c:0:b0:516:6779:263e with SMTP id ca28-20020aa7cd7c000000b005166779263emr4537575edb.22.1686151272576;
        Wed, 07 Jun 2023 08:21:12 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/14] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Wed,  7 Jun 2023 17:20:25 +0200
Message-Id: <20230607152038.469739-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

These helpers are required to support idmapped mounts in the Cephfs.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL as Christoph Hellwig suggested
---
 fs/mnt_idmapping.c            | 2 ++
 include/linux/mnt_idmapping.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 4905665c47d0..57d1dedf3f8f 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -256,6 +256,7 @@ struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 
 	return idmap;
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_get);
 
 /**
  * mnt_idmap_put - put a reference to an idmapping
@@ -271,3 +272,4 @@ void mnt_idmap_put(struct mnt_idmap *idmap)
 		kfree(idmap);
 	}
 }
+EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 057c89867aa2..b8da2db4ecd2 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -115,6 +115,9 @@ static inline bool vfsgid_eq_kgid(vfsgid_t vfsgid, kgid_t kgid)
 
 int vfsgid_in_group_p(vfsgid_t vfsgid);
 
+struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
+void mnt_idmap_put(struct mnt_idmap *idmap);
+
 vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 		     struct user_namespace *fs_userns, kuid_t kuid);
 
-- 
2.34.1

