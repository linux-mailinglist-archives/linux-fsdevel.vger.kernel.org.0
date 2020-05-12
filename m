Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F01CFE8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 21:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgELTnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731042AbgELTnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 15:43:11 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60471C061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k6so15456684iob.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDftBJHTSVWUMGmOVvO/pH+pahE34h/2CLqQbMrb1kQ=;
        b=VzOhyBJ50rj9y88lIuva7HYzzznyCm0H+hG7FD00dWc/TiDJCA0E+1yzh9jKD03Cfi
         kSccnBPJ+dd0SV6w5izzhPQuEkkxsawS6RQRRTCRL1INujJo/0rcYEQ2llTEpm97/DVq
         mEJYM55GogDCJuBTiXAFQQf9lmZRzfKSyTmK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDftBJHTSVWUMGmOVvO/pH+pahE34h/2CLqQbMrb1kQ=;
        b=bkZlL39CONG4KwgTxHoiQjYqiM4mbMa4VVj1te1e27HSYpRS17QtWAK0+WQg9C3u/n
         s4FCDjNKznyhravnC0lgjiP/Yg3nSykHVfC+HrHUN7+l9ocKBlbyHCcCI6qV1EflyQyy
         +tUttwuovqTLbONPluaZoc26ZrBU845K9fLx49aqQyiiyvu8RDlM8wklT4CH4PcVXKcR
         ZQaHyGuALPefluwfYOMbo9JiQ5nRTOm5DcqXMlbRXwjTqLz44UHs4iMJ1zeq2RFEMf4l
         Ef8GIwFz3C0FrLBeck74oJMl4vUnwhBKwxye5wV5p/jTR7E+lPRJA5FlurgqPvtWUwUV
         Cgnw==
X-Gm-Message-State: AGi0Pub+5696FZxWTAHaQSYkocQ1dgHuXND/wsJONi8hJCpf6v0QukGD
        zx123x4ss7XSJ2NTupULbvDDWQ==
X-Google-Smtp-Source: APiQypIsGCeZQw29/QluF60afoXeCbOYKr29SjbfKMLdQ5jsD5GwNaMMwLiS2ovQFxknpVAAqHt+kg==
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr9897803jah.38.1589312589835;
        Tue, 12 May 2020 12:43:09 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f5sm6177781iok.4.2020.05.12.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:43:09 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
Date:   Tue, 12 May 2020 13:43:04 -0600
Message-Id: <71cc3966f60f884924f9dff8875ed478e858dca1.1589311577.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1589311577.git.skhan@linuxfoundation.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags.

Change it anyway since failed fdget() doesn't require a fdput(). Refine
the code path a bit for it to read more clearly.
Reference: commit 22f96b3808c1 ("fs: add sync_file_range() helper")

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/sync.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..300ca73ec87c 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -364,15 +364,15 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags)
 {
-	int ret;
-	struct fd f;
+	int ret = -EBADF;
+	struct fd f = fdget(fd);
 
-	ret = -EBADF;
-	f = fdget(fd);
-	if (f.file)
-		ret = sync_file_range(f.file, offset, nbytes, flags);
+	if (!f.file)
+		goto out;
 
+	ret = sync_file_range(f.file, offset, nbytes, flags);
 	fdput(f);
+out:
 	return ret;
 }
 
-- 
2.25.1

