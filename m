Return-Path: <linux-fsdevel+bounces-14202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E9087941C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89341B230AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07997A121;
	Tue, 12 Mar 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+IXdD5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1A7A129;
	Tue, 12 Mar 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710246243; cv=none; b=U0XBaiY8jsO4iYLmS5Mte0+248O0Z2RQrvcckYgyABRMKodwECYEiCUiy65tpOr5Mxsfs4hyC2o7ZpUr8Z0rdYPgEt4BQuf5b8awLjAnjsgLpTLMp9KdtGapOUa4jfERARUOZxqVAHV5W1AmPF5H/2b9NeY6L/1GD3/T7llZvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710246243; c=relaxed/simple;
	bh=PBaDVSfhDdJKESyBjRcTtGSxti52ggzrqINVFpc1cLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/lz45oImpxe7XGsJXnSBpq773YUeVO2N9NhEmQKh0RxpwHRApzoUW3uGKt9tyr/QDkrPD66xA7ptaE3evEwyhkS13fqx50jU0DgfW8mhdzXz7JG4Qu7mhKvDOabg2ermpr160JtUexQiVBRlP91xHvw98aD5xMiE1tHRgdusF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I+IXdD5q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kmn1BYFbhsM8azsrnbO9rLxJwlcubYnrbjMKsZaUD/Y=; b=I+IXdD5qc9hFmfJqLvXAr2cL7a
	pTjyx5oTFNuW3hLTVYaCXz8NlgJnzCnlNUoeQc5TgvPyixmoB8uSAjGaSYMBukaQGLyTWaM4frCT1
	LySFdt1LNkr0bC7Kf924lNAXQI1XPnOLC1iCfmJG7QYMZFSS9J3C9aIAmPeFQM1ra021AHPUTIvzP
	ajYMUh0YZ7Jg2IKELiV8Y0RIgOc5lTI4nNrIAeXZbSJBKSMHvHuHlZ/OS5R1jRRN7RB6yuwbQ18H/
	kIndrRzQCVM2PjSVakwA9uMz2a7Sr0T7EJEf+91B3K36yNblq01UJpBOOffK7YQacAAU+PVOBsUI9
	npFwXgAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk1An-00000005jHK-01DP;
	Tue, 12 Mar 2024 12:24:01 +0000
Date: Tue, 12 Mar 2024 05:24:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 4/4] iomap: cleanup iomap_write_iter()
Message-ID: <ZfBJYG5OHgLGewHv@infradead.org>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-5-yi.zhang@huaweicloud.com>
 <20240311160739.GV1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311160739.GV1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 11, 2024 at 09:07:39AM -0700, Darrick J. Wong wrote:
> If at some point iomap_write_end actually starts returning partial write
> completions (e.g. you wrote 250 bytes, but for some reason the pagecache
> only acknowledges 100 bytes were written) then this code no longer
> reverts the iter or truncates posteof pagecache correctly...

I don't think it makes sense to return a partial write from
iomap_write_end.  But to make that clear it really should not return
a byte count by a boolean.  I've been wanting to make that cleanup
for a while, but it would reach all the way into buffer.c.


