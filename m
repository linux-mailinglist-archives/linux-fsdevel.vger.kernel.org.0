Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988677B3E1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjI3FBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjI3FBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:11 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157A81B7;
        Fri, 29 Sep 2023 22:01:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c5ff5f858dso87310675ad.2;
        Fri, 29 Sep 2023 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050068; x=1696654868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GtFO6vuSssICdkJfKNyb2r68AOrzMFP2HioLeCz7V4=;
        b=CF9F6ZMXs4tS7I5BphwJiO7DM3J4c0nlEf6bVj85qGyOGo9VJtGLLMlWWJHWukH7sz
         wuyHd5dGgSPMmu2W/oMJR1TGBnzSXDFm7CLkjk0PeaqNrn2J9+Ca1CDurOR/ue5ZRLq2
         XJa8cBVB4wekSCyqp/JprH12ZLE8vM+JsSzzjwyjDodv9U5qd0hOOyb1TTB78V76wUr8
         cX5hXZP9iGZ6ONRiyzpcK/sRKZpKsiDcsvtKhjEL0ha4z9CWGhlVDnkRtbmuV4pnC0DD
         wj8fqO0KZn+KbSlb3chO2T2uOGMSraivDa+PeKs0KnXzDPfZEVstyCGik95RTTXZ9rBF
         4qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050068; x=1696654868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GtFO6vuSssICdkJfKNyb2r68AOrzMFP2HioLeCz7V4=;
        b=GovwltfyFu6y5UOUQH5R9O1rlwg0ByXpl086SgyoBuwZwKcfR2ToeJzQLA7k2oPidZ
         TpIYKyNU2ZQiXbZaQZ+p5lPahpksMiwv9LIS9bRzghCvRPlNADvivTLb3u15jwNLj6LV
         66IZxOwK1A06eE5AGeTkdGXwLKy6VaAB16ine9MMf0phl8iXis2mX6RekLbkOgwNQ4D8
         HwNaVmSfpmZWWxdCuJ//3z0frxzmq7yXgo2hNHpRORO2/Lp/qqewqmP/sOLb/C4PIyno
         SyufpvKX2SRqQQvgL7joIQ5b2S0mxuusK07hnGZuNBIGL6lmWDpYE1iL1BcglrB1Q61s
         kOew==
X-Gm-Message-State: AOJu0YwYyrl+LRQXEpjm2A0MetBpHkznn9nmBFanqhgQLKwwsCYy4VDP
        oczE1pCHmBOUfyAJ3aoNz6k=
X-Google-Smtp-Source: AGHT+IFxqffIY89PQUswFKtn5NoGKsgIMAvFv6a9S5IWp52RXMEP6bAOtDEOepkpnybcFK70HBAR3w==
X-Received: by 2002:a17:902:f54b:b0:1c3:86cf:8cc0 with SMTP id h11-20020a170902f54b00b001c386cf8cc0mr6608621plf.10.1696050068454;
        Fri, 29 Sep 2023 22:01:08 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:08 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 04/29] afs: move afs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:08 -0300
Message-Id: <20230930050033.41174-5-wedsonaf@gmail.com>
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
afs_xattr_handlers at runtime.

Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/afs/internal.h | 2 +-
 fs/afs/xattr.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9d3d64921106..a01d1f71ae8c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1539,7 +1539,7 @@ int afs_launder_folio(struct folio *);
 /*
  * xattr.c
  */
-extern const struct xattr_handler *afs_xattr_handlers[];
+extern const struct xattr_handler * const afs_xattr_handlers[];
 
 /*
  * yfsclient.c
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 9048d8ccc715..64b2c0224f62 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -353,7 +353,7 @@ static const struct xattr_handler afs_xattr_afs_volume_handler = {
 	.get	= afs_xattr_get_volume,
 };
 
-const struct xattr_handler *afs_xattr_handlers[] = {
+const struct xattr_handler * const afs_xattr_handlers[] = {
 	&afs_xattr_afs_acl_handler,
 	&afs_xattr_afs_cell_handler,
 	&afs_xattr_afs_fid_handler,
-- 
2.34.1

