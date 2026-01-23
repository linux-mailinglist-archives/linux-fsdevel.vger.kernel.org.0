Return-Path: <linux-fsdevel+bounces-75233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bs9GKQjc2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:30:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9171BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A99A6300752D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E812E7F1C;
	Fri, 23 Jan 2026 07:30:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A21ACED5;
	Fri, 23 Jan 2026 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153438; cv=none; b=D3grlFfVU63Jy8ZPosWWBp6GNC3V1Wco/vpu95eg/XOiLvP5lr2xKync3sTm1CK0OGxUDvsapROtR/ujwCNGis0STvR85NK6l38Av2Q594FrJebCk63OZ+CB7braQgqrdm0Wey9N+q/tFYVLfwqG6tR1N1ABKtdd/IyAxEXjw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153438; c=relaxed/simple;
	bh=7cs8KTtnIn7YUHI145cRhMX4l5zAigUfI//KElxOWLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjDb1b5sbO6eX0Kr3ISpu15jPeai3fIS4d5Ma8xTA4kvaDqF+HUb5Sr34E2SlayiEhGcFsXM+M0RBN3Ts8QirtXE/jLs89Nm5HJtIpfzoui+/CYI2QPG7TNfBQR7upcn4cTrOCC9tCtP9VJ7UgJ13ehUJi6xjXgCK9t3TvxJZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93D62227AAE; Fri, 23 Jan 2026 08:30:25 +0100 (CET)
Date: Fri, 23 Jan 2026 08:30:24 +0100
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
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the
 fsverity_info
Message-ID: <20260123073024.GA27731@lst.de>
References: <20260122082214.452153-1-hch@lst.de> <20260122082214.452153-12-hch@lst.de> <20260122220420.GI5910@frogsfrogsfrogs> <20260123052723.GE24123@lst.de> <20260123072700.GN5910@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123072700.GN5910@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75233-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0CE9171BB5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:27:00PM -0800, Darrick J. Wong wrote:
> > rhashtable_lookup_fast returns the struct containing the rhash_head.
> > The paramters store the rhead_offset for that purpose.  See rht_obj
> > as used by rhashtable_lookup.
> 
> Ahah.  That's right, but (imo) a weird quirk of the rhashtable
> interface.  Though I only say that because *I* keep tripping over that;
> maybe everyone else is ok.

I don't think it's a quirk.  It seems like an explicit design decision.
Not one I would have taken as I think doing a container_of in the caller
would be cleaner, but it is what it is.


