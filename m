Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDBA529EE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 12:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbiEQKLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbiEQKJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 06:09:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301AD47388;
        Tue, 17 May 2022 03:08:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so16903917plg.5;
        Tue, 17 May 2022 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :organization;
        bh=UmRh5WeDJb4FxIPG+OEtpyHlfmIGfbV1ERHbKbuEXYE=;
        b=GWgmAxIVkNS1hGtn9UXI/hhbF+NlDnsuo1E29/vgNHDT9rX780CQX384vlcp8cBNSW
         D0pm5QJwf/IZBxQ96by1TRF87mu8+gqRrI/78FWqJUI9Yd9hK6LogzLmOu1Cw6LNG3yp
         T7Dm7NswUYZb9cOI5A7frGvpf/WJss6DFjc7aBzeYKLX+eqZ+GhaKEvg5Nb9sDhW11go
         CBQfnbCUlOswlkMhAiwlf+eKMpdY/l0JUkRwIyF7lSbgfsDBTjfzP+ekrsW3OBeDdU3c
         +Ckt5AF6GSeHUCDwzUfThV7ChJNA/Cmwg9hTQylZm/oyY3f3GFstT1UJg3zadTBz0sKD
         wpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:organization;
        bh=UmRh5WeDJb4FxIPG+OEtpyHlfmIGfbV1ERHbKbuEXYE=;
        b=41P5rCnLXm/us3LKrTt3gxiRvJSrozzo8M/NAhChpoqBCqEnDSoXYDiCsYKgd5+Yp1
         5lP/5dCvasAPaGWuZLomI3L8ojELGK5iH8gi6I76oFuxmBoDoTEGMjhVovrVmtU78p6C
         MLqrkg4wFfXnC6Kf5nwvRWTfi+frxjk0ZPKS4T+AFUPMbYjoDCIBGNBO4PmsyMT05R1e
         N9laQInNAt/sTCr1tjJg1hn9EHIJMD+UwdHA0aAuGAfwj35EADvpyovIvOp47iDQEZjY
         8ZqIryy5BhaGRtgEQPfGCeOR2VAZXH+E0bDCed0bzo+GSDIy9NJ7SOaIbOlvWycADQfo
         ntCw==
X-Gm-Message-State: AOAM533jgd+ZlcxuTQXLzjL5IMQsxTeWjixYrRhsqEsuw1852DUMriYW
        wjx8L0eNyqQzhalymtrPQHs=
X-Google-Smtp-Source: ABdhPJznjwSaPYLoRL29ez7lvADpiJ2YQUbUx8jjWJHSiWCTYjYJvVYOysHYKrK0biU4ndLkTZ2IxQ==
X-Received: by 2002:a17:902:8501:b0:15c:ea4b:1398 with SMTP id bj1-20020a170902850100b0015cea4b1398mr21712865plb.109.1652782091353;
        Tue, 17 May 2022 03:08:11 -0700 (PDT)
Received: from localhost.localdomain ([219.91.171.244])
        by smtp.googlemail.com with ESMTPSA id a10-20020a631a0a000000b003c6ab6ba06csm8202595pga.79.2022.05.17.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:08:11 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com,
        Dharmendra Singh <dsingh@ddn.com>
Subject: [PATCH v5 2/3] FUSE: Rename fuse_create_open() to fuse_atomic_common()
Date:   Tue, 17 May 2022 15:37:43 +0530
Message-Id: <20220517100744.26849-3-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517100744.26849-1-dharamhans87@gmail.com>
References: <20220517100744.26849-1-dharamhans87@gmail.com>
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch just changes function name as it is used in next patch
to make code better readable.

Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
---
 fs/fuse/dir.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ed9da8d6b57b..517c9add014d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -521,9 +521,9 @@ static int get_security_context(struct dentry *entry, umode_t mode,
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, uint32_t opcode)
+static int fuse_atomic_common(struct inode *dir, struct dentry *entry,
+			      struct file *file, unsigned int flags,
+			      umode_t mode, uint32_t opcode)
 {
 	int err;
 	struct inode *inode;
@@ -674,8 +674,8 @@ static int fuse_create_ext(struct inode *dir, struct dentry *entry,
 	if (fc->no_create_ext)
 		return -ENOSYS;
 
-	err = fuse_create_open(dir, entry, file, flags, mode,
-			       FUSE_CREATE_EXT);
+	err = fuse_atomic_common(dir, entry, file, flags, mode,
+				 FUSE_CREATE_EXT);
 	/* If ext create is not implemented then indicate in fc so that next
 	 * request falls back to normal create instead of going into libufse and
 	 * returning with -ENOSYS.
@@ -723,8 +723,8 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 		if (err == -ENOSYS)
 			goto lookup;
 	} else
-		err = fuse_create_open(dir, entry, file, flags, mode,
-				       FUSE_CREATE);
+		err = fuse_atomic_common(dir, entry, file, flags, mode,
+					 FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
-- 
2.17.1

