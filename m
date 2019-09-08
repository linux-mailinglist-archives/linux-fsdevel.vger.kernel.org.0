Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC97EAD129
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfIHXTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:19:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46331 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731260AbfIHXTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:19:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7965132pfg.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BEDKpXPdUTV7XE4Q14Y66bFncWGnnigD83Lkh90WyW8=;
        b=VX1ufSX+EkshMc6s83N6qaf+btBEf9yhfbW6461tj53vckr/OoZpr8badf1c6bVRW2
         Xy4o50K2g/HgazBt17HSZx2wlmvSA+iDTiixxTMb88DQgpdWJ1zGSpY8ovSwe2fKg2mM
         8g0CwKKXWpzS+GGk7KjRMb/HnGsU2At8MlqcSRPE6bxllUHdnQiAf7ZGiAaTsIx0xsGj
         JMK9/lFKyEjE9wfOqSxxyTu3W7n9yxZGa5FD1c6rQaqgQaQDQY+Vn+o7XNj9r2+XpBAL
         gWsfOhupO5gXSKP4xgGU1dCQ9tjrtZT+Oh2KfPucABgzCcf6zXbuAq0Ys/h6fENTWdVm
         Nhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEDKpXPdUTV7XE4Q14Y66bFncWGnnigD83Lkh90WyW8=;
        b=Mhh/qkh8cIJYR+u+QOdHBC/WBVSJtrQQalIKz/TGrF+NdKk0xfZzZapMW8/NlwJAXO
         UsyT5Kf8L993DjPGAdVQZ3aFtbmiIcSJ03oC9QxRgjfiykLQxvAalSE3ZQt7VAWZ3T3/
         wBaLJcwbKxBWbLYrs6+OASorqFzExh1hv+4ymN2aY1977qhHdtLKa/GHskLZxKt7HY86
         ueof3FP5uamlE3XbwaGBRCW5mRQdZqvBD/t+i9LTV4XjNK1WCWzZUn20X0VUnVMj8xC/
         2scA6P+R1lfTy1Ah6WqZ12ieW8YMYYtasDWFBtgWHOAzlqwQfzEDh6CgNtJ/b89+uDzF
         bnbw==
X-Gm-Message-State: APjAAAXeIIyVZKkdBBgtftAIpHfZOdQQToF5pYhu5z22SywPjExGCHrt
        iPva2n1pE9mz1XTzqaXrTIgN
X-Google-Smtp-Source: APXvYqy3mQm3z49ZC/NdLW7xH3ra53grqxkIsg20iZa9ZuVw7JEBHIfynKTyoqo6TLwR4fEcaiuMBg==
X-Received: by 2002:a17:90a:8c16:: with SMTP id a22mr13087982pjo.111.1567984790208;
        Sun, 08 Sep 2019 16:19:50 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id v18sm10904747pgl.87.2019.09.08.16.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:19:49 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:19:44 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 4/6] ext4: reorder map.m_flags checks in ext4_iomap_begin()
Message-ID: <38c2c1dd6f62f82e485b1a767ddeb49606439d67.1567978633.git.mbobrowski@mbobrowski.org>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567978633.git.mbobrowski@mbobrowski.org>
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

