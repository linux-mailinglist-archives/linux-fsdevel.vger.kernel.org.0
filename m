Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38DF4CE5C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiCEQFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbiCEQFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B15387B2;
        Sat,  5 Mar 2022 08:04:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so16925211wrr.2;
        Sat, 05 Mar 2022 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIBRvQXE//zDJAEj1LXYr/IDU3RJ1FAKagi05ekc5gM=;
        b=pbaIQ3wjh/0/IjgSW9c19x3yY3kB0IKi0Nf8621R+s39g4IApSGoOO1A0+ytlYyt5X
         /l40N4++dQHWD5UjTqDKAK/cjjs0CCrO8EfFyyXprrA2ioXh0OzaGr7Uazj6Tw4LgIg3
         oHQJgUfclCZUOb5Rf8QMgwEBmxd4HuFpLDz7HNuFpDEsadXiUZmHHU+YND2xi2XjoGFc
         lLqZITYSvsLLdxA6RCMtrlMtqWsQggqF6Z2ED9uOIeOqVXLyEvlTZqduEmRbYbXOlVay
         obRsJJuwjjUGq/lcHluiFLok4WiTyG2CTs0OjUAeD09zH/YsSV6BhRMNPUc57XVZ6d7G
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIBRvQXE//zDJAEj1LXYr/IDU3RJ1FAKagi05ekc5gM=;
        b=IGO3G2v6AHeXuW/jfVP7F/vPBtVJrE1y7zihyCHz11h0GtaJQ9phAney6YktCobYAg
         4ciNQB0l7yTeSLs4onc77/c+P16bKY5EcqdvbLfcb+QupsG/+Qqkj2vcZ77v2COuSztR
         au0akdzxC+fDt+SXvEkzfOJ5AWjyME6zcGstI6kt5oQc5VyrvamZA5spt65KmMAL0+4z
         DVMkF6pntkNK2dOUqSyOBTPrrIc/eVnm2FDtWa21z+MKlux3XSo21Qww/kUh3HdbUTfd
         DSkNsA5btbLAaLG3YUwbsF4pdWlO0J+GIN4MeMwCzu99F+SOpZWmNi4vPdpBNWHoEcF7
         KGZQ==
X-Gm-Message-State: AOAM530IZZ6zsFVa4ObXaaYo9Z0CIu1VN8j3EJ3XRpYgwyPnbH0VMJ41
        vZFJ9yEvSgOrIJuphkiZip8=
X-Google-Smtp-Source: ABdhPJyOZdAamn/dg/bv38lfSaqZVf9bJvhdpYULSmZZpNdQrknkIGIM24iYvkk4dOZISiLKWQNy2A==
X-Received: by 2002:adf:eccc:0:b0:1f0:1a33:a7af with SMTP id s12-20020adfeccc000000b001f01a33a7afmr2944141wro.113.1646496285317;
        Sat, 05 Mar 2022 08:04:45 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:44 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 3/9] fs: tidy up fs_flags definitions
Date:   Sat,  5 Mar 2022 18:04:18 +0200
Message-Id: <20220305160424.1040102-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305160424.1040102-1-amir73il@gmail.com>
References: <20220305160424.1040102-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bit shift for flag constants and abbreviate comments.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fs.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 831b20430d6e..ecb64997c390 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2429,13 +2429,13 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
-#define FS_BINARY_MOUNTDATA	2
-#define FS_HAS_SUBTYPE		4
-#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
-#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
-#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+#define FS_REQUIRES_DEV		(1<<0)
+#define FS_BINARY_MOUNTDATA	(1<<1)
+#define FS_HAS_SUBTYPE		(1<<2)
+#define FS_USERNS_MOUNT		(1<<3)	/* Can be mounted by userns root */
+#define FS_DISALLOW_NOTIFY_PERM	(1<<4)	/* Disable fanotify permission events */
+#define FS_ALLOW_IDMAP		(1<<5)	/* FS can handle vfs idmappings */
+#define FS_RENAME_DOES_D_MOVE	(1<<15)	/* FS will handle d_move() internally */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
-- 
2.25.1

