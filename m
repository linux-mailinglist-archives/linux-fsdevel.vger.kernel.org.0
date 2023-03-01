Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2A6A647D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 01:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCAAya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 19:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCAAy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:54:27 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D883802B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oj5so7709434pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 16:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677632062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8QvEJHYhAXcNkgYMIkS1lSU8aRrD4xwhBP8pWQKoEQ=;
        b=POpWsg0D7RKSBcxfWey09P/uiwmcI7RQXs+IRRVllDsAp8dZ8Uz1pCW2nsB3x2sVDm
         adz4wQt9hBCZA9Z65RvFgYvAFS6b9nfMOgqn6CxiaUWNZWvZErnz2fDrZSeD0A0sbBqx
         gouNPyUN/sS22fY9nFZaPnsXvjOn2v/ZoBo7+StxIbqRFCTTvenxy81A4s64ZqtMOWMw
         DYC7Dr7FrIuwur4+uD6rtjWpr+vmftWcRrwUOO7kpsPwPxEsjrfhJ3WqHDsjDMbNGG9K
         Hk6hXlRkUcIJMmbV0ZQIUd299cJJkbu3SrYGpWOLfh7nOArneTJF6ojGNk3esqX8Q7u3
         L9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677632062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8QvEJHYhAXcNkgYMIkS1lSU8aRrD4xwhBP8pWQKoEQ=;
        b=44CnsUzJmZGb63izk9F/JQh7LwrcnKmlwDucUUaRYiAO7tmIF2vu7hNZdkvlu6igVY
         jz5nq2QVwMWgS3UNlo/50aCaHQyhErwfbwyMt9A87NJuBR6r3MGOInMirIjyVi5jjSnm
         mRJKgDNITySoyEk1a4krxveCiAX3/5ixmHA8bLzi4A+IDAnGWCrvUUsiw/Ktv0PbHZqf
         i+ZHwRHXhywoqtqoJwGQut3XV30SQjCw6KJIMUCdkKnI7n9yNs237R5aVxrxFjKkoRLO
         gs9kN6uhu2TbFtbakq3lTmnIbxB4f+kvdG8QfSe35bZrTH9Dy9mlUTEfBuYS/HwUHF0C
         IuGg==
X-Gm-Message-State: AO0yUKV3pY6Mw9r1SpYksbzRpf42qS08soZlTz6MkYZlPfU2WI7aDesU
        ThpIF3zDhK7f3RN+/qIaKnWHBg==
X-Google-Smtp-Source: AK7set+ZIjetJnI/eW38N5gYq4TacNpMbuGunCgeLcexpsYtSVLN8hreE/tlERE7S87p3ZoWWB92Jw==
X-Received: by 2002:a05:6a20:748c:b0:bd:17a4:c35f with SMTP id p12-20020a056a20748c00b000bd17a4c35fmr5665085pzd.23.1677632062013;
        Tue, 28 Feb 2023 16:54:22 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id c5-20020a6566c5000000b00503000f0492sm18606pgw.14.2023.02.28.16.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:54:21 -0800 (PST)
From:   Glenn Washburn <development@efficientek.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Glenn Washburn <development@efficientek.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] scripts/gdb: Add GDB convenience functions $lx_dentry_name() and $lx_i_dentry()
Date:   Tue, 28 Feb 2023 18:53:35 -0600
Message-Id: <c9a5ad8efbfbd2cc6559e082734eed7628f43a16.1677631565.git.development@efficientek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1677631565.git.development@efficientek.com>
References: <cover.1677631565.git.development@efficientek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

$lx_dentry_name() generates a full VFS path from a given dentry pointer,
and $lx_i_dentry() returns the dentry pointer associated with the given
inode pointer, if there is one.

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 scripts/gdb/linux/vfs.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/scripts/gdb/linux/vfs.py b/scripts/gdb/linux/vfs.py
index 62d4f9ad7d79..c77b9ce75f6d 100644
--- a/scripts/gdb/linux/vfs.py
+++ b/scripts/gdb/linux/vfs.py
@@ -13,6 +13,9 @@
 # This work is licensed under the terms of the GNU GPL version 2.
 #
 
+import gdb
+from linux import utils
+
 
 def dentry_name(d):
     parent = d['d_parent']
@@ -20,3 +23,37 @@ def dentry_name(d):
         return ""
     p = dentry_name(d['d_parent']) + "/"
     return p + d['d_iname'].string()
+
+class DentryName(gdb.Function):
+    """Return string of the full path of a dentry.
+
+$lx_dentry_name(PTR): Given PTR to a dentry struct, return a string
+of the full path of the dentry."""
+
+    def __init__(self):
+        super(DentryName, self).__init__("lx_dentry_name")
+
+    def invoke(self, dentry_ptr):
+        return dentry_name(dentry_ptr)
+
+DentryName()
+
+
+dentry_type = utils.CachedType("struct dentry")
+
+class InodeDentry(gdb.Function):
+    """Return dentry pointer for inode.
+
+$lx_i_dentry(PTR): Given PTR to an inode struct, return a pointer to
+the associated dentry struct, if there is one."""
+
+    def __init__(self):
+        super(InodeDentry, self).__init__("lx_i_dentry")
+
+    def invoke(self, inode_ptr):
+        d_u = inode_ptr["i_dentry"]["first"]
+        if d_u == 0:
+            return ""
+        return utils.container_of(d_u, dentry_type.get_type().pointer(), "d_u")
+
+InodeDentry()
-- 
2.30.2

