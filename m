Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C61E0225
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbgEXTWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbgEXTW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 15:22:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57175C05BD43
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so7646604pjd.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 May 2020 12:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=uRHMeG7h0qyUWA7vuWqk7MVYR+0HFA9+hLVEVjHnDq9/bGqeemt5utvzvZZgUdnrIy
         U+lba7Qp6iQLZ4c8z3yex1xsl7NBK51bH9ntOiA1bzrAsnflM9kzXN7kNcJ7N0emlteQ
         f6PTLXDnlvMvkO0+xbsF0n3KM+R3esV6iaI/VrxgFuKg6m/QCwh29NieyfZ0bGIkLBzC
         N0tz472lFi/FcUthEq7qQBwQ8YXqMbnsRrwlnS1p3BAEfpEt6RqH5JLCBFEKqy0ijFcH
         WD0e0R9E3NAVkMWZKPvQJyEy1N1km2FpSHT2g5nK9H0/Uh1ImNoyNvY6xNut1BwqV9ew
         Tb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=O221G0Y2NrL4ZtQ+68nHrxNIOWARxQoGzxBqcr8DU2p8p2qYc7UbL1luLT4E7yUVjp
         VMZ1eWYB4OL9I4dcjLa1HPEMOkk8sYSolczXPUG9TolewOhe/DZJoWOdTnWoof1pEaYz
         JYQ0pshAjCHszVittDCwpVjt3Q89wAmpc/UlFYuWm2G7UxU9oQN+4kpqGzQaqqyVof8J
         ZqM3lk564fzvP+73PvjezftLbrFtPJa5ChbTxOMU7Vn9she4tY5PKszNvXCZ7dOAITfT
         hstPf2J3PRHI03Dmp35J71lqcfkQTx0WnNBS1kMUf441K0qjd8TYlEIU+z6YLduGSDHg
         TgkA==
X-Gm-Message-State: AOAM532334HxU09jzJd17+8TBTVo5UsUL3kSuLTATBufSRThbyBIzDoc
        6f5WrSYYbwIuZTnHeoBZ8vvDXA==
X-Google-Smtp-Source: ABdhPJx5oK/myeVn3bRCetPZQwQdNS3kfvzT2VTrfAxdR1BbKcm7G7xwvH5T6Twt2b9anXcaIgaOgg==
X-Received: by 2002:a17:90a:fd85:: with SMTP id cx5mr16698146pjb.146.1590348145904;
        Sun, 24 May 2020 12:22:25 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c871:e701:52fa:2107])
        by smtp.gmail.com with ESMTPSA id t21sm10312426pgu.39.2020.05.24.12.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 12:22:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] btrfs: flag files as supporting buffered async reads
Date:   Sun, 24 May 2020 13:22:04 -0600
Message-Id: <20200524192206.4093-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524192206.4093-1-axboe@kernel.dk>
References: <20200524192206.4093-1-axboe@kernel.dk>
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

