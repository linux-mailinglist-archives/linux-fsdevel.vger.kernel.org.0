Return-Path: <linux-fsdevel+bounces-16765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065728A2415
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBAC1F22EE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 02:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDD14F7F;
	Fri, 12 Apr 2024 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nQA1sdRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB213FF5;
	Fri, 12 Apr 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890767; cv=none; b=RBG3L9gmHl7mjRT64q4BsjGHZxq/HvyNFm/9xPQASOz3wonyRYUvsjNSfzCr6O7b6awGyBm5YJYSUKwqRu96TqqqmdSCYpTFRwrOHPTQs1W0l6iWVtvhHjXsh6KLMY53rt4JgoJkbqKWV0mxcebgas1Ibsy/XTDsEE66kNA2mcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890767; c=relaxed/simple;
	bh=7SomgUsA1Qq2vlf1oUganfHwvlApdoZFh8j0xlO7c3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMxJe5diYAxSqRkOzh7GF+/KLQJ8f/oukbTrQ9bLzSw3OLGPD4vUN3fYL6VzV5ko4NlcXLh4LZAyznapwfNEDsTwLhi6s3dn3WEZ8AyWKOgOtG9RAj4twbJTWduNX5eMuwjMVvqi8T8r0UmETOgWc+CkyUkZKhMnvqJ449SjCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nQA1sdRt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tmrFo7Ace5AT6ilsEHkjcDFgjh8yjJTquw+T2TQgMos=; b=nQA1sdRtbjSzvFSnaJaUj+h1O2
	U/lPUC/LOqn9oJew2ZwMcGUZJj2UI/eTVFJnm3X1NkzNkHxKadLegE0M4EEBzO/KxLxThKnUlDuCN
	vq0TDnGtUmqSVvl19tmi9VOG4JBOfFnSiBpLjSEsXxSDS2SvyBtIrqaS/uS35JEi0s5XO7JaRcygx
	J9uJ9QqJcIVOe33cjNH7fdrJr7rjNacDIQ+zFaV/9HA+Q4hBixnQi2Emgfc57P0I2I18cxOxxGyQN
	oR9NMJzhRXKCrpUTCF+3G1cuSHqhb8OLeaIqeAh16+R3QO7p766HfGOCnPY68FTSfjNprV2XOt+ay
	hX7bhs0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rv78A-00AtT3-2N;
	Fri, 12 Apr 2024 02:59:10 +0000
Date: Fri, 12 Apr 2024 03:59:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240412025910.GJ2118490@ZenIV>
References: <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240411144930.GI2118490@ZenIV>
 <d89916c0-6220-449e-ff5f-f299fd4a1483@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89916c0-6220-449e-ff5f-f299fd4a1483@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 09:38:16AM +0800, Yu Kuai wrote:

> There really is a long history here. The beginning of the attempt to try
> removing the filed 'bd_inode' is that I want to make a room from the
> first cacheline(64 bytes) for a new 'unsigned long flags' field because
> we keep adding new 'bool xxx' field [1]. And adding a new 'bd_mapping'
> field will make that impossible.

Why does it need to be unsigned long?  dev_t is 32bit; what you need
is to keep this
        bool                    bd_read_only;   /* read-only policy */
	u8                      bd_partno;
	bool                    bd_write_holder;
	bool                    bd_has_submit_bio;

from blowing past u32.  Sure, you can't use test_bit() et.al. with u16,
but what's wrong with explicit bitwise operations?  You need some protection
for multiple writers, but you need it anyway - e.g. this
        if (bdev->bd_disk->fops->set_read_only) {
		ret = bdev->bd_disk->fops->set_read_only(bdev, n);
		if (ret)
			return ret;
	}
	bdev->bd_read_only = n;
will need the exclusion over the entire "call ->set_read_only() and set
the flag", not just for setting the flag itself.

And yes, it's a real-world bug - two threads calling BLKROSET on the
same opened file can race, with inconsistency between the flag and
whatever state ->set_read_only() modifies.

AFAICS, ->bd_write_holder is (apparently) relying upon ->open_mutex.
Whether it would be a good solution for ->bd_read_only is a question
to block folks, but some exclusion is obviously needed.

Let's sort that out, rather than papering it over with set_bit() et.al.

