Return-Path: <linux-fsdevel+bounces-29365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071D978A43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4454B1C21F90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7B1537DA;
	Fri, 13 Sep 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggmGxdN3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79516E61B;
	Fri, 13 Sep 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260918; cv=none; b=SwSqXXfQzcxCkJKEb+IlU2m162Wdc3GtJKUieOsJyrc63pmgSpcmEEwuEhpdtNEef9TqtJOpVjenqZoA9JSfmYceV0XDde0qxuTrbVVwoG7VtRXW+2+CXdd9pCt5YxTbaE7paZJpSZ84JhoXbK5n5bDDgk6b/DOHTmmHtytrKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260918; c=relaxed/simple;
	bh=Z1XBAbgYmw8YIwLJs7IEKr+reOQanHF29uIUJKT5TVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1z1A90De6DfiS9YDkZyPHgPj+8I8BGL9HWmJPL8gie538Es/weaF4EePx3efeGO1FASGogiGe7kSoiwdO7+p97xlTFpBKuazhifbKSrrSD6kP2kKIyBmHwZYkjHm++Uz6BHrePmwaouVspKOJ56W8DIGzTDMx0en4ilF/iHFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggmGxdN3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4582760b79cso13336551cf.2;
        Fri, 13 Sep 2024 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726260915; x=1726865715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWz8NpK90UXKM6MGuUsbwjni1csa8n13hFbkhCIz6HU=;
        b=ggmGxdN38WocZ57uIkXusxsT8dJU7NhoK9Xm2bjvFThe/FHnDAFwTUCzTC+ZcID1NV
         T0qTLp2A33XUzVlH1x9ZFZ6tghWg0EAk9sBz/LWhc5T6mWwb/6jemzxyxjO3XCSR07Ji
         lyOx+dmh/kWH/APwIVpIEfNApkDklkQCc1YY61Jpa5SLu7TqZcKV/aIQRezOsDXRzphn
         S84EM1CfMyynPEYtOFj3S3t9PW4VInQgDdIiAc3XHs1mfpGr1dsYnaKk+e6FvHOynrfp
         oWScL6L/S6ZDU4MK0kcHB+GznJO+zW/MkIwMbwaPq4ogxCFtkoKz/+JQuDDMsDWMmsa9
         o03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726260915; x=1726865715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWz8NpK90UXKM6MGuUsbwjni1csa8n13hFbkhCIz6HU=;
        b=jE33uB9y+Vz0C9tp+8MgxXedUCisEzE/pQbpbGaR+17bf8QxpfU87TI7JN+T6liBpY
         wuYzjNroDF+/7dlvP94FA6xMgsISpIK7zzF2bKWsMD7l6U1Dyg19Ru45ku2hAMoM1zM9
         USS2qm4JtQiiSyn2jsNt940pY8hE9ZmdKRetoXjLWHtHOCKar08I8drr4VOadtoJT0ib
         iFbUsvgmwGNUf9MBcx1iyOMXV715bAHSo/vq//rbLvxLY1LGnacVIPmaVmTMfAADVMTo
         wf4vcDesDzIv37U6A6x11/DbAuoZvSfUjRGoS1mcEje2J7IUlY9nesypte48/t2CWpbp
         tDgg==
X-Forwarded-Encrypted: i=1; AJvYcCW7VokCd+RzZ+4JpfnLUIEVzgJ1dXU0G0mRR7VxPeHXJdpFKzHmHbSIPgkaun/clef/jPGAYVOaQ2DWE5dn@vger.kernel.org, AJvYcCWI3gU/Toxz8kKYMnJ7O9Yo5Eifl/SDiR5PhsxLnODHm0UuaIwSB9SEvncbWlrDWXoQRyvvSJMHTkXCrn5l@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnSIEAupqSbiQhkedA1ryiVxp0WByx/csONNrqT4MZw0ZIEoS
	ytm7lGY3lmX+xpEDcX3Yu/c8caApKsMt7lXo52UGUyBjcwramPQKeaBZeKI4sVbXSP1Ie6AURK3
	Zdp4/6z78E0nu8hyhhl0tgS4FOYQ=
