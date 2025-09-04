Return-Path: <linux-fsdevel+bounces-60236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F89B42FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 04:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EED7C66E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785E1D63F7;
	Thu,  4 Sep 2025 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKyAB6eT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8203C01;
	Thu,  4 Sep 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953983; cv=none; b=kfEiO8Ct8yGG9MSXVPeYsdM5CwdOMFR8ujkCM78uRAH8RSEnvuXgxjDWHHSGYPg+qHzshWK8J6nbDV2cnU2hwtsxMye+ck5Vz2FNR/6KaaZZsZdcKlFMVqM6BPDIDV4dwteSbyX7ts1bHrUbQJ5poRjadz7gvC5PcMuBNJPW6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953983; c=relaxed/simple;
	bh=sy/DcoAE4tkjlVpnWESp42rhMjtk++poKPOMe02XAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL4NccQ8N+hisXhu+L5lcKxX7/e17Z/XyHMgLss8xwJYPNdJ6uKJUk0B8R3JMzNJ0xrrfoaRWt2iibhHcr4PDGuXdPArxJrxyt2kzrDy0fdjNK0MG0epMz5ETgSFg6wBIK0LnAScjWUy5fGRWjwpVBQlOs89+tRog2QHmkFA5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKyAB6eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9719EC4CEE7;
	Thu,  4 Sep 2025 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756953982;
	bh=sy/DcoAE4tkjlVpnWESp42rhMjtk++poKPOMe02XAsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKyAB6eTyPg9KvOkINssekR5BEKQyKDM+Pp1d+lDd2qWvb5VraG2TPuq5IoAEuhdL
	 vF4iPWg0Yo2EWg7A6XwnyaxHxOWYvFJDn1uTHU5ywmguswZP19BMCeQG9Zq/fp8Il0
	 Qbd751UylxCTZWTpDOFyad8wz+gfBFf50AN3TzKevJYu+KWteEvg8hvlS9Sg/Uvg5u
	 As44nccuwDW53Cn5AgtwWXGmc4UDAc1lwkbHT0HgfaIOu1Zmw335HrLgBvYL3pCEe1
	 CDhTqy9um8IlVyzbKwyRqYgc6ABRvOOfc0cRG6EQAgHr55kZPdWr6vyms7ELx2swMk
	 wgBpacPlmSqeg==
Date: Wed, 3 Sep 2025 19:46:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in
 fuse_iomap_writeback_{range,submit}()
Message-ID: <20250904024622.GN8117@frogsfrogsfrogs>
References: <20250903083453.26618-1-luis@igalia.com>
 <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
 <87ikhze1ub.fsf@wotan.olymp>
 <20250903204847.GQ1587915@frogsfrogsfrogs>
 <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aa97AwixCq9+eGQT52LAfqL-S1Ci5fSUygfFOo-6kMHA@mail.gmail.com>

