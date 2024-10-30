Return-Path: <linux-fsdevel+bounces-33275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267929B6B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2801C20C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B31F4274;
	Wed, 30 Oct 2024 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjtlpg+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906591F4738
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309763; cv=none; b=sWeMEavPKfWDiaolCusr4M+dPX0IhxCED4UAo+TyTs0zOYSSwnE7dYJ1OwZ9CmDWp+KEbF7rcLENTY+iepxRKiN40b5pk9K/fOIwy29dkxX2veBqjF9tfRtSAUtXRNAAFH4/1Ni84NWfpwK5V903t6MJhehpeSPGGXWibaH3uYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309763; c=relaxed/simple;
	bh=gwBp5MSUGfI6TXV6phbvIAYd3clwdxRT14CSUmu058Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUKrKegQDP/u2ckaDb0ITAT+T00td2Fb+PdxwI3+77gMLAYj8bpGOilPKbeUJCJiW2NseaFDM2JEatm8v0KoEgGa7pv3VB4T4FB8vJ3zItTrP7838vDQAaeVpvVkUcW5kSrHXwrVcfnU4igsmSvc4HwgRACBCyHaHQKkbaEeafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjtlpg+T; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460c1ba306bso876311cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730309758; x=1730914558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wg5QAgsMhA2/BDgON/4C0ErrXfNx74mooVbV9XsK58=;
        b=kjtlpg+TrXxE+ESCiJsbgNM0PKX8DZSx5/OvJbhIyeGHrjLd7MfcwrIyGjCuZOdmDq
         u3Sy/7Uep8xoBrp5XKka7ZExC0SzibXoIVv8jP1o4fwk4NRw56jKMxCLBNxRy4nQNsBN
         zzY40bFfu9qWbraCvs/HbuNq/B2S5g7RZzttU3ZzDDnzurCbjKrbnlBntlL9A82A/WI+
         xXTGqjenXxjuP2pKkAC8Ou1O2duGCcMV1kz3E7bEfDKxlerrMKg6AJbzYHzvnK8B1Xsq
         SY8PMAdlw75EVTEcyMElbviXJ/tFWqx1W1nHM8sBL8sokxqMv4OHaibYlZTRx9b+RbA/
         eqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730309758; x=1730914558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wg5QAgsMhA2/BDgON/4C0ErrXfNx74mooVbV9XsK58=;
        b=OA8AxmqXwevzWs3MmYiva1UA5gl3zFnQfYGS9NwDnEzx+htnp51Yq3OV3B8GlySHSf
         n/8IiM17aMfsSw3bpFJ0p01fvZL8WVUgJNcKe5Sn3Rrt6ptOuLeGRyfaFm6UwDB+D9rt
         DqTBCZNzK9y2FiHxvm6zV12kVPPe7oFKJrtAjQc6qEbcS9E4MHUau1JmeTJV49lrem6R
         4BHhkReOSwBanUtNp6bw40f0xZPw0L6as3sv+jY58ZdRhYhaAFYq9tWA6vdT53BbiiEY
         V4czhH3MCxRCLeq/EiSmd9nXJOd8eNIAWVsfE3VtXMYoWn6Ok7mmWPnt63gI0cMm0ldD
         BDUg==
X-Forwarded-Encrypted: i=1; AJvYcCXQEoArmUkA5XHK2JimjXcSJF7W28A91TNVUQrCQJ8Cn3x/njQkx5z3kTmUISWm38RGWL2pBSSJYi5uMpWq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7xMiXfW1Sz0mY2WtNuSTxdEL9Zu1SVF3cIXUEqXMC4eKhvDx
	JoTCGAeUjGtXSym/AX/YR9IRO2S14YtRPj4AITU97x7d/HHfAo6JMQxmp5t5hUkDGhyJ9XVV+O4
	eGzx30/IdTDU1fziyfZftcx2GSjE=
X-Google-Smtp-Source: AGHT+IFQJGKL2jLqEKFDffFJ3XBCCpg4qoR6XYDdr83XvzpfpvEc/SGk0AUv85BAfPAFv+MqR2CeJf8xPISOyl/z0HE=
X-Received: by 2002:a05:622a:1997:b0:458:4353:609f with SMTP id
 d75a77b69052e-4613c1bafebmr216005441cf.59.1730309758505; Wed, 30 Oct 2024
 10:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com> <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJnrk1ZNqLXAM=QZO+rCqarY1ZP=9_naU7WNyrmPAY=Q2Htu_Q@mail.gmail.com>
 <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm> <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm> <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
