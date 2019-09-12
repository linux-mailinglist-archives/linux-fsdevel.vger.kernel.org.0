Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA86B0D87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 13:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfILLEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 07:04:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35904 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731030AbfILLEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:04:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so11627383plr.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xvKXFdBtQB3yQOurXNo/gI3+u2ypREteaJJMao+E0oY=;
        b=GRD5iLLAZIiHjSZmiGrdMxTxBL0svd2jLL5cR9tu/mkuuXp1Z02fexdFKypzqelRnG
         3YHrwGxOvyReaTCChNyLtjut6xtgCOAiJuLOjeGbt4PBga8+JeoVTYCUWApK++fB8rSO
         nHkTWHZILK/QhxWHyXslhQKKEwm7BvvZNfR0oHjEiGVF3Pdws8DIUleCNFYcMaMH22Uh
         mNOX7fwazz25TkYeIQ24HOK4xpsJIrbGb3drqQWcgNsSktb4TeLGSmwEAyaR9NcHnS0v
         u4BY935fQphE0PHoBpYu4MlpG4+/X8W5jsA78MLxIE9jlfCkAlfpSnsWUWKSAfau0LLf
         vfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xvKXFdBtQB3yQOurXNo/gI3+u2ypREteaJJMao+E0oY=;
        b=WGN4yo3nIANyf7WdxWte2w7cM0BIHjBnxcwDtfUOALJ50uUhK0UStVfpSJct0isk/Y
         Zsnc11/mc91ffcHpmavQu1uKGHvO1HunWDiTKGocDxn62Ag+YG+QJAOJ2eKR6FfJt2Hn
         zs58oADo+QhHspZLuvfvYhJ/HvaGQ1Z72tLhIwQ1XvIMhf6hagh+EHOda4gLPdQ3VNYI
         WWcGcePn36IBoSP4qK+d3lt6KpHhnhJp66pF48OBzsBMc+k4FOzLC8eblQ0NXddVILMV
         iqLtHQT99j9xbULwwBxT5baRcM9u1tvO+nBccHKEu46AUu5vYRkKC2Babzkug4zdxEmO
         LbgQ==
X-Gm-Message-State: APjAAAVS/EFk/s0w56Awqi0Mipw1SCTMKIa2IsWsO7j6P8L/dDzVbGbU
        bAX67SCYnGmSg8+VXH3+28KA
X-Google-Smtp-Source: APXvYqyOnsSaZsJ0jffDI1vKPRo2tnN5Byf320Ia4ne7aaX5w4i15A1uQIjpaMFpviMtNJg107a0mA==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr42970540ple.34.1568286277818;
        Thu, 12 Sep 2019 04:04:37 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id a6sm6636090pgb.34.2019.09.12.04.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 04:04:36 -0700 (PDT)
Date:   Thu, 12 Sep 2019 21:04:30 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v3 4/6] ext4: reorder map.m_flags checks in ext4_iomap_begin()
Message-ID: <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For iomap direct IO write code path changes, we need to accommodate
for the case where the block mapping flags passed to ext4_map_blocks()
will result in m_flags having both EXT4_MAP_MAPPED and
EXT4_MAP_UNWRITTEN bits set. In order for the allocated unwritten
extents to be converted properly in the end_io handler, iomap->type
must be set to IOMAP_UNWRITTEN, so we need to reshuffle the
conditional statement in order to achieve this.

This change is a no-op for DAX code path as the block mapping flag
passed to ext4_map_blocks() when IS_DAX(inode) never results in
EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at once.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 761ce6286b05..efb184928e51 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3581,10 +3581,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		/*
+		 * Flags passed to ext4_map_blocks() for direct IO
+		 * writes can result in m_flags having both
+		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
+		 * order for allocated unwritten extents to be
+		 * converted to written extents in the end_io handler
+		 * correctly, we need to ensure that the iomap->type
+		 * is also set appropriately in that case. Thus, we
+		 * need to check whether EXT4_MAP_UNWRITTEN is set
+		 * first.
+		 */
+		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
 			iomap->type = IOMAP_UNWRITTEN;
+		} else if (map.m_flags & EXT4_MAP_MAPPED) {
+			iomap->type = IOMAP_MAPPED;
 		} else {
 			WARN_ON_ONCE(1);
 			return -EIO;
-- 
2.20.1

