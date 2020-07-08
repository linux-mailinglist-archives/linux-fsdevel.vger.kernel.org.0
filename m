Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E351218456
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgGHJwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGHJwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:52:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C07C08C5DC;
        Wed,  8 Jul 2020 02:52:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so20615460pgg.10;
        Wed, 08 Jul 2020 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uXoXl8/1y/j7nPsVmJseHhrJF5XiQs05znGEJZOBZ8=;
        b=A5CJo1ZxDAYBmoD9C3rvsPznO+6JycDycdMwgxsHX+j1QuieL3wg35GNkjtERxLz6j
         DI6kLhCoZ+3VAa80POJ4LibgHlO7oXvX/hqeoDc6JDjjNT48UGFE9PgEd+M85cgYEYSZ
         PpAyTEXTg9cB9JP7uxz05yuJmhctQ1MlGFWSOMIMc0AaR44ziLHPCEtjKHxQe1jDICQ4
         RlBa1Y17gcCPLzWLGKjZP0JUN3/t3154Xl7NyoesS8JhTm5EyL+HryK4FghKcaVa9cGd
         CSg8iJQ9U9TteotyI0aH2YYdda4CycMJVlRHInBjgZROA2PZv6z+ijRdlNiKlnYSuyjD
         Jl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uXoXl8/1y/j7nPsVmJseHhrJF5XiQs05znGEJZOBZ8=;
        b=Yv+xR6ZydIctcYeFLiWDdie8KCNJMCaArL+o7Dx0J8TCK4ueL6sCjkQBhte01Cxm0u
         9Xyp5dwnEfYAVvCAPhEKJg3ITS0FZe31eN9YpiKWRKx5XYzl5zxqm4f7zztYgwdPhllF
         5pQXdhCDIZEP7+MZxjOcdy96Rq3v9He+J6tuTlUcaOMbCLq6uFYMN6n8OZw/g0bpSSAb
         0sZMALfyeYnpE/njOtyQjuWNZ+C6CRs18zMRaT/Sh12/iP1JTPwU5kvOMc2cZF7vBGqu
         bFbT/hLKbqvDyYvfnK6O14Y6QkHZw50V5qvilr+J11OK841EAlxULdi6YJZHjC9fw/qw
         9dbw==
X-Gm-Message-State: AOAM532HBDYpzym67vSDq3Nv0YvE6i/VKEON5d8PH4peMUdEdrZvVwBh
        ZTb7z8WLlyG33WPvlTLe+h7i3CKNpPAUXQ==
X-Google-Smtp-Source: ABdhPJwwY9vjbL2kr0eR3IHlFZebmDGsxlNG+/tT0bM+RSmn4SVVUAjgIfg/Etx5J7ki0dCTkwG0/g==
X-Received: by 2002:a63:7054:: with SMTP id a20mr47155904pgn.17.1594201958740;
        Wed, 08 Jul 2020 02:52:38 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id d16sm24761257pfo.156.2020.07.08.02.52.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 02:52:38 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] exfat: fix wrong size update of stream entry by typo
Date:   Wed,  8 Jul 2020 18:52:33 +0900
Message-Id: <20200708095233.56131-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The stream.size field is updated to the value of create timestamp
of the file entry. Fix this to use correct stream entry pointer.

Fixes: 29bbb14bfc80 ("exfat: fix incorrect update of stream entry in __exfat_truncate()")
Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6707f3eb09b5..6bdabfd4b134 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -177,7 +177,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 			ep2->dentry.stream.size = 0;
 		} else {
 			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep2->dentry.stream.size = ep->dentry.stream.valid_size;
+			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
 		}
 
 		if (new_size == 0) {
-- 
2.27.0.83.g0313f36

