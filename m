Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4166E0925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDMIly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDMIln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551383F8;
        Thu, 13 Apr 2023 01:41:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b145b3b03so2014451b3a.1;
        Thu, 13 Apr 2023 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375301; x=1683967301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqeYJxKpbpADcsi+GjjFQcA/vJWyOX2R4c8J3BAVvBU=;
        b=iFRkkLKFh6j30/LTvw3dIYG9nRwKWYufZizVg/AOYfT9itVbu9m2Rl7KwKUsCEzmO3
         jwM/WskIOOfZJpNIs37Yl3r5CkWYgyTmLHgpdkx9Kb3gGSN+DEQbtU9vuVbM0UmDZhG2
         Y81n1dhAAnSmRCy/zs81kpdI1GuPA4MYbJun7o2MJeN95sQpRnjHwglcn8lkHnh0e3Ad
         GUz8fs9sCXX3jI7EXD8bs/bAa//UB9HcJKGWqPzh59Bh7643jR8XFpIMM+w8RXYaM7Xh
         tBVNsQOKqw3bILAhuSitTw4OJPcEzN90ILyz+5xHOiI0K28KSDJrOyctUJn5fM03BFOG
         bQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375301; x=1683967301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqeYJxKpbpADcsi+GjjFQcA/vJWyOX2R4c8J3BAVvBU=;
        b=EOkO3fO4vqyu6IX378AICnpMnDjUtFbVS1x5tcCbg1C1n4Xo0xyj5rOvan+5XDR1Sg
         FlSKEQgXgMPefk895MK93n+ASGkmEfUSVsQxEF+of/o7W7OYqUkKUirbKxdOHnAGhj0+
         njj7esG2uoyEXgPdZD/qzL9tOLyyu/huHw+qoD88fYeilgOtE6ORK42vqulEeTocX7d5
         QYc4JamTH3pSBw44PGZsxM5qXjdDN6bDn8SVhF2n+AW537JxF+/k1qA8axdwpIlfdEKw
         LMZEdH2WMfFiZpso4nhaf0dM37Po1lxBkWxE88fdbhezquKe1Odt3hxLiK1dvqCzHPOm
         bQaQ==
X-Gm-Message-State: AAQBX9ft0aPGNBffcnWcvfoHMma3Ygk6+LvUwcCPgGsWsDQNsY52t1jX
        S2fiAKCgAvVZ1vHX/1TST1F+pWRClHU=
X-Google-Smtp-Source: AKy350amQnUZBc63C7KzpHAZOE7KZT2vIO11qE8Kma47yzJvCmDPytJ9u3I/mS1ouqj8R8y8+Yn2yA==
X-Received: by 2002:a05:6a00:3086:b0:633:9db8:c23b with SMTP id bh6-20020a056a00308600b006339db8c23bmr5916710pfb.12.1681375301640;
        Thu, 13 Apr 2023 01:41:41 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:41 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv3 09/10] iomap: Minor refactor of iomap_dio_rw
Date:   Thu, 13 Apr 2023 14:10:31 +0530
Message-Id: <ac0b5e5778585f8d02b4abc355f185cba261b239.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The next patch brings in the tracepoint patch for iomap DIO functions.
This is a small refactor change for having a single out path.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/direct-io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 36ab1152dbea..5871956ee880 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -679,11 +679,16 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		unsigned int dio_flags, void *private, size_t done_before)
 {
 	struct iomap_dio *dio;
+	ssize_t ret = 0;
 
 	dio = __iomap_dio_rw(iocb, iter, ops, dops, dio_flags, private,
 			     done_before);
-	if (IS_ERR_OR_NULL(dio))
-		return PTR_ERR_OR_ZERO(dio);
-	return iomap_dio_complete(dio);
+	if (IS_ERR_OR_NULL(dio)) {
+		ret = PTR_ERR_OR_ZERO(dio);
+		goto out;
+	}
+	ret = iomap_dio_complete(dio);
+out:
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_dio_rw);
-- 
2.39.2

