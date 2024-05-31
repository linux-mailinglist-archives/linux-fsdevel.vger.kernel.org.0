Return-Path: <linux-fsdevel+bounces-20634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031A8D643E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB15290828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D217FF;
	Fri, 31 May 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chVMjZcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C11DDE9;
	Fri, 31 May 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164936; cv=none; b=To9r3IY8BdSd6wu5gb33hLqniBSKxxt1izqOqUmuzXLAPt/leuDB4zo4bhg+gi3YR88OGmhzzhtnBWcshzFIb4dkQ3BSGBpWLWj5RHnh4qOVJKK++IwypGzaTDe1GLcYwKAzYlDX1c1vuRGVQZxBh5Gm2Kd2t9oxXBxMfGPEbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164936; c=relaxed/simple;
	bh=5Rey5xN0MXA0y0tadukcD8LP2UP6QjS+heRmwfQVai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfBr1IaUtyGgQQJr8Ki7o9pGKqKAMj1hZ0CcI5I/R4KUV3/Sq4kkrMfSqAaj3CQ3LN0T4+4o0/rF/gZyZGgrADUcKICJStGho1PPiPUa7FXvEC88u+jU0eNyndYSzk+2ycSs260Mtjvw0GgLvmHOiRdniEOI8RlnKhsKkwjkOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chVMjZcf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0+a6tacPu1YtcBGRfqyTbC3+CVmW9vtBaiEb1zmwwss=; b=chVMjZcfkH05kqy4S7wfwBrhEq
	yU21I1btKbo9L+wSpMhwfEsIM1P/e1HFLNjyeCuRO2Huom7vqDbM1pekmo1agobFCHGBUS53ZcQZZ
	Aj1nVNeh1bKmmSxAsRr5Gj/DXG7ku5BXs83LlsYiEC/thuqsCRYSwUzFWds5CV4nlANXIU8W+l7/3
	eX/ilhmjYAb57hYIycq6V9saLPabkp9P/rOqJu/5HlM7WmHVwQqHmC/cDyha0gaQvrch9zatcj+X1
	Jji3+C6Mr4WXgo7J0UXFRwYf04SPz1CgRR2OL2cEwFJhs6u7SYX0aYzR9rGEGCgzlNQ4aBNvz6IE8
	ZLHeoR9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD32c-0000000ATsV-2pSP;
	Fri, 31 May 2024 14:15:34 +0000
Date: Fri, 31 May 2024 07:15:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 8/8] xfs: improve truncate on a realtime inode
 with huge extsize
Message-ID: <Zlnbht9rCiv-d2un@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-9-yi.zhang@huaweicloud.com>
 <ZlnUorFO2Ptz5gcq@infradead.org>
 <20240531141210.GI52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531141210.GI52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 07:12:10AM -0700, Darrick J. Wong wrote:
> There are <cough> some users that want 1G extents.
> 
> For the rest of us who don't live in the stratosphere, it's convenient
> for fsdax to have rt extents that match the PMD size, which could be
> large on arm64 (e.g. 512M, or two smr sectors).

That's fine.  Maybe to rephrase my question.  With this series we
have 3 different truncate path:

 1) unmap all blocks (!rt || rtextsizse == 1)
 2) zero leftover blocks in an rtextent (small rtextsize, but > 1)
 3) converted leftover block in an rtextent to unwritten (large
   rtextsize)

What is the right threshold to switch between 2 and 3?  And do we
really need 2) at all?


