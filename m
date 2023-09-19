Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867C7A5C48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjISISY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjISISW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:18:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76B11A
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40434d284f7so56212225e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111495; x=1695716295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gAr+spSxhyFbhqTlLTsUHb79LCXE+R6cPkLBxMk/S0=;
        b=a6Px7MKbWj9XN89Vv2RGeM7Tcww6D+O+V6x+isuBPEM0nJtB4HOp+iN6RJj33H6srq
         qYIjfTpZPCqzy2+Xa8U6lCDzb1VhwT2QZN+08uOpRIAYt5N6dkzxMun7CpV4s3b6aAqu
         rmTbvGLJmIsE9z8DOuYTsfvo/J48WclbZuoNQKsnEsq/gP+zvxQSRpQckTJzel9fXROP
         x1Odydqt41yZpy+yPMog78EX6B+3Eh9IEL0DRZ4oLdEyzmCsAIT2GiaTzNLsuUqzH12Z
         5bT1Ahvx8iBVzxJ+j910NVViwI3Z3kjYWzl4h9tRRUbgI7qWO1w1ZbyMl184+pk2i2dT
         aEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111495; x=1695716295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gAr+spSxhyFbhqTlLTsUHb79LCXE+R6cPkLBxMk/S0=;
        b=E+e7xyYCKMAMk5OZWny0/969/4mtcYArrAQAK373UTjb+oZuznsOOefe5LRW5cfECP
         cPO1B/ux9snsswaFXxP1ywRwc7wZ/ufvv/j6+ySdLBr4SLUtCGhZ8oyDN8Sk5j+sFYGc
         HGQh7ZUvBInXb3dVJH+FXJdK1xgbplcQDGL37+mTUSxpONPyGvrvJpe5D40UbHA3OWy0
         N4iaGABE+ICyEL6Wgz0/U5Ml3R9yYQcWuvfmEzOyKTi5PiLItPOZl2gYf06AUtaKP8nJ
         HhQ/afiHDADzzJxYgb5tD4qruu8Gp/KOn9Xo57yrq2aO14o1h++uL6ne2EimK2v3IODT
         9kMQ==
X-Gm-Message-State: AOJu0YxKYd3Ov4h4f65ncUGQHwQjQN5rUa+Ol2m/VMr7kWXDbxJ9h4K6
        64SNv83nLgHeHkv7GXVEESKlIw==
X-Google-Smtp-Source: AGHT+IG5VEm9hgImnF5v/c+C1fp7ixIrprGYP5WLwWP+P7ukaYzOA2c8Th+LPLSPi3vygtcDYT1eyA==
X-Received: by 2002:a7b:cd1a:0:b0:3fe:d630:f568 with SMTP id f26-20020a7bcd1a000000b003fed630f568mr8617755wmj.39.1695111495235;
        Tue, 19 Sep 2023 01:18:15 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b00402f745c5ffsm14451531wme.8.2023.09.19.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:18:14 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/posix_acl: apply umask if superblock disables ACL support
Date:   Tue, 19 Sep 2023 10:18:07 +0200
Message-Id: <20230919081808.1096542-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function posix_acl_create() applies the umask only if the inode
has no ACL (= NULL) or if ACLs are not supported by the filesystem
driver (= -EOPNOTSUPP).

However, this happens only after after the IS_POSIXACL() check
succeeded.  If the superblock doesn't enable ACL support, umask will
never be applied.  A filesystem which has no ACL support will of
course not enable SB_POSIXACL, rendering the umask-applying code path
unreachable.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on tmpfs:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/posix_acl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a05fe94970ce..79831269dd2f 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -642,9 +642,14 @@ posix_acl_create(struct inode *dir, umode_t *mode,
 	*acl = NULL;
 	*default_acl = NULL;
 
-	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
+	if (S_ISLNK(*mode))
 		return 0;
 
+	if (!IS_POSIXACL(dir)) {
+		*mode &= ~current_umask();
+		return 0;
+	}
+
 	p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
 	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
 		*mode &= ~current_umask();
-- 
2.39.2

