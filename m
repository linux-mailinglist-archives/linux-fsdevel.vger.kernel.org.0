Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA961B5656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDWHrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgDWHrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:47:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F76C03C1AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 00:47:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so2535677pfb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6afMVNKrwhHvItapD8+y1UIvImlGm4AxbJB6yoQNwMs=;
        b=SCM8dRONky/8rS2rqCqHeCYbuvaHYu0hB+ukSIBDw5JHli4+P+L+832bN+2L1uPNo9
         rNrh6C0/55Wv9BMrYnjW/VTq2A94ue2PTVzwWI/HVmFxKevj5eQSiR1B7kuKN4nbulSa
         g2sakG58rB9FEpRr1/vbTznToVZr2VzRGvMYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6afMVNKrwhHvItapD8+y1UIvImlGm4AxbJB6yoQNwMs=;
        b=TYcwGUwFHh7g/2ylIQxSdP13FJki2P/I6vUa9DeZsOwJlV9H8tWIfGm0rH87uywIR0
         Owe4i8AuLOMLIqDS5oM+SeAWEal9Q3r1A4CmttimUjggy0vLfbVI0iRVeUg/jCsayza2
         ppd7AWpxB1u1xWelxatq+C3gOb9R2XkQyuHr7ghGar08CaPXoqUlfBRzFurbgLQPj0Gb
         aYf0qpx7mdppwNCBikSK1DdZg+qtY5VuN/VdtdPUv3wr1qfCI+YOdXtQqNIOz7AivKMr
         P+2KA6Ddo310LIFJnFlSlPAjxMSpKq521yV66//rMMwYCPWUTv8y8KdpVbbWUUDMAQAR
         CMWw==
X-Gm-Message-State: AGi0Pubv86Ns2aVhHL/UOCq07nzPkpJh1bP4YQTTgCjshYzLC4mkBBKE
        J9Z6vpJamCyYjLjwVW4B7sQUSA==
X-Google-Smtp-Source: APiQypIS4YQaXK5NOp0wFurhL/ElLKR9UXu1gwC+x0GnqdUE+BXokQb5UInvjOzt/kTWxXJ8ZiCqmQ==
X-Received: by 2002:a63:651:: with SMTP id 78mr2701573pgg.129.1587628039456;
        Thu, 23 Apr 2020 00:47:19 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:1c5:cb1a:7c95:326])
        by smtp.gmail.com with ESMTPSA id o7sm1804692pfg.74.2020.04.23.00.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 00:47:18 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     =Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH] fuse: Mark fscrypt ioctls as unrestricted
Date:   Thu, 23 Apr 2020 16:47:06 +0900
Message-Id: <20200423074706.107016-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The definitions for these 2 ioctls have been reversed: "get" is marked
as a write ioctl and "set" is marked as a read ioctl.  Moreover, since
these are now part of the public kernel interface they can never be
fixed because fixing them might break userspace applications compiled
with the older headers.

Since the fuse module strictly enforces the ioctl encodings, it will
reject any attempt by the fuse server to correctly implement these
ioctls.  Instead, check if the process is trying to make one of these
ioctls and mark it unrestricted.  This will allow the server to fix the
encoding by reading/writing the correct data.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a2..9b6d993323d53 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/fscrypt.h>
 
 static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 				      struct fuse_page_desc **desc)
@@ -2751,6 +2752,16 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 
 	fuse_page_descs_length_init(ap.descs, 0, fc->max_pages);
 
+	/*
+	 * These commands are encoded backwards so it is literally impossible
+	 * for a fuse server to implement them. Instead, mark them unrestricted
+	 * so that the server can deal with the broken encoding itself.
+	 */
+	if (cmd == FS_IOC_GET_ENCRYPTION_POLICY ||
+	    cmd == FS_IOC_SET_ENCRYPTION_POLICY) {
+		flags |= FUSE_IOCTL_UNRESTRICTED;
+	}
+
 	/*
 	 * If restricted, initialize IO parameters as encoded in @cmd.
 	 * RETRY from server is not allowed.
-- 
2.26.1.301.g55bc3eb7cb9-goog

