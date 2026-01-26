Return-Path: <linux-fsdevel+bounces-75472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMwvB/mBd2m9hgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:02:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84289E0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACD8E3006D77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F53346B5;
	Mon, 26 Jan 2026 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BrScewTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C888329E4B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439595; cv=none; b=R4rbxN+GzRAPL4f4X51pc3+RlTHwBKIznJ0IXsPcQTRho1z2JA3JnMG7KKNVz9w4bTlm8e+dk3ZpfuejM9a34Mj2BMvhKgCgH+Fvfx5n5/zAlKUduyPopHHgk9ebzTw/QlbmpT82d0JN2Bg/+95YcfXCqwyHuutFzp7TlZAUW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439595; c=relaxed/simple;
	bh=OX+v4TKDR+gsW/n8vIf9pjEXlRymcXTp3D79Tv25LRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/ufT9Rf/AZHmoPyulAg9qC2UFauJdrLyGFoJn5fN1pRoB3qIpqjJmu9y9JlAnLw8pEz3aY5d1l8BlSE2FMiwFXtXqpwJVaPD7xW2N57J207XUugEknbXvzKJ4cgzaFNCAica3PNcgHMdpWP3zvFqu0+3rkU1Kc+Ge8iv694N3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BrScewTz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w0fs68nxSYfkTSNg/ax/LrOAm2/rHroEdR3TFp7o/b8=; b=BrScewTz4PBRKInE6NkIu98MCm
	oNTa1v3mBAHPl/8htrfKlPhKOOF4VDMHIrh6oNJQickm/9gpIXkvjDyQjlwfgMWUYnNZAd8hMEeG3
	XIlIbTGcSk1qOku2RYOCSAXJsIokfAOmnbp7nu8jj/anEHFnqy6jtCZ0HZJi8Uya8fqroBRdYelCL
	bXdIyZM6/yG08pHGqTiPBD4/WRT0MqgyHnGFMXpcGoW0B7eSSgXaAUO8VAYIPFT1kCaR99aTubFqq
	VyoPSsi39Ou22MD3z+sIXqk2h7JAh55qWVpNX9ep8GRgeuo9iMgCLtgzOr2B6r9dFqCexkFIPAxh2
	PnLotR5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkO4F-0000000Cjp3-0NvD;
	Mon, 26 Jan 2026 14:59:51 +0000
Date: Mon, 26 Jan 2026 06:59:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iomap: fix invalid folio access after
 folio_end_read()
Message-ID: <aXeBZx7A3sWuFmIm@infradead.org>
References: <20260123235617.1026939-1-joannelkoong@gmail.com>
 <20260123235617.1026939-2-joannelkoong@gmail.com>
 <aXb_trkyt-uzdIkd@infradead.org>
 <aXeAY8K12KKf9d4_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXeAY8K12KKf9d4_@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-75472-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A84289E0C
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:55:31PM +0000, Matthew Wilcox wrote:
> > Can you drop this cleanup for now?  I think it's actually useful,
> > but it should be in a separate patch, and creates a conflict with
> > my iomap PI series.
> > 
> > The actual fix looks great and simplified the code nicely!
> 
> I don't think it's just a cleanup -- I think it's a bug fix.  But, yes,
> it should be a separate patch because it's a separate bug.  That bug
> can be hit if the folio passed to iomap_read_folio() covers more than
> one extent, the first call to iomap_iter() succeeds, and then the second
> one fails.  Now we have a folio with a positive read_pending that will
> never become zero, so we'll never unlock the folio.

Oh, I missed it added a condition for the read_folio case.  Another
reason to split the fix from the (otherwise nice) refactoring.  And
fixing it directly in read_folio also helps with the conflict avoidance.


