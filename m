Return-Path: <linux-fsdevel+bounces-19007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30C8BF670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 08:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256A41C2156F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4F22EF5;
	Wed,  8 May 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MaQ8UFwb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134A1DA53
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150585; cv=none; b=l/XVZpcBhuE5ZtqB7OtRa0OPPPl9JJWuz2ddRnrzHTDnA/bGqLf6/v7MbNDhY36AtbjvPjiGAQwKeiUwQP76CrKOYHcoEgfhuuhs8hS0L8N4RCm6JgYnxtNFIXANQMi3Vfd3lSKZpT8Q5MIMjuaIQ1auCv1DOFn3sEMC42GdIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150585; c=relaxed/simple;
	bh=4AKcBf8T1mKo69V26eKRttQKogY/D5c0HXlT8kTQcfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNaSXiBn+4202xm/PHtTnR8n4Vw9f8h1tHURcYRpo+TFDF8YsDtVgCqc4hRx77YveylRLShXz/gdWCCxTENp65FiWuH5rYZlkqp4WKGEbY4bPtIBFf0snfyMUqTIjJ3PSpcS6p6HMRrPtNsLowx5Kc5Na/dFpLthN79K9ZXhRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MaQ8UFwb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gT1CHbrfj2ld1KCAZnaHgr9yRAWq/Q+f8sqf1E8X5lw=; b=MaQ8UFwbjhMrWM+Sg4tp1XlC0G
	6oy0nhoCy+XKCVEvelmBMNLRcRtEENflNTyKqH8Y+r1oAmLTPnAXNxg7628sJeteC3omBJLIFJ3bt
	hxcQBpzm6wpuN6kfquvRAzSeCoDiNVNKrTBBeLXYSHzF3l8pcmQ0MLqWFLZltJiA8ymYOqDyH1rik
	AZMZNWo1lKR7mC5V+Hq70h7k1qfVUwmlTgw1GZ7e1jCiVF4gSRcCvujV4oTXj0cNlt6Ibp1VJs6YH
	g3wl4URof/QbKjk/MiZFWwxMOul7JJAWy2mx/j88TCe7s0O/VW2vuQfhgi81v13lx3KKoeCzW7KOS
	z/nuDnqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4b13-00FvpC-38;
	Wed, 08 May 2024 06:43:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@lst.de
Subject: [PATCHES part 1 2/7] bcachefs: remove dead function bdev_sectors()
Date: Wed,  8 May 2024 07:42:56 +0100
Message-Id: <20240508064301.3797191-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
References: <20240508063522.GO2118490@ZenIV>
 <20240508064301.3797191-1-viro@zeniv.linux.org.uk>
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
Link: https://lore.kernel.org/r/20240411145346.2516848-10-viro@zeniv.linux.org.uk
Acked-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/bcachefs/util.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 5cf885b09986..5d2c470a49ac 100644
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


