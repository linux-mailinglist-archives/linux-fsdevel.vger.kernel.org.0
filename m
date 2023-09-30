Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1C7B3E3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjI3FDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjI3FCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:02:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2EC10C1;
        Fri, 29 Sep 2023 22:01:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c63164a2b6so9927795ad.0;
        Fri, 29 Sep 2023 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050106; x=1696654906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH9OE0TWxgoHAH6ZcW6POZxSiYPCkmArEwnHUlA64Qc=;
        b=Lk93wttLTNuHCCDZqSRZu5hJ6zh3eTJKxYMAetLyk/k1h/oXdJnm0fCj38edehQLsl
         XoA4+r8hWx+EEbFhBJkkysH94rH1vypgXKJ3g/jBhyU1TDyJLkDJuMFzLFakzLrWyLmC
         o26/AiZu2yqdMpvtI8+46US7syVhfZpxaf1Mv79qGeOxrF5g69Vc+r4Vbw9FVnLFqZFl
         Nt32QadODTj6Ur0bNdbLd/h7b56+rv7bHRGV+hl7cA1uCU/mtoKtKYnALbPoaWPmn3kI
         MmYUZKyU9h4verzDki9ZCfxMtcSPqTNc36UUCXQ1ldMjqf4ilfgAOpbdKm4knONhASF1
         4rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050106; x=1696654906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH9OE0TWxgoHAH6ZcW6POZxSiYPCkmArEwnHUlA64Qc=;
        b=dACHRVqLaENYRh8Z6MnZ9JICvB/ru8u9Xce4ISCIHoH+1Yb5nLf+ijkz51UQuZkkf4
         rXvvIR9IixVQ3pYAvdrdraG5uPm5FHxib84mQzlJ+o4kDhBNWvEl1uLDeqJGr+vPN3dv
         ItFBUPbP2oXNbSmgqV3s4GgliILi0Ue+HqJN/Vmf8iP2VoVh3lMSw4CR7bsEEFvSFlis
         GFdop2QncRDYusWoaybkRZDRwqc8R6FIKcAZFgtNGL3AbA3psl/a811hUWrIXXjeJcPN
         X1syXbzstlrafr5Q5Ad4ya6cV6htyFE1ZHJDkPrP0s6zI9F8anRODh71UbBRwe8gWLmu
         9xUg==
X-Gm-Message-State: AOJu0Yx0m+wAEfLuCHMK1sGD1AjPhVcU82WKyzH6AIDrWI2S4BE6ceZU
        qB4/JkkTv2zqv2CtF9fYvqM=
X-Google-Smtp-Source: AGHT+IHAzgG2FCKLymM5welKmJ5/CePC/XSaVTDjJbbILvZOuVR8hRdcHee/TCME5wh9arWVsysT6g==
X-Received: by 2002:a17:903:41d1:b0:1c3:432f:9f69 with SMTP id u17-20020a17090341d100b001c3432f9f69mr11026355ple.23.1696050105710;
        Fri, 29 Sep 2023 22:01:45 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:45 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 15/29] jffs2: move jffs2_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:19 -0300
Message-Id: <20230930050033.41174-16-wedsonaf@gmail.com>
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
jffs2_xattr_handlers at runtime.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/jffs2/xattr.c | 2 +-
 fs/jffs2/xattr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index 3b6bdc9a49e1..00224f3a8d6e 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -920,7 +920,7 @@ struct jffs2_xattr_datum *jffs2_setup_xattr_datum(struct jffs2_sb_info *c,
  * do_jffs2_setxattr(inode, xprefix, xname, buffer, size, flags)
  *   is an implementation of setxattr handler on jffs2.
  * -------------------------------------------------- */
-const struct xattr_handler *jffs2_xattr_handlers[] = {
+const struct xattr_handler * const jffs2_xattr_handlers[] = {
 	&jffs2_user_xattr_handler,
 #ifdef CONFIG_JFFS2_FS_SECURITY
 	&jffs2_security_xattr_handler,
diff --git a/fs/jffs2/xattr.h b/fs/jffs2/xattr.h
index 1b5030a3349d..7e7de093ec0a 100644
--- a/fs/jffs2/xattr.h
+++ b/fs/jffs2/xattr.h
@@ -94,7 +94,7 @@ extern int do_jffs2_getxattr(struct inode *inode, int xprefix, const char *xname
 extern int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 			     const char *buffer, size_t size, int flags);
 
-extern const struct xattr_handler *jffs2_xattr_handlers[];
+extern const struct xattr_handler * const jffs2_xattr_handlers[];
 extern const struct xattr_handler jffs2_user_xattr_handler;
 extern const struct xattr_handler jffs2_trusted_xattr_handler;
 
-- 
2.34.1

