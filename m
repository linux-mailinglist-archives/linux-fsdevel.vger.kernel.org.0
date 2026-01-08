Return-Path: <linux-fsdevel+bounces-72701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49DD0092B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 02:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CC4B3014728
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF8E2222CB;
	Thu,  8 Jan 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGUA78nU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A116CD33
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836517; cv=none; b=IvNxelnuDCATtJZdE8ae1eMYe562FpIaGbLzCXBhYFisUC8BwCKjuZ8Pk7928NKBRnJdeb0PZ7fsqCb+lXPpooh+eScxsiHYVHPHLbCAfrbXvUKCua87ARWyvLIXK1keGPX5lsJZEpX4jJTk9toQyMNQHMVBt5wALXYcxlfJ0M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836517; c=relaxed/simple;
	bh=M9yHR1XfPPJzR6HD84lJ6rex1Ap7BwlzA4/uFO038Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1gxGmbfdFBMYYet8QKXDUGqs1kb9l0/heQ/6YVsv6OzpxQewb7HcXtA/8iHQf8RcczPBxtSHhCN/eNR3QsK8WveWwhqq3BB1yx9Lv118WlLMXZLh1ETqFkcIS7pVtLMcrLKRqrYF6OIPBkv81uyZ5X6AXtws5mf2OT9nQ/YGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGUA78nU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee257e56aaso16962191cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 17:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836514; x=1768441314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoKL+tEiturYQhNE0D7jddJwaxAiO6MVi1FXZcB0yqI=;
        b=JGUA78nUXN3D7jqIXSjOLf/6JQHCgM5lgqXSrFXSc4gQAMwToIflDF45xdCYmDD2u2
         M24Q2lGGE5BgJWuj/STLubCeU9bWCB3YaapHrGeWXGz14Jlpmzkj2yYaxmeCX24J6AUt
         yeadOuVA3lBUmjrWg1ucVUFRdTKfju3jVTXwjCybd/JezlPRFGTkZXFRcoIiDcho6u0l
         ChQRyQ/KNRX532ULB6slRsCkdYO3QRpnXtZ17eLr9qM8etMC3911Xsh4Yo0GQNMY+wE1
         08y4q6vFbw+wHiQY7vJtogaG+al2LsCAE21ggzEK8ooCAt2uH9t6IyugEcmD+coay0GI
         AFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836514; x=1768441314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoKL+tEiturYQhNE0D7jddJwaxAiO6MVi1FXZcB0yqI=;
        b=rn67HqoIOeUcOPSknyWfdtDG4nzPpnoPMsPWAWaJHFiSvoO/68wWw9hUEddbyTkjqi
         9OQu6W6lbuGY5uIvqTXD5SC/fHAsSSWo0x4f5rjYT9nN4XHNAC8yZ7hRGsCE4YqqYR2f
         7UMGP6LNdRAYzdv76ToFyU04ySi9y5Zp21E5I1kw+ZPXQhFzDNUK6Iqv23EME0ucMqFU
         6plc4qKGce7XvGg2S6QUQLFxs8W2h1OgWvLTYm+ggrD4PosU3nnsr/spAmVXUZnJSsVb
         +JM2/8xjwb6g+ML6DG/ICSIYp+z+sbasqYMdwgvfuyiIbX9078b7KGnt3N9xFSm1p3L2
         Xc+g==
X-Forwarded-Encrypted: i=1; AJvYcCWMcrwi4nVXo1AeXMGSVMtQqg42R3efCaypG9QOTmWF3IGMt3q9GHwixhSA/eh+/9Q/6dbVesdXbjacSnrD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywumfcr1uur/eWUTdmVGfef2OfxZgqUrBRyUsk3Cz924eDEVsOF
	wsIRi5SpMYTsWG+IE9N9RB7UBlgvToqBnlT6pSZaXt8bY6dzUy33lKAhWYLxRottLkOAwMXHjs3
	zMuSr7oj4Ukb896Xc0BrN+guNrbEMbl8=
