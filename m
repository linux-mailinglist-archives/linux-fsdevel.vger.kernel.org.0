Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7875C76EB76
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjHCOAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjHCOAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:00:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106652109
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:16 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C231742420
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071214;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kJ7jaag9qoW/v/GDVLSWB2NvvzbRwSLLIsn9wjPbzrXIqsJS5Ta/yDMbgq8VKlstQ
         9AVfRVwks7t05MaL2sbCY60BRs5yQ7mArPVKuDz7BYwROEUv0RlxwxyW6vu0bO84vT
         I85mTa4pIoy3D/kidbBiVGNdpWPatZuYgLXLMS24SOZb3xfIsJ5tOWigJNi22s/axM
         r9+rxf30Ir3D7xEdghGMPf+E1FHItcD0JbozAR5RouN/xMUYIm/Cmf6Ym1NZHSVmmu
         GKmUYmElAZIrkSfk1gkd9KitGiIfv8OAYcctbqlFy2frxzrOLrNtGrU7Dq0bcdOrvW
         jxBRQFkQ+bFsw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-521da4c99d4so698858a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071212; x=1691676012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNwWvhavDkNrI4eqwez7OWrv+w+Iw1WNhnwQW/Fw7E=;
        b=lYDHcp0BrePMDRiREY/VAEV7wnWMRzeLWOs7b2eGYZWTmD5/3WQBFEed4K2IashH5M
         4UODuiWryP3fNAr6ABiWLl0wR2nGQFf6CyBSPhpqpfFyHp4yQxcoRAYzrd1IeTDLvqPU
         nGJMMpKwFJy2KgwUV0IxWClSXPyuIMbjOfz3Pgaotttx/Qr36w8SxCd13JAhr7A3uDg0
         yTMSvXGqhqiKwLTntfSAODopgEgeTHMxjvWvAwvn2q9+PBtLN62OeekOKcjOOz7uqQEl
         fn+oRBOA5us5XRZkn9bmfMs/LmrWv409E8/65SopBt6XFnl089tZ3yqJjHY1mnzpuioD
         DoNQ==
X-Gm-Message-State: ABy/qLZhbTWaW3LocOXqUnnmSXSnFiGd8axQ1gI+4CDbcqJLqeLwb/yr
        4UvfH0LfnKRe/goxN3aszjd32+9YVnKCjeqv/Lq9MUKlQzTWJwtwjtzY0BygcpiKO0naiShMPUm
        9BuHtRj2NhvQQn34uvb0rXZaxud8mWftbmN8hKvgw5klIQnHt/AU=
X-Received: by 2002:aa7:c49a:0:b0:522:3855:7ec5 with SMTP id m26-20020aa7c49a000000b0052238557ec5mr8584103edq.10.1691071212141;
        Thu, 03 Aug 2023 07:00:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfIOUItlo0hjwrY4HJh2AtdBwv8To0WNWjW3o7KEaguO5IXHRwEyXe3XNgge+1GeScqXxVOA==
X-Received: by 2002:aa7:c49a:0:b0:522:3855:7ec5 with SMTP id m26-20020aa7c49a000000b0052238557ec5mr8584083edq.10.1691071211914;
        Thu, 03 Aug 2023 07:00:11 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:11 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/12] fs: export mnt_idmap_get/mnt_idmap_put
Date:   Thu,  3 Aug 2023 15:59:44 +0200
Message-Id: <20230803135955.230449-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

