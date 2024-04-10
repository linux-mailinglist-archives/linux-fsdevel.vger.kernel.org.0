Return-Path: <linux-fsdevel+bounces-16615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B289FECC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 19:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346FF1C221F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71717F371;
	Wed, 10 Apr 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eE3Aw0Mx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6E31A60;
	Wed, 10 Apr 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770844; cv=none; b=PhTiVQ3cZwwQT+U9PEUaSN2Y/KSIdwO4CqNCuKwh8mIfN4Yh4OW642fe7onpF4J4qS3x8kOUBcZDN5QWl45vMyFkFms6TpmWYraCnGvEWJuX450r0JWjNjixkcJf/Qbr2tOwEftKv6iDfMlZuilgG3f+z3ODhPSm5dGszot6IT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770844; c=relaxed/simple;
	bh=Gjl3wSp7ur8Qunu2dD8FGg1cqgp+5LVBQ1YktW9N5Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0B3hfJLEDeBmNWZmgkQfj+xy0KmwVnlwWrmxmzL6AnRHdwgkd3WA2B+POm2d3dFUqBRUTWnDAVbPVyvdiNyN9k63HNT6b0tTbfnNQQT/CiaG+lk5EG4qp55fT1QgFB+A4AJrb83Lebwhq+LHsW32BbELs8m+sYNh5+sc6SabGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eE3Aw0Mx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0xwc7/CqYk8fCzFRTxKDO4UHVWB8MLf/q3BVtND24kU=; b=eE3Aw0Mxe6eg7eMz/Z2gDLXvD+
	d0x3C81beNQrgj1ZTa1RptP4BHKEklNyxZqSTrzymaYPPCUKiS1YZ8/23BRcnA5N4KG9G5PlUEarl
	l22bvYh3AjPGteN2/lTzyDFegWrZUuJzKIgP8z7mJg4A5402nOv5qzGz8QN0VEtg4ZxNWs4853YHL
	TTfvt9Ju66nOeA655bxf5pmDJBSPW+p0rRDqyE2hoIECpUa5t1MYq8JfLkR0/td54Krg3yCF6lQ/d
	y7edX1WuuwwXrl7jgZ/qONzV49M4WL7L9/Se+Ccnq9B9zzvgPLZ3dF3kvzL/0g57muPdYwB44cQO3
	2hMfi/ig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rubvq-00A01R-3C;
	Wed, 10 Apr 2024 17:40:23 +0000
Date: Wed, 10 Apr 2024 18:40:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Sakai <msakai@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com, dm-devel@lists.linux.dev
Subject: Re: [PATCH vfs.all 19/26] dm-vdo: convert to use bdev_file
Message-ID: <20240410174022.GF2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-20-yukuai1@huaweicloud.com>
 <a8493592-2a9b-ac14-f914-c747aa4455f3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8493592-2a9b-ac14-f914-c747aa4455f3@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 10, 2024 at 01:26:47PM -0400, Matthew Sakai wrote:

> > 'dm_dev->bdev_file', it's ok to get inode from the file.

It can be done much easier, though -

[PATCH] dm-vdo: use bdev_nr_bytes(bdev) instead of i_size_read(bdev->bd_inode)

going to be faster, actually - shift is cheaper than dereference...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/md/dm-vdo/dm-vdo-target.c b/drivers/md/dm-vdo/dm-vdo-target.c
index 5a4b0a927f56..b423bec6458b 100644
--- a/drivers/md/dm-vdo/dm-vdo-target.c
+++ b/drivers/md/dm-vdo/dm-vdo-target.c
@@ -878,7 +878,7 @@ static int parse_device_config(int argc, char **argv, struct dm_target *ti,
 	}
 
 	if (config->version == 0) {
-		u64 device_size = i_size_read(config->owned_device->bdev->bd_inode);
+		u64 device_size = bdev_nr_bytes(config->owned_device->bdev);
 
 		config->physical_blocks = device_size / VDO_BLOCK_SIZE;
 	}
@@ -1011,7 +1011,7 @@ static void vdo_status(struct dm_target *ti, status_type_t status_type,
 
 static block_count_t __must_check get_underlying_device_block_count(const struct vdo *vdo)
 {
-	return i_size_read(vdo_get_backing_device(vdo)->bd_inode) / VDO_BLOCK_SIZE;
+	return bdev_nr_bytes(vdo_get_backing_device(vdo)) / VDO_BLOCK_SIZE;
 }
 
 static int __must_check process_vdo_message_locked(struct vdo *vdo, unsigned int argc,
diff --git a/drivers/md/dm-vdo/indexer/io-factory.c b/drivers/md/dm-vdo/indexer/io-factory.c
index 515765d35794..1bee9d63dc0a 100644
--- a/drivers/md/dm-vdo/indexer/io-factory.c
+++ b/drivers/md/dm-vdo/indexer/io-factory.c
@@ -90,7 +90,7 @@ void uds_put_io_factory(struct io_factory *factory)
 
 size_t uds_get_writable_size(struct io_factory *factory)
 {
-	return i_size_read(factory->bdev->bd_inode);
+	return bdev_nr_bytes(factory->bdev);
 }
 
 /* Create a struct dm_bufio_client for an index region starting at offset. */

