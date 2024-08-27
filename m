Return-Path: <linux-fsdevel+bounces-27313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2296960262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A613728561E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB4155322;
	Tue, 27 Aug 2024 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/xBkBlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299523A1C4;
	Tue, 27 Aug 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741495; cv=none; b=donUhzw2rdA9RUjuuHl1lNlN1pq/TSY3HHnEHE25ubIvH75cG5ZocpWqT1qnLs1DN+0SZKyf89cebCs//7xkme7v39/x8Np0YH+GPrT9KG6f48QjLjturlyaMBjOKFXhn+JhSmbujzu5INHrE2mQ68nISn3akmBZGUpYoysKSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741495; c=relaxed/simple;
	bh=GFDgSREkc10KvJibkFoMGKetqK6/aq+WcOR08cWF8OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFBJmogakKrnWbudMTOGGtNoCzL3lRUzd3wAyonbdto5+DDovms+TWiDiFPAq5FlAGoaa2+YMG+IRKUJhhn1LrcSspcyo5gCczUnxL1FnAXz2ToRD5dojr8grsiKVYHlZEjy8a6bV78MbwYiydJDKks3ejMgmy3Vrmms6Or6ksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T/xBkBlC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qqxbe0v5qYjyQtS6Ev502TIe5IRKBV0K7OLmDV05ewU=; b=T/xBkBlCmF1znEw/QhxcgU9uSQ
	2rSFF2TBCbArQ5JmjbniSg04piyjhdYmCksiv/wT3WjaOYAaY/dyiH6zTB5wqvACCXDNQvEFqmjVR
	Ch5cI47req7Bs2Cv84EnPxyT5myY3JL0JIw04ibatvEXVjBYPBy5LovATfovE+bwm9gBGTDQdjw3q
	aW6q1/wPp+wwNa4gzgJlPCgtJ9g4PIDwS73yve6iAYwXAA+DtzSn0KUDK5ovdio42TtcsMUVcPaCb
	xGyWg462qAV87j27UmgjKg7fPK97CImsmlCIpdSi3ofOZn60GKzgAUDVmSfzVF6pCflsE9FgwkUBB
	GINvSmOw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siq37-0000000A6AF-2xNl;
	Tue, 27 Aug 2024 06:51:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/6] block: remove checks for FALLOC_FL_NO_HIDE_STALE
Date: Tue, 27 Aug 2024 08:50:45 +0200
Message-ID: <20240827065123.1762168-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827065123.1762168-1-hch@lst.de>
References: <20240827065123.1762168-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While the FALLOC_FL_NO_HIDE_STALE value has been registered, it has
always been rejected by vfs_fallocate before making it into
blkdev_fallocate because it isn't in the supported mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9825c1713a49a9..7f48f03a62e9a8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -771,7 +771,7 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+		 FALLOC_FL_ZERO_RANGE)
 
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
@@ -830,14 +830,6 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
-	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = truncate_bdev_range(bdev, file_to_blk_mode(file), start, end);
-		if (error)
-			goto fail;
-
-		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL);
-		break;
 	default:
 		error = -EOPNOTSUPP;
 	}
-- 
2.43.0


