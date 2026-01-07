Return-Path: <linux-fsdevel+bounces-72577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB9CFC22A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 07:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38E73067F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 05:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0B26E70E;
	Wed,  7 Jan 2026 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1bbtKJkO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AA1FBEA8;
	Wed,  7 Jan 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765485; cv=none; b=Cf5WaJzHTgk4ugaUjfbdyu3DLw3x9Bu+BHiqDuhtzmunVLRQgZIH8FZ+qLiwa16MHkPtntxtlq1tsoMD+a0RZJ30p772kY+81J3H+jQmTerhSWpKnmzluZT0/S2Z3qgrYWJ+G0QMfJC+g+e1WiqTE5kH4coXplv4Phknuz1FpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765485; c=relaxed/simple;
	bh=n2TxllsBzZx2LLTcJvsSP2QzK6N5kNDdr9mUSEGZmN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1IBr74qS7X6gx12zkWTSWmaT5s2dETXAEgJwRxes6n0YxpGXTiGc8/U8HECVyRJr6J2+6O7b6rUtf4ibB+xG/4hl6EWOXAjXw9qv3vzYxMBPg3/iMxHP+MrKLhnRFSMfkf9v6iOiWYSe/8AcGtHXrbuOTII/0q+lFHIUox9N/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1bbtKJkO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aOTv+1CjFuyWjmteCe2ePDaH/N8WFJwT0hycP5oYavU=; b=1bbtKJkOB8nrc5xGHj+NwlJcTz
	dTjh1dSVBjIz4W1gOFZmRq/e5P2J1U2hC4PurwwED86d7tYM+7RSHGXMP1b3QhxlFD+qfflLkXTYq
	ElypM2dNm2P2Ya6HGf/jU8EvK1weSFl0tubOJ1smpA+qUE9X5IDX4MKEZR0SVeeZiCHUVDEr3qnkW
	wjsTVboPUB6vVL7zAXGriFfBZNU6dhUM/8jL9oZ7YYWV1Au89ABtvb/B+ARHXDQoJ73JYxxXsw2Ud
	UGs+3Fg0cJReQhZ0JyHy4+bamfNdyQqCeuvsoUGBkUpQVD/YfJil0ccZJB7OCVW4AZ6ZWAuiDAzaY
	fmQTwcDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdMYS-0000000EC3R-2eLM;
	Wed, 07 Jan 2026 05:58:00 +0000
Date: Tue, 6 Jan 2026 21:58:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 3/3] generic: add tests for file delegations
Message-ID: <aV316LhsVSl0n9-E@infradead.org>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-3-be55fbf2ad53@kernel.org>
 <aVyriyPD8x8oJUo-@infradead.org>
 <696b5d94d413aa89b88c68138eabecca9ce9e873.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <696b5d94d413aa89b88c68138eabecca9ce9e873.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 06, 2026 at 06:09:24AM -0500, Jeff Layton wrote:
> On Mon, 2026-01-05 at 22:28 -0800, Christoph Hellwig wrote:
> > On Wed, Dec 03, 2025 at 10:43:09AM -0500, Jeff Layton wrote:
> > > Mostly the same ones as leases, but some additional tests to validate
> > > that they are broken on metadata changes.
> > 
> > Under what conditions is this test supposed to actually work?  It seems
> > to consistently fail for me even with latest mainline, which is a bit
> > annoying.
> 
> There is a patch that is not yet merged:

Thanks.  Also what is the story with generic/786 on NFS?

It seems to constantly fail for me:

generic/786  5s ... [   17.862569] run fstests generic/786 at 2026-01-07 05:29:40
[failed, exit status 1]- output mismatch (see /root/xfstests-dev/results//generic/786.out.bad)
    --- tests/generic/786.out	2025-12-18 06:25:33.420000000 +0000
    +++ /root/xfstests-dev/results//generic/786.out.bad	2026-01-07 05:29:47.576897353 +0000
    @@ -1,2 +1,3 @@
     QA output created by 786
    -success!
    +Server reported failure (1)
    +(see /root/xfstests-dev/results//generic/786.full for details)
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/786.out /root/xfstests-dev/results//generic/786.out.bad'  to see the entire diff)


