Return-Path: <linux-fsdevel+bounces-46170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA44A83B74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 09:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C2A4406F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C8204687;
	Thu, 10 Apr 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2WCDTj6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE021DDC15;
	Thu, 10 Apr 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270817; cv=none; b=BcVvmOK9HvQii8A5B2Si/kp0OmVNCYYDNOj0UpB9jQ1EHASli+EV2uGh4/7btmdAYrZzgxdq6MiVwOfebhgX3AbEGxypu6Tjy8vuLzVKEnL3aw2fnvc36tDXwqMsQ6VKIWgU5/qASdJ7acgKgHsWthuHz6HSWv8VzDARs40SMas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270817; c=relaxed/simple;
	bh=ztqsTTcHOGytcHIA2rtOvbbiMGZZBwiVn7qPcC3HuFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnee0FJZsrqCbrz8Xkx2TbZcnBTUps1TxKv+MO6FFVDzmFs1+qOE8vHEn5vdgUSrOThuuGA0bPe3P4WJXxSJc771XejxsbP8UkQerfmtfWR8yy9VIf92S8APnUM/d14xxLvM3gc0HYocXXhFWlfOKPzZj4FQWHjBmlg9pAK4cNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2WCDTj6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SzrEiCnT63jVe3C2a/P8jyKS7uOpDFoAJei40tblVa4=; b=Y2WCDTj63XxxIDRN3r+YE6rJE0
	f0EpnT9lKC4MbPOULgJOwkJHmLBfOx+VqyRYpo/pxc/HYd/jkpSv7HpbnxTkO8eciHJX5We4uXCrs
	ce9tzWte+2TWYwqiHvSlDqTzWm2PbWv23iC2B1mKwkuKtXd6KohjCBOkLop1aw2j5RqEpq3DhjN9n
	GSKACyHNI5tOaaITGqA7TK9pUnwT4HC0qnl528O1ny/4cGcrE25qvx4XP2Z1cgHh3NilpAN5gQgCs
	5E8lQi81z+S/r3vjTrdmKpMJFMbWGlKR2gkqUVtEgdbZrb4w0RhXlToQph7xDrFSV7wVeL/gWmBVG
	a46ZhgUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mWF-00000009bQm-1dGZ;
	Thu, 10 Apr 2025 07:40:15 +0000
Date: Thu, 10 Apr 2025 00:40:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: Weird blockdev crash in 6.15-rc1?
Message-ID: <Z_d13yReJn2vqxCL@infradead.org>
References: <20250408175125.GL6266@frogsfrogsfrogs>
 <20250409173015.GN6266@frogsfrogsfrogs>
 <20250409190907.GO6266@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409190907.GO6266@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 09, 2025 at 12:09:07PM -0700, Darrick J. Wong wrote:
> Subject: [PATCH] block: fix race between set_blocksize and IO paths
> 
> With the new large sector size support, it's now the case that
> set_blocksize needs to change i_blksize and the folio order with no
> folios in the pagecache because the geometry changes cause problems with
> the bufferhead code.

Urrg.  I wish we could just get out of the game of messing with
block device inode settings from file systems.  I guess doing it when
using buffer_heads is hard, but file systems without buffer heads
should have a way out of even propagating their block size to the
block device inode.  And file systems with buffer heads should probably
not support large folios like this :P


