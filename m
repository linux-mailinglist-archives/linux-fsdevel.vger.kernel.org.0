Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D614017A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 02:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgAQBdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 20:33:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45155 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgAQBdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:33:24 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so17067914lfa.12;
        Thu, 16 Jan 2020 17:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vv41OytkG2lm8SDKlOhg/H6yihO/V8R0f5z4QUp0HiY=;
        b=Ah4TFo6IAW4T2As4EOtGEwjyCC4a/sieRz+Y9ll6/X1YfVcWC45I32GbSnGbdYDCbA
         PmwYVbh8mD6sH146gnqDd9pPR1E6Wq/Nq+0qVafy5jYXBBII88hwa9iBwTiZV7vqrRId
         1Wrii4CzY7JPvxuGQgCME78phMA22NwqzOojZy+oSzxK2ADHsH9kRkkDpFjXeTZBm5zf
         WF21SQmP/Gxcg9oxq7ylsx5S8xywWyAqoRb/aloJyaCiP1+z5T1+uaxRxL0c30rjTESI
         4OyJorxOeoHIDMq1K0uow3O9+S8DnQ/2PY5qoNGc/ioUXKJ3s4FZHjgaA2QdicF47S1s
         EFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vv41OytkG2lm8SDKlOhg/H6yihO/V8R0f5z4QUp0HiY=;
        b=uOi99bAAaazzG0IL3qwUG7I/1PX17QvwtvsAWqV+cFx72PmTaQtrLm14oWTW/+REP3
         UJfDDnWfOuJsqJHyDz5BK1SWQ35SolbWhd/d0WYv2P277XlbiJRhoFsT/qAKlssyJL7z
         ekRoQ7bjprYT8YJXE9PZVGHU2JVnpXzZrW/0oouhhRnMBgNGhN2hS80X6caW0T6b7S0m
         uRR6zoqujdUkBmDM4GgXmNN+PRHK5+k3CsyVVv46lqhqYsZy9s3CMfIlvXdnxWPsjd6j
         lPjV0m821Nph+ZapwZfRvk9niqYRxC0kHHHVN28MA0OZcgCZRd1FK4OYTtSTcUx7/zz+
         lydw==
X-Gm-Message-State: APjAAAU1gzFLg5lnMN1vHF7RTF/zrT/uWNJk+f/edFWv4HwYG24VJ/wm
        v9xXBAPyuTjS8i3gp+q/oQ4=
X-Google-Smtp-Source: APXvYqxw8NkIQQimSy+3i2QsgTXNgXe3GdPb4+CIflp9GmK5A8gUyzNBZXzEBOPS4cO2XeJFaBceUQ==
X-Received: by 2002:a19:c1c1:: with SMTP id r184mr4172932lff.128.1579224801780;
        Thu, 16 Jan 2020 17:33:21 -0800 (PST)
Received: from localhost.localdomain ([109.126.145.157])
        by smtp.gmail.com with ESMTPSA id q10sm11608696ljj.60.2020.01.16.17.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 17:33:21 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: optimise kiocb_set_rw_flags()
Date:   Fri, 17 Jan 2020 04:32:37 +0300
Message-Id: <5328b35d948ea2a3aa5df2b1d740c7cb1f38c846.1579224594.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
References: <8cecd243-38aa-292d-15cd-49b485f9253f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kiocb_set_rw_flags() generates a poor code with several memory writes
and a lot of jumps. Help compilers to optimise it.

Tested with gcc 9.2 on x64-86, and as a result, it its output now is a
plain code without jumps accumulating in a register before a memory
write.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: check for 0 flags in advance (Matthew Wilcox)

 include/linux/fs.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..22b46fc8fdfa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3402,22 +3402,28 @@ static inline int iocb_flags(struct file *file)
 
 static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 {
+	int kiocb_flags = 0;
+
+	if (!flags)
+		return 0;
 	if (unlikely(flags & ~RWF_SUPPORTED))
 		return -EOPNOTSUPP;
 
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		ki->ki_flags |= IOCB_NOWAIT;
+		kiocb_flags |= IOCB_NOWAIT;
 	}
 	if (flags & RWF_HIPRI)
-		ki->ki_flags |= IOCB_HIPRI;
+		kiocb_flags |= IOCB_HIPRI;
 	if (flags & RWF_DSYNC)
-		ki->ki_flags |= IOCB_DSYNC;
+		kiocb_flags |= IOCB_DSYNC;
 	if (flags & RWF_SYNC)
-		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
+		kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
-		ki->ki_flags |= IOCB_APPEND;
+		kiocb_flags |= IOCB_APPEND;
+
+	ki->ki_flags |= kiocb_flags;
 	return 0;
 }
 
-- 
2.24.0

