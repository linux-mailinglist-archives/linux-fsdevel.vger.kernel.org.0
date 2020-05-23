Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1231DFA70
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgEWS6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgEWS6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 14:58:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95615C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 124so374881pgi.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2020 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=SDURcEf2V5NO/4iU1aE24OeWSLHMCXpJdAgFrdnJEd7bIgxaZY8OsCWvWhzpOJOtb7
         RA+oFu3X71L4OYZdo4lWYTXGqp8MWSeWkbW1ZPXTUNI/+Qc/A6l9IJVklr6G4fHvvyM2
         eSkYQ36gSdm3LbIvrCiTfPKjmIT0uHzq657/N5EqmkFU1X3ShnSc8TgsHYOsTlmDtjbs
         fhQgttgwQveWyVOwYI4QoW4GE276osyEbPco1QcSxndNWxRvqeb591UYbiXTc10MOx29
         fpGpdY3/b413xwsNy5DGpoifG0/dhZFZd2GrucUQb1vlwz2jFn1Z/Q8UTQqIGSSktfdg
         vdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDbeWlveWyEr17EututM6ewZlLrenoq+wrG4TB+c+O8=;
        b=UM35d60z7gJH3tApFvXxtF8rC50Tgn23AlgKO+wz6nAvE2Z2di8lAnJ/TBox7H8uzN
         nfdwnU5rgSZK3i1mAwcPMAaPzE0A+8h/n4bdRc/e7xjndD/5nEMA6Oo4pcdrGNuyzafv
         K2RpofpBWA3v0GvdjskobsGvShrjWAwG0Iixbl/Ex7ykGG4rPVddK6omHypEIbE7TlTT
         0ggQ8rGjmMNhFRSoAZlRovjhHfSE+tKWkds9uGZiGVRHraMSuXBfwoJV7G5hIS8tnqAx
         b0CwdJJx7iw69j65JL60KyrRb1hjQQo+lZH28nXWVmQg1dLbB+G4R7rY/Zxwj5Ag4Uou
         W4aA==
X-Gm-Message-State: AOAM532wPth0AEAfH6ZgaiRV3muKqrcnrNQBIEew7mCzrUL/mkIJCCsw
        RKsx78+MdLaGg10pJO71VFRUmw==
X-Google-Smtp-Source: ABdhPJyltVIJNk8C4W/9AMto9tWC1IL7mnDA5eVGXtM6JkHvLgYtWln7h/t01grs2y91cUsPUSnHHA==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr19101914pgn.378.1590260292180;
        Sat, 23 May 2020 11:58:12 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:c94:a67a:9209:cf5f])
        by smtp.gmail.com with ESMTPSA id 25sm9297319pjk.50.2020.05.23.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:58:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] btrfs: flag files as supporting buffered async reads
Date:   Sat, 23 May 2020 12:57:53 -0600
Message-Id: <20200523185755.8494-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523185755.8494-1-axboe@kernel.dk>
References: <20200523185755.8494-1-axboe@kernel.dk>
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

