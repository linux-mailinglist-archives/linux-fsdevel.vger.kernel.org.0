Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC9216824
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGGITi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGGITe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7BC08C5EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 01:19:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so414336pfn.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXmMUA+Slmu9lbYRAJIZHSMzlajqISgWM80EG35cNbg=;
        b=ZeE/vfgK+v1GqxYTXUNDmF5e4/g8r2Ag6iu8mzSJEkdVGm9dB1k7swD0RAVU24nTiG
         7SBN7HaMbE+vWnkOfjl94jR8dvSapP0o8KaY7KKDOMRjyZ8iu+UduP+5EBnrStRPh/KV
         8JQXl7MBiiW+TlBbhV6wxfykp90S//DeLS5UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXmMUA+Slmu9lbYRAJIZHSMzlajqISgWM80EG35cNbg=;
        b=Ed9MzpfBQhlHMj05A4j/skqQpcG4GXN8nD4Wc8o0Wtba1jyBR4oHcGUZljHDM4hBVJ
         OqB1+xEw8wHjTv4JXevdyBFUS4dZC4TiPTbQpzfZYgQe7w67dRXXLsVwfGFuf1fgx+YU
         9PCwWdzJJ2W0JJaGDoBwFli34NNBuVK8KiMcFPL2l+3zWR/2MS3Tf2HAHmt58GPtSYZI
         99iZLhTPj+HPdgvulVBOjwHgBaUaH/RneEZE0CAOBxOusbjiFjrbkjyCPl+oZpcxjivY
         NdQ0BCgqNs2TPJZMzxe0C5MOaxNv3uCS8ZkMyRVjldtTuUxrKlrrZGFt2xVY+YzpM3IQ
         OwGA==
X-Gm-Message-State: AOAM533NkrbyDRFkWtmlwFFNZRxdqjFo6I42UWjV1XPcetf3qHYt/Izg
        Gza0TtKUxrrPGc05HbdnqeyJfA==
X-Google-Smtp-Source: ABdhPJzNhYHBYnkkxr0IEIYYTJP1XkKnUvqNP/Ht2HIYfP3jBUvPvi3Me6tsEjyrqJal9c9F0sY0kg==
X-Received: by 2002:aa7:93c3:: with SMTP id y3mr37629502pff.206.1594109973630;
        Tue, 07 Jul 2020 01:19:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm1806653pju.10.2020.07.07.01.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from kernel_read_file() enums
Date:   Tue,  7 Jul 2020 01:19:24 -0700
Message-Id: <20200707081926.3688096-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FIRMWARE_PREALLOC_BUFFER is a "how", not a "what", and confuses the LSMs
that are interested in filtering between types of things. The "how"
should be an internal detail made uninteresting to the LSMs.

Fixes: a098ecd2fa7d ("firmware: support loading into a pre-allocated buffer")
Fixes: fd90bc559bfb ("ima: based on policy verify firmware signatures (pre-allocated buffer)")
Fixes: 4f0496d8ffa3 ("ima: based on policy warn about loading firmware (pre-allocated buffer)")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/main.c | 5 ++---
 fs/exec.c                           | 7 ++++---
 include/linux/fs.h                  | 2 +-
 security/integrity/ima/ima_main.c   | 6 ++----
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b13524e..c2f57cedcd6f 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -465,14 +465,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 	int i, len;
 	int rc = -ENOENT;
 	char *path;
-	enum kernel_read_file_id id = READING_FIRMWARE;
 	size_t msize = INT_MAX;
 	void *buffer = NULL;
 
 	/* Already populated data member means we're loading into a buffer */
 	if (!decompress && fw_priv->data) {
 		buffer = fw_priv->data;
-		id = READING_FIRMWARE_PREALLOC_BUFFER;
 		msize = fw_priv->allocated_size;
 	}
 
@@ -496,7 +494,8 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 
 		/* load firmware files from the mount namespace of init */
 		rc = kernel_read_file_from_path_initns(path, &buffer,
-						       &size, msize, id);
+						       &size, msize,
+						       READING_FIRMWARE);
 		if (rc) {
 			if (rc != -ENOENT)
 				dev_warn(device, "loading %s failed with error %d\n",
diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..2bf549757ce7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -927,6 +927,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 {
 	loff_t i_size, pos;
 	ssize_t bytes = 0;
+	void *allocated = NULL;
 	int ret;
 
 	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
@@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 		goto out;
 	}
 
-	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
-		*buf = vmalloc(i_size);
+	if (!*buf)
+		*buf = allocated = vmalloc(i_size);
 	if (!*buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -980,7 +981,7 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 
 out_free:
 	if (ret < 0) {
-		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
+		if (allocated) {
 			vfree(*buf);
 			*buf = NULL;
 		}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea7..95fc775ed937 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2993,10 +2993,10 @@ static inline void i_readcount_inc(struct inode *inode)
 #endif
 extern int do_pipe_flags(int *, int);
 
+/* This is a list of *what* is being read, not *how*. */
 #define __kernel_read_file_id(id) \
 	id(UNKNOWN, unknown)		\
 	id(FIRMWARE, firmware)		\
-	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_EFI_EMBEDDED, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c1583d98c5e5..f80ee4ce4669 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -611,19 +611,17 @@ void ima_post_path_mknod(struct dentry *dentry)
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
 	/*
-	 * READING_FIRMWARE_PREALLOC_BUFFER
-	 *
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
 	 * of IMA's signature verification any more than when using two
-	 * buffers?
+	 * buffers? It may be desirable to include the buffer address
+	 * in this API and walk all the dma_map_single() mappings to check.
 	 */
 	return 0;
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
-	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-- 
2.25.1

