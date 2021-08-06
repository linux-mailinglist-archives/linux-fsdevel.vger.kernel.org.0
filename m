Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE33E2973
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 13:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhHFLXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhHFLXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:23:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F46C061798;
        Fri,  6 Aug 2021 04:22:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso8643180wms.5;
        Fri, 06 Aug 2021 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd6SDWe5bP1W9aLKeKIqrkoSJGtHDp+fK9q/kasAchc=;
        b=TsrhJeomucBYTnCk3vTYAMK/GujB3r3QJHd/WsBX3YzZEcrd5qiU5qSX2nbGkCVxDW
         dLXVDg3xB3jmBUEIov8a+ILVRvOEq60fjqnUuBpNiJeWY/MRA9CERGfS+WYC25dcdgsv
         XObImycmWspbAAawI6xgy4W9xf0MN3ggD/le73GCcOtXU7ZXxE0i1VQyw5aeT87k4Ri/
         +NRHZU2JGFQh7mFz4MpTf4ND18HbEhQct+ZMec4vbpIVtONY8f018adIl+Wc1hho/ou5
         TcydTpAdtyUUuL/aHyiL6GLa8xOW7k17GJViHZmnPP4WzRWGjeNN1nxi2yov/cq9pGWg
         MGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd6SDWe5bP1W9aLKeKIqrkoSJGtHDp+fK9q/kasAchc=;
        b=RYBIB5AtTec+Efy8fyiIzO2LO1rTVxwlc7FMSXceGKRxjIBjNbWmeytNuMX2r9dSnH
         Rwz0kGeA7UKJZaH6tfHVKXL3v+NMQWThFYi0adNYTBp46BnkrdwYBt7y1Ke/z3oghqzM
         VjaY4NZV2fhJeY4Hf2ACrqiZXKVJ3RGOZ3u/dLABUnJDUueQVG2NAJJmNVIqiNxXcZy4
         xAuVsxPHc/4wVY9YBEfHuyJgS/ScI1gVTbSSSyQkHMlUXwugVXBDT5T5NKjRz9UjYiVW
         eJXcUekSd0xabsQBrtaxyBJOvfNuXAysjY9upW9CASzSeOcZak27ZbTcLWpvh998NQIE
         y0Rw==
X-Gm-Message-State: AOAM532WrhUa8mlN69yTfEnTjvMGDqNZs4B1pWsRgucxaR9N7i4WcUPk
        Pz5VBKk1EuR/ZNa/kNJjZLQ=
X-Google-Smtp-Source: ABdhPJyOAVveugaFzsVI0ZfcFSXOUGGnR+OLUhC1bNuCMSh1Jrnlq1ocE5eW5xN3Leps75rxSlynBA==
X-Received: by 2002:a05:600c:2942:: with SMTP id n2mr20073552wmd.152.1628248971542;
        Fri, 06 Aug 2021 04:22:51 -0700 (PDT)
Received: from localhost.localdomain ([85.255.237.205])
        by smtp.gmail.com with ESMTPSA id j4sm8285654wmi.4.2021.08.06.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:22:51 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: optimise generic_write_check_limits()
Date:   Fri,  6 Aug 2021 12:22:10 +0100
Message-Id: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Even though ->s_maxbytes is used by generic_write_check_limits() only in
case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
if it's not going to be used.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/read_write.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..db662d0c3cfa 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1609,9 +1609,8 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
  */
 int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
-	struct inode *inode = file->f_mapping->host;
-	loff_t max_size = inode->i_sb->s_maxbytes;
 	loff_t limit = rlimit(RLIMIT_FSIZE);
+	loff_t max_size = MAX_NON_LFS;
 
 	if (limit != RLIM_INFINITY) {
 		if (pos >= limit) {
@@ -1621,8 +1620,11 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 		*count = min(*count, limit - pos);
 	}
 
-	if (!(file->f_flags & O_LARGEFILE))
-		max_size = MAX_NON_LFS;
+	if (file->f_flags & O_LARGEFILE) {
+		struct inode *inode = file->f_mapping->host;
+
+		max_size = inode->i_sb->s_maxbytes;
+	}
 
 	if (unlikely(pos >= max_size))
 		return -EFBIG;
-- 
2.32.0

