Return-Path: <linux-fsdevel+bounces-14130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2B8780C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BF91C20A39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD323FB9C;
	Mon, 11 Mar 2024 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ykb14C9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB03FB3C;
	Mon, 11 Mar 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164567; cv=none; b=F7nJW4rGlS8c9XSfFrU25FGTl8AHScR70Oy0bIGsz3xtTWlO0gVzAnk9hO4TLvm4SxEUBGjbt+TFlwrKP9r2/PGPgK51HMHhD/AoHOW2e58Yv3QisBFLrY/mGfTRhV6rpcumGK+jgD8i/WCu5HBQyCb1Tlft5Qxvc1q7Hhx7D24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164567; c=relaxed/simple;
	bh=+I/Wk9Nub0tk6WhdxOcXtTKXBuiR4vGpTpqcFipyRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUaazorI+dJNtFwIsIpnnRKeyMFZzEW5PdYU2f/Tyk3AZBwtSYobQTP5l41Nw4wZU2LlKfmmLQQW6sztVaUdUdicyzCOivE0RP1jgy/VqwkBTRAihYAkKuc/9D/UC+IP2LQvgofESnAtq8TVKK+5VUfiPPurr5vbwG5Vi9wzoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ykb14C9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A6AC433C7;
	Mon, 11 Mar 2024 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710164566;
	bh=+I/Wk9Nub0tk6WhdxOcXtTKXBuiR4vGpTpqcFipyRjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ykb14C9xDvUI6EhvVZQRIzqqHG8W0Jb0uw63NWw4hLZ6Yrokcqa6OrCpIHiNMm8rt
	 s+h07Wjqc+lUjPymS7X/gqkluiWcPzai72t4kUNk4swW0NW5aNaBTwwUj9OpqSH7sr
	 G/SoUmqAlfkX8JhjM2lfwv37A2ebD1RQY/l09K+AawioH5eyo2VsPKOBt9KqapJHea
	 eN6vhASYUmI6/Nb1tfTIWofukRJPyH5Nzk/qR+qeTBLJm5MXyo4SCakkEr5uEz51pR
	 DCubKYwMYTF0d68ay6SaBfuU2vytZ6i2eaCxMGgcNjvCZjHhh9Diff3cYm2TT2nE9K
	 1tSymQSy2xkCg==
Date: Mon, 11 Mar 2024 14:42:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Neal Gompa <neal@gompa.dev>, linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240311-anbringen-pelle-1d1eaa78961a@brauner>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308165633.GO6184@frogsfrogsfrogs>

