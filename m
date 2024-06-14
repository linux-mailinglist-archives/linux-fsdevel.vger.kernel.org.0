Return-Path: <linux-fsdevel+bounces-21691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0111908377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 07:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FBD1C2296F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 05:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1AC1482E6;
	Fri, 14 Jun 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIUGGDmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A61146A90;
	Fri, 14 Jun 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344729; cv=none; b=PS1eobavu1WatS85PInf6oCJRsykd3UQ+oUA99JI9pEwQVBIZ6otxNIp0qpkoEXbI8+ozfXYVKAbkskF0dqbnflXvDtBVEl3aFuqG8orFstRC2cmQDCpbp+7v5ysETePImE/U+E0NVX9wNQeeY+qwfEXOzfcnpi0enuWOTsLvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344729; c=relaxed/simple;
	bh=2W7Trm/7VY+Bt5vh8GDrzCZNVN4WDeSncx0AdiLm5KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDpQULUmA7GVHT/+vy3VL3HguSMmpyvIYVDOxIn0TC6vWP1KbLu+a8pw65DftP+TYIn62zS/K4wxio7mgsDXfnS9FTjtA0Ujbl/EFFUC1WgcWr8JNyDJGZBBz5hIojAlE3Elm4zrkgN5jPp1zkhex+hKUa1WtvZDDSToiQTDfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RIUGGDmQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aiR8KluRZrK8024tgwaCQgiiuc7LvgtUkwwSFHGJK8s=; b=RIUGGDmQg/sLW9wyDnsOvTh5xq
	pmChq19poY5mKNii2/16cWp+o8vvtns5DwHrQ+SmRATp7EZgBbM7OylvAj48VHBt26l+xSzzlOUzE
	sPUA6VMl0Tf6yYqES0jRnd+5OmnVca8TQaqK2uGrTYIEeARWkgZHsukA2PW4DSeA9hL3RUtGpCLMM
	OhwG6hhIUWKQZEK5prXTgX10W8JPfwEc86aVifS6q9BDyxcNX9h+p7i2320+LHdjV6NHMAHcr+3iA
	oXEOP78HrOmasOI8KhHuvH2FIjyDHoHrvB9lGhbdJKvI5ZE8JICuewVXwCroOgC1NPfVg+b4RZJlw
	EBo4hFOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHzxX-00000001Z8J-31HC;
	Fri, 14 Jun 2024 05:58:47 +0000
Date: Thu, 13 Jun 2024 22:58:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH -next v5 6/8] xfs: reserve blocks for truncating large
 realtime inode
Message-ID: <ZmvcF_IXVLENjOVy@infradead.org>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613090033.2246907-7-yi.zhang@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 13, 2024 at 05:00:31PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For a large realtime inode, __xfs_bunmapi() could split the tail written
> extent and convert the later one that beyond EOF block to unwritten, but
> it couldn't work as expected on truncate down now since the reserved
> block is zero in xfs_setattr_size(), fix this by reserving
> XFS_DIOSTRAT_SPACE_RES blocks for large realtime inode.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


