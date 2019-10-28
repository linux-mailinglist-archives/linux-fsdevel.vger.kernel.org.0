Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C862E6FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 11:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbfJ1KvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 06:51:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37692 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbfJ1KvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 06:51:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so6646499pgi.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adn4gOH9wM1yK1i3uZc/QwdCwMT/Epp1BBGQLJPWPVM=;
        b=G9Md5Kat3ZszJ6WvVofzucKe1kR+H5u+O0+UtzEYZIgJOgKbina+CIMx7USP3hYliB
         5f+BUq26w57DXOCHzwjIe9LuGD+6Bu2VqhuJI+K2dRDNX1FNYQ/sgBuk0wP0m1JwOaCZ
         vOko0PQBkDVdh5mekf6tVVelrUCXtjEhT1AHa5Z/tfHx5VlMEpRkPqD865pdlyCbxsI+
         yVPyYnTzTnzlqh/2iwK7Ccm0dS2ijXW4ilvpsHClehDQw0vy5gkDM5Ha8KfdUbyEG2o4
         TQG8wHL2YgziVGM83VU+gFjg7czeqAN0AhzeLaMDix+EB7Sjh85rPKeJqvNMY1zvK2EG
         Dduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adn4gOH9wM1yK1i3uZc/QwdCwMT/Epp1BBGQLJPWPVM=;
        b=Cs4l18C8ygO5QB6W4aC/rnA31yzrVHpguUtoXBzmtESCEc/H/p0n8sA6n0P9zYd9He
         NNkfnsqiIdJZyjDDj7/1kXPvL0ARkmIMRxgDU+SymUf7l8TzfYOA8sWixqNbKx+DOdIh
         J1M1KNX0EBpSkEAWOJO+TU8TuyJdoUMskBHl2d4DrJJ/rxUs6y7gX/BObplLUaVFNxTB
         0SFki6hrTz+OAPACtRoYlzkbD7fq+UKl9DlcVdmFtXX4cWrH+ABd71F6/FcRwegi/msp
         +C9ttys5sbVQ0EubR56V6zOCvZeQJgz3dVek9GNvl/wzD7Tc6+ANZ2oLZRuCxTdcwNCg
         Jk0w==
X-Gm-Message-State: APjAAAUeEaC8U35SHQ32R9+5IsPqPF8vJFPnbe5IWfnfg59a8sR1t3zH
        Nc4nuP8phmorVxzxyk6sVFpiEdUzrw==
X-Google-Smtp-Source: APXvYqxxGA+x43l4hHBehKoNsCBRa2AermBDxa/8TQql01AraTK0RxXJ7Iu0d7PBH7mRoW5CoEHAYQ==
X-Received: by 2002:a62:5ac3:: with SMTP id o186mr19860150pfb.20.1572259861132;
        Mon, 28 Oct 2019 03:51:01 -0700 (PDT)
Received: from poseidon.bobrowski.net (d114-78-127-22.bla803.nsw.optusnet.com.au. [114.78.127.22])
        by smtp.gmail.com with ESMTPSA id 21sm2820419pfa.170.2019.10.28.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 03:51:00 -0700 (PDT)
Date:   Mon, 28 Oct 2019 21:50:54 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v6 02/11] ext4: update direct I/O read lock pattern for
 IOCB_NOWAIT
Message-ID: <17824b863511c87c3b4ea36531ca3c1430d30660.1572255425.git.mbobrowski@mbobrowski.org>
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

This patch updates the lock pattern in ext4_direct_IO_read() to not
block on inode lock in cases of IOCB_NOWAIT direct I/O reads. The
locking condition implemented here is similar to that of 942491c9e6d6
("xfs: fix AIM7 regression").

Fixes: 16c54688592c ("ext4: Allow parallel DIO reads")
Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/inode.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ee116344c420..0a9ea291cfab 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3837,7 +3837,13 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 	 * writes & truncates and since we take care of writing back page cache,
 	 * we are protected against page writeback as well.
 	 */
-	inode_lock_shared(inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
+			return -EAGAIN;
+	} else {
+		inode_lock_shared(inode);
+	}
+
 	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
 					   iocb->ki_pos + count - 1);
 	if (ret)
-- 
2.20.1

