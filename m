Return-Path: <linux-fsdevel+bounces-75208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFMtFYIKc2mWrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:43:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F270854
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74BC23006FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3638FEE1;
	Fri, 23 Jan 2026 05:43:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A72332D0C2;
	Fri, 23 Jan 2026 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147004; cv=none; b=Qghds5FpZLjg484Bpuhahj3Rc/q1Tw54FQJ/U3AABpo+zWwq4fiAbN4uXVfnagy1WaHlC9Zn62XwQSd4StIm7WL3gigwCzyctEEDI1SOgOwajGT5BsY+0Q8Iiy3h28Hx9U944rbjbKFUs4UmizP9FrsvbRcFPH5OXx4bvVR6M7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147004; c=relaxed/simple;
	bh=LUVdakYwv/MUsmQ/94WD/ML3ty+iq9n/F8AGZi3XJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucZhVzrNVmsaF/gVt8hfQtEibGXRezZzdAr2Q/aUXjcxWVGOlUuOSQ/sRyj0+7Sh7E2zGwmI7Zp9Jly4IqOvyz4REZ2asGG4Rcsb6VWnJfGfDrLqWq8aqKLpyxWIzeGP3VhoD7f/dTv1GPl0oqXno7qN2ZVhdklLnrCkwoLfPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0869227AAF; Fri, 23 Jan 2026 06:43:14 +0100 (CET)
Date: Fri, 23 Jan 2026 06:43:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling
 of mismatching P2P ranges
Message-ID: <20260123054314.GA24902@lst.de>
References: <20260119074425.4005867-1-hch@lst.de> <20260119074425.4005867-3-hch@lst.de> <20260122175908.GZ5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122175908.GZ5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75208-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: EC2F270854
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:59:08AM -0800, Darrick J. Wong wrote:
> On Mon, Jan 19, 2026 at 08:44:09AM +0100, Christoph Hellwig wrote:
> > bio_add_page fails to add data to the bio when mixing P2P with non-P2P
> > ranges, or ranges that map to different P2P providers.  In that case
> > it will trigger that WARN_ON and return an error up the chain instead of
> > simply starting a new bio as intended.  Fix this by open coding
> 
> AFAICT we've already done all the other checks in bio_add_page, so
> calling __bio_add_page directly from within the loop is ok since you've
> explicitly handled the !zone_device_pages_have_same_pgmap() case.
> 
> > bio_add_page and handling this case explicitly.  While doing so, stop
> > merging physical contiguous data that belongs to multiple folios.  While
> > this merge could lead to more efficient bio packing in some case,
> > dropping will allow to remove handling of this corner case in other
> > places and make the code more robust.
> 
> That does sound like a landmine waiting to go off...

What?  Removing the handling?


