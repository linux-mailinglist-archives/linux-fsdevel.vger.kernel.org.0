Return-Path: <linux-fsdevel+bounces-76056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML2+CIDOgGkuBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:19:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4F2CED56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7F1305DB90
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E879B37C11A;
	Mon,  2 Feb 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFy8BgK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B2271464;
	Mon,  2 Feb 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048352; cv=none; b=px4T9pHGtqKUAx58Sz7cBr+OnbaZBOzAosRJy0Yl0OkU3mmn914XSBUvyddg3Y0wnoiIIFGWt01/g9tFYXsafOKVDMvjFr61UXqmXVpiJkqPZKNN8p5urRCOyUGI37eXYYTyukUgL28tZv+skUZuUNSFjf+U0Ko+KtpQE5e2Ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048352; c=relaxed/simple;
	bh=ygzOtupooNTepvxoUWjaHEvjuLS7Q89q+udmj5bYQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZQsI5o8M+R2beEQtrg5NtDHNmh3HZEaZq+B+DyVqbyV4b9DQDDgKKjlSGl1k0NK0hUd9rg0CAtzKWvxNQ8+Fju9acalyCXDvJRGuE1tFpUv0fcjOQIeszRphaPuM091bJbtTli3+OSWlmABo0O71xfYaqYn6HBqpLG+YatgMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dFy8BgK8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bqVSryV38mdCL0eVX/lowdw9tG4bE60oeMG1mMMKxPY=; b=dFy8BgK8EJvpphdClPg47j63Yu
	3qPuBNa8PASiRQhuREzw8fKIsnYQ6NDaRBfSbC+l1xEuXaM0Rnzzk0gcXeNn8sEX1kOUg6oKpmpEc
	febuNWpBYJSkrkWZX4b/ZYIQH8cKzPGglWB+QWMkJ0jMeVtJZ78pD2mlOgYbD0MDEzFpmaLtc3KXr
	cAykU2aQpRMbk6+XO5rwrPNKa0zj1K4gPQRGaUsyzx0sSZigteEbHUqFfbDsrkaTadJ6ePwCfMUjM
	i2t9iomcJzsGjDLfxvK6PW/JpbpsgxxxvbuYRECzBbRlmS6G8BQ0fegX1zVbeVqIHvFERKl1krlX9
	TWLKW8Jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmwQu-00000005GQr-1HCx;
	Mon, 02 Feb 2026 16:05:48 +0000
Date: Mon, 2 Feb 2026 08:05:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Piyush Patle <piyushpatle228@gmail.com>, brauner@kernel.org,
	djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Subject: Re: [PATCH] iomap: handle iterator position advancing beyond current
 mapping
Message-ID: <aYDLXHqHmkdTL-M0@infradead.org>
References: <20260202130044.567989-1-piyushpatle228@gmail.com>
 <aYC5Utav-rTKigTw@infradead.org>
 <aYDES-sGwCEr80Z3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYDES-sGwCEr80Z3@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-76056-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,bd5ca596a01d01bfa083];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F4F2CED56
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 03:35:39PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 02, 2026 at 06:48:50AM -0800, Christoph Hellwig wrote:
> > On Mon, Feb 02, 2026 at 06:30:44PM +0530, Piyush Patle wrote:
> > > Closes: https://syzkaller.appspot.com/bug?id=bd5ca596a01d01bfa083
> > 
> > This link doesn't work.  And the commit log has zero details of what's
> > happening either.
> 
> Looks like this one:
> 
> https://syzkaller.appspot.com/bug?extid=bd5ca596a01d01bfa083
> 
> but there's no reproducer.  Looks like it's through the blockdev rather
> than a filesystem being involved.

Let's wait for a reproducer.  The fix looks incorrect for anything I
could think of, so I'd rather fix a real bug.  Given that lack of
reproducer I'm also not confident that it fixes anything.  The fact
that the Fixes tag points to a merge commit doesn't really increase
the trust I have in it either.


