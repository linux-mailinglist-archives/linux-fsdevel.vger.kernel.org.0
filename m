Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F471AF5B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgDRWvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgDRWvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132D3C061A10
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s9so4671078eju.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vI+qH6PQl8iOTuF91icuURnJsbkLpyoxA3JGpFFvgGY=;
        b=BydKuw3C1yL1Zrxj6fxlQJkXD633PCUQ9qVzyPGmiKRT14W89wfOFNSS+Hn26SuP+5
         Vo8HJw8MYYtBGBAka0mqnlZlMMpd0ptQhbl7X6NKiKmz4XXv30cOi6hUfbAMo1UA7lWS
         aMU2m7g8WpHmjULDeYJfoOER9Zb+JUo/YdxUvVip7Ug9p+yE4waD/O7MAU+DT11IeVhf
         eqz4E0nWeK0hqywttveVAT7SDsG3iT3349J/4hDoFu+IhWgBCaLPqa6KndDTuxt9G1sG
         s72FVBDp83nZald1aA+FeIOXFjl43cVKu/bvFr+ZUIbsx5uGs5MIlycbgyxqgGR7wXjM
         J6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vI+qH6PQl8iOTuF91icuURnJsbkLpyoxA3JGpFFvgGY=;
        b=LiMG4LaTBExJTe5wmbZxGx45oxStRYrilnd+1OLi8d2xi/FcA0wQLHZxCbgN+8ALa0
         tg8/lywm6J72nfyiCm7AsQZ3oVjU2Ml8ejvkXR+7QwlG+lal7UZs4nVZotj5OtnHUmEd
         8oUaocF9WvR8/ZcdnWRXbocQ2gbIsQaQF5gaqf9xQ6o0e7TfFCbgL32a7ZHOqEAIj5A4
         sw54+DXZeoD9DVrA3d9ICacKrVkZhnIPxwWDArO4NoZTXyc5E7dCeHLMHLCPQixBkH+z
         zs4SBUymSWXOKqqv5p94rFfTeL1hQ5G9iK/GIe/3vE0S1/a0rY7PED6WB6XXauJdM3G4
         1X3Q==
X-Gm-Message-State: AGi0PuYWDBO+nBJVNnGh0aPBkErFHSJXvpt70WijKMIcBC6k94FCEwnW
        KZQP0GSisBzw/efSVKqZ+y0DCg8Utu9GfA==
X-Google-Smtp-Source: APiQypKY3BdcqjF3Tf4l/0w0TOoBeBknIwydV9wTBcWqQDgCxj4Pnxn7JcavMI4hhcMA45D9jzledw==
X-Received: by 2002:a17:907:72c9:: with SMTP id du9mr3995735ejc.146.1587250290578;
        Sat, 18 Apr 2020 15:51:30 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:29 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 3/5] iomap: call __clear_page_buffers in iomap_page_release
Date:   Sun, 19 Apr 2020 00:51:21 +0200
Message-Id: <20200418225123.31850-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After the helper is exported, we can call it to simplify code a little.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 fs/iomap/buffered-io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 89e21961d1ad..b06568ad9a7a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -74,9 +74,7 @@ iomap_page_release(struct page *page)
 		return;
 	WARN_ON_ONCE(atomic_read(&iop->read_count));
 	WARN_ON_ONCE(atomic_read(&iop->write_count));
-	ClearPagePrivate(page);
-	set_page_private(page, 0);
-	put_page(page);
+	__clear_page_buffers(page);
 	kfree(iop);
 }
 
-- 
2.17.1

