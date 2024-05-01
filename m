Return-Path: <linux-fsdevel+bounces-18404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11688B85BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29A11C223D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF04C637;
	Wed,  1 May 2024 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YZCqbJme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A53A29A;
	Wed,  1 May 2024 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546547; cv=none; b=jZ60TsIIvuyTiv8/ku3sRtoPFu93Mit8HsLLzKUIICG86PHFAVaJExHyj5JeOoIoQSNQFtSJ56i0VivClTR6un3A9uxBf1fnKB8LboMrF/uEpyhSL+9eQXf/hanAQu7IBXrFHnshgK+iMg3GcDdzKbOawBZg74xroVKd5VsVSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546547; c=relaxed/simple;
	bh=+bQ3DwJZk9txh6D4qC9G1QMaPiN1mLq5wyuyworR9NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix5M82E807chV8cOppupU3KesZhIgXGjZ/elNjgCBoNK7LdtiQwFvRK8bvnO+FEwgHRNnwqaFZiZTCS6giA9zxuT0BxhfJ9v50OSSLUZiA2KcyKv8QHK3F9N7kTjLAKVrU4qSDB7eONdvzu9QeUZWNlnaxXuKrnV3sqiAIP+Ijg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YZCqbJme; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y/DMizRoLN1rPRQVCGXsaKDbtpvSpp+bQ6CCWxaet6E=; b=YZCqbJmeF5CUY/AdIqqPtcmudx
	jOugoukw12eKzMqDaNLwNUzN9Zk3IxO+QWQrJAaLUyHkoFY6P7EYqMMEN0qkupF3iImIRTge1g0n0
	VFxsqpasAjbdB1DoAp98hbC0cZ9P3OGqXB6soXk/nZJth6FvsjBZaa7rFmTMK/a7lcTFIxifflSAi
	JH3JxZRX5/z4mvy/Mm+FPelPlYc98bdtTGCMZzQh71RhRVBHSFRS7lTqzcFUlIL5V7p1cE1kCxz33
	1Y3YVwwQuAScWh1av+GWHfr5yqze0aVeEIg4AKUEFK2PIIobXXyCcNRMiHAGhUqmcO9QbIIHVeKxk
	pa24eI6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23sX-00000008iG1-1PLu;
	Wed, 01 May 2024 06:55:45 +0000
Date: Tue, 30 Apr 2024 23:55:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/26] xfs: turn XFS_ATTR3_RMT_BUF_SPACE into a function
Message-ID: <ZjHncb3Y4EALrhm-@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680395.957659.3370622609053473856.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680395.957659.3370622609053473856.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:24:37PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Turn this into a properly typechecked function, and actually use the
> correct blocksize for extended attributes.  The function cannot be
> static inline because xfsprogs userspace uses it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

please expedite this as well.

