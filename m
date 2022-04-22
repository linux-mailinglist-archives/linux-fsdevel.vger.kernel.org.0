Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE1850B6D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447296AbiDVMIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447344AbiDVMHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16EF56C0D
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y10so15921739ejw.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZfDOJDN+f6HlsMcD0ehVtQsF1UIr7uk2DkRuU+2Oys=;
        b=j5+Fro2vguaSyHNxEJgZSjLEGJ25yi5NfckhWFuRgqjZOpFa8Znx0KXU5qssHF4F2e
         X7olOlH3ufgI6uvs0Li4zI8hBSbXj02BD83sIURrFoY4af0PjYngWrM5hthc/Ep2Uj74
         scrEhSUhiNruVC3pi3LSSvcyMXvMW2jP+IN6UTtZKxBg3a+sGPophlr/2kr1vlyZV3Hw
         5VbE2k4LbpSEnw+enr94rmZLzEX/O2SK3Wi3XPoVoAaTzKQZbdOZWWSPBsHf5yLdyibo
         rJecMjBTFfrRA1EBp3oxckwfaUutRj1V5Q7O2h/piXvsVGjltLwKnFDyTqxD0hJP3jLB
         hyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZfDOJDN+f6HlsMcD0ehVtQsF1UIr7uk2DkRuU+2Oys=;
        b=nDs4Y3f9HuoFCwxg6EPzY/0tzKhM65HqdOMdIVSLtMO+FDZ8kuRZYaodUqQTwbvOCA
         ftkpKUwEre0q0e8s2QffC3FqdLhiQWg/EK070S/FPSr+T7vUEnPD1vtACjfobu1TEYWV
         qTPNHu99MoRaRd3i4YxA1gCvcpKL65Nqub0izIDBV23alajk1TzmsCcprWVabJp3Biqs
         3+6FOdKAyxTWX8ioQPICKX1q8x4XEq8S203t8JgLaBjiP6HVKH68gRtltMJSlK4N77h2
         9oAShiIluCxfleYenaNjWFlUnqDvhQ7ErP/eA26B1bP864laqn4/FoqE/vattqrU/4bK
         kQ3w==
X-Gm-Message-State: AOAM5334KLKPR+bymZdpS/fAqWclrVSRD8peohPXBkD1TfOPRRPGRhOD
        eiPZnem8G0fG4/cKEonGQOpujwqU6Jk=
X-Google-Smtp-Source: ABdhPJxWp/gH8yH0IVu5hTx0XUp74VCCUzVOYz4AGEYHqnwDpR/fYZjaCAtAkBEwCWJXVcP1/MnGrQ==
X-Received: by 2002:a17:907:7ea9:b0:6f0:27a1:afb8 with SMTP id qb41-20020a1709077ea900b006f027a1afb8mr3797802ejc.59.1650629032233;
        Fri, 22 Apr 2022 05:03:52 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:51 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 12/16] fanotify: create helper fanotify_mark_user_flags()
Date:   Fri, 22 Apr 2022 15:03:23 +0300
Message-Id: <20220422120327.3459282-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To translate from fsnotify mark flags to user visible flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.h | 10 ++++++++++
 fs/notify/fdinfo.c            |  6 ++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index a3d5b751cac5..87142bc0131a 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -490,3 +490,13 @@ static inline unsigned int fanotify_event_hash_bucket(
 {
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
+
+static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
+{
+	unsigned int mflags = 0;
+
+	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
+		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
+
+	return mflags;
+}
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1f34c5c29fdb..59fb40abe33d 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -14,6 +14,7 @@
 #include <linux/exportfs.h>
 
 #include "inotify/inotify.h"
+#include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
 
@@ -103,12 +104,9 @@ void inotify_show_fdinfo(struct seq_file *m, struct file *f)
 
 static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 {
-	unsigned int mflags = 0;
+	unsigned int mflags = fanotify_mark_user_flags(mark);
 	struct inode *inode;
 
-	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
-		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
-
 	if (mark->connector->type == FSNOTIFY_OBJ_TYPE_INODE) {
 		inode = igrab(fsnotify_conn_inode(mark->connector));
 		if (!inode)
-- 
2.35.1

