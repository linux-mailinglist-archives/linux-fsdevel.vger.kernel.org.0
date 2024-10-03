Return-Path: <linux-fsdevel+bounces-30863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05098EED2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59510284D44
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733516F827;
	Thu,  3 Oct 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V1E58div"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA614D708;
	Thu,  3 Oct 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957475; cv=none; b=fxA9DD+pfj6DPvPxkqQh7lEiibF48F+IxxfXeItoU5TV/mm3oSxpJxC4g4cFo39jyqrc4VVsnni9PgPmsJ5yRgG2cOnY/Oq1/3YreszeHMGN4Q2Ozb7sTM+YOVWCiQAFITk7EX2WUooRwX0p2P1YfGwt7Qa9zTgZFbz3zHsKZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957475; c=relaxed/simple;
	bh=Pj8ze2hn78F38jRAAhc3T+G/8A/paWVEx4b69ovgYLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/y12qxjaxnwqdk6ZKRqsNQCh9IIWRo8RNAyKHC1uYCKQXU4gr/07eZlseZkqkpTJkn1nar5uSmJyxrxO7CBLlOupXiWHglmz8L+vqMDOFKffXrcetOYblkusi1Jnl8nK7kKVxazX/WyWv/sZjZcdb+piZyyw02Bsdesc7akRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V1E58div; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pj8ze2hn78F38jRAAhc3T+G/8A/paWVEx4b69ovgYLU=; b=V1E58divffuS8U4FI/HplNQy8b
	qoduPx+/cQxIPhkEGoihH/cu1AL+ojOjK0ceJNl/8T4TnINeJXiupAE5yVV4KBYEspJd1zmTPdxQZ
	aK7HEm0LXgZx+hx8vDYBcWXr4VNPB2Ebj41Pqkdysp8RPRDrp1Sy4Kexhg3sVCwWtTAwj/HUXXJBZ
	QPPkolMqbXYZA0Ez3HjnTQ7RZUTVjbG5urw/J7DK19iFXT07Vl6HsjlbDPTBGQxa3m5k2SwNlG82G
	jG3MJ06vXw7CgpMdZs1oLwcZIf1YFN+s6E5w+YPghLyNMPKRx1yRSJEbqjKa1gZmsABCtWLj+yssL
	ugZc3uBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swKfn-00000008z5C-1ihP;
	Thu, 03 Oct 2024 12:11:11 +0000
Date: Thu, 3 Oct 2024 05:11:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <Zv6J34fwj3vNOrIH@infradead.org>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003115721.kg2caqgj2xxinnth@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 01:57:21PM +0200, Jan Kara wrote:
> Fair enough. If we go with the iterator variant I've suggested to Dave in
> [1], we could combine the evict_inodes(), fsnotify_unmount_inodes() and
> Landlocks hook_sb_delete() into a single iteration relatively easily. But
> I'd wait with that convertion until this series lands.

I don't see how that has anything to do with iterators or not.


