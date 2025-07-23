Return-Path: <linux-fsdevel+bounces-55894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BDB0F994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 19:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831C91628DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36741218584;
	Wed, 23 Jul 2025 17:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXdc7Hi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FDC2E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293032; cv=none; b=fczX+fru9+Nrtr1CydRaUP5QFz4hAvIg2uuHZKrmp+qdjCJTpTp0SqRPLbtI0sNRJ/tPIXhx6syOlhHt01yF0OyFY5ZVG8umzpctJf8ju9bY5WElNOOThLkwubqt4ml+w4dNEBKZtvlzg8apabxsAdYN045t+PPtkI3nj0x80rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293032; c=relaxed/simple;
	bh=B/lKmPX74KDknpXwWmINT2iRTYVh7sNbCytWc8ch4rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9lzbJ7umkbGKYjjzLDSZ3ohg63i8pVJCIjY7YEBXnCuOKNK9WSjnc5qWB0EyhTW2yA3fsRJ3ZsrTkYGTRwwnppNJt4RHF4HcexE+B13EZvbAvfYh+TlcGJvrFsKlRg1pV8rDHLWBpF1tzpuftyw00zu7sQ3JbjnDh+RAIAebbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXdc7Hi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26742C4CEE7;
	Wed, 23 Jul 2025 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753293032;
	bh=B/lKmPX74KDknpXwWmINT2iRTYVh7sNbCytWc8ch4rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXdc7Hi/1tMj9zDnmdPXCkRR+5MhNJ+5QY3jkDLbSIeccW8Qy+uYt+ZzETPlN2Tnn
	 Vs6DlXgoQISE+1YEwbFjWyxTQB3lPaxpRaqfOaB+GE6N0+shSziH9PrrFx9cadToEd
	 3tA45vwS16Y60xvgBH869nXzyrsrhz1ZtPMY7p8tQw/enINEQwo0cC8y+kwW6kQtDJ
	 AfCWi/OuVf25eJqWyJjZk8w0MFpdKI6noYM0WZvvTkUq9eczxa+Pv8+mpYjzj36aVA
	 h96S7o0fGut1YIbC7x5gHDhCswDtDiCuZpvX1H/BR8W8yKCFy6ZAHaEBwYpUISeeyl
	 +TgmAGTJktOIg==
Date: Wed, 23 Jul 2025 10:50:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"John@groves.net" <John@groves.net>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 08/14] libfuse: connect high level fuse library to
 fuse_reply_attr_iflags
Message-ID: <20250723175031.GJ2672029@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459875.714161.9108157061004962886.stgit@frogsfrogsfrogs>
 <CAOQ4uxjRjssQr4M0JQShQHkDh_kh7Risj4BhkfTdfQuBVKY8LQ@mail.gmail.com>
 <20250718155514.GS2672029@frogsfrogsfrogs>
 <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa6b51a1-f2d9-4bf6-b20e-6ab4fd4fb3f0@ddn.com>

