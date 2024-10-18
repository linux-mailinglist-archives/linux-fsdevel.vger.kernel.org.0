Return-Path: <linux-fsdevel+bounces-32293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F39A3420
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7167C1C216F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 05:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592017B50B;
	Fri, 18 Oct 2024 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Qy22qGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3451514CC;
	Fri, 18 Oct 2024 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228727; cv=none; b=nNMBSMvCtTuRDqca6a8B7G0eGCbIMGKiM4Yechz8Gc36iQbroOtq13csVzvQ20DVM/m64doMRdiFowYyXlRZNrPpfI0nwP0A97kFEhZ4jrQt88gLiDTee5knwOOnpdmrSEZBIkp+S9xiIsgxP/wIrvRb3S7lVAYiQWcTodrLG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228727; c=relaxed/simple;
	bh=Cl1eVcdvEBGCDIeFom/zNrxx/WDnDDyKiVianxM7W6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACGhR36Xc2D+tnTK3YOdI0KeWB8nRRb5oxEl7LFk27CIDSdGORFy7OW/BpQ2oH20hAwMxs1lbVhEd2/pWXPvPXisxy4roy4k92RN2cowumxE6TOvYvsOqYUBO5csTaqST4hUaMWtKDI/FP6J7BzljIQNxoTIMld0UOVAzQwYpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3Qy22qGN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ZSmUXD9HJeH6SUwnNZzVXD7QLf9sIXyABH54O7yWQQ=; b=3Qy22qGNf6UBI+f5AsWzDFn6zX
	D2WAJnTJKurst6NbdPfwliqRqsVkUq5f0cca/iukd4EUI4HGfTCzR+5UB1VyBATaqd7kfDld8h2z3
	ZaJIIDqQhe7amxT2lGg8I46RPkQI2lXXrLxDimCKQgsQCygLG80wv9X2S+ozG9O+4NqPhrw29QLc9
	bo9c29PEMKE0OBbQNIZqv/IWm+Pqqkv3/yz1De6FQU/egJVcPZ85N1oh+bgH5wbRZwKiIZl/NYGje
	0FLVUApssPEBtNikKg80iDF/AVLkyxn29ISTMT6j41wLVogabryHWwXS6f8YE/cO/W/sHqxOgP/IY
	VkG0vGYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fNr-0000000Gwy5-3EgA;
	Fri, 18 Oct 2024 05:18:43 +0000
Date: Thu, 17 Oct 2024 22:18:43 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"paul@paul-moore.com" <paul@paul-moore.com>,
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <ZxHvs652LwSypyIL@infradead.org>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <5a5cfe8cb8155c2bb91780cc75816751213e28d7.camel@kernel.org>
 <8d9ebbb8201c642bd06818a1ca1051c5b1077aea.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9ebbb8201c642bd06818a1ca1051c5b1077aea.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 17, 2024 at 05:09:17PM +0000, Trond Myklebust wrote:
> > It'd be better to stop with these sort of hacks and just fix this the
> > right way once and for all, by making i_ino 64 bits everywhere.
> 
> Nope.
> 
> That won't fix glibc, which is the main problem NFS has to work around.

There's no Problem in glibc here, it's mostly the Linux syscall layer
being stupid for the 32-bit non-LFS interface.

That being said with my XFS hat on we've not really had issue with
32-bit non-LFS code for a long time.  Not saying it doesn't exist,
but it's probably limited to retro computing by now.  The way we
support it is with the inode32 option that never allocates larger
inode numbers.  I think something similar should work for NFS where
an option is required for the ino mangling.


