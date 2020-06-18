Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4D11FF52B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFROpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgFROoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7FC0617BF
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so2861520pfi.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=lmn4EHxlosWk2LKyZRbh3uHZDbpZvbZJJ5zRlTFAsKo=;
        b=ynTJluJ6Q99yEvMTa6y10W+u5+Z89pdb0A+GuJkEPIQuhyxpm60zb8aV1UgTzM49Cg
         7mYXB2z8mtKRwGfC7oa8zmXN0NeqZcMk0nfEZAsWCQC7qS69O7EfAy7bvV4ntFSDUnKd
         s1HYlH3UUvMSO05JqooeCBbZY0ZRIjrWWqeXC7QjivnX5Jt0UXn8Nku5Kkav004uevwG
         8PUXkLfmKjS6G8DCuicClsmZmNXcIm7PbrbS7/OqZObQQHmkmS+ttktTCCcqchSw4mb3
         huoY15kQX2Ms3nHgl6XAnHvSp6STkjvZO6hPs2x+GSzE549wVTux9mlLhmmuwEge7kyC
         Whmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=lmn4EHxlosWk2LKyZRbh3uHZDbpZvbZJJ5zRlTFAsKo=;
        b=Tm8NFa79typLIzDuhAaHsLft9kBQisy8lJ0kwaqXzDQ5bRBW5n0hwNPX2Zp2bBnBqN
         5uLRcPE5/jwRbSLizOrJBEALOIEWwAofmAvzDzPCuMLiD+GJSdAOl/XsZDQkj/vobvL0
         CpDnGnjmsiWSgGWJj9O83XtC3JCQoc+Kjc6tr/Pit6PPNut+M0PYR8srAC/VqUUqpcn1
         mA8po7o2ozyqYlpVqNTPFzo1kWezxrmDwNd4ts6RLwWPJ+ld5DanNIm19dJ9UbSnSOGU
         35qojmEBBKeHR2qug6gLEzIwcVS5e/jeFISn3FNqTSkY89xKn2XsZ40vSocV4iOV/xS7
         PTQw==
X-Gm-Message-State: AOAM533NOTfIUB2xK04+ufYgEofoAyBvsT/tAx35eztM4AG+TeNo1n/X
        hHH1p7YJIBXEr2otnGinCGpe78xljZNB6g==
X-Google-Smtp-Source: ABdhPJzBNjEb2EomZLOu+f8/v3tw76mKzCcpM8kJeYEd8Lb2xxqO66ZxbvFvynHQ19qXPAAGDtGMUA==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr3518283pgm.172.1592491452832;
        Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/15] block: flag block devices as supporting IOCB_WAITQ
Date:   Thu, 18 Jun 2020 08:43:50 -0600
Message-Id: <20200618144355.17324-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
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
index 47860e589388..54720c90dad0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1850,7 +1850,7 @@ static int blkdev_open(struct inode * inode, struct file * filp)
 	 */
 	filp->f_flags |= O_LARGEFILE;
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.27.0

