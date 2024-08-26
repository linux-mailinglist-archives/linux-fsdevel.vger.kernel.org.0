Return-Path: <linux-fsdevel+bounces-27192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917595F543
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05801F220FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2142419309E;
	Mon, 26 Aug 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twbvlj3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9041917DF;
	Mon, 26 Aug 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686707; cv=none; b=faVcfPK2ZaOZgQorTL03dpn+LR3GHg98z8BGIDQhjUe8pTnQo3QEy+9vw6j6rZ0Yrwq5Scobq1cmYMiJxaxeOIHuBB/nxcVo6I1g7J27YbH4VUFWIrTQB3wALyoRkYmmW55oPTZR3r0RTcTIoTU82S6d1r6aiM5YCwsKA7/ILuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686707; c=relaxed/simple;
	bh=AoIeT6J21BOKQIuAxniE8GhuWWyXWeoOWze9RexAtOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9v7f6fH+hUcknHOHIKRlAmFhfMnUbTd/foZeSl7qvDqncd7wbcEn394ezpDqU7jinzWvNK0hs7qvSEgOe97s7B8/DmWSKLu1sJW38Aq0rz6bYQ1y+Wxx3sJvTzROCLUpci4BUToVIwFf5vA33EmjN6XBbYXdNlCQGLgTcByNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twbvlj3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A78C52FC0;
	Mon, 26 Aug 2024 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724686707;
	bh=AoIeT6J21BOKQIuAxniE8GhuWWyXWeoOWze9RexAtOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twbvlj3CYanTaYrMsPN/QVjOnXnJqbnZcX+gdw7cNuurVnxJzFUPlvK8dFZtM5tlm
	 fUFxfY76R/SkTNr5jVxO7lZqrqXaxK422+TH7k2qtKAP8iXUzKHag7Yt7trdpNAotE
	 yuSVthfRghggKLa87ZzHXAsExa/EA84Xf+acgz8VjoV4uCxpUkzxnsM2eeIRitRpRM
	 1fdqQBR3vaijhoRHlWiCzWFo+OGKhJrAvPn3bPlqFWzwgFOGJGpgVaVulCByefn3oX
	 9/aDLGPPfmJFU76t4gqi9g3PGbfboAMEoSwvt7eggtMZ0cd5NAhOx0vm+9+D8th8Y1
	 fPdlBmI+ZUCqQ==
Date: Mon, 26 Aug 2024 11:38:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 15/19] pnfs/flexfiles: enable localio support
Message-ID: <Zsyhco1OrOI_uSbd@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <20240823181423.20458-16-snitzer@kernel.org>
 <172463637116.6062.16257686016201336610@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172463637116.6062.16257686016201336610@noble.neil.brown.name>

On Mon, Aug 26, 2024 at 11:39:31AM +1000, NeilBrown wrote:
> On Sat, 24 Aug 2024, Mike Snitzer wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 
> > If the DS is local to this client use localio to write the data.
> > 
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/flexfilelayout/flexfilelayout.c    | 136 +++++++++++++++++++++-
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
> >  3 files changed, 140 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
> > index 01ee52551a63..d91b640f6c05 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/nfs_mount.h>
> >  #include <linux/nfs_page.h>
> >  #include <linux/module.h>
> > +#include <linux/file.h>
> >  #include <linux/sched/mm.h>
> >  
> >  #include <linux/sunrpc/metrics.h>
> > @@ -162,6 +163,72 @@ decode_name(struct xdr_stream *xdr, u32 *id)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * A dummy definition to make RCU (and non-LOCALIO compilation) happy.
> > + * struct nfsd_file should never be dereferenced in this file.
> > + */
> > +struct nfsd_file {
> > +       int undefined__;
> > +};
> 
> I removed this and tried building both with and without LOCALIO enabled
> and the compiler didn't complain.
> Could you tell me what to do to see the unhappiness you mention?

Sorry, I can remove the dummy definition for upstream.  That was
leftover from the backport I did to 5.15.y stable@ kernel.  Older
kernels' RCU code dereferences what should just be an opaque pointer
and (ab)use typeof.  So without the dummy definition compiling against
5.15.y fails with:

  CC [M]  fs/nfs/flexfilelayout/flexfilelayout.o
In file included from ./include/linux/rbtree.h:24,
                 from ./include/linux/mm_types.h:10,
                 from ./include/linux/mmzone.h:21,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from ./include/linux/nfs_fs.h:23,
                 from fs/nfs/flexfilelayout/flexfilelayout.c:10:
fs/nfs/flexfilelayout/flexfilelayout.c: In function `ff_local_open_fh´:
./include/linux/rcupdate.h:441:9: error: dereferencing pointer to incomplete type `struct nfsd_file´
  typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
         ^
./include/linux/rcupdate.h:580:2: note: in expansion of macro `__rcu_dereference_check´
  __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
  ^~~~~~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:648:28: note: in expansion of macro `rcu_dereference_check´
 #define rcu_dereference(p) rcu_dereference_check(p, 0)
                            ^~~~~~~~~~~~~~~~~~~~~
fs/nfs/flexfilelayout/flexfilelayout.c:193:7: note: in expansion of macro `rcu_dereference´
  nf = rcu_dereference(*pnf);
       ^~~~~~~~~~~~~~~

> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
> > index f84b3fb0dddd..562e7e27a8b5 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.h
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.h
> > @@ -82,7 +82,9 @@ struct nfs4_ff_layout_mirror {
> >  	struct nfs_fh			*fh_versions;
> >  	nfs4_stateid			stateid;
> >  	const struct cred __rcu		*ro_cred;
> > +	struct nfsd_file __rcu		*ro_file;
> >  	const struct cred __rcu		*rw_cred;
> > +	struct nfsd_file __rcu		*rw_file;
> 
> What is the lifetime of a layout_mirror?  Does it live for longer than a
> single IO request?  If so we have a problem as this will pin the
> nfsd_file until the layout is returned.

Ah, yeah lifetime is longer than an IO... so we have the issue of pnfs
(flexfileslayout) holding nfsd_files open in the client; which will
prevent backing filesystem from being unmounted.  I haven't done that
same unmount test (which you reported I fixed for normal NFS) against
pNFS with flexfiles.  Will sort it out.