On Mon, Jul 21, 2025 at 06:51:00PM +0000, Bernd Schubert wrote:
> On 7/18/25 17:55, Darrick J. Wong wrote:
> > On Fri, Jul 18, 2025 at 04:27:50PM +0200, Amir Goldstein wrote:
> >> On Fri, Jul 18, 2025 at 1:36 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Create a new ->getattr_iflags function so that iomap filesystems can set
> >>> the appropriate in-kernel inode flags on instantiation.
> >>>
> >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > <snip for brevity>
> > 
> >>> diff --git a/lib/fuse.c b/lib/fuse.c
> >>> index 8dbf88877dd37c..685d0181e569d0 100644
> >>> --- a/lib/fuse.c
> >>> +++ b/lib/fuse.c
> >>> @@ -3710,14 +3832,19 @@ static int readdir_fill_from_list(fuse_req_t req, struct fuse_dh *dh,
> >>>                         if (de->flags & FUSE_FILL_DIR_PLUS &&
> >>>                             !is_dot_or_dotdot(de->name)) {
> >>>                                 res = do_lookup(dh->fuse, dh->nodeid,
> >>> -                                               de->name, &e);
> >>> +                                               de->name, &e, &iflags);
> >>>                                 if (res) {
> >>>                                         dh->error = res;
> >>>                                         return 1;
> >>>                                 }
> >>>                         }
> >>>
> >>> -                       thislen = fuse_add_direntry_plus(req, p, rem,
> >>> +                       if (f->want_iflags)
> >>> +                               thislen = fuse_add_direntry_plus_iflags(req, p,
> >>> +                                                        rem, de->name, iflags,
> >>> +                                                        &e, pos);
> >>> +                       else
> >>> +                               thislen = fuse_add_direntry_plus(req, p, rem,
> >>>                                                          de->name, &e, pos);
> >>
> >>
> >> All those conditional statements look pretty moot.
> >> Can't we just force iflags to 0 if (!f->want_iflags)
> >> and always call the *_iflags functions?
> > 
> > Heh, it already is zero, so yes, this could be a straight call to
> > fuse_add_direntry_plus_iflags without the want_iflags check.  Will fix
> > up this and the other thing you mentioned in the previous patch.
> > 
> > Thanks for the code review!
> > 
> > Having said that, the significant difficulties with iomap and the
> > upper level fuse library still exist.  To summarize -- upper libfuse has
> > its own nodeids which don't necssarily correspond to the filesystem's,
> > and struct node/nodeid are duplicated for hardlinked files.  As a
> > result, the kernel has multiple struct inodes for an ondisk ext4 inode,
> > which completely breaks the locking for the iomap file IO model.
> > 
> > That forces me to port fuse2fs to the lowlevel library, so I might
> > remove the lib/fuse.c patches entirely.  Are there plans to make the
> > upper libfuse handle hardlinks better?
> 
> I don't have plans for high level improvements. To be honest, I didn't
> know about the hard link issue at all.

Assuming "I didn't know" means you're not familiar with what I'm
talking about, let me provide a brief overview:

So you know how fuse.c implements a directory entry cache in
fuse::name_table?  Every time someone uses the cache to walk a path and
misses a path, it'll alloc_node() a new struct node, hash it, and add it
to the name_table.

Allocating a node assigns a new nodeid, which is then passed into the
kernel and the kernel uses the nodeid to index the struct fuse_inode
objects.

Unfortunately, if the filesystem supports hardlinks, the name_table
creates two nodeids for the same ondisk inode.  IOWs, if the directory
tree is:

$ <mount fuse server>
$ mkdir /mnt/a /mnt/b
$ touch /mnt/a/foo
$ ln /mnt/a/foo /mnt/b/bar
$ umount /mnt
$ <mount fuse server>
$ ls /mnt/a/foo /mnt/b/bar

Then the fuse library will create one struct node for foo and another
one for bar.  They both refer to the same ondisk inode, but in memory
they have separate nodeids and hence separate struct fuse_inodes in the
kernel.

For a regular fuse server (no writeback caching, no iomap) this works
out because all the file IO requests get forwarded to the fuse server.
If the server is sane it'll coordinate access to its internal inode
structure to process the requests.  fuse is careful enough to revalidate
the cached file attributes very frequently, so out of date metadata is
barely noticeable.

For a fuse+iomap server, having separate fuse_inodes for the same ondisk
inode isn't going to work because iomap relies on i_rwsem in the kernel
struct fuse_inode to coordinate writes among all writer threads, no
matter what path they used to open the file.

> Also a bit surprising to see all your lowlevel work and then fuse high
> level coming ;)

Right now fuse2fs is a high level fuse server, so I hacked whatever I
needed into fuse.c to make it sort of work, awkwardly.  That stuff
doesn't need to live forever.

In the long run, the lowlevel server will probably have better
performance because fuse2fs++ can pass ext2 inode numbers to the kernel
as the nodeids, and libext2fs can look up inodes via nodeid.  No more
path construction overhead!

> Btw, I will go on vacation on Wednesday and still other things queued,
> going to try to review in the evenings (but not before next Saturday).

<nod> Enjoy your vacation!

--D

> 
> 
> Cheers,
> Bernd

