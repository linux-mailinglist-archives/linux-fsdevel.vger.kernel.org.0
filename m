Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A24E4375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiCVP6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiCVP6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:58:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D669F6CA4B;
        Tue, 22 Mar 2022 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aPFiOr5G7mMDnn6nH3mubjuHCB6ew1WgsZAJpnOOBQY=; b=Paq8OJUn9rPn0MITXmbsxum2+i
        A+4LVVO065UePaGqt6XAiZ6EiFIDUPbAxzbBypGmEp4QRA5vaBSO6wrl+yJ9xXKgbt81cCH5LL+cM
        9HkUK8AX8sXxTi1epWW2erBfP2bRq9URA64RcvXH9m4rusD8ks4jnJkTBvavA61gozd5wL/92zHJs
        LCSVyG7IIeMLAoVr2B+uVraSHjkLVY0Y5PXWC0wMWAjMGlgjWzhvzAUIZ259UMS7CnqeTNqArsxPw
        DwXXChaTudRFZVWI6IFkCsXXM5FT7GykidkBSTj7KayA6T5FHpK//AqnGlu/laUBMo7Mx7wT8frWv
        mjgFZaAQ==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgs9-00Bahn-8C; Tue, 22 Mar 2022 15:56:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/40] btrfs: move the call to bio_set_dev out of submit_stripe_bio
Date:   Tue, 22 Mar 2022 16:55:37 +0100
Message-Id: <20220322155606.1267165-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Prepare for additional refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bfa8e825e5047..5dc2a89682a22 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6751,7 +6751,6 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
-	bio_set_dev(bio, dev->bdev);
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
@@ -6843,6 +6842,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		else
 			bio = first_bio;
 
+		bio_set_dev(bio, dev->bdev);
 		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
 	}
 	btrfs_bio_counter_dec(fs_info);
-- 
2.30.2

