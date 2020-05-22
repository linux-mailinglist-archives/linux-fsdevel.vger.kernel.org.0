Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521751DF089
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgEVUX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbgEVUX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 16:23:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4794BC05BD43
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so5411051pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 13:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=dDUvxjbstbHn7Sjiy+FPAA2PEvxIM7GifOiRJeDAMSbY7yuZnnZssNPrW/E901JJmZ
         OiWeE8x8Dullp8KQX0tfScd3zLgJ5dqFDExo65YjCoSluEuUiua3jP++fR5YzUqru8zI
         NXVTSEKuAtwrG/ZRrJptiR6rdkUh3s0gV2rnNOuBXEHCRFP2f7G+O6Kd7xTEzLo5d7O6
         1kKmpbdn46318RaR3RoKDqSBHERhxohD2GZV8Ws+IOrzVKyuazrQVmIYmUbQkjczdFs6
         4tMUI5bcGqqrmfzKTUnEqt1xwSLASC838o8d/OH5NWXSrzKDy3ZhjDyXw5k2B4zWiXIr
         qkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=DqKlJlGXquwa1ZQGhgCSegrBY5qUce2Y2H8WkyuVltZG64L6tsHqCR6MAwyF8/f8O8
         djpK3UoU84zs5qbZESsHfbCJkGvwU3j/7z/NbgqkkwBn3BsuTl1KDcA2yL8lRKtT9wMV
         3JtT8MUKYrYat5YKab/2jNzJDhZ9SGEjBwPjKg6Eud9/VcXclMKTYLBAlAq9muRpeDks
         b2/QBbm2ficlgpCjWA2nFU6jLceYf+YOvkahj9DMApsEPcrvot+7/0BmSXWJEhbG+QtH
         aCwq2lTG5rtIU2RnKM/vU3PA2iHinq1U4D9oTpQNbVz3hfXIaj3rZcDqxfTBERkd+coF
         e1Kw==
X-Gm-Message-State: AOAM533y1MHU6y70JSFyAagOfhepThr7gNWJ2U7GdNuE1MCzMBC03Gc0
        wVm2xSCVtZgaHUGwojPrXkJfyA==
X-Google-Smtp-Source: ABdhPJxHHV8hqa7uaJgKGvaQpHrwfQ3OD8pDgEG5RnHU/xBhEFUUXMnZAbPdGq2y0/Mjy8qPwsjM7w==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7mr16387892plb.136.1590179005767;
        Fri, 22 May 2020 13:23:25 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id e19sm7295561pfn.17.2020.05.22.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 13:23:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] ext4: flag as supporting buffered async reads
Date:   Fri, 22 May 2020 14:23:06 -0600
Message-Id: <20200522202311.10959-7-axboe@kernel.dk>
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
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d624250a62b..9f7d9bf427b4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -826,7 +826,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.26.2

