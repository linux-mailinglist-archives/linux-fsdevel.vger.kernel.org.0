Return-Path: <linux-fsdevel+bounces-64401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4F8BE5B45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 00:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 196B04EB6AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3ED2DF6F8;
	Thu, 16 Oct 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3ci1Wcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B619F48D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760654381; cv=none; b=mwSpj9sTfFoeqn0oloHvL9/SEDrt9+7Pg/3Foru1jJkupKsfsM5d5Zr06MBrD2MgOU9gDDE3pbtfj81v/erfrmSVLhMCFPiqYye9qFENo+WkMLhOJJwUw6Nrp57KJeDeiJJUNYC0PNsjWRWaa9KO0HzsZI64QhgUYOe1Z6B8w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760654381; c=relaxed/simple;
	bh=cB+IJenTCekhHSmjv1XF3MrFSsptXBFBVDPxc2B+TL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9UTqca0wy+0kL3CyEbFGhP0c2TvqXAlUlfqiGjkH70Pww95ovWEJ8Q8Pm6/WfZII9TxgggHbD8XxGAiXkNZq/HOYSbT0bOxEDw8nEeL1tS+YKtAF1cicgn/5cddqx7JfYcpui3TNUoa5TYVoa6Inry8hnnGWHRV5zMsPv5/0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3ci1Wcx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-796fe71deecso16383036d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760654378; x=1761259178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUkBetk7F2E2MqpJQ+ErD5kCGmewTP3QqtZRTc2LRMQ=;
        b=G3ci1WcxBfoisdYHs6/lk89PqVfNX263MqMaxYmYPoM4XaJjzvioWmPtiArraBUBA2
         BTEvgidrO1HfQPVt6CM6gSvmZfRxKc3gwyZkQyReTR6pVGbvXEIIhC95YVJ5GTfcHBO9
         +95KN2LnmR50nJ5EfeAG0D35vBvlSHbY8MP93OTVopv6+d32k865RRt83A2PZOyyc4FO
         9EsUKW8rdtycp4K65W30agqw22hEKYa7nvKlYmoitdD3Ty9PWcwfRYc3LTHeTkuoY4Fq
         z23OfhIox6K4oWg4t/Ebpcwz6nvqSTvb9LziyofG0oWaI5mTJt+d/MLFuav4yqHmIv5c
         wYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760654378; x=1761259178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUkBetk7F2E2MqpJQ+ErD5kCGmewTP3QqtZRTc2LRMQ=;
        b=sxUfHkAb03wp3489yGFMyr9075StHdSZz5r+yYms6qIOWX0ua0T5z9Ik4oKKyCiuTP
         PJLl5sD44pQyHZxJ7bGI2mBdNJHSYOBZXwp/V2lw7rNQmSCJGh4mFNN+oKxzMps7hzd9
         igKD+5+VLB2mWaC3UNXCJAek42wGHxIhJD6NkyChiN+5PCDDHVI5zC1TYmCu9hh3+Qkz
         HQdpZvm+hV2+snfhdeeChsHCleGMfvXui/MaYZAN+4AlzLXhNmRMALziJxgQCYaBZeWx
         PKJ/NtPgsJqxAIGIyhtQVqPajieRWgq/Vmw+znfTeHun1LnldO6Wb/uIOB0TIK330URe
         +GcA==
X-Forwarded-Encrypted: i=1; AJvYcCVAl47AXNwH9Go2Fe/lj3O9ffDqQZFpE+fSEAo9ytWH7eJ84Fjvqatelsne4h4Tt07sjgksKyR1u0NLgp9X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KuD9kdC++A+0grYJZvgJsVCZtDeOuIeagbBP+RwYOPPM3Z0G
	aIoDwas/oQCmLESGBPVIdyZcJcm76zAOHUPPwhCQYf1w4ebXFHUOQ6Jydzc6UdHzuDCGbrIAc7X
	btNKQgwCJcM9QxKocaXRBRXA6lf2iwTw=
