Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4843A161743
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgBQQM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PEqrgFvISIAaZ/B0HMya4ckarbzN8BQoSggebQYt5cc=; b=IbwNPCB4O/bav+b3m1LH1AVpmB
        gEZI9Dn+BdKi09Mou9G+hxU6rmXlAw4UW2ujtXcwaJy3OZvmkIG96fMmDosAP5O44t4YxRaJJYA8J
        qHfb6DFitFoTluC0tEoc54uDg6yws2lMm7pETqxTqVAO/zmqp78/FhhCbOQ0wNNnJ6U7EyyUltbZo
        pQwmYbnmpr4FhO+d7CYXQch78ZdAEx9Fi8atw+nHASBAWZBvjypt8l3pwM1hrsV8pSycmqeaTwheO
        mlOf0qHXay3ppjIkaiCtGZd9CSnf3fMlQELJnx/GYBBV1E0y1cVQFYkxgB6997M5FnR/kRB+Bu69K
        iLQEXWEA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006ux-49; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbk-6f; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 35/44] docs: filesystems: convert relay.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:21 +0100
Message-Id: <f48bb0fdf64d197f28c6f469adb61a7a091adb75.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Use notes markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{relay.txt => relay.rst}      | 129 +++++++++---------
 2 files changed, 69 insertions(+), 61 deletions(-)
 rename Documentation/filesystems/{relay.txt => relay.rst} (91%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index b8689d082911..0aade8146d4d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -84,5 +84,6 @@ Documentation for filesystem implementations.
    proc
    qnx6
    ramfs-rootfs-initramfs
+   relay
    virtiofs
    vfat
diff --git a/Documentation/filesystems/relay.txt b/Documentation/filesystems/relay.rst
similarity index 91%
rename from Documentation/filesystems/relay.txt
rename to Documentation/filesystems/relay.rst
index cd709a94d054..04ad083cfe62 100644
--- a/Documentation/filesystems/relay.txt
+++ b/Documentation/filesystems/relay.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
 relay interface (formerly relayfs)
 ==================================
 
@@ -108,6 +111,7 @@ The relay interface implements basic file operations for user space
 access to relay channel buffer data.  Here are the file operations
 that are available and some comments regarding their behavior:
 
+=========== ============================================================
 open()	    enables user to open an _existing_ channel buffer.
 
 mmap()      results in channel buffer being mapped into the caller's
@@ -136,13 +140,16 @@ poll()      POLLIN/POLLRDNORM/POLLERR supported.  User applications are
 close()     decrements the channel buffer's refcount.  When the refcount
 	    reaches 0, i.e. when no process or kernel client has the
 	    buffer open, the channel buffer is freed.
+=========== ============================================================
 
 In order for a user application to make use of relay files, the
-host filesystem must be mounted.  For example,
+host filesystem must be mounted.  For example::
 
 	mount -t debugfs debugfs /sys/kernel/debug
 
-NOTE:   the host filesystem doesn't need to be mounted for kernel
+.. Note::
+
+	the host filesystem doesn't need to be mounted for kernel
 	clients to create or use channels - it only needs to be
 	mounted when user space applications need access to the buffer
 	data.
@@ -154,7 +161,7 @@ The relay interface kernel API
 Here's a summary of the API the relay interface provides to in-kernel clients:
 
 TBD(curr. line MT:/API/)
-  channel management functions:
+  channel management functions::
 
     relay_open(base_filename, parent, subbuf_size, n_subbufs,
                callbacks, private_data)
@@ -162,17 +169,17 @@ TBD(curr. line MT:/API/)
     relay_flush(chan)
     relay_reset(chan)
 
-  channel management typically called on instigation of userspace:
+  channel management typically called on instigation of userspace::
 
     relay_subbufs_consumed(chan, cpu, subbufs_consumed)
 
-  write functions:
+  write functions::
 
     relay_write(chan, data, length)
     __relay_write(chan, data, length)
     relay_reserve(chan, length)
 
-  callbacks:
+  callbacks::
 
     subbuf_start(buf, subbuf, prev_subbuf, prev_padding)
     buf_mapped(buf, filp)
@@ -180,7 +187,7 @@ TBD(curr. line MT:/API/)
     create_buf_file(filename, parent, mode, buf, is_global)
     remove_buf_file(dentry)
 
-  helper functions:
+  helper functions::
 
     relay_buf_full(buf)
     subbuf_start_reserve(buf, length)
@@ -215,41 +222,41 @@ the file(s) created in create_buf_file() and is called during
 relay_close().
 
 Here are some typical definitions for these callbacks, in this case
-using debugfs:
+using debugfs::
 
-/*
- * create_buf_file() callback.  Creates relay file in debugfs.
- */
-static struct dentry *create_buf_file_handler(const char *filename,
-                                              struct dentry *parent,
-                                              umode_t mode,
-                                              struct rchan_buf *buf,
-                                              int *is_global)
-{
-        return debugfs_create_file(filename, mode, parent, buf,
-	                           &relay_file_operations);
-}
+    /*
+    * create_buf_file() callback.  Creates relay file in debugfs.
+    */
+    static struct dentry *create_buf_file_handler(const char *filename,
+						struct dentry *parent,
+						umode_t mode,
+						struct rchan_buf *buf,
+						int *is_global)
+    {
+	    return debugfs_create_file(filename, mode, parent, buf,
+				    &relay_file_operations);
+    }
 
-/*
- * remove_buf_file() callback.  Removes relay file from debugfs.
- */
-static int remove_buf_file_handler(struct dentry *dentry)
-{
-        debugfs_remove(dentry);
+    /*
+    * remove_buf_file() callback.  Removes relay file from debugfs.
+    */
+    static int remove_buf_file_handler(struct dentry *dentry)
+    {
+	    debugfs_remove(dentry);
 
-        return 0;
-}
+	    return 0;
+    }
 
-/*
- * relay interface callbacks
- */
-static struct rchan_callbacks relay_callbacks =
-{
-        .create_buf_file = create_buf_file_handler,
-        .remove_buf_file = remove_buf_file_handler,
-};
+    /*
+    * relay interface callbacks
+    */
+    static struct rchan_callbacks relay_callbacks =
+    {
+	    .create_buf_file = create_buf_file_handler,
+	    .remove_buf_file = remove_buf_file_handler,
+    };
 
-And an example relay_open() invocation using them:
+And an example relay_open() invocation using them::
 
   chan = relay_open("cpu", NULL, SUBBUF_SIZE, N_SUBBUFS, &relay_callbacks, NULL);
 
@@ -339,23 +346,23 @@ whether or not to actually move on to the next sub-buffer.
 
 To implement 'no-overwrite' mode, the userspace client would provide
 an implementation of the subbuf_start() callback something like the
-following:
+following::
 
-static int subbuf_start(struct rchan_buf *buf,
-                        void *subbuf,
-			void *prev_subbuf,
-			unsigned int prev_padding)
-{
-	if (prev_subbuf)
-		*((unsigned *)prev_subbuf) = prev_padding;
+    static int subbuf_start(struct rchan_buf *buf,
+			    void *subbuf,
+			    void *prev_subbuf,
+			    unsigned int prev_padding)
+    {
+	    if (prev_subbuf)
+		    *((unsigned *)prev_subbuf) = prev_padding;
 
-	if (relay_buf_full(buf))
-		return 0;
+	    if (relay_buf_full(buf))
+		    return 0;
 
-	subbuf_start_reserve(buf, sizeof(unsigned int));
+	    subbuf_start_reserve(buf, sizeof(unsigned int));
 
-	return 1;
-}
+	    return 1;
+    }
 
 If the current buffer is full, i.e. all sub-buffers remain unconsumed,
 the callback returns 0 to indicate that the buffer switch should not
@@ -370,20 +377,20 @@ ready sub-buffers will relay_buf_full() return 0, in which case the
 buffer switch can continue.
 
 The implementation of the subbuf_start() callback for 'overwrite' mode
-would be very similar:
+would be very similar::
 
-static int subbuf_start(struct rchan_buf *buf,
-                        void *subbuf,
-			void *prev_subbuf,
-			size_t prev_padding)
-{
-	if (prev_subbuf)
-		*((unsigned *)prev_subbuf) = prev_padding;
+    static int subbuf_start(struct rchan_buf *buf,
+			    void *subbuf,
+			    void *prev_subbuf,
+			    size_t prev_padding)
+    {
+	    if (prev_subbuf)
+		    *((unsigned *)prev_subbuf) = prev_padding;
 
-	subbuf_start_reserve(buf, sizeof(unsigned int));
+	    subbuf_start_reserve(buf, sizeof(unsigned int));
 
-	return 1;
-}
+	    return 1;
+    }
 
 In this case, the relay_buf_full() check is meaningless and the
 callback always returns 1, causing the buffer switch to occur
-- 
2.24.1

