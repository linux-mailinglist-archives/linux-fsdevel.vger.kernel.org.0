Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D47722D764
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 14:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGYMFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 08:05:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37636 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgGYMFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:05:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id s9so6592360lfs.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 05:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40zw6rhVNvbVkVv5RErzKN+f5cy3L6Jp5j8oauarrw4=;
        b=RcPUudyrQ3MNUQlb6MgFOYjWW50O8m3dElQGNvxNlOlFzoXInI7YwsVpAQaV9hnxAR
         jzjXd2kOCiL7jWnleREt7YF7Emk0LJmEIkYkffcp87cevc6LSNEJohSdcX5uNevZXSpE
         booSK99HW78lqXy6y7w5bQGFMk4dpcs3GmcunIgJ37MxiXzxz34AK+eGPIcvvcqMnuMS
         qCLktCNFFkFwrK52pYa2md2zHfvVhZ4ov8UoeCBXXGDY/r+7t1ZrKl0r0PxMvdUIUMjD
         49nQG8UThN9mVGMjSx9C5RUjqbGEzWgHNs8TrjKK/jImdaFLxwi3uLqEqDF7LiuiB85O
         hWoQ==
X-Gm-Message-State: AOAM530ewm7zHfAzej8eQfaObVdTq7ix/CzffFfKvzbR2v9DvqHOIPPp
        c36kFbEvxu3S/kBBQtJ/etg=
X-Google-Smtp-Source: ABdhPJwixbzBRwb4gnvc8RPNHD9V9Dgv6ZQBGdRKs8tRhTlg+NWloLIZERXH0Pzy20xx3WZDDdsp1w==
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr7168424lfp.138.1595678699336;
        Sat, 25 Jul 2020 05:04:59 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z7sm979256ljj.33.2020.07.25.05.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 05:04:58 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [RESEND PATCH v2] fs: Remove duplicated flag O_NDELAY occurring twice in VALID_OPEN_FLAGS
Date:   Sat, 25 Jul 2020 12:04:57 +0000
Message-Id: <20200725120457.10808-1-kw@linux.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The O_NDELAY flag occurs twice in the VALID_OPEN_FLAGS definition, this
change removes the duplicate.  There is no change to the functionality.

Note, that the flags O_NONBLOCK and O_NDELAY are not duplicates, as
values of these flags are platform dependent, and on platforms like
Sparc O_NONBLOCK and O_NDELAY are not the same.

This has been done that way to maintain the ABI compatibility with
Solaris since the Sparc port was first introduced.

This change resolves the following Coccinelle warning:

  include/linux/fcntl.h:11:13-21: duplicated argument to & or |

Also, remove extra white space after the FASYNC flag, and keep the line
under 80 characters to resolve the following checkpatch.pl warning:

  WARNING: line over 80 characters
  #10: FILE: include/linux/fcntl.h:10:
  +	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v2:
  Update commit message and subject line wording as per review feedback.

 include/linux/fcntl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..be3e445eba18 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -7,9 +7,9 @@
 
 /* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
-	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
-	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
-	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
+	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | \
+	 O_TRUNC | O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
+	 FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
-- 
2.26.2

