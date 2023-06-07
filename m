Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32228726815
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjFGSLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjFGSLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:02 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968B2107
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:50 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D02B3F160
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161448;
        bh=U0wDd5vU5m4d9k8unybyLOfQsgHlr2098zatHuE7IuM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ldL169xNMQ6eUQugy7Hh/gSYwpxyZaEYgmX3W+adg73fYV2m3fOMVZVaIdS5EdF7Y
         Fo63hseefReNeLCKUyKTxeuXPxUu+eb8mppxjz832753rR5DzEAU3YOXmXbCU16/wb
         ncgO058JVfcxMikZ931K7sIOGJsPmEJGFdOLOPXSIUvRXqGsaTvZKqP0au7AVdGqLg
         oaivhcrJ/buzI6CaynR01IdW6rKBmwEonxUG8wzGgS474UUzCMzbxKuO1unRpR8BKN
         fTtI8STnpaTFUY75gX+ZxCqnsdvCMfCdFEpp7JVLTQxGP4KWggVCs+C7LTshxqNHFv
         NHG9ipxTbPgtA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977cb78acfcso377576166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161448; x=1688753448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0wDd5vU5m4d9k8unybyLOfQsgHlr2098zatHuE7IuM=;
        b=K5DB9kwDHXWqrHlgXrdq/of+ptIcSeuvpH5ZHcFlNC/IErWXj2lgNggNZYCAh82hPS
         JgnpCIADTtDVxZ1Tbj+kwHKo2etIF7dRvBUWPwiwFNvkft8LkglzsF1fHqxp5dxQCb22
         xi0TEJgzI1ykfqxIHxl5BGluMbXtO0q9K83WTHuqZh6c6Au/VxrEOZJNn5Lg9n2k3euj
         Kypy8PTvNQWYi3SMkv5Z2vVo+Bj1A7wFuUE5KEfKdU4x+HbH/ahDWmqmy/figKBpOAMB
         CQvs/41DxclNG5flnjjGgX1O6jsqltpPx+/lNReaRw4Ozt23ZGv3PRPtXfpb3tBqLiiH
         H9fA==
X-Gm-Message-State: AC+VfDxpkthwhMbJxwK2MWUHb4L6h3v+tPoRja13lHFHe3aWMyPol+Ac
        DPK1fuiECIBQS87yFistrEkrOVt8qOoL+9meBE3eZzCJxxeOccjwTTLFTfyBNuXKks0lMelxocC
        nw4stjFhktJp3XsiKibnEBUl3ALOu5lQ3ZHj5f0JPlNA=
X-Received: by 2002:a17:906:dc8e:b0:965:6d21:48bc with SMTP id cs14-20020a170906dc8e00b009656d2148bcmr6951906ejc.75.1686161448211;
        Wed, 07 Jun 2023 11:10:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ngknujcXmRZ3o/zUU3vPHCFz/0yZ08tou5UTAorufeNDslI9p+T/7P4VcApY0KYKUmADI6A==
X-Received: by 2002:a17:906:dc8e:b0:965:6d21:48bc with SMTP id cs14-20020a170906dc8e00b009656d2148bcmr6951885ejc.75.1686161447977;
        Wed, 07 Jun 2023 11:10:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:47 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/14] ceph: allow idmapped rename inode op
Date:   Wed,  7 Jun 2023 20:09:50 +0200
Message-Id: <20230607180958.645115-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_rename() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 5ef90a49b156..355c5574ad27 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1327,6 +1327,7 @@ static int ceph_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	req->r_old_dentry_unless = CEPH_CAP_FILE_EXCL;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	/* release LINK_RDCACHE on source inode (mds will lock it) */
 	req->r_old_inode_drop = CEPH_CAP_LINK_SHARED | CEPH_CAP_LINK_EXCL;
 	if (d_really_is_positive(new_dentry)) {
-- 
2.34.1

