Return-Path: <linux-fsdevel+bounces-75222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GkFNJUfc2ngsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:13:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C4717B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680C93033503
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8B435C1BF;
	Fri, 23 Jan 2026 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2IQz7ox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E8346A08;
	Fri, 23 Jan 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152299; cv=none; b=oa+kEeSTS8GTLP+kCikGiD1+y3pdVRTF5iSnSfHDoSGtAkmAcFdmTRVuEkYsZP/4WLpBIW8X39/sdGF3ODzLVEdPr3awFHmdrs/KKUVzW/We9mldXPaeBBx0gRRvfGdJLGJ59zhvGBS4hUW4B2TssMfkFAjOZ7limWNrPpTz/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152299; c=relaxed/simple;
	bh=Di+hOyRFpG3yCQTTuX2zjMcmDVRHfCRQ6tKIhquda4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufpV+H9slQjMgIeZ/Nu70nyq//G536DWntETIgE0kAdfsfvRIPGBLwfxOBPq8Vsan9ZpSdK23kthmwuPzteSCg/2Yzk6Xtbi3x3Nnz+IZ9WbjnaT6PcNUdIrkPxugTZVgqLhVI9NDr9fd209zCJYd0LdF+W3FGW63UuaPAAHIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2IQz7ox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6EEC4CEF1;
	Fri, 23 Jan 2026 07:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769152299;
	bh=Di+hOyRFpG3yCQTTuX2zjMcmDVRHfCRQ6tKIhquda4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l2IQz7oxRKt6TWSY0wjcbTF2Zi21KvYseuvg00TLZ4DOfnUvuJsXeQAzX/U7bYlIA
	 fzPBvlS9Fzm239iK1lkgjkSfrCeHeu9T4uc4L7hQ4TfpcoXEs+gt9iy3PPST9GG9RD
	 xiS1Hoe+/RUYbwxA/RzbpJXiI33ur52SiuSMr0Yil3LTKDZBYr2lEniEK8yowfvM44
	 BoMaGqk9bxrHWIaeo7LGX1O/fqEsGq2Er7qD+YdOn9jAp7Esj1xp5y+WEySpUzx5XL
	 qf6ZGhWQ/cbzO/GdGWwbqNDTsi5ugDJmNBHH6BxuFFrgll6R7Ped8Nf2327/h3Wx5W
	 iJksFE8bUrSow==
Date: Thu, 22 Jan 2026 23:11:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Message-ID: <20260123071139.GT5945@frogsfrogsfrogs>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-6-hch@lst.de>
 <20260122172556.GV5945@frogsfrogsfrogs>
 <20260123055128.GC24902@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123055128.GC24902@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75222-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 667C4717B9
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 06:51:28AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 09:25:56AM -0800, Darrick J. Wong wrote:
> > Hrm.  Should we combine this with the slightly different version that is
> > in xfs_healthmon?
> 
> Yes, but not now.  I'd rather not introduce a three-way cross tree
> dependency with bike shedding potential right now.  Let's look at this
> once we have the two versions in tree, and also look out for others.

<nod>

> > > +static void bio_free_folios(struct bio *bio)
> > > +{
> > > +	struct bio_vec *bv;
> > > +	int i;
> > > +
> > > +	bio_for_each_bvec_all(bv, bio, i) {
> > > +		struct folio *folio = page_folio(bv->bv_page);
> > > +
> > > +		if (!is_zero_folio(folio))
> > > +			folio_put(page_folio(bv->bv_page));
> > 
> > Isn't folio_put's argument just @folio again?
> 
> Yes, I'll clean this up.
> 
> > > +		if (this_len > PAGE_SIZE * 2)
> > > +			this_len = rounddown_pow_of_two(this_len);
> > > +
> > > +		if (bio->bi_iter.bi_size > UINT_MAX - this_len)
> > 
> > Now that I've seen UINT_MAX appear twice in terms of limiting bio size,
> > I wonder if that ought to be encoded as a constant somewhere?
> > 
> > #define BIO_ITER_MAX_SIZE	(UINT_MAX)
> > 
> > (apologies if I'm digging up some horrible old flamewar from the 1830s)
> 
> Heh.  I don't remember any flame wars, but maybe that's just because my
> memory sucks.

Well it's not like I'm highly incentivized to remember misinteractions
on the mailing lists... :D

>  I guess this would be more like:
> 
> define BVEC_ITER_MAX_SIZE	sizeof_field(struct bvec_iter, bi_size)
> 
> though.

Hrmm, that might be better.

> > > +	} while (len && bio->bi_vcnt < bio->bi_max_vecs - 1);
> > > +
> > > +	/*
> > > +	 * Set the folio directly here.  The above loop has already calculated
> > > +	 * the correct bi_size, and we use bi_vcnt for the user buffers.  That
> > > +	 * is safe as bi_vcnt is only for user by the submitter and not looked
> > 
> > "...for use by the submitter..." ?
> 
> Yes.
> 
> > > +	if (likely(!is_error)) {
> > > +		void *buf = bvec_virt(&bio->bi_io_vec[0]);
> > > +		struct iov_iter to;
> > > +
> > > +		iov_iter_bvec(&to, ITER_DEST, bio->bi_io_vec + 1, bio->bi_vcnt,
> > > +				len);
> > > +		WARN_ON_ONCE(copy_to_iter(buf, len, &to) != len);
> > 
> > I wonder, under what circumstances would the copy_to_iter come up short?
> > 
> > Something evil like $program initiates a directio read from a PI disk, a
> > BPF guy starts screaming in a datacenter to wobble the disk, and that
> > gives a compromised systemd enough time to attach to $program with
> > ptrace to unmap a page in the middle of the read buffer before
> > bio_iov_iter_unbounce_read gets called?
> 
> I don't think it can at all.   Remember, this is not directly copying
> to the user iter, but to the bvec array pointing to pinned pages,
> which are not going away. 

Ah, right.  How about adding a comment so that future me doesn't trip on
this again?

	/* copying to pinned pages should always work */
	WARN_ON_ONCE(copy_to_iter(...));

--D