X-Google-Smtp-Source: AGHT+IEzAgmQDWv/AggdEZkuYqS6NzkZob0viK21n1/QnuxtF6GzRb6jrCc/wmchmcx4MPd2OVFW2zeUlcWffFHEZes=
X-Received: by 2002:ac8:5792:0:b0:456:89a6:ec00 with SMTP id
 d75a77b69052e-458603cc3afmr134884151cf.39.1726260915403; Fri, 13 Sep 2024
 13:55:15 -0700 (PDT)
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
 <ce7a056d-e4f1-4606-b119-f8e21bbfff55@linux.alibaba.com>
In-Reply-To: <ce7a056d-e4f1-4606-b119-f8e21bbfff55@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Sep 2024 13:55:04 -0700
Message-ID: <CAJnrk1beWkzsF6uQtkaLoTxNTNR5K4iODb+b6-tMWrN8MXGD4A@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 8:35=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
> On 9/13/24 7:18 AM, Joanne Koong wrote:
> > On Wed, Sep 11, 2024 at 2:32=E2=80=AFAM Jingbo Xu <jefflexu@linux.aliba=
ba.com> wrote:
> >>
> >> Hi all,
> >>
> >> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
> >>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> w=
rote:
> >>>
> >>>> IIUC, there are two sources that may cause deadlock:
> >>>> 1) the fuse server needs memory allocation when processing FUSE_WRIT=
E
> >>>> requests, which in turn triggers direct memory reclaim, and FUSE
> >>>> writeback then - deadlock here
> >>>
> >>> Yep, see the folio_wait_writeback() call deep in the guts of direct
> >>> reclaim, which sleeps until the PG_writeback flag is cleared.  If tha=
t
> >>> happens to be triggered by the writeback in question, then that's a
> >>> deadlock.
> >>
> >> After diving deep into the direct reclaim code, there are some insight=
s
> >> may be helpful.
> >>
> >> Back to the time when the support for fuse writeback is introduced, i.=
e.
> >> commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, the
> >> direct reclaim indeed unconditionally waits for PG_writeback flag bein=
g
> >> cleared.  At that time the direct reclaim is implemented in a two-stag=
e
> >> style, stage 1) pass over the LRU list to start parallel writeback
> >> asynchronously, and stage 2) synchronously wait for completion of the
> >> writeback previously started.
> >>
> >> This two-stage design and the unconditionally waiting for PG_writeback
> >> flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
> >> stall on writeback during memory compaction") since v3.5.
> >>
> >> Though the direct reclaim logic continues to evolve and the waiting is
> >> added back, now the stall will happen only when the direct reclaim is
> >> triggered from kswapd or memory cgroup.
> >>
> >> Specifically the stall will only happen in following certain condition=
s
> >> (see shrink_folio_list() for details):
> >> 1) kswapd
> >> 2) or it's a user process under a non-root memory cgroup (actually
> >> cgroup_v1) with GFP_IO permitted
> >>
> >> Thus the potential deadlock does not exist actually (if I'm not wrong)=
 if:
> >> 1) cgroup is not enabled
> >> 2) or cgroup_v2 is actually used
> >> 3) or (memory cgroup is enabled and is attached upon cgroup_v1) the fu=
se
> >> server actually resides under the root cgroup
> >> 4) or (the fuse server resides under a non-root memory cgroup_v1), but
> >> the fuse server advertises itself as a PR_IO_FLUSHER[1]
> >>
> >>
> >> Then we could considering adding a new feature bit indicating that any
> >> one of the above condition is met and thus the fuse server is safe fro=
m
> >> the potential deadlock inside direct reclaim.  When this feature bit i=
s
> >> set, the kernel side could bypass the temp page copying when doing
> >> writeback.
> >>
> >
> > Hi Jingbo, thanks for sharing your analysis of this.
> >
> > Having the temp page copying gated on the conditions you mentioned
> > above seems a bit brittle to me. My understanding is that the mm code
> > for when it decides to stall or not stall can change anytime in the
> > future, in which case that seems like it could automatically break our
> > precondition assumptions.
>
> So this is why PR_IO_FLUSHER is introduced here, which is specifically
> for user space components playing a role in IO stack, e.g. fuse daemon,
> tcmu/nbd daemon, etc.  PR_IO_FLUSHER offers guarantee similar to
> GFP_NOIO, but for user space components.  At least we can rely on the
> assumption that mm would take PR_IO_FLUSHER into account.
>
> The limitation of the PR_IO_FLUSHER approach is that, as pointed by
> Miklos[1], there may be multiple components or services involved to
> service the fuse requests, and the kernel side has no effective way to
> check if all services in the whole chain have set PR_IO_FLUSHER.
>

