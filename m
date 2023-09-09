Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0441799652
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 06:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjIIEjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjIIEjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:39:16 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819841FC4
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 21:39:12 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso802345fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694234351; x=1694839151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhvBSGcdwV31C1SYJQtO0sVcH2QZ1kB2UqKoOP29X9Q=;
        b=ic2U7hPd8GeA1nrJDP4AuP40fy5/hPo3ZZndLOEPSGW+JV0KsmIEV0RmEDwRKvovQC
         kR+AnzwB9urGMuv8SxDwUuBmkPz8G3giBWZxm6q1hkaqSfeVJh63yvYEBBqj528uFQMF
         DZtjthk4fXv0iv9xkR/loIEnRZoDHK2zWDXKaQr5E6bQvipapX0XSFFFbGEKxvMQiERa
         ZY8Tw8c0tjAh2kzt7WZEEDTOiQ18tPrmjTMreFABgW6O0Pi77hwM9G8m/hCrTVQXJusR
         qh1IXMLvDjqLj2X8V64d6+v3niqhcaKn5T4nLEeInYaMI0opOwdZkmlJH+c+dDYUXNEi
         4IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694234351; x=1694839151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhvBSGcdwV31C1SYJQtO0sVcH2QZ1kB2UqKoOP29X9Q=;
        b=L7izKOHwN+AtBsLvqT7QkhjcWQSOmJ0EUAJ4V1VeVhRVG1BGON+Wv1Axo7ZDn+3DHO
         9+irM2nmtmZOQPeDMDYfuT2hjBjIHy8bnyST+n8jlfv+2JRoooNJbekxtM9HsMYD5G7i
         ZicIEjszSs/Wl2QNSf9MaIN4Hnu3ktP5wI5kQ5hIy2kQq6e2GTZ0X5BMqQ/6xSAKqy8Q
         iRXAsYQUIq8S9WAxwFqLIxwu+4IXgANMXFdshu/yEsPZrvglDVn8+j9wgnPQRlHyufRZ
         lI3QUHJWb4TSZuUoZ0pDce+fU2AujppqAN6g8zO8BwQr2knxQKBHvRb/iyIxAiC3LoOD
         Mpnw==
X-Gm-Message-State: AOJu0Yw7g4V+wlvPjQU56PeI+TUKPnsoys5im2+b9SB2BJjBfiiAFZyB
        RtzBDd6MEzM8NjBRNp4pmUa25KxX1Y8=
X-Google-Smtp-Source: AGHT+IEljCm1qQe6NHT0otp5XyvH4bz9kXZqIIh5oRiaxOiAg7DDw6Niw3Qkxo4TH3IekLdaBikPBw==
X-Received: by 2002:a4a:b382:0:b0:573:4a72:6ec with SMTP id p2-20020a4ab382000000b005734a7206ecmr4395882ooo.1.1694234351297;
        Fri, 08 Sep 2023 21:39:11 -0700 (PDT)
Received: from node202.. ([209.16.91.231])
        by smtp.gmail.com with ESMTPSA id t3-20020a0568301e2300b006b8bf76174fsm1339645otr.21.2023.09.08.21.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 21:39:10 -0700 (PDT)
From:   Reuben Hawkins <reubenhwk@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     amir73il@gmail.com, mszeredi@redhat.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        Reuben Hawkins <reubenhwk@gmail.com>
Subject: [PATCH] vfs: fix readahead(2) on block devices
Date:   Fri,  8 Sep 2023 23:38:06 -0500
Message-Id: <20230909043806.3539-1-reubenhwk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Readahead was factored to call generic_fadvise.  That refactor broke
readahead on block devices.

The fix is to check F_ISFIFO rather than F_ISREG.  It would also work to
not check and let generic_fadvise to do the checking, but then the
generic_fadvise return value would have to be checked and changed from
-ESPIPE to -EINVAL to comply with the readahead(2) man-pages.

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 47afbca1d122..877ddcb61c76 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -749,7 +749,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    S_ISFIFO(file_inode(f.file)->i_mode))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1

