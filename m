Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E513142BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 23:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBHWTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 17:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHWTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 17:19:17 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9CC061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 14:18:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s15so8595762plr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+p4V3Uds2r1nqxPoujfGyPXKob2/IV0lWtEI4+ZvEg=;
        b=MCUOts+F6kQY/nu6UyvRrlXSoyvu5xOrN2/S+S9DWUJuNC6onmSzj1BmOb7N2a8bSU
         hZdJ68ZQ8XXn74dwvSh+dF9j6GE9YrSGhLk47gTGhv6H4gsmfLw3spc3j0a3144mAKyW
         pMWT0uhDrLwukYwKMCFV7BXkvdyL+qV8Ns00rCppn4ctjDaHE4NkgqOwNH9NS265iVxb
         j0WtWGZnJ6lNGoXYyC3Zp5tkEwVTA+b+yQVzFAZiw0AIN5QJhLymyYeli85lm+GdxThI
         hOJy0fcjiftVzMApESZ8penZ/O7w6r8c0SAtyr7uea8xRk2JscS0ZKa1LsuD6Uv5LoX1
         ucYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+p4V3Uds2r1nqxPoujfGyPXKob2/IV0lWtEI4+ZvEg=;
        b=J9hc2FE0BmLhrBpdOuDkrx30sX5Map3TauLGPRQkckObDoox0QqpdnM16H1MEKASA5
         3d+mHLbww77IAj2hDXtcMjN4PtUKf+vrhClGZAglFuGUWgrEBfk1qnvD6Btyu96UEJyL
         7Du0KccbLsIgThtCgxWyxAzOmQxN7+RrG6ZrLi+o/Jlb8pBQTAg0FfGGFImBw0HYqO7J
         8/izNdB+Y9H2O5P1lHl/VOUq1tuu5CqgVd/NevJ2rhU4SKL5zD0shnyqUw6rQxweM3s9
         hYNpnsEmRDXAT9Z9KO29MLdzClxEfKK4BrlVqpKJQAnjckO2y0Fy9yZ3uFnP4YEzPoVq
         bPlw==
X-Gm-Message-State: AOAM533S34EB9/FxCYwqexbC0pIM9DLFyJNZx//uo+0XIAP6JBEKIfN1
        9DEp7xL4dX7sk8RYtk7JpE1XaJhSTgCoUw==
X-Google-Smtp-Source: ABdhPJztojDx2x8WNq5jT6fElvzP7MG7VRij6fFOjelaAvaWg9vgyxKKNiezcD5sKJ+bJGAjSNVdHA==
X-Received: by 2002:a17:90a:d34b:: with SMTP id i11mr867673pjx.235.1612822715591;
        Mon, 08 Feb 2021 14:18:35 -0800 (PST)
Received: from localhost.localdomain ([2600:380:4a36:d38a:f60:a5d4:5474:9bbc])
        by smtp.gmail.com with ESMTPSA id o10sm19324472pfp.87.2021.02.08.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:18:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org
Subject: [PATCHSET 0/3] Improve IOCB_NOWAIT O_DIRECT
Date:   Mon,  8 Feb 2021 15:18:26 -0700
Message-Id: <20210208221829.17247-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Ran into an issue with IOCB_NOWAIT and O_DIRECT, which causes a rather
serious performance issue. If IOCB_NOWAIT is set, the generic/iomap
iterators check for page cache presence in the given range, and return
-EAGAIN if any is there. This is rather simplistic and looks like
something that was never really finished. For !IOCB_NOWAIT, we simply
call filemap_write_and_wait_range() to issue (if any) and wait on the
range. The fact that we have page cache entries for this range does
not mean that we cannot safely do O_DIRECT IO to/from it.

This series adds filemap_range_needs_writeback(), which checks if
we have pages in the range that do require us to call
filemap_write_and_wait_range(). If we don't, then we can proceed just
fine with IOCB_NOWAIT.

The problem manifested itself in a production environment, where someone
is doing O_DIRECT on a raw block device. Due to other circumstances,
blkid was triggered on this device periodically, and blkid very helpfully
does a number of page cache reads on the device. Now the mapping has
page cache entries, and performance falls to pieces because we can no
longer reliably do IOCB_NOWAIT O_DIRECT.

Patch 1 adds the helper, patch 2 uses it for the generic iterators, and
patch 3 applies the same to the iomap direct-io code.

 fs/iomap/direct-io.c | 10 ++++-----
 include/linux/fs.h   |  2 ++
 mm/filemap.c         | 52 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 56 insertions(+), 8 deletions(-)

-- 
Jens Axboe



