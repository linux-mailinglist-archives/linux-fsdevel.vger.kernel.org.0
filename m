Return-Path: <linux-fsdevel+bounces-61137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194DCB557AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 22:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D015F176493
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88B5279DB7;
	Fri, 12 Sep 2025 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NCtYJM9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7262DC76D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709385; cv=none; b=OYOhVzIpq6DY5w/Iyx0oTSTqU7ULpDU4sXRDNHDq6NA8+VW8XWdlntSmHdUYwIurZUrVHeJcg0B5m3171moKfobPmI1uqplWNqoC3/nJFcwoWZ+RDDrq8TdPsItK2VDNJkmv5JchvFncLej2PIuPQ4QC9pYYhDBq+jnyuSm8fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709385; c=relaxed/simple;
	bh=vYfDjHWEcNnd2h+Brr59BZ9JkrWsACaLm+3s+YHkT+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkb+7AzsKmZ4uIa0Oj/6bDvlWBPzK0qb9NsFYt+zzhjskbl643WREDUNuR0Xx36GgG4ApjHAOtreORJsDrLXV7A9PT+1ovLfH7GQizsn/eR/TEKhZYYCTFjtHLJ9i/6KYi/QnMrI18J0r+mw6T1rmF6ZfIJY51Tt17BDzrbQF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NCtYJM9R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SdTdacqB5dsZuGVeeICErfAkiBWsDRh1v8yQdMZSmeQ=; b=NCtYJM9Ru4IHH/yNrkwFx76VqR
	5A43mZSImoTxuRqnVgtMMOwPVIppj1sAI/Mhkg77K0QWQhYFias1mkBwhH4ctk6r+/bbqJHgX2Cme
	HUe36PK2eWMkl3uoWqGX8bB14eMIQpBeWBt4pxX1UsI2HbLjwitlxj2KJVkJ8VnpSGDjjS06k0rFZ
	F37OLz4ErOQcBHgQxKUZ6CFUun+HmMq1P3FuQVBzQBT+T7RvdNAfCeVlA4UC58SGVqENm5B5Q/D+L
	49djUxpA+RsrAc3Rc4ioCKCNuFTxMBqO0gjZn8tZr+haiy+l9FteO0Jk1M0HYKi7KfcArdpbi0r0i
	mJq8ygWA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxAVG-00000002jcv-493d;
	Fri, 12 Sep 2025 20:36:19 +0000
Date: Fri, 12 Sep 2025 21:36:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: NeilBrown <neil@brown.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250912203618.GB39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV>
 <CAJfpegtesk1G-hvcUvVqjH0_gN+YCRXvLHf=H7SORdrNUOnEsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtesk1G-hvcUvVqjH0_gN+YCRXvLHf=H7SORdrNUOnEsQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 09:22:05PM +0200, Miklos Szeredi wrote:

> You are talking about the disconnected directory case?  That can't
> happen in this call path, since it's following a normal component from
> a parent directory, which by definition isn't disconnected.

Huh?  No, just a lookup in a different place with server giving you
the nodeid of the directory you had in that place in dcache.
d_splice_alias() has no choice other than "move the existing alias
into the right place" - directory inodes *can't* have multiple
hashed dentries, period.

> Just realized, that open_last_lookups() will bypass lookup_open() on
> cached positive anyway, so really no point in handing that  inside
> lookup_open().

IIRC, when the last time it came up, it was along the lines of "could
we call ->atomic_open() for positive dentries as well?" and I think
it had been about FUSE.

