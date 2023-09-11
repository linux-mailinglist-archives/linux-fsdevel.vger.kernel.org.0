Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7321A79B627
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjIKUxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbjIKOYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EEEBE50
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694442243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uRBy/5hifpXCoen/qJhmmaxJlCG9fz8e4gG1zbFX/1o=;
        b=PY8AMyTJ/XH6Kps2cYdxXgNq8sYAohWT81b+tqlL7bg567e0oeXd13suJLFWPoI4iORzKT
        F9Q2dI+RQiaR+4MAksh/m7Wdq5POxpWLENB6VU9xfdzEqpmg6y18dQEEoX2jrgpgZdX9kP
        0UUG29kJiokGjjFDu5/E2Inml5hUI3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-hrRTlzsfNai227-xHYT_Nw-1; Mon, 11 Sep 2023 10:24:01 -0400
X-MC-Unique: hrRTlzsfNai227-xHYT_Nw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401dba99384so33817725e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 07:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694442240; x=1695047040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRBy/5hifpXCoen/qJhmmaxJlCG9fz8e4gG1zbFX/1o=;
        b=YZz9wUynReg8c3fQklKzmIs4hdVxzrb0ULII5CPI5x+Lukp5Nl+ym3bnbF44t5owAw
         59w1dCKN0u8vD8qhkXaTa+4pnTfefi2Fw1vYa9vJHmiekPWHsoUA+gdrxulgIXeZCkY4
         xou4kBaDD7YAldhIg5499GbaQqkWBZv65tiT4yf+q6wPId28/NmFnT13Sk+XzHyEokFu
         tX5p8IsG8CCbyd6rSHrQKKTfWuf/lnd4V3vP8ap3zR4ne5hBDR/npZfCfKMCPl2RMuZ1
         79XueXBlcfG3HqnJAYP6nJAB5dCZXPyVDQpxdcdXIJCPIDolac9rR6ZpSzmhhoms58e5
         9f9A==
X-Gm-Message-State: AOJu0YxkA2qtsmCAqcBFQRCSIA9FESlemWdVKP1w0KbXsV6Vja70kpwm
        paieVYXWYkjeqXDrpMAIj8OGQ95IJCocxq6Bo5u/WoFU4IdK2lTNKmdWg8yuVLVWMCZWPY2zKMV
        XCCvhywfCema3CjlD6dhC2FBZrA==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id n17-20020a7bcbd1000000b003fc0a494c05mr7916586wmi.40.1694442240423;
        Mon, 11 Sep 2023 07:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zMpKjEdJmmCLNeJZXrAZudqrekd0jemCiU1mmGpQotLlsulhOtjU19kH5XisEZuTTQ7n+A==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id n17-20020a7bcbd1000000b003fc0a494c05mr7916569wmi.40.1694442240086;
        Mon, 11 Sep 2023 07:24:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003fc04d13242sm13357490wmi.0.2023.09.11.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 07:23:59 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
Subject: [PATCH] selinux: fix handling of empty opts in selinux_fs_context_submount()
Date:   Mon, 11 Sep 2023 16:23:58 +0200
Message-ID: <20230911142358.883728-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

selinux_set_mnt_opts() relies on the fact that the mount options pointer
is always NULL when all options are unset (specifically in its
!selinux_initialized() branch. However, the new
selinux_fs_context_submount() hook breaks this rule by allocating a new
structure even if no options are set. That causes any submount created
before a SELinux policy is loaded to be rejected in
selinux_set_mnt_opts().

Fix this by making selinux_fs_context_submount() leave fc->security
set to NULL when there are no options to be copied from the reference
superblock.

Reported-by: Adam Williamson <awilliam@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2236345
Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10350534de6d6..2aa0e219d7217 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2775,14 +2775,20 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 static int selinux_fs_context_submount(struct fs_context *fc,
 				   struct super_block *reference)
 {
-	const struct superblock_security_struct *sbsec;
+	const struct superblock_security_struct *sbsec = selinux_superblock(reference);
 	struct selinux_mnt_opts *opts;
 
+	/*
+	 * Ensure that fc->security remains NULL when no options are set
+	 * as expected by selinux_set_mnt_opts().
+	 */
+	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
+		return 0;
+
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
 		return -ENOMEM;
 
-	sbsec = selinux_superblock(reference);
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
 	if (sbsec->flags & CONTEXT_MNT)
-- 
2.41.0

