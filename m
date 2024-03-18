Return-Path: <linux-fsdevel+bounces-14681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D9887E1BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 02:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A261F21DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC41CD07;
	Mon, 18 Mar 2024 01:32:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97218049;
	Mon, 18 Mar 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710725536; cv=none; b=mXnImmes+KNb+6HNoX/G6zlbReyQOaDubNjhMRWsjNIo3Di4Gu2BvDXdeWuRgu9u1P7UvABTxW+lSQlm5b9vnpzwZbceyRtcYhekV7P7hXvupVvblo+TOtUxeREaJ9WOF0ex0w2HfMZejixogzSVcHrSkfQnZQbX4SQKcTnuYBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710725536; c=relaxed/simple;
	bh=CtVxhV1IdXq6fPflY2fch1UAMN51oJLk+I6IpNjr3ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpQKBgQybNllB1Mf8FRiv/B8ztbkCcKyRRNt9beyIha2uTR+MXIh3ksIl/uAj1Pgn1l/KJivXMsOi8ZvHTcyZF3Osd1C9my3cJAGr2oTl4OVn2minXfHOkSHOg1kzIenjlNNdnbDgdoq6sJhRfXLsibFudz7aI2VhqFmXIR102s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EE3C68BEB; Mon, 18 Mar 2024 02:32:09 +0100 (CET)
Date: Mon, 18 Mar 2024 02:32:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240318013208.GA23711@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-20-yukuai1@huaweicloud.com> <20240317213847.GD10665@lst.de> <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 18, 2024 at 09:26:48AM +0800, Yu Kuai wrote:
> Because there is a real filesystem(devtmpfs) used for raw block devcie
> file operations, open syscall to devtmpfs:
>
> blkdev_open
>  bdev = blkdev_get_no_open
>  bdev_open -> pass in file is from devtmpfs
>  -> in this case, file inode is from devtmpfs,

But file->f_mapping->host should still point to the bdevfs inode,
and file->f_mapping->host is what everything in the I/O path should
be using.

> Then later, in blkdev_iomap_begin(), bd_inode is passed in and there is
> no access to the devtmpfs file, we can't use s_bdev_file() as other
> filesystems here.

We can just pass the file down in iomap_iter.private

