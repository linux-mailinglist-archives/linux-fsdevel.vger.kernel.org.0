Return-Path: <linux-fsdevel+bounces-64398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B28BBE5A20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 00:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBD163560A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 22:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2142DF3E7;
	Thu, 16 Oct 2025 22:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9OoERyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD29199385
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760652197; cv=none; b=XQUzvPMiw5kNrYfqJ3SVChar9lePgP1zRkPtMG1sIaHOjq440+QXYS4oc4THXIpm8OKjCAM+2O8TOmsQgnFcQWdBEh/gKcRPxgplIRHc6E+BrlemYrQ1xkbvWkHrmm+QuCzYiCBjW5yJOdUJUEuTuPWpp9Vap5d02e2OGhk2QUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760652197; c=relaxed/simple;
	bh=7Gx7WfvL9ptpUyiCmXIUIHbjlsr2h2vZ3NdU9O40wAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWTTa+6dT237aUDIlQJln7yDOtV1Cyg0bPlUf0o4OL/ORmDmIL2wOhz6gZHDZ0dwvVC0+4LgpLW1jhteTpvImLxkQutdnhoEje9Qo2ddz7zkoev1msZVQ2hUFQp1FKyeAJa5hEr8/rRiAoGgtclMzyUgZ6IhRU3+SRr+z9XG1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9OoERyF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-795be3a3644so11105936d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760652194; x=1761256994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN5gyTaihvhhPs0y1Znk4JIqaqZoVi/RL6MI4xUysZs=;
        b=F9OoERyFjoVxq/A+szoqRiq3xNPrC4iQJAg71jMjboqOMlQjEMX0Bd1exZByh/rdoS
         hVQG+KAcYFiR2CzojZgFWjUMIOLkS6wdXcH60M2G8voXFMbOmBHHgltJW0uwIwn/AP5d
         t1CSpDLmWXzzFArWhYeA8fNvkFWANURfUtQBDPKQntBJxj3eB026v30alKwCsGTOE/tt
         z9whfBCHgvR8xlinAyoSk6UW0ZCpprz2zCo191hYJlFGD8eUYLiPS/4ZP5RklGhqu/D2
         ot3vTP94nPXtmdX2CmgU/YfMGsmYjfxyeAp5mCwgmk6FyLqA4cx4ht2GG1nosnXgTlLj
         p2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760652194; x=1761256994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN5gyTaihvhhPs0y1Znk4JIqaqZoVi/RL6MI4xUysZs=;
        b=idZ64LhR/CuT8TApPWlqu4Nk6lG2LSeMkLf7HxhxrasKF9PAQXAqfQkN6dKxoL492b
         QEx0Pd8ZVbUOGmQFO/K3IUAMpAU3QZXHkIVnsQaH0HIZ/YrPDFDGHFVBtRcj6RNIo+VX
         GDFXtscTLJQJbkgZKW9V9zTmsExIXtquLP4NjZGh1xA5AKzg+sLV2EgOWO1Pm64B08KU
         zDTIGH7t/b8T6Es0img3LzIz07298cviz5V6K4E5O2aphCyD6ldcGSWQWrSDWRWepUSQ
         vRQNQNnn4Frf/AXJNwBxoLE6tPsF64+KLPZIQIy7al7+cbdoWqSvUvepapxVUGTDZSCJ
         jjxg==
X-Forwarded-Encrypted: i=1; AJvYcCVl0DRMc13IaGMRokkbOjgJQTxI/eToAdpZxewL1W1bRzNfg3S4r9xPewqllGZWWAoAfGS2rR3CeGirk4lD@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvsrMyq1+IGEaC+hsBRrQ2FYHfMcX0IL+iwosc86dY9tYkJm5
	tdjXH2tIv+EHcHlU/s2u9hlJcSsOO78+52/2MyQYu50QZQ/wFdFJOsFUMQKZJ4L4bpd3IBI+/BQ
	cDOr0ON7/NYNZDmxW3iIoag3F6U/hsH0=
