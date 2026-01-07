Return-Path: <linux-fsdevel+bounces-72604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B4CFD116
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCC70306EC30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5A1302773;
	Wed,  7 Jan 2026 09:36:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7012FE060;
	Wed,  7 Jan 2026 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778617; cv=none; b=jYMkSGo9BzG3Q18pxNb4EwlmH75fdm/FVf83QaRFPALQJZ2t+BXk2DWvXeuqBB8aCbLa4F9i9mlDlAgs4n5KnuM2P/Ig0HSlpP2lTgS+SXoHFrSS5ZEoodDChNHbZJb/Wj73tmxRBi+4mI2H19IPCD4O2rwb88Gp9HxzaGF/NmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778617; c=relaxed/simple;
	bh=gXVQp7npc6dT/cJLoJjY8lpx7txszNeKOKQkUQQeTe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOMr4y9TcxFY8PougSepLPu8Jst/MqH42ItfRwBf5ZtktIjvGUKRsl5EtSb3UYg4PqJbYkBfnnmevKcQCrkCCxIQWOnQdRvYzRfgim4CUi2Bmfrk1Dewx3MwZlR3jXS+0MPUWdLxp5wsW23kDgK7JQjkkXeCHosJ2qCH/HXW2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 38C1BE02AA;
	Wed,  7 Jan 2026 10:29:32 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 7 Jan 2026 10:29:31 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: Re: [PATCH RFC v2 1/2] fuse: add compound command to combine
 multiple requests
Message-ID: <aV4hjyza_Xkakaoa@fedora.fritz.box>
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


Hi Joanne,

first ... thank you so much for taking the time.

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
> > +       if (offset != compound->buffer_pos) {
> > +               pr_info_ratelimited("FUSE: compound buffer size mismatch (calculated %zu bytes, actual %zu bytes)\n",
> > +                                   offset, compound->buffer_pos);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> 
> I wonder if this is overkill to have given that the kernel is in
> charge of setting up the compound request and if the code is right,
> has done it correctly. imo it adds extra overhead but doesn't offer
> much given that the kernel code should aalready be correct.

You are completely right. It was just a big help during development and has to be taken out eventually.
I don't really like #ifdefs very much. Do you think we should throw it out completely or just not use it in the usual code path?

> > +}
> > +
> > +int fuse_compound_add(struct fuse_compound_req *compound,
> > +                     struct fuse_args *args)
> > +{
> > +       struct fuse_in_header *hdr;
> > +       size_t args_size = 0;
> > +       size_t needed_size;
> > +       size_t expected_out_size = 0;
> > +       int i;
> > +
> > +       if (!compound ||
> > +           compound->compound_header.count >= FUSE_MAX_COMPOUND_OPS)
> > +               return -EINVAL;
> > +
> > +       if (args->in_pages)
> > +               return -EINVAL;
> > +
> > +       for (i = 0; i < args->in_numargs; i++)
> > +               args_size += args->in_args[i].size;
> > +
> > +       for (i = 0; i < args->out_numargs; i++)
> > +               expected_out_size += args->out_args[i].size;
> > +
> > +       needed_size = sizeof(struct fuse_in_header) + args_size;
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

We could do that. But then we would have to have the whole picture from the start.
What I'm trying to say is (and at the moment there is no example to the contrary) 
that we could not create a compound without exactly knowing what will be in it.

So by the time we do the allocation the calls should all be there.
I have no counter argument for that at the moment which doesn't mean there isn't one.
The API felt more inuitive to me doing alloc, then add, then send, but it would be faster
the other way around.

> 
> > +       }
> > +
> > +       /* Build request header */
> > +       hdr = (struct fuse_in_header *)(compound->buffer +
> > +                                       compound->buffer_pos);
> > +       memset(hdr, 0, sizeof(*hdr));
> > +       hdr->len = needed_size;
> > +       hdr->opcode = args->opcode;
> > +       hdr->nodeid = args->nodeid;
> > +       hdr->uid = from_kuid(compound->fm->fc->user_ns, current_fsuid());
> > +       hdr->gid = from_kgid(compound->fm->fc->user_ns, current_fsgid());
> > +       hdr->pid = pid_nr_ns(task_pid(current), compound->fm->fc->pid_ns);
> > +       hdr->unique = fuse_get_unique(&compound->fm->fc->iq);
> > +       compound->buffer_pos += sizeof(*hdr);
> > +
> > +       for (i = 0; i < args->in_numargs; i++) {
> > +               memcpy(compound->buffer + compound->buffer_pos,
> > +                      args->in_args[i].value, args->in_args[i].size);
> > +               compound->buffer_pos += args->in_args[i].size;
> > +       }
> > +
> > +       compound->total_expected_out_size += expected_out_size;
> > +
> > +       /* Store args for response parsing */
> > +       compound->op_args[compound->compound_header.count] = args;
> > +
> > +       compound->compound_header.count++;
> > +       compound->total_size += needed_size;
> > +
> > +       return 0;
> 
> Does fc->max_pages need to be accounted for as well? iirc, that's the
> upper limit on how many pages can be forwarded to the server in a
> request.
> 
Eventually yes. For open+getattr and lookup+create I didn't think it was relevant.
Am I missing something obvious?

