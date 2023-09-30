Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B97B3E20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjI3FBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjI3FBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E3C1AE;
        Fri, 29 Sep 2023 22:01:14 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c328b53aeaso133639595ad.2;
        Fri, 29 Sep 2023 22:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050074; x=1696654874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViPm2eeZWez7GosgS7Ec0gZyjCavTFF5oxKm8MbpuGg=;
        b=SFpLc4tua/KoIENLihOJW6ASf/vqC+aDrOhpgPkrnx7JjTjM/Fd/d/FchnRUM0mjvO
         lHeP8Qdr0rqgsxiKboNjGoTp5owKliBGUtbbd6UcEyOpmsdpgyEvURiHvkKBdQIZ+Y8U
         GJzT0W0sThdkbqqhG70jWKxy3zMMhy/Jk6pJuRpeF1hyGttAx2fYlmmVbJ/ogzuyygRd
         jJCQ2AWPx5m18cCdQKooZOD3MDMDmUCFz8cMlALw15SsRrOg5QwmBUgeeFHQpRgw1f0c
         4dj6xdivEvPMlUJUgfIjTyLPsOF+mSauJMa1WD10HmFPZ1kDPDl2Vpsp4+/wjrOL83Tl
         wccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050074; x=1696654874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViPm2eeZWez7GosgS7Ec0gZyjCavTFF5oxKm8MbpuGg=;
        b=L/DAsQzv6T/gihmw4t9BevCBzCbhOXEdXa5kUU8u0MbNIQuHClZBgA2MuHd1SSqN6D
         /cysk1N13FwTiE5cnnRzlpfhOMsLHHigRD6MSPxzybtBm9qibHI1THt8ZqpPlvpyGzXJ
         qAJS+mVTKa+DdLtiEvvYeCN+C+oSIRoZDkXkgFWoGsXey9riJPupyi4a4sKnjCxp/VRP
         RR+OSj5H+2IzGDEHfLN1OEGVJo1tvmQrcIHQLUGP7P1Q7l1uqTlWmQdXF7hXvUNfc0w5
         7iJpViBbAqovJnMS05Jk9ehRcDK46zAUyy37fxozh/7AJt8T+OsBBZ2EDOyBKTlDPnom
         ja/w==
X-Gm-Message-State: AOJu0Yxum6JAxLGlH4xfEI7zL3u//Wy6zAy1wF7eDRj6HPK3t6swaUuE
        InX/nq9wJ7YMbuhXvBS6ygk=
X-Google-Smtp-Source: AGHT+IG+l3fV8iD5HMrRShZdK20EkWFhKE5cE0W+riqOkqHNNpN/TeIpEATRcVZmdpv/mD+K9DyvVg==
X-Received: by 2002:a17:903:120b:b0:1c6:d1f:514d with SMTP id l11-20020a170903120b00b001c60d1f514dmr5924330plh.45.1696050073856;
        Fri, 29 Sep 2023 22:01:13 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:13 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/29] btrfs: move btrfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:09 -0300
Message-Id: <20230930050033.41174-6-wedsonaf@gmail.com>
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
btrfs_xattr_handlers at runtime.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/btrfs/xattr.c | 2 +-
 fs/btrfs/xattr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fc4b20c2688a..d82d9545386a 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -442,7 +442,7 @@ static const struct xattr_handler btrfs_btrfs_xattr_handler = {
 	.set = btrfs_xattr_handler_set_prop,
 };
 
-const struct xattr_handler *btrfs_xattr_handlers[] = {
+const struct xattr_handler * const btrfs_xattr_handlers[] = {
 	&btrfs_security_xattr_handler,
 	&btrfs_trusted_xattr_handler,
 	&btrfs_user_xattr_handler,
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 1cd3fc0a8f17..118118ca3e1d 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -8,7 +8,7 @@
 
 #include <linux/xattr.h>
 
-extern const struct xattr_handler *btrfs_xattr_handlers[];
+extern const struct xattr_handler * const btrfs_xattr_handlers[];
 
 int btrfs_getxattr(struct inode *inode, const char *name,
 		void *buffer, size_t size);
-- 
2.34.1

