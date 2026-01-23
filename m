Return-Path: <linux-fsdevel+bounces-75210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLGSFHsMc2ncrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:51:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDD708EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56664301017B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB4C3659E5;
	Fri, 23 Jan 2026 05:51:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05B38E5CC;
	Fri, 23 Jan 2026 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147497; cv=none; b=BH5xaz961VMEllnILW1HZQKiaEu0kEq46wHmj2vyd8coStbDFpNEyonSWPowYuuCG/CcsT+xhgGQ1SkhGVd5bSxVoKxiWcBDNGBT/Rszq46ffjeDAhAjnMcMhkiVlzQro9ksG3Em+/GkBTqP/IRGVrY1Oyw6W8/46enA3MqzjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147497; c=relaxed/simple;
	bh=cSfY0j5WNPVTLRhOpzWH7Htic2v0ucJ87L2Qiw27oGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwyxpCZkc5RCFwxW45jjvWYWsXISH51bJz8AQgMPNj+hsPSdkmgOT8H0tlcDLQy3RGD767ewX/gkV8GuifWddztUxUuwgqzLpk/UPBXfKCn100t/i+OuNqgsR/+P/o7UGn43qF2ERk+vS8SuSzTUC0yXgJLRw1AUZL4ukTKgT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90792227AAE; Fri, 23 Jan 2026 06:51:28 +0100 (CET)
Date: Fri, 23 Jan 2026 06:51:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Message-ID: <20260123055128.GC24902@lst.de>
References: <20260119074425.4005867-1-hch@lst.de> <20260119074425.4005867-6-hch@lst.de> <20260122172556.GV5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122172556.GV5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75210-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 96DDD708EF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:25:56AM -0800, Darrick J. Wong wrote:
> Hrm.  Should we combine this with the slightly different version that is
> in xfs_healthmon?

Yes, but not now.  I'd rather not introduce a three-way cross tree
dependency with bike shedding potential right now.  Let's look at this
once we have the two versions in tree, and also look out for others.

> > +static void bio_free_folios(struct bio *bio)
> > +{
> > +	struct bio_vec *bv;
> > +	int i;
> > +
> > +	bio_for_each_bvec_all(bv, bio, i) {
> > +		struct folio *folio = page_folio(bv->bv_page);
> > +
> > +		if (!is_zero_folio(folio))
> > +			folio_put(page_folio(bv->bv_page));
> 
> Isn't folio_put's argument just @folio again?

Yes, I'll clean this up.

> > +		if (this_len > PAGE_SIZE * 2)
> > +			this_len = rounddown_pow_of_two(this_len);
> > +
> > +		if (bio->bi_iter.bi_size > UINT_MAX - this_len)
> 
> Now that I've seen UINT_MAX appear twice in terms of limiting bio size,
> I wonder if that ought to be encoded as a constant somewhere?
> 
> #define BIO_ITER_MAX_SIZE	(UINT_MAX)
> 
> (apologies if I'm digging up some horrible old flamewar from the 1830s)

Heh.  I don't remember any flame wars, but maybe that's just because my
memory sucks.  I guess this would be more like:

define BVEC_ITER_MAX_SIZE	sizeof_field(struct bvec_iter, bi_size)

though.
	
> > +	} while (len && bio->bi_vcnt < bio->bi_max_vecs - 1);
> > +
> > +	/*
> > +	 * Set the folio directly here.  The above loop has already calculated
> > +	 * the correct bi_size, and we use bi_vcnt for the user buffers.  That
> > +	 * is safe as bi_vcnt is only for user by the submitter and not looked
> 
> "...for use by the submitter..." ?

Yes.

> > +	if (likely(!is_error)) {
> > +		void *buf = bvec_virt(&bio->bi_io_vec[0]);
> > +		struct iov_iter to;
> > +
> > +		iov_iter_bvec(&to, ITER_DEST, bio->bi_io_vec + 1, bio->bi_vcnt,
> > +				len);
> > +		WARN_ON_ONCE(copy_to_iter(buf, len, &to) != len);
> 
> I wonder, under what circumstances would the copy_to_iter come up short?
> 
> Something evil like $program initiates a directio read from a PI disk, a
> BPF guy starts screaming in a datacenter to wobble the disk, and that
> gives a compromised systemd enough time to attach to $program with
> ptrace to unmap a page in the middle of the read buffer before
> bio_iov_iter_unbounce_read gets called?

I don't think it can at all.   Remember, this is not directly copying
to the user iter, but to the bvec array pointing to pinned pages,
which are not going away. 


