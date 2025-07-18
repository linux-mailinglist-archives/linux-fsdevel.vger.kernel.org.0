Return-Path: <linux-fsdevel+bounces-55442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D66B0A7FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1381C4150C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AF92E5B14;
	Fri, 18 Jul 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6D/wg4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FF2DFA4A
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854115; cv=none; b=E/t4qXqvZikPU7vzJehe9ocFkEcb6jyXX1rJeoRuTLvZ5JCrKD4B5UTrgNJVGbirTqWF0N9lyHThF72uVEytVN/qxbAAw62dPRxOUcZ9GnTJO9BixDg/tjyHItxrvUMinQS/Os5yCbg9Z2ByNlzTZS7/b6MTiHPs65Xds2DEM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854115; c=relaxed/simple;
	bh=RLIpovMdg7S9lNaJQjKCdlZB1Hse0gqy3sSIY21jibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwPWsefEH4K1U2Rf82Ly8y6gPYhjFKOgziabr0aimOSUmZgpvCyRRGhps53cQKbDNJXU/DPtqrH7OZIP2lj3mpUgiqlmwBTHCfmfzTMJelcbs68lmshjy/vcEH/PgAxYXoS1pmpCZ8Xq1O7SIropaf72kmO2+l5t857QIl8/XVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6D/wg4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C454CC4CEF1;
	Fri, 18 Jul 2025 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752854114;
	bh=RLIpovMdg7S9lNaJQjKCdlZB1Hse0gqy3sSIY21jibM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6D/wg4jS9KVXhYkeML6YNoqoEocJexxNyA0ig8GBpfeOvNBikGH3S9xBQ70PD8QG
	 M68Q08XlpXBeTwgKPkwL15yU6IKEuq5YjZAkcsBbGaAePIS9i+tTk66If2QAwr23VF
	 5xTtc7lAWJeeDSXm4ph2XyO4zsMMgltgjw6AJQV0nN8Oc1SIvnJ11x/6CTpqF5p3po
	 spkf1zT4bllBKgfwwUbKdtvXU4+bjVO0yJIU5HOhQVWAZEwVctj5GOg/I/bcNPQGCk
	 8tQZEHiO+N5PISHy3W7U5uLJ2frQ2F2PT8L2EbAxqhnMMeVU++sai7RIB6DFVOx8a1
	 NjUjiWAhfVAJQ==
Date: Fri, 18 Jul 2025 08:55:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	miklos@szeredi.hu
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Message-ID: <20250718155514.GS2672029@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>

On Fri, Jul 18, 2025 at 04:27:50PM +0200, Amir Goldstein wrote:
> On Fri, Jul 18, 2025 at 1:36 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Create a new ->getattr_iflags function so that iomap filesystems can set
> > the appropriate in-kernel inode flags on instantiation.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

<snip for brevity>

> > diff --git a/lib/fuse.c b/lib/fuse.c
> > index 8dbf88877dd37c..685d0181e569d0 100644
> > --- a/lib/fuse.c
> > +++ b/lib/fuse.c
> > @@ -3710,14 +3832,19 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
> >                         if (de->flags & FUSE_FILL_DIR_PLUS &&
> >                             !is_dot_or_dotdot(de->name)) {
> >                                 res = do_lookup(dh->fuse, dh->nodeid,
> > -                                               de->name, &e);
> > +                                               de->name, &e, &iflags);
> >                                 if (res) {
> >                                         dh->error = res;
> >                                         return 1;
> >                                 }
> >                         }
> >
> > -                       thislen = fuse_add_direntry_plus(req, p, rem,
> > +                       if (f->want_iflags)
> > +                               thislen = fuse_add_direntry_plus_iflags(req, p,
> > +                                                        rem, de->name, iflags,
> > +                                                        &e, pos);
> > +                       else
> > +                               thislen = fuse_add_direntry_plus(req, p, rem,
> >                                                          de->name, &e, pos);
> 
> 
> All those conditional statements look pretty moot.
> Can't we just force iflags to 0 if (!f->want_iflags)
> and always call the *_iflags functions?

Heh, it already is zero, so yes, this could be a straight call to
fuse_add_direntry_plus_iflags without the want_iflags check.  Will fix
up this and the other thing you mentioned in the previous patch.

Thanks for the code review!

Having said that, the significant difficulties with iomap and the
upper level fuse library still exist.  To summarize -- upper libfuse has
its own nodeids which don't necssarily correspond to the filesystem's,
and struct node/nodeid are duplicated for hardlinked files.  As a
result, the kernel has multiple struct inodes for an ondisk ext4 inode,
which completely breaks the locking for the iomap file IO model.

That forces me to port fuse2fs to the lowlevel library, so I might
remove the lib/fuse.c patches entirely.  Are there plans to make the
upper libfuse handle hardlinks better?

--D

> Thanks,
> Amir.
> 

