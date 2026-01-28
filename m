Return-Path: <linux-fsdevel+bounces-75694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBF4BiWHeWnjxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:48:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B69CDBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EB6830115BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B802FF679;
	Wed, 28 Jan 2026 03:48:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38212DB7B4;
	Wed, 28 Jan 2026 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572121; cv=none; b=ou0Kh56sU/89UK/7lKmUORGF56Jo1+NmlN3hjfjqWG1Uzn33wLYZiV9QNeWPgsWrJb18T6djL4xqw+nU+M36wRc1zMu/bBOALprO+xSP9ozPHh2WjgzyQ8hfumhJ4AxpE6lsSXIS8ghrnMsronu8kY5DaQrrQq3Hf8HPdDx8ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572121; c=relaxed/simple;
	bh=YDYx/xGL3+9NOvw5JgVcU8B0T2B050prrVuE8IqGCVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqggKhKONVqQBBvMVC1pdnAhLORIkurxrBuP558JC1k/UGvohbJh7kRDJfb/Qs5najippz9aPeQXq6qiMZcAeiSkDLDZ1kFwxjvlCtyQtTCy1GU6Gf8CRvmA+8GTMA8MdZGVlToQwjDWwMPhxw6rsJBJME1F/WXPfw21mZRftOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE668227A8E; Wed, 28 Jan 2026 04:48:38 +0100 (CET)
Date: Wed, 28 Jan 2026 04:48:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
Message-ID: <20260128034838.GB31178@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-17-hch@lst.de> <20260128032817.GB2718@sol> <20260128033519.GB30830@lst.de> <20260128034405.GD2718@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034405.GD2718@sol>
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
	TAGGED_FROM(0.00)[bounces-75694-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AD1B69CDBF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:44:05PM -0800, Eric Biggers wrote:
> On Wed, Jan 28, 2026 at 04:35:19AM +0100, Christoph Hellwig wrote:
> > > Is there a reason for this function in particular to be __always_inline?
> > > fsverity_get_info() is just inline.
> > 
> > Without the __always_inline some gcc versions on sparc fail to inline it,
> > and cause a link failure due to a reference to fsverity_readahead in
> > f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)
> 
> The relevant code is:
> 
>     vi = f2fs_need_verity(inode, folio->index);              
>     if (vi)                                                  
>             fsverity_readahead(vi, folio, nr_pages); 
> 
> Where:
> 
>     f2fs_need_verity()
>         => fsverity_get_info()
>             => fsverity_active()
> 
> If fsverity_active() needs __always_inline, why don't the other two
> functions in the call chain need it?

I wish I knew.  compiler inlining decisions are a big of black magic.
If you prefer I can use __always_inline for the entire chain.


