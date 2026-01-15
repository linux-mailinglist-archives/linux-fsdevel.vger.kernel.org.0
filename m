Return-Path: <linux-fsdevel+bounces-73898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB738D23177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D751A30DA60F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462B330B34;
	Thu, 15 Jan 2026 08:19:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C132FA19;
	Thu, 15 Jan 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465171; cv=none; b=buJc6DUAtFIgxfHqr5GhJY9O1+53fyJosb7hyduK7uMzalx6FKBJ3gvaEeDe0JcHdPTtp1LZuZlNwnheDSkUWs2dlfPe1kZQGpM8PkfD+yTW/tOWwOljttmVzAOexGqPlCB+zqnBJ9K3ShSuWWashSnaVtFIUEJpg3UJzNjMMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465171; c=relaxed/simple;
	bh=OeeaBZoljXUAlnVq7mXtgabs1NOPEpqGWoEZTQx/aHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2LCI+fmGK5OUdGHowxkUpybU5hhCP7hpfh11MI747Wh2W3ke2Oy8t9371ChWuaZy+96hF94ASeJCcMHXcon8kQpO+DBNe5SsXfj226sTW0flvDVNBN8rxLbkEi0SJ7GI4TeZZCNwNNRCXG3ksQDomr1hYSfvCCwvG/vMleI5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 8E663E03DB;
	Thu, 15 Jan 2026 09:19:20 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 09:19:19 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
Message-ID: <aWigYqmD5RObGzUx@fedora>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
 <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>

On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > The discussion about compound commands in fuse was
> > started over an argument to add a new operation that
> > will open a file and return its attributes in the same operation.
> >
> > Here is a demonstration of that use case with compound commands.
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> >  fs/fuse/file.c   | 110 +++++++++++++++++++++++++++++++++++++++++++++++--------
> >  fs/fuse/fuse_i.h |   7 +++-
> >  fs/fuse/inode.c  |   6 +++
> >  fs/fuse/ioctl.c  |   2 +-
> >  4 files changed, 107 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 53744559455d..c0375b32967d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -152,8 +152,66 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
> >         }
> >  }
> >
...
> > +
> > +       err = fuse_compound_get_error(compound, 0);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = fuse_compound_get_error(compound, 1);
> > +       if (err)
> > +               goto out;
> 
> Hmm, if the open succeeds but the getattr fails, why not process it
> kernel-side as a success for the open? Especially since on the server
> side, libfuse will disassemble the compound request into separate
> ones, so the server has no idea the open is even part of a compound.
> 
For this specific one (open+getattr) you are completely right. That makes total sense.
But there is the possibility in libfuse and a fuse server to process the compound as such. Especially when it has the (not defined in this patch) 'atomic' flag set.
This actually makes me think that there are multiple error handling scenarios.
1. The one we have here. Have errors for every compound request
2. it failed as a compound but no errors for the request (I have to think of a good example for this ;-) )
3. is not supported with the conditions set (like some atomic flags)

That's why I said in the other comment that we probably need two or three different functions here.
This gets complicated fast ....

Let me come up with something in the next version and see what you and the people here think.

> I haven't looked at the rest of the patch yet but this caught my
> attention when i was looking at how fuse_compound_get_error() gets
> used.
> 
> Thanks,
> Joanne
> 

Thanks,
Horst

