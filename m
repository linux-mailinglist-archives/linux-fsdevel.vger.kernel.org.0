Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEEA791836
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbjIDNdk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343587AbjIDNdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:33:37 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB918CE5;
        Mon,  4 Sep 2023 06:33:31 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-401b5516104so14317015e9.2;
        Mon, 04 Sep 2023 06:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693834410; x=1694439210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5+wmWmgq56dJme4hT4eR6efR4KKOLOFEcKhP5GIfQA=;
        b=bGlALo2aLpGzkCw6rQr+L/D3hOAFJFIrRHPndPp+fIMwjDu6UWhu+UsAXLsBH/zaht
         B8GCuAKF5G+3aWwZtoPVsgKssdG2LHiZim/cJofhKe1C1YFKct4MsGfa4l4J4wXAmhoq
         Cp7GI49zj7jhxCBjbUZY3boAOB+DyDNMMMLkUddGMtloqt41ZLh39nW1OxnI0nNpSXGS
         WADGVb8+vIx2zuID/r9KAsrgUhbQFCBgf9gScj9gIImOUc/den7NUSNt9FdR4Dw2Npa7
         LDEKpTep8Yn0Z11GOtM9CFpTxqfZWdsxrMfxPIbVyzNTmAziIAZTqw+UQzE2RyH1zkJn
         M/KA==
X-Gm-Message-State: AOJu0YwFWxtuSl5teWoY2/Me3Acz9CouW9oBm0r023T9YUk4SaixX0K4
        oe8lkNCdRPtZlwKIaXMhyvwUnxEZaIefOw==
X-Google-Smtp-Source: AGHT+IFxbB18mEtudWSY8KF+q0LrNp0V4UKPHFpHBoHRs0sEGdrZ23pWrQxQRXPPTt7rRTaq0B8qrQ==
X-Received: by 2002:a05:600c:2194:b0:401:b204:3b85 with SMTP id e20-20020a05600c219400b00401b2043b85mr7579256wme.36.1693834410047;
        Mon, 04 Sep 2023 06:33:30 -0700 (PDT)
Received: from salami.fritz.box ([80.111.96.134])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003fe4548188bsm17278519wmj.48.2023.09.04.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 06:33:29 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Subject: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
Date:   Mon,  4 Sep 2023 14:33:21 +0100
Message-Id: <20230904133321.104584-1-git@andred.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: André Draszik <andre.draszik@linaro.org>

This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.

This patch breaks all existing userspace by requiring updates as
mentioned in the commit message, which is not allowed.

Revert to restore compatibility with existing userspace
implementations.

Cc: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
resend because of missing people in Cc
---
 fs/fuse/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 549358ffea8b..0b966b0e0962 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1132,10 +1132,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags;
-
-			if (flags & FUSE_INIT_EXT)
-				flags |= (u64) arg->flags2 << 32;
+			u64 flags = arg->flags | (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-- 
2.40.1

