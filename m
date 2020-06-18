Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0221FF528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgFROpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbgFROoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:44:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FCC061796
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so2991133pgo.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=agiR+Byeck2s775I8LSKf8tm0BQVQsWoO+u3QsmIwcE=;
        b=CmsR4pnk1FMjkbrTWikiw1ru36jrxC1tfShgKpQNL5fwTTR48LJzuB0WFeslN0A8R7
         yVhdczhT7rCHZGNSPImdCvg2GFHYjPZq3Lo8LN55YdVfIqbcMnyIHIfCWRTp7nIlWoCP
         8mIA0QOEOodS5hrggItuRz50XlDx1FRg2U51ti0K2K6RLhv04afTVM85LjEQHy1K3put
         aih63C1nllRb0Y93OtUHEJJE5MygBtOKi6TQwE2EGgx2382rGAnQZJ70Af+bxcWW78if
         p90wfGKQkPEoYPs0wXfDt35iVSEZ+5uCYlZohmz4//abZsAjr1a8x2PskDZN8j4J5CQD
         CYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=agiR+Byeck2s775I8LSKf8tm0BQVQsWoO+u3QsmIwcE=;
        b=tnljA0G5yysSotr5D7W3Kz3LElR+5y7zVr6a3D8R5JXx94ldyuRRdb6weVWsJv3l0l
         eLa6Jm5JnTGHg7IWy+uPwH4Uxf4BKyCFb0GXd+nzBUdrx/8M8nmrxABPTVyiK/Rv2euq
         sulCLLhdJVP4ff6DKQLZvwL21QT/5/dTanHH12EvmPwzU8yL4MMXydnyymkC9wCQcQ6B
         Y4dcw/C1A3sReZqqJp/izWU0qRxTOrycnAJNrwZ85Zs6VDJWzw5abiRGF2a9azn1/cv+
         0FAbHghvAKAB9cT8q61yYqS2OwBxQ7RRPFGTvxgUf4tF8+qWbvbPGi2lzo4qtS3BVvJC
         6I/w==
X-Gm-Message-State: AOAM531BNOlj+Vd9JxDj8cxLkrNRdSGpdY4D/XpFAz15jhRQxcpQ4EaC
        ioPmp+eLfOnfIlsGQ7sNLeLUXQ==
X-Google-Smtp-Source: ABdhPJyNr3+kHnVN8fM6oIP5PSOO4gsldaD6y/PdYSuuK7cpSwrVAwO5ubxT1Qc0fzuBScSDRUwL4w==
X-Received: by 2002:a65:6558:: with SMTP id a24mr1850398pgw.110.1592491457531;
        Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g9sm3127197pfm.151.2020.06.18.07.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:44:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 13/15] ext4: flag as supporting buffered async reads
Date:   Thu, 18 Jun 2020 08:43:53 -0600
Message-Id: <20200618144355.17324-14-axboe@kernel.dk>
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

ext4 uses generic_file_read_iter(), which already supports this.

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..1e827410e9e1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -839,7 +839,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	filp->f_mode |= FMODE_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.27.0

