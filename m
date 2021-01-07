Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5892EE7C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 22:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAGVov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 16:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhAGVou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:44:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC537C0612FE
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 13:44:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q18so7078187wrn.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 13:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tedZkGRz19E+gSb1Lsnaa3e326cdPd1VuGpkvijDJns=;
        b=jQyWA2z2Ddq58oUb6ByQEmGcpSq/04U5lI2bFLW8kTIL8OI5PhTAKg0DVNyq7YX98u
         RX7CoXQxW3k293D+yWA68dabNzWBK1nD53zzNFAJnwfqHSosZZ0iNc/FHW4sYPi6YNyz
         /S/0sPMr1LvKlpXYktNNIIAOoY+DMB1Tp9kEiqVTFJYnZjqKugqp0w+Jnik/cfa+m8iX
         SkRTZO4Na5ZvpRk2+1ADtTAgtP/bOJShLXYuJ6FeHfXw28NkziLjR+rmtyfDkgHMj1Kw
         q0vU0Qn3LLUXdqAsvuJqLKlNY4ioim8c6x4MS42KXj+tYbP9QiKYl/clgRVpwPO2XK1H
         TcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tedZkGRz19E+gSb1Lsnaa3e326cdPd1VuGpkvijDJns=;
        b=ONdWbkH2D7KdmGkz5nO5iZpQ1/P8UJSDEPlZVe1iBdusi637tOXAD67siL9ZSfnsoH
         cIQd8i2Mj134m0ZRLZrUkj8lLUFAuCyTLXODkcDMecAxZxFXu5tjiY8swwaGCcHFEzU9
         5K6yHKY4ajgVVEESZcIP4wIgozLuhkJnhexNPPipRl6LMhGDj3LlTxAZ4R2k/hJecFYN
         QXA7cwkXrbsgYW06GWIJZjBQr1GpDNzRQMqn3Jpa9yFmpnEFh5aiFxUyk+eNy9ZE3mf8
         tbsvNnBSxd4QjuL63+n1zrZRvIBBni0wDhUlGhy0FNMqHHlr2tLzrPCcgHHk9qpwZIdz
         6OMQ==
X-Gm-Message-State: AOAM532XmJ8QzLAyhteb87mTZn/WdSOuP2VLMnR6+e/RejoeN/ya5oG/
        QTE+snPGjvtePpHrGJNDRGGOyL3BxBk=
X-Google-Smtp-Source: ABdhPJz1HRpeGn83ETPj4RSIkH+x6QZHvh8WCsaSTbctuVhBZk9ms7q0v7aAWfjaDCGby4NsXUXPIw==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr609140wrq.18.1610055847696;
        Thu, 07 Jan 2021 13:44:07 -0800 (PST)
Received: from localhost.localdomain ([31.210.181.203])
        by smtp.gmail.com with ESMTPSA id g1sm10084997wrq.30.2021.01.07.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:44:07 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/3] fs: report per-mount io stats
Date:   Thu,  7 Jan 2021 23:44:01 +0200
Message-Id: <20210107214401.249416-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107214401.249416-1-amir73il@gmail.com>
References: <20210107214401.249416-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Show optional collected per-mount io stats in /proc/<pid>/mountstats
for filesystems that do not implement their own show_stats() method.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

See following snippet from mountstats example report:

device overlay mounted on /mnt with fstype overlay
	times: 125 153
	rchar: 12
	wchar: 0
	syscr: 2
	syscw: 0

Thanks,
Amir.

 fs/mount.h          |  1 +
 fs/namespace.c      |  2 ++
 fs/proc_namespace.c | 13 +++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 81db83c36140..1f262892a6ed 100644
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
index 04b35dfcc71f..3a91234e5fd0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -198,6 +198,8 @@ static struct mount *alloc_vfsmnt(const char *name)
 		mnt->mnt_count = 1;
 		mnt->mnt_writers = 0;
 #endif
+		/* For proc/<pid>/mountstats */
+		mnt->mnt_time = ktime_get_seconds();
 
 		INIT_HLIST_NODE(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index eafb75755fa3..34aea7f3f550 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -229,6 +229,19 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
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