On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> On Fri, Mar 08, 2024 at 11:48:31AM -0500, Kent Overstreet wrote:
> > On Fri, Mar 08, 2024 at 11:44:48AM -0500, Neal Gompa wrote:
> > > On Fri, Mar 8, 2024 at 11:34 AM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Fri, Mar 08, 2024 at 06:42:27AM -0500, Neal Gompa wrote:
> > > > > On Thu, Mar 7, 2024 at 9:29 PM Kent Overstreet
> > > > > <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > > > > btrfs and bcachefs.
> > > > > >
> > > > > > This includes bcachefs support; we'll definitely want btrfs support as
> > > > > > well.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > > > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > > > > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > > > > ---
> > > > > >  fs/bcachefs/fs.c          | 3 +++
> > > > > >  fs/stat.c                 | 1 +
> > > > > >  include/linux/stat.h      | 1 +
> > > > > >  include/uapi/linux/stat.h | 4 +++-
> > > > > >  4 files changed, 8 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > > > > > index 3f073845bbd7..6a542ed43e2c 100644
> > > > > > --- a/fs/bcachefs/fs.c
> > > > > > +++ b/fs/bcachefs/fs.c
> > > > > > @@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
> > > > > >         stat->blksize   = block_bytes(c);
> > > > > >         stat->blocks    = inode->v.i_blocks;
> > > > > >
> > > > > > +       stat->subvol    = inode->ei_subvol;
> > > > > > +       stat->result_mask |= STATX_SUBVOL;
> > > > > > +
> > > > > >         if (request_mask & STATX_BTIME) {
> > > > > >                 stat->result_mask |= STATX_BTIME;
> > > > > >                 stat->btime = bch2_time_to_timespec(c, inode->ei_inode.bi_otime);
> > > > > > diff --git a/fs/stat.c b/fs/stat.c
> > > > > > index 77cdc69eb422..70bd3e888cfa 100644
> > > > > > --- a/fs/stat.c
> > > > > > +++ b/fs/stat.c
> > > > > > @@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
> > > > > >         tmp.stx_mnt_id = stat->mnt_id;
> > > > > >         tmp.stx_dio_mem_align = stat->dio_mem_align;
> > > > > >         tmp.stx_dio_offset_align = stat->dio_offset_align;
> > > > > > +       tmp.stx_subvol = stat->subvol;
> > > > > >
> > > > > >         return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> > > > > >  }
> > > > > > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > > > > > index 52150570d37a..bf92441dbad2 100644
> > > > > > --- a/include/linux/stat.h
> > > > > > +++ b/include/linux/stat.h
> > > > > > @@ -53,6 +53,7 @@ struct kstat {
> > > > > >         u32             dio_mem_align;
> > > > > >         u32             dio_offset_align;
> > > > > >         u64             change_cookie;
> > > > > > +       u64             subvol;
> > > > > >  };
> > > > > >
> > > > > >  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> > > > > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > > > > index 2f2ee82d5517..67626d535316 100644
> > > > > > --- a/include/uapi/linux/stat.h
> > > > > > +++ b/include/uapi/linux/stat.h
> > > > > > @@ -126,8 +126,9 @@ struct statx {
> > > > > >         __u64   stx_mnt_id;
> > > > > >         __u32   stx_dio_mem_align;      /* Memory buffer alignment for direct I/O */
> > > > > >         __u32   stx_dio_offset_align;   /* File offset alignment for direct I/O */
> > > > > > +       __u64   stx_subvol;     /* Subvolume identifier */
> > > > > >         /* 0xa0 */
> > > > > > -       __u64   __spare3[12];   /* Spare space for future expansion */
> > > > > > +       __u64   __spare3[11];   /* Spare space for future expansion */
> > > > > >         /* 0x100 */
> > > > > >  };
> > > > > >
> > > > > > @@ -155,6 +156,7 @@ struct statx {
> > > > > >  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
> > > > > >  #define STATX_DIOALIGN         0x00002000U     /* Want/got direct I/O alignment info */
> > > > > >  #define STATX_MNT_ID_UNIQUE    0x00004000U     /* Want/got extended stx_mount_id */
> > > > > > +#define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol */
> > > > > >
> > > > > >  #define STATX__RESERVED                0x80000000U     /* Reserved for future struct statx expansion */
> > > > > >
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > > >
> > > > >
> > > > > I think it's generally expected that patches that touch different
> > > > > layers are split up. That is, we should have a patch that adds the
> > > > > capability and a separate patch that enables it in bcachefs. This also
> > > > > helps make it clearer to others how a new feature should be plumbed
> > > > > into a filesystem.
> > > > >
> > > > > I would prefer it to be split up in this manner for this reason.
> > > >
> > > > I'll do it that way if the patch is big enough that it ought to be
> > > > split up. For something this small, seeing how it's used is relevant
> > > > context for both reviewers and people looking at it afterwards.
> > > >
> > > 
> > > It needs to also be split up because fs/ and fs/bcachefs are
> > > maintained differently. And while right now bcachefs is the only
> > > consumer of the API, btrfs will add it right after it's committed, and
> > > for people who are cherry-picking/backporting accordingly, having to
> > > chop out part of a patch would be unpleasant.
> > 
> > It's a new feature, not a bugfix, this should never get backported. And
> > I the bcachefs maintainer wrote the patch, and I'm submitting it to the
> > VFS maintainer, so if it's fine with him it's fine with me.
> 
> But then how am I supposed to bikeshed the structure of the V2 patchset
> by immediately asking you to recombine the patches and spit out a V3?
> 
> </sarcasm>

I see no reason to split this up. Especially given how small the patch
is. If there's a good reason such as meaningful merge conflicts then we
can always move to a stable branch for the infrastructure changes that
everyone else can pull from.

> 
> But, seriously, can you update the manpage too?  Is stx_subvol a u64
> cookie where userspace mustn't try to read anything into its contents?
> Just like st_ino and st_dev are (supposed) to be?

I was honestly hoping for a more elaborate patch description that would
have explained this. But I can just add this and yes, this is how I
conceptualized it and how we've always discussed it before.

