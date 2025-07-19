Return-Path: <linux-fsdevel+bounces-55494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B401AB0ADEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 06:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486DA1AA63F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC21191F89;
	Sat, 19 Jul 2025 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bP3FJ5Aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A63AD24;
	Sat, 19 Jul 2025 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752898641; cv=none; b=CPzhdTgQ5Mqp+Tm+hfMfjWnC5hv7sXJ6ggApeCbUoOXospO+1fdli5hSIUhXY6Iy7nrf7sQutdOxTIZXuqB29FGl2W/bJ2/0O9uyuXR4RriA0gqr+0ffKaBPq2lihvKejrCAwaHr3gCQwbBfnpknknDYFm7C8fpv23q0VvJb8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752898641; c=relaxed/simple;
	bh=8Mupvjh8C3CjS9E8BGBz7fLYIr+7QB6sQWXmscgCUGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGprlvfTczIfMMBN7y5BWMV0UneIWnosD1mhVV6aFutQvIhpYkYYxuAJEhqBDCCJFJi4Jo1GaMJkucKE8ea4vGcd2mG5XbAaM4ckebb5fK6zwBvtrNopAqjtoie7sJfoJlOT1MSG1uVPPAmaJrCBYsQKY37shP2uaSoGIcg0Dfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bP3FJ5Aa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YENCZnGysDyoXLTiMskCs9m24InAyieLb39es5sSD2s=; b=bP3FJ5Aa30BKFT9OQVwhQS1IMb
	3U7GtwYiXRTLHxK7QpjXsdAVcanA6itY9TZLPFFEtqz48JtQbUW6KP6tHmqyIuqt/nGGqWR4tztxx
	zwv5UQbhTNwGNyFKi/ED7osXcFML9PjICMYvFZSf46AIQ8YCMeTvePgN7HBgbLGrQXPpn4/s7oLCv
	sPXtuy3T9wKI78Ct9R2aVl8D3KF4iEwJdcooGnl1kl2gxQZju6A/cJPDK35oSRdovljbhCvyAdE5m
	SuTZjGAkvzR6YhCu6t1DMVKtHMaxwAOxMeq+0q5uNebz1Rl8RNIxFvhh0iVyjB+VaAGbrBD5p7omo
	N2SYm6Hg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucz0X-0000000HFdr-1mze;
	Sat, 19 Jul 2025 04:17:09 +0000
Date: Sat, 19 Jul 2025 05:17:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: jack@suse.com, brauner@kernel.org, axboe@kernel.dk, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] fs: Add additional checks for block devices during mount
Message-ID: <20250719041709.GI2580412@ZenIV>
References: <20250719024403.3452285-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719024403.3452285-1-wozizhi@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jul 19, 2025 at 10:44:03AM +0800, Zizhi Wo wrote:

> mkfs.ext4 -F /dev/sdb
> mount /dev/sdb /mnt
> mknod /dev/test b 8 16    # [sdb 8:16]
> echo 1 > /sys/block/sdb/device/delete
> mount /dev/test /mnt1    # -> mount success
> 
> Therefore, it is necessary to add an extra check. Solve this problem by
> checking disk_live() in super_s_dev_test().

That smells like a wrong approach...  You are counting upon the failure
of setup_bdev_super() after the thing is forced on the "no reuse" path,
and that's too convoluted and brittle...

