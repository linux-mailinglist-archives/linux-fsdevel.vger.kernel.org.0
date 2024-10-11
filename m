Return-Path: <linux-fsdevel+bounces-31791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604EE99AF07
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 01:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6781F22495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C1C1E0B6D;
	Fri, 11 Oct 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUwGeZin"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F728EB;
	Fri, 11 Oct 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688132; cv=none; b=Lnyq+hIUdc2cbqvXI3rUrg7MUp1lew0M7zqps1jwMfAJiInXgL7t3Hvvk/pGVu3uUrOzuOBPsn3koYVpZH3l6qjWi9zylnrCkOS3jWJKDYnmo+yyh7FjdLyAxLwQkbEMAMwimk9tHBMWMHyJ8Z/5iyN+5X11og2jaJFVqs/GJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688132; c=relaxed/simple;
	bh=d4Tz3ZJ7fcXdvW//ObWVbdDWaO6e9uQYs95H6CMYmUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGk+CWyGpLd0rSduGnolbnZ5uW+Y5uwV7YrGAXPJKqu+YqO2wMxA3XItBAL//rTY5WDv6jDJTZ5OlrrYKqwXKQ4Fj7ppXDY8xG5RCQmEOksmiZFEGAXBBYpwMxfaEsK+TiVMBwr29LzTRuwENouOzQQBbW1/AK9puVxDUrSLL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUwGeZin; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4604111f629so22586221cf.3;
        Fri, 11 Oct 2024 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728688130; x=1729292930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcingAt+hW1qpJtEcUVfg5qj20QzsG8bgO+lEiUrk6Y=;
        b=kUwGeZindfes9+RBTcVP0H+6L+6LH8YKFaS587X2STM5F7KsAx6pxVVu0GFfmGYCgJ
         x24qbBbTGEUuy72plj0C1jPfEZGt+zqOMpo44uhg9a/OMX7KBqoulHxQAx0ES1ZuYhuM
         Ck1pShmSbRU/6P09tayAFapaOJ/e8rXsCIJXsnbmtnBlFCvcK7PNn//iXGj6TFjBJiqu
         Uz8XM2UP8AS1nLUYAuq1nJnWOGb4bWbmPnUg0XfRTSJFgl3uo1kn7N1n31SzyZ6EzQCb
         BgVdY1i2vduvnkEuSllwvu2lQtQbaUoOWHzE1K62SZqif+QZVuyBn5x77C87TWJ59pZL
         0RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688130; x=1729292930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcingAt+hW1qpJtEcUVfg5qj20QzsG8bgO+lEiUrk6Y=;
        b=bL27oGu/SxMIlEdqX1vgWJ8uMcZx+wVL9j1XXSv2hO90IZLd9QHa6QZgZ/GyaRBV3T
         vSYoIeJI72BnckUNBLHyZoRDF8ujVdZnP1FtNS9Ut6rxya2O4rwyr/etCnvJvoIKU/5h
         uVUXLdeKzaUoIZML851jaN+zymteMbi1+BpfCF6PYU7OcOIrYOQ9BN9rwgLo4jubXyNi
         QeokkNX81OSUKM4lnLNGFHxRHgQ+NHKM9IDYkpyvPN18uu3/POjEivb2915QiGWWfsVg
         dLuUuznnwyk132C56y6UHTGP4Us6yWE+uoIRS5vWg3LXXzSdc5lbFIF4xAnmhjbrqiO+
         ghMw==
X-Forwarded-Encrypted: i=1; AJvYcCWwZ+zhwZxG52r//rGUzVn7QcZaY7lOd02J0U++ITgwLRGQjbk3o3vOCclTz+4gDUlDk7vyrB3aNRtCfsJJ@vger.kernel.org, AJvYcCXEfz4PO15YyxB37Qt3mAsh5IZcJGccC4G2vysp4HqG2+RUKIAI9eK56s3piO9LyY3eaogsRAEJ768K2XKk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TQ2WKTduKhgQnWseaoeDhNGGyBIRTI2PtDm1dV7yccuDdXXa
	vao7naZd0Jfa2/qLINbdTR4hwv5xDTpW4SvI4yb19sdmz5sjGJcDY3M6uoNqBrtPOGKnn1gQjcv
	82hIgzldXzmmhslSG/FWF1mPQ0ww=
