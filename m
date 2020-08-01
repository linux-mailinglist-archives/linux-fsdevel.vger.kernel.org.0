Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256D02351BA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHAKii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAKii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 06:38:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F61C06174A;
        Sat,  1 Aug 2020 03:38:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so7304531ejb.0;
        Sat, 01 Aug 2020 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqz4aqY/bLtRz86OcwNjOWqVFrJQP1RdLh4tx8zW7E4=;
        b=POK204KueaZ+f8craETK8myo945mHWVOy3UWIcucqFxpWOfAmFh80MHV6UMpKDRkEj
         /e2nsSAvjlQpyJ0KQBJZfX8ae0KgBr+ftk1Agxv9BOlNnDg5kz7HUfPULDOgWEjLf8Sv
         FIuHH13PuFZRYRknv6afWtT23A0K/xcrJm9Ox9kwes5YfUV2W7f0PretjRJ8i8Kogxb6
         Yuu/AWF5S0uEFYKva6NLiQjV3IKvgz27vkWemlgxUzO7hJmP80CdRkTp/FUWc+14W+7E
         JHvtdoGpG65bPmKo3yJi/svqlgTZa5xu90vD8JjQrTXLHwsn0eYn8txmKkUThbBflW5f
         JZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqz4aqY/bLtRz86OcwNjOWqVFrJQP1RdLh4tx8zW7E4=;
        b=h+D901Kv046yp+JBTqLu1tbjot4DWd6JhCF80MKq7HlF+GQ2Lht4Q95rDXVVGQLFkt
         M47zyAoUCJgnMmLRgZ6m9P1yKrm8UK69C4g7ALctTwStz+vcsrsHfoFRQIOV/Cywo8Iq
         3nMeCG2rtnUQZ0EMAeYotR7H/8TtuCA9vcHvkP9cJpPrOk+FJuY7GOtZDKSpJajgGmHt
         ShkhFWqkHjhLH4Yg7t8187I3fcDw+AwjZFBZHAACPfvX7no50azx6RkMiJ62f7yPekHJ
         AyoJaxiPqdO2MIyNmGYfo1GLVOsFYPEmW48KjvITJsUauM+xnVvDnC0401ETVOxa74vC
         Nn0w==
X-Gm-Message-State: AOAM530kEO5AGZstedDSVKizXkB/ykeORm0fJ/ho7ulTe36DpJM/sVW9
        NOLRLflkExfGK/ybAKyQJ5e3JFUF
X-Google-Smtp-Source: ABdhPJxk4XwPcfn0jWfUZRR6GWHyrJcd47ExA1Y7nzAb0VJDqjsXNQjECMaJPQqI4JRR8VsWxxJOrg==
X-Received: by 2002:a17:906:8d5:: with SMTP id o21mr8570861eje.155.1596278316325;
        Sat, 01 Aug 2020 03:38:36 -0700 (PDT)
Received: from localhost.localdomain ([5.100.193.69])
        by smtp.gmail.com with ESMTPSA id w20sm11133375eds.21.2020.08.01.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 03:38:35 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: optimise kiocb_set_rw_flags()
Date:   Sat,  1 Aug 2020 13:36:33 +0300
Message-Id: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a local var to collect flags in kiocb_set_rw_flags(). That spares
some memory writes and allows to replace most of the jumps with MOVEcc.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: fast exit on flags == 0 (Matthew Wilcox)

 include/linux/fs.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8a00ba99284e..b7f1f1b7d691 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3282,22 +3282,28 @@ static inline int iocb_flags(struct file *file)
 
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

