Return-Path: <linux-fsdevel+bounces-17978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE38B4833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754D928220E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F65B145B3D;
	Sat, 27 Apr 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fZUZ8m1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED863B9;
	Sat, 27 Apr 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252211; cv=none; b=Vzm9e+w3h6YBkQ4upplzg0Kk3sttNjTzSGp7xzRqj50MQAWe2zo0GHeUZ3Nrx/SYVcVdZNiFmUZQYjU/cJUevsZhL7Fxvac0+tTiqIeHvHHrUoibl3AV44jUt9miGkCLQb8Orq/lrbROdBR6NjkAZc72Yg5GEAsR67DAKOyYfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252211; c=relaxed/simple;
	bh=dVsV+suRWdeSLs4M2uRGgnhXWCL23HP01Bass/RE1+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTT0GdULWF6B30wUpIbkY1XBIqXx44GmR6S3gASqJAd/WYiC2En/esvCUw66u/DhaWAWavC+q58S1rtJsLtJTcG9QZwNLku2Cg8gTdr+iSEFY2ulRnanolBMEhyjyB+AmCf/S3APDbme/Mu6X82Iv+Hdwzora8IHjRFfZpaOxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fZUZ8m1I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xFS+qBCy2Bcky/O/uXQHGoo0wfXXcYfy2ak+7vNvwmw=; b=fZUZ8m1IEx8EYaPX7L6Cex2RE5
	GlWSFtLJkNHsVnz4B0d+O8+7nCN1fcfzqKWhJKzsEuE5x9mWnIriMFjWghPzG/LUMf6csTtHgC0Xr
	hk0fkR41EgBmilvf2XJR/0JDKXohhk6qTriDjghnT4pS6WtKnGmKuzZFnrqVefGsqXPqgXJBTz33J
	Ke7S8cebKcAAMdQLO+pZG4SxbiGBqpbOIXkD7cD0VnriPyaVXoHzYs6j5wX7ta6Vf6zJ5TG1wq8ok
	Zb5rKClmJXRDqke4GG2XKAPntgEHalyHA3ShzPnw0hmPTInuyzsRaFNM+Gu9CcgCkEqvS/eJVlEt8
	tqFyM05A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s0pJ9-006H26-0S;
	Sat, 27 Apr 2024 21:10:07 +0000
Date: Sat, 27 Apr 2024 22:10:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/7] bcache_register(): don't bother with set_blocksize()
Message-ID: <20240427211007.GA1495312@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427210920.GR2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

We are not using __bread() anymore and read_cache_page_gfp() doesn't
care about block size.  Moreover, we should *not* change block
size on a device that is currently held exclusive - filesystems
that use buffer cache expect the block numbers to be interpreted
in units set by filesystem.

ACKed-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/md/bcache/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 330bcd9ea4a9..0ee5e17ae2dd 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2554,10 +2554,6 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	if (IS_ERR(bdev_file))
 		goto out_free_sb;
 
-	err = "failed to set blocksize";
-	if (set_blocksize(file_bdev(bdev_file), 4096))
-		goto out_blkdev_put;
-
 	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
 	if (err)
 		goto out_blkdev_put;
-- 
2.39.2


