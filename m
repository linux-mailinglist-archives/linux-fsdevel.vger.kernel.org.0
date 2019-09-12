Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1555B0D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfILLDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 07:03:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46888 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbfILLDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:03:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so15763196pfg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6TdpHGRMo/9QGFFi43irhTk/FFMkZ5MctGN+Nor7bUo=;
        b=e1ZsZIQKwY04TZyCyLF3+eKdqL7zUB44U/DjsjtqLdpGeQZpMXkNYhq4tEu53pbWja
         kcnWDtijf9xsDUsHu2fEyJUp4RtOPkJKcsIBZm+3F+drHu2zZdAYO4AGPgq+5LxcT6/Z
         Humd2JXqYUlmyA8DTIX9vQLaQR0ZuxIxsDsglIrAO4M/GvgrVlJM+BI3+njZKeOul5ey
         ZqRMAIvN3JlL4XIYDwYxNdkpR2AiIs5mgbx8EE55odTiXuaUUZT9iUpPdpGuOswppxkM
         QIgO57DSW59CR4jTS1hYBQzGSKj6VT8tNSk1cgI+NGLIi7+2uLFXLODIwuvGxYGjTAkq
         VRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6TdpHGRMo/9QGFFi43irhTk/FFMkZ5MctGN+Nor7bUo=;
        b=Vy+/U0YnlmGi7Oxfb8i9AUYYYDXmACFpAuXGxwrCeCGBprHSk/KNRwTNg3Eh+9Ak0P
         DaX9xZhKJ5G9PRQTvMlzl4ufF5sC/TWdAWJJNYbgqgkbZxNKZ2qH1ZwOxmE1wkzxZxyy
         r+aWfq/eGkTRoQI5wxnoD8ZMVnd1FRcm8p5DGAyDz1J9C5kONF4Axz9hkqn6aKN8MjoD
         tb04MDgYuffQnes26UIvzBFmrNOeWceNTZeZYvpJm4QJ25PvtztGuSotRaqoA1BD6lti
         0jZjNjEb1f+MeCSsMTOPe7s4doKmeHrYGQvBB1y1lzIObU48UFCj0AAvbDedA2pwlXmD
         tYLg==
X-Gm-Message-State: APjAAAXn2URXl8JZqJzIEwMayGHi6NFqI021L/+GTbB01xWFRk04Fki5
        v/Yl30scJLAzs3Z3vOJWdHL5
X-Google-Smtp-Source: APXvYqxMi/6AwAWIBbV3Fk+7VAehvArZGxks4tfVfWiG90d8S7WeSaYnEa0sztMwIwxAYvqzUV7e+A==
X-Received: by 2002:a63:c246:: with SMTP id l6mr37856485pgg.210.1568286215350;
        Thu, 12 Sep 2019 04:03:35 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id u65sm27618703pfu.104.2019.09.12.04.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:03:34 -0700 (PDT)
Date:   Thu, 12 Sep 2019 21:03:28 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v3 0/6] ext4: port direct IO to iomap infrastructure
Message-ID: <cover.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series ports the ext4 direct IO paths to make use of the
iomap infrastructure. The legacy buffer_head based direct IO paths
have subsequently been removed as they're now no longer in use. The
result of this change is that the direct IO implementation is much   
cleaner and keeps the code isolated from the buffer_head internals. In
addition to this, a slight performance boost could be expected while 
using O_SYNC | O_DIRECT IO.

The changes have been tested using xfstests in both DAX and non-DAX
modes using various filesystem configurations i.e. 4k, dioread_nolock.

Changes since v2:

  - Simplified ext4_write_checks() by using file_modified() as oppose
    to calling file_remove_privs() and file_update_time() explicitly.

  - Other minor cleanups that have been suggested by Ritesh Harjani in
    the previous round of feedback.

In the original patch series, there was a relatively lengthy
discussion around the merging of unwritten extents. The buffer_head
direct IO implementation made use of inode and end_io flags to track
whether an unwritten extent is eligible to be merged, or not. We don't
make use of these flags in the new direct IO iomap implementation,
effectively making the extent merging checks that make use these flags
redundant. However, it appears that even if additional merges and
splits are performed, it isn't deemed problematic as such and that's
due to the way that the filesystem now accommdates for unexpected
extent splits. The only real concern is the potential wasted
performance due to the unnecessary merge and split performed under
specific workloads. The full discussion that goes through these
details starts from here:
https://www.spinics.net/lists/linux-ext4/msg67173.html.

Thank you to all that took the time to review and provide constructive
feedback for previous patch series, highly appreciated.

Matthew Bobrowski (6):
  ext4: introduce direct IO read path using iomap infrastructure
  ext4: move inode extension/truncate code out from ext4_iomap_end()
  iomap: split size and error for iomap_dio_rw ->end_io
  ext4: reorder map.m_flags checks in ext4_iomap_begin()
  ext4: introduce direct IO write path using iomap infrastructure
  ext4: cleanup legacy buffer_head direct IO code

 fs/ext4/ext4.h        |   3 -
 fs/ext4/extents.c     |  11 +-
 fs/ext4/file.c        | 364 +++++++++++++++++++++++------
 fs/ext4/inode.c       | 516 +++++-------------------------------------
 fs/iomap/direct-io.c  |   9 +-
 fs/xfs/xfs_file.c     |   8 +-
 include/linux/iomap.h |   4 +-
 7 files changed, 363 insertions(+), 552 deletions(-)

-- 
2.20.1

