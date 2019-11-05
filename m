Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2346CEFCC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbfKEL7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 06:59:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32859 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfKEL7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:59:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so2292626plb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 03:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VdKsd//dFRQ9+Fa8NSM2awvny3x28JChjcL7z2bSow=;
        b=u65yxE2wOCCjxGBRaPCG/rOGpX2Twv/PDVqQzPPBYm/w0c/Jk2T5953b5F36jTIchw
         xGbVJdUM2MFzgXacBQN5MuBXajw4c7KzLpv0lxWeEFuUa/NFstbyioNZPh/uV2ktZQn8
         tyxeOGSHPfD4prABCaVEAX3RKHi4TUft5iratmp+cvdtidV2aj9zlRXmQFNAuCDvhojM
         dltROoO9jOfPaY3dkDqF6gokRZsd5X2Zm8ew/WM52H+ppplKsA9o/tHkt5YPjy8ikt4p
         C6RvsJbGsVnOQXlFNZuY10hD9olTozHlEUqdpSuC6qAmpqDfm8oEg9V6RJm0GOlsXMqz
         b9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VdKsd//dFRQ9+Fa8NSM2awvny3x28JChjcL7z2bSow=;
        b=Rws1gkK6XyzoGv+FWB2KjBoSgGE1+qQ+ikYxXg1RVn0gxFJCTws7BJfC7bgBPi5oB/
         C5/BHUWVbnqktT/2UJz0hvaKteeVjALqzIpwJgGGBmYcio2N9awinX80mXVRQsXwBQ4L
         nUY7YhR2NYplclJSglZZhJxIXLAxHD0J9i1G00Yhqy3Iemrtsv+XyEll52A4jjAWkBvS
         g0bqij12S/Gwr5HsMfyvQlvpn4ANLWTyFvr3Rs4ngZj6H3hdxH6E/BMsvQaiFfRlmbW6
         JhcIuSVuRmY+pcVzBFYTbYW6B5q9NK4BfuH1KDumK1U8CXM4QltJIOi+ti8KRBZucu6y
         Kl0w==
X-Gm-Message-State: APjAAAWZi9hkoIvQsziAd9DwD/9iv278P8SPsulnvUp1rzcYtc1G3gWG
        wGEpIDzlTDs0J9Y4KfjA96kGCl17jw==
X-Google-Smtp-Source: APXvYqxLZgDUPW0YSoxvlIBvju48Z+fGQ6cHAThEnnmp+LPOgzqGUQGVeHFqEl77HxXzNX6ZnwsVeA==
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr19690622plj.329.1572955141857;
        Tue, 05 Nov 2019 03:59:01 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id z18sm22687374pfq.182.2019.11.05.03.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:59:01 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:58:55 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 01/11] ext4: reorder map.m_flags checks within
 ext4_iomap_begin()
Message-ID: <1309ad80d31a637b2deed55a85283d582a54a26a.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
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
index 0d8971b819e9..e4b0722717b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3577,10 +3577,20 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

