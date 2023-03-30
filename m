Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85996D0BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjC3QrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjC3QrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA0CDCB
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p17so8527216ioj.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194833; x=1682786833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqvAB6d8goa2TAcTv+sr3+77aiqYZ9Ym4nn/6JW4p+g=;
        b=dzte15Gqp4cjRsbJLzbWwn94XvOXX4Egre/oxtQ1GjfkxqT/X6qAkOGReDejGZKfp3
         yqD5bCHvpi9IVDaUJcvjVnSmfTr78j5WSm/ZFyBARceGSJUlzjXx1XluHx5A6TOAYvob
         Vd63Ef9uF6Pj+ZTs6/cyvNIYkJ2O6d01GAlVOr7h48hngri7PAm81pcO4DjAtXvJ4Wpb
         Io+zaQOmwiQ/DayJUVyUFnH5f6m2IwwrvjDF01hcbxKHERIVADmLHVTX9yRlRiuE8fRl
         +16eXsxZmtaTcyzFxh8yNBqgMjeE9skO04Up4fY+1/qJ7Y3vC7cm3ejFhDya6JUYS9pH
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194833; x=1682786833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqvAB6d8goa2TAcTv+sr3+77aiqYZ9Ym4nn/6JW4p+g=;
        b=aLCFlgEpYn7UL0SSEvAP5ji6KbBRPhXNN8FtvmvnduJTgCACiuNrfsxu15MGNdrjYj
         d0mwZs4xmNzrCrQd5RdRfKlIYwthh8riYhsBQ9+ZMUuFdpybXj4D8gNwzk0DukjIjFJt
         GVbGqbimyfT5oTV0biH95vFhL5NTo4yocrbJxIxqJaGqyOOLawYKYWDS9By6L1uGlara
         8yCbzcW3FNWERtw88SEna4ItUn5+X/XL+WqSq/l8Plic19gn/ea18bEAUNY+VuNViv90
         A6SA4cWujCxUXcykOITmHh4INRvjvnp65Po9KJKml1+KIOeGEbuT3PPfWUWetEDFagKM
         xNYQ==
X-Gm-Message-State: AO0yUKUX8kxxFmrgxAnuvZdjCPaVyAQMBjRpjBEM3MLKyh4nN6XLrKt1
        MfAKZAqigTCjLRlLUCDr0kDKxbfpmSkMncuMmGYLDg==
X-Google-Smtp-Source: AK7set8/RjCICeWEl0bCRLxbc4bISYPLNktpF2cGm2Fq+oz6xnVePguVmGCD8E4IPyj5Ak6rdEceaw==
X-Received: by 2002:a05:6602:2dcf:b0:758:6517:c621 with SMTP id l15-20020a0566022dcf00b007586517c621mr17378759iow.2.1680194833513;
        Thu, 30 Mar 2023 09:47:13 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/11] iov_iter: set nr_segs = 1 for ITER_UBUF
Date:   Thu, 30 Mar 2023 10:46:59 -0600
Message-Id: <20230330164702.1647898-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 7f585ceedcb2..5dbd2dcab35c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -355,7 +355,8 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
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