X-Gm-Gg: AY/fxX5HonL+POhcdIcwQ/x0z2fCKK9NisJVpltXRRZwBm5uvUkDyBK+bj13Bra4F1s
	VKBCqh0frcPUgoQlurpkQqeYR+bG59Mmg3giGhnYDO2BGg9XMcOuJae+xhq5/rqoJvbjjSIBnLw
	9SJFlZeSFSc5nxHt9kX748SrAHwm4kiGCOSQ7ECZ+JqqNXKpIUp6T8sdBqi5KH1+l47GWTWY3ix
	lTx26LVkx+qVZwXzlStmMpTka+qNdZeSrVQbgHRbkfuG4qDNNp6UuUVrlVrJmZe1kkQ0Q==
X-Google-Smtp-Source: AGHT+IEMg/zqFBrv5f81U5UoMIqxHwBJsrT92zlLSLlbuhwGjgYvOG1w3lzMfKvoMPrrFPkgLcodFgPrh9OdM8XbW0I=
X-Received: by 2002:ac8:5fcb:0:b0:4ff:82aa:d845 with SMTP id
 d75a77b69052e-4ffb40324b5mr68664381cf.41.1767836514236; Wed, 07 Jan 2026
 17:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <20251223-fuse-compounds-upstream-v2-1-0f7b4451c85e@ddn.com>
 <CAJnrk1b-7zqqDG+vROx=eALGkrM3oU-KDx1zHZtj=F5zP+oaLQ@mail.gmail.com> <aV4hjyza_Xkakaoa@fedora.fritz.box>
In-Reply-To: <aV4hjyza_Xkakaoa@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 7 Jan 2026 17:41:43 -0800
X-Gm-Features: AQt7F2qy5YpYSLm3L9_6tsPg3zG7-n1vwdjCdfx2A0MbFPsE-Plmyk8C_45vSTw
Message-ID: <CAJnrk1Z3mTdZdfe5rTukKOnU0y5dpM8aFTCqbctBWsa-S301TQ@mail.gmail.com>
Subject: Re: Re: [PATCH RFC v2 1/2] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>, 
	syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:29=E2=80=AFAM Horst Birthelmer <horst@birthelmer.d=
e> wrote:
>
Hi Horst,

