Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B71539A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbiFABL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFABLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:11:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924F941B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i185so430931pge.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zB4k8HCgWXfZMWhhHx3oaP+QO4uDjlOYW5CoGqwerk=;
        b=Lbq7WXgQ/WC3otO2Va6VnCJPaH/mjOaNwN17SFcjO6TTUjkrrWkXKU4/I7E8aSOylz
         rygmw+G6kHV1S7NEhQtCElRekSTDNEoEdDkORdvEPnh5Iri8rR/f2iuW1o+F2zc6bU/o
         C0/HWydp8AK1kopJfiZ4dy+RMO8dwKo1J5t3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zB4k8HCgWXfZMWhhHx3oaP+QO4uDjlOYW5CoGqwerk=;
        b=ii6WzUKOS5Z4foqhYXFZdwbENU72wb6NjqWBoQTLRBE9JJ90/yoaE1JSU/ws1hvRFk
         Z62yJLCM34D0JWsWFoONwJPPbS/G+lR0Xbgx9uy1HtXe3rR9OsjIugKWQ3N0lmNx94NK
         EJEeOTjO6Y/bpisc3BQL6kVWevWPJ8kCgpFtPhMfZTtyTuHkqLkoQ/0TuDAgRFPPDcQ0
         5p6hvuvajHT4L+hBf0e3fhKfCY0wfq73RTPkfZJR67//+TVREpCznWdo8rQDCl2mVcCk
         Jvt9Dc4YAoyOkjLhxaRfgtzDz/bqCVvEwfvaRpblKamwC8LvjqhTW0G4lhaBBLQP5AQs
         mnzw==
X-Gm-Message-State: AOAM532v/AvuNmxNDTeV0Iujhuc8icqccO475XjE0NVJljMGLnyhdKRF
        kFlT5iHDAmNEwQF2NDLXIzI6zEgTCHfDYA==
X-Google-Smtp-Source: ABdhPJww89xHjaZSrTlsmpVQ0UyZtfG7Ef/34KraF0X8f2jl92sSxYe4IW8cr5SOURKUegrj11fg8A==
X-Received: by 2002:a63:401:0:b0:3fc:8810:f0ae with SMTP id 1-20020a630401000000b003fc8810f0aemr2585858pge.335.1654045880991;
        Tue, 31 May 2022 18:11:20 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id mi16-20020a17090b4b5000b001df6173700dsm2621916pjb.49.2022.05.31.18.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:11:20 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
X-Google-Original-From: Daniil Lunev <dlunev@google.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@chromium.org>,
        Daniil Lunev <dlunev@google.com>
Subject: [PATCH v4 1/2] fs/super: function to prevent super re-use
Date:   Wed,  1 Jun 2022 11:11:02 +1000
Message-Id: <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220601011103.12681-1-dlunev@google.com>
References: <20220601011103.12681-1-dlunev@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniil Lunev <dlunev@chromium.org>

The function is to be called from filesystem-specific code to mark a
superblock to be ignored by superblock test and thus never re-used. The
function also unregisters bdi if the bdi is per-superblock to avoid
collision if a new superblock is created to represent the filesystem.
generic_shutdown_super() skips unregistering bdi for a retired
superlock as it assumes retire function has already done it.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
Signed-off-by: Daniil Lunev <dlunev@google.com>
---

Changes in v4:
- Simplify condition according to Christoph Hellwig's comments.

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

 fs/super.c         | 28 ++++++++++++++++++++++++++--
 include/linux/fs.h |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d6..3fb9fc8d61160 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -422,6 +422,30 @@ bool trylock_super(struct super_block *sb)
 	return false;
 }
 
+/**
+ *	retire_super	-	prevernts superblock from being reused
+ *	@sb: superblock to retire
+ *
+ *	The function marks superblock to be ignored in superblock test, which
+ *	prevents it from being reused for any new mounts. If the superblock has
+ *	a private bdi, it also unregisters it, but doesn't reduce the refcount
+ *	of the superblock to prevent potential races. The refcount is reduced
+ *	by generic_shutdown_super(). The function can not be called concurrently
+ *	with generic_shutdown_super(). It is safe to call the function multiple
+ *	times, subsequent calls have no effect.
+ */
+void retire_super(struct super_block *sb)
+{
+	down_write(&sb->s_umount);
+	if (sb->s_iflags & SB_I_PERSB_BDI) {
+		bdi_unregister(sb->s_bdi);
+		sb->s_iflags &= ~SB_I_PERSB_BDI;
+	}
+	sb->s_iflags |= SB_I_RETIRED;
+	up_write(&sb->s_umount);
+}
+EXPORT_SYMBOL(retire_super);
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -1216,7 +1240,7 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return s->s_bdev == fc->sget_key;
+	return !(s->s_iflags & SB_I_RETIRED) && s->s_bdev == fc->sget_key;
 }
 
 /**
@@ -1307,7 +1331,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23a..ef392fd2361bd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1411,6 +1411,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
+#define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 
 /* Possible states of 'frozen' field */
 enum {
@@ -2424,6 +2425,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
+void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
 void kill_anon_super(struct super_block *sb);
-- 
2.31.0

