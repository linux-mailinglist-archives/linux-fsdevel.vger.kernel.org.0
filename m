Return-Path: <linux-fsdevel+bounces-73011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C277DD078F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 08:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31C7E301AB94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0872EC55D;
	Fri,  9 Jan 2026 07:26:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2B29CEB;
	Fri,  9 Jan 2026 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767943611; cv=none; b=QasRIM7021/gwttR2C4awajsiWRBOjsSxGCnm2hZ/jVfWOa8emvDv2jvEp3k0XT2C4wXTePWqxlIDgldq0iF829hIS17Q9YF3n9KWrv3tTj1apfo9VERJg79ipt+KNeQ8kzkC2zUtVyfCnAs9/PZZzESGlkeBs9pqq8qIqirnh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767943611; c=relaxed/simple;
	bh=oMeV2HNYHn6tLEsnBAWyn8IEGHhXt9L8R/OYogECrJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj9OdIAzHZRz2gv0RJ1iKqyRRZUWWRMjB1LwIJF03JReR9qdMZe7K+3TVZpqwPArd8iHnvTLxOAbT0/NAA4sZo0CJyeu0GSAM9D/f+DXdVdqk4LjavjsVOeK2gBz48KBw4A2N2oWa9MpCWQa1GFJsBAvM04kF494gVKE1dvCV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 293DBE04A1;
	Fri,  9 Jan 2026 08:20:54 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 9 Jan 2026 08:20:53 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: horst@birthelmer.com, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH RFC v3 3/3] fuse: use the newly created helper
 functions
Message-ID: <aWCrRKV5zWW2vitk@fedora.fritz.box>
References: <20260108-fuse-compounds-upstream-v3-0-8dc91ebf3740@ddn.com>
 <20260108-fuse-compounds-upstream-v3-3-8dc91ebf3740@ddn.com>
 <CAJnrk1Ynob-fqDUf_xrGkGwgj+=6kyhAB=qPVkKHW5ri5frsRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Ynob-fqDUf_xrGkGwgj+=6kyhAB=qPVkKHW5ri5frsRQ@mail.gmail.com>

On Thu, Jan 08, 2026 at 02:19:10PM -0800, Joanne Koong wrote:
> On Thu, Jan 8, 2026 at 6:23 AM <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > new helper functions are:
> > - fuse_getattr_args_fill()
> > - fuse_open_args_fill()
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/dir.c  | 9 +--------
> >  fs/fuse/file.c | 9 +--------
> >  2 files changed, 2 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 4b6b3d2758ff..ca8b69282c60 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -1493,14 +1493,7 @@ static int fuse_do_getattr(struct mnt_idmap *idmap, struct inode *inode,
> >                 inarg.getattr_flags |= FUSE_GETATTR_FH;
> >                 inarg.fh = ff->fh;
> >         }
> > -       args.opcode = FUSE_GETATTR;
> > -       args.nodeid = get_node_id(inode);
> > -       args.in_numargs = 1;
> > -       args.in_args[0].size = sizeof(inarg);
> > -       args.in_args[0].value = &inarg;
> > -       args.out_numargs = 1;
> > -       args.out_args[0].size = sizeof(outarg);
> > -       args.out_args[0].value = &outarg;
> > +       fuse_getattr_args_fill(&args, get_node_id(inode), &inarg, &outarg);
> >         err = fuse_simple_request(fm, &args);
> >         if (!err) {
> >                 if (fuse_invalid_attr(&outarg.attr) ||
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 676f6bfde9f8..c0375b32967d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -73,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
> >                 inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
> >         }
> >
> > -       args.opcode = opcode;
> > -       args.nodeid = nodeid;
> > -       args.in_numargs = 1;
> > -       args.in_args[0].size = sizeof(inarg);
> > -       args.in_args[0].value = &inarg;
> > -       args.out_numargs = 1;
> > -       args.out_args[0].size = sizeof(*outargp);
> > -       args.out_args[0].value = outargp;
> > +       fuse_open_args_fill(&args, nodeid, opcode, &inarg, outargp);
> >
> >         return fuse_simple_request(fm, &args);
> >  }
> >
> 
> This is a very minor nit but imo the split is a bit nicer if patch 2/3
> is this patch with your helper changes:
> 
> +/*
> + * Helper function to initialize fuse_args for OPEN/OPENDIR operations
> + */
> +void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
> + struct fuse_open_in *inarg, struct fuse_open_out *outarg)
> +{
> + args->opcode = opcode;
> ...
> +}
> +
> +/*
> + * Helper function to initialize fuse_args for GETATTR operations
> + */
> +void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
> +     struct fuse_getattr_in *inarg,
> +     struct fuse_attr_out *outarg)
> +{
> + args->opcode = FUSE_GETATTR;
> ...
> +}
> +
> 
> and then patch 3 is your open+getattr changes. That way, it's easier
> to see that the changes in this patch to fuse_do_getattr() and
> fuse_send_open() have no functional changes in logic.

My rational here was, that if people don't like the changes to those functions
I can easily backtrack by just not providing this patch, so basically laziness.

I can easily change that.

Thanks for your explanation.

> 
> 
> Thanks,
> Joanne
> > --
> > 2.51.0
> >

