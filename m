Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63FC32425D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 17:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhBXQpz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhBXQpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:45:47 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C317FC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:44:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id i8so2656140iog.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 08:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMzB5LYCHoM595ZIb+y1ol2dkADnSvukLtKLVnTqze0=;
        b=AVQCxkz5J4nfCA0mAe3Mnbrck5888vMIEE8QcIC4O2wdwMyeRam9GbdoiXPuRB32aG
         w260s+ZSC6tLi4JlZgTQFprJtoPfSWY+ZPxT/UlkqMZ++65Ct0+SPhgLQvQi7LTdLO/q
         t7jPsMB/zIKeK8GBpcQ0dFAMvC3bNQPesJps96nImAUF8zxBncnSJdxUgUbbF4SGYIkY
         aomSzUO8Jx93QibP4GYnRN/5L6fzRKZeQoUcprc6QiUs96MpB2fvlMrPhfyrOl/Lj7sE
         truEaH6BJmnYYuGQKKEW5G26mtBaDTZYhXoX27LE8dZJBgZGykSvLQ9VIzUlMCmTto/E
         k7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMzB5LYCHoM595ZIb+y1ol2dkADnSvukLtKLVnTqze0=;
        b=sbs8KyhyMlGe2tD3FwKhg0DahoisAVb1aTb5lb5y3/vtbH2CGqppvYYP+BlLOX1W/V
         UmIAIPXAvP9yVdI26NWsApkz6LnTPVtmsT6IdMWJr0I64fBvwTsxHsS0XWzACC8Ta2Pt
         uESv+kd0dczKfqGOK5Rvh0Cni+ia46i6J8galYa78KRSspi5U7AjjczMTlsDOltsystU
         L2sU4otIH6YeByptlQUi7pyG7RC2r2Uuo5hRHywJKOexIKr3jIwxhXnbNBh5vEaHxq+7
         RVUc4K2pXjAhMFwyRPZN8ddbJZgCI50VhyOhdVfI456nC/6TtN7v1S0VYDIa60ElQBis
         quGA==
X-Gm-Message-State: AOAM5332CosO+nzEbC8fFW+HutPCZ/l8o4Y8/XFMwmwnzWFAcuRAo0om
        EA7ZAoUn7fTOTmy8eBsNhqqH9XJU48PcWYpl
X-Google-Smtp-Source: ABdhPJy+7CORlpmRxO8v25KgBy7jYkJ9ubA/L4EAP4TUDCUTmCXjqmxrfuHJc8Z4nT/tLMCnzan+pw==
X-Received: by 2002:a5d:8f9a:: with SMTP id l26mr21653310iol.106.1614185098674;
        Wed, 24 Feb 2021 08:44:58 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f1sm2273652iov.3.2021.02.24.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:44:57 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org
Subject: [PATCHSET v3 0/3] Improve IOCB_NOWAIT O_DIRECT reads
Date:   Wed, 24 Feb 2021 09:44:52 -0700
Message-Id: <20210224164455.1096727-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

For v1, see:

https://lore.kernel.org/linux-fsdevel/20210208221829.17247-1-axboe@kernel.dk/

tldr; don't -EAGAIN IOCB_NOWAIT dio reads just because we have page cache
entries for the given range. This causes unnecessary work from the callers
side, when the IO could have been issued totally fine without blocking on
writeback when there is none.

 fs/iomap/direct-io.c | 24 ++++++++++++++--------
 include/linux/fs.h   |  2 ++
 mm/filemap.c         | 47 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 10 deletions(-)

Andrew, any chance you can pick this up for 5.12?

Since v2:
- Drop overly long line (hch)
- Rebase to master, iomap changed flags to iomap_flags

-- 
Jens Axboe


