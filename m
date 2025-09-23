Return-Path: <linux-fsdevel+bounces-62519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CFFB97360
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F010F17A3B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E302A301705;
	Tue, 23 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRt43h3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D5E2D838E;
	Tue, 23 Sep 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758652458; cv=none; b=Z4HG8H73y5lZ4XO4wSeAkWAEXzOaM2k1uClxpWsE5calYXKj7QC+HDAnICZg89Z4GwnZJttRnp4wOIgy/3OsX8n1081ld0CnvK1YH6RG5phDxrC6+hea0/1dIGmAWp0n+umVXiZ88hpIXrFlWopEHfCLTu7MZ/M5/D6dWEnuxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758652458; c=relaxed/simple;
	bh=xYnQBipMi65qEiSh/mIQtqgoJkO09SWwbYjysGBw+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY2m02S/TIJlh5vwKSpztL96EBr2qziHyDc5oC5Rbq6XonFjSr/Cf0HBdSspvLWinTEgMKph4OO3T6SN2/dNjfBD3xiYQUaJLMIQeSj/MPX0gqZP4VMeDpqZQZigbSinISDo1YRz+Pkh3Ou2MFQXKRGNt0/5NDxq7zPZD23pjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRt43h3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD45EC4CEF5;
	Tue, 23 Sep 2025 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758652457;
	bh=xYnQBipMi65qEiSh/mIQtqgoJkO09SWwbYjysGBw+Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iRt43h3Du9yRwlveGENSYwFjy0+Owb56rb7DsE6ylLjFN5A2W4xAcAyoCGzBfesJh
	 oJ33V1MJPeMQG+NQJYn4pek0jnz7JihuPvszNiS28i8q6Y1MgJUL4vnzJ+dBN9rfu9
	 4nOb7wCzUx4NIfg/87HV7cO1Z4wjWNmnAVDUGsW9o9mvsuh303W4jc6+AFH8SEAUZD
	 O4li8Jz+MRJ6glbG8iKp41wdwvmNoMjK+++dag4glRyCRN2jAzImeZPtKBRv3LX5D5
	 QLvSS7GZdqlNQiCs4BCyayPozdEj7MXdbAfCb9wNaBRHmSR6nIlZP1sc0d7QrsQ6Er
	 iiR0TpFUbYzzw==
Date: Tue, 23 Sep 2025 11:34:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <20250923183417.GE1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com>
 <aLktHFhtV_4seMDN@infradead.org>
 <aLoA6nkQKGqG04pW@casper.infradead.org>
 <CAJnrk1ZxQt0RmYnoi3bcDCLn1=Zgk9uJEcFNMH59ZXV7T6c2Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZxQt0RmYnoi3bcDCLn1=Zgk9uJEcFNMH59ZXV7T6c2Fg@mail.gmail.com>

On Mon, Sep 22, 2025 at 09:49:50AM -0700, Joanne Koong wrote:
> On Thu, Sep 4, 2025 at 2:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 11:09:32PM -0700, Christoph Hellwig wrote:
> > > On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> > > > Propagate any error encountered in iomap_read_folio() back up to its
> > > > caller (otherwise a default -EIO will be passed up by
> > > > filemap_read_folio() to callers). This is standard behavior for how
> > > > other filesystems handle their ->read_folio() errors as well.
> > >
> > > Is it?  As far as I remember we, or willy in particular has been
> > > trying to kill this error return - it isn't very hepful when the
> > > actually interesting real errors only happen on async completion
> > > anyway.
> >
> > I killed the error return from ->readahead (formerly readpages).
> > By definition, nobody is interested in the error of readahead
> > since nobody asked for the data in those pages.
> >
> > I designed an error reporting mechanism a while back that allowed the
> > errno to propagate from completion context to whoever was waiting
> > on the folio(s) that were part of a read request.  I can dig that
> > patchset up again if there's interest.
> 
> Could you describe a bit how your design works?

I'm not really sure how you'd propagate specific errnos to callers, so
I'm also curious to hear about this.  The least inefficient (and most
gross) way I can think of would be to save read(ahead) errnos in the
mapping or the folio (or maybe the ifs) and have the callers access
that?

I wrote a somewhat similar thing as part of the autonomous self healing
XFS project:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=health-monitoring&id=32cade9599ad951720804379381abb68575356b6

Obviously the events bubble up to a daemon, not necessarily the caller
who's waiting on the folio.

--D

> Thanks,
> Joanne
> >
> 

