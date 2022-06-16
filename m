Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB654E28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbiFPNzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377310AbiFPNzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:55:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D12F3A5D5;
        Thu, 16 Jun 2022 06:55:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so1316023pgc.2;
        Thu, 16 Jun 2022 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WKPmpB+aAJiU6QhTcanmbujSg9PjTV7h3OUq8aN20ls=;
        b=BNDYUPT0KVPat6mgtpfD/fKON/fzzUKSm2Uh/Zsd7BB2Op/cc3mkqlfRc7Enf1K/gh
         vSgbPYEg68dP+o/wLLxp5kykPyBWfRKF9aTxunTS9njC9OoHYsmhxPKHcZ9P/xfckkKP
         mbsUwNGdaDXoWWVj+PJkidkc5sIElrDULyAHssgeXsE4nChJKMEuXRKlPCH7654edB1j
         UlwrOqmYB1mh4ypeQf6RuB3KZu0HWkS/liAIGqk8UDODz4uUeHxEC7eObTWJDJIs0T4c
         f4ad/kEI9dYaAdG9fy3JrIcrrD0GDvcbMs83x5bIs4Wv9hToq3HRqQcDUE5vci3A9H5f
         BKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WKPmpB+aAJiU6QhTcanmbujSg9PjTV7h3OUq8aN20ls=;
        b=CixpsL6vO557LGt9VP9EUZE4CCZNqFvICIckW7QDsx0GOVnDkPOp06eo4xsutEcsSy
         InHtna2rL98Fe4U34kIko1gXRTlktCOHnMKjIDZYd9VzyNFAnSLitUmT7nx/R7mke7OE
         5299HloDCko5hE01mSRrtxLitrm9k6PD/2NJsXThPF3jwX+bTbMUHvf5AMaC4eoEFhWi
         lmpG5Khl1xGYONWjjbjIFK+MlzO4n1znXsU+ymumlpCzB/78cL3KsgZpEHffApT+AgVb
         36Qa8qTZjYuNEn+oz3vLs3b5JYSCtGblMNMxb7TSgpSzfBXr/fTSsYNDQVn3O10E7uie
         K4Zg==
X-Gm-Message-State: AJIora9jq22pOrmACG7lyE8/B4skOpOfyrgIjKKd7z7Fq6WlPRoHnmvn
        c7Meo1RjWgNMTk05owJkblbapKsXhg==
X-Google-Smtp-Source: AGRyM1sQemj2DEtO+kYCnm4bQbxyl59usGhttndogk7CAk4twYyMjCv1rXYiaH5yLbiRhvbaIcRMYQ==
X-Received: by 2002:a05:6a00:194d:b0:51b:eb84:49b1 with SMTP id s13-20020a056a00194d00b0051beb8449b1mr4855140pfk.77.1655387702912;
        Thu, 16 Jun 2022 06:55:02 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1565149pjn.53.2022.06.16.06.55.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:55:02 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, djwong@kernel.org, dan.j.williams@intel.com,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 2/2] dax: set did_zero to true when zeroing successfully
Date:   Thu, 16 Jun 2022 21:54:40 +0800
Message-Id: <1655387680-28058-3-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655387680-28058-1-git-send-email-kaixuxia@tencent.com>
References: <1655387680-28058-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

It is unnecessary to check and set did_zero value in while() loop
in dax_zero_iter(), we can set did_zero to true only when zeroing
successfully at last.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 fs/dax.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4155a6107fa1..649ff51c9a26 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1088,10 +1088,10 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		pos += size;
 		length -= size;
 		written += size;
-		if (did_zero)
-			*did_zero = true;
 	} while (length > 0);
 
+	if (did_zero)
+		*did_zero = true;
 	return written;
 }
 
-- 
2.27.0

