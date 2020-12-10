Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D192D67F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404534AbgLJUCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 15:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404297AbgLJUCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:02:03 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284AC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:23 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id q137so6874633iod.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 12:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9wyBKhUFn5MftHH1nBQv0b+/+lQzzrxlCkxBzkiQkw=;
        b=ZUOsicGAsjaxaxMruwDX+r/8yws7MgUYX/uXSJml/uFlQ+KWeVbJFU3gg0C//SqWhF
         LyizevQmC7DezFajy/xYr02Huh54dHEWgPOUdKzMWK875Dte/YP8LPgojGceb6OSuA08
         +zTnQMuvviRfqV+ca7AGBbYBIWNBPtHycXSQuyipGXnr2ldLNmXr4leGhfad3PwbOLhU
         TVn7Ul85OI2pzhXpHGkrdiDxozVQy75N1t9Z6RiD/J/R2w6V0Nqivp5g6e+5DXHTt1Dy
         d7Kb0sQ9l52qOjPDkG2W27j9VkJxvZtbo0lp1RfRvLwbL6oOHmug7SC5U4I8pRRNazAd
         QkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9wyBKhUFn5MftHH1nBQv0b+/+lQzzrxlCkxBzkiQkw=;
        b=FLdZ/UQA2QYuMzc0ubAQDwHMaH29uZ4SL8mhfU/pr6CjEE81tTnGQi+k8q4HJ/u4ic
         Kq0Ce72UEOz99l2gvQEaoqyTSuecDVeselUmTxAwW2o0l8Cr2pq/XL03zBwuIwhsgXwN
         UeXUO2tayPQkrwZ0pX2Fw2E+ZjG75BmiPipC+rNlHpI5muUZqH2NqkyyAkMyaSRXmGTx
         qXOpGd5pdBeQ3b8fB0b1ruszTpG7JZtIlPhpMGnkSeTMf6vSidAnTWaSobldlaFe7Md4
         qxAW25zsSHmZmYD6w6W/g/BMB2/2L9642MAWIucQfuZB0QtBMh/wIUOHV4FEst5Wr3g8
         mTug==
X-Gm-Message-State: AOAM530jr3bQstDzhimN4FPGJFJD5WfHM8V9nEWkcCrvURE9YuQClmBr
        0s+opkWizmx+Yb3inVa6R1fp29QkUVEuvA==
X-Google-Smtp-Source: ABdhPJyMvgOTu5LjV7jYWGp5juEAIZ+UJRF5innuk8cif+w2Av3cg3mtEle0Z3fgu7Vw1aGV0J+sFA==
X-Received: by 2002:a05:6602:258b:: with SMTP id p11mr9902926ioo.115.1607630482473;
        Thu, 10 Dec 2020 12:01:22 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm3850277ilm.22.2020.12.10.12.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:01:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] fs: expose LOOKUP_NONBLOCK through openat2() RESOLVE_NONBLOCK
Date:   Thu, 10 Dec 2020 13:01:14 -0700
Message-Id: <20201210200114.525026-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210200114.525026-1-axboe@kernel.dk>
References: <20201210200114.525026-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we support non-blocking path resolution internally, expose it
via openat2() in the struct open_how ->resolve flags. This allows
applications using openat2() to limit path resolution to the extent that
it is already cached.

If the lookup cannot be satisfied in a non-blocking manner, openat2(2)
will return -1/-EAGAIN.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/open.c                    | 2 ++
 include/linux/fcntl.h        | 2 +-
 include/uapi/linux/openat2.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..07dc9f3d1628 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1087,6 +1087,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_BENEATH;
 	if (how->resolve & RESOLVE_IN_ROOT)
 		lookup_flags |= LOOKUP_IN_ROOT;
+	if (how->resolve & RESOLVE_NONBLOCK)
+		lookup_flags |= LOOKUP_NONBLOCK;
 
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 921e750843e6..919a13c9317c 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -19,7 +19,7 @@
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-	 RESOLVE_BENEATH | RESOLVE_IN_ROOT)
+	 RESOLVE_BENEATH | RESOLVE_IN_ROOT | RESOLVE_NONBLOCK)
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index 58b1eb711360..ddbf0796841a 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -35,5 +35,7 @@ struct open_how {
 #define RESOLVE_IN_ROOT		0x10 /* Make all jumps to "/" and ".."
 					be scoped inside the dirfd
 					(similar to chroot(2)). */
+#define RESOLVE_NONBLOCK	0x20 /* Only complete if resolution can be
+					done without IO */
 
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.29.2

