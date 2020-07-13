Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03321D345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGMJ5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 05:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMJ5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:57:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08111C061755
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 02:57:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5806473pgc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2020 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BVl/A4ZuZHtoqyknQZtUC9ho61FPvwu+Y4wN12Kj8U=;
        b=VP+bk5HMZIAPlQjZP2e7eQNzu1lE6CFhQ6VMPNrgIOjST02IUF2y0kRzXV7UrIGGj8
         HedvsxcGBaZVebJSB7mztbkxFe6a//+FrxDIftoeDtAQQCaB5Dhp1n4vrpzhpf/DORNK
         YZ1ceF8lEmfx2bD37dx+tGQ7TTE1ESyNeQQu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BVl/A4ZuZHtoqyknQZtUC9ho61FPvwu+Y4wN12Kj8U=;
        b=Ett6+jqGQO3/XK+X/UBFwshXN1k9mGnZUYsdgczCAlxb+iMz1RHqrIhMdetOqnHRZB
         Wpv6YdRwS56sHg5lLj5vsr8PW63GgbWqQ8wygzluBFKOlNNouEE6zstFGvbZkCt/Yy+W
         sIlhmoMBQytMZpMQtPecGeuxP8S+6K9OxpM7emzw0Z6NChutZSbfCS1ptqMR+wBPdhF7
         OkRw1bQFAxygZ9sb+h+6kZQh2JXAn13G3Tue3JjGZ7pPT3wBmkLIVjOgxVF5CDibmCEl
         Wdpo/8DN2sF+GL0wDqtDbYGDqQCjwYDggnDXRsQI7Gz4WCEw3dBHPOcvH7jXdwLpJKqe
         6ZcQ==
X-Gm-Message-State: AOAM533gyndpU0avyvTtTUc6GFNuC7LHOjTj8+hCGffH9B9BvdnKGZDB
        09k0+KhS/qggcQ4TFaPLnjd+6Q==
X-Google-Smtp-Source: ABdhPJzTiKU6MkYpR31tfDqsy+4lcc0pUEWAIbEZYhRb8/sYZIcm/sACohdD9hft6UVXozSVM0ZSKg==
X-Received: by 2002:aa7:84d3:: with SMTP id x19mr63384343pfn.155.1594634226613;
        Mon, 13 Jul 2020 02:57:06 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id w9sm13741053pja.39.2020.07.13.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 02:57:05 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
Date:   Mon, 13 Jul 2020 18:56:59 +0900
Message-Id: <20200713095700.350234-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
In-Reply-To: <20200713090921.312962-1-chirantan@chromium.org>
References: <20200713090921.312962-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the FUSE_SECURITY_CTX flag for the `flags` field of the
fuse_init_out struct.  When this flag is set the kernel will append the
security context for a newly created inode to the request (create,
mkdir, mknod, and symlink).  The server is responsible for ensuring that
the inode appears atomically with the requested security context.

For example, if the server is backed by a "real" linux file system then
it can write the security context value to
/proc/thread-self/attr/fscreate before making the syscall to create the
inode.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
Changes in v4:
  * Added signoff to commit message.

 include/uapi/linux/fuse.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada898159..e2099b45fd44b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -172,6 +172,10 @@
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  *  - add map_alignment to fuse_init_out, add FUSE_MAP_ALIGNMENT flag
+ *
+ *  7.32
+ *  - add FUSE_SECURITY_CTX flag for fuse_init_out
+ *  - add security context to create, mkdir, symlink, and mknod requests
  */
 
 #ifndef _LINUX_FUSE_H
@@ -207,7 +211,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 31
+#define FUSE_KERNEL_MINOR_VERSION 32
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -314,6 +318,7 @@ struct fuse_file_lock {
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
  * FUSE_MAP_ALIGNMENT: map_alignment field is valid
+ * FUSE_SECURITY_CTX: add security context to create, mkdir, symlink, and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -342,6 +347,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_SECURITY_CTX	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.27.0.383.g050319c2ae-goog

