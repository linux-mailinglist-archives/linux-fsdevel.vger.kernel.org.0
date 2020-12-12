Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF592D8871
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407680AbgLLQwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405951AbgLLQv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:51:57 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5A3C061793
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:17 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lj6so2508240pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTka/gpM64k/H7yRLstKZFGJk0r4OmXli/cCm+jSN2I=;
        b=YI4UOEoSrYqL2SQF5uzul8hd8gHkG76ZWTU4YGdGrqYHXjSD2gWqk0eNdj/CSxwkd1
         H72EbdOohorQTaHOhjOgjxqPxlBsqurA45LhdvWPoN/4KuiECfQBUQZlsLTYG22Ivag+
         UYaP6I32RGIfEG9tiStfbF0CjotP2Hpeec85RzM6ShxVgsxGufpxeI+SsIUkeDPXPEuw
         wV7ENWShhY0IW3ijUD9609kpNKn3f4SR9+L3qeUyeZ8ZixEVzDEHrvyTeH+oTvtzx202
         Eg9yVo36WVqh0XvY87Y674obWsqPbIeBnP7io4SP2VaBf6YS8rlg0Fbtp18on7g4qxan
         8JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTka/gpM64k/H7yRLstKZFGJk0r4OmXli/cCm+jSN2I=;
        b=RS+ZP09pxDr0c5su0qmGYKP2Ds438Bwn1L2oLncLP8lQp7EZBZJevV33zmH5+noM35
         25Bo7kmWxyvVUsbZEgy5+ESoeQWHjwL5Ai3fZFgmUcoNmNypRZCVN4TXZ/JB9KPlAbXz
         WRPQzDwtGyOnIRTF8YhHlNQXDttBqiLLxCCVUnEID/RVaD7kWCFe3Wzf1zqLxGfWR/3H
         GTJ40Cr99BHXdjIR+ZGHE8+abYSgykZBdKZPXoEM4uLnISpdq/8PHBkhge5+lqfsSYNL
         9VQ93IymElSVx74DFGbjW6u1+B3aDfJsAotc6HlYIBaCtBBGFCbGjHkQCSvAWDia5UsS
         Db/A==
X-Gm-Message-State: AOAM531QoVBZVPJKOQzCKytaiIyNrH9S/7uxh1fiRrGgNrzIxHaxG6zf
        YE/0GD683RHPmamgSjEPuCSMkkZwJXhU9g==
X-Google-Smtp-Source: ABdhPJw3/r5x8pvaInMYvJmCE5bzsm0V4ctUb8EA2WRVTatl4tefhaPU8/dQ3MwANxJ5JluG827ycA==
X-Received: by 2002:a17:902:bcca:b029:da:61e3:a032 with SMTP id o10-20020a170902bccab02900da61e3a032mr15779975pls.63.1607791876678;
        Sat, 12 Dec 2020 08:51:16 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] fs: add mnt_want_write_trylock()
Date:   Sat, 12 Dec 2020 09:51:03 -0700
Message-Id: <20201212165105.902688-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165105.902688-1-axboe@kernel.dk>
References: <20201212165105.902688-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

trylock variant of mnt_want_write() - this ends up being pretty trivial,
as we already have a trylock variant of the sb_start_write() helper.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namespace.c        | 18 ++++++++++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..7881cb5595af 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -359,6 +359,24 @@ int mnt_want_write(struct vfsmount *m)
 }
 EXPORT_SYMBOL_GPL(mnt_want_write);
 
+/**
+ * mnt_want_write_trylock - try to get write access to a mount
+ * @m: the mount on which to take a write
+ *
+ * trylock variant of @mnt_want_write. See description above.
+ */
+int mnt_want_write_trylock(struct vfsmount *m)
+{
+	int ret;
+
+	if (!sb_start_write_trylock(m->mnt_sb))
+		return -EAGAIN;
+	ret = __mnt_want_write(m);
+	if (ret)
+		sb_end_write(m->mnt_sb);
+	return ret;
+}
+
 /**
  * mnt_clone_write - get write access to a mount
  * @mnt: the mount on which to take a write
diff --git a/include/linux/mount.h b/include/linux/mount.h
index aaf343b38671..e267e622d843 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -78,6 +78,7 @@ struct file; /* forward dec */
 struct path;
 
 extern int mnt_want_write(struct vfsmount *mnt);
+extern int mnt_want_write_trylock(struct vfsmount *mnt);
 extern int mnt_want_write_file(struct file *file);
 extern int mnt_clone_write(struct vfsmount *mnt);
 extern void mnt_drop_write(struct vfsmount *mnt);
-- 
2.29.2

