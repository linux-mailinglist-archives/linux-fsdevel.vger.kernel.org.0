Return-Path: <linux-fsdevel+bounces-74705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK14FJDSb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:08:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074A4A056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63B6E70E1D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EF5428821;
	Tue, 20 Jan 2026 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNwjuBdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54779427A1A;
	Tue, 20 Jan 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930491; cv=none; b=U9ij2ztIFqC7JOLAmPRmY2ZI8G1uqIqAZ+ijqsn6ft7oXoM1Qb7ZG4aXP9KfNa6st9shS2xmFcnlBEo/CNv89jmcSdv+KWo5+xg2xibfiEdVER7KtklCv1f9JCFPlx9ipQlsVemTllf/bj7VKYI7IywbhhXzM17qdiHRZ7q9lgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930491; c=relaxed/simple;
	bh=bbwKwfsUkmuvOMgOcdbOJxj3wN5bi2yJZMEPDyyRAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anWP0IUiT0OrqaSMb+RTVEa8J+tbTQpnhxU2Tdfly1/1PPy8sm+vnwl+tuU5kvCpt5OtPR4uO73TqXDlu/JU3WRInR/0AmwxacK1ZhMXzbNd1ylZYqWTVu9/8ZbfqrSh4wSqJkTXVd7gy+lT3GV6VXIjNU1YNaCtAbP4eNTL1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNwjuBdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA559C19421;
	Tue, 20 Jan 2026 17:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768930489;
	bh=bbwKwfsUkmuvOMgOcdbOJxj3wN5bi2yJZMEPDyyRAmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNwjuBdMDLfek3/xIfvCw2Cg7Igj3Yx+mB7nJya6q5iHS+aEveDCYOpcpIXMHJVHK
	 VikR47aGfhbX4f8sXZN781IN6Tnv6H6+NrFAeRqI9eYH7dC/T6zqDKaX99VASDB7NQ
	 hYdK2YP1hL7PpEL0dc6J3+Vbg7qJK/PhxRvT0LlNYSnZ3yGcXdu4qqN69FHgjr1xR8
	 WhRvVWarLotZ+67tOStY2TysV7KIJ5HB9sNtt6pvrE5xNQ1E1VZsmmd9Ccj1uGiogm
	 aCjjn3sQDEIIYBt59WkxoUxhJcd4sNgNX1xxIYKMLWJBoVCXjJrGGORZiHCczGf23V
	 f+O6KVgEi7Peg==
Date: Tue, 20 Jan 2026 09:34:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <20260120173449.GT15551@frogsfrogsfrogs>
References: <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
 <20260119063349.GA643@lst.de>
 <20260119193242.GB13800@sol>
 <20260119195816.GA15583@frogsfrogsfrogs>
 <20260120073218.GA6757@lst.de>
 <5tse47xskuaofuworccgwhyftyymx5xj3mc6opwz7nfxa225u6@uvbk4gc2rktd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5tse47xskuaofuworccgwhyftyymx5xj3mc6opwz7nfxa225u6@uvbk4gc2rktd>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74705-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3074A4A056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 12:44:19PM +0100, Andrey Albershteyn wrote:
> On 2026-01-20 08:32:18, Christoph Hellwig wrote:
> > On Mon, Jan 19, 2026 at 11:58:16AM -0800, Darrick J. Wong wrote:
> > > > >  a) not all architectures are reasonable.  As Darrick pointed out
> > > > >     hexagon seems to support page size up to 1MiB.  While I don't know
> > > > >     if they exist in real life, powerpc supports up to 256kiB pages,
> > > > >     and I know they are used for real in various embedded settings
> > > 
> > > They *did* way back in the day, I worked with some seekrit PPC440s early
> > > in my career.  I don't know that any of them still exist, but the code
> > > is still there...
> > 
> > Sorry, I meant I don't really know how real the hexagon large page
> > sizes are.  I know about the ppcs one personally, too.
> > 
> > > > If we do need to fix this, there are a couple things we could consider
> > > > doing without changing the on-disk format in ext4 or f2fs: putting the
> > > > data in the page cache at a different offset than it exists on-disk, or
> > > > using "small" pages for EOF specifically.
> > > 
> > > I'd leave the ondisk offset as-is, but change the pagecache offset to
> > > roundup(i_size_read(), mapping_max_folio_size_supported()) just to keep
> > > file data and fsverity metadata completely separate.
> > 
> > Can we find a way to do that in common code and make ext4 and f2fs do
> > the same?
> 
> hmm I don't see what else we could do except providing common offset
> and then use it to map blocks
> 
> loff_t fsverity_metadata_offset(struct inode *inode)
> {
> 	return roundup(i_size_read(), mapping_max_folio_size_supported());
> }

Yeah, that's probably the best we can do.  Please add a comment to that
helper to state explicitly that this is the *incore* file offset of the
merkle tree if the filesystem decides to cache it in the pagecache.

--D

> -- 
> - Andrey
> 
> 

