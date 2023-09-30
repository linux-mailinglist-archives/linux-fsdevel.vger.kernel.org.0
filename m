Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913BC7B3E55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjI3FER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbjI3FDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362F1CC3;
        Fri, 29 Sep 2023 22:02:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c724577e1fso48053185ad.0;
        Fri, 29 Sep 2023 22:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050144; x=1696654944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWwX1MjDa5FGmsQKrAkRxhx462UR+5GB5fgvAVZzAwA=;
        b=JVnbZxN4OTRqCD7cNE0PHFfiwZHl6nDh76sQjP5LQ8bvAU/TxOr0svsg8D5uZdsfIJ
         lI5Sek6rV44djNuSL6c54gHgb5zQsWHsssN+tqOa8+/MzOdf0d4jO0mlcJL9gB2dwj/L
         hq8yLtd5Y1G7Ww0t9Ni18YTxBEsk8IRMnJwhFHCXkzGAILl4X+bkm70cZGyLX6eKVHcn
         7M9n1/utbQ7eFzWRexkIr3vMH5i1p7XApbYteMmrp3wedkc7RsCL+nI4uPE4mW4Uidvs
         QNa4uiv17c7qnnrqSCDteOSUlkXMZ4yF5r1gkSLC7A1XAOaW7TVkSZqeniKV8re9MR1z
         AHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050144; x=1696654944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWwX1MjDa5FGmsQKrAkRxhx462UR+5GB5fgvAVZzAwA=;
        b=XDVWZGskamCFow1Gfbro9Whu51lwBJRhqMQyW1KBOhGPSAEAhqQaw1nU9/RDWPzaob
         T1NJ/nyzwAcQ83+PUcSHbIMidvDiRSy4qlKQoebAvZoSHhnY3hiHeC+TZ/sTCjnsD4AB
         pi1ok7TMFLZqtFZpsf7vSnyV5Z3A/G7ekbitDZr78ByLDtO5FeP9M1tV0WvfXORirYbs
         1Hr78niIttFzcn9ccRBDlJsSaLZwC9dIlZGQQeS07Yw8q6hBpMR2p6JPRSniJ2HbkdgE
         46VBV3zGiyirCqRm58sJez2LWplSvrwtaXtD+hUbmkem1uKOXnLq40WSncvTflOSpdu4
         1gjQ==
X-Gm-Message-State: AOJu0YxIEuBe6Q/yfpYxSeXv7I57zN4bCxIWyK8t3/FJrq/uuBP4xeZv
        a5ZsZDzjJyUbfeqdwnhwzYJtVdsnrdeLfw==
X-Google-Smtp-Source: AGHT+IFIlc8Vq/8N/tGMkgyuANwozZ0mBguFDiaZEtT70ECOLGoDQI71l/D4XkwCp1O2tNVWur5ySg==
X-Received: by 2002:a17:903:25ce:b0:1c6:25c3:13d3 with SMTP id jc14-20020a17090325ce00b001c625c313d3mr5649024plb.6.1696050143991;
        Fri, 29 Sep 2023 22:02:23 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:23 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 26/29] xfs: move xfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:30 -0300
Message-Id: <20230930050033.41174-27-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
xfs_xattr_handlers at runtime.

Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/xfs/xfs_xattr.c | 2 +-
 fs/xfs/xfs_xattr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index 43e5c219aaed..77418bcd6f3a 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -175,7 +175,7 @@ static const struct xattr_handler xfs_xattr_security_handler = {
 	.set	= xfs_xattr_set,
 };
 
-const struct xattr_handler *xfs_xattr_handlers[] = {
+const struct xattr_handler * const xfs_xattr_handlers[] = {
 	&xfs_xattr_user_handler,
 	&xfs_xattr_trusted_handler,
 	&xfs_xattr_security_handler,
diff --git a/fs/xfs/xfs_xattr.h b/fs/xfs/xfs_xattr.h
index 2b09133b1b9b..cec766cad26c 100644
--- a/fs/xfs/xfs_xattr.h
+++ b/fs/xfs/xfs_xattr.h
@@ -8,6 +8,6 @@
 
 int xfs_attr_change(struct xfs_da_args *args);
 
-extern const struct xattr_handler *xfs_xattr_handlers[];
+extern const struct xattr_handler * const xfs_xattr_handlers[];
 
 #endif /* __XFS_XATTR_H__ */
-- 
2.34.1

