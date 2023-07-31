Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FC76A0A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjGaSrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 14:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjGaSrt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:47:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2515A9E
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 11:47:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b643df5dso3381425b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690829267; x=1691434067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JN96jnVa8IBWwtTClB8xPfkb6N6bM5c/T3ET8uC8oJ8=;
        b=CcpnP8uIrewmUPxFzGigZZ3wM009a2S2lsstGRByU7TVDE4ACXyD8Q2cIWpB9vMe4V
         lwLjoXxULsemtIkLeCagPlwSVYxBlMwYXDOV1GvqLzv1sfzKeZbtwiVdUIVdvw5LnMVk
         cjbDwGJtbi39YEqp6zlMG9hewljSHKqfi6oQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829267; x=1691434067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JN96jnVa8IBWwtTClB8xPfkb6N6bM5c/T3ET8uC8oJ8=;
        b=PQVTGDVFIZgMy+CcxvlpoKp3FTwHFE2e9Pyv/5lX0p9oI+NkUTBw59vE8VBU6A6/Of
         LwtqTSnVThPF3GUzylmoKaMGUYkUG3MfETJrCi3G0d6b1ERxBOeqfI2o7tIbyUVPdRu8
         bff0Dv7tRg3OXyUvMZwjKeqZx655DQR38ruky77rUBPJqM5Q8qp6VsmcjVmQtgyh8qVy
         QJMlp9/KxvipBqpG58n9lEXkVVKe8DgWSONnFySwmUaIri/ZP7aAObMKlEIhdAG1CUYN
         5OSJFo4LCFFToBnsoRI+XfUmuVdZBWNCuNp5QiK5hPNnZfhosK/gNfBTjo82iUcMK/+K
         khjA==
X-Gm-Message-State: ABy/qLbJr7Di2/RH2+xLiOjv2QWOQLVTnjWaCy+gM7eexJu3gQBHUBMm
        kLUqvKD1zSmgs3/lQ4nInHs7y0/0KDY61Kq5KRw=
X-Google-Smtp-Source: APBJJlFFmAw8wiJvudwPvziHRcbnHNI3lcjMWLFmj8ZikGiQEC40ijLtuYe0d8UqxM6xtOdS1jKsUA==
X-Received: by 2002:a05:6a21:3806:b0:13d:315f:26b7 with SMTP id yi6-20020a056a21380600b0013d315f26b7mr5548436pzb.1.1690829267232;
        Mon, 31 Jul 2023 11:47:47 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:74c2:128c:7249:4816])
        by smtp.gmail.com with ESMTPSA id e21-20020a62aa15000000b006826df9e286sm8099232pff.143.2023.07.31.11.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 11:47:46 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Ivan Babrou <ivan@cloudflare.com>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2] kernfs: attach uuid for every kernfs and report it in fsid
Date:   Mon, 31 Jul 2023 11:47:31 -0700
Message-ID: <20230731184731.64568-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following two commits added the same thing for tmpfs:

* commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
* commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file handles on tmpfs")

Having fsid allows using fanotify, which is especially handy for cgroups,
where one might be interested in knowing when they are created or removed.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Acked-by: Jan Kara <jack@suse.cz>

---
v2: Added a missing static and an ack from Jan Kara
---
 fs/kernfs/mount.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d49606accb07..930026842359 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -16,6 +16,8 @@
 #include <linux/namei.h>
 #include <linux/seq_file.h>
 #include <linux/exportfs.h>
+#include <linux/uuid.h>
+#include <linux/statfs.h>
 
 #include "kernfs-internal.h"
 
@@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 	return 0;
 }
 
+int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	simple_statfs(dentry, buf);
+	buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
+	return 0;
+}
+
 const struct super_operations kernfs_sops = {
-	.statfs		= simple_statfs,
+	.statfs		= kernfs_statfs,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= kernfs_evict_inode,
 
@@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
+		uuid_gen(&sb->s_uuid);
+
 		down_write(&root->kernfs_supers_rwsem);
 		list_add(&info->node, &info->root->supers);
 		up_write(&root->kernfs_supers_rwsem);
-- 
2.41.0

