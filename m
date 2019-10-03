Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A612C9D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfJCLc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:32:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33586 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbfJCLc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:32:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so1609671pfl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jm85ztTw6loR+224Tv9cB/n0utlhi6GT8VW3M5n6AjE=;
        b=oVR6bnX98C4ThAwx5Lbs+x477cjllNQuTDTk1YD8TtAL+MhxFl+LwHhpdHrA+GTxqs
         dIE5trm/6OHEvaNOKdjJEcY3YMPLTEvt1X4n7aBcq0U7dpJ+ImQbZpe8tUBPwoJb9qkq
         DNHc/nqZAmP3ICy7hjjQh0ZjVNiS34DgaYJGDVaje2ahjKeHhFQ+Y8EDBzVr6+352I6O
         q/hg/ZnZ9tV6Y9Owpg5WdhZzH7wORjtY8/gSV2WtfSa03E4GdAvvpU0a31qZ7bY14Xi0
         dAIhSALgm+QRH1qrbZ8PVhUxVlQ6fAJFzY+amq6f9/xFaoah02rT/VIJyS6OyYIoEj0E
         wQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jm85ztTw6loR+224Tv9cB/n0utlhi6GT8VW3M5n6AjE=;
        b=AYdFeXp27y51kO93QIDWDBtIgGrmCviyIgAi175rqKDea+ESn9eco/6OFuHgsPoUzk
         JdP1C3YwQHWFgyjkrtXhpTXEsgPZ0nWzDWZjw6eC/j8WInj9+UHiTdsRkJ20re6LiAbI
         KYM8xyhixAiZzo9RTHyKgWbQuA2fjPSs/Dkp0EupwWWJijobw8wTENOnjNEvvkolRjly
         oM1UWWtWNtFT98GHevVSORrwUkUUq7W7VsRC+wUSuSIQDDo2WywRNkNfUsk0LuXbmMTL
         oJrmD5EtP1YxFdk9BP+edYp/gnyqiY0NyTCkLj3Ur5dv8vsQNEpq2Lafk3zoHTzQAzCe
         /FaQ==
X-Gm-Message-State: APjAAAXMoMixMa0fbwryv5TzSU/Yv/b3I1df1VYjmSE7ksOhw/DxtTzF
        KOXsBeXWvpJeVHqEk6t6MND9
X-Google-Smtp-Source: APXvYqyD54ONlQLVF1ccr3hbQp3x5ECfWVqd9JkpwYA/z0HUvSCWEijRVg+kaXN8su+WmPLQ6bcabg==
X-Received: by 2002:a65:6858:: with SMTP id q24mr8995208pgt.236.1570102375382;
        Thu, 03 Oct 2019 04:32:55 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id j128sm3345936pfg.51.2019.10.03.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:32:54 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:32:48 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 0/8] ext4: port direct I/O to iomap infrastructure
Message-ID: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series ports the ext4 direct I/O paths over to the iomap
infrastructure. The legacy buffer_head based direct I/O paths have
subsequently been removed as they're no longer in use. The result of
this change is that ext4 now uses the newer iomap framework for direct
I/O operations, which results in an overall cleaner implementation and
keeps the code isolated from buffer_head internals. In addition to
this, a slight performance boost may be expected while using O_SYNC |
O_DIRECT I/O.

The changes within this patch series have been tested via xfstests in
both DAX and non-DAX modes using the various filesystem configuration
options i.e. 4k, dioread_nolock, etc.

Changes since v3:

 - Introduced a couple preparation patches around refactoring the ext4
   iomap code. This involved splitting chunks of the existing
   ->iomap_begin() callback into separate helpers.

 - Moved out the orphan handling code into a higher level caller. It
   used to be within ext4_iomap_begin(), but is now within
   ext4_dio_write_iter() and similarily ext4_dax_write_iter().

 - Renamed the helper function from ext4_dio_checks() to
   ext4_dio_supported(). Overall, it just reads better when using this
   helper throughout the code.

 - Cleaned up the ->end_io() handler. This was a result of refactoring
   ext4_handle_inode_extension() and allowing it to perform clean up
   routines for extension cases rather than calling
   ext4_handle_failed_inode_extension() explicitly.

 - Added a couple comments here and there to bits of logic that aren't
   immediately obvious.

 - Rather than having the clean up code in a separate patch at the end
   of the series, I've incorporated the clean up into the patches
   directly.

Thank you to all that took the time to review the patch series and
provide very valuable feedback. This includes Jan Kara, Christoph
Hellwig, Ritesh Harjani, and anybody else that I may have missed.

Matthew Bobrowski (8):
  ext4: move out iomap field population into separate helper
  ext4: move out IOMAP_WRITE path into separate helper
  ext4: introduce new callback for IOMAP_REPORT operations
  ext4: introduce direct I/O read path using iomap infrastructure
  ext4: move inode extension/truncate code out from ->iomap_end()
    callback
  ext4: move inode extension checks out from ext4_iomap_alloc()
  ext4: reorder map.m_flags checks in ext4_set_iomap()
  ext4: introduce direct I/O write path using iomap infrastructure

 fs/ext4/ext4.h    |   4 +-
 fs/ext4/extents.c |  11 +-
 fs/ext4/file.c    | 387 ++++++++++++++++++++-----
 fs/ext4/inode.c   | 709 +++++++++++-----------------------------------
 4 files changed, 484 insertions(+), 627 deletions(-)

-- 
2.20.1

