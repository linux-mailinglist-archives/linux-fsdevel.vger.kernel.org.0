Return-Path: <linux-fsdevel+bounces-75230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PdaBlUic2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:25:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE6271AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38D743021992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C70F35DCEA;
	Fri, 23 Jan 2026 07:24:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5233D4FA;
	Fri, 23 Jan 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153079; cv=none; b=IQEqnLqtqf9iaYCTTpOSho3labv+poarASsVSZTxxr0EUjZN+TgJ0O4ukFjXIvcdkt12t5yoj0BIoWwAoZtkKVhdgHBWoXSWoDdgmY4gZthkbc4V/iGXnezTtCnDVPiq+XH4DVRQ94aZgttMKazDlpnrV/FMZKKmJFUF1hdD3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153079; c=relaxed/simple;
	bh=Tdc9xwIa7aB3BlCpIOjUKl9IwWx6UPKNoW05Ii8kmec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw+wfACKWzc3IT77qat361gLZ8AkVZetX/CpLU3qTaYe4G4MsKBOIp1dlILSTdwa+rD+eFgZthR2rAkeiEjcYNySq7ehiOEY9ODBB+rI4aep257qAzcffEQOO+Tk/qY/FV6ESzPKvWsrcr3kGiAoqHsfEFQffGGOAC5bsYG34BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06C25227AAE; Fri, 23 Jan 2026 08:24:34 +0100 (CET)
Date: Fri, 23 Jan 2026 08:24:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 07/11] fs: consolidate fsverity_info lookup in buffer.c
Message-ID: <20260123072433.GA27421@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-8-hch@lst.de> <20260122214958.GG5910@frogsfrogsfrogs> <20260123051556.GC24123@lst.de> <20260123072329.GL5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123072329.GL5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75230-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 7CE6271AEF
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:23:29PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 23, 2026 at 06:15:56AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 22, 2026 at 01:49:58PM -0800, Darrick J. Wong wrote:
> > > Well this is no longer a weird ext4ism, since f2fs also needs this,
> > > right?  Maybe this comment should read:
> > 
> > f2fs doesn't use buffer heads.  So this is just because ext4 only
> > implements the easy parts of ->read_folio and ->readahead itself and
> > falls back onto the generic code for the rest, which then had to be
> > grow hacky ext4-specific bits like this for it :(
> 
> Yikes.  So I guess we shouldn't genericise the comment to encourage more
> people to do the same thing ext4 did?

I don't think so.  I actually need to send a ping to the ext4 folks
that maybe, maybe they really should handle all reads into the page
cache in their own code so that we can hopefully kill this entirely.


