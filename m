Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13931A2161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 18:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfH2Qvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 12:51:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42135 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2Qva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:51:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so4136342wrq.9;
        Thu, 29 Aug 2019 09:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax9lthaK3JhQ59ymHdiiPSvPPTi+y1ZSO3PCkFb2G5c=;
        b=ihD8QLtJevBClQBmt7qVK24jqzxyAW5XpySoXrPKXW+9LBP22kDWd4z7HKKtaA8vTj
         kjV6+TJ8gT+BApAlM/rtjIqzsFZYEIcaoUfEWiF5EZhVFZj+X3zlyUEEn5oJlKHxB90q
         re9S/3yf8dgCKuU1DJ6k55GUGBe1d7y+u4/SQtWaovWTptCU5q2i3K5aYzB3K7/uSLGh
         BYKXPUfSdsalFCsZyfuHHy67tF/z14PfZz1+FypFpuIR/DEeiGrLHOt+ra4ahY3SF+Ay
         Kv+xDPYbEcI8zuRVj1IsqsQDW4NhXduDkmcVtuuzlzBUcjButcp4g2fndiBBWl6aX7LR
         60uw==
X-Gm-Message-State: APjAAAWxfo45RmlAr/4RW1N64clRn5kbjFdhfR6vZuGeQS0SlHErPZMg
        FXQjoaxmZomub4Wl4647/ozDuf8e8sw=
X-Google-Smtp-Source: APXvYqwNCX5KpCkJvjt3Q24LOmT9KyMwfdz46BXc98KC+dRLdeECTISprmN61E3Jdwt/Xriho/gXZA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr13825551wrx.51.1567097488358;
        Thu, 29 Aug 2019 09:51:28 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id o14sm8340770wrg.64.2019.08.29.09.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:51:27 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/11] fs: remove unlikely() from WARN_ON() condition
Date:   Thu, 29 Aug 2019 19:50:19 +0300
Message-Id: <20190829165025.15750-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829165025.15750-1-efremov@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"unlikely(WARN_ON(x))" is excessive. WARN_ON() already uses unlikely()
internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index a59abe3c669a..9432cd5a8294 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -776,7 +776,7 @@ static int do_dentry_open(struct file *f,
 		f->f_mode |= FMODE_ATOMIC_POS;
 
 	f->f_op = fops_get(inode->i_fop);
-	if (unlikely(WARN_ON(!f->f_op))) {
+	if (WARN_ON(!f->f_op)) {
 		error = -ENODEV;
 		goto cleanup_all;
 	}
-- 
2.21.0

