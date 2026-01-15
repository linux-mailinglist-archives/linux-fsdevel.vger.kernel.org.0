Return-Path: <linux-fsdevel+bounces-73893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C83BD2306E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1DE4302008B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1A32E6AB;
	Thu, 15 Jan 2026 08:11:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78030E0FB;
	Thu, 15 Jan 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464711; cv=none; b=kX6JBut/HPIU0CkAM9VDFoJhLXi3ACOAMGmUtIuSK3UqPSjNpO45KjV17LX7VgKM2EeMas1bM5Akh8sZHSPWv6yCSZGaBKpT/nKLqZ2Uw+rtcxGOYElPnzu6GD3UFs1GnHHVMgvqso5et3uNTkJON1RQj+IghOhhwgd6w/1tWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464711; c=relaxed/simple;
	bh=EVArVt0ik2Kv9bzGVAoa+VWVbEUcYJK95Lagzu47DhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqH6+OB1756+QYs/ELjKxFoWwzGQDfw3EDFFXXo+lC0iAlad514qvasV/V5ZFJDoi1bzB7V/NBOIEYWNDU2Jc5uKqk72nQVOPx2J90NdmLM7LVRPcDcENlm2L+bbkkSNLbWn62PTlCTQDS6Wa3jr4ksj6NiQ/w1UCedltI0rjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id EE0E2E0143;
	Thu, 15 Jan 2026 09:06:16 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 09:06:16 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v4 2/3] fuse: create helper functions for filling in
 fuse args for open and getattr
Message-ID: <aWifE9GaESLJ3MW5@fedora>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-2-0d3b82a4666f@ddn.com>
 <CAJnrk1aS=zJvBNwUFmM+vos36i3nY2UaZzZv96vDikuHr8SLqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aS=zJvBNwUFmM+vos36i3nY2UaZzZv96vDikuHr8SLqA@mail.gmail.com>

On Wed, Jan 14, 2026 at 06:37:48PM -0800, Joanne Koong wrote:
> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > create fuse_getattr_args_fill() and fuse_open_args_fill() to fill in
> > the parameters for the open and getattr calls.
> >
> > This is in preparation for implementing open+getattr and does not
> > represent any functional change.
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/dir.c    |  9 +--------
> >  fs/fuse/file.c   | 42 ++++++++++++++++++++++++++++++++++--------
> >  fs/fuse/fuse_i.h |  8 ++++++++
> >  3 files changed, 43 insertions(+), 16 deletions(-)
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
> > index 01bc894e9c2b..53744559455d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -23,6 +23,39 @@
> >  #include <linux/task_io_accounting_ops.h>
> >  #include <linux/iomap.h>
> >
> > +/*
> > + * Helper function to initialize fuse_args for OPEN/OPENDIR operations
> > + */
> > +void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
> > +                        struct fuse_open_in *inarg, struct fuse_open_out *outarg)
> > +{
> > +       args->opcode = opcode;
> > +       args->nodeid = nodeid;
> > +       args->in_numargs = 1;
> > +       args->in_args[0].size = sizeof(*inarg);
> > +       args->in_args[0].value = inarg;
> > +       args->out_numargs = 1;
> > +       args->out_args[0].size = sizeof(*outarg);
> > +       args->out_args[0].value = outarg;
> > +}
> > +
> > +/*
> > + * Helper function to initialize fuse_args for GETATTR operations
> > + */
> > +void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
> > +                            struct fuse_getattr_in *inarg,
> > +                            struct fuse_attr_out *outarg)
> > +{
> > +       args->opcode = FUSE_GETATTR;
> > +       args->nodeid = nodeid;
> > +       args->in_numargs = 1;
> > +       args->in_args[0].size = sizeof(*inarg);
> > +       args->in_args[0].value = inarg;
> > +       args->out_numargs = 1;
> > +       args->out_args[0].size = sizeof(*outarg);
> > +       args->out_args[0].value = outarg;
> > +}
> 
> sorry to be so nitpicky but I think we should move this to the
> fuse/dir.c file since that's where the main fuse_do_getattr() function
> lives

That is true. I kept it here since this is the 'second home' and the patch was smaller but that's an easy fix.

> 
> > +
> >  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
> >                           unsigned int open_flags, int opcode,
> >                           struct fuse_open_out *outargp)
> > @@ -40,14 +73,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
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
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 6dddbe2b027b..98ea41f76623 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1179,6 +1179,14 @@ struct fuse_io_args {
> >  void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
> >                          size_t count, int opcode);
> >
> > +/*
> > + * Helper functions to initialize fuse_args for common operations
> > + */
> > +void fuse_open_args_fill(struct fuse_args *args, u64 nodeid, int opcode,
> > +                        struct fuse_open_in *inarg, struct fuse_open_out *outarg);
> 
> I don't think we need this for fuse_open_args_fill() here since it'll
> be used only in the scope of fuse/file.c
> 

That is true. This was a premature optimization on my part since I have a strong suspicion that we will be using more open calls in other compounds.
I agree, let's keep it clean for the moment.

> Thanks,
> Joanne
> 
> > +void fuse_getattr_args_fill(struct fuse_args *args, u64 nodeid,
> > +                           struct fuse_getattr_in *inarg,
> > +                           struct fuse_attr_out *outarg);
> >
> >  struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
> >  void fuse_file_free(struct fuse_file *ff);
> >
> > --
> > 2.51.0
> >

Thanks,
Horst

