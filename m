Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC122A933
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfEZJf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 05:35:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43869 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfEZJf6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 05:35:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id z5so12133612lji.10;
        Sun, 26 May 2019 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlsLGGue5NzaOqNGq4CRCj25EgHuy55qJULT51w7Sg8=;
        b=kgffFgbWHPphtY5PBVnHsRK2xV+X9po+LErsWTqi3oEEnTWIskEIXVxJyo08fF+lX9
         LhbXJo91v5iSeJS/BELs2WJ9RFylCAoQ33w3luSxCMvyRn5dtpo1fy+FulNGjI5T1ri6
         5+VrLjsISiHnvdV0mEYJrDTA4onRE43jeFAkvj16+Gs5huNaAEGFERpI1xKcskUjKdMK
         dG5fCu4lA0XonnRpAroyIni5r+MorPStfXycPAeXJMMBc8iyhIQXfM/PfYZJQuQK/iI7
         ywgWzuwS1UoR9NlemvLz1tJIJKD6blqeewVCt3NX/maUT+W3R4XlvwqWO3u9nquDmJrY
         V7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlsLGGue5NzaOqNGq4CRCj25EgHuy55qJULT51w7Sg8=;
        b=q8TJX0zRBjtwcpNIS5oWc/iLaA/Yu+FiP7VueunK7i2XyweUziGukJ2a7xYLxRvxIB
         iOmf7j334iXsgKnFOgQv+6A+KYA3jz8wnctlNCsPMG6KWc1Fw+gm1X/7ZltEj7BRnDXb
         wldeOnOuLKDsOBPJ+iTu4b127Rmg7kIndVZ0RwrMQqzx1j+SlIWIBxRwsT32WcjL9ctL
         A2dwa7EJcs68/vIa9S61QFACiXf2kNxqDqDZ5fFEg4dD6BM5a1kZG0mfoD+tcv7U4Q1e
         JYgZlujQjxcd9AIRDPu1EWv3nTvOMKIvu0M+ABKUjD084b3oli0+SR0BZRXkCp3PWh/W
         7E8w==
X-Gm-Message-State: APjAAAXS4MpnRwYBHoTEbNDKPhEhZ4snw1PCvkp33qwnyj461jI/1dtu
        uk35xe28CpCrfL3wv5/xC9A=
X-Google-Smtp-Source: APXvYqzXI9dUMnt69jPd5UMR3eiQUOvTGInlLgUoTEn/5HuMtyAdh4rh7sxCznDuGSmvz1rVjsqJBg==
X-Received: by 2002:a2e:1284:: with SMTP id 4mr27143486ljs.138.1558863356611;
        Sun, 26 May 2019 02:35:56 -0700 (PDT)
Received: from localhost.localdomain (mm-78-96-44-37.mgts.dynamic.pppoe.byfly.by. [37.44.96.78])
        by smtp.gmail.com with ESMTPSA id n9sm1563426ljj.10.2019.05.26.02.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 02:35:55 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/1] io_uring: Fix __io_uring_register() false success
Date:   Sun, 26 May 2019 12:35:47 +0300
Message-Id: <f9e0372fd0e52ca276bb307da1271908cab4efb4.1558862678.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

If io_copy_iov() fails, it will break the loop and report success,
albeit partially completed operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 310f8d17c53e..0fbb486a320e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2616,7 +2616,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 		ret = io_copy_iov(ctx, &iov, arg, i);
 		if (ret)
-			break;
+			goto err;
 
 		/*
 		 * Don't impose further limits on the size and buffer
-- 
2.21.0

