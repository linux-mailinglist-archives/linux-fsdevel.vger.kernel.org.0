Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA71E2F63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbgEZTvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389809AbgEZTvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154BC03E979
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so9105652plo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=UT8tDTtjIxNNLckeUW39C1DftMV8tadKSzZHS24JY/ZgL6QUhytEvq2lkIf1qolpKk
         U19xBYg0KGV33rpnvi79D2PmiTq7vV4GnQy/vbDB5t3xuGIzSzGqlvQmaVY0B+9G+GIX
         llYo8cOvcrKG7jjvG4eBsx1q+LF9dT2crnAC1DmoY/wdrKeOH+NZ2+jAdxVlTNFeGy4a
         bQz1a2+aBWm5/WLAaDmlh/4XzvXPR5G3jeezjLE44Z3L1BaD260oHfxmj3fx6/puUmDQ
         a+gZr/lzYlcH0GBmCG9QZp0U8aQKyRwejv/NOtaCLlRLWl4GrEw481VCXscus2avzuQ2
         95Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=dYgfRkQzfOXtlZBFh/I0BkuYS6dKzJh50gFGkcK5ILzWF4CM66QC5V9mYopP5LXc3/
         qofWiIeF9vqGF9fVrzcyWImLt3kV5XrthC9cDjIDsoZRMKvvCf3EtEKVZ8yNNeNbW5ni
         Lx6o66NBLg2q38MppYz+a5s16ONIJW5PBIY/sN8Ymz+ZWsWXZRpPr2EEY2LoPOFPAaRc
         RbXZqpKCs0vA0e1xFm2ly/njdepbhfrswDmIBUWrBVtiTpeDXD8ni/n1Y8QEhzeyrJ//
         xSw5MxDHT/o/WRB9H2r3Zt5FPBZlULtFoc/yVZAW5Qq8bIphjtQWrvZp8b3k5N+Qo8KT
         fBvQ==
X-Gm-Message-State: AOAM531UvyZfSCmEF1JhoP/x0aos/ted/c0FgbLkb5bFWMJoysIyXTtH
        9BEbI0r2FvHN7fHQsXJ/+FogpQ==
X-Google-Smtp-Source: ABdhPJyosEhz0s+kAgLEF75WSYNIzH1LsNfIRNs9Hso+92gcwzjdxDZZ5u7k8VwB526quKNtSk2K0Q==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr930733pjq.226.1590522700418;
        Tue, 26 May 2020 12:51:40 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] btrfs: flag files as supporting buffered async reads
Date:   Tue, 26 May 2020 13:51:21 -0600
Message-Id: <20200526195123.29053-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 719e68ab552c..c933b6a1b4a8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3480,7 +3480,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.26.2

