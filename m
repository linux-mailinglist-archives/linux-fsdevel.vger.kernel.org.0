Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8722455D38D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbiF1IT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiF1ITD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:03 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45F2DAA8;
        Tue, 28 Jun 2022 01:17:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so11620966pju.1;
        Tue, 28 Jun 2022 01:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhvXMK8bFw6njNlQyliLjVolxFmrQvweDYEjgua0NV8=;
        b=bkcBTv8p4RsYt48WZxvsE/a/MiJmHGufkP3vhXuXj8VBihMxjuYzO5rkby9KeGzYt9
         qLug/u/yvmZRqarN/DvBMqWAAIS9C2JJGUXwJDFwUDtXcdGnHYJEm0wFo1g8yPBrM1u8
         g/YFOw5rgpDwAxOwroSVhx83U4BXiizfQ7n7I11Q/aEoEH7oSVJFsBbzbW6jflsKMp6w
         LHBIsaWTE8RqVUpjeJ3CW6QrqmjT2VYEK0ZDvBupmDwjUrbU//VNYqiYiDDTpf6Drml1
         qoh71ZSfuO5Sf8TIdUzp8O8/T7aUe1DZOA/i56kSU3AD/vWhyRGhTrv7Yiku+Xg1CgAP
         mm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NhvXMK8bFw6njNlQyliLjVolxFmrQvweDYEjgua0NV8=;
        b=rcyGnATCt26aiyrqVWIBz76T0I3a7ToZ3Brfz6DAu5ZN8w0NbKkKApve0kfZRM1tou
         Fx3P0qIyMI07qIW/IezroyYsHD4H35NlfE4rxy4q3Az0hIL5tzE0TpOYfs2S7mbriYJJ
         Fd4IzFNqhjmOd7kNGywCHVz5TpH3Rab1rWG8sJ6LvDR7Kga4NAC6YycAeudl7HcpDNDf
         q0q1qW5m1SC7deA1Q6ARMF8l3U9VT14TR6q+gprjHS3cqBPmkY8JQfzeMdGegxm2In+H
         31V1uk3NxRDMTndNJIcO/ZIyHasNrxRLHq1bdZ/pFIdZr+JmmVjfjt+glLQn9uOr6MrP
         B8xA==
X-Gm-Message-State: AJIora82XOQieSAIIh4yVT0WlVfn1D0r+vmtij8K7Slu9nK7i+P8e9Zw
        ROyHLvsZG7q9jyhMV2OmiKA=
X-Google-Smtp-Source: AGRyM1sgluu4OgUva5oJgOl67WyN5tOvnNzOIRJ2llMgHgHZDuxJBd4ZUr9XiqURhNHTsyxo8Ik/sA==
X-Received: by 2002:a17:903:32c4:b0:16a:4227:cd68 with SMTP id i4-20020a17090332c400b0016a4227cd68mr3722753plr.173.1656404260702;
        Tue, 28 Jun 2022 01:17:40 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id b16-20020a17090a101000b001eeeb40092fsm2931223pja.21.2022.06.28.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:17:40 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jack@suse.cz, amir73il@gmail.com, repnop@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        duguowei <duguowei@xiaomi.com>
Subject: [PATCH 5/5] fanotify: add inline modifier
Date:   Tue, 28 Jun 2022 16:17:31 +0800
Message-Id: <20220628081731.22411-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: duguowei <duguowei@xiaomi.com>

No functional change.
This patch only makes a little change for compiling.

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/notify/fanotify/fanotify.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4f897e109547..a32752350e0e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -18,12 +18,12 @@
 
 #include "fanotify.h"
 
-static bool fanotify_path_equal(struct path *p1, struct path *p2)
+static inline bool fanotify_path_equal(struct path *p1, struct path *p2)
 {
 	return p1->mnt == p2->mnt && p1->dentry == p2->dentry;
 }
 
-static unsigned int fanotify_hash_path(const struct path *path)
+static inline unsigned int fanotify_hash_path(const struct path *path)
 {
 	return hash_ptr(path->dentry, FANOTIFY_EVENT_HASH_BITS) ^
 		hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
@@ -35,20 +35,18 @@ static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
 	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
 }
 
-static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
+static inline unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
 {
 	return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
 		hash_32(fsid->val[1], FANOTIFY_EVENT_HASH_BITS);
 }
 
-static bool fanotify_fh_equal(struct fanotify_fh *fh1,
+static inline bool fanotify_fh_equal(struct fanotify_fh *fh1,
 			      struct fanotify_fh *fh2)
 {
-	if (fh1->type != fh2->type || fh1->len != fh2->len)
-		return false;
-
-	return !fh1->len ||
-		!memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len);
+	return fh1->type == fh2->type && fh1->len == fh2->len &&
+		(!fh1->len ||
+		 !memcmp(fanotify_fh_buf(fh1), fanotify_fh_buf(fh2), fh1->len));
 }
 
 static unsigned int fanotify_hash_fh(struct fanotify_fh *fh)
-- 
2.36.1

