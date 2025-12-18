Return-Path: <linux-fsdevel+bounces-71616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A292FCCA532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26E253032FDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E930B536;
	Thu, 18 Dec 2025 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hI6Fe4c5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19452309EFA;
	Thu, 18 Dec 2025 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035622; cv=none; b=FRhZn/JIXJfLlUqa90rz4hKYzswGYA7Zf/ceY0NwtNfYPZczpKFf6wB6EVOcl0JFEavk7LN9D70Xb2FvcpL/ETBL6KpXrUM86m7ZONkTNU7VIMU88xG4TdZ4s4ztz8TF2ccxf2ZkyyDH+lsQFkDv0pd0EFcCQ73fI5I40Xg4nqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035622; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTJq+T8Nrl8dlhLyzHZm4LpI1xKGR6n0sP7atO7Q6Mo70g6irBbH9mh1wn4fiseNyZ5d0AI3Qj856Z1MJQ70xK1DTPEYOBAGfnVO2OGIvLIIFXExtH3JiqVCDV0aTy1BFgYOB5dP/o4mtMsb07+OJqCjrzo1CDZG/o2X8fs2Zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hI6Fe4c5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hI6Fe4c51C2yUJ0eTgB2sNhuK9
	qV5CT3Zh1csty7JjrUxO6uOr2gJCFCuQnupy5QjgyxMcPtmvZldXUUdyOUCYM7BSZVqe2c2CyXDHh
	xe2gOWYs+Sc3hEwNnBT//rbzMk4Wp4zN87no3yCnEDNpJn8cyag/e7CMDP0w2RAP4RqZ5TFsP7tWf
	wkbnGNUZwmwHjScMX855F4w7v6LlhiCriBGDRkBPur8OMMHX7oWk1gmS6648tAaQuSOV3oj4nGdhI
	rH+0pBhUqyJG69ZDcndBR6cipryvAb9O810c2LmIwgdcXbEpJLlHi3eCGPQPGRYat5/urFWahg6sU
	rvXe8n5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW6XU-00000007qOl-2UxX;
	Thu, 18 Dec 2025 05:27:00 +0000
Date: Wed, 17 Dec 2025 21:27:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] xfs: send uevents when major filesystem events happen
Message-ID: <aUOQpFz87HUJKnJf@infradead.org>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
 <176602332548.688213.501157461742943815.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176602332548.688213.501157461742943815.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