X-Google-Smtp-Source: AGHT+IEjLX0UJQ7dQY2YZjtSj4CIwRLMvg13jizMgk3QLZI4WTb08GVSLVpQHtKh9eEoC+1jUEbWwH2iPZY66RzUKlw=
X-Received: by 2002:a05:622a:1193:b0:458:5bec:41b7 with SMTP id
 d75a77b69052e-4604bbcbb41mr72081181cf.26.1728688129869; Fri, 11 Oct 2024
 16:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <19ffac65-8e1f-431e-a6bd-f942a4b908fe@linux.alibaba.com> <CAJnrk1bcN4k8Ou6xp20Zd5W3k349T3S=QGmxAVmAkF5=B5bq3w@mail.gmail.com>
 <ce7a056d-e4f1-4606-b119-f8e21bbfff55@linux.alibaba.com> <CAJnrk1beWkzsF6uQtkaLoTxNTNR5K4iODb+b6-tMWrN8MXGD4A@mail.gmail.com>
In-Reply-To: <CAJnrk1beWkzsF6uQtkaLoTxNTNR5K4iODb+b6-tMWrN8MXGD4A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 11 Oct 2024 16:08:39 -0700
Message-ID: <CAJnrk1ZjBGzxDnj+PXFNTgqgXgpBoxi3sx2aOBOLaLA2yzX9pA@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 1:55=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Thu, Sep 12, 2024 at 8:35=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba=
.com> wrote:
> >
> > On 9/13/24 7:18 AM, Joanne Koong wrote:
> > > On Wed, Sep 11, 2024 at 2:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.ali=
baba.com> wrote:
> > >>
> > >> Hi all,
> > >>
> > >> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
> > >>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com>=
 wrote:
> > >>>
> > >>>> IIUC, there are two sources that may cause deadlock:
> > >>>> 1) the fuse server needs memory allocation when processing FUSE_WR=
ITE
> > >>>> requests, which in turn triggers direct memory reclaim, and FUSE
> > >>>> writeback then - deadlock here
> > >>>
> > >>> Yep, see the folio_wait_writeback() call deep in the guts of direct
> > >>> reclaim, which sleeps until the PG_writeback flag is cleared.  If t=
hat
> > >>> happens to be triggered by the writeback in question, then that's a
> > >>> deadlock.
> > >>
> > >> After diving deep into the direct reclaim code, there are some insig=
hts
> > >> may be helpful.
> > >>
> > >> Back to the time when the support for fuse writeback is introduced, =
i.e.
> > >> commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, t=
he
> > >> direct reclaim indeed unconditionally waits for PG_writeback flag be=
ing
> > >> cleared.  At that time the direct reclaim is implemented in a two-st=
age
> > >> style, stage 1) pass over the LRU list to start parallel writeback
> > >> asynchronously, and stage 2) synchronously wait for completion of th=
e
> > >> writeback previously started.
> > >>
> > >> This two-stage design and the unconditionally waiting for PG_writeba=
ck
> > >> flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
> > >> stall on writeback during memory compaction") since v3.5.
> > >>
> > >> Though the direct reclaim logic continues to evolve and the waiting =
is
> > >> added back, now the stall will happen only when the direct reclaim i=
s
> > >> triggered from kswapd or memory cgroup.
> > >>
> > >> Specifically the stall will only happen in following certain conditi=
ons
> > >> (see shrink_folio_list() for details):
> > >> 1) kswapd
> > >> 2) or it's a user process under a non-root memory cgroup (actually
> > >> cgroup_v1) with GFP_IO permitted
> > >>
> > >> Thus the potential deadlock does not exist actually (if I'm not wron=
g) if:
> > >> 1) cgroup is not enabled
> > >> 2) or cgroup_v2 is actually used
> > >> 3) or (memory cgroup is enabled and is attached upon cgroup_v1) the =
fuse
> > >> server actually resides under the root cgroup
> > >> 4) or (the fuse server resides under a non-root memory cgroup_v1), b=
ut
> > >> the fuse server advertises itself as a PR_IO_FLUSHER[1]
> > >>
> > >>
> > >> Then we could considering adding a new feature bit indicating that a=
ny
> > >> one of the above condition is met and thus the fuse server is safe f=
rom
> > >> the potential deadlock inside direct reclaim.  When this feature bit=
 is
> > >> set, the kernel side could bypass the temp page copying when doing
> > >> writeback.
> > >>
> > >
> > > Hi Jingbo, thanks for sharing your analysis of this.
> > >
> > > Having the temp page copying gated on the conditions you mentioned
> > > above seems a bit brittle to me. My understanding is that the mm code
> > > for when it decides to stall or not stall can change anytime in the
> > > future, in which case that seems like it could automatically break ou=
r
> > > precondition assumptions.
> >
> > So this is why PR_IO_FLUSHER is introduced here, which is specifically
> > for user space components playing a role in IO stack, e.g. fuse daemon,
> > tcmu/nbd daemon, etc.  PR_IO_FLUSHER offers guarantee similar to
> > GFP_NOIO, but for user space components.  At least we can rely on the
> > assumption that mm would take PR_IO_FLUSHER into account.
> >
> > The limitation of the PR_IO_FLUSHER approach is that, as pointed by
> > Miklos[1], there may be multiple components or services involved to
> > service the fuse requests, and the kernel side has no effective way to
> > check if all services in the whole chain have set PR_IO_FLUSHER.
> >
>
> Right, so doesn't that still bring us back to the original problem
> where if we gate this on any of the one conditions being enough to
> bypass needing the temp page, if the conditions change anytime in the
> future in the mm code, then this would automatically open up the
> potential deadlock in fuse as a byproduct? That seems a bit brittle to
> me to have this dependency.
>

