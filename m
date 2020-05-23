Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBEE1DFA79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbgEWS6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgEWS6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FDC05BD43
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:11 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d3so5765659pln.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=aKd+2/L3zhcWktix7GTJLEddQj7iHGpD8+Gbc5lZhZOPOtmfTJSybdWwo7P0uIA+5v
         nw2OIz8yCOB1kQ+IBoWa2qYrd11KuhOSiTCgjz8Jjm4+Tbl8Cf41Vg52NSUaa9pR0Tks
         pkC3Lt4M+d5mqE795NFN0OzGrct0KwdthHdOM6Z+6CVlf/5eQQtIf3ehLbgkfuqZc8TW
         LGTqI4HsD0RR6mx2SM2tRYFi+hbvTahsWpdHb5Bev/u13hAyTFgVlHtEXxkQ5BzcNmAl
         BuEeOlr0w8tDobCzI8GcOwgNnklK24cTNiXcD+JIsmWtWOcPcpqxO21EEftbMqyXTPz1
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=f2yaho1MPu8DxjHTSh8tZlOfFeJMX/ewZr/HG7aXcZW7DulWm/k9L1cAHxrlWh/LYM
         X9+RduuE7PGetPGnCtUbgP2pz80QQKxA/gjuX3sq/Z31OVIpi6SFdiXZkLu5OQ4cK2MB
         z1yH1wTTB1DqA54qGKhX8HnhXHEA0D9vvJaBQPo4SaH+IuVJdGnVjw+Z+qHWIBRaQ6Xf
         COjq6lF5zW9AWOzaUN0HsS09BrydjIartc36iTgBaHpWWUKK1H28xD/2XwHayf5lKwbV
         I3ZEOxtIvIxKMqd3MLtWLUIiVpLr8yvTCB6AQFJA0WO43aQILnPhr79xX/X8TM7QvOXZ
         FkgQ==
X-Gm-Message-State: AOAM533ItKzTE4Qpi3TI8M0KAwekfVnFSkLcGNh0k+zzsgPFOlI3QY6E
        DxlhgbtY4fahjKnbAGo7nZZF/Q==
X-Google-Smtp-Source: ABdhPJzz+UanoYeeFHEpf7tdaIQvpR4HprzsHsuIgK/sPHYRYz8bhbR5K4GsEWQ0YkbTx9slFOzW/g==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr12921445pjo.64.1590260290884;
        Sat, 23 May 2020 11:58:10 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:10 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:52 -0600
Message-Id: <20200523185755.8494-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