X-Gm-Gg: ASbGncv6mOWe+TVYLcCPZVJ2TEOiHimh+ZbiP+ekLY1jCtOMGpU1bqhj8MV4kAgMCPD
	rhWMOnMI516Wo/ic/4s3WWziC69SoMTC943BNYyfB38vBzvfFdVqZuYpZZJzXnOR+Ug6yC/jqkG
	qf0E1YiF8o0+JIClGPjDtXHmpeTRiKxwmL+sHPDpnMZBWV2lRA5iLIlJCzUaY+KO3RxOUS9zXpW
	vTY2YK2YyXN3EYFD+qJw8hPel4Z2+N0+dVFdJh1wCflZfOZ93cIvxQCREM6CTSW60W5FmBf6Vf6
	oxDr+Ai9HK9klc7tM82S51VAPL0=
X-Google-Smtp-Source: AGHT+IG0lwwUNBJIaax1MHxp8Re/YpLfs0R4n8rIWoGpZSGQNnhQNXFPDt2o06NKysgW611LoSGX9jQ/BnK/Omfrx7A=
X-Received: by 2002:a05:622a:1103:b0:4df:45b1:1547 with SMTP id
 d75a77b69052e-4e89d3a7dcdmr25272901cf.69.1760654378392; Thu, 16 Oct 2025
 15:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org> <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com> <aPDXIWeTKceHuqkj@bfoster>
In-Reply-To: <aPDXIWeTKceHuqkj@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Oct 2025 15:39:27 -0700
X-Gm-Features: AS18NWDv1_aSL6zBQyp59YEeO31LWd-MvaUfnrS_FKdXG8H82PI6HpwItt-muGc
Message-ID: <CAJnrk1YeT8uBLf0e2-+wd6vKMH4Rp9dhHbC0d9eCu1hEwhiANA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Brian Foster <bfoster@redhat.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:25=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangkao@linux.a=
libaba.com> wrote:
> > > >
> > > > Hi Joanne,
> > > >
> > > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > > On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangkao@lin=
ux.alibaba.com> wrote:
> > > >
> > > > ...
> > > >
> > > > >>>
> > > > >>> This is where I encountered it in erofs: [1] for the "WARNING i=
n
> > > > >>> iomap_iter_advance" syz repro. (this syzbot report was generate=
d in
> > > > >>> response to this patchset version [2]).
> > > > >>>
> > > > >>> When I ran that syz program locally, I remember seeing pos=3D11=
6 and length=3D3980.
> > > > >>
> > > > >> I just ran the C repro locally with the upstream codebase (but I
> > > > >> didn't use the related Kconfig), and it doesn't show anything.
> > > > >
> > > > > Which upstream commit are you running it on? It needs to be run o=
n top
> > > > > of this patchset [1] but without this fix [2]. These changes are =
in
> > > > > Christian's vfs-6.19.iomap branch in his vfs tree but I don't thi=
nk
> > > > > that branch has been published publicly yet so maybe just patchin=
g it
> > > > > in locally will work best.
> > > > >
> > > > > When I reproed it last month, I used the syz executor (not the C
> > > > > repro, though that should probably work too?) directly with the
> > > > > kconfig they had.
> > > >
> > > > I believe it's a regression somewhere since it's a valid
> > > > IOMAP_INLINE extent (since it's inlined, the length is not
> > > > block-aligned of course), you could add a print just before
> > > > erofs_iomap_begin() returns.
> > >
> > > Ok, so if erofs is strictly block-aligned except for tail inline data
> > > (eg the IOMAP_INLINE extent), then I agree, there is a regression
> > > somewhere as we shouldn't be running into the situation where erofs i=
s
> > > calling iomap_adjust_read_range() with a non-block-aligned position
> > > and length. I'll track the offending commit down tomorrow.
> > >
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
> >         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> >                 iomap->type =3D IOMAP_HOLE;
> >                 return 0;
> >         }
> >
> > but I think what probably would be better is a separate patch that
> > reverts this back to the original behavior of stopping the iteration
> > after IOMAP_INLINE extents are read in.
> >
>
> Hmm.. so as of commit bc264fea0f6f, it looks like the read_inline() path
> still didn't advance the iter at all by that point. It just returned 0
> and this caused iomap_iter() to break out of the iteration loop.
>
> The logic noted above in iomap_iter() is basically saying to break out
> if the iteration did nothing, which is a bit of a hacky way to terminate
> an IOMAP_INLINE read. The proper thing to do in that path IMO is to
> report the bytes processed and then terminate some other way more
> naturally. I see Gao actually fixed this sometime later in commit
> b26816b4e320 ("iomap: fix inline data on buffered read"), which is when
> the inline read path started to advance the iter.

