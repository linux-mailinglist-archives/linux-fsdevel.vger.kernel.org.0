Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E192010F6E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfLCFUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfLCFUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so1225540pfd.11;
        Mon, 02 Dec 2019 21:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VeU+4RS/PpYtzQGHtIekj3ninA+VVkPKJdEtPDnLRPU=;
        b=gwVAe8g4xi2/LueExwl9mjN4TSqcI5f+1FomCI0NfGnq505J0FsoHuq9/U1/5o1j/H
         LG23ptGFgJuVqAUTHTL/oTccCqJz/IiHq+xYggvMOspWdMWGm2ao8gtZ47Eemf1S7Rg4
         3hKF//ApfC7jC8mFhHRXBjGlURZ9r7ZudphdqO+l4kfGCnulneRQDBEFbG7umJbqOjpS
         n/r07yATJ1AJhloDdhk6jYjjOoR8bAn/RcjF7jvm5ZmdB46EpoNrJqVBII0O8lsGEpfp
         CEfSfVCv5lhkfSr8JE54w0iynDJr7BD5wWwm6OKAT7/O62MtOR6JtYQiLMK9Vlw/9Z/w
         lhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VeU+4RS/PpYtzQGHtIekj3ninA+VVkPKJdEtPDnLRPU=;
        b=NAhnARkxSIb37PE2T2AYaHFlxPMjyc8bV32bfkttvNgGfKdgrpND2+l8HAmG8mNVgj
         hj1l+cimljWTqRgnH3a3FesnFXNo41c2WPXF5lnDVGFQ/L/27RUw+1sgIiHBPR901seh
         3agEDjYWLM9H3sB+4snDe7PE8FD6FBDA7Ortu/fih3r00+JkEVT9mgl6kpq+CZLC4xGC
         wIb0aUG6NtlDdiS8usrErBrHXtbVBzxcQQ1wc/gQHonJs+0PfH9JGXXfpsb0XU6VIOOE
         3C1GuyLEdaZAAhKLX9YSJstxwJsuc4JmAKQyEEGZ/+7qri4L+KttjSy4WoY0v2mVwPBH
         jquw==
X-Gm-Message-State: APjAAAWfahmO2OURflP8yav2WnPahtGlY2PBrOLZrJzCp8rZaGgT0kXi
        Pk/++AQWIAbvpkWx9jKtBUw=
X-Google-Smtp-Source: APXvYqw0YvpmI6G+T2AV285iedroWKgLbw7+vCwsHcSwjyfgoD0qwqJARPSSoxAnpAwM+8cyB1bK3g==
X-Received: by 2002:aa7:972a:: with SMTP id k10mr2994373pfg.140.1575350417865;
        Mon, 02 Dec 2019 21:20:17 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:17 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH v2 6/6] fs: Do not overload update_time
Date:   Mon,  2 Dec 2019 21:19:45 -0800
Message-Id: <20191203051945.9440-7-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

update_time() also has an internal function pointer
update_time. Even though this works correctly, it is
confusing to the readers.

Just use a regular if statement to call the generic
function or the function pointer.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 12c9e38529c9..aff2b5831168 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1675,12 +1675,9 @@ EXPORT_SYMBOL(generic_update_time);
  */
 static int update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	int (*update_time)(struct inode *, struct timespec64 *, int);
-
-	update_time = inode->i_op->update_time ? inode->i_op->update_time :
-		generic_update_time;
-
-	return update_time(inode, time, flags);
+	if (inode->i_op->update_time)
+		return inode->i_op->update_time(inode, time, flags);
+	return generic_update_time(inode, time, flags);
 }
 
 /**
-- 
2.17.1