Right, so doesn't that still bring us back to the original problem
where if we gate this on any of the one conditions being enough to
bypass needing the temp page, if the conditions change anytime in the
future in the mm code, then this would automatically open up the
potential deadlock in fuse as a byproduct? That seems a bit brittle to
me to have this dependency.

The other alternatives seem to be:
* adding a timer to writeback requests [1] where if the pages have not
been copied out to userspace by a certain amount of time, then the
handler copies out those pages to temporary pages and immediately
clears writeback on the pages. The timer is canceled as soon as the
pages will be copied out to userspace.
* (not sure how possible this is) add some way to tag pages being
reclaimed/balanced (I saw your comment below about the
->migrate_folio() call, which I need to look more into)

The timeout option seems like the most promising one. I don't think
the code would be that ugly.

Curious to hear your thoughts on this. Are there any other
alternatives you think could work here?


[1] https://lore.kernel.org/all/CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dh=
Mptrgamg@mail.gmail.com/

>
> > Additionally, if I'm understanding it
> > correctly, we also would need to know if the writeback is being
> > triggered from reclaim by kswapd - is there even a way in the kernel
> > to check that?
>
> Nope.  What I mean in the previous email is that, kswapd can get stalled
> in direct reclaim, while the normal process, e.g. the fuse server, may
> not get stalled in certain condition, e.g. explicitly advertising
> PR_IO_FLUSHER.
>

Gotcha. I just took a look at shrink_folio_list() and now I see the
"current_is_kswapd()" check.

> >
> > I'm wondering if there's some way we could tell if a folio is under
> > reclaim when we're writing it back. I'm not familiar yet with the
> > reclaim code, but my initial thoughts were whether it'd be possible to
> > purpose the PG_reclaim flag or perhaps if the folio is not on any lru
> > list, as an indication that it's being reclaimed. We could then just
> > use the temp page in those cases, and skip the temp page otherwise.
>
> That is a good idea but I'm afraid it doesn't works.  Explained below.
>
> >
> > Could you also point me to where in the reclaim code we end up
> > invoking the writeback callback? I see pageout() calls ->writepage()
> > but I'm not seeing where we invoke ->writepages().
>
> Yes, the direct reclaim would end up calling ->writepage() to writeback
> the dirty page.  ->writepages() is only called in normal writeback
> routine, e.g. when triggered from balance_dirty_page().
>
> Also FYI FUSE has removed ->writepage() since commit e1c420a ("fuse:
> Remove fuse_writepage"), and now it relies on ->migrate_folio(), i.e.
> memory compacting and the normal writeback routine (triggered from
> balance_dirty_page()) in low memory.
>
> Thus I'm afraid the approach of doing temp page copying only for
> writeback from direct reclaim code actually doesn't work.  That's
> because when doing the direct reclaim, the process not only waits for
> the writeback completion submitted from direct reclaim (e.g. marked with
> PG_reclaim, by ->writepage), but may also waits for that submitted from
> the normal writeback routine (without PG_reclaim marked, by
> ->writepages). See commit c3b94f4 ("memcg: further prevent OOM with too
> many dirty pages").
>

Thanks for the explanation! This is very helpful. The reliance on
->migrate_folio() for reclaim is the piece I was missing.

>
>
> [1]
> https://lore.kernel.org/all/CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx92=
T8W6uQ@mail.gmail.com/
>
> --
> Thanks,
> Jingbo

Thanks,
Joanne

