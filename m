Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0B132C92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgAGRIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:08:50 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:34491 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:08:49 -0500
Received: by mail-il1-f193.google.com with SMTP id s15so228392iln.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkTeT9dMuqRE2KnIp/DqwjMGpbw3/baJ/fs0la8Y1qc=;
        b=e4Oe1q5gukYZz4HLHJcP6sglwTrktCOMxAAPST6QfcGz7NxrErwBGE6xIP9lxOebY0
         ccgTmPSaUWXBw76LhVNeel+2SlDFxwEQuYa32lJCbnCmG5vK9iZJNfV/HCchSdl5EHKT
         KGESbl/h9TfwlCmso8yTFdXFqTSREyKPdhU2w4eLhNMYsZ/wEb39x98wWDuc+MMdTG81
         QEagAvCa6KByOhucSeGCywEbTz40MqSOv8Yfkre3rrspXlU9EeO34hmfy8/JD8JodC3r
         pTjpoAVzbh7xLU8K0Mwz+F0XTTolXrsgl8juybiCAWCFdEZvf246r29cZh+1+xvG+bja
         XhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkTeT9dMuqRE2KnIp/DqwjMGpbw3/baJ/fs0la8Y1qc=;
        b=H8YOs8ApkRQX1Mt12zN1q+1KKCYJSbs6LBkHDDeajsq2IQ4ANTgHbJfq0kNUdZP2Jp
         0nL8r/MjSXruX9lAlTnlh/h55t8VEl2GrWYM4Bfcz4uT6Jmb2cQMmyzLWLDeopVG87Ab
         Z9iCPV5K+V7m7VDFAKIkoJPWdZDD1BF3Y+RRAQFqmOvx2wyxekTuHjXVGVpwdHE9iVwD
         M8vmdVwmHwXd5yGvSyhyzCAk1EDbo/8R8efdmDdHSDbuIsXrM/KXp9JKRpY7mCwlj5G6
         Lok5s/0p1vpf8LwYQNG1sgHhcD9dsmEMXNqYUP24vcEM1pU1wtWzgQ5uTy246ILFuU+I
         NB/A==
X-Gm-Message-State: APjAAAVkU3PvdjX4rkoMTlCHk4obSP3b0aFgmVf06I7anOOHIs2h66tZ
        wItLQXELD83NdB8Y89x9mXd/Wg==
X-Google-Smtp-Source: APXvYqxMgg8kBG7Lt3o7312cVCkomC/XW4qdyrEWa1cdfvlnQCkx3pqt4i1CW34sGwSd6IAm8MNjZg==
X-Received: by 2002:a92:58d7:: with SMTP id z84mr14367ilf.179.1578416437866;
        Tue, 07 Jan 2020 09:00:37 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm42547iln.81.2020.01.07.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:00:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/6] fs: add namei support for doing a non-blocking path lookup
Date:   Tue,  7 Jan 2020 10:00:29 -0700
Message-Id: <20200107170034.16165-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107170034.16165-1-axboe@kernel.dk>
References: <20200107170034.16165-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the fast lookup fails, then return -EAGAIN to have the caller retry
the path lookup. Assume that a dentry having any of:

->d_revalidate()
->d_automount()
->d_manage()

could block in those callbacks. Preemptively return -EAGAIN if any of
these are present.

This is in preparation for supporting non-blocking open.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c            | 21 ++++++++++++++++++++-
 include/linux/namei.h |  2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index b367fdb91682..ed108a41634f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1641,6 +1641,17 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	return dentry;
 }
 
+static inline bool lookup_could_block(struct dentry *dentry, unsigned int flags)
+{
+	const struct dentry_operations *ops = dentry->d_op;
+
+	if (!ops || !(flags & LOOKUP_NONBLOCK))
+		return 0;
+
+	/* assume these dentry ops may block */
+	return ops->d_revalidate || ops->d_automount || ops->d_manage;
+}
+
 static int lookup_fast(struct nameidata *nd,
 		       struct path *path, struct inode **inode,
 		       unsigned *seqp)
@@ -1665,6 +1676,9 @@ static int lookup_fast(struct nameidata *nd,
 			return 0;
 		}
 
+		if (unlikely(lookup_could_block(dentry, nd->flags)))
+			return -EAGAIN;
+
 		/*
 		 * This sequence count validates that the inode matches
 		 * the dentry name information from lookup.
@@ -1707,7 +1721,10 @@ static int lookup_fast(struct nameidata *nd,
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return 0;
-		status = d_revalidate(dentry, nd->flags);
+		if (unlikely(lookup_could_block(dentry, nd->flags)))
+			status = -EAGAIN;
+		else
+			status = d_revalidate(dentry, nd->flags);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
@@ -1912,6 +1929,8 @@ static int walk_component(struct nameidata *nd, int flags)
 	if (unlikely(err <= 0)) {
 		if (err < 0)
 			return err;
+		if (nd->flags & LOOKUP_NONBLOCK)
+			return -EAGAIN;
 		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
 					  nd->flags);
 		if (IS_ERR(path.dentry))
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 4e77068f7a1a..392eb439f88b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 /* LOOKUP_* flags which do scope-related checks based on the dirfd. */
 #define LOOKUP_IS_SCOPED (LOOKUP_BENEATH | LOOKUP_IN_ROOT)
 
+#define LOOKUP_NONBLOCK		0x200000 /* don't block for lookup */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.24.1

