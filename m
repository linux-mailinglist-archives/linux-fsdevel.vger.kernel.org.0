Return-Path: <linux-fsdevel+bounces-64828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DBBF5101
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ACD40286A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEFB2874F5;
	Tue, 21 Oct 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1F3uxSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC36281530;
	Tue, 21 Oct 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032891; cv=none; b=C6HgWlr0m9ntnoxeVEVsOS0s5OiFCM45rMvOz+0E5ZioRfOovGoo5VMKmPktIcI0i/69wT+foSXWvM1ryLhyPwDypfuUJGLfIjnVqP0vTrf5c/EfC+Flse2/nAoKokzoYyZfYhfk6Hc7rXR/jkHWp6PcrkS9JtoDOsSVHY6aLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032891; c=relaxed/simple;
	bh=XhCl+SCbyOpeOZ1AE2jPhpd4MAf2vxC3mUxmHvFOwU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZcmWT1FWEgb7iB6x/6BCrAB4SgasKnwkugChs699U78ppyCKO6kSsg2c8j5LZSoWkuFPRNlLfXuAQJFHiFWaur1i3ORXfFxMh7oEsbSwy0vf8xOPnUSIWHAV/TG0voenyfhkEhOAmVsNpNEDpQSB/FEMuqEFVwwqMrb3q2svII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1F3uxSV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yalo9SiRMGqaQ57Tjo01PZAvDxSGipcok0E7dyv6KxY=; b=S1F3uxSVDM2G8R0EL9JyjwN4LD
	T3bAgqcuJQcRn2FQRZ9433Vc9KUz36fT2u2LN3A9pSSrBe/aricGB+em1DnnLpjO7heKE6tjvN/mr
	Ef2FK7rp90zlJ67vXe2PLQxmDHdSkVwOulHs86nkwEYQaL42Oe8FFZ9UxCK7ZypCHt7uFFrUnff2c
	MUQm8lfeRPk+sFn3/7EjOu/stzK/lSTG45Hr1KBCrjWikJaPKQydLw8Uji8QKXd+9+XaKRtN7rHJA
	8JSDrnlOaqQGXW9oK6pRYtdQPeon+5tFCLdEaVjjk5aYa1k9LZvTqAX3SXcCR+5dsHWfhA7/zeW33
	QLd6+eOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB76G-0000000G9Fq-0mBQ;
	Tue, 21 Oct 2025 07:48:08 +0000
Date: Tue, 21 Oct 2025 00:48:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPc6uLKJkavZ_SkM@infradead.org>
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 01:47:03PM +1030, Qu Wenruo wrote:
> Off-topic a little, mind to share the performance drop with PI enabled on
> XFS?

If the bandwith of the SSDs get close or exceeds the DRAM bandwith
buffered I/O can be 50% or less of the direct I/O performance.

> With this patch I'm able to enable direct IO for inodes with checksums.
> I thought it would easily improve the performance, but the truth is, it's
> not that different from buffered IO fall back.

That's because you still copy data.

> So I start wondering if it's the checksum itself causing the miserable
> performance numbers.

Only indirectly by touching all the cachelines.  But once you copy you
touch them again.  Especially if not done in small chunks.