...
> > +
> > +       fuse_args_to_req(req, args);
> > +
> > +       if (!args->noreply)
> > +               __set_bit(FR_ISREPLY, &req->flags);
> > +
> > +       __fuse_request_send(req);
> > +       ret = req->out.h.error;
> > +       if (!ret && args->out_argvar) {
> > +               BUG_ON(args->out_numargs == 0);
> > +               ret = args->out_args[args->out_numargs - 1].size;
> > +       }
> > +       fuse_put_request(req);
> > +       return ret;
> > +}
> 
> This logic looks almost identical to the logic in
> __fuse_simple_request(). Do you think it makes sense to just call into
> __fuse_simple_request() here?

When I wrote it, I thought I had to do a different error handling.
After testing I realized, that I could actually treat the compound
as a normal request.
So, yes I think so. 
Will be changed in v3.

> 
> > +
> >  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> >                               struct fuse_mount *fm,
> >                               struct fuse_args *args)
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 7f16049387d1..86253517f59b 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1273,6 +1273,20 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
> >  int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
> >                            gfp_t gfp_flags);
> >
> > +/**
> > + * Compound request API
> > + */
> > +struct fuse_compound_req;
> > +ssize_t fuse_compound_request(struct fuse_mount *fm, struct fuse_args *args);
> > +ssize_t fuse_compound_send(struct fuse_compound_req *compound);
> > +
> > +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, uint32_t flags);
> > +int fuse_compound_add(struct fuse_compound_req *compound,
> > +                   struct fuse_args *args);
> 
> Looking at how this is used in the 2nd patch (open+getattr), I see
> that the args are first defined / filled out and then
> fuse_compound_add() copies them into the compound request's buffer.
> Instead of having a fuse_compound_add() api that takkes in filled out
> args, what are your thoughts on having some api that returns back a
> pointer to the compound buffer's current position, and then the caller
> can just directly fill that out? I think that ends up saving a memcpy.
> 
I have to think about that.
Sounds like a good point, but makes the api slightly more complicated.

> > +int fuse_compound_get_error(struct fuse_compound_req *compound,
> > +                       int op_idx);
> > +void fuse_compound_free(struct fuse_compound_req *compound);
> > +
> 
> I think an alternative way of doing compound requests, though it would
> only work on io-uring, is leveraging the io-uring multishot
> functionality. This allows multiple cqes (requests) to be forwarded
> together in one system call. Instead of batching X requests into one
> fuse compound request, I think there would just be X cqes and the
> normal flow of execution would remain pretty much the same (though on
> the kernel side there would have to be a head "master request" that
> request_wait_answer() operates on). Not sure in actuality if this
> would be more complicated or simpler, but I think your approach here
> probably makes more sense since it also works for /dev/fuse.
> 
I had a similar discussion with Bernd for libfuse.
I completely get your point, but I think it would really complicate things.

I would really want to keep this as simple as I can, since the handling 
gets complicated very fast the moment we get more calls and have to handle
pages.

Bernd already had some idea about doing writes while using compounds making the 
handling different form /dev/fuse to io-uring was too scary for me.

> Thanks,
> Joanne
> 

Thanks,
Horst

