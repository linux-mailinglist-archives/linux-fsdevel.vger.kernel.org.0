Return-Path: <linux-fsdevel+bounces-75450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNAYH7dVd2nMeAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:53:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2687DBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E980C3032CCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F16333441;
	Mon, 26 Jan 2026 11:48:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38232E743;
	Mon, 26 Jan 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428117; cv=none; b=lQmvDTcWEVhRm21kiXuAXYKF6UqpFYknDc8CZd7qgIAny/P0BNCDTWfzag8TMRQK+g98wbOWWaRFLU1UkOGKUfeHzGaoFJAalTQ4v6S1DcsmRTuTVsHVlasqeK1fQuN8BM41eyCk/8yyojKHP9jMfQk8eV4H1bKEPF+BdMZBC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428117; c=relaxed/simple;
	bh=Hv8PLo/XZN7+ToF8xlqSWcXxwVmhYxoiNZFUek0J+v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guVeF4e42vdJfXjfMvqvecc87mQKIc7yv0ZNK4q15jJjrOJNPEe1CvpCB5/ZXgm/RTtm/0M1xSVJUP82PhqOdE+9xAUeRnrV4BnL1KdorChkrJezVGnlq3E8o+i2vdc32ZH9bxI+jP/Rv6srbZzf527J6F3M9sr084fEQld6NPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 837A76732A; Mon, 26 Jan 2026 12:48:31 +0100 (CET)
Date: Mon, 26 Jan 2026 12:48:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/15] iov_iter: extract a iov_iter_extract_bvecs
 helper from bio code
Message-ID: <20260126114830.GA23617@lst.de>
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-5-hch@lst.de> <c8ec9ff0-a445-49d1-8b84-6b0ed39c9b92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ec9ff0-a445-49d1-8b84-6b0ed39c9b92@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75450-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: EFC2687DBA
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:27:16PM +0900, Damien Le Moal wrote:
> On 1/26/26 2:53 PM, Christoph Hellwig wrote:
> > Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
> > move it to lib/iov_iter.c so that it can be used by block code for
> > other things than filling a bio and by other subsystems like netfs.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
> > +ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
> > +		size_t max_size, unsigned short *nr_vecs,
> > +		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
> > +{
> > +	unsigned short entries_left = max_vecs - *nr_vecs;
> 
> Do we need to check that *nrvecs > 0 && *nrvecs < max_vecs ?
> Also, if *nr_vecs == max_vecs, we should warn and return 0, no ?

*nr_vecs = 0 is fine, and in fact the most common case.

We could add a protection for *nrvecs < max_vecs, but this is a very
low-level API, so we should be able to expect some sanity from the
users.  Especially as it will blow up instantly, including with KASAN
splats.


