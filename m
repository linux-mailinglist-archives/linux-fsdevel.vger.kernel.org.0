Return-Path: <linux-fsdevel+bounces-77054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGZSEqwqjmlsAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:31:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A89130B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6844230417A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DB2DEA95;
	Thu, 12 Feb 2026 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOcLSB7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A9274B44;
	Thu, 12 Feb 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770924703; cv=none; b=Q1mc0avaQXgVN6Xtvmj3KFL+ikBbhU9pwii3roCjsD2MTl27vvNzZu181HuGhU59rRE0CDIs9XaV/4+4n28QzEWtmfDW32mhyUgt49MDHHwVumTAUEc5DLhf5EEeFqRE/i8Ihn3PbSdRhkuSKmCha1eI7TonBEvMWmBTYwE9Pog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770924703; c=relaxed/simple;
	bh=haZ8oSpcvOdAc/4/xkwB5xWSodTnx7Kn5CXGs0AxRBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev6g406EsCjOn30Bkya1jNdX2ts62ZskyC9VkxHyMZNT+VxvunhFYSs7tTLGL5QBBePiw83M1J0vPsmXyyEaeHsBfW3C+iU3K2z5rQ5epGXrqlPVkLp6pIhME4F9MPdMuM5ZRRSYxfQMKV/Gd1YdpMby+27+RVNfGYd75F5vOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NOcLSB7c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=U8bd8FIyNs2OJZnQ9wdSrRYGwMYUnhq9GMT3wy9wYVI=; b=NOcLSB7cp9ar6xuccEPJ1jd9WW
	qMApDHtGJ6oCgJiVY9Ira53meVVA/JaRcaVstxDScWDacz49WHavaO2K/f7ordv2gdYtHEW91xj7/
	2lwSc6JzcdgIuFw5VxoiVzRuX0DeHQxS08bFjF4Fba/1uiHkKC4tHHoO0Io5nJWTxPFhDV15pKpxE
	39P2BQPUokK+KybUH5vcb0eriobKx5cl0W7N0INKZ6kdTFNanFk+FTlEdPovHc7nqGOB0gDFOSvrs
	JWYeaHL4x5uRRGo9qjLGLCr6GmWdQ8pPtL/DiBthte1/I8TE22PHQgGN8xJHzCaa08opo9/oR60lW
	XyXX9gNA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqcPa-0000000Ed2S-3GLR;
	Thu, 12 Feb 2026 19:31:38 +0000
Date: Thu, 12 Feb 2026 19:31:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Wei Gao <wegao@suse.com>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aY4qmjRMganhoqxk@casper.infradead.org>
References: <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
 <aYvzUihKhMfM6agz@casper.infradead.org>
 <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
 <aYzulh4XWO-TBof8@casper.infradead.org>
 <CAJnrk1YcuhKwbZLo-11=umcTzH_OJ+bdwZq5=XjeJo8gb9e5ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YcuhKwbZLo-11=umcTzH_OJ+bdwZq5=XjeJo8gb9e5ig@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77054-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,casper.infradead.org:mid]
X-Rspamd-Queue-Id: B6A89130B95
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 03:13:48PM -0800, Joanne Koong wrote:
> On Wed, Feb 11, 2026 at 1:03 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Feb 11, 2026 at 11:33:05AM -0800, Joanne Koong wrote:
> > > ifs->read_bytes_pending gets initialized to the folio size, but if the
> > > file being read in is smaller than the size of the folio, then we
> > > reach this scenario because the file has been read in but
> > > ifs->read_bytes_pending is still a positive value because it
> > > represents the bytes between the end of the file and the end of the
> > > folio. If the folio size is 16k and the file size is 4k:
> > >   a) ifs->read_bytes_pending gets initialized to 16k
> > >   b) ->read_folio_range() is called for the 4k read
> > >   c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
> > > 0 to 4k range is marked uptodate
> > >   d) the post-eof blocks are zeroed and marked uptodate in the call to
> > > iomap_set_range_uptodate()
> >
> > This is the bug then.  If they're marked uptodate, read_bytes_pending
> > should be decremented at the same time.  Now, I appreciate that
> > iomap_set_range_uptodate() is called both from iomap_read_folio_iter()
> > and __iomap_write_begin(), and it can't decrement read_bytes_pending
> > in the latter case.  Perhaps a flag or a second length parameter is
> > the solution?
> 
> I don't think it's enough to decrement read_bytes_pending by the
> zeroed/read-inline length because there's these two edge cases:
> a) some blocks in the folio were already uptodate from the very
> beginning and skipped for IO but not decremented yet from
> ifs->read_bytes_pending, which means in iomap_read_end(),
> ifs->read_bytes_pending would be > 0 and the uptodate flag could get
> XORed again. This means we need to also decrement read_bytes_pending
> by bytes_submitted as well for this case

Hm, that's a good one.  It can't happen for readahead, but it can happen
if we start out by writing to some blocks of a folio, then call
read_folio to get the remaining blocks uptodate.  We could avoid it
happening by initialising read_bytes_pending to folio_size() -
bitmap_weight(ifs->uptodate) * block_size.

> b) the async ->read_folio_range() callback finishes after the
> zeroing's read_bytes_pending decrement and calls folio_end_read(), so
> we need to assign ctx->cur_folio to NULL

If we return 'finished' from iomap_finish_folio_read(), we can handle
this?

> I think the code would have to look something like [1] (this is
> similar to the alternative approach I mentioned in my previous reply
> but fixed up to cover some more edge cases).
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/joannekoong/linux/commit/b42f47726433a8130e8c27d1b43b16e27dfd6960

I think we can do everything we need with a suitably modified
iomap_finish_folio_read() rather than the new iomap_finish_read_range().

