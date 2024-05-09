Return-Path: <linux-fsdevel+bounces-19148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3BB8C0AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 06:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B8B22E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 04:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ADD149013;
	Thu,  9 May 2024 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMgIF5/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CC10E5;
	Thu,  9 May 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230517; cv=none; b=glctnPd6U232TwdCNlhaz/hGmHD6I3QlE+VoBl9JYiSVJjg//jELMQy1TiGeaXyFaZuVTJ+sc/S0I0FT4vqlnWaoZWM0GLUhWflV1O79tZskri/OS6aGkeUACC0zm8n3hmu7BKNKXJYvbejGeCo7HGZqTEqf1CkvPhiFeqZKIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230517; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryilJgjIldHwda87s1EU/jyOpLSjuLBScNPs4i6Q+yCCM7XZWkgvShi+JojziiwSMBGhihYa+dT8uMVlRHWfj1sLdaxg8xUkMgjU1AFto/g99n+eqA32M5aYI0eZuOqC9KYuy0t2uAMwr1Hqi1MdAR9U/JMy4q1c0Vn1XJqu098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qMgIF5/U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qMgIF5/UxoiD3vH6YQ9rrZlV9X
	S0mnfRIgXz4C5F0onIricS6FKnXRAxtLIvH+J7ZfhA1Z64LfKdC7s5dMypx6+NNH+ksch4FECqGNT
	Zo98hplf5jm+wVplkDqi+fLO4x9vuWnXfzFYCU5BiKUUVMi3uViquA3UK+2cUJn3+XKCZdAE5e87G
	vZYzfB3u69bUhj+1MhNdU0PBZYI/HGDmDuMVe65JSGSb2zckgQdvUj9hsD902t8SUQXsUaMspzxZV
	Kh/HIe5xLDFBtx3pzC2oBoDsg7SjILHWCa9d1EcDys/wRc7H5EfLKKD7ILrF8OWAu7dlK//qowYfb
	hKnYLorA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4voJ-00000000MNk-0BIJ;
	Thu, 09 May 2024 04:55:15 +0000
Date: Wed, 8 May 2024 21:55:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 2/2] iomap: Optimize iomap_read_folio
Message-ID: <ZjxXMw8jFS9jlRaS@infradead.org>
References: <cover.1715067055.git.ritesh.list@gmail.com>
 <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


