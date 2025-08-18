Return-Path: <linux-fsdevel+bounces-58117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8600DB29922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CCF7AA88D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9148272803;
	Mon, 18 Aug 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQIbIxYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94126E711;
	Mon, 18 Aug 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496366; cv=none; b=uesCmvrl7lpSsXy4Q8p5zoFv8j9s2INYhvz5DE72eRZHdPui82SQXgmLL/LHwrAqui1FtPQNPV4OFVCokUCW3KR0qjyhhaMU60kfGF224QB8JUDltb9ZRWn7vtQX5MNesZhpC4Ru6OKlxbAcGc5tkt/KE6GFXhZJgy5IdafrACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496366; c=relaxed/simple;
	bh=+TFfy3LqtKNrPUR0rJlyKhGuXtg6n7Nco3CwrAsFQNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a48vIZEYa0FVGbpN8l114gHOayiSoDHBVHYD1eB6GSKZo85VJYoeTvDIsZOU/vz9n9UfTP3dDVZruk6GjePC6jmSWHAwM7iX1YVmwfH5y++mx6IVxSY4TTSJldXcsOWrDRZyjHlcrgxE49jFQBCxA33t+z/RdgPj4pjcgWy2eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQIbIxYn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qldtFRTQc/MaNY89VBZwlRVVq7wc7xMm/wizvObjV+g=; b=sQIbIxYnGYk+ZkuRHPnc4lYFg9
	tfvf012CbVkkiJoLTpPaH0tPxNCovs0XL/m1I5cJdkXlUhjii2fL0RwtG8cHC5jcY3Qec/mYnrpGU
	oMF/7gzNGIrT+S9jto9TjvBxFPdWs9J/PTpNI9sF7uudiaL4nJ+dykOVRCNM7Nj+FVP4/nblSGp7m
	MljoXkVVYadq1kj3B8vwa9Mdn4CzteRmYJEbMJirZB5mkcjMjN0guYpVLDBELfDE9in9t25bzveaf
	87WtcEiCDO2cChnRlryJx+4gJ0tFTn5mG5LrF5xr6mv10zg5CFj1mW2Hagok8uwBN5wKMPVI21xpc
	AKOZ1GFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unsnS-00000006a60-1N7v;
	Mon, 18 Aug 2025 05:52:42 +0000
Date: Sun, 17 Aug 2025 22:52:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ethan Ferguson <ethan.ferguson@zetier.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: Re: [PATCH v2 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Message-ID: <aKK_qq9ySdYDjhAD@infradead.org>
References: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
 <20250817143200.331625-1-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817143200.331625-1-ethan.ferguson@zetier.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Aug 17, 2025 at 10:32:00AM -0400, Ethan Ferguson wrote:
> Both e2fsprogs and btrfs-progs now use the FS_IOC_{GET,SET}FSLABEL
> ioctls to change the label on a mounted filesystem.

Additionally userspace writes to blocks on mounted file systems are
dangerous.  They can easily corrupt data when racing with updates
performed by the kernel, and are impossible when the the
CONFIG_BLK_DEV_WRITE_MOUNTED config option is disabled.


