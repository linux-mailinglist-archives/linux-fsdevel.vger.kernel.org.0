Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A43F40A48A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 05:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhINDeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbhINDef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:34:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603BC061767
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 20:33:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so10166908qtk.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=yIvUop3P/60QYLtm8bDVCxAY3B7HwxRQ7AkWTc9jkh8=;
        b=UgU+ZGMcIRDHUazzWyvjbnYgPk38HeUD054UfCNUk/5P8rMXNbD5DbpJzY2/NwJnbk
         B+FrHS7LvYvCnLVPoGMgntRSQFOsg9Nl2QuKfmRRuwVlVHaPeLR3hTpWCAdxJD1Tqjxx
         fKv8n0cbftyErcP0rY5NC1WMglM9KHmxLUXmHHwrTVoapBa6SN75vlNjd8L601C/hW+E
         K23NCl8EpLdbAFG+GCr1uW2f2QeqmRPnnT4V3q/Da25J1ItCbI4ajKE4Y6jAo10guLnV
         s7/cYgSka8Q9cSrCPWDyvf+FBqMVkoscIqz/iiVoX61wrdHFN5316lXkBzpQ1De4hVXQ
         TDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yIvUop3P/60QYLtm8bDVCxAY3B7HwxRQ7AkWTc9jkh8=;
        b=vlX78oMqMioXzprdD7zxB5pjk70+eikWlIHB5SmB2IlPyIaMD6kTfrQGPKyGAOFDSK
         hQBR/AlpbCgEy4luyUejF0+gQBO1uiPG/+/FexK2eyXoLYmf6mXFV2lhFygTcabpqO+s
         ygMPNeBfISvY/fzQmAv4eGCrJClD9EBcpspp3l0aCzxqPoYPs3rSSROzL6Y9Xt4zSsxr
         hKHPgQPFILJCMSQWLTAlmqcly2n3V6edri0cQipp7nVfhIU06c1I8E+i93vNiPSw3466
         3mr3uxZ+8Z7U1v07t4BykKbLeaE745PiQmg/C3d6CjVL8nsZ6RCXygpkx/g5/hQaaf2E
         raVA==
X-Gm-Message-State: AOAM532fgYX7Lm0+f0I9RlvwxIVsfiJnZtzc7o6i7rCLy/C/w7I3w55i
        ky7CC0suJJemLEGFBSB33lm5
X-Google-Smtp-Source: ABdhPJyBLgu6nnMNu0XNtQrmb84WAJq+QQFJ7unI1AirZRKDx5A8vQSop0c3lfor668lSPDvc9ZMMA==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr2748253qtw.390.1631590397433;
        Mon, 13 Sep 2021 20:33:17 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id u7sm5288981qtc.75.2021.09.13.20.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:33:17 -0700 (PDT)
Subject: [PATCH v3 4/8] fs: add anon_inode_getfile_secure() similar to
 anon_inode_getfd_secure()
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 13 Sep 2021 23:33:16 -0400
Message-ID: <163159039643.470089.15401020922378832012.stgit@olly>
In-Reply-To: <163159032713.470089.11728103630366176255.stgit@olly>
References: <163159032713.470089.11728103630366176255.stgit@olly>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extending the secure anonymous inode support to other subsystems
requires that we have a secure anon_inode_getfile() variant in
addition to the existing secure anon_inode_getfd() variant.

Thankfully we can reuse the existing __anon_inode_getfile() function
and just wrap it with the proper arguments.

Acked-by: Mickaël Salaün <mic@linux.microsoft.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>

---
v3:
- no change
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

