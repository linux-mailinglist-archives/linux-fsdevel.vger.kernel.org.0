Return-Path: <linux-fsdevel+bounces-20675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58878D6BE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B3328338E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 21:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9B7F7CA;
	Fri, 31 May 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIHj44PF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAFAD59;
	Fri, 31 May 2024 21:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191931; cv=none; b=FBUR8DtBDWoJmVO2FfdG/yed5IBJnCZFrUbq7N8WJUAnmjUOHK8LpaMNmPM2gBHfs0SRKp+T9mtGLh0aPAilygsjKsxCC9H2ymUeju9WmBdM32hWadoo+7cXwUPIZ2MlSNiLGMmztA8U4VVCm7pa0c3syJyiOCsqapBBv3JNGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191931; c=relaxed/simple;
	bh=HHQP+Fg1R6MOWZlS0A4+JYwt6Gcvc6gytPwUX0yRCdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1plnlsaQa7/13zk8cM1ZkPmg+VaebahOjIfRVK/1JEXztT7697iNh+lUdRJhcTPicwKLEgn5Eibtdww/gMBq77Z0sOtIdpiet6PvUq0PrkcOVziqDQasD0EQhXxueyhdltST9grmTDSUOJCSDKpTcB81ZbHeBygmVM7ffXY0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIHj44PF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AE7C116B1;
	Fri, 31 May 2024 21:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717191930;
	bh=HHQP+Fg1R6MOWZlS0A4+JYwt6Gcvc6gytPwUX0yRCdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIHj44PFphhGxBWMMvfIT/ucvmBtdDzYph7XCFPh4RlO32s5dw29DX927JT0KbRQx
	 OSMfWAlIFMQyoQ8Zr6hTuWY74jQ/EqKVV2m/+zh7Na/qcVbBP3GKTAb596LuAvI/+d
	 aflLHDzmyiTI8G9QKZgfc1v0/SWTLHss8Eu09+DcRDKGqe44WA0jYVFpg9WmR5ezBa
	 lpQoaZ+hq/gUFDvnTkk+rfHOtxapX1TxIa6354PUiUrlQhFYo5fg5cHjCCiZrk7HQi
	 ZoHk4pR0iE7Z5hk367iGwosGDoVvSvLRRIiWbEKAFW3im6TvxEMW6+Is9C5hwDDTlf
	 XdTr7ZWKn/TIQ==
Date: Fri, 31 May 2024 21:45:29 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240531214529.GC2838215@google.com>
References: <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
 <20240517171720.GA360919@frogsfrogsfrogs>
 <ZktEn5KOZTiy42c8@infradead.org>
 <20240520160259.GA25546@frogsfrogsfrogs>
 <Zk4DIzXJX_gVoj2-@infradead.org>
 <20240522182900.GB1789@sol.localdomain>
 <20240531212850.GU52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531212850.GU52987@frogsfrogsfrogs>

On Fri, May 31, 2024 at 02:28:50PM -0700, Darrick J. Wong wrote:
> On Wed, May 22, 2024 at 11:29:00AM -0700, Eric Biggers wrote:
> > On Wed, May 22, 2024 at 07:37:23AM -0700, Christoph Hellwig wrote:
> > > On Mon, May 20, 2024 at 09:02:59AM -0700, Darrick J. Wong wrote:
> > > > On Mon, May 20, 2024 at 05:39:59AM -0700, Christoph Hellwig wrote:
> > > > > On Fri, May 17, 2024 at 10:17:20AM -0700, Darrick J. Wong wrote:
> > > > > > >   Note that the verity metadata *must* be encrypted when the file is,
> > > > > > >   since it contains hashes of the plaintext data.
> > > > > > 
> > > > > > Refresh my memory of fscrypt -- does it encrypt directory names, xattr
> > > > > > names, and xattr values too?  Or does it only do that to file data?
> > > > > 
> > > > > It does encrypt the file names in the directories, but nothing in
> > > > > xattrs as far as I can tell.
> > > > 
> > > > Do we want that for user.* attrs?  That seems like quite an omission.
> > > 
> > > I'll let Eric answer that.  Btw, is the threat model for fscrypt written
> > > down somewhere?
> > 
> > See https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html?highlight=fscrypt#threat-model
> > 
> > As for why it stopped at file contents and names (and fsverity Merkle tree
> > blocks which ext4 and f2fs encrypt in the same way as contents), it's just
> > because it's very difficult to add more, and file contents and names alone were
> > enough for parity with most other file-level encryption systems.  That's just
> > the nature of file-level encryption.  For each additional type of data or
> > metadata that's encrypted, there are a huge number of things that need to be
> > resolved including algorithm selection, key derivation, IV selection, on-disk
> > format, padding, UAPI for enabling the feature, userspace tool support including
> > fsck and debugging tools, access semantics without the key, etc...
> > 
> > xattr encryption is definitely something that people have thought about, and it
> > probably would be the next thing to consider after the existing contents and
> > names.  Encrypting the exact file sizes is also something to consider.  But it's
> > not something that someone has volunteered to do all the work for (yet).  If you
> > restricted it to the contents of user xattrs only (not other xattrs, and not
> > xattr names), it would be more feasible than trying to encrypt the names and
> > values of all xattrs, though it would still be difficult.
> > 
> > Of course, generally speaking, when adding fscrypt support to a filesystem, it's
> > going to be much easier to just target the existing feature set, and not try to
> > include new, unproven features too.  (FWIW, this also applies to fsverity.)  If
> > someone is interested in taking on an experimental project add xattr encryption
> > support, I'd be glad to try to provide guidance, but it probably should be
> > separated out from adding fscrypt support in the first place.
> 
> Does the fscrypt data unit size have to match i_blocksize?  Or the
> fsverity merkle tree block size?

The crypto data unit size is a power of 2 less than or equal to i_blocksize
(usually equal to it, as that is the default).  See
https://www.kernel.org/doc/html/latest/filesystems/fscrypt.html#contents-encryption

It applies to contents encryption only, though as you know, ext4 and f2fs treat
the Merkle tree in mostly the same way as contents, including for encryption.
For an implementation of fsverity that doesn't treat the Merkle tree as contents
like this, and where the filesystem supports fscrypt too, encryption of the
Merkle tree would need to be implemented a bit differently.  It wouldn't need to
use the same crypto data unit size as the contents, e.g. it could be always one
data unit per Merkle tree block.

- Eric

