Return-Path: <linux-fsdevel+bounces-15108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F610887028
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E2D1C22B06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8E56754;
	Fri, 22 Mar 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bec2OJPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959384CB57;
	Fri, 22 Mar 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123297; cv=none; b=RkMtryx3GXUoHdjWEtqmLnHEcGQU2cy+DwdhBRaPArrOsEn1R+DdOBRWGxg7CQjG0eiHlMl8RttIGvKza3V/DV798sqncvYUTWLllvJty9q05lCbCMO1U7d3O+0HtnNkzndON5ZOuSHv5DaW1/F77tDgxfR0j7y7E9XpTB9etOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123297; c=relaxed/simple;
	bh=EwuD0AxhROWhZfAd1uSHmc7H83AS5hbOhRzOJsulkQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPWzFpR0XAIhBNtTXsH5JC+hi7K2bY1+A5jO2P7YOsUFl549Ye/ReYFBhMdwzjVlB0oVsKdAwkmLa9J2M+ghp7yzGVHaNwo9BoT3XFiZMvcS8kF/D3e3fhtlGHY8nD6scXHN2XUcjBrOorLSlJmG/5oScGnpqLcH+mJsXNalIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bec2OJPw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R3jSqEojSIWuueaFLc/Jo+JTmVc2Pu7J5YcVJNPesNM=; b=bec2OJPw/+kSffSQDNfptwJuWv
	OwIOLrjmW86PCKjZmfUi17RmPE/Qoix56IdaZBRL4MHAduELbmbS6WOBr5vhZKs29+7nToHbiZE+1
	PiEC41sf6+eC6ZIYNK+pQJb5AUlae2lG3qiCQUheGuEaBENZu9afbAxw3JLGoYHF963anGNu0bniA
	yxVJn+VbzL4JUH2QEreepmRAg5poW6m6ZvCwnWg4zEiWOgUoWnFde+pkKqldafgQWqihLCSKHunXz
	Vs/OigX2tRbd4fruO8+hpn3cMrVXaNnwydrxwW0PWY9pc9sWhpFnIC8sKZczt0nx0pQF5egHHT3GI
	CDk0iPXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnhKe-00Ec4X-2K;
	Fri, 22 Mar 2024 16:01:24 +0000
Date: Fri, 22 Mar 2024 16:01:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
Message-ID: <20240322160124.GP538574@ZenIV>
References: <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240322063346.GB3404528@ZenIV>
 <6f784f43-068b-12c0-e3ff-56dbc09420e8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f784f43-068b-12c0-e3ff-56dbc09420e8@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Mar 22, 2024 at 03:09:30PM +0800, Yu Kuai wrote:

> > End result:
> > 
> > * old ->i_private leaked (already grabbed by your get_bdev_file())
> > * ->bd_openers at 1 (after your bdev_open() gets through)
> > * ->i_private left NULL.
> > 
> Yes, I got you now. The problem is this patch is that:
> 
> 1) opener 1, set bdev_file, bd_openers is 1
> 2) opener 2, before bdev_open(), get bdev_file,
> 3) close 1, bd_openers is 0, clear bdev_file
> 4) opener 2, after bdev_open(), bdev_file is cleared unexpected.
> 
> > Christoph, could we please get rid of that atomic_t nonsense?
> > It only confuses people into brainos like that.  It really
> > needs ->open_mutex for any kind of atomicity.
> 
> While we're here, which way should we move forward?
> 1. keep the behavior to use bdev for iomap/buffer_head for raw block
> ops;
> 2. record new 'bdev_file' in 'bd_inode->i_private', and use a new way
> to handle the concurrent scenario.
> 3. other possible solution?

OK, what lifetime rules do you intend for your objects?  It's really
hard to tell from that patch (and the last one in the main series).

