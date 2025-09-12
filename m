Return-Path: <linux-fsdevel+bounces-61138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A71B557F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AD65C1C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D42E1F16;
	Fri, 12 Sep 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YN/uNC9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FAC2D5419
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710241; cv=none; b=bA2zLyRE45gzddSczL1oqzAsJ9HWKwUwk3EQM71q4qIivYfzm9MNWLqay5bvWjRRNz2FMPAb6bWHsvq7Svnj5nW6w+LT0wiepTK9nFyoAknIMQjdTvfNsdSBTzFYXDy9tSkFfMSGvyoE1PfHnpf5vhiiPdXymFvbHWS4ZwK24kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710241; c=relaxed/simple;
	bh=UT93DYhaX/rZG4Umm6gaKfuWCraseafx+uN7RMGsX5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+ZAvnDGbbtjtNbvf07E6RpBP04Lytbe3ycoBtITMkYRF7Ac3g6gMPwryOzQmSEeYcP/j9m5q1En+Ylw31ZmK347MaH2pks1Fz7gLag4klmNYrDGrAKSCz0AglvRiEF/l/Uu+Y+/73LMvKySTHns3u1hJQDegcOvqNmMe4Ug5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YN/uNC9O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yz4nZo0ZJb7YXkqNNS47AaIu43uI1/g+ijPlH1W7TIk=; b=YN/uNC9OMJX0S2YuLSDAjW9BED
	RsyPDu5xlhfnv324jPbF9AinQDhssLlrm4T8f8jho1CRBpCxFOdpiFDIPxQi82yoJHZBqxlcrF1d6
	45vuczDw4lDKeXF/8QYoT9UvIWWoP68LrIb8Nvsv0sMvT7+q/uOkfyOeHZfeoEBLpcD3Xy4OzbOFH
	tBAxAxOesznaC58JNJzssqv9vTXa+v/+B396nWiN3+nSoB75ufrNYmnHOBEIeBg0bgJGVW/G/bz9E
	2wpQLI+/vWo6RKPH69E+w8MdMWpgLC2Scf6NJnTW/7Wx4IX3EAztqddmADAEKOKgxw2SpEG2UUj+c
	XWfOMOcg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxAj6-00000002qOf-0mRi;
	Fri, 12 Sep 2025 20:50:36 +0000
Date: Fri, 12 Sep 2025 21:50:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: NeilBrown <neil@brown.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250912205036.GC39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV>
 <CAJfpegtesk1G-hvcUvVqjH0_gN+YCRXvLHf=H7SORdrNUOnEsQ@mail.gmail.com>
 <20250912203618.GB39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912203618.GB39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 09:36:18PM +0100, Al Viro wrote:
> On Fri, Sep 12, 2025 at 09:22:05PM +0200, Miklos Szeredi wrote:
> 
> > You are talking about the disconnected directory case?  That can't
> > happen in this call path, since it's following a normal component from
> > a parent directory, which by definition isn't disconnected.
> 
> Huh?  No, just a lookup in a different place with server giving you
> the nodeid of the directory you had in that place in dcache.
> d_splice_alias() has no choice other than "move the existing alias
> into the right place" - directory inodes *can't* have multiple
> hashed dentries, period.
> 
> > Just realized, that open_last_lookups() will bypass lookup_open() on
> > cached positive anyway, so really no point in handing that  inside
> > lookup_open().
> 
> IIRC, when the last time it came up, it was along the lines of "could
> we call ->atomic_open() for positive dentries as well?" and I think
> it had been about FUSE.

The last iteration of those threads I've seen was in October 2023; has
anything changed since then?

