Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3EE6FE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfJ1Kuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:50:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36919 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbfJ1Kuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:50:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id u9so1925237pfn.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ies8OSR13TA7Jp7kWGv+5wsPA+gLPOwFV0PFLes+tE=;
        b=idgzY9km4ZymqCqJaxtjO+0q0W941CVEFuRLmx4zne73d4vqSH/0Qe6y+ItLL8ln+a
         jIcdv0tlpUdzxcxd6KUo6VYCudr2nAL/MF6oyUjzuflIU6Q3PCnjy4JlfCtlxV80LaWl
         O6OtzimuKGGpbEzOTtsMd3O2q4BCHk9hLvHzbRmTRAAQvhv7PwBZ3EHUXvzEt68CGVQB
         x62msDbHzDthkeeKKrOuxBXi+fKmm+azxk8e8cwyE67sFtvZCtxTMKKNWsO0GivbfQ6B
         Y3fGwWpxdgVFdUOEwVPwnyQGh+Gx2V6e40NFMjejXGo8TlDR8Aq1iv9Zgc1sFoIIGvqu
         mWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ies8OSR13TA7Jp7kWGv+5wsPA+gLPOwFV0PFLes+tE=;
        b=GfMkPfV1Ms/qnYShMCB+2o4DQeqPy3dBaOLSV9J39/eCm4rxri7pAFJp+AYzpTHkFR
         RX7FWgguh5Ni+fNmCp+8SkjLTTjl0KoygkWidUkLirK9M91Ppmc2jtIrg+A5SoeONVRT
         fNAgR4BbQ3IVq276nwM/a6pa7GuEac1UuaYty21QSEWGw0+cUqt+xZcLJ4nUmaVi/F2Q
         3wlLrBiI7agu0QabpeXDn7Ey7xPb4IKQgb243rdFTNrKZsKFSGML2cQfNtebJTE1rWXg
         k9BJjfDaawtuNK7hCo5H7V6EpxrrejrLAeywC2+Bcg8GbRqFYCROaZ+4UAQG2S2fqDTN
         RgGQ==
X-Gm-Message-State: APjAAAUByJEuPOwe4dp84jJeHS1U8J3XqtSgk2Pii7iF3GCGbpkUVj6d
        hsLC1fvoZs4Vul6K3XeGLWWr
X-Google-Smtp-Source: APXvYqy//cEjP+6Jvq/xP++tGHTGJ/km9mLsA5w7vy0g4d1acQF3C/Wjg30kTBo+WdBztVYsI+ELiw==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr21536034pji.126.1572259839283;
        Mon, 28 Oct 2019 03:50:39 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id q13sm11740176pjq.0.2019.10.28.03.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:50:38 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:50:32 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 01/11] ext4: reorder map.m_flags checks within
 ext4_iomap_begin()
Message-ID: <7fcb28c72d81123f7882b8420b76860c05f302f8.1572255424.git.mbobrowski@mbobrowski.org>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572255424.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the direct I/O changes that follow in this patch series, we need
to accommodate for the case where the block mapping flags passed
through to ext4_map_blocks() result in m_flags having both
EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In order for any
allocated unwritten extents to be converted correctly in the
->end_io() handler, the iomap->type must be set to IOMAP_UNWRITTEN for
cases where the EXT4_MAP_UNWRITTEN bit has been set within
m_flags. Hence the reason why we need to reshuffle this conditional
statement around.

This change is a no-op for DAX as the block mapping flags passed
through to ext4_map_blocks() i.e. EXT4_GET_BLOCKS_CREATE_ZERO never
results in both EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN being set at
once.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index abaaf7d96ca4..ee116344c420 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3535,10 +3535,20 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 	} else {
-		if (map.m_flags & EXT4_MAP_MAPPED) {
-			iomap->type = IOMAP_MAPPED;
-		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
+		/*
+		 * Flags passed into ext4_map_blocks() for direct I/O writes
+		 * can result in m_flags having both EXT4_MAP_MAPPED and
+		 * EXT4_MAP_UNWRITTEN bits set. In order for any allocated
+		 * unwritten extents to be converted into written extents
+		 * correctly within the ->end_io() handler, we need to ensure
+		 * that the iomap->type is set appropriately. Hence the reason
+		 * why we need to check whether EXT4_MAP_UNWRITTEN is set
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

