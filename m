Return-Path: <linux-fsdevel+bounces-62524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE6B97877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039F019C6D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD182F3C07;
	Tue, 23 Sep 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ84PfSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748652FD1B1;
	Tue, 23 Sep 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660704; cv=none; b=TL29Ncslh0X9kFQiiXb/G4hXHPQDsoam7YT17umzcCF+qnzuXlJ6ezMb07D1yB/vVuOFw9M+Kr5xbj+fLrM81/HHinwCvSL/2DLMVXDW2k7KbBI8+Xvuw7jpUHbIgmVgj8fJSBwtR8BZvol9P144WCAOWsrPrmQ+agoTnjUn750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660704; c=relaxed/simple;
	bh=/QKC5gS3PU6N6KoHnQXuX32vt7Q06L57F0gWbiReTRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCLWwkux6C5gk6XgAbEZooy8brnSjnlm3Hf0K7tY9U9HzF+y6kbVljnFS4GR6rlnkzMeLEOw5ApyApCzlOX1VB0emep1jTna1ecQDnHXvOZjl21jbSbO12JRp8Z4gI2J15UpMrUQdF7Ei0KG4kWJuHNxWRwKoupuTbPc8nEwJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ84PfSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F248BC4CEF5;
	Tue, 23 Sep 2025 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758660704;
	bh=/QKC5gS3PU6N6KoHnQXuX32vt7Q06L57F0gWbiReTRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ84PfSIjYEDCZlfdD7faAPQ8QZF5pmhfikZehUr6GKw20/HBZ/+AooIhZASB9bmd
	 wHar1sZ+TDUq0GRN1zJH9NG6PxCnnPwPw9OiKG4oNxy8CgBv1+Vj2meG4+jcOXS8mh
	 5peIupxleMVwtN/YBxoqlpb6WUQ/j5QGXWMs+O+ayd2Y+EM0xmG1qU2UUcdSkY+63a
	 Sbq4V+/INmV6GXuHIW1YKNOs428R8edhnM+U3zXXe14RVVE9xgkAwLqTXC2HYxG9uS
	 XqyQsZnuEXcAC+Wgp+piSOd6gc1t0P/DZSUfC9XA95RqsrvNE4U1ESma0BvHPpCQCJ
	 gqpjhjfb+GeaA==
Date: Tue, 23 Sep 2025 13:51:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
Message-ID: <20250923205143.GH1587915@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
 <20250918165227.GX8117@frogsfrogsfrogs>
 <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
 <20250919175011.GG8117@frogsfrogsfrogs>
 <CAJfpegu3+rDDxEtre-5cFc2n=eQOYbO8sTi1+7UyTYhhyJJ4Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu3+rDDxEtre-5cFc2n=eQOYbO8sTi1+7UyTYhhyJJ4Zw@mail.gmail.com>

On Tue, Sep 23, 2025 at 04:57:30PM +0200, Miklos Szeredi wrote:
> On Fri, 19 Sept 2025 at 19:50, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > /**
> >  * fuse_attr flags
> >  *
> >  * FUSE_ATTR_SUBMOUNT: Object is a submount root
> >  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
> >  * FUSE_ATTR_IOMAP: Use iomap for this inode
> >  * FUSE_ATTR_ATOMIC: Enable untorn writes
> >  * FUSE_ATTR_SYNC: File writes are synchronous
> >  * FUSE_ATTR_IMMUTABLE: File is immutable
> >  * FUSE_ATTR_APPEND: File is append-only
> >  */
> >
> > So we still have plenty of space.
> 
> No, I was thinking of an internal flag or flags.  Exporting this to
> the server will come at some point, but not now.
> 
> So for now something like
> 
> /** FUSE inode state bits */
> enum {
> ...
>     /* Exclusive access to file, either because fs is local or have an
> exclusive "lease" on distributed fs */
>     FUSE_I_EXCLUSIVE,
> };

Oh, ok.  I can do that.  Just to be clear about what I need to do for
v6:

* fuse_conn::is_local goes away
* FUSE_I_* gains a new FUSE_I_EXCLUSIVE flag
* "local" operations check for FUSE_I_EXCLUSIVE instead of local_fs
* fuseblk filesystems always set FUSE_I_EXCLUSIVE
* iomap filesystems (when they arrive) always set FUSE_I_EXCLUSIVE

Right?

--D

> Thanks,
> Miklos
> 

