Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683153AD9B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 13:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhFSLEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Jun 2021 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFSLEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:04:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB02FC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jun 2021 04:02:25 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so12389591otu.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jun 2021 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tayuv2cKNkJ03HX+cu637KFCuEoLfy40YzpTfISUWbo=;
        b=smFixnXOCkQgaILUWGxCVcoursfHNbNxXXOCpPh6N77/V+0oo0Uq0jHh6QOrVU2k+e
         NuJGjFD7HWds3LAIIem4BAhjspTPUTjDTme67lnwLZgDGmCpSbUtXZheNwoxOUTpGh49
         fp3fknk13aOxN6xypsK7TWOBRzPJvwXQeWhTz7mSvKG7V66AYRm7RKEpzTs421cv6GsP
         eoPgDw2V7EXo2rpfTuDZMZiUxeKNjXOlxNngOq/tLYwJAehaLebe2/XXciCJnFGFoMdT
         DRbSVXX4k7t86pYSrfOiw7u34bfF1uHv4iKKig6UYfahPcZJRWn0QD8vsenRpjZX0abH
         QTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tayuv2cKNkJ03HX+cu637KFCuEoLfy40YzpTfISUWbo=;
        b=djQGlQCAnTgL1v5fTVbBtsVfSuW6rv7nRR7ZkuPgPVkCaM6f7Ni4dHSMf7KCWVbp+u
         5mmF1JWyqzoIIsITGka/NBWi/mDSBs43BpJaX/BJ2iYwLNzWecnaNvrvKO2bh69F9oOa
         xi+YlUWI2wpYpmLsjcb5U5jOCWsZ2zrvImJOsqs/wl74SW9CrWhiZplB75/OZbvkjhq8
         3pKky+0RmvsTpIOhYTlihWjRWYEVwUFrzT/rhE0Na7JI4nOF3k26eqzYKhKa6RpDjrbX
         uCqOwtmc/ErWPCyvdVnmkvRV9yoGS5J+QPLds6AmhwSxRnQcOP/eUgAyu90aFlwveZTd
         D2+Q==
X-Gm-Message-State: AOAM530h3f9f88Xiq9YbVdRzxUJRzBXrKdp/XEHiZMO+k5gG3B6BJdmw
        z8o5zi5DjeGTNjRFfqUxXzJpp6B956DOkw==
X-Google-Smtp-Source: ABdhPJyolpnOZlGs8IbLerq36Klg0vq7cBohMTbmexORpEdVTlIdBDGHHmcRV0fCCc72e9DMlh4LwQ==
X-Received: by 2002:a05:6830:161a:: with SMTP id g26mr13068365otr.62.1624100544749;
        Sat, 19 Jun 2021 04:02:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-32-232-216.hsd1.tx.comcast.net. [73.32.232.216])
        by smtp.gmail.com with ESMTPSA id r12sm1607456otc.38.2021.06.19.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 04:02:24 -0700 (PDT)
From:   Arthur Williams <taaparthur@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Arthur Williams <taaparthur@gmail.com>
Subject: [PATCH] fs: Allow open with O_CREAT to succeed if existing dir is specified
Date:   Sat, 19 Jun 2021 06:01:48 -0500
Message-Id: <20210619110148.30412-1-taaparthur@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make opening a file with the O_CREAT flag a no-op if the specified file
exists even if it exists as a directory. Allows userspace commands, like
flock, to open a file and create it if it doesn't exist instead of
having to parse errno.

Signed-off-by: Arthur Williams <taaparthur@gmail.com>
---
 fs/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..58d06709541c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3334,8 +3334,6 @@ static int do_open(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
-		if (d_is_dir(nd->path.dentry))
-			return -EISDIR;
 		error = may_create_in_sticky(mnt_userns, nd,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
-- 
2.31.1

