Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAB7A9F80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjIUUW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjIUUWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:22:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA4D6068
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:26:32 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so1296080f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695320791; x=1695925591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXl3XjtNY+qQUGAfKFbAOhIfMu203xufyzo0Jfa0XyY=;
        b=AQyqw2hmtvETPkConD+HqIROJDoLoeYUUTKSVHkSRChKrZKZqoM0fSc4Tptwg5X2g6
         hajOmARPPIea4P+eu5IAMb4/1uerV1LomVWMNW9np1zLTXV1DCnF+ejH0x9Nan2exwru
         wFV0u2q6Xc/5tYZi5RsDGrE+m9K8KH+UH6BS7f5RVgpO4UeyEvLSMZ/3PLAqwdUzvQYI
         8HImRxLF1GVWsV4vJOyF4CNYTkDS0ex8isFW43OqYM90tWTTTcQM/sY9pNxPN/lUxuXm
         7yem40xKM7Aq31jfizI7YYQm0mDDGM/BurmvtymsMqKA2ee7stnTe7jSHITD6zD36hJI
         FZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320791; x=1695925591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXl3XjtNY+qQUGAfKFbAOhIfMu203xufyzo0Jfa0XyY=;
        b=PngcV0a+w2iPchygNd7SskyxRCQAHMMZrxECFo2dcDDKDWIeMD7PxC0T3DD9L+L3vn
         e9HDvaAn0ZsVzZ1EK0hmca9la+7TIAjPa579DNJ4x255tTWlL/CHxyUTx0HO+AwW0Ujp
         oHNvRNZKI+6gYqWVCu1DCRU4TR3Z/QtNZSd3iN6t0XsBfK1MAZtZI92WS3s/sc1DULnA
         /w1uaaQFBxrseJUBvZsU358q7yekS/mWkOWZI6/EQ+i1rQfI3/iZwdp8t92V08KSSpQE
         EoLl3G0e8KSwn3XwtM98vJbu2e/9ixT0dR06uYjXFbnupohMxJrGO5cSY/FUxt3Bj/OD
         EUEw==
X-Gm-Message-State: AOJu0Yx79PCZcE1bnAFEA9Q5fVL1oRIAoZ9k+Up7xD8B5f39Acie7tai
        fhYDvM/ouBAEcmkWXvG4w29U3gp7AkAffPRSCd8=
X-Google-Smtp-Source: AGHT+IF1pBtqoHJupqJB89JDTv8U2tPiwASllgBiXga49KhWXGoCCYdQLyGMzig5D0GLqGXQxvk2QQ==
X-Received: by 2002:ac2:44ce:0:b0:503:f:1343 with SMTP id d14-20020ac244ce000000b00503000f1343mr3999054lfm.19.1695283079562;
        Thu, 21 Sep 2023 00:57:59 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003fef19bb55csm1151252wml.34.2023.09.21.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:57:59 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, howells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/4] pipe: reduce padding in struct pipe_inode_info
Date:   Thu, 21 Sep 2023 09:57:52 +0200
Message-Id: <20230921075755.1378787-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This has no effect on 64 bit because there are 10 32-bit integers
surrounding the two bools, but on 32 bit architectures, this reduces
the struct size by 4 bytes by merging the two bools into one word.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/pipe_fs_i.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 608a9eb86bff..598a411d7da2 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -62,9 +62,6 @@ struct pipe_inode_info {
 	unsigned int tail;
 	unsigned int max_usage;
 	unsigned int ring_size;
-#ifdef CONFIG_WATCH_QUEUE
-	bool note_loss;
-#endif
 	unsigned int nr_accounted;
 	unsigned int readers;
 	unsigned int writers;
@@ -72,6 +69,9 @@ struct pipe_inode_info {
 	unsigned int r_counter;
 	unsigned int w_counter;
 	bool poll_usage;
+#ifdef CONFIG_WATCH_QUEUE
+	bool note_loss;
+#endif
 	struct page *tmp_page;
 	struct fasync_struct *fasync_readers;
 	struct fasync_struct *fasync_writers;
-- 
2.39.2