In-Reply-To: <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Oct 2024 10:35:47 -0700
Message-ID: <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 10:27=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 10/30/24 18:02, Joanne Koong wrote:
> > On Wed, Oct 30, 2024 at 9:21=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> On 10/30/24 17:04, Joanne Koong wrote:
> >>> On Wed, Oct 30, 2024 at 2:32=E2=80=AFAM Bernd Schubert
> >>> <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> On 10/28/24 22:58, Joanne Koong wrote:
> >>>>> On Fri, Oct 25, 2024 at 3:40=E2=80=AFPM Joanne Koong <joannelkoong@=
gmail.com> wrote:
> >>>>>>
> >>>>>>> Same here, I need to look some more into the compaction / page
> >>>>>>> migration paths. I'm planning to do this early next week and will
> >>>>>>> report back with what I find.
> >>>>>>>
> >>>>>>
> >>>>>> These are my notes so far:
> >>>>>>
> >>>>>> * We hit the folio_wait_writeback() path when callers call
> >>>>>> migrate_pages() with mode MIGRATE_SYNC
> >>>>>>    ... -> migrate_pages() -> migrate_pages_sync() ->
> >>>>>> migrate_pages_batch() -> migrate_folio_unmap() ->
> >>>>>> folio_wait_writeback()
> >>>>>>
> >>>>>> * These are the places where we call migrate_pages():
> >>>>>> 1) demote_folio_list()
> >>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>>>>>
> >>>>>> 2) __damon_pa_migrate_folio_list()
> >>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>>>>>
> >>>>>> 3) migrate_misplaced_folio()
> >>>>>> Can ignore this. It calls migrate_pages() in MIGRATE_ASYNC mode
> >>>>>>
> >>>>>> 4) do_move_pages_to_node()
> >>>>>> Can ignore this. This calls migrate_pages() in MIGRATE_SYNC mode b=
ut
> >>>>>> this path is only invoked by the move_pages() syscall. It's fine t=
o
> >>>>>> wait on writeback for the move_pages() syscall since the user woul=
d
> >>>>>> have to deliberately invoke this on the fuse server for this to ap=
ply
> >>>>>> to the server's fuse folios
> >>>>>>
> >>>>>> 5)  migrate_to_node()
> >>>>>> Can ignore this for the same reason as in 4. This path is only inv=
oked
> >>>>>> by the migrate_pages() syscall.
> >>>>>>
> >>>>>> 6) do_mbind()
> >>>>>> Can ignore this for the same reason as 4 and 5. This path is only
> >>>>>> invoked by the mbind() syscall.
> >>>>>>
> >>>>>> 7) soft_offline_in_use_page()
> >>>>>> Can skip soft offlining fuse folios (eg folios with the
> >>>>>> AS_NO_WRITEBACK_WAIT mapping flag set).
> >>>>>> The path for this is soft_offline_page() -> soft_offline_in_use_pa=
ge()
> >>>>>> -> migrate_pages(). soft_offline_page() only invokes this for in-u=
se
> >>>>>> pages in a well-defined state (see ret value of get_hwpoison_page(=
)).
> >>>>>> My understanding of soft offlining pages is that it's a mitigation
> >>>>>> strategy for handling pages that are experiencing errors but are n=
ot
> >>>>>> yet completely unusable, and its main purpose is to prevent future
> >>>>>> issues. It seems fine to skip this for fuse folios.
> >>>>>>
> >>>>>> 8) do_migrate_range()
> >>>>>> 9) compact_zone()
> >>>>>> 10) migrate_longterm_unpinnable_folios()
> >>>>>> 11) __alloc_contig_migrate_range()
> >>>>>>
> >>>>>> 8 to 11 needs more investigation / thinking about. I don't see a g=
ood
> >>>>>> way around these tbh. I think we have to operate under the assumpt=
ion
> >>>>>> that the fuse server running is malicious or benevolently but
> >>>>>> incorrectly written and could possibly never complete writeback. S=
o we
> >>>>>> definitely can't wait on these but it also doesn't seem like we ca=
n
> >>>>>> skip waiting on these, especially for the case where the server us=
es
> >>>>>> spliced pages, nor does it seem like we can just fail these with
> >>>>>> -EBUSY or something.
> >>>>
> >>>> I see some code paths with -EAGAIN in migration. Could you explain w=
hy
> >>>> we can't just fail migration for fuse write-back pages?
> >>>>
> >>
> >> Hi Joanne,
> >>
> >> thanks a lot for your quick reply (especially as my reviews come in ve=
ry
> >> late).
> >>
> >
> > Thanks for your comments/reviews, Bernd! I always appreciate them.
> >
> >>>
> >>> My understanding (and please correct me here Shakeel if I'm wrong) is
> >>> that this could block system optimizations, especially since if an
> >>> unprivileged malicious fuse server never replies to the writeback
> >>> request, then this completely stalls progress. In the best case
> >>> scenario, -EAGAIN could be used because the server might just be slow
> >>> in serving the writeback, but I think we need to also account for
> >>> servers that never complete the writeback. For
> >>> __alloc_contig_migrate_range() for example, my understanding is that
> >>> this is used to migrate pages so that there are more physically
> >>> contiguous ranges of memory freed up. If fuse writeback blocks that,
> >>> then that hurts system health overall.
> >>
> >> Hmm, I wonder what is worse - tmp page copies or missing compaction.
> >> Especially if we expect a low range of in-writeback pages/folios.
> >> One could argue that an evil user might spawn many fuse server
> >> processes to work around the default low fuse write-back limits, but
> >> does that make any difference with tmp pages? And these cannot be
> >> compacted either?
> >
> > My understanding (and Shakeel please jump in here if this isn't right)
> > is that tmp pages can be migrated/compacted. I think it's only pages
> > marked as under writeback that are considered to be non-movable.
> >
> >>
> >> And with timeouts that would be so far totally uncritical, I
> >> think.
> >>
> >>
> >> You also mentioned
> >>
> >>> especially for the case where the server uses spliced pages
> >>
> >> could you provide more details for that?
> >>
> 7>
> > For the page migration / compaction paths, I don't think we can do the
> > workaround we could do for sync where we skip waiting on writeback for
> > fuse folios and continue on with the operation, because the migration
> > / compaction paths operate on the pages. For the splice case, we
> > assign the page to the pipebuffer (fuse_ref_page()), so if the
> > migration/compaction happens on the page before the server has read
> > this page from the pipebuffer, it'll be incorrect data or maybe crash
> > the kernel.
> >
> >>
> >>
> >>>
> >>>>>>
> >>>>>
> >>>>> I'm still not seeing a good way around this.
> >>>>>
> >>>>> What about this then? We add a new fuse sysctl called something lik=
e
> >>>>> "/proc/sys/fs/fuse/writeback_optimization_timeout" where if the sys
> >>>>> admin sets this, then it opts into optimizing writeback to be as fa=
st
> >>>>> as possible (eg skipping the page copies) and if the server doesn't
> >>>>> fulfill the writeback by the set timeout value, then the connection=
 is
> >>>>> aborted.
> >>>>>
> >>>>> Alternatively, we could also repurpose
> >>>>> /proc/sys/fs/fuse/max_request_timeout from the request timeout
> >>>>> patchset [1] but I like the additional flexibility and explicitness
> >>>>> having the "writeback_optimization_timeout" sysctl gives.
> >>>>>
> >>>>> Any thoughts on this?
> >>>>
> >>>>
> >>>> I'm a bit worried that we might lock up the system until time out is
> >>>> reached - not ideal. Especially as timeouts are in minutes now. But
> >>>> even a slightly stuttering video system not be great. I think we
> >>>> should give users/admin the choice then, if they prefer slow page
> >>>> copies or fast, but possibly shortly unresponsive system.
> >>>>
> >>> I was thinking the /proc/sys/fs/fuse/writeback_optimization_timeout
> >>> would be in seconds, where the sys admin would probably set something
> >>> more reasonable like 5 seconds or so.
> >>> If this syctl value is set, then servers who want writebacks to be
> >>> fast can opt into it at mount time (and by doing so agree that they
> >>> will service writeback requests by the timeout or their connection
> >>> will be aborted).
> >>
> >>
> >> I think your current patch set has it in minutes? (Should be easy
> >> enough to change that.) Though I'm more worried about the impact
> >> of _frequent_ timeout scanning through the different fuse lists
> >> on performance, than about missing compaction for folios that are
> >> currently in write-back.
>
> Hmm, if tmp pages can be compacted, isn't that a problem for splice?
> I.e. I don't understand what the difference between tmp page and
> write-back page for migration.
>

That's a great question! I have no idea how compaction works for pages
being used in splice. Shakeel, do you know the answer to this?


Thanks,
Joanne

>
> >>
> >
> > Ah, for this the " /proc/sys/fs/fuse/writeback_optimization_timeout"
> > would be a separate thing from the
> > "/proc/sys/fs/fuse/max_request_timeout". The
> > "/proc/sys/fs/fuse/writeback_optimization_timeout" would only apply
> > for writeback requests. I was thinking implementation-wise, for
> > writebacks we could just have a timer associated with each request
> > (instead of having to grab locks with the fuse lists), since they
> > won't be super common.
>
> Ah, thank you! I had missed that this is another variable. Issue
> with too short timeouts would probably be network hick-up that
> would immediately kill fuse-server. I.e. if it just the missing
> page compaction/migration, maybe larger time outs would be
> acceptable.
>
>
> Thanks,
> Bernd

