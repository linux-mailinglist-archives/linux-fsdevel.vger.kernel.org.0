Return-Path: <linux-fsdevel+bounces-38423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C029AA02449
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B078D164220
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683561DC997;
	Mon,  6 Jan 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C5WVTdcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F861D7E47;
	Mon,  6 Jan 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162874; cv=none; b=oRM3U2L7/pl4vxJo9nxYgLTL90eguj/OnNWb8kT3qiIllpS2AZN7RejvnTEtpsFIxxEdzwRsJdbSLVMMR0NFfPbvyXqzmTDHKnpE/4OGou0TRVvOsrezh/3qO2yW1TsfeTuHTJMSEhz39aXjrKogQ/FD1EGD3FQQznPlS75/Ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162874; c=relaxed/simple;
	bh=l04Sn1dfSlQGCURV9x7QruuY//X+d0MieVxpN6+yUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dol24l/ns9A7IjzG1OrduF9Jkr2c7ZThbKS63CZdxYX7Ym/kZvFtC7oudSIbhvX5w0AfRzAZj5O6D/r6BZ3kHQ7zZziOWY9vYJoXbPqD+VdE4YU515CrjHgj/fH5qGV4hq3z9zIjWHUA/KAnm9vZa7qzUknM3cC7+0kzCw9XbqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C5WVTdcZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vDW6gnYA7VPDj+2tAOrKHd0KqqAcw1BLmo2EgHZGMDA=; b=C5WVTdcZe0co06gSEJ9iaPDcmT
	384Kc53WCiaItAxPvAZ7vtbEtJsr/n1nopl/+LlEcg0H+YytRWHRIlk/NqZYyQYBue2zMlMSBs1kX
	qIx4TEK82js1TlN0QGav/c76C0y0XIqy5jBet2FOiXFyxYyTPQasPOqLs5lkKcPhlt/1z3Wszh+Lg
	CRPjKic0U4JNk8C1JE/wyTAdIhf416qeBm44wr9Zute4HANUIiMFpkfFS7YrHltpC8ftc2KeR/Mn2
	FxuLyUyz7fA8L3zjRkURrpAdmYYqXh7pufI8OAu+BZhMmtJYSGM4NkFs4sui2PH3AVhvDE18+7GeT
	4no0BvbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUlGy-000000012gx-1B3f;
	Mon, 06 Jan 2025 11:27:52 +0000
Date: Mon, 6 Jan 2025 03:27:52 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, tytso@mit.edu, djwong@kernel.org,
	adilger.kernel@dilger.ca, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
	Sai Chaitanya Mitta <mittachaitu@gmail.com>,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fs: introduce FALLOC_FL_FORCE_ZERO to fallocate
Message-ID: <Z3u-OCX86j-q7JXo@infradead.org>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
 <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228014522.2395187-2-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

There's a feature request for something similar on the xfs list, so
I guess people are asking for it.

That being said this really should not be a modifier but a separate
operation, as the logic is very different from FALLOC_FL_ZERO_RANGE,
similar to how plain prealloc, hole punch and zero range are different
operations despite all of them resulting in reads of zeroes from the
range.

That will also make it more clear that for files or file systems that
require out place writes this operation should fail instead of doing
pointless multiple writes.

Also please write a man page update clearly specifying the semantics,
especially if this should work or not if there is no write zeroes
offload in the hardware, or if that offload actually writes physical
zeroes to the media or not.

Btw, someone really should clean up the ext4 fallocate code to use
helper adnd do the

	switch (mode & FALLOC_FL_MODE_MASK) {
	}

and then use helpers for each mode whih will make these things a lot
more obvious.


