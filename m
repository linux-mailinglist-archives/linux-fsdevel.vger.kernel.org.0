Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4492959608D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiHPQr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHPQrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:47:55 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F78D80EA5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:47:54 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10edfa2d57dso12294725fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mJasFaND7LjomVxkdYXYonO3wAclwe/rGyXo8QjdL9s=;
        b=Ja7PaCGUPvoBk7eOlAajh5wJNDh7Bd+Z4j/dl2JIQanztB3OhTO5dzosm9aqyvdYA5
         74qZYcE0NlDvtNzXUVPv6fR+a5dNCxx9+v91+EVRAHRmgxVPCpfMsnPij5AqYOfPqzt+
         ey1KYiHZYPsyMvV7W40z8ms4YH2D2X7IPRpiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mJasFaND7LjomVxkdYXYonO3wAclwe/rGyXo8QjdL9s=;
        b=xlNhrX7oBVtiwziioG+in8WcXvDljqKyeAVvN84FmCQh1NCdi9+7N9rkuSg5+V2LvP
         Q7ep4u9UuMFk3Ad8NZBOcgACjUIu3357s6MxXujX1lvjha9C/WKSd3/LSXDGiyNxM3re
         88ZqmIU+M41ZrG/7B4b++ngXZnLvadOm3ITEBXLmbhGfnMF8PXjP2lTgXZyppdfvIgUo
         T5HVW5rM2lz7SacV5ZZyqdVjqJoWclHAmvoWzFlw/Gp3kYsy6G/wJaUdGiAdjw95gtQ8
         DXddqU3N9t8fP05g8pHaDUmaLuykW38zpoVLzzYj8+EaUmGh70bUNYgA2Cf+p7Cjp6vv
         nnUQ==
X-Gm-Message-State: ACgBeo33kew64jywBeJFlaFUPaFNW6Qts6W0YOiU/xrZe5/zK7mkYYCK
        aIiITzuZpfZbPKvFzibmZIRJ+Xv10nXnQQ==
X-Google-Smtp-Source: AA6agR57zeWyxU11JVfmjYopK8Tys5rEt3VnNyi4ZDMP0TiH+ECC5fMGGY9coRg3MDHL2xug2/0Bsw==
X-Received: by 2002:a05:6870:a11e:b0:10e:d665:2a21 with SMTP id m30-20020a056870a11e00b0010ed6652a21mr13710078oae.281.1660668473295;
        Tue, 16 Aug 2022 09:47:53 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:aba6:cb35:e58f:e338])
        by smtp.gmail.com with ESMTPSA id x35-20020a05683040a300b00638ae0350bdsm1182125ott.0.2022.08.16.09.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:47:53 -0700 (PDT)
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: require CAP_SYS_ADMIN in target namespace for idmapped mounts
Date:   Tue, 16 Aug 2022 11:47:52 -0500
Message-Id: <20220816164752.2595240-1-sforshee@digitalocean.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Idmapped mounts should not allow a user to map file ownsership into a
range of ids which is not under the control of that user. However, we
currently don't check whether the mounter is privileged wrt to the
target user namespace.

Currently no FS_USERNS_MOUNT filesystems support idmapped mounts, thus
this is not a problem as only CAP_SYS_ADMIN in init_user_ns is allowed
to set up idmapped mounts. But this could change in the future, so add a
check to refuse to create idmapped mounts when the mounter does not have
CAP_SYS_ADMIN in the target user namespace.

Fixes: bd303368b776 ("fs: support mapped mounts of mapped filesystems")
Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
---
 fs/namespace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 68789f896f08..51416e6caf90 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4003,8 +4003,9 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
 		return -EINVAL;
 
-	/* We're not controlling the superblock. */
-	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
+	/* Mounter doesn't control the source or target namespaces. */
+	if (!ns_capable(fs_userns, CAP_SYS_ADMIN) ||
+	    !ns_capable(kattr->mnt_userns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* Mount has already been visible in the filesystem hierarchy. */
-- 
2.37.1

