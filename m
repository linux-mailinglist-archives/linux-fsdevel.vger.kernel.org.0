Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37647B3E5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjI3FEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjI3FDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B71FD0;
        Fri, 29 Sep 2023 22:02:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so10231870a12.0;
        Fri, 29 Sep 2023 22:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050152; x=1696654952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNgBYnm3H81CL2AuZdWmOPe+pdl1B3VjJnIrmYnD2KM=;
        b=ZjSIypxRE2W8y2ExF38WwCcprBmHUjWY845bSU6xuICaiZKMN6fjwxqIvxGX+EnUn0
         tZM884r2KmCnahZZszQpwvsLMIwFrgRIFnLK2ccBIQ7NgWCMZpX6Th6aR+on0aikpcnC
         1nLBLPcbVzhH9c3yB73EX9PBYyefZCATsExTqW7lYD0OsiJDs3alDykVg4KOA2MgTFcM
         NS6E9JRYsUPGuotNtVRxZKLuvRpEuqduNsL5mN/VApu0xI7p5ONZNGO3ADZIq6ne5bfH
         +EDIZv1RhNJoNWEPnu0hLDeeQb/593bcsHSTj4ZYlOHcI4+R11nQXUnML+tWG6YpEQaI
         Qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050152; x=1696654952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNgBYnm3H81CL2AuZdWmOPe+pdl1B3VjJnIrmYnD2KM=;
        b=ImxdMpqKQGop5/ARYaP/UCrqNFbFhaj7D8enNvtYz0OrVX4CFf80hmkW6ypWlufqDG
         SBUfBlOvRiH+mf0BFgOWPfSXcboXo+bKX5o4WFkxK/rRBYIhN0jmVAWH1/PluGeh2OeA
         uzIj5dIpqrNiwxMwiAXFC/A1NYkp2+KM+sMGit+bA29/Fq6ceiMOysbULPTGmUY79x1M
         oZzuVzcCYMQqP5NesC/yQvI0/aSKPu5j6crD/0gVNuzRP0wDziFhTJ6Z/mQ7uWn9VHIN
         Z8mTCMK94TM6yoKQcLzueWwFMoqnF1GkFzeuZwAavWXnoIerDsXZjwC7wrmI8ZqAqtxX
         Dwmg==
X-Gm-Message-State: AOJu0Yzc+w2Fd8rD2SJsCkWdg3EnS9d019zrfNctLBmlsePXkHzXhfQg
        9ltcfR7zs8s7rjC3xob/V8AQHwfxHV00Cw==
X-Google-Smtp-Source: AGHT+IEkoX3osHqW7MF0FxSEMREB1QMsEglPWjtX2Q1cWoIBeEDqUcOfOMx9W6EaOObSdAy+ByR2RA==
X-Received: by 2002:a17:902:e80d:b0:1c5:efd1:82b6 with SMTP id u13-20020a170902e80d00b001c5efd182b6mr6762435plg.30.1696050152408;
        Fri, 29 Sep 2023 22:02:32 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:32 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 28/29] shmem: move shmem_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:32 -0300
Message-Id: <20230930050033.41174-29-wedsonaf@gmail.com>
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
shmem_xattr_handlers at runtime.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d963c747dabc..683c84d667c1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3487,7 +3487,7 @@ static const struct xattr_handler shmem_trusted_xattr_handler = {
 	.set = shmem_xattr_handler_set,
 };
 
-static const struct xattr_handler *shmem_xattr_handlers[] = {
+static const struct xattr_handler * const shmem_xattr_handlers[] = {
 	&shmem_security_xattr_handler,
 	&shmem_trusted_xattr_handler,
 	NULL
-- 
2.34.1

