Return-Path: <linux-fsdevel+bounces-75451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPhBMedVd2nMeAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:54:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B387DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F0643053679
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE133374A;
	Mon, 26 Jan 2026 11:49:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFE3314B9;
	Mon, 26 Jan 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428166; cv=none; b=rW2RXU6W+aHmFG9u65kHuDB4SPtL37tzjU82Rhdr8IIxQjHQnreGUBxfBbmdOGlxwpvhUCoUqKejKZ62cA/6wg0cKV/sH5qhUZ1Ab2HZC0Wip/s0YhUC6nJ8o4Ep7lH3cT+sz6QvP71K6cB7PHefkexCTGnr5yTBgTvw1UNReuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428166; c=relaxed/simple;
	bh=+6yDB44WLT2wxWGFozgz1t46XALOOvrPkLAvGhdLOlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1CyajYrQyOJcTJo135gh2PPUPngQHaF9AAjyTQHlqtptwUNKW1/s+rzl0dAANL/jeiXQ6tKQClGq964c7oJsCf99z2Fzb71+NDzxJc6dsRsQWL3VQhXYZjpLrpvw/2QGXAwliPzDo6t+YH8zuIzyBlXBZlc6mtfil8NgU7k/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28070227A88; Mon, 26 Jan 2026 12:49:22 +0100 (CET)
Date: Mon, 26 Jan 2026 12:49:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 11/15] iomap: free the bio before completing the dio
Message-ID: <20260126114921.GA23923@lst.de>
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-12-hch@lst.de> <3360b495-b66d-40af-9274-bdb614455f6d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3360b495-b66d-40af-9274-bdb614455f6d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75451-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7C7B387DE9
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 03:22:41PM +0900, Damien Le Moal wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Repeated tag...
> 
> Looks good to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> (which I think I already sent :))

I guess I messed up and pasted Darricks' review again instead of yours,
sorry.


