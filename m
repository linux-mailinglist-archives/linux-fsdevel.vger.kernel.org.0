Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA78331465A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBICbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBICaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:30:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE64C061788
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:30:15 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e12so8901931pls.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8FMeR2iDUb+pnY3zeA5vegBZlcCW1eYs5QHWNmSbac=;
        b=Hfhf1Sl+ENVsH5K6DuM84ZIkF4FEGvtPE9VDNp0asrxHHYP1sh2dwmWlDqfON5u+VS
         NoQKeoIHNim9RguIN37CysLwS1IthE+b/2LnS3fRw4PjrALIVdSggcI2rzlKTgYVggvZ
         JBcO5Weqzg4ONY0qI14MQxbGKMtOfZWvfitphu7twWtH6VDIiKiz2ovuowv8PV3/6yQ1
         6j8NHMyzCCwjwmBVawLPQttBLmcQAYDYQGUaCesw3o6jqzKzSz91qoUT5p3HySkQZthI
         JokqkCuwnPaHh7zKAXnOx8fPlFz/sx4JqSa9+wUfftj5mJFFnXZ66rbAfs1bvbwXwPT6
         0g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8FMeR2iDUb+pnY3zeA5vegBZlcCW1eYs5QHWNmSbac=;
        b=uSbQGlSypN9tEta3i/qE3HNmZnVH9K648CLXRnwHdFEqPVHWiKmv2Fs8X6PZsb3iaZ
         8mo0GtoO+RkvzFBtc8P8Q8ZJE3MNs36kNp5dGE3VjVx3fn+6zwxK6svS5d45tRS8mmfp
         2vkX93YR32fd8t43Glj7QExS66eph9tkU4itVdVTZUyvbJnb0HPUM4F0b6lN4lpO/OLQ
         aZGGcrUbb+WNvtZQQOmIfwP6t9HIPtUEr8+FMNoofX4abn/nSztltpXr3dGqr9PRmL1N
         HSm959bY0yERy6h8fzrZ0/LP0FpnLGfZZlYx84YLSLjtxQuXMi/SfyVLkmiifYepdGXr
         kXDQ==
X-Gm-Message-State: AOAM533qgDfEoMxO3fkjV4cjvxtSv6MruGxI1lPageWuzeZApF5R43Rr
        slTekSWQMdJDRqwiOSrw2dPe8ZHhX9ZQIA==
X-Google-Smtp-Source: ABdhPJxCzFHzGm1phewsToczBmz1RG+OQ7sLKoAaPECWZXB937/8j5V39NCV++/Umg/mdS9vZIrzoA==
X-Received: by 2002:a17:90a:c702:: with SMTP id o2mr1717835pjt.7.1612837814624;
        Mon, 08 Feb 2021 18:30:14 -0800 (PST)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y2sm19070597pfe.118.2021.02.08.18.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 18:30:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     hch@infradead.org, akpm@linux-foundation.org
Subject: [PATCHSET v2 0/3] Improve IOCB_NOWAIT O_DIRECT reads
Date:   Mon,  8 Feb 2021 19:30:05 -0700
Message-Id: <20210209023008.76263-1-axboe@kernel.dk>
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

 fs/iomap/direct-io.c | 23 ++++++++++++++--------
 include/linux/fs.h   |  2 ++
 mm/filemap.c         | 47 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 10 deletions(-)

Since v1:

- Simplify the filemap_range_needs_writeback() loop (Willy)
- Drop the write side (Chinner)

-- 
Jens Axboe


