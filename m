Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D231E0220
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgEXTW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388212AbgEXTW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8CC061A0E
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:25 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so6701299pln.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=AYei7bDKo4OkFtepp3xg4zfIw0hnd0Ebv9o/8vOyKbFHZ8InT64M5SLPyKbX5X3sUK
         Fkh7pM1hAJFMjnux/MH3PsrYNU/IaoreI0I/UUZHTe9NxJWQKmxRBMtdWR0udtiIbeCb
         FbxxIyYfHNT7MeXwmxuPM/7LHoWK8VkstsOX8wEOu3N5XhIfsuTIrmRWTVi0+n8wkRb7
         DNDwTBRW8SzP5mVNKj3+C6xyivFrnnJeUTG5ro7J3AmMh1Q5eZRP+8NIJUqmNnigS3cu
         DHQtC5SBLkYMeJN9r23BQVb8ndCYHRhxM7a0nMmr6b8oFKNZjU2N+KNcXWF6qvyESK5u
         YF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=grloRgO4vrRyjHYvv/H0bCvgbrAcF8skoays0kKFsZh+YCURS0wXHXk43Lg3xc3IDz
         7ev970AWKw9M3tbVQMTg3/Pvw5DrNArx2VzzfM8P5A/iqVv6/S3C9W89YLcJpdAsjG05
         1vfdcuvFHc+ZcP1OtRalUz9vGT941YfOlLTnDSVEC8DY5EHnzo6tMv0DdFkL92zeWpZR
         hxJCWymEjXbeEZQ5kavYaRO9RQxO5Lays5f3yEDdV2IxjSolFl3B2RekChAK5TYQJoCK
         ay/Nut9qQ5EVgdWdyOHeEuGxs7M11nsCMQI38ZRDZKhhyJSo8rU0eS0tTxK+ppkF3rc9
         N5AQ==
X-Gm-Message-State: AOAM531yN7VRDr/A97HiFFdI2TS69HnzaeucmQqlu/sLhKu8wfCh/LRF
        BPhTp/hxfrBMF5A6xIvoM1p8WA==
X-Google-Smtp-Source: ABdhPJz6bGpR32ObwKt+551KDTdoAZNVR9ZlVB3PlXK2+knHsCmS9S73FZQgm9i0pCo/tlaxVlOxZQ==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr6482101pjd.33.1590348144618;
        Sun, 24 May 2020 12:22:24 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Sun, 24 May 2020 13:22:03 -0600
Message-Id: <20200524192206.4093-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

XFS uses generic_file_read_iter(), which already supports this.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/xfs/xfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4b8bdecc3863..97f44fbf17f2 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1080,7 +1080,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return 0;
 }
 
-- 
2.26.2

