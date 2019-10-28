Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D77E6FE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfJ1KuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:50:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44335 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbfJ1KuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:50:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so5159067pll.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LvbFfeKV3nz2hEYpQnhJJq59AxtU+a0JI4ei8YANrcI=;
        b=ipd2f1F7/F+/L1Jlgz8gwzHnOJvSgQxJLVSvXDQf5x5qUow/0ivIemBGuK4wrh+MkR
         a9gC8ZBaAh9dRz1HYWrJQ8z1DDUN+J6gHnrezALemj0FQnjZOP66aXMCrbyw93Ki9Gx7
         UGAFF5R5ezlDmwkLkyCbGwYBy5XCz9NclWKe2gEqtQT5zhSVGZgzd3L3EONcVbTu0lTE
         KaKsmVMcA0MRGUjLjAlp6JWV5nXCjjMlsaD78BrJuL76kphgDnS3Te+/9tPaxeQSQ9P3
         Za4ydVxbvBFuKZOsWFaBRkPmosb5HkmuHQ4zJnq0uVErrMMi+t5H5tilnrGI5vt1QfcD
         Mj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LvbFfeKV3nz2hEYpQnhJJq59AxtU+a0JI4ei8YANrcI=;
        b=epC2eNE3RTIfzO9wnv668xp5qvdStqc5KzUkLWqnbkXbTni/QjWl2Ds/wTSBZSBrg6
         WWlFTHOXegStW2keEGSelSBj0EX+gCEQlbMyVYELjmpM9eVbd8Rai/LBs0yJAECLbQoV
         vbLWgE+/eR3hDOE1UxJLsLPcEduDcwAIG158lVCBlAZzeHbL7Gf1LlMy98sE+O301Y8O
         bAsnYVv/DVry7hJSz3nLi0J+iHYEbNMBwupSJG5mieC4cl0q34Et5E/RTA49trLKswYk
         i7J6vZKHEC2faOoDN2ZY91cbg4fkhXr3432v+elfObrn05x2qksj2R2MbqeTD+Y+2XD/
         pRrQ==
X-Gm-Message-State: APjAAAWB5iccqIr86JSnV7q4DEY7EPQryZnEBYlvwpOD6nFpf9hwcEzj
        zGU5S7ZuOJaOkXzdShXV3uRM
X-Google-Smtp-Source: APXvYqwG/GI8rz1BSP7NAzZnrH0YMKGqLiq0XCa3e/YAgha+mcrKAV1a0ep1nmmT/gm6H+Q46/nHig==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr18674434plc.169.1572259809999;
        Mon, 28 Oct 2019 03:50:09 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id d7sm10289333pfr.108.2019.10.28.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:50:09 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:50:03 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

OK, so I think we're now coming very close to having this patch series
ready, if not already there. I've made some slight amendments to this
patch series as a result of the last round of feedback. This patch
series is based off Darrick's iomap-for-next branch, as there are some
iomap API changes there that we're dependent on here.

Changes since v5:

 - Fixed up calling into __generic_file_fsync() from
   ext4_sync_file(). Previously this caused a recursive lock situation
   when the filesystem was created without a journal.

 - Rolled up the orphan handling code from ext4_dio_write_iter() into
   ext4_handle_inode_extension().

 - Dropped redundant conditional statement and expression from
   ext4_iomap_is_delalloc().

 - Fixed up a couple comments, changelogs, as well as some other
   really minor grammatical corrections.

This patch series ports the ext4 direct I/O paths over to the iomap
infrastructure. The legacy buffer_head based direct I/O implementation
has subsequently been removed as it's no longer in use. The result of
this change is that ext4 now uses the newer iomap framework for direct
I/O read/write operations. Overall, this results in a much cleaner
direct I/O implementation and keeps this code isolated from the
buffer_head internals. In addition to this, a slight performance boost
may be expected while using O_SYNC | O_DIRECT.

The changes within this patch series have been tested via xfstests in
both DAX and non-DAX modes using the various filesystem configuration
options, including: 4k, dioread_nolock, nojournal.

Matthew Bobrowski (11):
  ext4: reorder map.m_flags checks within ext4_iomap_begin()
  ext4: update direct I/O read lock pattern for IOCB_NOWAIT
  ext4: iomap that extends beyond EOF should be marked dirty
  ext4: move set iomap routines into a separate helper ext4_set_iomap()
  ext4: split IOMAP_WRITE branch in ext4_iomap_begin() into helper
  ext4: introduce new callback for IOMAP_REPORT
  ext4: introduce direct I/O read using iomap infrastructure
  ext4: move inode extension/truncate code out from ->iomap_end()
    callback
  ext4: move inode extension check out from ext4_iomap_alloc()
  ext4: update ext4_sync_file() to not use __generic_file_fsync()
  ext4: introduce direct I/O write using iomap infrastructure

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c |  11 +-
 fs/ext4/file.c    | 387 ++++++++++++++++++++-----
 fs/ext4/fsync.c   |  72 +++--
 fs/ext4/inode.c   | 714 +++++++++++-----------------------------------
 5 files changed, 537 insertions(+), 651 deletions(-)

-- 
2.20.1

