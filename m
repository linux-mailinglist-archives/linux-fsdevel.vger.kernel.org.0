Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56C14976C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 01:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiAXAdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 19:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiAXAdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:33:53 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C4C06173B;
        Sun, 23 Jan 2022 16:33:53 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g2so13685210pgo.9;
        Sun, 23 Jan 2022 16:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpX4ecSb0e+06p326ykDTkroEp41gEPP6WRFjfBdl4w=;
        b=O48NMz9Zfry3yFS2QCX3pEEw3gYYzGUh21zsPB4VzU5gnaYI9EzADMqBVsgr2n4pkr
         axxHq24jBc4QJeGPa8sjcIyx01T6OEuQV2US1iwRmeNhx2e1u8jRzXljPrYEXj6sb4AC
         XPGz91sAyqFdG5oGxsPriNO4YPNDNXiJg1NS7d/sa76efYIyc1bNDbYrEy0v6T0aSbgu
         cBZGjqQSOlaWrUGTZaraVg9lxT1dqXiRVJXg2J6AHwgKsCnbklLgMjV9cbauwMzlPNnf
         E9+Fx6yRmMMEbHYxlZmz+hH9sKRrZtWdh2ds0AVZVl8Ado3jkFoWrX/PiZkJ5EgJo0u2
         PJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HpX4ecSb0e+06p326ykDTkroEp41gEPP6WRFjfBdl4w=;
        b=xg7/xD1sp6Dp5LhTlYNjRy0tYjuLgsor0pGHkjenBGxSvhQgnwU16FDrEYrx7HWGpb
         A5fkJ+rYaixPOOiPnT0VBQNeFczwr8ztnxmXPubBrLOum23N98NoLISVtXPkMC+/Mfwv
         xwcJtcejzH9kuw8N78FRf/RS6H4XfmFlK1cqfVcrc9YGf4mDGedVpT4/WDm9g9zvLvt7
         CMhPhgVB7qCMV5NjtcEziFqkV+gqv4nHkQ8jAs5I4SAJft6Oe/gE8ApQJ4vpPYPpJfxp
         P0N19XFNbf0JSHyrZPq0c04tC6Vg+QSu16QtGSTloAlpw/yqJ+m6TrM7ZgZyeG47lCZz
         AY/A==
X-Gm-Message-State: AOAM530c4w5N0+idgUjhA9V/KyfYbwg08hI2Y0APKa/TiIXUcd5HDQLJ
        Xw9KONNNPzIVhnIgf5lyCD0=
X-Google-Smtp-Source: ABdhPJyKg2M4A98BdPmPFrbAvdcUJynOKsgFR9nlZRYDXhyxPRvadysZNeCNoZ5IkZP+0lIkV5VqMg==
X-Received: by 2002:a63:bf4b:: with SMTP id i11mr9958661pgo.214.1642984432315;
        Sun, 23 Jan 2022 16:33:52 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id lt17sm10909710pjb.41.2022.01.23.16.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 16:33:51 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v1] binfmt_misc: fix crash when load/unload module
Date:   Sun, 23 Jan 2022 16:33:41 -0800
Message-Id: <20220124003342.1457437-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should unregister the table upon module unload otherwise something
horrible will happen when we load binfmt_misc module again. Also note
that we should keep value returned by register_sysctl_mount_point() and
release it later, otherwise it will leak.

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
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 fs/binfmt_misc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index ddea6acbddde..614aedb8ab2e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -817,12 +817,16 @@ static struct file_system_type bm_fs_type = {
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
+
+	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
+	if (!binfmt_misc_header) {
 		pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
 		return -ENOMEM;
 	}
@@ -831,6 +835,7 @@ static int __init init_misc_binfmt(void)
 
 static void __exit exit_misc_binfmt(void)
 {
+	unregister_sysctl_table(binfmt_misc_header);
 	unregister_binfmt(&misc_format);
 	unregister_filesystem(&bm_fs_type);
 }
-- 
2.25.1

