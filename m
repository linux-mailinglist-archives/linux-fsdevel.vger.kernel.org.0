Return-Path: <linux-fsdevel+bounces-75526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP2oBaTKd2lylAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:12:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C84438CED2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B11633025A4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC592C08D9;
	Mon, 26 Jan 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3K3AwRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5112C027C;
	Mon, 26 Jan 2026 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458328; cv=none; b=i79V/FBxa9FJMijdix4gURmZrbDg+CP/HytoWTvIx07No5+N+pJn02AsUQQ31/teX1NTP+zfZRYG9bcpLK9XMm5u4Z2tT4GDPv8r0AkDSB5A+A4WxGAa10AJg472UQ06DD4YPNpinVvdaeVkftG7U5zhJ4J+lhiydV7fBsTpb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458328; c=relaxed/simple;
	bh=NBe+OxYRigsrCScWNRGhoFuPEsSz3lykHJTIWDbyMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUeFvyPqwIj7MkFwY4LHp/BYsTYlewRh72QM+1z2V4uHM1Hh/eRV0lSekiaMGcU00WfOn2hsVeYwLg2HI+r48EGtTbGj2ctAlZDAB9SZE70lyFRQ9cDfOM6jRjNndJQweGo4U8KZWnFluyezWNuFdkteG+XDfHNcGZgqP8x57m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3K3AwRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26AEC116C6;
	Mon, 26 Jan 2026 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769458328;
	bh=NBe+OxYRigsrCScWNRGhoFuPEsSz3lykHJTIWDbyMDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3K3AwRdtBqGRu/L0NVC2m/GP0oeFUwZGfM5GvznVm9SC4gLQ0Q/wUEhnJgCtVJ6/
	 3hBgOYdjlX4u9PUZ0AVnNlNqsADYsiji5c7ZCYbDF3dPITcbpj0MWR24shiGQ+aZyN
	 qhBUxH2vAzOy0Q+hW8/87TrJC5oOxviszzzyQi+o7HiwPKy0ODSW/eeG+xVqNQNFPG
	 aCd3Tr+fuP0vTljmBoLEVDvqhaqRvXutNBbYDiGg3XmuUxeCLfYatg3u21MkYa6tET
	 4+2gllNik8k0IpeNxNVqiGa88nvSll2D2FKnPiS0Mz94gEdfhKUxrVNYxjgAXP6E/N
	 Wg+2yKtJ8gj+A==
Date: Mon, 26 Jan 2026 12:12:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260126201206.GA30838@quark>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
 <20260125013104.GA2255@sol>
 <aXaPph6Yi-hzf0J-@casper.infradead.org>
 <20260126044432.GE30803@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126044432.GE30803@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75526-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C84438CED2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:44:32AM +0100, Christoph Hellwig wrote:
> On Sun, Jan 25, 2026 at 09:48:22PM +0000, Matthew Wilcox wrote:
> > Is there a reason not to do as DAX did:
> 
> > +#ifdef CONFIG_FS_VERITY
> >  #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
> > +#else
> > +#define S_VERITY       0         /* Make all the verity checks disappear */
> > +#endif
> >  #define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
> >  #define S_ANON_INODE   (1 << 19) /* Inode is an anonymous inode */
> > 
> > 
> > and then we can drop the CONFIG_FS_VERITY check here and in (at leaast)
> > three other places
> 
> I looked into this, but wasn't entirely sure about all callers.  Also
> in at least some places we might need the barrier in fsverity_active,
> so my plan was to see how many of the checks should simply be converted
> to fsverity_active in a follow on and how much is left after that first.

When CONFIG_FS_VERITY=n, there can still be inodes that have fsverity
enabled, since they might have already been present on the filesystem.
The S_VERITY flag and the corresponding IS_VERITY() macro are being used
to identify such inodes and handle them appropriately.  

Consider fsverity_file_open() for example:

static inline int fsverity_file_open(struct inode *inode, struct file *filp)
{
	if (IS_VERITY(inode))
		return __fsverity_file_open(inode, filp);
	return 0;
}

When CONFIG_FS_VERITY=n, __fsverity_file_open() resolves to the stub:

static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
{
	return -EOPNOTSUPP;
}

So the result is that on a kernel that doesn't have fsverity support
enabled, trying to open an fsverity file fails with EOPNOTSUPP.

But this relies on IS_VERITY() still working correctly.

Similar code that relies on IS_VERITY() working correctly exists in
other places as well, for example in the implementation of statx().

So IS_VERITY() can't be changed to always return false when
CONFIG_FS_VERITY=n, unless we identified all the callers like these and
updated them to check the underlying filesystem-specific flag instead.

- Eric

