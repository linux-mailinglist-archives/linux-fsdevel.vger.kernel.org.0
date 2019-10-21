Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B98DE7CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 11:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfJUJRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 05:17:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42292 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:17:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id c16so2575985plz.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kFIVgO2YksXRjD5tda5/UJj64Ei0B+eEt7Hnd2mM3NY=;
        b=Uo3zr7trKThC4pmfsXo30OGjFMvRyOBOVdnMVnzyxgz2PNeDwuKSNMjNzhP1JVRO3W
         MF54hl2lXse3UsGhdKYKNTAVNk2aH4tjd6aWqSpIpxDwnQCH9qBA2fTAdzDyyH9Tikbd
         EdR6BqYdnhlA/uo6f+8qJxN4/dz56qfhN1dnUCKYCiLiZEftc13fgDcEP57tRr8jiw7J
         pMydu2grPOc/myDJbKQNxQ5xOO3Pgd8SFcRalfg1KqQ5Trwi1mMd38z/xfnCLZnPGfa0
         2q+upjp9dF9gNjb3x+C5yU5aIxG+w7TVv6d5LuPxLwsebYxK7ldnBlp/o/OyaeG6rwoG
         5/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFIVgO2YksXRjD5tda5/UJj64Ei0B+eEt7Hnd2mM3NY=;
        b=Mk6y3TwH7cVQekhoELy5+42Bnu++cMZ+uRM7davN1iaxAc+riJljyVpRndDsHLWMKe
         zPBmSHvAlD3IuWvw8cnK3t1UcIorPe1yCSE+22U+RMd/3TrMG1mHcQCK6/9ZatqTRUKS
         IoQS21v+Ngrf/OqQPP3EHZ2Xy2X/Nz1IZDaqxkBIPVtYHXVwnflImh4NK7Tpdxmx+6VU
         KEgHzQMBNED99xXFZwre6hW2PcCTy+cAWPp1NwSpfoZpvqX0FH+nrIEd2Oca0U7YKoMl
         wt5cNn2O0A56FkcvOLn7l2MVOltS0RxWB8ihVQf4oXs5W8Zf7np3rl158rMiC5TSxoup
         iBFA==
X-Gm-Message-State: APjAAAV8jDlFK+i9r+kUwfACLbcKRH3Mm+x+6Y/1d9FhZlzOv0Ab4Poz
        lCk1Q/iL5vcDSrZK8xuvkSZDIqbf7Q==
X-Google-Smtp-Source: APXvYqz3mYx7cmUkHNEfnEKl7FxPqahCOgtXbxigRVZ8V12cpFeT5WCWPf/azOypVzAyGwm8WsG5Ow==
X-Received: by 2002:a17:902:9002:: with SMTP id a2mr24448909plp.147.1571649472765;
        Mon, 21 Oct 2019 02:17:52 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id t125sm17210797pfc.80.2019.10.21.02.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:17:51 -0700 (PDT)
Date:   Mon, 21 Oct 2019 20:17:46 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v5 02/12] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
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

This patch is effectively addressed what Dave Chinner had found and
fixed within this commit: 8a23414ee345. Justification for needing this
modification has been provided below:

When doing a direct IO that spans the current EOF, and there are
written blocks beyond EOF that extend beyond the current write, the
only metadata update that needs to be done is a file size extension.

However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
there is IO completion metadata updates required, and hence we may
fail to correctly sync file size extensions made in IO completion when
O_DSYNC writes are being used and the hardware supports FUA.

Hence when setting IOMAP_F_DIRTY, we need to also take into account
whether the iomap spans the current EOF. If it does, then we need to
mark it dirty so that IO completion will call generic_write_sync() to
flush the inode size update to stable storage correctly.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 158eea9a1944..0dd29ae5cc8c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3412,8 +3412,14 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 {
 	u8 blkbits = inode->i_blkbits;
 
+	/*
+	 * Writes that span EOF might trigger an I/O size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC, even if
+	 * there is no other metadata changes being made or are pending here.
+	 */
 	iomap->flags = 0;
-	if (ext4_inode_datasync_dirty(inode))
+	if (ext4_inode_datasync_dirty(inode) ||
+	    offset + length > i_size_read(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
 
 	if (map->m_flags & EXT4_MAP_NEW)
-- 
2.20.1

--<M>--
