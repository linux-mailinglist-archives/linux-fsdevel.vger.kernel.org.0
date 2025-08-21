Return-Path: <linux-fsdevel+bounces-58621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D330B2FFCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 18:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F48A21129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A792D9EC8;
	Thu, 21 Aug 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIgHjl7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E452D8371
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792911; cv=none; b=Xj8vdLBo2QDslW0PSV2RrMFHfI9V2ewFwDJ7wGK5l6Dh2+Ku2nJDCTXqzG/56NsMknowhL9bQJTbit+cUXZ9Qj0UPfHh6e56XfVXfwOwlzA4alkwpvUS9+HYo1pkOIvAEIwE3Jh0KGG2UuxtXW9teNOF/ZNVzm6g6TTn+eGhsZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792911; c=relaxed/simple;
	bh=cf6/14jAuVNqOyJRLc85+//Ot75g0EjlTIbfmxleAbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGxL/nluJDjbEP0V5DBAh1OIc62djzhpYVm1KoutG3brrfBaC+dkVTi3LS5/daMVuA7ZcnONgMTOOqnw3zi2KAOA/gnSgOGi786prpIFWxNVZV5YdtJ2ss93Ba3acYA8LuhcQ/t2gWdO7OtEAD1gQNyCKRRZThCOyDRrpfqNQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIgHjl7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D869C4CEEB;
	Thu, 21 Aug 2025 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792911;
	bh=cf6/14jAuVNqOyJRLc85+//Ot75g0EjlTIbfmxleAbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIgHjl7zyv/e0w9PytTFHEJSoagEYlu5F3QIJjkM7wWDgI8sMkUvPtCGIJHfzY3Kn
	 y/eBa3uCdEWEZEcTpbSb6CECKnUXx+iD3bXH+krfZlq2Hzx2cUY4dQCMScMQNp0dlf
	 Kg9Gka/e2tyiSGTuMhcoe7hDMZdL70EdUXDqcmHqfdFpaAdZxVouainz98wrqDUfJA
	 tr4NmMN126tYWzyBbQPQfI+A/fRcwBeimQF8WjanY98NTM19dQuVz15PRn55F4JJ+O
	 YD8GnLS8yX7hBff10nqkCCG6l/bAGOnwP29GVDB+G2IZcLVLdAFvLdr6m+IfURKTsg
	 ZeQ39k+M9/H3A==
Date: Thu, 21 Aug 2025 09:15:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 06/23] fuse: add an ioctl to add new iomap devices
Message-ID: <20250821161510.GN7942@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709244.17510.7992044692651721971.stgit@frogsfrogsfrogs>
 <CAOQ4uxgPOARcEq+p6p0NsBSC9GQp3egHViFeniR=Kc2GpQBCDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgPOARcEq+p6p0NsBSC9GQp3egHViFeniR=Kc2GpQBCDg@mail.gmail.com>

On Thu, Aug 21, 2025 at 10:09:29AM +0200, Amir Goldstein wrote:
> On Thu, Aug 21, 2025 at 2:54 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Add an ioctl that allows fuse servers to register block devices for use
> > with iomap.  This is (for now) separate from the backing file open/close
> > ioctl (despite using the same struct) to keep the codepaths separate.
> 
> Is it though? I'm pretty sure this commit does not add a new ioctl
> and reuses the same one (which is fine by me).

Oops, stale message. :(

<snip>

> > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > index c128bed95a76b8..c63990254649ca 100644
> > --- a/fs/fuse/backing.c
> > +++ b/fs/fuse/backing.c
> > @@ -187,10 +193,13 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >          * error code will be passed up.  EBUSY is the default.
> >          */
> >         passthrough_err = fuse_passthrough_backing_close(fc, fb);
> > +       iomap_err = fuse_iomap_backing_close(fc, fb);
> >
> >         if (refcount_read(&fb->count) > 1) {
> >                 if (passthrough_err)
> >                         err = passthrough_err;
> > +               if (!err && iomap_err)
> > +                       err = iomap_err;
> >                 if (!err)
> >                         err = -EBUSY;
> >                 goto out_fb;
> 
> Do you really think that we need to support both file passthrough and file iomap
> on the same fuse filesystem?

Probably not.

> Unless you have a specific use case in mind, it looks like over design to me
> We could enforce either fc->passthrough or fc->iomap on init.
> 
> Put it in other words: unless you intend to test a combination of file
> passthrough
> and file iomap, I think you should leave this configuration out of the config
> possibilities.

Nah, one subsystem per backing device_id is ok with me.  If someday
someone builds a hybrid filesystem then ... hopefully they don't need
more than INT_MAX backing files to be in the index.

--D

> Thanks,
> Amir.
> 