That's a good point, the fix in commit b26816b4e320 is what led to the
new erofs behavior, not commit bc264fea0f6f.

>
> TBH, the behavior described above where we advance over the inline
> mapping and then report any remaining iter length as a hole also sounds
> like reasonably appropriate behavior to me. I suppose you could argue
> that the inline case should just terminate the iter, which perhaps means
> it should call iomap_iter_advance_full() instead. That technically
> hardcodes that we will never process mappings beyond an inline mapping
> into iomap. That bugs me a little bit, but is also probably always going
> to be true so doesn't seem like that big of a deal.

Reporting any remaining iter length as a hole also sounds reasonable
to me but it seems that this may add additional work that may not be
trivial. For example, I'm looking at erofs's erofs_map_blocks() call
which they would need to do to figure out it should be an iomap hole.
It seems a bit nonideal to me that any filesystem using iomap inline
data would also have to make sure they cover this case, which maybe
they already need to do that, I'm not sure, but it seems like an extra
thing they would now need to account for.

One scenario I'm imagining maybe being useful in the future is
supporting chained inline mappings, in which case we would still want
to continue processing after the first inline mapping, but we could
also address that if it does come up.

>
> If we wanted to consider it an optimization so we didn't always do this
> extra iter on inline files, perhaps another variant of that could be an
> EOF flag or some such that the fs could set to trigger a full advance
> after the current mapping. OTOH you could argue that's what inline
> already is so maybe that's overthinking it. Just a thought. Hm?
>

Would non-inline iomap types also find that flag helpful or is the
intention for it to be inline specific? I guess the flag could also be
used by non-inline types to stop the iteration short, if there's a use
case for that?

Thanks,
Joanne

> Brian
>
> > So I don't think this patch should have a fixes: tag for that commit.
> > It seems to me like no one was hitting this path before with a
> > non-block-aligned position and offset. Though now there will be a use
> > case for it, which is fuse.
> >
> > Thanks,
> > Joanne
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > >
> > > > Also see my reply:
> > > > https://lore.kernel.org/r/cff53c73-f050-44e2-9c61-96552c0e85ab@linu=
x.alibaba.com
> > > >
> > > > I'm not sure if it caused user-visible regressions since
> > > > erofs images work properly with upstream code (unlike a
> > > > previous regression fixed by commit b26816b4e320 ("iomap:
> > > > fix inline data on buffered read")).
> > > >
> > > > But a fixes tag is needed since it causes an unexpected
> > > > WARNING at least.
> > > >
> > > > Thanks,
> > > > Gao Xiang
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-=
1-joannelkoong@gmail.com/T/#t
> > > > > [2] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-=
1-joannelkoong@gmail.com/
> > > > > [3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-=
1-joannelkoong@gmail.com/T/#m4ce4707bf98077cde4d1d4845425de30cf2b00f6
> > > > >
> > > > >>
> > > > >> I feel strange why pos is unaligned, does this warning show
> > > > >> without your patchset on your side?
> > > > >>
> > > > >> Thanks,
> > > > >> Gao Xiang
> > > > >>
> > > > >>>
> > > > >>> Thanks,
> > > > >>> Joanne
> > > > >>>
> > > > >>> [1] https://ci.syzbot.org/series/6845596a-1ec9-4396-b9c4-48bddc=
606bef
> > > > >>> [2] https://lore.kernel.org/linux-fsdevel/68ca71bd.050a0220.2ff=
435.04fc.GAE@google.com/
> > > > >>>
> > > > >>>>
> > > > >>>> Thanks,
> > > > >>>> Gao Xiang
> > > > >>>>
> > > > >>>>>
> > > > >>>>>
> > > > >>>>> Thanks,
> > > > >>>>> Joanne
> > > > >>>>>
> > > > >>>>>>
> > > > >>>>>> Otherwise looks good:
> > > > >>>>>>
> > > > >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > >>>>
> > > > >>
> > > >
> >
>

