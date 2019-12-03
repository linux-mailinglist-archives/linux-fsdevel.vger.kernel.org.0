Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A3D10F6DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfLCFUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33870 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLCFUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so1253073pff.1;
        Mon, 02 Dec 2019 21:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lo1FIdw7u0NV2Tgo0tQfhnWJEQxmW3ioGg2cCeozVqA=;
        b=Ztb0RreyoIgcYMObe/fxFbZfmUwBOO9ZNQVyf+0wUkqB4IUF8iX0Aj4QAEgwK2Y8HM
         9R9J2WuuwQAzhlQ/JTsmxUblpgOZSEXSlTYpieISOLR+lxkkznNggFCdSHSHCjpIqfV7
         /xfCn0FBK0DACW28QfMqcF/4QzP3mvELDENsDx94okHKtlscY7ccBwXgRl5XhA2ZeExO
         JSpLajE42kSVi4FjSO+rDXerjrHBAEwhAUn3qReScV8VZLmL+FP5uXu88tMcR4sQc4xI
         mZycIOiu7BQgSsmJ7DMs0dilebUnmKiNVXx2Vhj+jT13hSRhf6hCmXcJlxcxNITmsd5n
         SpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lo1FIdw7u0NV2Tgo0tQfhnWJEQxmW3ioGg2cCeozVqA=;
        b=FaewhzjznJ8gUADr9XNN+Sz1PXWM16WhTsnJE1NL6gUhNfSMzvbJIbxPMCEoX8Vq2D
         X8aDOPu58IjZTk5ck2GV7sv9G9RnUeTx+0etFFpYhB5iZ4XxNKJieFTTrTegEi+wkHsT
         LAcKuItYWTkfDiS/0pnubibGXuN2zzgiMXrsoltE+CHrAJclhoYQVSUeQ6Cj+lTas1Jj
         Kz7K6HdslPUy5JkRIUavM7ykHgtpAfLYq05OOVgcbgZoCmnwUUVHHAz6AndC3+tW3iRg
         Trsldac6MyUEK7Afycy38xjJGIrTOqQZO+xOwCaULFn62k6ImLykQEdODta3YlDdhH9t
         CAUg==
X-Gm-Message-State: APjAAAVLcM/b68TpbUL7BB3k/7WNX5fh8moExhUHR7Q9Fvjmi5KtLKKq
        z5qfrE+95gclFIeNeK9j6jZPbrJZ
X-Google-Smtp-Source: APXvYqxzZDh2NfeBrYDTnnOf9/hdb2fm1fLorKVVSa377tbXVjQqr8t/Sr3B1HKNXY0bY7gwbZcU3Q==
X-Received: by 2002:aa7:9465:: with SMTP id t5mr2899660pfq.18.1575350404175;
        Mon, 02 Dec 2019 21:20:04 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:03 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        ceph-devel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        stfrench@microsoft.com
Subject: [PATCH v2 0/6] Delete timespec64_trunc()
Date:   Mon,  2 Dec 2019 21:19:39 -0800
Message-Id: <20191203051945.9440-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series aims at deleting timespec64_trunc().
There is a new api: timestamp_truncate() that is the
replacement api. The api additionally does a limits
check on the filesystem timestamps.

The suggestion to open code some of the truncate logic
came from Al Viro. And, this does make the code in some
filesystems easy to follow.

The series also does some update_time() cleanup as
suggested by Al Viro.

Deepa Dinamani (6):
  fs: fat: Eliminate timespec64_trunc() usage
  fs: cifs: Delete usage of timespec64_trunc
  fs: ceph: Delete timespec64_trunc() usage
  fs: ubifs: Eliminate timespec64_trunc() usage
  fs: Delete timespec64_trunc()
  fs: Do not overload update_time

 fs/ceph/mds_client.c |  4 +---
 fs/cifs/inode.c      | 13 +++++++------
 fs/fat/misc.c        | 10 +++++++++-
 fs/inode.c           | 33 +++------------------------------
 fs/ubifs/sb.c        | 11 ++++-------
 include/linux/fs.h   |  1 -
 6 files changed, 24 insertions(+), 48 deletions(-)

-- 
Changes since v1:
* Dropped the atime comparison (patch 2/7) taken through cifs tree.
* Refactored update_time according to review comments.
2.17.1

Cc: ceph-devel@vger.kernel.org
Cc: hirofumi@mail.parknet.co.jp
Cc: jlayton@kernel.org
Cc: linux-cifs@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: richard@nod.at
Cc: stfrench@microsoft.com
