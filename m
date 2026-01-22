Return-Path: <linux-fsdevel+bounces-74977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKExNVO9cWkmLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:01:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A962224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FA30504CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2C34D391;
	Thu, 22 Jan 2026 06:01:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A803346BB;
	Thu, 22 Jan 2026 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769061679; cv=none; b=ihjAjWdp1vO1PZZikwsLw5+8Bl3sGThdaHq75wJe3u8qSW07CXEH+MO2KbpD0jMdot88xKouvMcvIgeQbjW04+CbH9sO8Wkuh8qkAgh2bGtFfTOLLcCI8O7nldME6Xr6ZfS9J/0uc9EjPInhU+bAmrP0ePfJweK+kyBGJdd30iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769061679; c=relaxed/simple;
	bh=5gyp324L+eemR9mmccTPng8VqzG5D5J69adD9YIdKdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/93MnKeE6Fb+lVxsIqE3C2/ivILCyhF7OPIPSV+P4XFOQ4XJOlnfFPViBSuFhWrLElhfkMab9WMZXFgwkcyjEZYX38joKTctkv9VkdwgUhWevh49VC8FmITUOI2/d/5WUTdX+74ujjUiR8qDbAOyXJwsANY/mf0aQY+L9rL29M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41570227AA8; Thu, 22 Jan 2026 07:01:15 +0100 (CET)
Date: Thu, 22 Jan 2026 07:01:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/15] iomap: allow file systems to hook into buffered
 read bio submission
Message-ID: <20260122060114.GB24006@lst.de>
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-12-hch@lst.de> <20260122004933.GO5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122004933.GO5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-74977-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,lst.de:mid]
X-Rspamd-Queue-Id: B82A962224
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 04:49:33PM -0800, Darrick J. Wong wrote:
> > verifying data checksums.  Allow file systems to hook into submission
> > of the bio to allow for this processing by replacing the direct
> > submit_bio call in iomap_read_alloc_bio with a call into ->submit_read
> > and exporting iomap_read_alloc_bio.  Also add a new field to
> > struct iomap_read_folio_ctx to track the file logic offset of the current
> > read context.
> 
> Basically you're enabling filesystems to know what's the offset of a
> read bio that iomap is about to start?

Yes.

> I guess that enables btrfs to
> stash that info somewhere so that when the bio completes, it can go look
> up the checksum or something, and compare?

Yes, where something in this series is the ioend that the bio is embedded
into.

> Or for PI the filesystem can do the PI validation itself and if that
> fails, decide if it's going to do something evil like ask another
> replica to try reading the information?

Yeah.  If your file system can do it.  Nothing in this series does
that, though.


