Return-Path: <linux-fsdevel+bounces-76926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEt/Olvzi2mpdwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 04:11:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F7120DF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 04:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 756ED30488F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF11340D86;
	Wed, 11 Feb 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xb+ziqc1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0428B4F0;
	Wed, 11 Feb 2026 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770779480; cv=none; b=YODNBKhyq+GNUJkpOLwMf5Lgql+HUDVL8QT3+pHJDv56botNkblZ0S7BO0NEB06lsUHn9D3wMTmWuSVEnOSHSpdPjgm4Jdcksv77Z39fhn8D1RGsvLMvhEL3DbC3OxmaK/esssp7kTqWR4jyljeiAY1QEVRhYbIeaT7vgslt4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770779480; c=relaxed/simple;
	bh=DCH2kn4IZ4HMYlAvNoIBmXepkZ5N3FUmnB4F34iLk38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTAGEiyEY4blhgb3O+8SQvst3pVavztBF/fTIgnvexDWjYd6HFzeCDdcsu1cxGtgZMUyPIdgognjMFlaTRLay63y/e++1tl+aIQA3Fb1NbT0A3/8vfUyLgwyEvcCXXPRMWgZDTQLPpUFM+5uJJejzbaPth6w/axTnMiqYlfdPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xb+ziqc1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FtKzJSaRWx0uyZoC4NpSdkDytjOu8nCUr6zTVUGfWDg=; b=Xb+ziqc1KtEIYvLc4DwJ2cA5Xq
	AmCCIlIvzQa+nWdYUMDDmyU67DzBmt02Q7XG1EfIh6f6cwaJR6wMwFRrCDfk5LrG/Yn2ySgwC2JAm
	YnWHObxmptaCfIoe2yuXKM3h7Z2l1lHAtXG4hzmUbLkXm9kSJBCrjSJOdAn5rPEYTQr2Lz4akLHn4
	0WvVmHex0FKjpDCHC3UOu+BPKL82scMJ3QRIyxFo9VD8GaQaFPVEnq2q+ygx1rL6tzcckXF8Ery9b
	4SQouLnv7QXFKTkzrEwqP1RBiG9/R0Rb6bjAwIFTMjID92QTN9pW6/PIVO0UA81LZciE9VfPfPKsI
	2Me+ikGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0dG-0000000C1Dk-19Ga;
	Wed, 11 Feb 2026 03:11:14 +0000
Date: Wed, 11 Feb 2026 03:11:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Wei Gao <wegao@suse.com>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
Message-ID: <aYvzUihKhMfM6agz@casper.infradead.org>
References: <20251223223018.3295372-1-sashal@kernel.org>
 <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps>
 <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76926-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC4F7120DF8
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:18:06PM -0800, Joanne Koong wrote:
>                 spin_lock_irqsave(&ifs->state_lock, flags);
> -               uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> +               /*
> +                * If a read is in progress, we must NOT call
> folio_mark_uptodate.
> +                * The read completion path (iomap_finish_folio_read or
> +                * iomap_read_end) will call folio_end_read() which uses XOR
> +                * semantics to set the uptodate bit. If we set it here, the XOR
> +                * in folio_end_read() will clear it, leaving the folio not
> +                * uptodate.
> +                */
> +               uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
> +                       !ifs->read_bytes_pending;
>                 spin_unlock_irqrestore(&ifs->state_lock, flags);

This can't possibly be the right fix.  There's some horrible confusion
here.  It should not be possible to have read bytes pending _and_ the
entire folio be uptodate.  That's an invariant that should always be
maintained.

