Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E068C2C7EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 08:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgK3HbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 02:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3HbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:31:13 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19754C0613CF;
        Sun, 29 Nov 2020 23:30:33 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq13so798275pjb.3;
        Sun, 29 Nov 2020 23:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EsNXvlnoUKD2pZSzgAC0fLx5VDJnXOdVhqeYF4VM7gs=;
        b=JOEzDc6okElYcSppns7/WVjH1la6U1Bw5p7qhSK0IJqmEaHqwuh9tFG2B5MMVggN0H
         AmTQrBI2OitGu8CMagBVTdT2EPudPSyFSGN+VrG0gJUCJnUk9vmEIDwEAyMuFFCzGbAa
         hhC/Y0udAf5zmNB+72YR2M6Ul+0mq9nvGjd/kRL0aV8fMaLGkH6j1s+lEKYnASjexezc
         mP8PAoia/TsrQ6EU45f/rLpdoQehPJCTbfIXrqH1qG49XXlpKUa55ya/my27DwkVwcSi
         0hRhl8ZOkziZrkaYb9DGb/2/oGVvWD9I7tgvY9cY7ucO3d03TOhOpqc0A2zdPdZlcfCr
         iweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EsNXvlnoUKD2pZSzgAC0fLx5VDJnXOdVhqeYF4VM7gs=;
        b=oROou3c4jPd3r80MAZrj71YA+3bj1Ea4SC2Xp7jeZK6mwwt5iFtRCbeAICjk/3lwSu
         iELH9pDcyg8dYeiNdvvlSGfOtrU6lJHV7nhadJu/wGx9ehVZiEBfAafsVh/Xwug/0g5L
         o7JxlPpJuabhB+DYtnp8pRWKqD0rbv5JkiBqjQ7Ozx9ThN+zZ5NIYihUIKNr0FTFbqgP
         kq2VdQrFoxuLDkKALMVo45R6tq3/LlNc6JqkMQQTdqm4VovpouhrRdER6XQJaRONtG8N
         epH249n66WOj5uS7u9RzklnyzQp0/27m0yCcg4bEectYql2EgQ8TCQ8d3IvM4BUJNDfc
         8k0Q==
X-Gm-Message-State: AOAM530kzZIq0gzMwA+VO9F6aJfYesR1fofOtHVxx404rKL2LpJXXOnC
        ft4MKIFfNT/+wIh8/TqRCH4=
X-Google-Smtp-Source: ABdhPJzmeWSfnybsAR3n/WvwFdQBAK5VqwyTCok3n0nJ50h0iqqlR5YIDKGqPhzhritbLkwzXAAP4Q==
X-Received: by 2002:a17:90a:7f93:: with SMTP id m19mr45747pjl.61.1606721432729;
        Sun, 29 Nov 2020 23:30:32 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id l76sm16006710pfd.82.2020.11.29.23.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 23:30:32 -0800 (PST)
From:   chenlei0x@gmail.com
X-Google-Original-From: lennychen@tencent.com
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lei Chen <lennychen@tencent.com>
Subject: [PATCH] fs: iomap: Replace bio_add_page with __bio_add_page in iomap_add_to_ioend
Date:   Mon, 30 Nov 2020 15:28:51 +0800
Message-Id: <1606721331-4211-1-git-send-email-lennychen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lei Chen <lennychen@tencent.com>

iomap_add_to_ioend append page on wpc->ioend->io_bio. If io_bio is full,
iomap_chain_bio will allocate a new bio. So when bio_add_page is called,
pages is guaranteed to be appended into wpc->ioend->io_bio. So we do not
need to check if page can be merged. Thus it's a faster way to directly
call __bio_add_page.

Signed-off-by: Lei Chen <lennychen@tencent.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 10cc797..7a0631a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1310,7 +1310,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
 			wpc->ioend->io_bio =
 				iomap_chain_bio(wpc->ioend->io_bio);
 		}
-		bio_add_page(wpc->ioend->io_bio, page, len, poff);
+		__bio_add_page(wpc->ioend->io_bio, page, len, poff);
 	}
 
 	wpc->ioend->io_size += len;
-- 
1.8.3.1

