Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23EE43DE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJ1Jux (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 05:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhJ1Jut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:50:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50001C061745
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 02:48:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so9055086wrv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDEJin9Wub/pTmZCaG0ahvo3TESho8nP0MZ/DG5F4bU=;
        b=Fq7FjlAbZV5zR/iWtDoqRfxsQKOz3/NHuIDK/MgY5Uz+X8Bzve19JOmFMCKZtHnc6C
         3JxZxqr5idu9by/1C9tNk29r5SoxWsPFNh4ZvUOyQuzMqlwxlTBnfcpI7COiVFzwU5i7
         Kh46iOm6VO6gPmtmj2vn2dabUejlwv7uesL9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDEJin9Wub/pTmZCaG0ahvo3TESho8nP0MZ/DG5F4bU=;
        b=a4fsuBgIuQ3w/innWcd6JsSXszddVBOhsKSvjGfm3rwu6wcpVpK+MdYNUinA8SoyI9
         3l4Ualp5T7eBrdxPWjh+1W79m5ldwy4Atho7aO3zpwHCZDnL2bJ3KYFPeL7SJWBkPoFg
         jQzrVpbItAqViAeFM2vsLQFlajfS33MAjhClXzB2eLhl6nrYmisKacVwTa8KAlFnyUWT
         KXTb+1X2bpPEanaJw8R0aGBYrf2FW+aYl4VcxL6hmgVpHjNJCuc1VpVOedE8OYrMdco2
         noiZ/qQIwxcP5xSOWGS4I+YTIyquVDFAKxjEGTjGmMXM6mcfBZdoub/thHaLiyG/32nY
         QB/A==
X-Gm-Message-State: AOAM530LI9/CufDg8YqIvE/Bf2Tgx+9suv8+IImaM15k4wavMqPpV+SC
        ihMxXUTVwUqe+tUC469UCPAE0ltm0UclAg==
X-Google-Smtp-Source: ABdhPJzuPEadJHFC6DHS+OKXKCrBNBoHbYtFLfXrapFarUbsAE/PiuGk7n5gPew0+g/APt+J5HIwJA==
X-Received: by 2002:a5d:4d52:: with SMTP id a18mr4233102wru.406.1635414500859;
        Thu, 28 Oct 2021 02:48:20 -0700 (PDT)
Received: from altair.lan (2.f.6.6.b.3.3.0.3.a.d.b.6.0.6.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:606:bda3:33b:66f2])
        by smtp.googlemail.com with ESMTPSA id i6sm3378029wry.71.2021.10.28.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:48:20 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     viro@zeniv.linux.org.uk, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     mszeredi@redhat.com, gregkh@linuxfoundation.org,
        Lorenz Bauer <lmb@cloudflare.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] libfs: move shmem_exchange to simple_rename_exchange
Date:   Thu, 28 Oct 2021 10:47:21 +0100
Message-Id: <20211028094724.59043-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028094724.59043-1-lmb@cloudflare.com>
References: <20211028094724.59043-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move shmem_exchange and make it available to other callers.

Suggested-by: <mszeredi@redhat.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 fs/libfs.c         | 24 ++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 mm/shmem.c         | 24 +-----------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 51b4de3b3447..1cf144dc9ed2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -448,6 +448,30 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_rmdir);
 
+int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
+			   struct inode *new_dir, struct dentry *new_dentry)
+{
+	bool old_is_dir = d_is_dir(old_dentry);
+	bool new_is_dir = d_is_dir(new_dentry);
+
+	if (old_dir != new_dir && old_is_dir != new_is_dir) {
+		if (old_is_dir) {
+			drop_nlink(old_dir);
+			inc_nlink(new_dir);
+		} else {
+			drop_nlink(new_dir);
+			inc_nlink(old_dir);
+		}
+	}
+	old_dir->i_ctime = old_dir->i_mtime =
+	new_dir->i_ctime = new_dir->i_mtime =
+	d_inode(old_dentry)->i_ctime =
+	d_inode(new_dentry)->i_ctime = current_time(old_dir);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(simple_rename_exchange);
+
 int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		  struct dentry *old_dentry, struct inode *new_dir,
 		  struct dentry *new_dentry, unsigned int flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..333b8af405ce 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3383,6 +3383,8 @@ extern int simple_open(struct inode *inode, struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
+extern int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
+				  struct inode *new_dir, struct dentry *new_dentry);
 extern int simple_rename(struct user_namespace *, struct inode *,
 			 struct dentry *, struct inode *, struct dentry *,
 			 unsigned int);
diff --git a/mm/shmem.c b/mm/shmem.c
index b5860f4a2738..a18dde3d3092 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2945,28 +2945,6 @@ static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 	return shmem_unlink(dir, dentry);
 }
 
-static int shmem_exchange(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry)
-{
-	bool old_is_dir = d_is_dir(old_dentry);
-	bool new_is_dir = d_is_dir(new_dentry);
-
-	if (old_dir != new_dir && old_is_dir != new_is_dir) {
-		if (old_is_dir) {
-			drop_nlink(old_dir);
-			inc_nlink(new_dir);
-		} else {
-			drop_nlink(new_dir);
-			inc_nlink(old_dir);
-		}
-	}
-	old_dir->i_ctime = old_dir->i_mtime =
-	new_dir->i_ctime = new_dir->i_mtime =
-	d_inode(old_dentry)->i_ctime =
-	d_inode(new_dentry)->i_ctime = current_time(old_dir);
-
-	return 0;
-}
-
 static int shmem_whiteout(struct user_namespace *mnt_userns,
 			  struct inode *old_dir, struct dentry *old_dentry)
 {
@@ -3012,7 +2990,7 @@ static int shmem_rename2(struct user_namespace *mnt_userns,
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
-		return shmem_exchange(old_dir, old_dentry, new_dir, new_dentry);
+		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
 
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
-- 
2.32.0

