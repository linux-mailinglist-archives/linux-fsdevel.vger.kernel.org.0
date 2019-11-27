Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10010ACF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 10:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfK0JzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 04:55:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34803 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfK0JzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:55:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so10554815pgb.1;
        Wed, 27 Nov 2019 01:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SObqhRlU5cENlMfk694hRi6SokTDPOUWbcmFxW6OtU=;
        b=Al97Xly0W55m2GYZr19HjBr1Hp/XGVBMD8EVexz3l1qrvyNaGgDCqOYX9a28wb5BWi
         B/Tz1LL/IS8ndjha0JxV8qHW/LRlWtKiqzv5s4fi56BOwsOQlFR73rl+9RYmUbrNXRj6
         TCWStkal38DyE4rAtwuO5efCEHB9N/ouq78cM8XWyT7aOgKqq7Ix0otLdg+fiRM9JldB
         mnuDidmhYYLwqgYJUvFli5r/dPOpLANuO+j0S/t3xVzVzfctb7FUD13IkdJ7e4PP/PD+
         TARzjOlrQ8346809ulD075MW3ikXazrpawuQWE6sg7TPFY7V8JS61gUY8ep2YtXsg7lG
         KgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8SObqhRlU5cENlMfk694hRi6SokTDPOUWbcmFxW6OtU=;
        b=Y1E6mCygU5IvGKjnyejt6oyvslJAOR+cdxtULopVaibeg8W/1qrm+j0sxkP5sBUADC
         3qEg7RwGd+YkG5I6xSfB+WoFiyLb8bWuI1pPT6Arvq03EjoTjIpzF5FkM2daxXqPAZkg
         Azfajf73hac5HqCa0QshDGwJpogMwWMQYVglx09u9I41VWOj4tF8NBnNsY7bbmpkbg+m
         T/+v0TV4ICdxDrr2VBvJiRhlw4N7wURKSMHgnULKus/2qew1ZP3ZpnU1k8sS8cX3tknt
         jkw0bHZC90a3zmUyN7JjtzaiYXnKwROffENJ1imVtPSHNuNrHWZVwop7sxre73s7rss/
         A5ag==
X-Gm-Message-State: APjAAAXuNcJH8KBqACjPe8EfIhkkwnwJaleM/INTDzN6ubkofh0jGZf+
        zrfqNjpaKiOg7j7OgShzuwo=
X-Google-Smtp-Source: APXvYqw6YwH9CkD3t2PbwHeHkYwI50XpNPSYUSfBcBM+X6Kvoza9K6V63rtUP/za8X0iTbm2TEklWA==
X-Received: by 2002:a65:530d:: with SMTP id m13mr3854619pgq.172.1574848508080;
        Wed, 27 Nov 2019 01:55:08 -0800 (PST)
Received: from athina.mtv.corp.google.com ([2620:15c:211:0:c786:d9fd:ab91:6283])
        by smtp.gmail.com with ESMTPSA id g11sm5772454pjv.8.2019.11.27.01.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 01:55:07 -0800 (PST)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] proc_do_large_bitmap - return error on writes to non-existant bitmap
Date:   Wed, 27 Nov 2019 01:54:59 -0800
Message-Id: <20191127095459.168324-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

Writing to an unallocated bitmap (with echo) results in an infinite
loop - although I'm not clear if this is in kernel or in userspace.

We return ENOMEDIUM 'No medium found', because it's the best error
I could come up with to describe the situation.

(Note: I'm not aware of any actual way to hit this with current
kernel code, I hit this while testing new code, but it still seems
like it should be fixed, especially since it prevented my machine
from booting, and didn't even have the dignity to crash...)

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus FS Devel Mailing List <linux-fsdevel@vger.kernel.org>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
---
 kernel/sysctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2c3958d2f463..431966967c99 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3174,6 +3174,11 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
 	unsigned long *tmp_bitmap = NULL;
 	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
 
+	if (write && (!bitmap || !bitmap_len))
+		/* returning 0 could cause an infinite loop */
+		return -ENOMEDIUM;
+	}
+
 	if (!bitmap || !bitmap_len || !left || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
-- 
2.24.0.432.g9d3f5f5b63-goog

