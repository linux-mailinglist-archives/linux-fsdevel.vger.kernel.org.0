Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AE42D099F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 05:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgLGED7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 23:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLGED7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:03:59 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AEAC0613D1
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 20:03:19 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 11so2259191pfu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 20:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inOElu6/JUf6LT7vGll69phmBCZm0t6wlFCb1dqlOv0=;
        b=EOur0hRVxLmjrmEDts8TZK2QWJaKIexvoGvYBWa24VSjNOjx3Z3TbVQWmUTugd8WI1
         npKW6RgzlZjihGL7PtdWzqFSNLbOZry1ef08m/CJaHtTFcAlYEhi51sBzuyKF6WuwTpf
         JkkIWPb+v7OCZ72zFCrz78Gwv1kToaSvzXEqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inOElu6/JUf6LT7vGll69phmBCZm0t6wlFCb1dqlOv0=;
        b=ZDzcOO9TZzjGyWqtSzlIB4IQaraYHx8Yq116iW0hxnP3N7t4LvOafu2xeyVF0y/r5N
         p1eMfiIPbYurHrCCwHSPIsCUqTDTcA5cakoQwMsKktfjoffpmOiWphOXhQ87U8KS6+aQ
         WRh/zGq2I8STZjqA0gGqJ7BFFq2opdYfCz329sQy0kTiBAVE+VtuIz4wvGaoZt9A9Zl5
         fcaMLXyPOEG0Tkp1p/vBNqHIA1iKSjgxyPC6pJwe5a/uAzrbT5a3nr2maYEODa95oYe7
         JDiK2SG1p9kIa1LegjR32JELRWt+ZRAYg1hEuQ01b2GbOXM0oqHmIlAecH3UJ5VADn9j
         s+Jg==
X-Gm-Message-State: AOAM532Z+yah4mXOXczcLLiHB6WT2Qipy+B0HI7hsBDoUiAxElcAg7SG
        aKBg8JOdNkFOdtpiTRRwEj+grxM/jRB39A==
X-Google-Smtp-Source: ABdhPJzsJ59HzpEioLOE0QOo6sdmlQhyk4wydS+Il7UTKqYCOLhnma+1JxRtGr+Uvc7nTRfnh3zSDA==
X-Received: by 2002:a63:7943:: with SMTP id u64mr16841738pgc.139.1607313798907;
        Sun, 06 Dec 2020 20:03:18 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id h7sm12461301pgi.90.2020.12.06.20.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 20:03:18 -0800 (PST)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH] fuse: Support FS_IOC_GET_ENCRYPTION_POLICY_EX
Date:   Mon,  7 Dec 2020 13:03:03 +0900
Message-Id: <20201207040303.906100-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a dynamically sized ioctl so we need to check the user-provided
parameter for the actual length.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c03034e8c1529..1627c14e9dacc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 
 static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 				      struct fuse_page_desc **desc)
@@ -2808,6 +2809,21 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 		case FS_IOC_SETFLAGS:
 			iov->iov_len = sizeof(int);
 			break;
+		case FS_IOC_GET_ENCRYPTION_POLICY_EX: {
+			struct fscrypt_get_policy_ex_arg policy;
+			unsigned long size_ptr =
+				arg + offsetof(struct fscrypt_get_policy_ex_arg,
+					       policy_size);
+
+			if (copy_from_user(&policy.policy_size,
+					   (void __user *)size_ptr,
+					   sizeof(policy.policy_size)))
+				return -EFAULT;
+
+			iov->iov_len =
+				sizeof(policy.policy_size) + policy.policy_size;
+			break;
+		}
 		default:
 			iov->iov_len = _IOC_SIZE(cmd);
 			break;
-- 
2.29.2.576.ga3fc446d84-goog

