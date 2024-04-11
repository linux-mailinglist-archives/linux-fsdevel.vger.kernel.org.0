Return-Path: <linux-fsdevel+bounces-16694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D518A17E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045341C2232E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84914A8D;
	Thu, 11 Apr 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rmXZC7De"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E627101DA;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847237; cv=none; b=UZkX+dvdin9bwRX1JQ8dz0DW9czvTcLuDg6DkD5FJHEczGgzxttQUCoR8yAbhEn95NKuMRECU3ateHXBhC1iZkxu2GfhSxby7Z/8qEY6O+5q7HaGC535YsHow+gm0Pp2UP14ywF13YN+X9xV8eHNqYuxieArPMj+E9l2/k308gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847237; c=relaxed/simple;
	bh=zAITByYiV72lOMoe91l07QkEWei6RA5E3auDtCcolDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlgwkQbJRS95uK6jvHLz2s4iSd2lpGkpDU/NgdEcUfod8Y+sXsBcDuCXukmwbG+V21D1iJQFxyFFtkobbNttDVXxa8eMcUdZvKC0UNHnOPMH0aHYPCA+iXLfPG0rDjOntYIyVL18x3YpaDuRR/hJIrbxlswgtWHvg+TnuHNq0SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rmXZC7De; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9XhFbTG8u3egOjWcDtrIIq9/Ln61pWsIkkuBNf4W/84=; b=rmXZC7DeKvBsJ2kCslaReU6AEB
	FwagE4Ij2nYkU8WAUYMnCzN4lDmPyu2Ga+cowgugDFkCEDh07NJf9xeGvd+GjMUJsumVsnWaTr/Nb
	6hlo7VuEUv1O/Rl9/Fy6sbQh2bBpuZdPreyuocPnUxLDTt619PGpQOahIHTCKXaVO3bTETuMdt5vh
	T9xehGG21JlPR8oGrfRPZPJ7kfiymblAcc8dRBZpMBxalyGGEEa5ptMTXSDIImz5GulYtjWr4yoAt
	5Ofhe6I3/IpmQLbKzlbRAXnicJ+bh+lZNFEr22dljQC98dfj9/03d+4NySiSk9yzikNPAUP1Sf75Q
	l2iZis3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ruvoC-00AYlE-0P;
	Thu, 11 Apr 2024 14:53:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	hch@lst.de,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: [PATCH 10/11] bcachefs: remove dead function bdev_sectors()
Date: Thu, 11 Apr 2024 15:53:45 +0100
Message-Id: <20240411145346.2516848-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
References: <20240411144930.GI2118490@ZenIV>
 <20240411145346.2516848-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Yu Kuai <yukuai3@huawei.com>

bdev_sectors() is not used hence remove it.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/bcachefs/util.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index b7e7c29278fc..6d666986f39a 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -445,11 +445,6 @@ static inline unsigned fract_exp_two(unsigned x, unsigned fract_bits)
 void bch2_bio_map(struct bio *bio, void *base, size_t);
 int bch2_bio_alloc_pages(struct bio *, size_t, gfp_t);
 
-static inline sector_t bdev_sectors(struct block_device *bdev)
-{
-	return bdev->bd_inode->i_size >> 9;
-}
-
 #define closure_bio_submit(bio, cl)					\
 do {									\
 	closure_get(cl);						\
-- 
2.39.2