On Wed, Sep 03, 2025 at 03:32:40PM -0700, Joanne Koong wrote:
> On Wed, Sep 3, 2025 at 1:48 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 03, 2025 at 09:08:12PM +0100, Luis Henriques wrote:
> > > On Wed, Sep 03 2025, Joanne Koong wrote:
> > >
> > > > On Wed, Sep 3, 2025 at 1:35 AM Luis Henriques <luis@igalia.com> wrote:
> > > >>
> > > >> These two functions make use of the WARN_ON_ONCE() macro to help debugging
> > > >> a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility of NULL
> > > >> pointer dereferences in the code.  This patch adds some extra defensive
> > > >> checks to avoid these NULL pointer accesses.
> > > >>
> > > >> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> > > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > > >> ---
> > > >> Hi!
> > > >>
> > > >> This v2 results from Joanne's inputs -- I now believe that it is better to
> > > >> keep the WARN_ON_ONCE() macros, but it's still good to try to minimise
> > > >> the undesirable effects of a NULL wpc->wb_ctx.
> > > >>
> > > >> I've also added the 'Fixes:' tag to the commit message.
> > > >>
> > > >>  fs/fuse/file.c | 13 +++++++++----
> > > >>  1 file changed, 9 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > >> index 5525a4520b0f..990c287bc3e3 100644
> > > >> --- a/fs/fuse/file.c
> > > >> +++ b/fs/fuse/file.c
> > > >> @@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> > > >>                                           unsigned len, u64 end_pos)
> > > >>  {
> > > >>         struct fuse_fill_wb_data *data = wpc->wb_ctx;
> > > >> -       struct fuse_writepage_args *wpa = data->wpa;
> > > >> -       struct fuse_args_pages *ap = &wpa->ia.ap;
> > > >> +       struct fuse_writepage_args *wpa;
> > > >> +       struct fuse_args_pages *ap;
> > > >>         struct inode *inode = wpc->inode;
> > > >>         struct fuse_inode *fi = get_fuse_inode(inode);
> > > >>         struct fuse_conn *fc = get_fuse_conn(inode);
> > > >>         loff_t offset = offset_in_folio(folio, pos);
> > > >>
> > > >> -       WARN_ON_ONCE(!data);
> > > >> +       if (WARN_ON_ONCE(!data))
> > > >> +               return -EIO;
> > > >
> > > > imo this WARN_ON_ONCE (and the one below) should be left as is instead
> > > > of embedded in the "if" construct. The data pointer passed in is set
> > > > by fuse and as such, we're able to reasonably guarantee that data is a
> > > > valid pointer. Looking at other examples of WARN_ON in the fuse
> > > > codebase, the places where an "if" construct is used are for cases
> > > > where the assumptions that are made are more delicate (eg folio
> > > > mapping state, in fuse_try_move_folio()) and less clearly obvious. I
> > > > think this WARN_ON_ONCE here and below should be left as is.
> > >
> > > OK, thank you for your feedback, Joanne.  So, if Miklos agrees with that,
> > > I guess we can drop this patch.
> 
> I think having the two lines "wpa = data->wpa;" and "ap = &wpa->ia.ap"
> moved to below the "WARN_ON_ONCE(!data);" would still be useful

<shrug> Compilers are magic, they can rearrange the function unless you
explicitly put in barriers or data dependencies to prevent that. 8-)

> >
> > AFAICT, this function can only be called by other iomap-using functions
> > in file.c, and those other functions always set
> > iomap_writepage_ctx::wb_ctx so I /think/ the assertions aren't necessary
> > at all...
> >
> > > Cheers,
> > > --
> > > Luís
> > >
> > > >
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > >> +
> > > >> +       wpa = data->wpa;
> > > >> +       ap = &wpa->ia.ap;
> > > >>
> > > >>         if (!data->ff) {
> >
> > ...because if someone fails to set wpc->wb_ctx, this line will crash the
> > kernel at least as much as the WARN_ON would.  IOWs, the WARN_ONs aren't
> > necessary but I don't think they hurt much.
> >
> 
> Oh, I see. Actually, this explanation makes a lot of sense. When I was
> looking at the other WARN_ON usages in fuse, I noticed they were also
> used even if it's logically proven that the code path can never be
> triggered. But I guess what you're saying is that WARN_ONs in general
> should be used if it's otherwise somehow undetectable / non-obvious
> that the condition is violated? That makes sense to me, and checks out
> with the other fuse WARN_ON uses.
> 
> I'm fine with just removing the WARN_ON(!data) here and below. I think
> I added some more WARN_ONs in my other fuse iomap patchset, so I'll
> remove those as well when I send out a new version.

<nod>

> > You could introduce a CONFIG_FUSE_DEBUG option and hide some assertions
> > and whatnot behind it, ala CONFIG_FUSE_IOMAP_DEBUG*:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/fuse/iomap_priv.h?h=djwong-wtf&id=170269a48ae83ea7ce1e23ea5ff39995600efff0
> >
> 
> In that case, personally I'd much prefer removing the WARN_ONs here
> than having a new config for it.

<nod> I added it to mine because there are a lot of things that iomap
/can/ get cranky about, so it's useful to have a "BAD_DATA" macro that
screams when the fuse server feeds garbage to the kernel.

--D

> Thanks,
> Joanne
> 
> > --D
> >
> > > >>                 data->ff = fuse_write_file_get(fi);
> > > >> @@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
> > > >>  {
> > > >>         struct fuse_fill_wb_data *data = wpc->wb_ctx;
> > > >>
> > > >> -       WARN_ON_ONCE(!data);
> > > >> +       if (WARN_ON_ONCE(!data))
> > > >> +               return error ? error : -EIO;
> > > >>
> > > >>         if (data->wpa) {
> > > >>                 WARN_ON(!data->wpa->ia.ap.num_folios);
> > >
> > >

