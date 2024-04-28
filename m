Return-Path: <linux-fsdevel+bounces-18020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4AB8B4D8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3E2281615
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4474438;
	Sun, 28 Apr 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U0r2nH1Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191971B25;
	Sun, 28 Apr 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330711; cv=none; b=J5eaDwYe1zEXKiHmJNf4U78SzkepkHjaHjYOrAvU0gN7LDuS24j7dWQsAOAmNLsEdhiZDyg7rcs8bcQJRWjwmSiYQkYLsBH+rw7ch1DwMr5Cd5X0KDYwFdmP/2UK6yfOUjMjv7xPERR6WPbm/j7Hm4WRemN5iiaAv1XYkyHC6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330711; c=relaxed/simple;
	bh=u2ZtkqxxcCpJtfkEaULrWkv4u+hez/5B6PoU3df+/uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhiPn5enx/rQAA8iplm7TgOW4aMDxigNq9fQftRaR0cDVbug/k58HmF9wzBJN33P8ZYoOHxO0fX3O3RHUQWvvQEbbftcGmwpKE6+y3F5IYnF98QVZimJRrKbU83jlZboiaEJdsX7NoD7IHrof1P3lX0KKGejz4F4IRHYkv7ACSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U0r2nH1Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mBuI6KLe53HXsLCkW0E3ngY1egf0eTXGKyNTP/1IL4o=; b=U0r2nH1Q1fZ+zxHW/3LVsJ5p1J
	Lhs1SBXV0fARFuOjwkyxM1HqIoCK2lnbohJoYV3ddkn0MspnhRsLs8rKeISIA7mAJ2TrA+gfrhR0Y
	o1M9PBtviRrJhRwTT68MsuVKe1dLrDetuNFiXCTVM2W9X+jyp+w7cJsFh8xCPj8szri+TGrAXHjKr
	w9RiUvEnFt0QHXupMu5neM5i45RnLl4GB4ToEpQORNQTuGDbC500wIvar8HbIs9PAcDwCJT2MNaNY
	YAU+jZF4qFO6H0CvXugDSCGfYYAoTvfp/GvnDqkRN6uNInQKU2Ci6zzJA4u/SXgNh9rewYZ2aG2yw
	XSO6+FUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s19jD-006w1h-1G;
	Sun, 28 Apr 2024 18:58:23 +0000
Date: Sun, 28 Apr 2024 19:58:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Eduard Shishkin <edward6@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
Message-ID: <20240428185823.GW2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
 <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca513589-2110-45fe-95b7-5ce23487ea10@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 17, 2024 at 02:47:14PM +0200, Stefan Haberland wrote:

> set_blocksize() does basically also set i_blkbits like it was before.
> The dasd_format ioctl does only work on a disabled device. To achieve this
> all partitions need to be unmounted.
> The tooling also refuses to work on disks actually in use.
> 
> So there should be no page cache to evict.

You mean this?
        if (base->state != DASD_STATE_BASIC) {
                pr_warn("%s: The DASD cannot be formatted while it is enabled\n",
                        dev_name(&base->cdev->dev));
                return -EBUSY;
        }  

OK, but what would prevent dasd_ioctl_disable() from working while
disk is in use?  And I don't see anything that would evict the
page cache in dasd_ioctl_disable() either, actually...

What am I missing here?

