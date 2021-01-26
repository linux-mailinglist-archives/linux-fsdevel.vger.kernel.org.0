Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EC230413F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405770AbhAZPAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391197AbhAZPAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:00:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17BC061A31;
        Tue, 26 Jan 2021 06:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nvbz5iYtrf14To4xrwKMIwRiNRZctL670kk4gnUD88w=; b=JoPiLXDSpvjKkodegpd/9Ki4eY
        +Xdf/GZ8NV/UcLDXZzZtEKsp27c7jZGL9XRkRoIjfSyaWrDECY/eM9d9EbW3hXiTfEZtMMSfbBElv
        gxIVvRv7JpUfBVu5HVmbC3V6jeIbpcuVLSOs+QAFB4JLCdJmf6UjhHo8cMfMWB6QtuEojK2aE4Zs4
        0EGwmh02yAfrn/3WhiiWW7P8cSoEUgeZK/uRN5Lli1a73a/4gQNDmMn9/nUDRCLyehO8q38TrrVt2
        Zp6tMS6WW0vuepmGDzOzrMfYXxlrsWqTSndYRyd8M3WUvaX0Wj1qAjSBNOpkRcDMl8FKs9wfJKhsN
        NNqeQ+0g==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4PjX-005m4E-5t; Tue, 26 Jan 2021 14:54:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 01/17] zonefs: use bio_alloc in zonefs_file_dio_append
Date:   Tue, 26 Jan 2021 15:52:31 +0100
Message-Id: <20210126145247.1964410-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126145247.1964410-1-hch@lst.de>
References: <20210126145247.1964410-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bio_alloc instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074beb..faea2ed34b4a37 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -678,7 +678,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	if (!nr_pages)
 		return 0;
 
-	bio = bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);
+	bio = bio_alloc(GFP_NOFS, nr_pages);
 	if (!bio)
 		return -ENOMEM;
 
-- 
2.29.2

