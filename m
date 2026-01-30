Return-Path: <linux-fsdevel+bounces-75927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO+gLko+fGkxLgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:14:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E38B73CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 06:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D3A3300DF47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 05:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5333C535;
	Fri, 30 Jan 2026 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r03nDq/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5D309EFF;
	Fri, 30 Jan 2026 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750076; cv=none; b=q8BuOBSrQ97rECkkb2CGJ17rf+4JYvSek3GH2G+lhN6USTv/uNoD41yowz7uJH1FtMhKzMeS3rb/CQ07lLqkx961qEVwDPgsiNG+WbK81IRLjaS7wvwF+VOpkxk46f/wqv14r19QaR+M4qbZtCJDkEh9d/fjYsjE53zFo/PwCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750076; c=relaxed/simple;
	bh=cq6DH+bxh7akNUaBSrNTANflbfENCcjsCJyagr96N80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asoPbftodrY8AxBWX+2WrxwC8Umd7h7VBx27XLjMa6ldMcmIHn6l4BrbNn6kP2KPqlAKCX5azS2RIU7izU4S7oHdfzpjKJc3ydAbcjWEF2TT6T8GLX/bOkgeE6A4rly37qA9cu45yNEJLmXn/XKPlH3Eo5EZ2irEAtwi6Tft1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r03nDq/s; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ueh0ic4T36q/iEhfckOEc49N99W/3h9BCo9Ibq+JFg8=; b=r03nDq/s/B8Jz5vTLg/Nn5yrkE
	jMXzM9hcJ+m1X27uiSZwlpki/dmOtNaRFWVAYEiTj4VGtncjSQYK927ZzpTT/c7SSsnw/zkNOm2ye
	iMV9gd61UMecpAjlHUy2s8rHPyFILnOmyK74BdxiGjsnufOlXIMJLWJWi8spyWQL0Q6y4HItPsNOn
	rtYoQWmXDMhvM5QxAGYzQyc2F+mRy29tWP7/Qg7neZ98FaWEOJD41BJC++gFvVwOocc8kF0ItYyqj
	aw53GElmWZpLi4VGZV5Et/q59NGcoPqoFEJZu5xalXMgjFTtLvya3GNiHGyZHX/SivDE2iN1Oklt5
	9DRjryhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlgpv-0000000BhUd-05Yh;
	Fri, 30 Jan 2026 05:14:27 +0000
Date: Fri, 30 Jan 2026 05:14:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, boris@bur.io, clm@fb.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: defer freeing of subpage private state to
 free_folio
Message-ID: <aXw-MiQWyYtZ3brh@casper.infradead.org>
References: <20260129230822.168034-1-inwardvessel@gmail.com>
 <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776e54f6-c9b7-4b22-bde5-561dc65c9be7@gmx.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75927-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmail.com,bur.io,fb.com,suse.com,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 43E38B73CD
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 01:46:59PM +1030, Qu Wenruo wrote:
> Another question is, why only two fses (nfs for dir inode, and orangefs) are
> utilizing the free_folio() callback.

Alas, secretmem and guest_memfd are also using it.  Nevertheless, I'm
not a fan of this interface existing, and would prefer to not introduce
new users.  Like launder_folio, which btrfs has also mistakenly used.


