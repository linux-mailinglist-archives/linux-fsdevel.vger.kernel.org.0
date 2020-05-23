Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAF1DF6EA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgEWLou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 07:44:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47089 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgEWLou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 07:44:50 -0400
Received: by mail-ed1-f67.google.com with SMTP id f13so10707874edr.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40zw6rhVNvbVkVv5RErzKN+f5cy3L6Jp5j8oauarrw4=;
        b=dTp/ITw6ONuhH1U9HPL/K9hosO/kHsXgOP+Jo9sIfeLxb6wk6Cs2zDix4KtwYiTCIg
         W4Dj0kxGN1TOdnyHEefpAiw9Ge+Fv5f/BjfiRw3evWiCENdpnRGLsLw4EI5GmRMvSu60
         eurPeT+T5JABHxwayINUATQdfQIH1ceBxj/toFlHgbAR163/Lb2Tvd9XZVYUiKLsjA/q
         5fsclMupnp3DkoJVL0G7k2d4tluD2i7fyK3+lTBKCSVBUtbiDd3UTDQs1wbTdCgmoZig
         JdjD1VMTwlsdZnV50F8eXnGYdhprWjCAVzMnGqZmXQDFMeAm9OZOYpokGIm1kqSGKTlC
         aRpg==
X-Gm-Message-State: AOAM533pfbGoMbMkhXHf5H3Hj8Nm1UlW6teM+Nf4wRQjZcOviRMO6M97
        mMgjofgeR54EnGlxHWdw5xpGOPcY8/xy3Q==
X-Google-Smtp-Source: ABdhPJy0nSEi/kbLAUhO+17NMwia2yHu1M9hoqPu/GSq1tjs6qHbI24ty07AezKNSX4vk3gEl2dBiA==
X-Received: by 2002:a05:6402:14d7:: with SMTP id f23mr6827472edx.187.1590234288212;
        Sat, 23 May 2020 04:44:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id se2sm10741108ejb.42.2020.05.23.04.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 04:44:47 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs: Remove duplicated flag O_NDELAY occurring twice in VALID_OPEN_FLAGS
Date:   Sat, 23 May 2020 11:44:46 +0000
Message-Id: <20200523114446.1102448-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
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

