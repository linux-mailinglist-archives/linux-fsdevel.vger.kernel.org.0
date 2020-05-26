Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5392B1DF3F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 03:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbgEWBvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 21:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbgEWBvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3071C05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so5124706plr.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=Kc3axrOr8g6RyUGzN4WwNP4r3OGAumLf5kpA+8EMTGVWnYe4InoSbthNtLq1X9D5rL
         y/70lT4NweSq/L9I+SQszizll3X1bhdvfgWCfGCUgfqEiYqwq4KOs5PPlO2zrn7ySz3n
         p6/slYwB2tCt8M5c0gMvijxmOFPa8UOS6s3JIFa6bts5pYqoZE0PkZWFtnfOpUSaNiw0
         lZz0Z88hp5u2jk5VRbbMuYl4y2jMfKWR9ssIP6RwMcYOtYgcvFgP6xNUwen9hzMo+Rg8
         MYZ9w5zMVgDRFYxQWw7WKYyDNB5XrSk4xd2d7bzTVnY7wfZsZxBdWjhHGlXlSbQh4kFd
         2F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=KBzXE7xvGpn4yfgLMisZQC4k64mg01Hs4HU6VhaCwa48z57mEbY9E64Wf4DJoh0f24
         JNQldhvuIdvjwrW7pEnWZ7VcDxkVYCcErWjp/iiqMScqL9gSEkq306iHBcCslNhk2/sE
         OLYT/StdKPSu1ewcADJSfoKAE0CPlzBbSvueaV+zHoYiLqp3iOt63vofTqLCHYIRl0Lw
         JXNpwArVr4BenyQVANWE5qKchIfSZhZhT86zpXNA696MT/Az/Bx7IjhYEJaaAL+HCzzg
         lYOcGbyrmTWeVjBvRg/ZRDHXoGgZfZPAwAl3YdThDrvPfrpqfTf58jTIu2NUP9WCJtD/
         L+2A==
X-Gm-Message-State: AOAM531yp3b7OwJ47Q1nnMqLcZ/ttFT6W80YHtq11qFxWS4DnfGhIbbp
        ObE1XgfTh1Nfclj8LMNvI9cV7w==
X-Google-Smtp-Source: ABdhPJxcS/HRQUwxMhKYNzvxtXy9z9SbHgXgGovyXvDbUCjxMMj2BnFCWsV8TcdQI7La9/Hb3uSngg==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr2047286pjq.156.1590198667421;
        Fri, 22 May 2020 18:51:07 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] xfs: flag files as supporting buffered async reads
Date:   Fri, 22 May 2020 19:50:46 -0600
Message-Id: <20200523015049.14808-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
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

