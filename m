Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93188FFEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfHPKWX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 06:22:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36759 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfHPKWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:22:23 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so3716945lfp.3;
        Fri, 16 Aug 2019 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8Whcxou6li//Ce6UssS2+puysTVPEZT2bFkzJanhf4=;
        b=ITapklmwtQoZxnLqjgth4nFKgfSGo7+adpQSSx4OCUjjKz2y2odzwqDrVT8dXupt58
         2xlZPLtCb8Cs4oDhRdh3Od3epxSsBfhA7xFDPctX5VdghUuyi4zch6KntVfV1VJ+W0XI
         PzPdMMgRgaw2zBqwEkA6OeRl0X+3kCsyxj9SV742c7IEM2q5NBkJQD8nMYTZ/zvTHdlm
         CoExg6sGcgnzDIL4CLv/2LuVVwIP1rUfVUG921bPX3dDoQbXhN53QcTRk0rNH7x6Xb5Y
         dDWZfaR6K7VwxtTsOlrpuhjbp7mZfSRqlpiFts7Z/3s24JbwnvO6G+oha4djPGiMjLCE
         Y51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8Whcxou6li//Ce6UssS2+puysTVPEZT2bFkzJanhf4=;
        b=kl3c71tIiy9e7YgtiB3JzT7I4iQFZfQO2yW++44TgcB+MedEWhL/tCSKaZUX+rL8zO
         75BRp6fxaJyG3akmt+sZ3J/pkcXFawRQg+zI4sphlM40ocOPkC/d5nodRf+X2hUrVNqB
         QpXnkGMU1mSNvePlRxSH0CAW1iUzT0MkgAhPFWHCOqmeXmkFNHp+z0hie8A9uLDYZBLn
         nhMxXypg/6Y3WwQFFPdGjvEJx7duuH0U9apcosiGRxXVc0OTJiUOsYCtpu1XWgEjrp11
         jjHjiRTevMPVH5evLFXVka+WOwRcHzj/CAEkutapaRvN8o7PghXhLApP/CioX5zB77kf
         7E+A==
X-Gm-Message-State: APjAAAVvpX9rOY5TQ1thoxF5D/Dzne2n4GHGxiQ4xW1EvzcDtY4NHfWT
        NOFtQ/oci2O7JJncdiK6RRTqvcSMcIEXeDjzXrs=
X-Google-Smtp-Source: APXvYqyhQGjrxNtTA8VpSttgLePNlAni5npFoym9t1xCM3mKwCzaGw2AQPrNcmr3QeXqZHyTh8W0nRhqIlReZIXkrsM=
X-Received: by 2002:a19:2297:: with SMTP id i145mr4670760lfi.97.1565950941067;
 Fri, 16 Aug 2019 03:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
In-Reply-To: <20190816083246.169312-1-arul.jeniston@gmail.com>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Fri, 16 Aug 2019 15:52:09 +0530
Message-ID: <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
Subject: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        arul_mc@dell.com, ARUL JENISTON MC <arul.jeniston@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'hrtimer_forward_now()' returns zero due to bigger backward time drift.
This causes timerfd_read to return 0. As per man page, read on timerfd
 is not expected to return 0.
This problem is well explained in https://lkml.org/lkml/2019/7/31/442
. This patch fixes this problem.
Signed-off-by: Arul Jeniston <arul.jeniston@gmail.com>


---
 fs/timerfd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..f5094e070e9a 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file,
char __user *buf, size_t count,
                                        &ctx->t.alarm, ctx->tintv) - 1;
                                alarm_restart(&ctx->t.alarm);
                        } else {
-                               ticks += hrtimer_forward_now(&ctx->t.tmr,
-                                                            ctx->tintv) - 1;
+                               u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
+                                                                ctx->tintv);
+                               /*
+                                * ticks shouldn't become zero at this point.
+                                * Ignore if hrtimer_forward_now returns 0
+                                * due to larger backward time drift.
+                                */
+                               if (likely(nooftimeo)) {
+                                       ticks += nooftimeo - 1;
+                               }
                                hrtimer_restart(&ctx->t.tmr);
                        }
                }
--
2.11.0
