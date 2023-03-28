Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A876CCC6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjC1V6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjC1V6U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:58:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C71B8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a25eabf3f1so892435ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680040700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOAS7cM0V1rdkNIjItXF2VBHbDuIbv2yhdJvo4Z80nc=;
        b=yYlCRjTNZ4drRlPl5mYFsz5uHc3P5w8v+6NMAtyq8TFs5uMdoljjCuvCvJ/4/gXbyW
         J3qUD8vw0QyR78IvJotOd58FvwlVYeLNjmEikd87FV/cDYUlq3GT9xOcwdoMIS4Kdq3r
         MgI9rVK1YtB+BOe8lJ9sc9WVveawZNrI489JaNKHcdZAdRc0D+9E6E3Z3z08v4l2/MoA
         7TJo2AtczAwtQjPQZjDafbEawBfUGeq//ysvstSWglmY44EARGZ6nvyJeS1786ucFcwH
         /pItmg0UqP/T0bKR/BZrJ7TmpF6WC1qtmyWZVoNWDeCb4BstQ27A5EinRPuKLz1spwuu
         /rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOAS7cM0V1rdkNIjItXF2VBHbDuIbv2yhdJvo4Z80nc=;
        b=7H/UsJLiEILhpp43rsAgPLjkA2j5rejYluB+3yCdJGl33m2TNSxNebPGjV42whE1E8
         Wtk1cAZbiq6VEvtl++ETUJnYS8YO0xjFYTnNmTCAZgKhdRFHoTL6Bzvn2TnXHrIVfahk
         GE83/xrohANjbi5mTVJkPOZQPQj7EzoDe+TfnSKO9cLFM/FYiHEYgmdTZ72vPJA+KFZ8
         I4ooKfipWdpALqv5mc6A6/j3S4wR26SS/iGR4qf34pm+oD7IogSa5Pbv4ekZQPMUdz7y
         VKqnOZb0DbIuxAWSILwuHgsmSx/fYFIPPirIBJJeHqvcli3HxxbRhvDnQEWk7VxILE86
         Y/5A==
X-Gm-Message-State: AAQBX9c5AbKfV1NCqIrck/cCA90nrREKdQ4czGD9DHKpq9VMQONCEUbY
        GjqBD70Ztp9+vh+DMmdi/qDU7t0W5VQ58DzEYZjXzA==
X-Google-Smtp-Source: AKy350aiu2JBX5shtZlb41Tc1cHsC4iYqdlBkRbSyVqYH5H3qE8Nz9VhP5yoxmXJEhuyCQBF7a2T0g==
X-Received: by 2002:a17:903:22ce:b0:19c:f005:92de with SMTP id y14-20020a17090322ce00b0019cf00592demr14207182plg.4.1680040699729;
        Tue, 28 Mar 2023 14:58:19 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t20-20020a1709028c9400b001a04b92ddffsm21560171plo.140.2023.03.28.14.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:58:19 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/9] iov_iter: set nr_segs = 1 for ITER_UBUF
Date:   Tue, 28 Mar 2023 15:58:06 -0600
Message-Id: <20230328215811.903557-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328215811.903557-1-axboe@kernel.dk>
References: <20230328215811.903557-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To avoid needing to check if a given user backed iov_iter is of type
ITER_IOVEC or ITER_UBUF, set the number of segments for the ITER_UBUF
case to 1 as we're carrying a single segment.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 192831775d2b..953ccba94164 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -390,7 +390,8 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 		.user_backed = true,
 		.data_source = direction,
 		.ubuf = buf,
-		.count = count
+		.count = count,
+		.nr_segs = 1
 	};
 }
 /* Flags for iov_iter_get/extract_pages*() */
-- 
2.39.2

