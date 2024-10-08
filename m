Return-Path: <linux-fsdevel+bounces-31272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDE9993DE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 06:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B5B23162
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 04:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007037DA7F;
	Tue,  8 Oct 2024 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eLnzV1g+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E333C0C;
	Tue,  8 Oct 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360985; cv=none; b=fg0WOXCA08FrF7Uq4nls84vCya51FZb7WV8fgEVgbFK/GaS7fBn8eXkiJYelgA8z3h4ysLSlnLjZCs3sugPwiSieBXIUcOBjebAisstAVziL8saJu1NIEtWks67h0CGAUP0f0cX1vwsX8u2x3wnC+qgCzsTYaRQPJ8Fwa835zdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360985; c=relaxed/simple;
	bh=2Rw5XCCscapRli23631yqGLbV9IuinESjjD7/PyBm/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsDie7omrX6LmV6e14ddOg/dkcQw/c4Fde2q/t7kTIl4w71PKWUU6IDH6bVfWtMimMwPOA8R9JiR4dYaUhXgNwnorduk9ARuy3q/9OkM0t0/DVNHgrfnXLuZJYSrZaltxudaZiKNrIHsCsYZInpsxYMbqy/ddFfT1s6KHfAOQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eLnzV1g+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=97l6SjBohVYWdAwAypURyEzWFaCjUnLj/GsOLcXtnv8=; b=eLnzV1g+ysODUXKXYkECsqDMwO
	0WkZVANtkvlg13cw+SuF5N5Q+MlJeKJsO3UliHKtrF7vdp7PjVp6zJ8wiFNg0xFzwdM69WXuqn/gk
	ogAeg84YiRG9saUfMQkIeijDDk5yGI/YUZd1Ps49QcWzdZkUbOgAb4J7gUaa4t3+hAn6Ziz3e8BlL
	dKhtnjkE+ene3VWsKJFGX6VlUIOteTwkj9UWq5odGhnN/FBGvcEclJ/1Q/HqfjfRsBtAMxKkJ1Fq0
	N4hekTk+SGVr7Ofa/sbLlF3745T3iUokvC0WrMpxotBxje5hDbL5l29tREFWcYwMIp9v7TBje5KHV
	LCbiOa/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1e1-00000001lcY-13ED;
	Tue, 08 Oct 2024 04:16:21 +0000
Date: Tue, 8 Oct 2024 05:16:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>,
	Miao Wang <shankerwangmiao@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH |
 ..., NULL, ...) behave as (..., AT_EMPTY_PATH | ..., "", ...)
Message-ID: <20241008041621.GV4017910@ZenIV>
References: <20241007130825.10326-1-xry111@xry111.site>
 <20241007130825.10326-3-xry111@xry111.site>
 <CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHdccL5Lh8zAO-0swqqRCW4GXMSXhq4jQGoVj=UdBK-Lg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 08, 2024 at 05:57:00AM +0200, Mateusz Guzik wrote:
> On Mon, Oct 7, 2024 at 3:08 PM Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > We've supported {statx,fstatat}(real_fd, NULL, AT_EMPTY_PATH, ...) since
> > Linux 6.11 for better performance.  However there are other cases, for
> > example using AT_FDCWD as the fd or having AT_SYMLINK_NOFOLLOW in flags,
> > not covered by the fast path.  While it may be impossible, too
> > difficult, or not very beneficial to optimize these cases, we should
> > still turn NULL into "" for them in the slow path to make the API easier
> > to be documented and used.
> >
> > Fixes: 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >  fs/stat.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/stat.c b/fs/stat.c
> > index ed9d4fd8ba2c..5d1b51c23c62 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -337,8 +337,11 @@ int vfs_fstatat(int dfd, const char __user *filename,
> >         flags &= ~AT_NO_AUTOMOUNT;
> >         if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
> >                 return vfs_fstat(dfd, stat);
> > +       else if ((flags & AT_EMPTY_PATH) && !filename)
> > +               name = getname_kernel("");
> > +       else
> > +               name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
> >
> > -       name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
> >         ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
> >         putname(name);
> >
> > @@ -791,8 +794,11 @@ SYSCALL_DEFINE5(statx,
> >         lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
> >         if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
> >                 return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
> > +       else if ((lflags & AT_EMPTY_PATH) && !filename)
> > +               name = getname_kernel("");
> > +       else
> > +               name = getname_flags(filename, getname_statx_lookup_flags(flags));
> >
> > -       name = getname_flags(filename, getname_statx_lookup_flags(flags));
> >         ret = do_statx(dfd, name, flags, mask, buffer);
> >         putname(name);
> >
> 
> I thought you are going to patch up the 2 callsites of
> vfs_empty_path() or add the flags argument to said routine so that it
> can do the branching internally.
> 
> Either way I don't think implementing AT_FDCWD + NULL + AT_EMPTY_PATH
> with  getname_kernel("") is necessary.

Folks, please don't go there.  Really.  IMO vfs_empty_path() is a wrong API
in the first place.  Too low-level and racy as well.

	See the approach in #work.xattr; I'm going to lift that into fs/namei.c
(well, the slow path - everything after "if path is NULL, we are done") and
yes, fs/stat.c users get handled better that way.

