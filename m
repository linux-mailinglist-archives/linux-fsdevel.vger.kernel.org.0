Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16D94C6AD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiB1LkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 06:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiB1LkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:40:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34571C88;
        Mon, 28 Feb 2022 03:39:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 10-20020a05600c26ca00b003814df019c2so2718653wmv.3;
        Mon, 28 Feb 2022 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+f9tMcztypYTJErs8jCKoHKno97PRfBI4us/WusXC6M=;
        b=iuzCIIQRuP02qRTnRtb1rJ4cNJavxtG7wk3a3tSlOiudWwhXcp0KHWqnXHzHlDgfwZ
         FQHqxD4YiCYElMCZofPXCXir1rI/4XLPqswZepRjVfdiciC/SXMd1UAhdmoBKCQZAnFA
         ZaLmza9X0kwf+wfdC3Pycq1HNKT9/0Fca+o+wH5LNxEWG75fLe1C4fUqyn3w3ylzfTr1
         JO2PphYw6wo9RWx2OS6EzxADWo39/k327lFSkB3scV6+OT6/lyWhrM7ivFli7ZVc2F5q
         GSlPbZe03ecr2QBihYTeovJ+9jgpTPooYZh3V9gE/QMbDkB9AUgiTrNXoo862BZl5Weq
         n1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+f9tMcztypYTJErs8jCKoHKno97PRfBI4us/WusXC6M=;
        b=ADlidYzvnsAGuHnjoIts/stzNUUlQf7JbKHMRbCIW6l9H67Lz3rjzhXLAU/XW2346B
         cyvHdNVsykehrs01l0BwcE5G0xyTkPQ3ccccqMlNKZGPG4FZgBxNGf56f7OKxFRfHOuR
         jyXg6XQeAGdrJS24EJf0rYZCWywZ3nTBXd8Dd1tkRVjp1kUh6mJw3iIRxnguHhSUDUzY
         +0uWsyEMi7Il2bz6N669tvaI7U9U2vUxX2BkxoZktMzRkknpeneQ9pRqK+qynKJ3K/uT
         DElVXSxwom90M3mEt8CvtjtAFMA2PAoTJyrZ+rORfR3hwnFAgSO/0T7Y7M+hWbIh6WXr
         FgYw==
X-Gm-Message-State: AOAM530I/AjlowngZ1YbflotO97RlkFxxQbXWp4/XLDGdHiN+DOjG/aI
        AFdnpNx/HTf7myZ09LwvQxA=
X-Google-Smtp-Source: ABdhPJyCau9G2Gjn6eGoo/A1/STE9A73lLQk33pFaH12vpwbWqO0rZaFSZnN9vSJLp9eg1kNhqt5hw==
X-Received: by 2002:a1c:4e03:0:b0:380:d3cc:61c9 with SMTP id g3-20020a1c4e03000000b00380d3cc61c9mr12486226wmh.193.1646048370903;
        Mon, 28 Feb 2022 03:39:30 -0800 (PST)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id e22-20020adf9bd6000000b001eda1017861sm10584592wrc.64.2022.02.28.03.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 03:39:30 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        containers@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/6] fs: report per-mount io stats
Date:   Mon, 28 Feb 2022 13:39:08 +0200
Message-Id: <20220228113910.1727819-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228113910.1727819-1-amir73il@gmail.com>
References: <20220228113910.1727819-1-amir73il@gmail.com>
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

Show optional collected per-mount io stats in /proc/<pid>/mountstats
for filesystems that do not implement their own show_stats() method
and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/mount.h          |  1 +
 fs/namespace.c      |  2 ++
 fs/proc_namespace.c | 13 +++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index f98bf4cd5b1a..2ab6308af78b 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -91,6 +91,7 @@ struct mount {
 	int mnt_id;			/* mount identifier */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
+	time64_t mnt_time;		/* time of mount */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
 } __randomize_layout;
diff --git a/fs/namespace.c b/fs/namespace.c
index 3fb8f11a42a1..546f07ed44c5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -220,6 +220,8 @@ static struct mount *alloc_vfsmnt(const char *name)
 		mnt->mnt_count = 1;
 		mnt->mnt_writers = 0;
 #endif
+		/* For proc/<pid>/mountstats */
+		mnt->mnt_time = ktime_get_seconds();
 
 		INIT_HLIST_NODE(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 49650e54d2f8..d744fb8543f5 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -232,6 +232,19 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 	if (sb->s_op->show_stats) {
 		seq_putc(m, ' ');
 		err = sb->s_op->show_stats(m, mnt_path.dentry);
+	} else if (mnt_has_stats(mnt)) {
+		/* Similar to /proc/<pid>/io */
+		seq_printf(m, "\n"
+			   "\ttimes: %lld %lld\n"
+			   "\trchar: %lld\n"
+			   "\twchar: %lld\n"
+			   "\tsyscr: %lld\n"
+			   "\tsyscw: %lld\n",
+			   r->mnt_time, ktime_get_seconds(),
+			   mnt_iostats_counter_read(r, MNTIOS_CHARS_RD),
+			   mnt_iostats_counter_read(r, MNTIOS_CHARS_WR),
+			   mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_RD),
+			   mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_WR));
 	}
 
 	seq_putc(m, '\n');
-- 
2.25.1

