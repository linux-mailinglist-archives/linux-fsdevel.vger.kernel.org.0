Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B5A1D708E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 07:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERFzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgERFzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 01:55:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95954C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so4327209pgm.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPKPZdLWYhVxpx5jrV/H8h0jtqWmPX7wH6A62qnOkus=;
        b=Kdpre7Exr/pMZGU8QiObZ4ZYPthvQzzf5UzH9ShzOMaqB7qV271cLqRWRlDhna2jMb
         DVm/UT04r0HB83+/3jJJjOf0vEXktU3iLJWXT+ixvegZsUIA5oFmKv2L6Qos/AG5/Kr4
         NUb7howiZnwR14Y8/i+ox9g0yzgIzizw7d/L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPKPZdLWYhVxpx5jrV/H8h0jtqWmPX7wH6A62qnOkus=;
        b=UOiWryuTFqSVH+7RmFiK3iia2SEqSUcm9lAFRMuGIA7qDFgNVZ12g8z2NHEmqmbiQG
         0rxNS6C4tSOlxQWj42FAbr/NBzxxeh9rWhn/5jUsXIcQwLtS9/sKA9WjRHuLMRuSxD9R
         ZAvZu67Cvlve18GZwFTV7AcauKXGnqNbmY9/YlBVUudhhWAH/22PxW7YkKOtkEshVAsa
         7zvdI3GudcXKhWZaRZIx8e71NY5CiBs9WkFJinlOKQNnJkOtWkR/LXcBqhXbTUqb397p
         LgcpyrUZmCKOwwymiKeI+U3ZH4oG29luN2rsKKr01WyYU9h8pkHlde4DKAuF7+RdORCp
         asoA==
X-Gm-Message-State: AOAM530+mvMis2E9N9jviTKf/Ix9ztEpy+bjojh1S4sBmWkviKXC1w4g
        azI07I6BLrZ+Pr0cqZOXscJG5w==
X-Google-Smtp-Source: ABdhPJxhtS996OCWMkgpeKohWlQufYcB+/tWiUrVycuLTEmz6Rc2lRetBKELSdXVfqF4RuGByiW3Pw==
X-Received: by 2002:a63:2bd3:: with SMTP id r202mr13454738pgr.130.1589781306161;
        Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm7490235pjl.32.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Date:   Sun, 17 May 2020 22:54:54 -0700
Message-Id: <20200518055457.12302-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518055457.12302-1-keescook@chromium.org>
References: <20200518055457.12302-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
the behavior matches execve(2), and the seemingly documented value.
The "not a regular file" failure mode of execve(2) is explicitly
documented[1], but it is not mentioned in uselib(2)[2] which does,
however, say that open(2) and mmap(2) errors may apply. The documentation
for open(2) does not include a "not a regular file" error[3], but mmap(2)
does[4], and it is EACCES.

[1] http://man7.org/linux/man-pages/man2/execve.2.html#ERRORS
[2] http://man7.org/linux/man-pages/man2/uselib.2.html#ERRORS
[3] http://man7.org/linux/man-pages/man2/open.2.html#ERRORS
[4] http://man7.org/linux/man-pages/man2/mmap.2.html#ERRORS

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/exec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 06b4c550af5d..30735ce1dc0e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -139,11 +139,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 	if (IS_ERR(file))
 		goto out;
 
-	error = -EINVAL;
+	error = -EACCES;
 	if (!S_ISREG(file_inode(file)->i_mode))
 		goto exit;
 
-	error = -EACCES;
 	if (path_noexec(&file->f_path))
 		goto exit;
 
-- 
2.20.1

