Return-Path: <linux-fsdevel+bounces-17962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F048B442C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576001F234FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 04:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743FB3F8ED;
	Sat, 27 Apr 2024 04:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXQAAuPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8493F8DE;
	Sat, 27 Apr 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714193687; cv=none; b=F1Rtxjis+6G3zn/3XhuciGrft/vp2eXS4mmq4gPTNUSj5skfv3rf39wDe+uNgtLM8M76DpHcm9qYeKGUQ+mygoYjgmL0V/KQngS3PF7V8k4K/7u/YCibEWfA7qX9PeMAcabzpGz1S6cqx+iLczRbD2N6dLGLBIV3kYn7LBpbHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714193687; c=relaxed/simple;
	bh=T0E7237sTqU8019u+o+Ijw9ffYKvcV9l5H6YU5Q+Rw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhWoTGJpRQT8cx5N+81qOQh/Jj35yx0z2UP2SQ1H1Sy1MrjKGfXGBgIKCYEoxhOXKnqc/lhZbgqpQNawt+4K2iv+5BwKYBgDNLLk2n6xfQXNINhZPMe9lZJ6b+Y5FB4/rHO33iMlQn6B0Mph7lrBjFcD61ajRhMOdLZObksMArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dXQAAuPQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hLV5QPd5z0nCLUjuiZ+ELPGlM0plNku5O42nbTYtdzg=; b=dXQAAuPQjzRpB6bwPw0jMYh78z
	XxOnSmi9yZC+HQ5q2PzZJYVtKPkZ7y1st4MIL1hmqPZYjil4p762Kk4B2+TJ6KcWPL0obftUv9k63
	5+ZJg4gkXTKAKmBGB5Tn2uByVNU4GeOBAdUSriLj+uSvNeG8OTtFA152HtTMjxyp9RUVgYnN95DgG
	Uze+wv3nz6L/2zJkzPwajHu3BaG149HD+MN4iyiZcMWvhFZ5xTm5b5FIexcGfqsZ6LMB31S3XwRRp
	wbbX6E0cYBjH92VUSchvdsiAhBwzGqoxWJGOenZcu2ZajO1fYqlvEcmZ5EMNRCmweht16eAUi+Ihz
	4inuVCEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0a5G-0000000EpPt-1ATz;
	Sat, 27 Apr 2024 04:54:46 +0000
Date: Fri, 26 Apr 2024 21:54:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems
 with indirect mappings
Message-ID: <ZiyFFsPlgODpc-e3@infradead.org>
References: <Zivu0gzb4aiazSNu@casper.infradead.org>
 <871q6symrz.fsf@gmail.com>
 <Ziv-U8-Rt9md-Npv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziv-U8-Rt9md-Npv@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 26, 2024 at 08:19:47PM +0100, Matthew Wilcox wrote:
> > ...One small problem which I see with this approach is - we might have
> > some non-zero value in ifs->r_b_p when ifs_free() gets called and it
> > might give a warning of non-zero ifs->r_b_p, because we updated
> > ifs->r_b_p during writes to a non-zero value, but the reads
> > never happend. Then during a call to ->release_folio, it will complain
> > of a non-zero ifs->r_b_p.
> 
> Yes, we'll have to remove that assertion.  I don't think that's a
> problem, do you?

Or refine it, as the parts not read shoud not be uptodate either?

Either way I had another idea to simplify things a bit, but this might
end up beeing even simpler, so I'll stop the hacking on my version
for now.

