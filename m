Return-Path: <linux-fsdevel+bounces-17967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC98B44A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 08:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B15F1C226F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338044C94;
	Sat, 27 Apr 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZ2+Te38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4841744C60;
	Sat, 27 Apr 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714201145; cv=none; b=XpE6UQObsuCrpSceaxZ3LquqH5bgSKn6YyKY/GyEITqMwTo69Mr7l/5Og4ylmDJpIKQVDzQCknE8NgMqYJoLXKZ69papru9HZHstilya//GPPy4kKNIae2i5UBgBnYiN7EYRkcw6lY3o0oa0+hqqpUgO3wYnBR/mvuNZN+f0Iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714201145; c=relaxed/simple;
	bh=fq4Y/YYHOYRUCKvJJh4GNGnlMj+5sYBsl8kLfoYa7lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7KMcfQ64VBKy6C1cNMqxwqIGCZf+rZKLYfQTFNHFz75uKqtyf1tKSSooIuep/uwn4aiy2thLWJ32LvtosB3EoA9A6fqmt/xN6WWJcuqkLtWtZm8e18S9uiRCMcJt+eTB0xJIrQ0r0aPs4Y4TFAVhJKioo+xTHGXzIFHWiDztxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZ2+Te38; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bM+nLGrQ9vgT793ZfeLQ0WwnxDxwOMp+8RGtkthqig4=; b=vZ2+Te38+JAQujmquNucTssFYW
	X8D+aJCsAfxEIprgR2nqHsnVAt8OW20EcOd1IlOX19LEPMmGcCqH3GgugmLsZzevUmyTZUwZS34wu
	HWMOsR40aBtRkqBksXetw9/CM46dGL5Sx06bdVYlRXubqwQuq2TwXvyc5A2I8V8AklcgZY1rFFHDh
	LDp9hJYOX6Wheg5PU+NzSaXdslNuK5htLGO+RvvroBLlvhXtjdwRUM8R52S6O8Dnz8XFZZ86oV8kS
	YGF/qPFLcLtaXToxHQ3xNMLGZf05pqEARetUA54kFrBBzH1iw4ZcRgpBIFVq7eeHQS//VPxazmF5B
	KYhDOxCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c1X-0000000F0I6-2C5w;
	Sat, 27 Apr 2024 06:59:03 +0000
Date: Fri, 26 Apr 2024 23:59:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 4/9] xfs: convert delayed extents to unwritten when
 zeroing post eof blocks
Message-ID: <ZiyiNzQ6oY3ZAohg@infradead.org>
References: <20240425131335.878454-1-yi.zhang@huaweicloud.com>
 <20240425131335.878454-5-yi.zhang@huaweicloud.com>
 <20240425182904.GA360919@frogsfrogsfrogs>
 <3be86418-e629-c7e6-fd73-f59f97a73a89@huaweicloud.com>
 <ZitKncYr0cCmU0NG@infradead.org>
 <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6228ce-c553-3387-dfc4-2db78e3bd810@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 26, 2024 at 03:18:17PM +0800, Zhang Yi wrote:
> I've had the same idea before, I asked Dave and he explained that Linux
> could leak data beyond EOF page for some cases, e.g. mmap() can write to
> the EOF page beyond EOF without failing, and the data in that EOF page
> could be non-zeroed by mmap(), so the zeroing is still needed now.
> 
> OTOH, if we free the delalloc and unwritten blocks beyond EOF blocks, he
> said it could lead to some performance problems and make thinks
> complicated to deal with the trimming of EOF block. Please see [1]
> for details and maybe Dave could explain more.

Oh well.  Given that we're full in on the speculative allocations
we might as well deal with it.


