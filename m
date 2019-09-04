Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715F6A8927
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfIDPDS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 11:03:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfIDPDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:03:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so11394900pgi.6;
        Wed, 04 Sep 2019 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7uLKsFf8UaYi9otI506qs+jXJd1+G87udMLmTQyNAO8=;
        b=hINAEv2btDn7HKYL6dPnq8PM7dvrHAdbK/Jqkovu4vQCEm2kaNaO568Tb0m/Z4BxhU
         G1e/IeSg4qsECAaZ5/iVfI7bJk/AvjEQaWcYz8ZbWvui+IPvznBZu/kW6vlRjSLqijSU
         YDXJYIFjF0oL1B3K1xBz7SuUSVCczPyStX05019DdhfC+NUvJN5wez/G7aBtQ7MXg1eM
         r5HaCD6z5YjEzI4A96m2fycpBzgy6B8o6Jlk7DWWKqSUOf5k0oFGeCk6j9LhnkJGSw/S
         vBFDXMvIW1yNJyOql4Zq1XYUsKdUHsY3OkTprgcB2qBP1JFNnAYm4rsgJezfW0gyvWbr
         T5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7uLKsFf8UaYi9otI506qs+jXJd1+G87udMLmTQyNAO8=;
        b=t8GDa30I3ds6wo992Fp0tDI9j1+PZRAuq8E7XTK9NokkBGenv5J/RKk6KN6HYg6gNK
         V+m8jOspCn0Poel3LL0IXIKpYnHpSrid5SQdC7I6r9NeXeMCBc6ZzkMa5IawxQg2drAC
         MhKY4oDkxiZlzztTXwhNNZydbiedEGaMh80gZKPeCRseiHc7Hc2Au0oezqSnRU3GF9IX
         rOIcp/8F0OvOJ/VU5ndYhoPLmwwxwQJjGY916+/R6q2MKz1EiVTOCBGf/KmV1aSOCzHI
         RB9DaJpQNknvw6DZ4KhXLX+vLLLoUuJh6rgXMJJKtki9KMShStpZ4JvaQBAGB+0ppJAQ
         qgPg==
X-Gm-Message-State: APjAAAVXmi49JhEa/k1C+yjwqggsKdncEqrta01bq8wfN0Pl6FfvnD1s
        5/vw91FpMGWJzFKi/0bkT5E=
X-Google-Smtp-Source: APXvYqw+K+rOd4gyctDvzKJSvTHtwjiu6imCFvIG97cnEI/NeSrECWN+iVxL79CR2Npz0aRr3Da0EA==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr36102490pgk.355.1567609397741;
        Wed, 04 Sep 2019 08:03:17 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id g2sm26349972pfm.32.2019.09.04.08.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 08:03:16 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, cai@lca.pw,
        deepa.kernel@gmail.com, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH] ext4: Reduce ext4 timestamp warnings
Date:   Wed,  4 Sep 2019 08:02:51 -0700
Message-Id: <20190904150251.27004-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <31a671ea-a00b-37da-5f30-558c3ab6d690@thelounge.net>
References: <31a671ea-a00b-37da-5f30-558c3ab6d690@thelounge.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When ext4 file systems were created intentionally with 128 byte inodes,
the rate-limited warning of eventual possible timestamp overflow are
still emitted rather frequently.  Remove the warning for now.

Discussion for whether any warning is needed,
and where it should be emitted, can be found at
https://lore.kernel.org/lkml/1567523922.5576.57.camel@lca.pw/.
I can post a separate follow-up patch after the conclusion.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/ext4/ext4.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9e3ae3be3de9..24b14bd3feab 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -833,10 +833,8 @@ do {										\
 		(raw_inode)->xtime ## _extra =					\
 				ext4_encode_extra_time(&(inode)->xtime);	\
 		}								\
-	else	{\
+	else	\
 		(raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t, (inode)->xtime.tv_sec, S32_MIN, S32_MAX));	\
-		ext4_warning_inode(inode, "inode does not support timestamps beyond 2038"); \
-	} \
 } while (0)
 
 #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-- 
2.17.1

