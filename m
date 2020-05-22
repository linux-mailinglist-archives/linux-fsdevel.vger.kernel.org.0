Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217661DF081
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgEVUXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgEVUXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA2C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so5460702pjd.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=j03IEEOgnJZi5ko1SE4Yy8wNORC5fg5JXAn8lnUJFKJf5u/9dtYUczkr1QQ/dY+CIw
         YbVVb3BBuMMxABnx0zlKNSYyZAx2G/vflHNqNmswq2TJutNL0kOMepkLngLrig7h+7oS
         ujgpYoMXH+ou8n5IPuIyRW2ix5asnqvPP46P0HqNUYH7oKiQNM6Gy67i1W5isZEwKih8
         OTvGPMeLn3efqm5Q2B5hhdq3U99RA2/4x0ebaA+WMXodP8rzwBFVxmSU86YJMleSfBMh
         TSp7hC+jwel4pfOL+8cOo7SxKq67U1+bTqluD9pbOs9RqNDYvqh/DBv78Wf6IsfF5oC2
         lSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=t+ExmdEIrX6uMEpF1z3omfHnUQ5y665LfjHLXlTSypibcOYAy52B8EHlxXE0B7F7NQ
         XZaXlql8n6yQZw3N3Cxja5X+HFZ9SEvtXZ9UbcC1zdY5IB9y6lcwDzgQu990nMeDvMn0
         AXf7SJxvUN6PeKNu6GrsL9ROoggLYRmcfhsNqKkVzivjQuCRtnxkVYpFcZPGgcwJ6x7t
         cjTHW0xbeEOHXso7NcEoZ/O/UAO32pI+S+VY441mnk1Eqb7HU19nPKFAQgFKl98RWFlE
         PqFO/xZqRhJLlEjibhGgSrpk+U4zD8xei2Jxy6+mWqvDDtMpvp+to7gOU9g6e6btXU6g
         9dVQ==
X-Gm-Message-State: AOAM530gIS0PNr1G1x9+RsRZBp8Rp2dG6edlkhqmURy2RF8XHqzYlhb9
        HuwIIsJ1qBZukqmOVEMnForXZg==
X-Google-Smtp-Source: ABdhPJwGQW7A98JrKpyFk925FUprxECV23C7TpnQ/+SA3VA1Ed5K0vN07mxApztvyVgBXrkD+DwUvQ==
X-Received: by 2002:a17:902:ab8b:: with SMTP id f11mr17078210plr.145.1590179009960;
        Fri, 22 May 2020 13:23:29 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] btrfs: flag files as supporting buffered async reads
Date:   Fri, 22 May 2020 14:23:09 -0600
Message-Id: <20200522202311.10959-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522202311.10959-1-axboe@kernel.dk>
References: <20200522202311.10959-1-axboe@kernel.dk>
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

