Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79594E7880
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359865AbiCYP7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354373AbiCYP7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:59:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C32BED
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 08:58:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so16234018ejc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjCwVKHInkYZOFvCXl5F/8irvVzXQKz9So+Ci2sABwA=;
        b=NMp4rsHHEXk8g/POoZFFTUizV17UY+9wSy7x5dg7sZozadTXMD9WyFq8GTw7Kz4wA8
         SpWE/tZ2noPTMjHAeolFtuGuWeCh3B8gP8VxKsgLcwdE7gpxduOe7j4QCv4uMFeiAT56
         FvJAcD5BLMpkPWnJBX1enNqNq92T4Qs2sn2cJPcDCxykTC/hC85ATCMauPkIf/JvIOOm
         Gtd94/qd25h+5sjYl6LQuGNwPGhw9Gd8Hded62kggmHR0U5HzT1Ry+glhlJ35b9mFI91
         Z3JuGWcTBeiZ4rIAWWsbEvQRLf+zs4wCLbdKGE33ptYGQTiF53r3LV+AS3YTjipd/Q5D
         TJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vjCwVKHInkYZOFvCXl5F/8irvVzXQKz9So+Ci2sABwA=;
        b=XLCNcDEkmM2HbH6G/fgMYD5AXq3jra01HjesjVpZ+KLdYBWBMLvxLxllxNKJIYLO+N
         VYph58XLysRK6qtn0vSzztWNfc73HQbLEdtXCmbEVR4HnB4bBEt+zC/cMb8K3t/Qy9Hl
         xOjExAflrMH+dE9sPZKuBdXTBpF0IOS9vj+amDrgldr49EBdLH0Zg6xZuLEzRYZe468y
         6OMfoeq0kxi2kcD/cPgybIxOitxBTbl8GDCLzHFacdSfXGjpkwNoGuq69v3YpGfNpvb/
         kyDfUxxyUZ+kIjLGc9IqiYKiYyP5IxygripXH5TC4IhnxF6Td2NCJ/J6IHtVlJoUwfvM
         y1og==
X-Gm-Message-State: AOAM530PiuxUaW0L9DhPUSjMvESe0i0zq259+1lQo1+21o0h/viUqYvA
        z9vH2ycmlQ2TRN9gNV3HS2nG+OXaYONRxg==
X-Google-Smtp-Source: ABdhPJymmP3C6QVZiUZ1G60vdKCKxvxLWCUamOYE3q8DwvFKnKuUH37CGIWLL77Xo4yIldsoxVUD8w==
X-Received: by 2002:a17:906:6a27:b0:6e0:3017:d3c2 with SMTP id qw39-20020a1709066a2700b006e03017d3c2mr12564107ejc.358.1648223889632;
        Fri, 25 Mar 2022 08:58:09 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170907160600b006dff6a979fdsm2554934ejc.51.2022.03.25.08.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:58:09 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] fs/dcache: use write lock in the fallback instead of read lock
Date:   Fri, 25 Mar 2022 16:58:04 +0100
Message-Id: <20220325155804.10811-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, there is a fallback with a WARN that uses down_read_trylock
as a safety measure for when there is no lock taken. The current
callsites expect a write lock to be taken. Moreover, the s_root field
is written to, which is not allowed under a read lock.
This code safety fallback should not be executed unless there is an
issue somewhere else.
The fix is to change the read lock to a write lock in the fallback.

Note:
I am currently working on a static analyser to detect missing locks
using type-based static analysis as my master's thesis
in order to obtain my master's degree.
If you would like to have more details, please let me know.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch. I have both compile-tested this patch and runtime-tested
this patch on x86_64. The effect on a running system could be a
potential race condition in exceptional cases.
This issue was found on Linux v5.17.

Fixes: c636ebdb186bf ("VFS: Destroy the dentries contributed by a superblock on unmounting")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..d81f5b9c2bce 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1692,7 +1692,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
 {
 	struct dentry *dentry;
 
-	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
+	WARN(down_write_trylock(&sb->s_umount), "s_umount should've been locked");
 
 	dentry = sb->s_root;
 	sb->s_root = NULL;
-- 
2.35.1

