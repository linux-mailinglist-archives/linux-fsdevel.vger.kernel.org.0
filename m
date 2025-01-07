Return-Path: <linux-fsdevel+bounces-38594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C0A046DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A21888A74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6C31F4E4E;
	Tue,  7 Jan 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5wxue/T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180A16DED2;
	Tue,  7 Jan 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268143; cv=none; b=Z582fYts0CeeK/m1Yn0TnKJXqlMasRWubaLe9O70lOwqcrysu50SEEGIl9+7pB4uItm6NQGs9aiDcUGHCS2mVa1rghkriieBo6nTIwlDLHtiGOvg+UxCX+65mtK6EXW+amYNOhv1LZf7SDb3EJbdKsBpmOrJmPhmGpFBm5ux7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268143; c=relaxed/simple;
	bh=PAWJ/eJ2Wg3E69cGC68zSAZov7lJ88H5VNZ0CAPmCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbmKe7TE8DZjL7QhhjOcX4YLYKOM8BA7avi40DR/tbGbuKHyOkI82HtPVSx1kiXQJubsC2glE7wlE3GnTzLQzhUHL8lQJPuDaX9VxBchAaK2F63zJc1Pclle7tQ2Fj4tz2smkmt+MA+R5/wAiThZCe7NvljsBebuxhsACR5ryCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r5wxue/T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UEHE3gr/uSlrG9puLdIg0UYSh9o/2BbUmqCiK33unbg=; b=r5wxue/TNqV4P8fo81MxFw+CmC
	xBrX3jHDjXDjBI463X6IrAZ5JUhzs64oTuvTMvgxvKvDwUU7nQqW2+I/r0bQeYHtuD0dLIRDw699C
	0ZUHwGEsXWORpAtlwis0+yUNnM0KoWvjZl0oLCx2lv1zV5xNx4KxOU8fZIqvtAthfhAnHJUKTgEoT
	MxIKES9g6nDDb+YL7HpG5XQ707foW6rzU8aSC6Yuu7YEdKo3cTZQN7CZMC5hzyuzAOz29gd7dTnmi
	eDzFSJ4/fiY6pK4FcIGfnUJ8T8eNxG+kuMDzyF1P9wlWG73FahkbfUNxvtdVXTB6RKSaJKKXjmqW4
	+1HAvQKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVCep-00000005gL6-3eyI;
	Tue, 07 Jan 2025 16:42:19 +0000
Date: Tue, 7 Jan 2025 08:42:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	Sai Chaitanya Mitta <mittachaitu@gmail.com>,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <Z31Za6Ma97QPHp1W@infradead.org>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
 <Z3u-OCX86j-q7JXo@infradead.org>
 <20250106161732.GG1284777@mit.edu>
 <Z3wEhXakqrW4i3UC@infradead.org>
 <20250106173133.GB6174@frogsfrogsfrogs>
 <b964a57a-0237-4cbd-9aae-457527a44440@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b964a57a-0237-4cbd-9aae-457527a44440@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 07, 2025 at 10:05:47PM +0800, Zhang Yi wrote:
> Sorry. the "pure overwrites" and "always-cow files" makes me confused,
> this is mainly used to create a new written file range, but also could
> be used to zero out an existing range, why you mentioned it exists to
> facilitate pure overwrites?

If you're fine with writes to your file causing block allocations you
can already use the hole punch or preallocate fallocate modes.  No
need to actually send a command to the device.

> 
> For the "always-cow files", do you mean reflinked files? Could you
> please give more details?

reflinked files will require out of place writes for shared blocks.
As will anything on device mapper snapshots.  Or any file on
file systems that write out of place (btrfs, f2fs, nilfs2, the
upcoming zoned xfs mode).


