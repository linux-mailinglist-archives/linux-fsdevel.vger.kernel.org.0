Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C049E363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiA0NbT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiA0NbS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:31:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FBC061714;
        Thu, 27 Jan 2022 05:31:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a8so5799737ejc.8;
        Thu, 27 Jan 2022 05:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=5nIqKZlOibjJMchSc29ilyxGF4P6Hgtuc1iyAzVCkk4=;
        b=m5uffl+5yi+zjmhnLdsa9orhYwCG2DMvF4D1VY+X8CGUuyI39U9orHyef7fFqDCa46
         aMVc56yVVLWGtwYjowa3x/rWKeTiONi2MDKsxm3bmgFhrwy7aQHGjGMefYfm8IhuGQzv
         JaBqbjJJUVwArWtVJC+7PJnHUs0/j9rwW7kNs2nilznP7h/qFyo/GWYeYc4AfT0rwHwX
         G+bu//fuQxEyQ+4n9bvu05DtwbAy8spjIUWiH911EqJOuUMoh13a55mgtf7uaFn5fKLu
         hyb7wkzSesHEYWPEe/3q+JHjVtyHnyOyM8MxRbIsODageKJsgk56zXUpGmHa6XBzJZ1n
         kUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5nIqKZlOibjJMchSc29ilyxGF4P6Hgtuc1iyAzVCkk4=;
        b=AGqZt8ZgcDgjut5q4WnPza3H1krH34TuXRsz7D859iGFFlsYthAFQcn8pEVJMklKsy
         +87CmSC05s6+Px3W3hDJpKMIwbQkz3zhg4WQLdZXEAytSzmlYKrykUxYCFk1IPC5rM+M
         shJPckd079p/8r3fgeXO1vr3cI+BSTG8Ac3uJeDRaSL2RpHSZ9aV4ORENINl8UzwFxd1
         ygrE5dvZ+y7FNDX2PoZTtA4k4ellvjAGz/eUGwb3NNdjABPttH/wBKDUfJqDIFGC2H5J
         +rOGsuEVnsog9ZMqjdHUBrvf4TirVTbSPCmiGurTHyxSe+AjvkCjOUGTGUD6r5cmZZpc
         nS0A==
X-Gm-Message-State: AOAM533u63K4Jw9srm08jRImEMCJjl9cuXYvIVrLlyfAYVpTdBfBcCcR
        qT7i9I+Q64BWE+/5f9SyJCc/flmUYUzooFpseBKTbh0PjNw=
X-Google-Smtp-Source: ABdhPJy16KkHE1vuKCYhWF6GQ1SLslOPn3jBhh30GjjI6Qlc+Twr0geRupjyZmIL0qS9sLnMMV0H2Q0nEqNuXg4XJ1k=
X-Received: by 2002:a17:907:724c:: with SMTP id ds12mr2862496ejc.203.1643290276629;
 Thu, 27 Jan 2022 05:31:16 -0800 (PST)
MIME-Version: 1.0
From:   INT MAX <untitled.yan@gmail.com>
Date:   Thu, 27 Jan 2022 21:31:05 +0800
Message-ID: <CACvCHSL-mmcvfjuCkhZSvfddojPuAOq8cnjxt8Tu9He2s_LRGw@mail.gmail.com>
Subject: memory leak in prepare_creds
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear maintainers,

I've found a memory leak bug in prepare_creds in kernel v5.16
(df0cc57e057f18e44dac8e6c18aba47ab53202f9) using Syzkaller. It happens after
fork-pipe2-close_range (a stable reproducer attached below). It's possibly
caused by incorrect reference counting of credentials after pipe2-close_range.

I tried adding some debug messages to trace "get_cred" and "put_cred" but it
seems the reference count is changed somewhere else. Unfortunately, adding more
debug messages makes it no longer reproducible. But there is one thing for sure
the reported leaked cred was indeed not freed by "__put_cred".

Attached are the following for your reference:

1. Syzkaller report (including a C reproducer at the end of the report with
   some extra debug info added by me): https://pastebin.com/xMWNhf5r.
   The reproducer will usually report the leak after 2 or more iterations, but
   the actual leak may happen in the first iteration by inspecting the debug
   output where the leaked "cred" object was reported to be created as early as
   in the first iteration, and never get destroyed. In addition, the number of
   iterations required for triggering the leak goes down to 1 after running the
   reproducer multiple times.
2. Debug output (added by me) during the lifecycle of "ls" (no leak) as
   reference: https://pastebin.com/L45kbnwt.
3. Debug output during the lifecycle of "sleep 0" (no leak) as reference:
   https://pastebin.com/XFM5r1sF.
4. Debug output during the lifecycle of "repro" (the C reproducer; leaked):
   https://pastebin.com/yj2evZbX.
5. The kernel config: https://pastebin.com/DU0VVviE.

[This email is resent to the two mailing lists because the previous
email sent via outlook is blocked.]

Best regards,
Untitled YAN
