Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521E22DA014
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 20:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgLNTOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 14:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439834AbgLNTOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:14:17 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05161C061793
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id n4so17979196iow.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eErfZhcM70ZZqvloxWZ8BUhglfgk7CIfMQqCeYN0MEQ=;
        b=DULW0PdyKe7iTWA4J5RQgXlizOy2dkjY4EXbm5Z9DKvzwRlV3978QpkQjfegjxy9z4
         qJ5YQhEAWcJ9mQv6KeFAS25g+try+xGMekdQwi4dBrjTFbCpf/l8pR0+4fSq/kIBDjqk
         KLHNDO877uI4bTmM1EDzE8Vk0Esg6tw+BwT5iyaZ68hGwCU5JptRAhzq/EZUyehBFTAA
         0DfAxs09TSMJ1u2t3o8YQB+anudGn+Hh9dt8RSisAdk5R+mHIQ2proapWKRib+DeTV+H
         06Uxs9q26Pn8waZa7jKWpKcC+1qCZSFR3ij2iKBRlqwQa3BosutMpO0puDDH0apWWvnd
         eFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eErfZhcM70ZZqvloxWZ8BUhglfgk7CIfMQqCeYN0MEQ=;
        b=AlJg1vvTbse3Nv/qzWQb91xH5VSBALZDy+nHv7icUuOT4JAGIO9dJ7SVBeyM9l23VN
         JhlN4v1AIMJ0bMa5xUptb7eEWgxnBEtL2YueH8M05iLNjzHufEFRbi0dEEo9+yI+DIBF
         x2D5Wn3JmkoUGtaqkmmSzWt4nYrLCDKaTJuv/vZwOzyuP55FHq/8ubzdyEU18u1LFPLm
         Z1ezo8qn9nsEvOu5ihPr7LfkcTawAqSPvIczVW6iXccmzT0g87iN1yZ+KjD1ULTADO39
         xuIqUL5o3e4pvaQTlB1cpYC1n/S8sKLAhx4tlIK5TxU1pgz+nZqFlXVouixYZjeUsTzq
         5Jhg==
X-Gm-Message-State: AOAM531II9E+C90dmj7uz6e9xWpVqtVEJAj879NRje7wwv6BdAQ3BtXg
        OH0VU7UQe6/u9mpwIW6/IFZVjUG0wGfq3g==
X-Google-Smtp-Source: ABdhPJxDH4EVvuL/niFklJujxx17TqS6wRLlX043oU8n4JyE7WGiPzgiwUlgr1iqGSwCn2SoxyzpLA==
X-Received: by 2002:a5e:a815:: with SMTP id c21mr32241787ioa.141.1607973216093;
        Mon, 14 Dec 2020 11:13:36 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 11sm11760566ilt.54.2020.12.14.11.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:13:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] fs: add support for LOOKUP_NONBLOCK
Date:   Mon, 14 Dec 2020 12:13:22 -0700
Message-Id: <20201214191323.173773-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
References: <20201214191323.173773-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

io_uring always punts opens to async context, since there's no control
over whether the lookup blocks or not. Add LOOKUP_NONBLOCK to support
just doing the fast RCU based lookups, which we know will not block. If
we can do a cached path resolution of the filename, then we don't have
to always punt lookups for a worker.

We explicitly disallow O_CREAT | O_TRUNC opens, as those will require
blocking, and O_TMPFILE as that requires filesystem interactions and
there's currently no way to pass down an attempt to do nonblocking
operations there. This basically boils down to whether or not we can
do the fast path of open or not. If we can't, then return -EAGAIN and
let the caller retry from an appropriate context that can handle
blocking.

During path resolution, we always do LOOKUP_RCU first. If that fails and
we terminate LOOKUP_RCU, then fail a LOOKUP_NONBLOCK attempt as well.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 27 ++++++++++++++++++++++++++-
 include/linux/namei.h |  1 +
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 7eb7830da298..83a7f7866232 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -686,6 +686,8 @@ static bool try_to_unlazy(struct nameidata *nd)
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_NONBLOCK)
+		goto out1;
 	if (unlikely(!legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
@@ -722,6 +724,8 @@ static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned se
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
 	nd->flags &= ~LOOKUP_RCU;
+	if (nd->flags & LOOKUP_NONBLOCK)
+		goto out2;
 	if (unlikely(!legitimize_links(nd)))
 		goto out2;
 	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
@@ -792,6 +796,7 @@ static int complete_walk(struct nameidata *nd)
 		 */
 		if (!(nd->flags & (LOOKUP_ROOT | LOOKUP_IS_SCOPED)))
 			nd->root.mnt = NULL;
+		nd->flags &= ~LOOKUP_NONBLOCK;
 		if (!try_to_unlazy(nd))
 			return -ECHILD;
 	}
@@ -2202,6 +2207,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	int error;
 	const char *s = nd->name->name;
 
+	/* LOOKUP_NONBLOCK requires RCU, ask caller to retry */
+	if ((flags & (LOOKUP_RCU | LOOKUP_NONBLOCK)) == LOOKUP_NONBLOCK)
+		return ERR_PTR(-EAGAIN);
+
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
 	if (flags & LOOKUP_RCU)
@@ -3140,6 +3149,12 @@ static const char *open_last_lookups(struct nameidata *nd,
 			return ERR_CAST(dentry);
 		if (likely(dentry))
 			goto finish_lookup;
+		/*
+		 * We can't guarantee nonblocking semantics beyond this, if
+		 * the fast lookup fails.
+		 */
+		if (nd->flags & LOOKUP_NONBLOCK)
+			return ERR_PTR(-EAGAIN);
 
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
@@ -3233,6 +3248,7 @@ static int do_open(struct nameidata *nd,
 		open_flag &= ~O_TRUNC;
 		acc_mode = 0;
 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
+		WARN_ON_ONCE(nd->flags & LOOKUP_NONBLOCK);
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return error;
@@ -3299,7 +3315,16 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 {
 	struct dentry *child;
 	struct path path;
-	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
+	int error;
+
+	/*
+	 * We can't guarantee that the fs doesn't block further down, so
+	 * just disallow nonblock attempts at O_TMPFILE for now.
+	 */
+	if (flags & LOOKUP_NONBLOCK)
+		return -EAGAIN;
+
+	error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
 	if (unlikely(error))
 		return error;
 	error = mnt_want_write(path.mnt);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a4bb992623c4..c36c4e0805fc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -46,6 +46,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_NO_XDEV		0x040000 /* No mountpoint crossing. */
 #define LOOKUP_BENEATH		0x080000 /* No escaping from starting point. */
 #define LOOKUP_IN_ROOT		0x100000 /* Treat dirfd as fs root. */
+#define LOOKUP_NONBLOCK		0x200000 /* don't block for lookup */
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
-- 
2.29.2

