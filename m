Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0423A2E62A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfE2U3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:29:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37753 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfE2U3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:29:53 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so3072105iok.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=UtbQPUgFNUmhmXEEatwgf5ugaH/Cm/lRbF8Ni8Oe5vI=;
        b=vC5r3d8quVXIgCrX8UOiVWJOzPKMpiOhCBUYVGA9G7/ZiaZP9WivbLSVYN86tf43eE
         4mK7FuHcFi9N7VAc92vZB8qJzZqd8T5dH6FZsQfscRKmshfRwVNggUt/kHpss/JXGAe0
         IUAWHRdhlwq41ON3nFw9gPYr6c25uRTaeIKfKArpivB4L60O2d0/vf56TUlyKNo2i4ky
         djUXffm6EJxiRjRNhQGBucc4aU7To+7VqSXbDcpRKspdFe70C3retyMu1yVnHPiCtVIr
         /8LNzzixzIup+X4C29HQqYY6cAzcJ2Nz3nyFL8CZNDbkEYuzQAMF5OepQCY6aEij49n1
         NhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=UtbQPUgFNUmhmXEEatwgf5ugaH/Cm/lRbF8Ni8Oe5vI=;
        b=fOi088E9lp7xIQdQfnIt0EBM+TviyBEGyvnWfFU/qozg3S0q4QB9TZipk6YTpVBxHS
         7Mw8aIQqLX8YOk0yW+7cp4RMP+AY+jYMvOsZ8iUzBmn/Eqvb5GPA325RRIZSN6zMzboK
         /KpedqT4MchLvxzAdPdlnXnBOXY5WChxh1DAtXjkoB0S3geggqotekS7JH19dioavVeE
         fuKOZTlQ8o/uaGbSXjdndhVMxr3+8h2beKUEkoXEsgf6HAHOG6Znm4fUgVTW5/P59+Yu
         4mHY1H+EpheULCgqU3VIIsIHr6VF/pAg+cuC0nqDUJexzYaDRblvJQTs3AN8B0AML4S/
         G09w==
X-Gm-Message-State: APjAAAUgLXcKoj07lrj9hS7tOekLpHGJNYDMb7kyUJYbcBTgPggX1ATi
        iFBhFfFQe/aWk7oCCmGOOWPUU7K6zcp/Yg==
X-Google-Smtp-Source: APXvYqy0uMJD9fhurgFqHv2vg8ochqIKRAl1p+TX6vKoSNCoNwiQBYZC5Y3pyCnIpRMdiktNJEkLPQ==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr14174865iop.293.1559161791850;
        Wed, 29 May 2019 13:29:51 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k76sm179105ita.6.2019.05.29.13.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:29:51 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCHSET v2 0/3] io_uring: support for linked SQEs
Date:   Wed, 29 May 2019 14:29:45 -0600
Message-Id: <20190529202948.20833-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's v2 of the linked SQE patchset. For a full description of this
feature, please refer to the v1 posting:

https://lore.kernel.org/linux-block/20190517214131.5925-1-axboe@kernel.dk/

Changes since v1 are just fixes, and nothing major at that. Some of the
v1 error handling wasn't quite correct, this should be. The liburing
repo contains the link-cp copy implementation using linked SQEs, and
also has a test case that exercises a few of the link combinations.

Patches are against my for-linus branch, but should apply to Linus
master just fine as well.

 block/blk-core.c              |  74 +++++++++-
 block/blk-sysfs.c             |  47 ++----
 block/blk.h                   |   1 +
 drivers/block/loop.c          |  18 +--
 fs/aio.c                      |   9 +-
 fs/block_dev.c                |  25 ++--
 fs/io_uring.c                 | 268 ++++++++++++++++++++++++++--------
 fs/splice.c                   |   8 +-
 include/linux/uio.h           |   4 +-
 include/uapi/linux/io_uring.h |   1 +
 lib/iov_iter.c                |  15 +-
 net/compat.c                  |   3 +-
 net/socket.c                  |   3 +-
 13 files changed, 329 insertions(+), 147 deletions(-)

-- 
Jens Axboe


