Return-Path: <linux-fsdevel+bounces-72617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D1CFE2BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3789C307DEA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2ED328B5B;
	Wed,  7 Jan 2026 14:03:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942F329E69;
	Wed,  7 Jan 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794634; cv=none; b=DqHKMmHkU52eimQ95g/3B2jHf5yMBfzewFxb92MB8FEqVaxeB0druQIvb2rNSwxSLwQd6QaurWQ7v6pD7nBSZkMflgKdxrR8ND4S4ZipTYqe9JiPtzatUJtC4P+aM8fNFAl3bE0T0hm+zoRxiE95IohLkSizCkcW1hDTQsVjusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794634; c=relaxed/simple;
	bh=+eQnaHuWZv2ZkgkfOXyskZrdcyLy9PbKFAADq+/ZjLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei6BFlfx6m3xlXF4cXs0SYiEVioSwmyfLan++Vm1FbjUnrB0j5/rgyzwTQx+lnQ2idt21k6z7ddXUTCelorT2E1GczPSx4NvvG0vuGcoPCXnPXgiUOOI9QQ6oP3YaOVpvxVjvFkKv/hykfgH66BcQAmCRGmocRNg5kqpk4SWIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id C8AC7E02BA;
	Wed,  7 Jan 2026 15:03:46 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 7 Jan 2026 15:03:45 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: Re: [PATCH RFC v2 1/2] fuse: add compound command to combine
 multiple requests
Message-ID: <aV5l5OxMuyYs8mzQ@fedora.fritz.box>
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
 <CAJnrk1b-7zqqDG+vROx=eALGkrM3oU-KDx1zHZtj=F5zP+oaLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b-7zqqDG+vROx=eALGkrM3oU-KDx1zHZtj=F5zP+oaLQ@mail.gmail.com>

On Tue, Jan 06, 2026 at 05:40:52PM -0800, Joanne Koong wrote:
> On Tue, Dec 23, 2025 at 2:13 PM Horst Birthelmer
> <hbirthelmer@googlemail.com> wrote:
> >
> > For a FUSE_COMPOUND we add a header that contains information
> > about how many commands there are in the compound and about the
> > size of the expected result. This will make the interpretation
> > in libfuse easier, since we can preallocate the whole result.
> > Then we append the requests that belong to this compound.
> >
> > The API for the compound command has:
> >   fuse_compound_alloc()
> >   fuse_compound_add()
> >   fuse_compound_request()
> >   fuse_compound_free()
> >
...
> > +
> > +       if (compound->buffer_pos + needed_size > compound->buffer_size) {
> > +               size_t new_size = max(compound->buffer_size * 2,
> > +                                     compound->buffer_pos + needed_size);
> > +               char *new_buffer;
> > +
> > +               new_size = round_up(new_size, PAGE_SIZE);
> > +               new_buffer = kvrealloc(compound->buffer, new_size,
> > +                                      GFP_KERNEL);
> > +               if (!new_buffer)
> > +                       return -ENOMEM;
> > +               compound->buffer = new_buffer;
> > +               compound->buffer_size = new_size;
> 
> Hmm... when we're setting up a compound request, we already know the
> size that will be needed to hold all the requests, right? Do you think
> it makes sense to allocate that from the get-go in
> fuse_compound_alloc() and then not have to do any buffer reallocation?
> I think that also gets rid of fuse_compound_req->total_size, as that
> would just be the same as fuse_compound_req->buffer_size.
> 
After looking at this again, I realized it would be more efficient to not do any allocation
in fuse_compound_alloc() at all except for the fuse_compound_req, of course, and then
do all the work in fuse_compound_send().
We keep pointers to the fuse_args given to the compound command anyway since we need
to fill out the result, so why not keep just the fuse args and don't copy anything
except when actually sending it out?

I will test this version a bit and make a simplified v3.

...
> 
> Thanks,
> Joanne

Thanks, 
Horst

