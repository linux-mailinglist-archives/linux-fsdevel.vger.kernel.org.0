Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676774B29CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351304AbiBKQKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 11:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350882AbiBKQKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DBCADBC
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Feb 2022 08:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644595795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yo4Sk1DNzPgxEb2veYDAeixTMuiv+VmABtkS2yiJEuI=;
        b=BppnZXVf+wUsK5xgYCf0vw6jmeULK5MtFlL0KYdUZzmyt5/9pb2gg2MAEsNoT0DK1SV9wc
        5XgaxI4hw0PVdURln92p4k4vWQHQuFWzkD6B6rVUNpgU7Vxf+Jjwn4ESouQtwwUV4jZ+YW
        wfY2/I8QBoNzwGmeTIlVcmuiEzK79uo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-N99tH8L4OeyNlv5197ZUwg-1; Fri, 11 Feb 2022 11:09:52 -0500
X-MC-Unique: N99tH8L4OeyNlv5197ZUwg-1
Received: by mail-ot1-f71.google.com with SMTP id f13-20020a0568301c2d00b005a61ef44410so5595625ote.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Feb 2022 08:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yo4Sk1DNzPgxEb2veYDAeixTMuiv+VmABtkS2yiJEuI=;
        b=wGTFeMTAQhKJfYySjDI1Qo8Qv+cGRvxNl3Ngbanr9fAI07CVs2YB4z1lzgSCqh/kfk
         ptUzUSI+HlZDmjbl8q8zIn8uckAzDgpM7WcDQCJYxz7Hi37UN7fjGrLHVBdZSHdiyjPV
         wWzp1SHbozozH7pxm1Rt0SqztlE54jf8Wfjla6Cw5rlt6HphWoECc1UFbpltyFcwb8D1
         07+RyZlUOj5rS3CPNmSap+suqhM2YeL9VN3BZQELlbabfFNzYmoql65r3PIx1sk8SFf0
         SgL6ab87NXYrd6Us2B1yEie72IgutxZzM+XLnQxtj5wwPY124nsqawwQI4gSdi0Pqo3Z
         EzNw==
X-Gm-Message-State: AOAM530tr0acC0dBideVeqIaWBJVGzsmWlqYsrffR/JDsdZ7/4XOHCzx
        gU3ViE0RAZ8XA/rOnE7vkgHetS+bQ5kHIh+eqY8ConjV5/dhvnHzBA/xETDVChMgsz5SGnaGJhg
        tVUfZCobHc9q35ZW73/d8zXf0aA==
X-Received: by 2002:a05:6870:12d0:: with SMTP id 16mr369566oam.317.1644595791754;
        Fri, 11 Feb 2022 08:09:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpB1h3el2cw+8MNyOUZeHsQWg8geBveybUftGpXm91hOunXzNp9BtY4zlGnmoPSTmuLr2jUQ==
X-Received: by 2002:a05:6870:12d0:: with SMTP id 16mr369549oam.317.1644595791477;
        Fri, 11 Feb 2022 08:09:51 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bf15sm10173664oib.32.2022.02.11.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:09:51 -0800 (PST)
From:   trix@redhat.com
To:     ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] exec: cleanup comments
Date:   Fri, 11 Feb 2022 08:09:40 -0800
Message-Id: <20220211160940.2516243-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'from'.
Replace 'backwords' with 'backwards'.
Replace 'visibile' with 'visible'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 40b1008fb0f7..8256e8bb9ad3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -118,7 +118,7 @@ bool path_noexec(const struct path *path)
  * Note that a shared library must be both readable and executable due to
  * security reasons.
  *
- * Also note that we take the address to load from from the file itself.
+ * Also note that we take the address to load from the file itself.
  */
 SYSCALL_DEFINE1(uselib, const char __user *, library)
 {
@@ -542,7 +542,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 		if (!valid_arg_len(bprm, len))
 			goto out;
 
-		/* We're going to work our way backwords. */
+		/* We're going to work our way backwards. */
 		pos = bprm->p;
 		str += len;
 		bprm->p -= len;
@@ -1275,7 +1275,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
-	 * not visibile until then. This also enables the update
+	 * not visible until then. This also enables the update
 	 * to be lockless.
 	 */
 	retval = set_mm_exe_file(bprm->mm, bprm->file);
-- 
2.26.3

