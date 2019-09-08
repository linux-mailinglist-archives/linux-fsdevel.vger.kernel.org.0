Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15685AD121
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfIHXSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:18:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45073 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731201AbfIHXSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:18:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id x3so5679201plr.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XtR7NCgyk644foWKKHXjEJ6/aEwW4hMsIVC72BpYIGw=;
        b=ZdGMKj3JQmVvUv0XrUuGvoVeuGBdaceDsst0Bae7Ult/3N20J8XEaQhflBHoSnHEKq
         fK9jhq3pRqSol0sQSBdErl9eJ0BLRA+cePcHfh9ZTDGbKfMMs8muItQ9ya++kwyuz9pe
         MhfA3X8gAOaN5VK+mRH5lVzbG1fT7zSKJ5R5zCKjA4cxU9fNghlHEV1RMdCvgaaH7Y1v
         WzH/aN3RjjgKNSCQf7/KkNKVs3VCnudYqhL1UEuf0E/KbEXkkWDMdGO48Gf2q+AysavQ
         71zuaYw1PTTP4k4gsSDh0Q/GtQAETRNP8d2L6P5xriHdt+tch0uD+bwX7p8ylbcZLzNY
         yJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XtR7NCgyk644foWKKHXjEJ6/aEwW4hMsIVC72BpYIGw=;
        b=JWCy8KSI7/rvdR//VhRt/k05+mo8L39bMJz7plr7zD5wScr3BALblUNaw4v7D2mikA
         j9iOq55mjTMKi43poLQyIhaivSixHOWqYzjqzynvmAjNaYtX3vxHcC2AycgxtMBiVmn+
         pULkrmP4/S94mlQ1oRBr2xJZhSp8kiAEDYx3r+BsIo5a5gLQvUePYahTD+Z+Hh2MMTlK
         m4EWloFidoB5tklxxVXaP4CZb5EsCXXRFc5TxgBbgMmq7AQO+oUqZSkmxrtRQvp4U5j6
         38Eaemx6EFdFwyRCD3JdtQ1WT7A5EipAdMmGNZ4m4H7f1DWDxRWfuI8i/tj9Jfwr9OvT
         RFWA==
X-Gm-Message-State: APjAAAXLWpQuOCnm63EsgqQkX/Qap2vKL+3KJILETN2WEg4wY8qhyqpx
        C37PLJOoVSqnUbGVuJ9YsfIr
X-Google-Smtp-Source: APXvYqzuHNJSxE4foCmCR4AX0Qdzr7GwzQpWQ3r7Cjh/5P38YK9XxY50BnDmvN9BwUKuJBHZ+4LAZw==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr21599455pld.266.1567984719116;
        Sun, 08 Sep 2019 16:18:39 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id az9sm10756029pjb.22.2019.09.08.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:18:38 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:18:32 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 0/6] ext4: port direct IO to iomap infrastructure
Message-ID: <cover.1567978633.git.mbobrowski@mbobrowski.org>
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

Changes since v1:

 - The error handling code within ext4_dio_write_end_io() has been
   moved out into a common helper ext4_handle_failed_inode_extension(),
   which is now used by both DAX and direct IO paths.

 - Simplified the conditional statement in ext4_iomap_begin() that
   determined which flags needed to be passed to ext4_map_blocks().

 - Split up patch 4/5 by taking out the hunk of code in
   ext4_iomap_begin() that determined the flag that should be assigned
   to iomap->type.

 - Introduced comments to snippets of code that are not immediately
   unambiguous and applied other minor cleanups based on the feedback
   that was received.

In the previous patch series, there was a relatively lengthy
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
  iomap: modify ->end_io() calling convention
  ext4: reorder map.m_flags checks in ext4_iomap_begin()
  ext4: introduce direct IO write path using iomap infrastructure
  ext4: cleanup legacy buffer_head direct IO code

 fs/ext4/ext4.h        |   3 -
 fs/ext4/extents.c     |  11 +-
 fs/ext4/file.c        | 363 +++++++++++++++++++++++------
 fs/ext4/inode.c       | 516 +++++-------------------------------------
 fs/iomap/direct-io.c  |   9 +-
 fs/xfs/xfs_file.c     |   8 +-
 include/linux/iomap.h |   4 +-
 7 files changed, 365 insertions(+), 549 deletions(-)

-- 
2.20.1