>
> Hi Joanne,
>
> first ... thank you so much for taking the time.
>
> On Tue, Jan 06, 2026 at 05:40:52PM -0800, Joanne Koong wrote:
> > On Tue, Dec 23, 2025 at 2:13=E2=80=AFPM Horst Birthelmer
> > <hbirthelmer@googlemail.com> wrote:
> > >
> > > For a FUSE_COMPOUND we add a header that contains information
> > > about how many commands there are in the compound and about the
> > > size of the expected result. This will make the interpretation
> > > in libfuse easier, since we can preallocate the whole result.
> > > Then we append the requests that belong to this compound.
> > >
> > > The API for the compound command has:
> > >   fuse_compound_alloc()
> > >   fuse_compound_add()
> > >   fuse_compound_request()
> > >   fuse_compound_free()
> > >
> ...
> > > +
> > > +       if (offset !=3D compound->buffer_pos) {
> > > +               pr_info_ratelimited("FUSE: compound buffer size misma=
tch (calculated %zu bytes, actual %zu bytes)\n",
> > > +                                   offset, compound->buffer_pos);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> >
> > I wonder if this is overkill to have given that the kernel is in
> > charge of setting up the compound request and if the code is right,
> > has done it correctly. imo it adds extra overhead but doesn't offer
> > much given that the kernel code should aalready be correct.
>
> You are completely right. It was just a big help during development and h=
as to be taken out eventually.
> I don't really like #ifdefs very much. Do you think we should throw it ou=
t completely or just not use it in the usual code path?
>

imo I think we should just get rid of it entirely.

> > > +}
> > > +
> > > +int fuse_compound_add(struct fuse_compound_req *compound,
> > > +                     struct fuse_args *args)
> > > +{
> > > +       struct fuse_in_header *hdr;
> > > +       size_t args_size =3D 0;
> > > +       size_t needed_size;
> > > +       size_t expected_out_size =3D 0;
> > > +       int i;
> > > +
> > > +       if (!compound ||
> > > +           compound->compound_header.count >=3D FUSE_MAX_COMPOUND_OP=
S)
> > > +               return -EINVAL;
> > > +
> > > +       if (args->in_pages)
> > > +               return -EINVAL;
> > > +
> > > +       for (i =3D 0; i < args->in_numargs; i++)
> > > +               args_size +=3D args->in_args[i].size;
> > > +
> > > +       for (i =3D 0; i < args->out_numargs; i++)
> > > +               expected_out_size +=3D args->out_args[i].size;
> > > +
> > > +       needed_size =3D sizeof(struct fuse_in_header) + args_size;
> > > +
> > > +       if (compound->buffer_pos + needed_size > compound->buffer_siz=
e) {
> > > +               size_t new_size =3D max(compound->buffer_size * 2,
> > > +                                     compound->buffer_pos + needed_s=
ize);
> > > +               char *new_buffer;
> > > +
> > > +               new_size =3D round_up(new_size, PAGE_SIZE);
> > > +               new_buffer =3D kvrealloc(compound->buffer, new_size,
> > > +                                      GFP_KERNEL);
> > > +               if (!new_buffer)
> > > +                       return -ENOMEM;
> > > +               compound->buffer =3D new_buffer;
> > > +               compound->buffer_size =3D new_size;
> >
> > Hmm... when we're setting up a compound request, we already know the
> > size that will be needed to hold all the requests, right? Do you think
> > it makes sense to allocate that from the get-go in
> > fuse_compound_alloc() and then not have to do any buffer reallocation?
> > I think that also gets rid of fuse_compound_req->total_size, as that
> > would just be the same as fuse_compound_req->buffer_size.
>
> We could do that. But then we would have to have the whole picture from t=
he start.
> What I'm trying to say is (and at the moment there is no example to the c=
ontrary)
> that we could not create a compound without exactly knowing what will be =
in it.
>
> So by the time we do the allocation the calls should all be there.
> I have no counter argument for that at the moment which doesn't mean ther=
e isn't one.
> The API felt more inuitive to me doing alloc, then add, then send, but it=
 would be faster
> the other way around.
>
> >
> > > +       }
> > > +
> > > +       /* Build request header */
> > > +       hdr =3D (struct fuse_in_header *)(compound->buffer +
> > > +                                       compound->buffer_pos);
> > > +       memset(hdr, 0, sizeof(*hdr));
> > > +       hdr->len =3D needed_size;
> > > +       hdr->opcode =3D args->opcode;
> > > +       hdr->nodeid =3D args->nodeid;
> > > +       hdr->uid =3D from_kuid(compound->fm->fc->user_ns, current_fsu=
id());
> > > +       hdr->gid =3D from_kgid(compound->fm->fc->user_ns, current_fsg=
id());
> > > +       hdr->pid =3D pid_nr_ns(task_pid(current), compound->fm->fc->p=
id_ns);
> > > +       hdr->unique =3D fuse_get_unique(&compound->fm->fc->iq);
> > > +       compound->buffer_pos +=3D sizeof(*hdr);
> > > +
> > > +       for (i =3D 0; i < args->in_numargs; i++) {
> > > +               memcpy(compound->buffer + compound->buffer_pos,
> > > +                      args->in_args[i].value, args->in_args[i].size)=
;
> > > +               compound->buffer_pos +=3D args->in_args[i].size;
> > > +       }
> > > +
> > > +       compound->total_expected_out_size +=3D expected_out_size;
> > > +
> > > +       /* Store args for response parsing */
> > > +       compound->op_args[compound->compound_header.count] =3D args;
> > > +
> > > +       compound->compound_header.count++;
> > > +       compound->total_size +=3D needed_size;
> > > +
> > > +       return 0;
> >
> > Does fc->max_pages need to be accounted for as well? iirc, that's the
> > upper limit on how many pages can be forwarded to the server in a
> > request.
> >
> Eventually yes. For open+getattr and lookup+create I didn't think it was =
relevant.
> Am I missing something obvious?

I don't think it's relevant for open+getattr and lookup+create either
since they won't exceed PAGE_SIZE, but imo I think it'd be good to
have the fc->max_pages logic added here since the api is a general
api.

