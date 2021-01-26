Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF25305D0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313568AbhAZWgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404890AbhAZT7y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:59:54 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278EEC0613D6;
        Tue, 26 Jan 2021 11:59:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so3503557wml.4;
        Tue, 26 Jan 2021 11:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/dDIOKSJWoqDTk0FZlKbb5WJxRrq5s89obAFyPnn+E=;
        b=YTuimI9C7eAU5UPa/+Fj//lwk7gPiGPewvllL+0Ok38zDSSIJ3D7EizZjXg5qysJ3J
         qb2DbfA6e/k9qyrpLAJU90GF2j3hDKFKX7mDNLQovQrbl6K7OSNCcFW76bv3reK343WJ
         7/3JcMl/ghFahj4+XDwhWBgzSJpTbzNLCfPyoQGNNx1n2ZwFtDTzntygtAzvvoS8kTSH
         AhqBNr6UI5Dx0mqcbUEMwD1vF94FbBUAs9V9GKMf6ae8FXWbdlk5c05Jq6lvVnHQG4ic
         vBUnmf63cKW5x0bB6jdkJE5xc4tJJskf9XlViYG6Muna14O2ig7SZSymtR5v6+MQVYH4
         zjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/dDIOKSJWoqDTk0FZlKbb5WJxRrq5s89obAFyPnn+E=;
        b=VwQWGP9kh44+iWVstXLXMdSGZCNiOE7dL3tSVPh+IQ+QvoWB4qNCB7CMT9Sv+UyKWj
         quyY68lwV194M0eaMRkxcG45aLfAdyapV5v5dA9zM+2llbMHy0oHTxtzGb6Y4oXg8bJq
         gVTV6hAlEh8fJbtoXtawU0NVyF94A303TZEQE2OrQVx4AAvx5ds9WTTj2H5yfTnUGYqm
         60/11QhEFmXvfrDqNh1oLdjCbbqLj0DBxu8lxJk8Y3eY7/kcDLsnNelEYo25dDjw5A02
         dIZyPqpxwIChgbTHrnAKaXEAn/dF2jo0H9t6ji4p0j878o1yVJAB/zf041wrtn2xDcFh
         W+dg==
X-Gm-Message-State: AOAM531VEzMg67XlQyElKc04cypZRRGoyhnbh3WDYayU1q2isXCwGEeh
        rjBAbGSlpHB2dlB0WuupLog=
X-Google-Smtp-Source: ABdhPJzOFbzyDewVYfOof2sd/OTH0kKSHxfbvcptEq+e4wMs3HMBhFrQik+dCVq1j5NNLb2w3fGbpQ==
X-Received: by 2002:a1c:2003:: with SMTP id g3mr1145446wmg.90.1611691150967;
        Tue, 26 Jan 2021 11:59:10 -0800 (PST)
Received: from warrior.lan ([2a03:7380:2407:423c:8b0b:377:3cef:94ac])
        by smtp.gmail.com with ESMTPSA id z15sm3845114wrs.25.2021.01.26.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:59:10 -0800 (PST)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] Revert "block: simplify set_init_blocksize" to regain lost performance
Date:   Tue, 26 Jan 2021 21:59:07 +0200
Message-Id: <20210126195907.2273494-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cited commit introduced a serious regression with SATA write speed,
as found by bisecting. This patch reverts this commit, which restores
write speed back to the values observed before this commit.

The performance tests were done on a Helios4 NAS (2nd batch) with 4 HDDs
(WD8003FFBX) using dd (bs=1M count=2000). "Direct" is a test with a
single HDD, the rest are different RAID levels built over the first
partitions of 4 HDDs. Test results are in MB/s, R is read, W is write.

                | Direct | RAID0 | RAID10 f2 | RAID10 n2 | RAID6
----------------+--------+-------+-----------+-----------+--------
9011495c9466    | R:256  | R:313 | R:276     | R:313     | R:323
(before faulty) | W:254  | W:253 | W:195     | W:204     | W:117
----------------+--------+-------+-----------+-----------+--------
5ff9f19231a0    | R:257  | R:398 | R:312     | R:344     | R:391
(faulty commit) | W:154  | W:122 | W:67.7    | W:66.6    | W:67.2
----------------+--------+-------+-----------+-----------+--------
5.10.10         | R:256  | R:401 | R:312     | R:356     | R:375
unpatched       | W:149  | W:123 | W:64      | W:64.1    | W:61.5
----------------+--------+-------+-----------+-----------+--------
5.10.10         | R:255  | R:396 | R:312     | R:340     | R:393
patched         | W:247  | W:274 | W:220     | W:225     | W:121

Applying this patch doesn't hurt read performance, while improves the
write speed by 1.5x - 3.5x (more impact on RAID tests). The write speed
is restored back to the state before the faulty commit, and even a bit
higher in RAID tests (which aren't HDD-bound on this device) - that is
likely related to other optimizations done between the faulty commit and
5.10.10 which also improved the read speed.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Fixes: 5ff9f19231a0 ("block: simplify set_init_blocksize")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3b8963e228a1..235b5042672e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -130,7 +130,15 @@ EXPORT_SYMBOL(truncate_bdev_range);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
-	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
+	unsigned int bsize = bdev_logical_block_size(bdev);
+	loff_t size = i_size_read(bdev->bd_inode);
+
+	while (bsize < PAGE_SIZE) {
+		if (size & bsize)
+			break;
+		bsize <<= 1;
+	}
+	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
-- 
2.30.0

