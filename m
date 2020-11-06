Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0A12AA0CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKFXRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 18:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgKFXRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 18:17:48 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D505C0613CF;
        Fri,  6 Nov 2020 15:17:48 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so2023488qtu.1;
        Fri, 06 Nov 2020 15:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+/nPnvBZkkkSvxbo6vGJ/Gsm2HBM8R8q98WAnARJvs=;
        b=PTe3ISANf/g4oBwf9DAsv6Fnv4HGMJXj/0RF9cRKmoXNA4kvew8VfxNcHKCJx+0QqX
         lEINR2peZMozFNGRX/EICopnZRIEtaevb2nwdR1qG52jgzYyu0k1EslQdw2+Sh+S2szq
         MnITJxYwj3JMaS/3OfnRzjFsfvT8SaAasncG6wYOtNAHk1+i79mSEQ5rGbPycOnWLAO2
         NdU3UH6ba+hdHGx9bjLmNdTyCTpE5nb91d7GNWbfvVojcWik3khsvCdy4rJ1dViqjG2u
         aTSLDIoUCOZ3lW5hjGQ0FQCiYrsWwde5tc40jqszd+Dne6YHG1xsEejDoHeLvNjM35n6
         UKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+/nPnvBZkkkSvxbo6vGJ/Gsm2HBM8R8q98WAnARJvs=;
        b=OtocbFbaz9b0QfwIur5eJzq+PlG6n4OEUB2hyjf+HL1IcvRug/u54WvxdIgFxAL+aH
         SqS/G3y23xryzKyeIhzJYoJTJfZQhbUUNEqrEUinUlpu16azKH2ZGT4IClpjEdcHiY6W
         JXdfho+2Wvw8XkEbDR//BsArolWwo6AVpIrGho3OUI34nxRlnicylG5mcnvW9lbin0oL
         SpVgb/D7YEVAzyz0z7HJ/iHJLSN/bw6Q5ZE12SIm9O1sxvNzXQNAw8aXdNygkRrHiNtM
         v9tnYRz8h0VB9msxrVYcP2vuM2z9uTFv7cRbETh+Dm9loZK4BEfWpUlECTHpc/9oA41X
         /fwA==
X-Gm-Message-State: AOAM532fIxYkRM7sbpZ2CTR+RJ6+sVOC3Dyv4P1acNJss9QU1Ou7wnUg
        FFU9BiihVMmAZE1LEf2hwyE=
X-Google-Smtp-Source: ABdhPJwS6wBnWgY7JCknm/7bQfhr4v9qZPuvsDH8GFuFdCY+xBoGS6JyVUNmQ9pC7kpl5jE+untjvg==
X-Received: by 2002:ac8:4e14:: with SMTP id c20mr3926827qtw.5.1604704667612;
        Fri, 06 Nov 2020 15:17:47 -0800 (PST)
Received: from soheil4.nyc.corp.google.com ([2620:0:1003:312:a6ae:11ff:fe18:6946])
        by smtp.gmail.com with ESMTPSA id p136sm1519357qke.25.2020.11.06.15.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:17:47 -0800 (PST)
From:   Soheil Hassas Yeganeh <soheil.kdev@gmail.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave@stgolabs.net, edumazet@google.com, willemb@google.com,
        khazhy@google.com, guantaol@google.com,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH 0/8] simplify ep_poll
Date:   Fri,  6 Nov 2020 18:16:27 -0500
Message-Id: <20201106231635.3528496-1-soheil.kdev@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Soheil Hassas Yeganeh <soheil@google.com>

This patch series is a follow up based on the suggestions and feedback by Linus:
https://lkml.kernel.org/r/CAHk-=wizk=OxUyQPbO8MS41w2Pag1kniUV5WdD5qWL-gq1kjDA@mail.gmail.com

The first patch in the series is a fix for the epoll race in
presence of timeouts, so that it can be cleanly backported to all
affected stable kernels.

The rest of the patch series simplify the ep_poll() implementation.
Some of these simplifications result in minor performance enhancements
as well.  We have kept these changes under self tests and internal
benchmarks for a few days, and there are minor (1-2%) performance
enhancements as a result.

Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>

Soheil Hassas Yeganeh (8):
  epoll: check for events when removing a timed out thread from the wait
    queue
  epoll: simplify signal handling
  epoll: pull fatal signal checks into ep_send_events()
  epoll: move eavail next to the list_empty_careful check
  epoll: simplify and optimize busy loop logic
  epoll: pull all code between fetch_events and send_event into the loop
  epoll: replace gotos with a proper loop
  epoll: eliminate unnecessary lock for zero timeout

 fs/eventpoll.c | 159 +++++++++++++++++++++++++------------------------
 1 file changed, 80 insertions(+), 79 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

