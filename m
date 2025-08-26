Return-Path: <linux-fsdevel+bounces-59315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72469B37356
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB0F464E39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F71930CD9E;
	Tue, 26 Aug 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOkQtVw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65B30CDA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237433; cv=none; b=lZMhA90TWiOoZ/CntIEH30xah1DSKuHSJ1/R8RTmgcgbAvDnH9TuFLSraDfSOGOAWqJTw3/pKPw4Ewoz0Dl7yHH/yfmiJ43A8fIIO4aRad40QGSVIJWluAdLqonCK1XdlVUEDJOG2hF3J5NZBwRExp6cnc7TW0PSllLvvwcLgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237433; c=relaxed/simple;
	bh=uOevrRYEXJ8QMLcA6ZuOhFt08uaD7jzqo894mdf79rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHlA/X4coVIdfqj4yWO2LkO9b5OC8xwKka/PkTWy6Su/L5ozOPGq7lP3Kiii5ISFE3bkPq41vs/gd4WjiXqPCV/h/5K5ukbE8hI4Lr6+UruMpKieKBxjkmgMC0b+tteJ+CgCF1EWq1KF6MmhTORAJrfj5nTZkiZDlibVIwHkrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOkQtVw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15902C4CEF1;
	Tue, 26 Aug 2025 19:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756237433;
	bh=uOevrRYEXJ8QMLcA6ZuOhFt08uaD7jzqo894mdf79rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOkQtVw10cCjltTOZqQTv2BA2nlS4/em+dQoNBDtQQUEIC6p9j7AWAfY4nyKVymCD
	 8W8+8XfSIdO8ZcXbcXS4992dfOfLwsY75w/asr9HjWQU8mBxNhuE4NvTHIw78Y9ozU
	 mmAVmP6TOPXZOK2OL/gmiUVWRnrDN/YiSzm1mYdkHsMzEhyOtsxt3QkI7qNYNoguHn
	 4r1uAa0Pa7+7iF3s0y2fAxBfz4Wl2Hl09CxswyspIrMdc8u+Ws1XDY9hEeKGej3hJs
	 7j6/V+Wigx60ynoNHg8pM0zYkxy54BX8OJ1e9wMBsQiBWPfPbFGohgOIbTNcTcWoC1
	 ypzPEJdGiA0lA==
Date: Tue, 26 Aug 2025 12:43:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	"John@groves.net" <John@groves.net>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"neal@gompa.dev" <neal@gompa.dev>
Subject: Re: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
Message-ID: <20250826194352.GF19809@frogsfrogsfrogs>
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
 <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
 <CAJnrk1Y-eEeJySHL5sYMTphUnApbK2hZpDjDh3qEmsa_f146tw@mail.gmail.com>
 <3722af15-f1e0-4a91-b0ed-9292f80a82a4@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3722af15-f1e0-4a91-b0ed-9292f80a82a4@ddn.com>

On Fri, Aug 22, 2025 at 12:54:01PM +0000, Bernd Schubert wrote:
> On 8/22/25 02:33, Joanne Koong wrote:
> > On Wed, Aug 20, 2025 at 6:01 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >>
> >> From: Darrick J. Wong <djwong@kernel.org>
> >>
> >> fuse.h and fuse_lowlevel.h are public headers, don't expose internal
> >> build system config variables to downstream clients.  This can also lead
> >> to function pointer ordering issues if (say) libfuse gets built with
> >> HAVE_STATX but the client program doesn't define a HAVE_STATX.
> >>
> >> Get rid of the conditionals in the public header files to fix this.
> >>
> >> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >> ---
> >>  include/fuse.h           |    2 --
> >>  include/fuse_lowlevel.h  |    2 --
> >>  example/memfs_ll.cc      |    2 +-
> >>  example/passthrough.c    |    2 +-
> >>  example/passthrough_fh.c |    2 +-
> >>  example/passthrough_ll.c |    2 +-
> >>  6 files changed, 4 insertions(+), 8 deletions(-)
> >>
> >>
> >> diff --git a/include/fuse.h b/include/fuse.h
> >> index 06feacb070fbfb..209102651e9454 100644
> >> --- a/include/fuse.h
> >> +++ b/include/fuse.h
> >> @@ -854,7 +854,6 @@ struct fuse_operations {
> >>          */
> >>         off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
> >>
> >> -#ifdef HAVE_STATX
> >>         /**
> >>          * Get extended file attributes.
> >>          *
> >> @@ -865,7 +864,6 @@ struct fuse_operations {
> >>          */
> >>         int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
> >>                      struct fuse_file_info *fi);
> >> -#endif
> >>  };
> > 
> > Are we able to just remove this ifdef? Won't this break compilation on
> > old systems that don't recognize "struct statx"?
> 
> Yeah, you had added forward declaration actually. Slipped through in
> my review that we don't need the HAVE_STATX anymore.
> 
> We can also extend the patch a bit to remove HAVE_STATX from the public
> config. 
> Another alternative for this patch would be to replace HAVE_STATX by
> HAVE_FUSE_STATX.
> The commit message is also not entirely right, as it says

<shrug> libfuse itself doesn't define a struct statx, so what does it
have, aside from the incomplete struct declaration?  TBH I wonder what
will happen when struct statx grows, but everybody gets to deal with
that problem because we didn't explicitly encode the size in either the
syscall or the struct definition.

Presumably fuse servers will detect and set their own HAVE_STATX,
and only supply a ->statx function if they HAVE_STATX.  They don't have
to know if libfuse itself got built with statx support; if it didn't,
then nothing will ever call ->statx, afaict.

> > to function pointer ordering issues if (say) libfuse gets built with
> > HAVE_STATX but the client program doesn't define a HAVE_STATX.
> 
> Actually not, because /usr/include/fuse3/libfuse_config.h defines HAVE_STATX.
> I'm more worried that there might be a conflict of HAVE_STATX from libfuse
> with HAVE_STATX from the application.

<nod>

--D

> 
> Thanks,
> Bernd