Hi Jingbo,

I had some talks with Josef about this during/after LPC and he came up
with the idea of adding a flag to the 'struct
address_space_operations' to indicate that a folio under writeback
should be skipped during reclaim if it gets to that 3rd case of the
legacy cgroupv1 encountering a folio that has been marked for reclaim.
imo this seems like the most elegant solution and allows us to remove
the temporary folio and rb tree entirely. I sent out a patch for this
https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoong=
@gmail.com/
that I cc'ed you on, the benchmarks show roughly a 20% improvement in
throughput for 4k block size writes and a 40% improvement for 1M block
size writes. I'm curious to see if this speeds up writeback for you as
well on the workloads you're running.


Thanks,
Joanne

> The other alternatives seem to be:
> * adding a timer to writeback requests [1] where if the pages have not
> been copied out to userspace by a certain amount of time, then the
> handler copies out those pages to temporary pages and immediately
> clears writeback on the pages. The timer is canceled as soon as the
> pages will be copied out to userspace.
> * (not sure how possible this is) add some way to tag pages being
> reclaimed/balanced (I saw your comment below about the
> ->migrate_folio() call, which I need to look more into)
>
> The timeout option seems like the most promising one. I don't think
> the code would be that ugly.
>
> Curious to hear your thoughts on this. Are there any other
> alternatives you think could work here?
>
>
> [1] https://lore.kernel.org/all/CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68=
dhMptrgamg@mail.gmail.com/
>
> >
> > > Additionally, if I'm understanding it
> > > correctly, we also would need to know if the writeback is being
> > > triggered from reclaim by kswapd - is there even a way in the kernel
> > > to check that?
> >
> > Nope.  What I mean in the previous email is that, kswapd can get stalle=
d
> > in direct reclaim, while the normal process, e.g. the fuse server, may
> > not get stalled in certain condition, e.g. explicitly advertising
> > PR_IO_FLUSHER.
> >
>
> Gotcha. I just took a look at shrink_folio_list() and now I see the
> "current_is_kswapd()" check.
>
> > >
> > > I'm wondering if there's some way we could tell if a folio is under
> > > reclaim when we're writing it back. I'm not familiar yet with the
> > > reclaim code, but my initial thoughts were whether it'd be possible t=
o
> > > purpose the PG_reclaim flag or perhaps if the folio is not on any lru
> > > list, as an indication that it's being reclaimed. We could then just
> > > use the temp page in those cases, and skip the temp page otherwise.
> >
> > That is a good idea but I'm afraid it doesn't works.  Explained below.
> >
> > >
> > > Could you also point me to where in the reclaim code we end up
> > > invoking the writeback callback? I see pageout() calls ->writepage()
> > > but I'm not seeing where we invoke ->writepages().
> >
> > Yes, the direct reclaim would end up calling ->writepage() to writeback
> > the dirty page.  ->writepages() is only called in normal writeback
> > routine, e.g. when triggered from balance_dirty_page().
> >
> > Also FYI FUSE has removed ->writepage() since commit e1c420a ("fuse:
> > Remove fuse_writepage"), and now it relies on ->migrate_folio(), i.e.
> > memory compacting and the normal writeback routine (triggered from
> > balance_dirty_page()) in low memory.
> >
> > Thus I'm afraid the approach of doing temp page copying only for
> > writeback from direct reclaim code actually doesn't work.  That's
> > because when doing the direct reclaim, the process not only waits for
> > the writeback completion submitted from direct reclaim (e.g. marked wit=
h
> > PG_reclaim, by ->writepage), but may also waits for that submitted from
> > the normal writeback routine (without PG_reclaim marked, by
> > ->writepages). See commit c3b94f4 ("memcg: further prevent OOM with too
> > many dirty pages").
> >
>
> Thanks for the explanation! This is very helpful. The reliance on
> ->migrate_folio() for reclaim is the piece I was missing.
>
> >
> >
> > [1]
> > https://lore.kernel.org/all/CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx=
92T8W6uQ@mail.gmail.com/
> >
> > --
> > Thanks,
> > Jingbo
>
> Thanks,
> Joanne