X-Gm-Gg: ASbGncvg8ul4lBIsU3hF3Shg5aQ1AoXzXPnzvJX2JY7ZZlVZvrSIcPyb3M1mXrkrjeN
	+uSmB64zQ2rTv7Gra8Ue3rMCfCIriPirHWYQkxZtnZKGFp031Qa/3SsdR428Z6vi8JPaJBqljkT
	SDMX3HdFvGLx9r/5DuxkAdj0UC7Wk0z8C809KSt+37uCX0QCKr2UYAdpYEXxWAG1nDVVlwnZ6Nv
	eXbyxhsbAp92gpj4/L60CUs8NsttE70XDjlqdsBFlHgedyJtPevz0SabHd7UQbv6e9bHCfHm2aW
	0fkBsihG/1bFLmPe
X-Google-Smtp-Source: AGHT+IGyxBTHJscWFJ04bhtrUznH+eFi3uuqj4jDtKQ3rfJLAJzxXQxkokzjkK0yiG2JDPwlzm4LlmIoU+junMUyb9w=
X-Received: by 2002:ac8:574f:0:b0:4de:3960:948e with SMTP id
 d75a77b69052e-4e89d297dc2mr22036581cf.32.1760652193894; Thu, 16 Oct 2025
 15:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com> <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com>
In-Reply-To: <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Oct 2025 15:03:03 -0700
X-Gm-Features: AS18NWAbSmKOg0kKBQaBREno9T6YVfHjFZiHhouxIsMS4TIpephXL-em4TvR_7c
Message-ID: <CAJnrk1aB4BwDNwex1NimiQ_9duUQ93HMp+ATsqo4QcGStMbzWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/10/16 09:27, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>>
> >>> Hi Joanne,
> >>>
> >>> On 2025/10/16 02:21, Joanne Koong wrote:
> >>>> On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangkao@linux.=
alibaba.com> wrote:
> >>>
> >>> ...
> >>>
> >>>>>>
> >>>>>> This is where I encountered it in erofs: [1] for the "WARNING in
> >>>>>> iomap_iter_advance" syz repro. (this syzbot report was generated i=
n
> >>>>>> response to this patchset version [2]).
> >>>>>>
> >>>>>> When I ran that syz program locally, I remember seeing pos=3D116 a=
nd length=3D3980.
> >>>>>
> >>>>> I just ran the C repro locally with the upstream codebase (but I
> >>>>> didn't use the related Kconfig), and it doesn't show anything.
> >>>>
> >>>> Which upstream commit are you running it on? It needs to be run on t=
op
> >>>> of this patchset [1] but without this fix [2]. These changes are in
> >>>> Christian's vfs-6.19.iomap branch in his vfs tree but I don't think
> >>>> that branch has been published publicly yet so maybe just patching i=
t
> >>>> in locally will work best.
> >>>>
> >>>> When I reproed it last month, I used the syz executor (not the C
> >>>> repro, though that should probably work too?) directly with the
> >>>> kconfig they had.
> >>>
> >>> I believe it's a regression somewhere since it's a valid
> >>> IOMAP_INLINE extent (since it's inlined, the length is not
> >>> block-aligned of course), you could add a print just before
> >>> erofs_iomap_begin() returns.
> >>
> >> Ok, so if erofs is strictly block-aligned except for tail inline data
> >> (eg the IOMAP_INLINE extent), then I agree, there is a regression
> >> somewhere as we shouldn't be running into the situation where erofs is
> >> calling iomap_adjust_read_range() with a non-block-aligned position
> >> and length. I'll track the offending commit down tomorrow.
> >>
> >
> > Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> > iomap_iter advances") that changed this behavior for erofs such that
> > the read iteration continues even after encountering an IOMAP_INLINE
> > extent, whereas before, the iteration stopped after reading in the
> > iomap inline extent. This leads erofs to end up in the situation where
> > it calls into iomap_adjust_read_range() with a non-block-aligned
> > position/length (on that subsequent iteration).
> >
> > In particular, this change in commit bc264fea0f6f to iomap_iter():
> >
> > -       if (ret > 0 && !iter->processed && !stale)
> > +       if (ret > 0 && !advanced && !stale)
> >
> > For iomap inline extents, iter->processed is 0, which stopped the
> > iteration before. But now, advanced (which is iter->pos -
> > iter->iter_start_pos) is used which will continue the iteration (since
> > the iter is advanced after reading in the iomap inline extents).
> >
> > Erofs is able to handle subsequent iterations after iomap_inline
> > extents because erofs_iomap_begin() checks the block map and returns
> > IOMAP_HOLE if it's not mapped
> >          if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> >                  iomap->type =3D IOMAP_HOLE;
> >                  return 0;
> >          }
> >
> > but I think what probably would be better is a separate patch that
> > reverts this back to the original behavior of stopping the iteration
> > after IOMAP_INLINE extents are read in.
>
> Thanks for your analysis, currently I don't have enough time to look
> into that (working on other stuffs), but according to your analysis,
> it seems EROFS don't have a user-visible regression in the Linus'
> upstream.
>
> >
> > So I don't think this patch should have a fixes: tag for that commit.
> > It seems to me like no one was hitting this path before with a
> > non-block-aligned position and offset. Though now there will be a use
> > case for it, which is fuse.
>
> To make it simplified, the issue is that:
>   - Previously, before your fuse iomap read patchset (assuming Christian
>     is already applied), there was no WARNING out of there;
>
>   - A new WARNING should be considered as a kernel regression.

