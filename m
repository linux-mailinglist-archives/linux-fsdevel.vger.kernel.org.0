Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291F1E2F5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbgEZTvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 15:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbgEZTvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 15:51:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB8DC03E96E
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so10629619pfk.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=yFrvO5Xl3qNEXOkExAlKW5HCKxIsDSMlTDL6yu/qdDNmAN9gaTkhr8Ji+yI9XJMB6r
         Yyj0QZ3VaFi/iX801MVu58AB5V7toUQ/3YSKHrzjYv7i2pgw3diwzJ9VU9sKkiQ+CqO5
         +3TnFQnSzV+5hEs5v5Y4SsfGIfcKj9q7W3SSj/g2m24bxPjK6B7OSCJCgOwvDr/T+fH0
         FXKEQYV/edda3rOI2u6He8F3YutgqUpDtRr1cjsP0bBekPjb/tjeT+Zdyk9nrP1RvMHF
         IL3sBKXh1sO3XzmReF4iBAlL3BzPeFNzf+QnoSzUJnqeO7X206hePi35FPbwAjeQ87ro
         IySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39qQrTBLEctUrGanLy/C45/WjdVfQkC7faPzmr+qhpI=;
        b=M2Oo/Puy7CN8jJ/dbhCcC4jSWNXFriAfnY8hSyYy5dQzdK6c6mfI7TaYHVxSv1V+qT
         ERoQob63NQZDbuISPxe8d6rkDTOP3PpMzzoKVpiZLZASo8xCDbX7Z7kJjwuiYeuKL1n0
         MmN2I0moqfv1Gc/mkd+IwMJhAfYlwtPreRbrGHO69YyNkwXdtr4MQuWgc468AniJM4KY
         8Co2464assbbq3S13DTNf4zdrPTv4FYFzrjTQWkXObV9mLPEvrtucubdxmdNxn9fkgIO
         9ROO+bgow0nFQy5Cv4KRrzSvgeSJn3CfBoho5zhKbFAjH8pWCk7qL351tsvLc43ciy/C
         bhgw==
X-Gm-Message-State: AOAM53214M1dTgmbtLDRb6BwN3h/67xHbKX/DTGmaNwZaNBW4NdYWli/
        qvSlY473wT/H0p5RsVfB3w2pXw==
X-Google-Smtp-Source: ABdhPJywnc6qZ+WtihMTbkb+pFwn9JjcTK1HqNCVBDIVrphWDInm6gN1LVPRjjrnGs3CvW4hueDaXA==
X-Received: by 2002:a62:14d6:: with SMTP id 205mr417227pfu.75.1590522699174;
        Tue, 26 May 2020 12:51:39 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:94bb:59d2:caf6:70e1])
        by smtp.gmail.com with ESMTPSA id c184sm313943pfc.57.2020.05.26.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:51:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/12] xfs: flag files as supporting buffered async reads
Date:   Tue, 26 May 2020 13:51:20 -0600
Message-Id: <20200526195123.29053-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
References: <20200526195123.29053-1-axboe@kernel.dk>
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

