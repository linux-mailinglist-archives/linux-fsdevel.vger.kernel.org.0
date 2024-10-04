Return-Path: <linux-fsdevel+bounces-30969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D29902A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7941D1F22060
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9FF15A868;
	Fri,  4 Oct 2024 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JiNkRwXY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CE1FAA;
	Fri,  4 Oct 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043660; cv=none; b=iBIeaCuj6vl6FvfVJ4kozbaPW7EyVeBEwsDX1m08o4oVWX9MDbi7LTvbo5ebI4tmIJNYZzX6N6wLyXw+8s0kTZ152POv0BLpX0qDxtsCLYg0PNXTNJXANa/VW8Jdl7nofWt60oOQSU994J6byR3RjInnw/mvc3W440mhDUNdGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043660; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSXRhYTGSDJLMQg6KnVB9JCktd7jkGLp3MceE9+3Sn0gnDT2EGUtEDamLi271+JRXGfJBzaUW8ZNaXELUepd9ZcbbN+qUMadFK8QAiqq5TzBUYoc+e5iQ11mygP65OY/kxp0rst7DecB2YCsT2Poyu2Gm3Uu5/ZbkDstfVNS9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JiNkRwXY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JiNkRwXYg5IujTertZEXPHBjd6
	jfAnisrjifvv1fY4wFYCQWtW/p2ASAcfFzIm2SUv5UJsidumF+lwomMGHr32fTzGYijzphzD7ArvC
	B+Rj0iNY0PrVUZza5GzWhoXDDwmkWjvKbfC0LGYJKSlb5VEx4X8fZGuKJzkeBMcN7cJZVFjgKrGoO
	gyrU9JwAdAWP9iOrITRQ+Pr8+fkhhhEHfXRAOcIAIzsgyipI/CFrUZk0pn616ilJThMttOvpX4BRu
	nt4325E1kiKyGHI4eFviQGtIN4IaPy54s1Qek1LPy70pVVGQmDPNm9oHqp+B0SqxaSvWJuvHR8ug6
	ZdEFiuPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swh5t-0000000CEwR-4AVv;
	Fri, 04 Oct 2024 12:07:37 +0000
Date: Fri, 4 Oct 2024 05:07:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: willy@infradead.org, brauner@kernel.org, cem@kernel.org,
	ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] iomap: share iomap_unshare_iter predicate code with
 fsdax
Message-ID: <Zv_aiQGbRhO-ChTZ@infradead.org>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
 <172796813294.1131942.15762084021076932620.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172796813294.1131942.15762084021076932620.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


