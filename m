Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA169DE7EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfJUJUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:20:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35305 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfJUJUg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:20:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so8040556pfw.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6aTkb4yzH7qH0ZPb7cWpZgOD2laaevcS5q6awwQkBmw=;
        b=KLunUWVfT4+mTcV+tMBougL2scDNrlt54x2ckYSM0GLdLrRFBHWAD67424BTH8eh1w
         bB8lYbZO41UdDj8j6CZ7JevPoINRlV7V+NEtnXU+rcaNaOS/BItEZpNqdHDZgR5nWEU7
         Vo3fYX0GqtL1ILqq95/Tgqf0BcO+F2SNCuwR0Tj14hygdZbHxxcf4UAVGmqZ2eGaUlHU
         r6YHAYMsGyWQq+b7/JqIFFmOAzSmlNx9Q/3MF5fiqzVNp471HVS/IATRXjCbPkEVvg10
         7pBzQJPwQVez0SYby/8W/6ke3r1aZ4lAFm6le0EYYd4pckTNbTj6jD36zyEFuq39A3PR
         xPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aTkb4yzH7qH0ZPb7cWpZgOD2laaevcS5q6awwQkBmw=;
        b=fZG6yRIzhU1j0WkEUcnYLZRlFkGffeSYIGxnxMZ7yEsmPEKi5yMUuB/KCRR2ccpPcb
         2YGjHkFIOUWhY6lQthfIpcGBclKMadpXIIFA17uIPSqLwG/VL30AIfCxNaZ2T7OAKB+/
         Dqd/nvJ8A9xDRhG6b6xNXwKVLqNji2h63hChDaOBhOE7KWPGMJ3OgfGeVHxdijMuAP+2
         y0ZQ1jsS1Q1pj+9znV6kqCC5ppxejvj6r/NlwOyAHmjBMEeR+EEUvo0NSEQZ97pXhfDp
         lnq7uwFtvNHAi3QxJXQQUD8DURf1QTTy4BHKmwp67ljuNi6HVB2G2ZLD9adAVOY1Z+6w
         E59Q==
X-Gm-Message-State: APjAAAWwRy8If5gScIJER3FvxBjsX2BJV71eyVmdmbkYK8QK7yvBpuwe
        gBuDsBdoE/cpmb4BfSsgvONo
X-Google-Smtp-Source: APXvYqxEUEl6I06XgVtcmgaqdPCbi69LP5xWeAACk9C94LIOhv7ztyDgHAs7X2iP0duau7w+Xt1Lcg==
X-Received: by 2002:a63:e056:: with SMTP id n22mr24050416pgj.73.1571649635750;
        Mon, 21 Oct 2019 02:20:35 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id 27sm1366785pgx.23.2019.10.21.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:20:35 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:20:29 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 11/12] ext4: reorder map->m_flags checks in
 ext4_set_iomap()
Message-ID: <a19bf499c10fc3d668ffee22519f3a8f62e8e307.1571647180.git.mbobrowski@mbobrowski.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571647178.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the direct I/O iomap write changes that follow in this patch
series, we need to accommodate for the case where the block mapping
flags passed to ext4_map_blocks() result in map->m_flags having both
EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In order for
allocated unwritten extents to be converted correctly in the
->end_io() handler, the iomap->type must be set to IOMAP_UNWRITTEN for
cases where map->m_flags has EXT4_MAP_UNWRITTEN set. Hence the reason
why we reshuffle the conditional statement in this patch.

This change is a no-op for DAX as the block mapping flags passed to
ext4_map_blocks() when the inode IS_DAX never results in both
EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a37112efe3fb..70ddcb9c2c1c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3428,10 +3428,19 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	iomap->length = (u64) map->m_len << blkbits;
 
 	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
-		if (map->m_flags & EXT4_MAP_MAPPED)
-			iomap->type = IOMAP_MAPPED;
-		else if (map->m_flags & EXT4_MAP_UNWRITTEN)
+		/*
+		 * Flags passed into ext4_map_blocks() for direct I/O writes
+		 * can result in map->m_flags having both EXT4_MAP_MAPPED and
+		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
+		 * extents to be converted to written extents correctly in the
+		 * ->end_io() handler, we need to ensure that the iomap->type
+		 *  is set appropriately. Hence the reason why we need to check
+		 *  whether EXT4_MAP_UNWRITTEN is set first.
+		 */
+		if (map->m_flags & EXT4_MAP_UNWRITTEN)
 			iomap->type = IOMAP_UNWRITTEN;
+		else if (map->m_flags & EXT4_MAP_MAPPED)
+			iomap->type = IOMAP_MAPPED;
 		iomap->addr = (u64) map->m_pblk << blkbits;
 	} else {
 		iomap->type = IOMAP_HOLE;
-- 
2.20.1

--<M>--