>
> ...
> > > +
> > > +       fuse_args_to_req(req, args);
> > > +
> > > +       if (!args->noreply)
> > > +               __set_bit(FR_ISREPLY, &req->flags);
> > > +
> > > +       __fuse_request_send(req);
> > > +       ret =3D req->out.h.error;
> > > +       if (!ret && args->out_argvar) {
> > > +               BUG_ON(args->out_numargs =3D=3D 0);
> > > +               ret =3D args->out_args[args->out_numargs - 1].size;
> > > +       }
> > > +       fuse_put_request(req);
> > > +       return ret;
> > > +}
> >
> > This logic looks almost identical to the logic in
> > __fuse_simple_request(). Do you think it makes sense to just call into
> > __fuse_simple_request() here?
>
> When I wrote it, I thought I had to do a different error handling.
> After testing I realized, that I could actually treat the compound
> as a normal request.
> So, yes I think so.
> Will be changed in v3.
>
> >
> > > +
> > >  ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
> > >                               struct fuse_mount *fm,
> > >                               struct fuse_args *args)
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 7f16049387d1..86253517f59b 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -1273,6 +1273,20 @@ static inline ssize_t fuse_simple_idmap_reques=
t(struct mnt_idmap *idmap,
> > >  int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *=
args,
> > >                            gfp_t gfp_flags);
> > >
> > > +/**
> > > + * Compound request API
> > > + */
> > > +struct fuse_compound_req;
> > > +ssize_t fuse_compound_request(struct fuse_mount *fm, struct fuse_arg=
s *args);
> > > +ssize_t fuse_compound_send(struct fuse_compound_req *compound);
> > > +
> > > +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm,=
 uint32_t flags);
> > > +int fuse_compound_add(struct fuse_compound_req *compound,
> > > +                   struct fuse_args *args);
> >
> > Looking at how this is used in the 2nd patch (open+getattr), I see
> > that the args are first defined / filled out and then
> > fuse_compound_add() copies them into the compound request's buffer.
> > Instead of having a fuse_compound_add() api that takkes in filled out
> > args, what are your thoughts on having some api that returns back a
> > pointer to the compound buffer's current position, and then the caller
> > can just directly fill that out? I think that ends up saving a memcpy.
> >
> I have to think about that.
> Sounds like a good point, but makes the api slightly more complicated.
>
> > > +int fuse_compound_get_error(struct fuse_compound_req *compound,
> > > +                       int op_idx);
> > > +void fuse_compound_free(struct fuse_compound_req *compound);
> > > +
> >
> > I think an alternative way of doing compound requests, though it would
> > only work on io-uring, is leveraging the io-uring multishot
> > functionality. This allows multiple cqes (requests) to be forwarded
> > together in one system call. Instead of batching X requests into one
> > fuse compound request, I think there would just be X cqes and the
> > normal flow of execution would remain pretty much the same (though on
> > the kernel side there would have to be a head "master request" that
> > request_wait_answer() operates on). Not sure in actuality if this
> > would be more complicated or simpler, but I think your approach here
> > probably makes more sense since it also works for /dev/fuse.
> >
> I had a similar discussion with Bernd for libfuse.
> I completely get your point, but I think it would really complicate thing=
s.
>
> I would really want to keep this as simple as I can, since the handling
> gets complicated very fast the moment we get more calls and have to handl=
e
> pages.
>
> Bernd already had some idea about doing writes while using compounds maki=
ng the
> handling different form /dev/fuse to io-uring was too scary for me.

That makes sense, I think this approach overall is simpler than the
io-uring approach and I agree that simpler is better :) I think for
some compound requests though, it would only suffice with the io-uring
approach due to the inherent limitation of /dev/fuse being bounded by
the size of the lone buffer that's used for reads/writes to the
/dev/fuse fd, whereas with fuse io-uring, the queue is set up with the
capacity to service multiple big buffers in parallel per 1 system
call. This only comes into play, I think, for compounding readahead
and writeback requests. Eg the buffer used for /dev/fuse is usually 1
MB, which means the upper limit is writing back 1 MB per system call,
but with io-uring, the default queue depth is 8 which means we're
potentially able to send 8 MB of writeback data per 1 system call. I
think it'd be very nice if we could reduce the number of system calls
needed for readahead/writeback. I think maybe this could be orthogonal
to the compound requests implementation you have in this patchset (eg
for readahead/writeback, we use io-uring multishot to compound those
requests together to be sent in 1 system call, and for other requests
like open+getattr, we use the compound request infrastructure you've
added here), since some servers may not be using io-uring and overall,
I think implementing io-uring multishot for fuse requests is a lot
simpler if those requests are all background requests (which they are
for readahead/writeback requests).

Thanks,
Joanne

>
> > Thanks,
> > Joanne
> >
>
> Thanks,
> Horst

