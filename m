Return-Path: <linux-fsdevel+bounces-16305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0EF89ADF1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A47C1F225A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84C6FC3;
	Sun,  7 Apr 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G8O29jiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294825223;
	Sun,  7 Apr 2024 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712454723; cv=none; b=rytY3LNjj/62y5y9+lTRCO4DuHqRSxixvAzJbk2FDHABhxrjmiNfVbjEpLp1QOcHelDQiIruzp6TVQ9fDJkYiMzOjz1Vs3X1sdscC8O0FjPm/mLHc2FxySDTgeBQOqg30D0OD8j1i4Ox1diPt47JIFeGdvGz/mF0D4r6Y2UPu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712454723; c=relaxed/simple;
	bh=zL9xUChQLfWAWOEJQptkrG651v8G+VFFSZb7s9+BqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn4y6CBOoaQxrk+ABDwZ5PRiEfsx0OCv0Dw3tQ7ugmbSFpaezBubrc7CqI7G9xOkTSzk/r6krmiWsDibt/xe/MUuYKJYZQb7jbRwaJLsD7d3CtSLJb0xtVAmru9e+Rg3PwT9HupH/wSv9lrptGpLpoWjIMnbDZmY7N3OYgFujP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G8O29jiv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bT5MB27Gn1a1sIaTe5DzcfgsC1K1nohDwUHYHJYq+3Q=; b=G8O29jiv8ccbTk7eQlqb4g2k1U
	GEFsOqX653nL2wTSkPuuJntE8018kbPiZdEsLBqxDZlJe/tWDFee7aHvjxX27kp6AzeKElqmrQKYT
	EXEuTxQ8Q1AgvYFI8nzvwQjfunbPmsvbufYem/uuiv2f+ruoixkT0wxsSp/kUjhlwumjjaYaPOmp8
	fKulvO4klbzOXoVo/yknnuyl7hQhgRDsrRulV5u5XyTSicMp/sb19WB67jnOO/ymK396eAdD0QsZf
	ea9CaHsRkq1KLLAIRDKHQCEWCb/ElmSY0/ZcQHaltERK345DcnLzydN8C6Ks+cAQrjMR1qjQzBMtN
	PDF86cGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtHhF-007WzV-2F;
	Sun, 07 Apr 2024 01:51:49 +0000
Date: Sun, 7 Apr 2024 02:51:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240407015149.GG538574@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV>
 <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 07, 2024 at 09:18:20AM +0800, Yu Kuai wrote:

> Yes, patch 23-26 already do the work to remove the field block_device
> and convert to use bdev_file for iomap and buffer_head.

What for?  I mean, what makes that dummy struct file * any better than
struct block_device *?  What's the point?

I agree that keeping an opened struct file for a block device is
a good idea - certainly better than weird crap used to carry the
"how had it been opened" along with bdev.  But that does *not*
mean not keeping ->s_bdev around; we might or might not find that
convenient, but it's not "struct block_device is Evil(tm), let's
exorcise".

Why do we care to do anything to struct buffer_head?  Or to
struct bio, for that matter...

I'm not saying that parts of the patchset do not make sense on
their own, but I don't understand what the last part is all
about.

Al, still going through that series...

