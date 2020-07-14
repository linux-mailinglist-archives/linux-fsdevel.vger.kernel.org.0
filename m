Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B50D21EDEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgGNK0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNK0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:26:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4D7C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 03:26:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so1372995pje.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1db+/DIrMS2Yx0NSZ68/XJbyfi4dpZJv5cNyKzn3Qk=;
        b=iFjhmUO8YXGtorzj9GrvqtopSUjVS554lUF+AJaqlSb2GMdFc4IlSUCU5bA0pYWUjG
         FRJLkUSucAnNqOK94kgYsjoWc4JYMsSmDvQFaw+4VFJkU9Jjo2t9H41rWzKmiOElhRXx
         /Pmj9fr3A/TW5IMRC72stJFUwjA2aItWsASQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a1db+/DIrMS2Yx0NSZ68/XJbyfi4dpZJv5cNyKzn3Qk=;
        b=gpt7shAL1C1UG8Eouti7lmSHWVAQjVisoa1K3xOuT/5hKmO0dugrnMPHdbkWYdoYsg
         eN0m1Z2/6iB22RreduETsaaO9CSplPZOXGg27gjyw37F6QQURhf6nsJrgCdJKgLTutsq
         IGLv++GqTEFJIckD6FbdYfO32t2NZy3SfDo5eEeks7T05T2drzYq4QaFZRwMJ94WrCQF
         wwg9ptSD87/KAvriDMOjgE8uI6xeQJ0D0GTW/VGNmcwTOMciH7ctVFGwv8A17DsYSyAx
         m5Cw4MitrvRZRkFZ0qb1tli3DIjEbAzMzyEhmsbXpWHsBwcBCFA911tWCyaCNyyT1NuP
         EHPw==
X-Gm-Message-State: AOAM530Srq80SM/2CR2GyMuk5xRADS1303xmcgrUBIBox1QfbH1yuHJ1
        NgA1YHgtCumbVziq8VjGDGr/Jg==
X-Google-Smtp-Source: ABdhPJwKGwCdCXFhqWZJbPu0PWI9fgnoXeEOCRLX/VEeAoqv1K5rx0Ng/BML3nW3L8VPZt4qIby1OQ==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr3237964plo.221.1594722407576;
        Tue, 14 Jul 2020 03:26:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id 200sm17330686pfy.57.2020.07.14.03.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 03:26:46 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH] fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS
Date:   Tue, 14 Jul 2020 19:26:39 +0900
Message-Id: <20200714102639.662048-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ioctl encoding for this parameter is a long but the documentation
says it should be an int and the kernel drivers expect it to be an int.
If the fuse driver treats this as a long it might end up scribbling over
the stack of a userspace process that only allocated enough space for an
int.

This was previously discussed in [1] and a patch for fuse was proposed
in [2].  From what I can tell the patch in [2] was nacked in favor of
adding new, "fixed" ioctls and using those from userspace.  However
there is still no "fixed" version of these ioctls and the fact is that
it's sometimes infeasible to change all userspace to use the new one.

Handling the ioctls specially in the fuse driver seems like the most
pragmatic way for fuse servers to support them without causing crashes
in userspace applications that call them.

[1]: https://lore.kernel.org/linux-fsdevel/20131126200559.GH20559@hall.aurel32.net/T/
[2]: https://sourceforge.net/p/fuse/mailman/message/31771759/

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 66214707a9456..fc0a568ee28c8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/swap.h>
 #include <linux/falloc.h>
 #include <linux/uio.h>
+#include <linux/fs.h>
 
 static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 				      struct fuse_page_desc **desc)
@@ -2760,7 +2761,16 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		struct iovec *iov = iov_page;
 
 		iov->iov_base = (void __user *)arg;
-		iov->iov_len = _IOC_SIZE(cmd);
+
+		switch (cmd) {
+		case FS_IOC_GETFLAGS:
+		case FS_IOC_SETFLAGS:
+			iov->iov_len = sizeof(int);
+			break;
+		default:
+			iov->iov_len = _IOC_SIZE(cmd);
+			break;
+		}
 
 		if (_IOC_DIR(cmd) & _IOC_WRITE) {
 			in_iov = iov;
-- 
2.27.0.389.gc38d7665816-goog

