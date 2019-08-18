Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B1391826
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfHRRAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfHRRAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:00:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so5506288pga.5;
        Sun, 18 Aug 2019 10:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nEEbHHdJo3J9AWmv4sfl/bvoNMJ35SzSby1tOYDy5S8=;
        b=b54tQzYSsRmCAlJyh6Kavpohs0OdJvZ9UDjvuR2AoSoybX1ntN0bftuCQ/XShiI+vF
         o77j5EvbgujPkihKMGvkrkwT49Xd7cRCwb53xGz2gQMmNONshxyytbDFBjE56rQRzC5k
         EsUHvclx2o5wul7wGEkU1dCg7ebKj0yqp1B0E0u2u133bdTPkmdaXSJLsA9YJx4XL1Xz
         2nnKiNJcuqRJgjBMnKTxkvkUjAmHh09TWq1f9QH+p+Hw/wbDn/liGZsYi/xmieu1DJzV
         m8I2cfmvFL796976kmGmhFlGqMJQ2yCkgdhsP2GLv6nqxzBKoBlOyBmkpUbFYVlaXWY4
         urAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nEEbHHdJo3J9AWmv4sfl/bvoNMJ35SzSby1tOYDy5S8=;
        b=JtRyk6EP4KUwejxJG+VgNhIsXKPU2FFNvBGQESv5M9ec5NTsaLpwCFALgUUFK4/5eH
         q2Bjr4HpeEWD6vMwGM1XXo4z0lxCap+WRlV/4DgnaFLuEkuSMXV6DXWIb2HSN6NNsK0O
         51z02cnuOiWAl9luOXOoTlPudOXzKSVeUt7bzq4gBbgDggmVhQGVxroyTKQ8lXmJ+jrj
         EDTRQu3E4Y4ZFDmpktuoW/ONGa7vPh0AAhn+RejCM/MsqD2UJCtRdyppXhwwMXiomit1
         hx32sA87nYlNSMUMvvUHIp0tZA5lt3KrSVWWbe00O5IF/AECKRfTWn9bgaSPRHZqJkJC
         ZI8w==
X-Gm-Message-State: APjAAAWlqVbebH12G8ecjGnWh8fam/UcQQYJET0aLh9G7ideRXa6R1Ou
        OwTJCGRAnx01bJmkL81JXvI=
X-Google-Smtp-Source: APXvYqwRhXzRs1zzMZIezaq6/uw6Cob7hLAY+JhGzjIvW8SRcCJqm9Plm4qMhRGHBZ/z/Bj/huu8Ng==
X-Received: by 2002:a63:2bd2:: with SMTP id r201mr16161226pgr.193.1566147605323;
        Sun, 18 Aug 2019 10:00:05 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.10.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 10:00:04 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, me@bobcopeland.com,
        linux-karma-devel@lists.sourceforge.net
Subject: [PATCH v8 18/20] fs: omfs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:15 -0700
Message-Id: <20190818165817.32634-19-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Acked-by: Bob Copeland <me@bobcopeland.com>
Cc: me@bobcopeland.com
Cc: linux-karma-devel@lists.sourceforge.net
---
 fs/omfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a835ec3..b76ec6b88ded 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -478,6 +478,10 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_maxbytes = 0xffffffff;
 
+	sb->s_time_gran = NSEC_PER_MSEC;
+	sb->s_time_min = 0;
+	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
+
 	sb_set_blocksize(sb, 0x200);
 
 	bh = sb_bread(sb, 0);
-- 
2.17.1

