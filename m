Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24EF498828
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiAXSUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245181AbiAXST7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:19:59 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5596C06173B;
        Mon, 24 Jan 2022 10:19:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y17so6116996plg.7;
        Mon, 24 Jan 2022 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ctx5e14bhP1jpSzioFVrN6pk5TDTGGJagrfiokJDdZI=;
        b=fKAowulHFgctXGr3wLhEmOulC+2juzpkhEs8oNgp6ZC7ZJ2za2ukZAElmhDx6ogSGb
         f5ghyHmecV/KYoBTJ1KoCtfqAaYcllGZM7IaFqoL/IKhnxfFHYPYnh2N2ZNkA3G6nu3Q
         LcjRDWlIuFuU88fDc78h9/akZqFgJpDuuvWzJNrAa3cyCbR3xGo14QgOmzYtQB1FreKu
         fHdLSa2EE5khKrzeJ/ip/yRp7JhAzjoy90Sqc9Tr0N272IJUle9RvErjmKrilNZFumG5
         rxoGomefnOekLuKkkzHjMBunFV2v4RAWLPs5hkQPaMidzsGS2IdKe/QkXpoA75+Z0vbo
         GN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ctx5e14bhP1jpSzioFVrN6pk5TDTGGJagrfiokJDdZI=;
        b=djtNF50O2KU1TTtpR+5xDPA++7Y++QDJ5lztVa0JsHkE/LwXMxHUw7Mg0ADeBTKOE5
         YDfzMakmXHknq7QomUU5QhLIRzJMX3OkZG4djGjuduRDqueoc0TiftqVhXeH48L698DC
         rj1tmvvbMKgYPctVFdHmA1SWWAdkpii70Kb0XreMmKcPOO4QdiQhKbKwJ2J25EbZMgq7
         glypv7Wa2zvWWb3ZA56fo1X1ICXDUlQ/9KxwHyfvLI5g5ufdp+MmlMWXNz9WLfsLJ+tN
         bQLbNjIiotLERn1c+2jrllrZ0DfbcZyuYv73UXrOZqMKyoUlmRFiDUclmd6pJUq0U1ZE
         N++g==
X-Gm-Message-State: AOAM531rCdTQExJRShtz7ihiIDWfNwsN0wxWz6SIYB3veTvQY4szeohu
        mD1Ev+Hp5lMrE1toT1xDBbs=
X-Google-Smtp-Source: ABdhPJwlDF9B406Uwoi1s8plAdpLRH1KyU5B6BClt7st0zCWZZ8l//PvIIJeX5+M9wp/KslYiUcIhA==
X-Received: by 2002:a17:902:a50f:b0:149:bc1a:2c98 with SMTP id s15-20020a170902a50f00b00149bc1a2c98mr15350482plq.35.1643048398309;
        Mon, 24 Jan 2022 10:19:58 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id ha11sm366667pjb.3.2022.01.24.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:19:58 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 1/2] binfmt_misc: fix crash when load/unload module
Date:   Mon, 24 Jan 2022 10:18:12 -0800
Message-Id: <20220124181812.1869535-2-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
References: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should unregister the table upon module unload otherwise something
horrible will happen when we load binfmt_misc module again. Also note
that we should keep value returned by register_sysctl_mount_point() and
release it later, otherwise it will leak.
Also, per Christian's comment, to fully restore the old behavior that
won't break userspace the check(binfmt_misc_header) should be
eliminated.

reproduce:
modprobe binfmt_misc
modprobe -r binfmt_misc
modprobe binfmt_misc
modprobe -r binfmt_misc
modprobe binfmt_misc

[   18.032038] Call Trace:
[   18.032108]  <TASK>
[   18.032169]  dump_stack_lvl+0x34/0x44
[   18.032273]  __register_sysctl_table+0x6f4/0x720
[   18.032397]  ? preempt_count_sub+0xf/0xb0
[   18.032508]  ? 0xffffffffc0040000
[   18.032600]  init_misc_binfmt+0x2d/0x1000 [binfmt_misc]
[   18.042520] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
modprobe: can't load module binfmt_misc (kernel/fs/binfmt_misc.ko): Cannot allocate memory
[   18.063549] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
[   18.204779] BUG: unable to handle page fault for address: fffffbfff8004802

Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
Co-developed-by: Christian Brauner<brauner@kernel.org>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 fs/binfmt_misc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ddea6acbddde..c07f35719ee3 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -817,20 +817,20 @@ static struct file_system_type bm_fs_type = {
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
+static struct ctl_table_header *binfmt_misc_header;
+
 static int __init init_misc_binfmt(void)
 {
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
 		insert_binfmt(&misc_format);
-	if (!register_sysctl_mount_point("fs/binfmt_misc")) {
-		pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
-		return -ENOMEM;
-	}
+	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
 	return 0;
 }
 
 static void __exit exit_misc_binfmt(void)
 {
+	unregister_sysctl_table(binfmt_misc_header);
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
 }
-- 
2.25.1

