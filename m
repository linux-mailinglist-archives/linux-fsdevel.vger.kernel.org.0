Return-Path: <linux-fsdevel+bounces-74980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QENxARjCcWmdLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:22:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CC62392
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B22D74E0F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA263ED105;
	Thu, 22 Jan 2026 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPtRDG3Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488040F8C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062926; cv=none; b=QXTThmIZy7WzfhbCddKNiDM45yEfu+VwpdU9kZTFpAg1rvkLJ3vMOzQCP+9NYvnZeRA2RcbHgHGhVQ0a6FSnvUVVWpLt0JNPbKVpVVPBfuV8OO/t1F25rF9KNE4W4wlQ8lsE5ZeYvGCNxK4PU+CWxs7diG2qfJp1JX+Kcsymj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062926; c=relaxed/simple;
	bh=BuhcUeagOrblC0D3FauRt9BUA47GTN59GTabgWaIwD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9kWQ6lUUcpY0axdrMgK4LzwFBSzjEi67Kari0oZpfRa19NKJj07dKTht3yALn235nJakRPE2MuCEH4KCOJWpuv7kdkGRyoLfUUtpPoBE4jqilOrGxUVdlp6PiLCcPx8dL8sSPqqeqtNjXymfhGWlD+R1L1ToXWJNUCPOpQbdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dPtRDG3Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E9+heVjOiPN4xLku4leMU1/TgIt/0iviGGXi0cpAQ7g=; b=dPtRDG3Qk40K+II92TfrLGhLFb
	hEEuy4bA6ZBeBqW7EupDUS4gw0v9mCd+5oqBIBqA2K8+jCFV5/pgt5ZTMlzae54XS0kn9oTL4CShi
	JqhoACfK14pnsTwNAJ5I7pjyrH6X1EmHDG/pLLJ06kIYdS9KIJ88IIAWAF+Q9Quk8MpNEJTFEzKl9
	dShncJ7k1ueEakvMn/hqFs8SSBF4CDSd5ib/9TNUHC+hWrbWhzeQJXYMFrUFAl8DO/hN9L2NOAjqo
	2kB/pyVQXvll4/nFhE402XY0ShmHOky9j6sqJxSa4J4PGivyuxa1EniRhgrlJlOzn6Yt1q91tnfOL
	2r3PQlyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vio4v-00000006Upk-0Es9;
	Thu, 22 Jan 2026 06:22:01 +0000
Date: Wed, 21 Jan 2026 22:22:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	willy@infradead.org, djwong@kernel.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after
 folio_end_read()
Message-ID: <aXHCCdqh04F-_wjt@infradead.org>
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com>
 <aXCE7jZ5HdhOktEs@infradead.org>
 <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	TAGGED_FROM(0.00)[bounces-74980-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 671CC62392
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 03:13:35PM -0800, Joanne Koong wrote:
> Thanks for taking a look at this. The problem I'm trying to fix is
> this readahead scenario:
> * folio with no ifs gets read in by the filesystem through the
> ->read_folio_range() call
> * the filesystem reads in the folio and calls
> iomap_finish_folio_read() which calls folio_end_read(), which unlocks
> the folio
> * then the page cache evicts the folio and drops the last refcount on
> the folio which frees the folio and the folio gets repurposed by
> another filesystem (eg btrfs) which uses folio->private
> * the iomap logic accesses ctx->cur_folio still, and in the call to
> iomap_read_end(), it'll detect a non-null folio->private and it'll
> assume that's the ifs and it'll try to do stuff like
> spin_lock_irq(&ifs->state_lock) which will crash the system.

Yeah, I think I gather that from the code changes in the patch, but
it helps to state this.  Or in short, this:

		if (ctx->cur_folio &&
                    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {

accesses a potentially freed folio.

> > > +                             if (unlikely(plen != folio_len))
> > > +                                     return -EIO;
> > > +                     }
> >
> > I think the sanity check here is an impossible to hit condition and
> > should probably be a WARN_ON_ONCE?
> 
> I'll be removing this check for the next version.

I think it's good to have the checking, what I mean is to add a
WARN_ON_ONCE to make it stick out as a debug check.

> Looking at this some more, I think we'll need to use ctx->cur_folio
> for non-readahead reads as well (eg passing ctx->cur_folio to
> iomap_read_end() in iomap_read_folio()). As Matthew pointed out to me
> in [1], we still can't access folio->private after folio_end_read()
> even if we hold an active refcount on the folio.

Yeah.


