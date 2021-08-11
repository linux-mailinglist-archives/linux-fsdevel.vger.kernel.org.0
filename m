Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF33E99F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 22:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhHKUtM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhHKUtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:49:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F09C061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:44 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l3so3198592qtk.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=W2ePed7b7Zeoarrg+9WSGsiLd7Tb2w8iYG/B7ulmbOM=;
        b=Q08tdZC3zUhePwuBfcwpZb7XyB3p9/YOLKej65cWgZvCK44GhukGTCy7P4n4N52VJm
         NNSuFNgtNQJscN9oPIk4FKvmUBUhDfiSiD4KkdPD1nSw1AsrnLmmez5MtLCE8H9m991N
         UxIO0taVWsxssJtcZoIKlKCsv4Dstls0LYuB+5dHmvd2mFjEFMXJy0iphSS/e8PYzEmq
         av80NkD/yLdr1S1l049acLbgfGhHZQIZzxFHmRq6EpT/4Fdv2p5gcoJdeLwykGHHNoQ/
         4kvU03H9ff8x32JloScyj8/i7nmbLyVIwzvy1ozlMWUHXUzi5eDt5B/8/oJdnTZFUMFM
         X8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=W2ePed7b7Zeoarrg+9WSGsiLd7Tb2w8iYG/B7ulmbOM=;
        b=FuLjo+6YSEdj5xMjBrcOXLG+1WU97XoipaXvudiHR4x6whsiDmHXMxr1QmwFENqmO8
         4DTwArTGEyD3cuLR/Z3lTVFQcZBjwZpBDWRGvy23GshrfkJsZQ5oP8LjFC/P/+KiKVsy
         4g6Vs+45EYotSXl6R/Cpd7DzlyNS027+hkKUmDC9MqYi0P3PcR49AmVhso7TWiWhUjio
         deXmQUMxZOKLtLkqMxVrkeFZiPGy5Z0ZPVPFfKuMVVIbrxwTQMwHBtV6pUf0Ra31xvhr
         QQU138IJel+v9LFdaEXMV3BbLdF9CEfPWLmz+siY7tyma3yJq3WVjK+4bbk8MNj5TXA4
         K84g==
X-Gm-Message-State: AOAM531UBdsh3H1jRnU6MYc25qukGLQE5VoKnSrOTwYXkGse+UXGGNo2
        fwmcBGXkGsw0twhrf84b5WJr
X-Google-Smtp-Source: ABdhPJzPm7vS80oH9l1MxGpWYzzRAHNbELlSvXDE1HIUCPH+TxQcMwQ+AA8dFa6dTLqb4NNtLM2rUQ==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr625967qtp.32.1628714923930;
        Wed, 11 Aug 2021 13:48:43 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id c68sm178277qkf.48.2021.08.11.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:48:43 -0700 (PDT)
Subject: [RFC PATCH v2 5/9] fs: add anon_inode_getfile_secure() similar to
 anon_inode_getfd_secure()
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 11 Aug 2021 16:48:42 -0400
Message-ID: <162871492283.63873.8743976556992924333.stgit@olly>
In-Reply-To: <162871480969.63873.9434591871437326374.stgit@olly>
References: <162871480969.63873.9434591871437326374.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extending the secure anonymous inode support to other subsystems
requires that we have a secure anon_inode_getfile() variant in
addition to the existing secure anon_inode_getfd() variant.

Thankfully we can reuse the existing __anon_inode_getfile() function
and just wrap it with the proper arguments.

Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v2:
- no change
v1:
- initial draft
---
 fs/anon_inodes.c            |   29 +++++++++++++++++++++++++++++
 include/linux/anon_inodes.h |    4 ++++
 2 files changed, 33 insertions(+)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index a280156138ed..e0c3e33c4177 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -148,6 +148,35 @@ struct file *anon_inode_getfile(const char *name,
 }
 EXPORT_SYMBOL_GPL(anon_inode_getfile);
 
+/**
+ * anon_inode_getfile_secure - Like anon_inode_getfile(), but creates a new
+ *                             !S_PRIVATE anon inode rather than reuse the
+ *                             singleton anon inode and calls the
+ *                             inode_init_security_anon() LSM hook.  This
+ *                             allows for both the inode to have its own
+ *                             security context and for the LSM to enforce
+ *                             policy on the inode's creation.
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags
+ * @context_inode:
+ *           [in]    the logical relationship with the new inode (optional)
+ *
+ * The LSM may use @context_inode in inode_init_security_anon(), but a
+ * reference to it is not held.  Returns the newly created file* or an error
+ * pointer.  See the anon_inode_getfile() documentation for more information.
+ */
+struct file *anon_inode_getfile_secure(const char *name,
+				       const struct file_operations *fops,
+				       void *priv, int flags,
+				       const struct inode *context_inode)
+{
+	return __anon_inode_getfile(name, fops, priv, flags,
+				    context_inode, true);
+}
+
 static int __anon_inode_getfd(const char *name,
 			      const struct file_operations *fops,
 			      void *priv, int flags,
diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
index 71881a2b6f78..5deaddbd7927 100644
--- a/include/linux/anon_inodes.h
+++ b/include/linux/anon_inodes.h
@@ -15,6 +15,10 @@ struct inode;
 struct file *anon_inode_getfile(const char *name,
 				const struct file_operations *fops,
 				void *priv, int flags);
+struct file *anon_inode_getfile_secure(const char *name,
+				       const struct file_operations *fops,
+				       void *priv, int flags,
+				       const struct inode *context_inode);
 int anon_inode_getfd(const char *name, const struct file_operations *fops,
 		     void *priv, int flags);
 int anon_inode_getfd_secure(const char *name,

