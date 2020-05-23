Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6727C1DFA7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgEWS6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgEWS6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AD8C05BD43
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so5737520plq.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=asMd1oaZIyB4OBJhuDDS6Qm6IETRfR3fCCxP9jAEJSZo3FYau0gIpI9b/WsuE4N1KX
         RhGUBNuuUrL+ZAlmaNkDbor8+W1ob/cE5h/o3evKIKCN9RWGAgjkY9nVj4AsDXFEOxvN
         jC7XVMjV1it0HHmhL0OxZuSDp/Abrk9rCOqaJil6/D6M7OiW2AtqylxkNCV9an6DjayG
         vOHDb15eEsnEy1dDiJMsIiXcTlcRPgEl8h11Wp/ZpqB/5F1uv0rEg/I9CQ+o05PMPjC4
         Y320pJtBGjmXFef+eP+mcAHwtpvSBcWWOC2sJdIvszbOHJlfXMWF9y09acccBUgWfqzA
         3Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SUIxRwptQ6YWj2W/l7Dp7FzKmS+sjQ+qLVh2r/v7CQ=;
        b=TJLRGpmvAeVrtSbvFNt+YlTsIr7iseMeBu/4yxV2hUCLYGEI/E+fjw7oavmc3hLNNg
         vceSNOTlln6eO5erMRm7RjHqXAPb3RNCxnWwh89vz72yv14lGCF/7VVOAj45UZ+Rc5HJ
         eyteQBYcOWNxMiQwL+GonJMngh9ynBZSF1QDlwCR0+enw1iP2U/ASDqYi8x2RHDcpyuW
         TVkv9bXyso0KsYKY0Yo/kb49B1WSuZuw0KPXFhmHWH3G5Urvjb088jDSfLIw4IH4D5IE
         j7gLk/JQa3OVX5Zoc4Mdc3WQsQogLhVI1soWJMy72iqddJUJv5UYyYf9PF0ip+XYSIyV
         CWPA==
X-Gm-Message-State: AOAM532gJDTaOi77wmvnAkDw8XeQ+AOI/jKkws55c7/CcBdaPcd2RBYv
        /SAZ4dRQ1CoDVYbgj2i/GTAg0g==
X-Google-Smtp-Source: ABdhPJxN9tF6/2bYMLjdUOX4WlnRkytgiqQRjaUtCQS8ug7GAw+E2pO4OMfyhBqrcqoO8mwzIxyTZw==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr6737530pls.185.1590260288366;
        Sat, 23 May 2020 11:58:08 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/12] ext4: flag as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:50 -0600
Message-Id: <20200523185755.8494-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

