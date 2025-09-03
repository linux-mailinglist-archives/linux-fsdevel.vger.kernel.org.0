Return-Path: <linux-fsdevel+bounces-60210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4AB42B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1CD484A48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B02E36FD;
	Wed,  3 Sep 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyacv/qU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05473285053;
	Wed,  3 Sep 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932529; cv=none; b=qZkQ8JB71tt5w2QvFP0vsHKo55qAA0960lrxkk+AiORhS8knJsYy0R5+s1x9B/KCMjHXUDsZYKsIGym74pBFv4iqwW4w+eFopvsrYziemXb/jf3sYxEGLfDMD8GBPoN/GC9BOD923mn1zUsds8xlElX/CfIecCIstCf6w+w8V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932529; c=relaxed/simple;
	bh=Bw40hBBIyzi0flxuqp/pKPWqRl9CPdh7gnrSmbLbzxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBfKWPaha7rqnoUcKCMY2ajcy/GL3v2iNHFGl93yWXTHpinxyY9faiRgwIhb9n3lljUJ/KNS4M4vM5KrkwJyhHlhHQhWAmwYkS7E0G8k3YsdoSzlGAHW0qDbchgmtQqR0eIkWgU7cV9c/O/iYZo6hkYrRKu55ij4gYlzrSl96FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyacv/qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8007CC4CEE7;
	Wed,  3 Sep 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932528;
	bh=Bw40hBBIyzi0flxuqp/pKPWqRl9CPdh7gnrSmbLbzxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eyacv/qU3uFEdNcMzYrfpmtHbVRRW1U7cq5dYnShLYde84EfoywwWPPRc/YmH+XBI
	 wkG80D1fuhkye4SyhGQGYqg2dxSpEQXdHRN9Hx4kGkZ9QeyeqXHGNOvTkX2pR/Wrfg
	 GvCTaf3qbZATvyhKcvvTk0uaJJGj7s0lPp+wr9y7XZntDRKecFOXg5k3a2znmFW2Gr
	 +11Kakl6aYKdOQyoNAY3NE7qd4j3s9cViqfUJ69kBZBVySDH81aFu3TMqRtj/dh1gb
	 HLR27iVDS9q00LPtZRpghW7CHQu1FCUyWAgvKOjrosDFjsoKOuBdUXtLCcqjD7TVYy
	 OsmlbttxmnjNw==
Date: Wed, 3 Sep 2025 13:48:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] fuse: prevent possible NULL pointer dereference in
 fuse_iomap_writeback_{range,submit}()
Message-ID: <20250903204847.GQ1587915@frogsfrogsfrogs>
References: <20250903083453.26618-1-luis@igalia.com>
 <CAJnrk1aWaZLcZkQ_OZhQd8ZfHC=ix6_TZ8ZW270PWu0418gOmA@mail.gmail.com>
 <87ikhze1ub.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikhze1ub.fsf@wotan.olymp>

On Wed, Sep 03, 2025 at 09:08:12PM +0100, Luis Henriques wrote:
> On Wed, Sep 03 2025, Joanne Koong wrote:
> 
> > On Wed, Sep 3, 2025 at 1:35 AM Luis Henriques <luis@igalia.com> wrote:
> >>
> >> These two functions make use of the WARN_ON_ONCE() macro to help debugging
> >> a NULL wpc->wb_ctx.  However, this doesn't prevent the possibility of NULL
> >> pointer dereferences in the code.  This patch adds some extra defensive
> >> checks to avoid these NULL pointer accesses.
> >>
> >> Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >> Hi!
> >>
> >> This v2 results from Joanne's inputs -- I now believe that it is better to
> >> keep the WARN_ON_ONCE() macros, but it's still good to try to minimise
> >> the undesirable effects of a NULL wpc->wb_ctx.
> >>
> >> I've also added the 'Fixes:' tag to the commit message.
> >>
> >>  fs/fuse/file.c | 13 +++++++++----
> >>  1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> index 5525a4520b0f..990c287bc3e3 100644
> >> --- a/fs/fuse/file.c
> >> +++ b/fs/fuse/file.c
> >> @@ -2135,14 +2135,18 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
> >>                                           unsigned len, u64 end_pos)
> >>  {
> >>         struct fuse_fill_wb_data *data = wpc->wb_ctx;
> >> -       struct fuse_writepage_args *wpa = data->wpa;
> >> -       struct fuse_args_pages *ap = &wpa->ia.ap;
> >> +       struct fuse_writepage_args *wpa;
> >> +       struct fuse_args_pages *ap;
> >>         struct inode *inode = wpc->inode;
> >>         struct fuse_inode *fi = get_fuse_inode(inode);
> >>         struct fuse_conn *fc = get_fuse_conn(inode);
> >>         loff_t offset = offset_in_folio(folio, pos);
> >>
> >> -       WARN_ON_ONCE(!data);
> >> +       if (WARN_ON_ONCE(!data))
> >> +               return -EIO;
> >
> > imo this WARN_ON_ONCE (and the one below) should be left as is instead
> > of embedded in the "if" construct. The data pointer passed in is set
> > by fuse and as such, we're able to reasonably guarantee that data is a
> > valid pointer. Looking at other examples of WARN_ON in the fuse
> > codebase, the places where an "if" construct is used are for cases
> > where the assumptions that are made are more delicate (eg folio
> > mapping state, in fuse_try_move_folio()) and less clearly obvious. I
> > think this WARN_ON_ONCE here and below should be left as is.
> 
> OK, thank you for your feedback, Joanne.  So, if Miklos agrees with that,
> I guess we can drop this patch.

AFAICT, this function can only be called by other iomap-using functions
in file.c, and those other functions always set
iomap_writepage_ctx::wb_ctx so I /think/ the assertions aren't necessary
at all...

> Cheers,
> -- 
> Luís
> 
> >
> >
> > Thanks,
> > Joanne
> >
> >> +
> >> +       wpa = data->wpa;
> >> +       ap = &wpa->ia.ap;
> >>
> >>         if (!data->ff) {

...because if someone fails to set wpc->wb_ctx, this line will crash the
kernel at least as much as the WARN_ON would.  IOWs, the WARN_ONs aren't
necessary but I don't think they hurt much.

You could introduce a CONFIG_FUSE_DEBUG option and hide some assertions
and whatnot behind it, ala CONFIG_FUSE_IOMAP_DEBUG*:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tree/fs/fuse/iomap_priv.h?h=djwong-wtf&id=170269a48ae83ea7ce1e23ea5ff39995600efff0

--D

> >>                 data->ff = fuse_write_file_get(fi);
> >> @@ -2182,7 +2186,8 @@ static int fuse_iomap_writeback_submit(struct iomap_writepage_ctx *wpc,
> >>  {
> >>         struct fuse_fill_wb_data *data = wpc->wb_ctx;
> >>
> >> -       WARN_ON_ONCE(!data);
> >> +       if (WARN_ON_ONCE(!data))
> >> +               return error ? error : -EIO;
> >>
> >>         if (data->wpa) {
> >>                 WARN_ON(!data->wpa->ia.ap.num_folios);
> 
> 