No, the warning was always there. As shown in the syzbot report [1],
the warning that triggers is this one in iomap_iter_advance()

int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
{
        if (WARN_ON_ONCE(*count > iomap_length(iter)))
                return -EIO;
        ...
}

which was there even prior to the fuse iomap read patchset.

Erofs could still trigger this warning even without the fuse iomap
read patchset changes. So I don't think this qualifies as a new
warning that's caused by the fuse iomap read changes. What the fuse
iomap read patchset does is make it more likely for some specific
reads (like the syzbot generated one) to trigger the warning because
now the iterator is advanced incrementally which detects the underflow
length value (hence triggering the warning) whereas before, the bug
could be masked if the underflow of len and overflow of pos that is
returned from iomap_adjust_read_range() offset each other perfectly.
But other reads (for example ones where there are trailing uptodate
blocks that need to be truncated) can already trigger this warning
before the fuse iomap read changes and after the fuse iomap read
changes.

With that said, commit b26816b4e32 ("iomap: fix inline data on
buffered read") is the commit that led erofs to this new behavior of
calling into iomap_adjust_read_range() with non-block-aligned offsets
and lengths and can trigger the warning for some reads. So since this
patch fixes that behavior introduced by that commit, I'll add a Fixes
tag referencing that commit.

Thanks,
Joanne


[1] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435.04fc.GAE=
@google.com/

>
> I'm not sure if Christian's iomap branch allows to be rebased, so in
> principle, either:
>
>   - You insert this patch before the WARNING patch in the fuse patchset
>     goes in, so no Fixes tag is needed because the WARNING doesn't
>     exist anymore,
>
> Or
>
>   - Add the Fixes tag to point to the commit which causes the WARNING
> one.
>
> Why it's important? because each upstream commit can be (back)ported
> to stable or downstream kernels, a WARNING should be considered as
> a new regression and needs a fix commit to be ported together, even
> those patches will be merged into upstream together.
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,
> > Joanne
> >
> >>
> >> Thanks,
> >> Joanne
> >>
> >>>
> >>> Also see my reply:
> >>> https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linux.=
alibaba.com
> >>>
> >>> I'm not sure if it caused user-visible regressions since
> >>> erofs images work properly with upstream code (unlike a
> >>> previous regression fixed by commit b26816b4e320 ("iomap:
> >>> fix inline data on buffered read")).
> >>>
> >>> But a fixes tag is needed since it causes an unexpected
> >>> WARNING at least.
> >>>
> >>> Thanks,
> >>> Gao Xiang
> >>>
> >>>>
> >>>> Thanks,
> >>>> Joanne
> >>>>
> >>>> [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-j=
oannelkoong@gmail.com/T/#t
> >>>> [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-j=
oannelkoong@gmail.com/
> >>>> [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-j=
oannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> >>>>
> >>>>>
> >>>>> I feel strange why pos is unaligned, does this warning show
> >>>>> without your patchset on your side?
> >>>>>
> >>>>> Thanks,
> >>>>> Gao Xiang
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Joanne
> >>>>>>
> >>>>>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc606=
bef
> >>>>>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff435=
.04fc.GAE@google.com/
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Gao Xiang
> >>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Joanne
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Otherwise looks good:
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>>>>
> >>>>>
> >>>
>

