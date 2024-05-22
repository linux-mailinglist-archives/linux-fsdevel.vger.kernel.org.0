Return-Path: <linux-fsdevel+bounces-20001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1358CC354
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982E2281886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274C17C95;
	Wed, 22 May 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pIEJ0Wpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65E17550;
	Wed, 22 May 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388647; cv=none; b=Qtp+NRRFjp6WFBcy3IC9pBBzKPGqhdA0E8wcpZArO07707LGP8MmxyBbTC6eG6ysRWmm2HS0LpNwlVmh1EHRadcw87zOzmstVrcVVXKPUNUPNzrhz79AK/bQd7xVL1RgaBjzBdMNzMYbhUQmWI7DdUmI9hkcbOBM/6Mdm/XcUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388647; c=relaxed/simple;
	bh=hxmhP567s4dSC9jpCW+zdbc4PJzsQqx6YlXvRACd2is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvBh2FrSN1lAcLCCill1tZp02ZFLwISaV9ccCHKVslw+BhReywdYHfgTkO6fuClmn7MWxgrLVp2D9oEaQUmVkK8kDqBui+Hbl5D9lgglV9HeK728LmzHINHZOB+kWVdCkk0GHnE36ZOXjZUwAE6cSXV8fAMt1vT3MNC2LdSKRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pIEJ0Wpi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I8E1hYnWG4Q3QnCoU6Xf7Jd0qzrKBRB6EdoIRleFSv8=; b=pIEJ0WpiPen6MsG0bCFP7QKQfi
	1jyJCsEWaTO0vqdgEVHEDEYA5cdYX0mqfEuG7vivgDpcFYEfp0aU7EZEcjv/bgH0CVozHq0y9bV8h
	Y4HCuGVuJzjsWBsgZLf+0VH1jhi8V/ykqSUm9BssvrmWWJDne2hgWYb56UUqhE0HwLtphv1CS05y4
	okWbseLm13A8IZi6nK1xu2VE1UgXnighmjqOW9EJHG623gjjX13jmQvKqYlzZ9oXVQiFj42hsokdD
	hsacBYeoJ2LyOI23NP4ippDnfNCxRNrwPWiDfal92qwbc+raAu80aoa/B4Yy2KGLry+6AfW8VBcT9
	fpY86kMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9n5n-00000003EKQ-39ku;
	Wed, 22 May 2024 14:37:23 +0000
Date: Wed, 22 May 2024 07:37:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <Zk4DIzXJX_gVoj2-@infradead.org>
References: <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
 <20240517171720.GA360919@frogsfrogsfrogs>
 <ZktEn5KOZTiy42c8@infradead.org>
 <20240520160259.GA25546@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520160259.GA25546@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 20, 2024 at 09:02:59AM -0700, Darrick J. Wong wrote:
> On Mon, May 20, 2024 at 05:39:59AM -0700, Christoph Hellwig wrote:
> > On Fri, May 17, 2024 at 10:17:20AM -0700, Darrick J. Wong wrote:
> > > >   Note that the verity metadata *must* be encrypted when the file is,
> > > >   since it contains hashes of the plaintext data.
> > > 
> > > Refresh my memory of fscrypt -- does it encrypt directory names, xattr
> > > names, and xattr values too?  Or does it only do that to file data?
> > 
> > It does encrypt the file names in the directories, but nothing in
> > xattrs as far as I can tell.
> 
> Do we want that for user.* attrs?  That seems like quite an omission.

I'll let Eric answer that.  Btw, is the threat model for fscrypt written
down somewhere?

> > > And if we copy the ext4 method of putting the merkle data after eof and
> > > loading it into the pagecache, how much of the generic fs/verity cleanup
> > > patches do we really need?
> > 
> > We shouldn't need anything.  A bunch of cleanup
> 
> Should we do the read/drop_merkle_tree_block cleanup anyway?

To me the block based interface seems a lot cleaner, but Eric has some
reservations due to the added indirect call on the drop side.

> One of the advantages of xfs caching merkle tree blocks ourselves
> is that we neither extend the usage of PageChecked when merkle blocksize
> == pagesize nor become subject to the 1-million merkle block limit when
> merkle blocksize < pagesize.  There's a tripping hazard if you mount a 4k
> merkle block filesystem on a computer with 64k pages -- now you can't
> open 6T verity files.
> 
> That said, it also sounds dumb to maintain a separate index for
> pagecache pages to track a single bit.

Yeah.  As I mentioned earlier I think fsverify really should enforce
a size limit.  Right now it will simply run out space eventually which
doesn't seem like a nice failure mode.

> Maybe we should port verity to
> use xbitmap64 from xfs instead of single static buffer?

The seems like a bit of overkill for the current use cases.


