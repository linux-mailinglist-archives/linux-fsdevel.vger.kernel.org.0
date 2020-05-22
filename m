Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C261C1DF08A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgEVUXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgEVUX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80E4C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so5409476pjs.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=vqlZYMPww7j3TOIyzxvdW3/q03eVxx/Kt286FLeusp48yDbLJjq0ln6B43V8FbVo3u
         gcdL0IJhfUQanWN/Su6LcPlVskFIZoDE79RbCWvLDvXaYW8oYUjtUGwaSS93SvGaudU0
         Dmja6SkC2nkNK/NZLi3mUHjaKvMiJ/q8BaDYHmBkAv6kq+6dvO1gdhPm3I6e7U2GPx7Z
         Sku/pU0sVdVBRuZriAmdEmXAdP3CLXjBAnqwV47vMFExFJB+158uymcq0+DXz/+vg0wR
         VHJyh2+6hv06m8Qe7Kg6r3uwm07yOeKHHjJ3925Ov3RZPMIzvNUdU2EAIEb5ptM7pC09
         w09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QX6izj81MoWvGB/E4/khaJEguGwrdsEfxjduXmAWvc=;
        b=l/QGnraHIbUXoQZIZmZ+Umdc1xQsZcL/hDFTQpxIUC8cOyNCBUU22+F3u19kn5GBOn
         DM9l5WaxRZYFFpHl42v2zgvesc5Dcwyj964XcHAgH9/OhwRjWSlolCKDJ5FafCRIEdGy
         /GoUDj4QJRMpNVndmuVzQBpW2lzgLPg9ICS61LnmWfpqLYWyERtz/cNnB7+ZqfDshJbp
         S6dwP1nNdOqdeCysuuBnpFSyByGBzzewRKwzRLvjkLPuIG+ye+c9X7eEWo9lrCIsVzA7
         j8yXZ0v2JL6rwGifSaPFDKPuKMMHSHDrQG8fImTlzTM030N2gdJ7tlvUQbNhdadpYtnD
         akDg==
X-Gm-Message-State: AOAM530yczo3QDiRX/bx9RSF+9UC8tSxWtXvEf5nM/BUf5IDRU2Dalw8
        U6+lv1gfu5wOQLqk7tK+Ct9s2A==
X-Google-Smtp-Source: ABdhPJwXSAs80allPBjJsy+8cK/RjOwPK4cXYA3LyZ3dlUNMHIjbWunnLsScPWqcRL/3fjvWEVHJEw==
X-Received: by 2002:a17:902:aa4a:: with SMTP id c10mr8642851plr.0.1590179007178;
        Fri, 22 May 2020 13:23:27 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] block: flag block devices as supporting IOCB_WAITQ
Date:   Fri, 22 May 2020 14:23:07 -0600
Message-Id: <20200522202311.10959-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 86e2a7134513..ec8dccc81b65 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1851,7 +1851,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.26.2

