Return-Path: <linux-fsdevel+bounces-16440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA189DA6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E820328DAFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CC131BCD;
	Tue,  9 Apr 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCeWjdls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DCA7EEE0;
	Tue,  9 Apr 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669631; cv=none; b=ievlKH4R+3eGpCEiy68vvPW1tE35G0r8I1MCtXdfSZ77WOGpcgFR+Q7ToBSZ7b8oJd9z5F2pq2UwoLI5HfqxJOTtTCj7DNiAnNWQN5AJCbY3f5j+/U95IyD8h9x7CeVSnuuEWwP34u/0PNJQu7B5n9onlmgo7QKKYcrQTTQLagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669631; c=relaxed/simple;
	bh=bhQVoSeCVQZFmu3xe8QAYmMu2pf0oBRpa0VTQU6dyHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwF00M1SlZdyG9BRrHVNg6Qu1BkQu3djxqvpQ4aIGxxeZt36uIXXb5/GIAk93slZFH+yW5p14nQBBXS6jRnGYw8BgpmRWYljfBtGL/Zz970sMYboBjXoW2mZJK1ND/TL6Tc5b4kLpw5xma/vqDy+94xyKTH8Co4YRZubR6Var58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCeWjdls; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Km3bOLDMGGRWd+5SjvzUlmGCBNDq0fi4QAuHHSAprMw=; b=XCeWjdls5jOcaZ8WfRNfDk2cLy
	Iyt53U8MAPlr4SgkqhEhBj13dxnpexly1B059JJ+FbmHoX+arhjkHHxgtM2GVtP78xpOgPs7TA0uS
	5S+frq2RcSoLJNyhnBh/mtIJhLrM+t5OvDiKVfmIXXQ8BwiAEONoL5kqP47fpnBX5v6IJLeVWveqU
	hTxmSnOwF19QE3Rn79bGdLP9I5sbSOqF9i+gVgULIX9WOeNXqJ/B+0fZr2ExEwf5IOESesGA+44gs
	6+EAHBae9p3YWJVFG9tU/hPz0dtnZ8jR6CPu2IQTJGtkXqke4fM+vkg3L+Lc6D2IyVXMD+btLMqcq
	PWKiyT6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruBbe-0000000296z-2SRm;
	Tue, 09 Apr 2024 13:33:46 +0000
Date: Tue, 9 Apr 2024 06:33:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/14] xfs: create a incompat flag for atomic file
 mapping exchanges
Message-ID: <ZhVDuhjxBQ_3EZng@infradead.org>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
 <171263348511.2978056.14454078733236237965.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171263348511.2978056.14454078733236237965.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 08, 2024 at 08:35:17PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a incompat flag so that we only attempt to process file mapping
> exchange log items if the filesystem supports it, and a geometry flag to
> advertise support if it's present.

Looking through the whole series this actually looks a lot cleaner than
the temporary log incompat flag.  No real changes except for that, so
still:

Reviewed-by: Christoph Hellwig <hch@lst.de>

