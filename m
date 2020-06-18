Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578CE1FF529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgFROpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgFROoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD60C0613EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so2866910pfa.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=qn8Ub7OYxVXKid0SneeEv6VlK8roF4pAhw3PBRQGk58=;
        b=JsQWJAr0eX5i4/3VH0JUUcbrX1hvyikPQulQivfaSDiMps3VzdLvSQq6dC4JKqWrJw
         KNxWMk6jyBDtv6zAbNsi8EXWu/yzVZs9PhGYrbDhl/fbSE8G4wRID9uPFVW7kqxk71SV
         0TMZ2olNJApcg9LZpxFyKjUmCe4HMfr+UszmCR8CNyND2jnymuGfLJggvQZrlKsGiP5H
         olUIpqHBAvyxiNTFfvQ13/71tmHFNQyLLqdFLI0ERuAdJTxyxlimD9W8/4OLmmmYJWbC
         NDlNdD05mAC1WxkMhISVU5ejMHN0Tp6Wbi9rsSKqKY3u8ZOVaCzS4KBi9ffc4A0l9I/a
         Yiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=qn8Ub7OYxVXKid0SneeEv6VlK8roF4pAhw3PBRQGk58=;
        b=FQnxOi7tspte+t5Z5BCTSOo7P12I+/LJjDMvHFqZtxt/VOFTIXUvVuoJXenCD9TmFq
         iBuBToRSrJvMmOkSaNcWccopIRn8eqxap+zc99YBsvYrbHJrvzY+JCDYou1b7dM/Owp/
         nTePk/09BbX76UccvKRz+c2NT/COPZF8j0feL4o4FJDdfUICuAekMbqXnXNASQUwpQrt
         NnkBPB0OpBN4a8NWBIohWRvDlS5SZ0SgYmlyDCZh6oflUYAqJY5IHRF2lazQeEx+7ADg
         OoOIBiy/xR+oORKBgjaAcljD67lpufkt6Wc8GOC94xAarIqHP/pKiYOYeyZbFEtw3LQw
         yZZg==
X-Gm-Message-State: AOAM533fgx3OJXu4jNRYxfS1ca2QPVSxZS+kiLyGEGwVjAG7CPL5vDfE
        co5Dcjb36HhIhDKoNheCOM6NBw==
X-Google-Smtp-Source: ABdhPJxqRDix9IaoTIWmuLrGVEzpKy6hFma+ZgZz9Se6n9okXrRAwv8gfsXZq8bmQZ3+Gotx4PSctg==
X-Received: by 2002:a65:6119:: with SMTP id z25mr3404328pgu.52.1592491456371;
        Thu, 18 Jun 2020 07:44:16 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>
Subject: [PATCH 12/15] btrfs: flag files as supporting buffered async reads
Date:   Thu, 18 Jun 2020 08:43:52 -0600
Message-Id: <20200618144355.17324-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618144355.17324-1-axboe@kernel.dk>
References: <20200618144355.17324-1-axboe@kernel.dk>
Reply-To: "[PATCHSET v7 0/15]"@vger.kernel.org, Add@vger.kernel.org,
          support@vger.kernel.org, for@vger.kernel.org,
          async@vger.kernel.org, buffered@vger.kernel.org,
          reads@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs uses generic_file_read_iter(), which already supports this.

Acked-by: Chris Mason <clm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2c14312b05e8..234a418eb6da 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3472,7 +3472,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return generic_file_open(inode, filp);
 }
 
-- 
2.27.0

