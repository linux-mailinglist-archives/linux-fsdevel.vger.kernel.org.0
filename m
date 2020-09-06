Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7EE25F0F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 00:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIFWjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 18:39:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44951 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFWjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:39:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id b19so13860570lji.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2020 15:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikx3uAdKFSJIzTgmz4fEDgTM2my2iVbAUKN6jp52/rw=;
        b=o7aBQDDYMFT42oYQF5Nh6vZnAD6QkWyCXnIpdqcmgX0aC4orP7tmHg+ar6rOupsCoB
         OJXGFqim/iQ7Sgiug/SkfVs2udDk3IaXqHImJOwtM7ZdhAulmLG5WcOLr/RhPLWysVXZ
         VJXA2ovzanSR63rr8lkf8LJuA0IQlOrkqadD38iBgBD0vHnj9wRTefVngHGTpmMy4OwW
         aLjJ54OeJriY63Sl4rqaB2b5VMRcZIG6UN9XxlSaFNHxM1S9wSrNKtCqy25CPtGadEPc
         nznAYSptFg8UIEXm3QMIlbPYyWwp6QOgFCRlSaUdcav3bzg6+53WbLhUPcKA2AskgE72
         amPQ==
X-Gm-Message-State: AOAM5302LwfazIyKDp2gkDyM7KxiaNCArT7+tAcqzm9f71uplpIC/nSY
        0NFaHfy/3r2D8bSugziaQpE=
X-Google-Smtp-Source: ABdhPJxoYf7E+GBHb5sBzQ+hlbyD87VNjF0h9jGa3Q1pViydBlaSOlqgnjtzZA7+XGGSm8T7sWm1LQ==
X-Received: by 2002:a2e:87c7:: with SMTP id v7mr6671842ljj.13.1599431991423;
        Sun, 06 Sep 2020 15:39:51 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v196sm4555898lfa.96.2020.09.06.15.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 15:39:50 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice in VALID_OPEN_FLAGS
Date:   Sun,  6 Sep 2020 22:39:49 +0000
Message-Id: <20200906223949.62771-1-kw@linux.com>
X-Mailer: git-send-email 2.28.0
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

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v3:
  Drop whitespace changes.  Thank you Jens!

Changes in v2:
  Update commit message and subject line wording as per review feedback.

include/linux/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..921e750843e6 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -8,7 +8,7 @@
 /* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
-	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
+	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
-- 
2.28.0

