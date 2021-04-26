Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F403A36B461
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhDZN4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhDZN4J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A378C061574;
        Mon, 26 Apr 2021 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ARSTr4gurE/VZTddIi1qs6m5xH6IWZR1moA6yIXa/GY=; b=Y2hQ1Kyuvx1g2fgWoRBKFasURE
        pJcC9lojCY50zMiLRYR/qjwnVJBi99rJwAVmsZO3M6z9aeYc+jLDFC/fe8XSv1uEVkwgox6GpKBVN
        yy5aFFHrIGiFDD5zjbZj2d0lb6EHm6AfkPHLjQ4T3PIWkVk/CceK9KWA1M1STiIGE8lDY4VdYGYOc
        3hsQVsr5MsD9UdsNLGhhQ2vVbmIAaKnhLn+7tULStPFFP/OaKIfwNYEYpq9/5b9UqZfi+WRlqUPQh
        sJlZ87Q758pqR7XhbRSAyQDjFqvdQm/zkGiub0CoW34cbIJWX6SSZSZcSd+xH3x0TyROz4VYr8XRS
        pkyguD9g==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hr-00FzpZ-Lw; Mon, 26 Apr 2021 13:55:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/12] block: define 'struct bvec_iter' as packed
Date:   Mon, 26 Apr 2021 15:48:20 +0200
Message-Id: <20210426134821.2191160-12-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

'struct bvec_iter' is embedded into 'struct bio', define it as packed
so that we can get one extra 4bytes for other uses without expanding
bio.

'struct bvec_iter' is often allocated on stack, so making it packed
doesn't affect performance. Also I have run io_uring on both
nvme/null_blk, and not observe performance effect in this way.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..a0c4f41dfc83 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,7 +43,7 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
-};
+} __packed;
 
 struct bvec_iter_all {
 	struct bio_vec	bv;
-- 
2.30.1

