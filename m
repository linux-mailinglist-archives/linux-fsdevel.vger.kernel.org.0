Return-Path: <linux-fsdevel+bounces-75399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kETAFUvtdmmPYwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:27:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876083E21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 05:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B703008766
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 04:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28530AAD4;
	Mon, 26 Jan 2026 04:27:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6558248B;
	Mon, 26 Jan 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769401659; cv=none; b=OMrVwpDpFmtAD+xZSamugpWkC0bcPwKByTQii4uYSGilVBbA/dV7CLOaqrEJekXcCp3VK2OjBEFgAOPBQgGpoPgQ2d2ot5+y9+1P5HATSoblqjtXS3far5bAmk70o2F113MinxIbM7gFISYLadKLHCvRKa9GlwKsqa+wifLtYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769401659; c=relaxed/simple;
	bh=AKjb1ReuQh11kWYO1exSMJ+pOg7SYRVbkRVhxcjnin4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNsYwcXSCqagfyKwe5lkALmA4TPuxNbG8ZvQW32ZgktOj9K6WhUcIkDXrec4tQqsmdrhNLjfPLqU/cv5V8ODEBXk07pB0Kl7sIqk5+XqkBDRT+ALR2zgVu8vp/pYbkr+ftCdp9Uw837HsOAmAzMG/i6GE8ySFuGXYqYEn0eiefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57D11227A88; Mon, 26 Jan 2026 05:27:27 +0100 (CET)
Date: Mon, 26 Jan 2026 05:27:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <20260126042726.GA30803@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-5-hch@lst.de> <20260124192747.GD2762@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124192747.GD2762@quark>
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75399-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 2876083E21
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 11:27:47AM -0800, Eric Biggers wrote:
> On Thu, Jan 22, 2026 at 09:22:00AM +0100, Christoph Hellwig wrote:
> >  fs/ext4/verity.c         | 17 +----------------
> >  fs/f2fs/verity.c         | 17 +----------------
> >  fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/fsverity.h |  3 +++
> >  4 files changed, 43 insertions(+), 32 deletions(-)
> 
> This creates a bisection hazard: the new file fs/verity/pagecache.c
> isn't added to fs/verity/Makefile until the next commit.

Fixed, that was of course not intentional :)

Still surprised the build bot didn't complain about it.

