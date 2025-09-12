Return-Path: <linux-fsdevel+bounces-61122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C15B55627
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C10B1666BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CF32ED21;
	Fri, 12 Sep 2025 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TlLzy7wC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A47271450
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701783; cv=none; b=pvTkrxXXHwoN1sm5DFoEmozmso1S82ZkZiNox4zUezUfZ01lbkoI5oE8N2EA+cmekEZAgDRJ4c86FWvgIvVgT+xQypsXTIIsQ3SpIPMz8rHr3up66fkdwVC97Xcj2sYf9RUSz8Zqo1ri8fQ8gRw7+6jwXacUjsW8jINgvd2GiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701783; c=relaxed/simple;
	bh=38gJMIzgFmmdsAl726NOzal13bLeeZSNQ5KpGqKwfFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuBTA31YD5jyBKh7JNTdb8qo5DmaEKn0s20wbvTnzOA4SGJKPxADfj/U0zWEYIRdyY/DUKJIRXYz3gC6t5fYFnm0ziFla3ixYo7xWd27EcHo/qrNA/bE6ASaYZRpt903/iuLDdryFeQFmixw5zzZePQVAIL95mWXs1DVGPgpUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TlLzy7wC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OvSFZwjtYJmJKA1S4ZwhP6UaxaMk27+HWb0pDxxLkpU=; b=TlLzy7wCpQ7dKMgvy+XqdwXMks
	/Xm22ymfZdcCQtmBBASVO9aM8lJsYjgFJoThMPSG74HsdVEnwX5e5fg+pMTWI2/AIaNn1LHv1J/U8
	7ebDKgybYCx+mG4utXgJ7yqDe8Z+e3A1VdOL9zqJ0VFTXxFpRd2Y6s6WFMKooWWUsAU7g6YKMo3j6
	HLpAVSS2xAPbZMZmo6alZ0vwCfNLl1xE7ddXGefbUVszuRwS3fk92u3h+nNgyRViBSgtZjmawf9at
	KOVNtv3xR5ug5GrskxCwI0Hz0/0+T/Tg95CZ6DN23HE+rZPmAsMl81HB+G7OJJFv4PRS5xDzYbv2t
	TzR/He1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8We-00000001NvJ-1Y3Q;
	Fri, 12 Sep 2025 18:29:36 +0000
Date: Fri, 12 Sep 2025 19:29:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: NeilBrown <neil@brown.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250912182936.GY39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 10:23:39AM +0200, Miklos Szeredi wrote:
> On Fri, 12 Sept 2025 at 07:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > While we are at it, Miklos mentioned some plans for changing ->atomic_open()
> > calling conventions.  Might be a good time to revisit that...  Miklos,
> > could you give a braindump on those plans?
> 
> [Cc: Bernd]
> 
> What we want is ->atomic_open() being able to do an atomic revalidate
> + open (cached positive) case.  This is the only case currently that
> can't be done with a single ATOMIC_OPEN request but needs two
> roundtrips to the server.
> 
> The ->atomic_open() interface shouldn't need any changes, since it's
> already allowed to use a different dentry from the supplied one.
> 
> Based on (flags & LOOKUP_OPEN) ->revalidate() needs to tell the caller
> that it's expecting the subsequent ->atomic_open() call to do the
> actual revalidation.  The proposed interface for that was to add a
> D_REVALIDATE_ATOMIC =  2 constant to use as a return value in this
> case.

	Umm...	Unless I'm misunderstanding you, that *would* change the
calling conventions - dentry could bloody well be positive, couldn't it?
And that changes quite a bit - without O_CREAT in flags you could get
parent locked only shared and pass a positive hashed dentry attached
to a directory inode to ->atomic_open().  The thing is, in that case it
can be moved by d_splice_alias()...

	Or am I misreading you?

