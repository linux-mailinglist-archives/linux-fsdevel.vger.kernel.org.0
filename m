Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0263F4AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 17:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiLAQBQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 11:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiLAQBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:01:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298EB3906;
        Thu,  1 Dec 2022 08:01:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id e27so5221010ejc.12;
        Thu, 01 Dec 2022 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAmHcTLy3hmcDrRNavtQUgMw98PbaTbM7w6twBSfXic=;
        b=hLHpNSYoXsKEdrsQBISE3ZxIWI54lE426PYVbSMG9yJGu4k/f6zxghgHlIlwpLNR6j
         h5/eXvhsPNapewmZXrSiMVqyHUZoJ1hjoWMcH6LIMGbXjgDJYgNR42VChw9gx+SVRoL9
         fyY8T7truV0UChNuh+3c+NEQBalDJbkygjtkYITSsKuxwEGisWtD0aNwQQIPQzk5LRsN
         1wtoU7fwUuTp9ytOtDlQpFHVnG2CBQ7/AYEKXQhgdROWAUiS6dhRTk65Qnu3vtPKlv2v
         bVEIe20aUSLj6/LEDdLyUM/Mb07P5L9sXFLc31FoD7gZwtgE98Z7yIbz/ePmXnw8v6mm
         2TXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAmHcTLy3hmcDrRNavtQUgMw98PbaTbM7w6twBSfXic=;
        b=OHkuUBxNTv56ZwUYRadKEm+UMpXQ5r+bGQSRoWTAupQdPxbsRs0LOGUMxUsw8iRoRz
         IbWbYZRCigGXRNxgx4oOHhbddHOXcjKAwi8KGkx3/VpQvzCE7q1OBUWrxEDKGPiBKwQD
         JilKvR9DE09Y9WoCYTEvRZN4a7bz4bgTkxJ6qSQvWd5eavR47cqV703a1bFE0cYwAItL
         43MRb+inY4YsHCSkdn2PAA0R5T4C36xNMZRKQkpP1NpiKvYmqdAUewGj20Qe56CK7bJ9
         Jt3z2Z4rrpzBzjRPjQRGP2sMavc4X6WYN70VGKGpDFFS/0T/iYHyXq85S9sICp76gdrp
         FRJg==
X-Gm-Message-State: ANoB5plz2YeDveu/T3xHnd54jVz7cqY9UPg0UQn05GJ0O6V4sP7cC7v+
        M2i0Lpv8Yu5UChaoIlRr55Sab7frJ651qw==
X-Google-Smtp-Source: AA0mqf7nGMGyjhCn5xB8KGJM8fwKqlnPWcu0lVgxd0pHQvV+O5L4ZEhXY0Xv3837SMybXs23a3uD6w==
X-Received: by 2002:a17:906:9f13:b0:7bf:661b:6b0e with SMTP id fy19-20020a1709069f1300b007bf661b6b0emr18786284ejc.191.1669910472221;
        Thu, 01 Dec 2022 08:01:12 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709063b5a00b0078db5bddd9csm1385453ejf.22.2022.12.01.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:01:11 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] posix_acl: Fix the type of sentinel in get_acl
Date:   Thu,  1 Dec 2022 17:01:03 +0100
Message-Id: <20221201160103.76012-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.38.1
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

The type should be struct posix_acl * instead of void *.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 74dc0f571dc9..3dadc37638a8 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -108,7 +108,7 @@ EXPORT_SYMBOL(forget_all_cached_acls);
 
 struct posix_acl *get_acl(struct inode *inode, int type)
 {
-	void *sentinel;
+	struct posix_acl *sentinel;
 	struct posix_acl **p;
 	struct posix_acl *acl;
 
-- 
2.38.1

