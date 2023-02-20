Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78BD69D113
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 17:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjBTQGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 11:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjBTQGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:06:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A291CAEA;
        Mon, 20 Feb 2023 08:06:34 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i31so276242pgi.10;
        Mon, 20 Feb 2023 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLP6dM5UDXEXAsSXY5zqNOKH8FTtAx9f9GeuD7z2I7g=;
        b=PG60FkTAG0Es9fS2CFHgfWTINP6FKXqlXydj7S0O1vL1rrZ6zMghbnpNwc3knpgM0Y
         CPRlCGDtOYRzlcUVZChY/UK7iCs8ebIfpn+djDYnZdrBc4u7/Q/Mpaz+VYfiocZdiC99
         kuLRb4BThueOAIUm2og65OfVrJNPlmlFPZd8LsvTwivYNSnauS3kbVsEvoSNEIZjyNDO
         ue/dgh5cFUHlhpkmuF42ScNW332EQ6dnEW2G5ksD43LSuMc0YNZhgV26iHKqNhB1++fo
         0AYYtUtG+JOC9ZrUjsu601z7GHdO44uyvqV6JOgYFC39p2it0IuCDGNuFzzbcHbtua2z
         BW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLP6dM5UDXEXAsSXY5zqNOKH8FTtAx9f9GeuD7z2I7g=;
        b=6Xy0Gum8jzt3mkUbf0wovO6PgDO+Qot91A+/rt32f4zxGI3v+py5PTLPDnFT9BRyX+
         0PkeuzVMfhazBCRn42AMUbGfGv2RDwExYxd/mh+hdaRJOoME7MLVoOlKf+XiLFB/9JiZ
         h5qHip1ClMIdbuaynlHEl2MM9KYOW6ATGgc1NhalWzQXR+/PAa++/S7t1hfQZtH+1Z+H
         pz5tNwIPezWXAgq1tErxx41gM0DW8B0GC9H5zw26SOA7siXUYSIoWBA74G1bRvlEj3sq
         QR3Dews/3s5MzxSF7JDP4G10/J9TSOslZrRhtUgy295ulh2cISVkY4cYlTTuzvBdjKFW
         2mVA==
X-Gm-Message-State: AO0yUKVTGhb9Yxkq7S+JLvTuxXPcZhq+YFHOkBiTghPcwhMzStwcBqvz
        kHl5AFVXEEoHBtB/+6Ddmp3YsNOY6huCVMhNIEdmVw==
X-Google-Smtp-Source: AK7set9+SD0x0cCHbgSXv/F0/kt8Q29dx6hkzfRODnqQSEmj8K41Z472m62CrbV4Yre/QQprta2C2Q==
X-Received: by 2002:aa7:9543:0:b0:5a9:c797:a1d6 with SMTP id w3-20020aa79543000000b005a9c797a1d6mr2018765pfq.2.1676909193069;
        Mon, 20 Feb 2023 08:06:33 -0800 (PST)
Received: from localhost.localdomain ([117.176.249.147])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b005893f281d43sm7830958pfm.27.2023.02.20.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 08:06:32 -0800 (PST)
From:   Moonlinh <jinhaochen.cloud@gmail.com>
X-Google-Original-From: Moonlinh <moonlinh@MoonLinhdeMacBook-Air.local>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org
Cc:     ChenJinhao <chen.jinhao@zte.com.cn>
Subject: [PATCH 1/1] fix NULL dereference in real_cred
Date:   Tue, 21 Feb 2023 00:04:29 +0800
Message-Id: <20230220160429.2950-2-moonlinh@MoonLinhdeMacBook-Air.local>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230220160429.2950-1-moonlinh@MoonLinhdeMacBook-Air.local>
References: <20230220160429.2950-1-moonlinh@MoonLinhdeMacBook-Air.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ChenJinhao <chen.jinhao@zte.com.cn>

When PAUSE-Loop-Exiting is triggered, it is possible that task->real_cred
will be set to NULL. In this case, directly parsing euid and egid of real_cred in
task_dump_owner will lead to NULL dereference and cause kernel panic like below.

 #1 [ffff97eb73757938] __crash_kexec at ffffffff8655bbdd
 #2 [ffff97eb73757a00] crash_kexec at ffffffff8655cabd
 #3 [ffff97eb73757a18] oops_end at ffffffff86421edd
 #4 [ffff97eb73757a38] no_context at ffffffff8646978e
 #5 [ffff97eb73757a90] do_page_fault at ffffffff8646a2c2
 #6 [ffff97eb73757ac0] page_fault at ffffffff86e0120e
    [exception RIP: task_dump_owner+47]
    RIP: ffffffff867496cf  RSP: ffff97eb73757b78  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff89fbb63dbd80  RCX: ffff89bb687677c0
    RDX: ffff89bb687677bc  RSI: 000000000000416d  RDI: ffff89fbb63dbd80
    RBP: 0000000000000000   R8: ffff89f51e1f5980   R9: 732f373839323734
    R10: 0000000000000006  R11: 0000000000000000  R12: ffff89bb687677c0
    R13: ffff97eb73757c50  R14: ffff89f53b19c7a0  R15: ffff8a75170e2cc0

euid and egid are temporarily set here, and for certain modes, they will
be updated to GLOBAL_ROOT_UID/GID by default when make_uid/make_gid
returns invalid values.

So, whether the NULL real_cred can also be considered as invalid value, and
treat the same?
---
 fs/proc/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..2cb77fc64e28 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1833,8 +1833,8 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	/* Default to the tasks effective ownership */
 	rcu_read_lock();
 	cred = __task_cred(task);
-	uid = cred->euid;
-	gid = cred->egid;
+	uid = cred == NULL ? GLOBAL_ROOT_UID : cred->euid;
+	gid = cred == NULL ? GLOBAL_ROOT_GID : cred->egid;
 	rcu_read_unlock();
 
 	/*
-- 
2.24.3 (Apple Git-128)

