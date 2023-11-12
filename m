Return-Path: <linux-fsdevel+bounces-2773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB487E8FD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 14:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511CF1C208CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A88BF4;
	Sun, 12 Nov 2023 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWHL919z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1A847C;
	Sun, 12 Nov 2023 13:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E935BC433C7;
	Sun, 12 Nov 2023 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699794361;
	bh=Up28SPWOa6jD0igTTwEC4Hob6rCXj0MPSVsR3u9yY8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWHL919zHSqxlcyqbgg08BrTE+ngjrz6rWxfxCiUBkB45mvrC8y5Mf3hfuF5ByIK2
	 wOAIr0P5yILWvjNbCOZG2/YOz+MkNEJaRczeBqoJET7pHxtoC5nDUtNnvRDLOOr1Gp
	 BIuvXNpCtT1/6Ang0KkbWm3OCcWzyRBbtM+2DzP0BvC9E+9CC0rd2lv5wdFJL2xuJA
	 iIcAjfVQynpLZYFtGsxKCurWalPK2nOX7ye85ZpKtjlU2k5KLiIYWZnCyXPkijQYzR
	 mp1LIQhMYDGOJzx/8ClVjq9GZE3JzxGXhA8Rqcy7InDtgYud1kl9LX/qdkIetjfKNg
	 M5WiaNM4y05aQ==
Date: Sun, 12 Nov 2023 14:05:58 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 4/6] add statmount(2) syscall
Message-ID: <20231112-gemessen-lauschangriff-3352c19e676a@brauner>
References: <20231025140205.3586473-5-mszeredi@redhat.com>
 <4ab327f80c4f98dffa5736a1acba3e0d.paul@paul-moore.com>
 <20231108-zwerge-unheil-b3f48a84038d@brauner>
 <CAHC9VhSLGyFRSbeZXE7z61Y2aDJi_1Dedjw0ioFOckRCs0CRaA@mail.gmail.com>
 <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRvYua4noiHbMqcAqz=Rkz=pxSgp5fVxXX+uhz61jYFag@mail.gmail.com>

On Fri, Nov 10, 2023 at 12:00:22PM -0500, Paul Moore wrote:
> On Wed, Nov 8, 2023 at 3:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Nov 8, 2023 at 2:58 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > > +static int do_statmount(struct stmt_state *s)
> > > > > +{
> > > > > +   struct statmnt *sm = &s->sm;
> > > > > +   struct mount *m = real_mount(s->mnt);
> > > > > +   size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
> > > > > +   int err;
> > > > > +
> > > > > +   err = security_sb_statfs(s->mnt->mnt_root);
> > > > > +   if (err)
> > > > > +           return err;
> > > > > +
> > > > > +   if (!capable(CAP_SYS_ADMIN) &&
> > > > > +       !is_path_reachable(m, m->mnt.mnt_root, &s->root))
> > > > > +           return -EPERM;
> > > >
> > > > In order to be consistent with our typical access control ordering,
> > > > please move the security_sb_statfs() call down to here, after the
> > > > capability checks.
> > >
> > > I've moved the security_sb_statfs() calls accordingly.
> >
> > Okay, good.  Did I miss a comment or a patch where that happened?  I
> > looked over the patchset and comments yesterday and didn't recall
> > seeing anything about shuffling the access control checks.
> 
> Gentle ping on this.  I'm asking because I know there have been issues
> lately with the lists and some mail providers and I want to make sure
> I'm not missing anything, I double checked lore again and didn't see
> anything there either, but I might be missing it.

Sorry, I'm traveling so I just didn't see this. Please see:

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.mount&id=dc14fa93943918bee898d75d7ae72fc3623ce9ce
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.mount&id=de17643cbf9b0282990bb9cf0e0bf01710c9ec03

I've folded the fixup into these patches. I probably just accidently
dropped the diff from my reply.

