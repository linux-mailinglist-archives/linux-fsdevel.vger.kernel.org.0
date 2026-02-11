Return-Path: <linux-fsdevel+bounces-76976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN+3LaLujGmSvgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 22:03:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 771041279A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 22:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6CE33003BD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F4343D75;
	Wed, 11 Feb 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MP81Tk6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E132D7F8;
	Wed, 11 Feb 2026 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843804; cv=none; b=EGQEwZuzde95jc9lqkcbLIkPvFlx+z7jZ9sb6Pi4jfItkMv2Y/foyaeczpPdMUyCkzVdf9vblMFwTf0n0Gcpg7tqzt+ymn5UjHD3DcS4KinznAkZlGOQMZq680DyANqjsOmK6z7VXp3Y1rXQGg25+dc9nlKktb4NvWaRviMK5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843804; c=relaxed/simple;
	bh=8wTqYUbqq65clNAqOC8TCnp7nSilVvXzG/uVMqRZgeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIkYDXJtNJyQoDr6IJy0dUocbBp5AdoBv+qRtZ1wHEw9TOBqs0jfrhDevJjj/ZOPdcJVvKNvD8fe8bF7ZLS5QlaMxdpxDUBwIJkLDQ62iZE0IDoY3GmHsehqfdc9LLcmxhn5q61xgs2vHi6V1mVUIm/Bkrazd4kbpp5OFQvQm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MP81Tk6n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T2N0+XYRSii8pK0bIYHt3wlyngbPoiRThz8/7AKipd4=; b=MP81Tk6nlBqmcABGd+IeIbmUP1
	2h2FBVws6Dy7TR42hQSQVSQl/FYQV2OjXrpRcrs9VQ1PVKhEmLDU8e99wVBXm7EgFXJnLdfzNgRgP
	zDP0w4o27ngfZTjH9a1k1O+NpAvXILU3bazP2sb7qdESTWT71Q0cFjvxvuVKB9qDfcvA0Ge+Vfb/+
	A28NtQBvFkXWpcdYgUUfU4QKsIxzTAWrUCdQtJF1+PeGgMoiocwZcZpqERegO1DModGylkVsqCPHP
	8mX/BGAx0DSw7aU/qzYF7ujJq3NxMCL0kQUiTMChxlf4sVBZXjAWz3DeOe5IZCG1se935tX5TDwb1
	nihzKHjg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqHMk-0000000DBxS-3CrK;
	Wed, 11 Feb 2026 21:03:18 +0000
Date: Wed, 11 Feb 2026 21:03:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Wei Gao <wegao@suse.com>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aYzulh4XWO-TBof8@casper.infradead.org>
References: <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps>
 <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
 <aYvzUihKhMfM6agz@casper.infradead.org>
 <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76976-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 771041279A1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 11:33:05AM -0800, Joanne Koong wrote:
> ifs->read_bytes_pending gets initialized to the folio size, but if the
> file being read in is smaller than the size of the folio, then we
> reach this scenario because the file has been read in but
> ifs->read_bytes_pending is still a positive value because it
> represents the bytes between the end of the file and the end of the
> folio. If the folio size is 16k and the file size is 4k:
>   a) ifs->read_bytes_pending gets initialized to 16k
>   b) ->read_folio_range() is called for the 4k read
>   c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
> 0 to 4k range is marked uptodate
>   d) the post-eof blocks are zeroed and marked uptodate in the call to
> iomap_set_range_uptodate()

This is the bug then.  If they're marked uptodate, read_bytes_pending
should be decremented at the same time.  Now, I appreciate that
iomap_set_range_uptodate() is called both from iomap_read_folio_iter()
and __iomap_write_begin(), and it can't decrement read_bytes_pending
in the latter case.  Perhaps a flag or a second length parameter is
the solution?

>   e) iomap_set_range_uptodate() sees all the ranges are marked
> uptodate and it marks the folio uptodate
>   f) iomap_read_end() gets called to subtract the 12k from
> ifs->read_bytes_pending. it too sees all the ranges are marked
> uptodate and marks the folio uptodate
> 
> The same scenario could happen for IOMAP_INLINE mappings if part of
> the folio is read in through ->read_folio_range() and then the rest is
> read in as inline data.

This is basically the same case as post-eof.

> An alternative solution is to not have zeroed-out / inlined mappings
> call iomap_read_end(), eg something like this [1], but this adds
> additional complexity and doesn't work if there's additional mappings
> for the folio after a non-IOMAP_MAPPED mapping.
> 
> Is there a better approach that I'm missing?
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/joannekoong/linux/commit/de48d3c29db8ae654300341e3eec12497df54673

