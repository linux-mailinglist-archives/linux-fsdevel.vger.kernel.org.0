Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DAE23C0C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHDUcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHDUcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:32:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7AC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 13:32:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so30378857yba.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 13:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TE39gsqa8qAtAr57skK2bIVW3cJaqxb5kdkpRE6BXx4=;
        b=PRIjpcg+RHpob503zkgZ/kH0zrL/dFq+o15VbDIE+7fG//gkTUyv+BUYuFJGk77mXH
         J7o0LRArbZY03nboYkobXyq5Mclw1iNcylfxM3oqjztUXa4b16oc9VAe8xlPpDq3VbNL
         HI7knhb8Bd2R6LXwLc4T7PdFbknrVoH3KQ1n0BjGHFivqbIbJQfRFJ1y0AwH6+9NVr43
         HUWdRLf+B2SEM4ZF4dJMT3G/MR6QGRE36f/gVO+YIJZKdCGAn9ByjwNRcb+g7GrstnU4
         +4PcVun0xBJKIGgBUNUyn3FwtjVmpVdQelavHxqvU9qFVlEhe7P2/E9kh/EoaHxvU/jH
         Rtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TE39gsqa8qAtAr57skK2bIVW3cJaqxb5kdkpRE6BXx4=;
        b=ogqT93zUp6j5XP+Uc3+3lgJY1kVhJ7knp/KgCVSVL6+oF9L+zGRXcNhUA212+Ez4W/
         tTdOut4JRxEc8mYXrVlvSIffWekR9RDu5vWuW2v1pmcJoRpWpRdMErGMoKSnGtvjtkuJ
         ufiYLY+situ6Fd14UBcc1O9kEQXRTzlUDlmJMVcZUp0azrtNch9fPjXw9PdE8xe7HAZa
         BVbISYS2J/e87lfMjyQER/MtdCMd3Tz5PRkO92jWn+EZ7WLie5kIbmoLG0eIsJo9boA0
         j2woK9fAv5dHky77d2WKV/a1xF7r76XzxwjUvZrgUwuwbKuMvOklYGOfMkM0nmlT4wjN
         wlzA==
X-Gm-Message-State: AOAM533qEuwHDShGysNyPmutQUITWB6YLUasjZ0HWBZ7QGEdHIyB48LR
        A8JhSAQCefD6b6rr16HmAc1LCE0QCEgIesYlHQ==
X-Google-Smtp-Source: ABdhPJwoK3L7KaN/vfgdTz0aHbC7HLz0oYVW6btJ16u62KFo8LdFftIZhnnFvgmftUX1Ybc35y0qD4s/OLoD5NuXFg==
X-Received: by 2002:a25:d946:: with SMTP id q67mr33939817ybg.423.1596573126838;
 Tue, 04 Aug 2020 13:32:06 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:31:55 -0700
Message-Id: <20200804203155.2181099-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and remove O_CLOEXEC
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     viro@zeniv.linux.org.uk, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, jmorris@namei.org
Cc:     kaleshsingh@google.com, dancol@dancol.org, surenb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nnk@google.com, jeffv@google.com, calin@google.com,
        kernel-team@android.com, yanfei.xu@windriver.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

when get_unused_fd_flags returns error, ctx will be freed by
userfaultfd's release function, which is indirectly called by fput().
Also, if anon_inode_getfile_secure() returns an error, then
userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.

Also, the O_CLOEXEC was inadvertently added to the call to
get_unused_fd_flags() [1].

Adding Al Viro's suggested-by, based on [2].

[1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
[2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/

Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 fs/userfaultfd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ae859161908f..e15eb8fdc083 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 		O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
 		NULL);
 	if (IS_ERR(file)) {
-		fd = PTR_ERR(file);
-		goto out;
+		userfaultfd_ctx_put(ctx);
+		return PTR_ERR(file);
 	}
 
-	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	fd = get_unused_fd_flags(O_RDONLY);
 	if (fd < 0) {
 		fput(file);
-		goto out;
+		return fd;
 	}
 
 	ctx->owner = file_inode(file);
 	fd_install(fd, file);
-
-out:
-	if (fd < 0) {
-		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-	}
 	return fd;
 }
 
-- 
2.28.0.163.g6104cc2f0b6-goog

