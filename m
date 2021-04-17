Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9A362C52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhDQALC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 20:11:02 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:47035 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbhDQALA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:11:00 -0400
Received: by mail-pf1-f182.google.com with SMTP id d124so19338434pfa.13;
        Fri, 16 Apr 2021 17:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ao1TqPYuNX1M0mXjxJ3GFwDA7rWIlPfE84JbdJJr5OA=;
        b=RPO5LSP1zuZZ4huXHLA8cMRNlXmnSjyMNHaFhLTUwnc/JN9MmH5HijDGKwhB0nYGfD
         5F32atoRSsDGJJd1CjHkBXrUFDf3X6/YrYS9oeq5UJku7SwNJfhwX9Sv6ekxzTdCjF1j
         EH5Q1tr0PSPfp/db0XMzL0sMLC5thDFudhuriOkMUrQ7dol4vM2x011k+jzV0wnez04B
         ZyZhD1+zOtUDGjzabg1M/PydjPh9r980lJaGjTzsFOsfbtfTnD2cAW9sWx2K8h9/wSWE
         AC2/q7Tb1BOO5W1vpa4kcpUg9Aoz/n+7BweflG1vt3kTOzPWNEG1SsK7PMqN3SIbK08Z
         eI1g==
X-Gm-Message-State: AOAM5331tVH75p5h7UCfgv26lu1EZuR12Difw6PNUqqO4k4amuLl2BF5
        AjSBvp+t2LOAfKWhlKq25Us=
X-Google-Smtp-Source: ABdhPJwTC+RAeTjahOoDPtRcvq+Jfl0m8X/KKO4KGgtDtLLj/0omvDnshJfd5dmHsNSF9+akcVmhhQ==
X-Received: by 2002:a63:e30a:: with SMTP id f10mr1312689pgh.167.1618618234447;
        Fri, 16 Apr 2021 17:10:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o134sm5417667pfd.66.2021.04.16.17.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 17:10:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 484E441C23; Sat, 17 Apr 2021 00:10:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 5/6] fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
Date:   Sat, 17 Apr 2021 00:10:25 +0000
Message-Id: <20210417001026.23858-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210417001026.23858-1-mcgrof@kernel.org>
References: <20210417001026.23858-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are use cases where we wish to traverse the superblock list
but also capture errors, and in which case we want to avoid having
our callers issue a lock themselves since we can do the locking for
the callers. Provide a iterate_supers_excl() which calls a function
with the write lock held. If an error occurs we capture it and
propagate it.

Likewise there are use cases where we wish to traverse the superblock
list but in reverse order. The new iterate_supers_reverse_excl() helpers
does this but also also captures any errors encountered.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 +
 2 files changed, 93 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 53106d4c7f56..2a6ef4ec2496 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -705,6 +705,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	spin_unlock(&sb_lock);
 }
 
+/**
+ *	iterate_supers_excl - exclusively call func for all active superblocks
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument. Returns 0 unless an error
+ *	occurred on calling the function on any superblock.
+ */
+int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
+/**
+ *	iterate_supers_reverse_excl - exclusively calls func in reverse order
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument, in reverse order, and holding
+ *	the s_umount write lock. Returns if an error occurred.
+ */
+int iterate_supers_reverse_excl(int (*f)(struct super_block *, void *),
+					 void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
 /**
  *	iterate_supers_type - call function for superblocks of given type
  *	@type: fs type
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6980e709e94a..0f4d624f0f3f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3442,6 +3442,8 @@ extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
+extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.29.2

