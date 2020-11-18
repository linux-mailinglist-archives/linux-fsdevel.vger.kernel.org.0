Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E22B84C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKRTTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgKRTTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:33 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9948FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:33 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so1550541plo.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Juha+13op+j4M860hObsmkFcXreLNLajnjj5oyj6Fc=;
        b=SXRyxESnxqWtvijXr4ME6DRo29Bb+r4IbukyFtWQhUiOeWuZMiGoqk8zT99vU9CfIs
         sFsL4VFXw2Tdeu6ztQjIN8SWzVcjYb5tSsuwX2M7LgIRx5Vsjp0xhYMqn57o+cyV2Wcc
         Gd5uTWmqj4v7p5sN5d7gLtojV66ED7tqqRR5lXMvzAaTJksLxc6da5hefoE8IqFedSCV
         ZBQmOGce5/4zoRzCiE8Jo82GHMms5/lfwKHOoA2VmDX8VgTzqdPXpFhoCMXQqoxjNZFq
         XWGHYeHvM8PzVrbopREJ9MeummLpqJn5ttjLSbS+YtpopW8KYFNKXrNVcy0oyTa95rGD
         zRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Juha+13op+j4M860hObsmkFcXreLNLajnjj5oyj6Fc=;
        b=VzJzrivg9+Cf4a0OJXdJiJG5mwKE2GzgcHEGZs7RlNIzrMIgG06rWiaozGLVthoxYn
         nUQ1vqzM8x60oiYAwNPuNLLK2qy7YX+0j0c9Avzjn3jUt//HnPbq6A1hIk2521i/CR1f
         1Zwf6FmSj6oHQgCwR2+V6w2yTHrOs/duePU32nDZCA3Q/AWMHMfepCvO9oQ3k3JexK4r
         yCIhtwuhinb7dcziu2uH4hFUJ/IigpJJWZCzwv7dENzpEmfRxGudhs9Ubu6NHuaC2CcM
         jDI7V9/dlRhcaAz71Nu9UiV1O6diNPxhlV7HbvZ3o3Yv4pcKbIYu1vkRCNaIPCLsWee0
         Gu3A==
X-Gm-Message-State: AOAM5309iJOnEiRZ2R+8zsCU9a+KmcyfyzQa19XKfmIBnIk12GjV9OY3
        Rb3cOK7x7sBsCdK9M1BJnMtIig==
X-Google-Smtp-Source: ABdhPJwtVAIOFL011TKnuC2lFW9Qq26zYzRJ4/EAzUsgjlotJzQpQnLq3yrQQp7SThqbk1uJ/r1pkw==
X-Received: by 2002:a17:902:8ec7:b029:d8:e603:304c with SMTP id x7-20020a1709028ec7b02900d8e603304cmr5393411plo.85.1605727173156;
        Wed, 18 Nov 2020 11:19:33 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:32 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/13] btrfs-progs: receive: open files with O_CLOEXEC
Date:   Wed, 18 Nov 2020 11:18:54 -0800
Message-Id: <41f3e3f92372f48037c7cee18af808d4cc5352c5.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Opening with O_ALLOW_ENCODED also requires O_CLOEXEC. Let's add
O_CLOEXEC now in preparation. btrfs receive doesn't exec anything, so
this should be a no-op.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 cmds/receive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..2c56cea6 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -654,7 +654,11 @@ static int open_inode_for_write(struct btrfs_receive *rctx, const char *path)
 		rctx->write_fd = -1;
 	}
 
-	rctx->write_fd = open(path, O_RDWR);
+	/*
+	 * When opening with O_ALLOW_ENCODED, O_CLOEXEC must also be specified.
+	 * We might as well always use it even though we don't exec anything.
+	 */
+	rctx->write_fd = open(path, O_RDWR | O_CLOEXEC);
 	if (rctx->write_fd < 0) {
 		ret = -errno;
 		error("cannot open %s: %m", path);
-- 
2.29.2

