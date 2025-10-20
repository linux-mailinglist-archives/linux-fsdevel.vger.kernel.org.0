Return-Path: <linux-fsdevel+bounces-64774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E69BF3C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 23:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 441C34E775B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076132ECEA3;
	Mon, 20 Oct 2025 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlLtO9sE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFE27C178
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996366; cv=none; b=f2hVZl1a2yjSinjODBxmImt4fHblPmPlrsHFNj1t8t/WYXK0oqbxciikb/754SvuDMEx/dG0cGdmmNhpHZgIgHaiB7RM++LmzxvjqltJeVuDEnqS9rwGtVSMOg77Md1YYPkzafwAFU1A/JsLYeGiUn6sJsym6FNcG8Hy9D/3CT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996366; c=relaxed/simple;
	bh=uJLGYZSky77rgzr0usXQd3bYevUTYKXLaIoi5ir8QtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYTeqDQt0CKPKziFlsq7lWqGoEeMXWkhkEbFXa4+j+XNPFQcHO0fTCTfSlSCoEqnCg8eWuZLxKg1S8Trtk97LOWFUrB28neM+tYJbcdYUhzgDA3ZXUzi/NFOa5N/h9aixYZqVm+RoicUMG1vWjSsGIc/JylOCMsdtWv2IL7sIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlLtO9sE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8923b2d9954so236486285a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 14:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760996360; x=1761601160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QyNPU75Nmyhu1WjHMAKpDY+ZowIxGddGiLDCYc7OBI=;
        b=DlLtO9sEhn1pWFxZz50hDVbA4Qhynuz/B7jrl5t+qJDJ9PvOb5l16v0O1uID5B6SfV
         cyTpzu72U3Fv0UI+xYR6Q0scBSaUw8hff5Rd3lsXNXMnsvvYcHLK0JLXn4PWLvKYUqGp
         G9syv6IbS5ednm+rzQ/LhzKF7RquITtwlK2wTcZS5aWdBUFqNG9TQe44/oATZ8hsd/jP
         U7MHIkYiheRwTMPNDC7kj2oksbEGV9ZjkpFWeETWIO+YueCm3f+4EYb8ezmieAHN9HR0
         Wrf167v3qVBr8VqrCc0kdWfiuKy/NQd5T4YlU1yNE+qEvWMkX+hYNDeha5MdnFbpCqSM
         dVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996360; x=1761601160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QyNPU75Nmyhu1WjHMAKpDY+ZowIxGddGiLDCYc7OBI=;
        b=Kd9vsOgkJRvxW1eHh3dUFItFtBJRrcBaVNYCv3GBncLhgyuvXE47F2/CAMqdiWGIMm
         OxTj2JhzMNs77znfxnZmXXP1XBR2QJHLpKQftFtUpZ2wOLXCPpjn+UchM/HlUhjAFrOx
         G6KmcKonUk7zVih2zrURAK9+obiM9Jct/PH424E3KxrYOiJOHXioDCxC4D7WyxmJ8i7a
         L8QM42pEEsaUEY8qPyBS9QnFCHiCd+TI5zbJMzviN4RK31yTA+/Iu83lXkM+w+P7IuGP
         On44kP+kAjGkF7RrTupaD6rHWBtIuuuF/v3u9JgbRpgk44j8XQ9sKKbQVCC+7uMLvANa
         1TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW276KZ4xLsY/on0rYDRwVSCGii9OBwq9ocvKOp6n9dT/98YLBgmtuZ/pWuwm32ilsbs/lfcQ3LsxG0bkO3@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfuTsw2cK60x4SKt+d3LLQ6kdIuoHFgB4mRIQi24UFSgB94S9
	Lh7GuYNRH+b4qV0YGa2lZ4CY/WU9E/9Afnzip8LfoJYx9kgz7E3vyVYpjUNvhQek+FV1egfveIo
	a5Nzt/5B7T67iMa3bAtzum5IPp3jR8YM=
X-Gm-Gg: ASbGnctcMElly8rkNsEEScekALdr49Hhzw7sxShIXYheb1FXSwBSwMDbfUmgo4Sgu2v
	tw25AaTivjBf6S1AowiRxbmvI/8mk4cyTutakf9azILNb2WowRXwU0WbCZIEbeZLJSpKPOASMsv
	jrY4aFTtQfNjcs3abm7te7NfaswYH1/fPxiUbHGGyuDgjRVmmurhzRwFoV5YNnH6SsWZDkH2v+g
	XOnEGwASXBadY+1ym2KP1orsSLycOMbL1UsaWlVoG7iV12n2/QUcrx2GuD6aUkCt2dOopYTRSYE
	WkSvFhcilCYOGVTGaGsIzJR3RGE=
X-Google-Smtp-Source: AGHT+IGmDYSCTzNxejtc7qiHdZHjxvwzH2KKBGbsn8kOju8jG+9sWSHt9fnauKiu64Y/XYCVMok0oQzizrIEsKdRZj4=
X-Received: by 2002:ac8:7e84:0:b0:4e8:b793:1c3b with SMTP id
 d75a77b69052e-4e8b79325e2mr95197721cf.61.1760996360182; Mon, 20 Oct 2025
 14:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <aPDXIWeTKceHuqkj@bfoster> <CAJnrk1YeT8uBLf0e2-+wd6vKMH4Rp9dhHbC0d9eCu1hEwhiANA@mail.gmail.com>
 <aPJhy4kEw0M7vtz-@bfoster> <aPKKgctbV4TQ9vid@bfoster> <CAJnrk1YLuiRyVwEW6nR1fUnvWf1Ozu1hK4LKn3mRWKeECVyMAA@mail.gmail.com>
 <aPNsK9D3RtAjccOA@bfoster>
In-Reply-To: <aPNsK9D3RtAjccOA@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Oct 2025 14:39:09 -0700
X-Gm-Features: AS18NWBJgC_o3jdslCVN4FdNpEJcvc15cVVanU6-DC8nnJXVJP5EYzhGuZm2F5g
Message-ID: <CAJnrk1aZPR0nnu0WwhYQDhF+oRX3knd3aOguWMG_VhUhHOyBAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Brian Foster <bfoster@redhat.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 3:25=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Fri, Oct 17, 2025 at 01:19:39PM -0700, Joanne Koong wrote:
> > On Fri, Oct 17, 2025 at 11:23=E2=80=AFAM Brian Foster <bfoster@redhat.c=
om> wrote:
> > >
> > > On Fri, Oct 17, 2025 at 11:33:31AM -0400, Brian Foster wrote:
> > > > On Thu, Oct 16, 2025 at 03:39:27PM -0700, Joanne Koong wrote:
> > > > > On Thu, Oct 16, 2025 at 4:25=E2=80=AFAM Brian Foster <bfoster@red=
hat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> > > > > > > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Joanne Koong <joannel=
koong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangk=
ao@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Joanne,
> > > > > > > > >
> > > > > > > > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > > > > > > > On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsi=
angkao@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > ...
> > > > > > > > >
> > > > > > > > > >>>
> > > > > > > > > >>> This is where I encountered it in erofs: [1] for the =
"WARNING in
> > > > > > > > > >>> iomap_iter_advance" syz repro. (this syzbot report wa=
s generated in
> > > > > > > > > >>> response to this patchset version [2]).
> > > > > > > > > >>>
> > > > > > > > > >>> When I ran that syz program locally, I remember seein=
g pos=3D116 and length=3D3980.
> > > > > > > > > >>
> > > > > > > > > >> I just ran the C repro locally with the upstream codeb=
ase (but I
> > > > > > > > > >> didn't use the related Kconfig), and it doesn't show a=
nything.
> > > > > > > > > >
> > > > > > > > > > Which upstream commit are you running it on? It needs t=
o be run on top
> > > > > > > > > > of this patchset [1] but without this fix [2]. These ch=
anges are in
> > > > > > > > > > Christian's vfs-6.19.iomap branch in his vfs tree but I=
 don't think
> > > > > > > > > > that branch has been published publicly yet so maybe ju=
st patching it
> > > > > > > > > > in locally will work best.
> > > > > > > > > >
> > > > > > > > > > When I reproed it last month, I used the syz executor (=
not the C
> > > > > > > > > > repro, though that should probably work too?) directly =
with the
> > > > > > > > > > kconfig they had.
> > > > > > > > >
> > > > > > > > > I believe it's a regression somewhere since it's a valid
> > > > > > > > > IOMAP_INLINE extent (since it's inlined, the length is no=
t
> > > > > > > > > block-aligned of course), you could add a print just befo=
re
> > > > > > > > > erofs_iomap_begin() returns.
> > > > > > > >
> > > > > > > > Ok, so if erofs is strictly block-aligned except for tail i=
nline data
> > > > > > > > (eg the IOMAP_INLINE extent), then I agree, there is a regr=
ession
> > > > > > > > somewhere as we shouldn't be running into the situation whe=
re erofs is
> > > > > > > > calling iomap_adjust_read_range() with a non-block-aligned =
position
> > > > > > > > and length. I'll track the offending commit down tomorrow.
> > > > > > > >
> > > > > > >
> > > > > > > Ok, I think it's commit bc264fea0f6f ("iomap: support increme=
ntal
> > > > > > > iomap_iter advances") that changed this behavior for erofs su=
ch that
> > > > > > > the read iteration continues even after encountering an IOMAP=
_INLINE
> > > > > > > extent, whereas before, the iteration stopped after reading i=
n the
> > > > > > > iomap inline extent. This leads erofs to end up in the situat=
ion where
> > > > > > > it calls into iomap_adjust_read_range() with a non-block-alig=
ned
> > > > > > > position/length (on that subsequent iteration).
> > > > > > >
> > > > > > > In particular, this change in commit bc264fea0f6f to iomap_it=
er():
> > > > > > >
> > > > > > > -       if (ret > 0 && !iter->processed && !stale)
> > > > > > > +       if (ret > 0 && !advanced && !stale)
> > > > > > >
> > > > > > > For iomap inline extents, iter->processed is 0, which stopped=
 the
> > > > > > > iteration before. But now, advanced (which is iter->pos -
> > > > > > > iter->iter_start_pos) is used which will continue the iterati=
on (since
> > > > > > > the iter is advanced after reading in the iomap inline extent=
s).
> > > > > > >
> > > > > > > Erofs is able to handle subsequent iterations after iomap_inl=
ine
> > > > > > > extents because erofs_iomap_begin() checks the block map and =
returns
> > > > > > > IOMAP_HOLE if it's not mapped
> > > > > > >         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > > > > > >                 iomap->type =3D IOMAP_HOLE;
> > > > > > >                 return 0;
> > > > > > >         }
> > > > > > >
> > > > > > > but I think what probably would be better is a separate patch=
 that
> > > > > > > reverts this back to the original behavior of stopping the it=
eration
> > > > > > > after IOMAP_INLINE extents are read in.
> > > > > > >
> > > > > >
> > > > > > Hmm.. so as of commit bc264fea0f6f, it looks like the read_inli=
ne() path
> > > > > > still didn't advance the iter at all by that point. It just ret=
urned 0
> > > > > > and this caused iomap_iter() to break out of the iteration loop=
.
> > > > > >
> > > > > > The logic noted above in iomap_iter() is basically saying to br=
eak out
> > > > > > if the iteration did nothing, which is a bit of a hacky way to =
terminate
> > > > > > an IOMAP_INLINE read. The proper thing to do in that path IMO i=
s to
> > > > > > report the bytes processed and then terminate some other way mo=
re
> > > > > > naturally. I see Gao actually fixed this sometime later in comm=
it
> > > > > > b26816b4e320 ("iomap: fix inline data on buffered read"), which=
 is when
> > > > > > the inline read path started to advance the iter.
> > > > >
> > > > > That's a good point, the fix in commit b26816b4e320 is what led t=
o the
> > > > > new erofs behavior, not commit bc264fea0f6f.
> > > > >
> > > > > >
> > > > > > TBH, the behavior described above where we advance over the inl=
ine
> > > > > > mapping and then report any remaining iter length as a hole als=
o sounds
> > > > > > like reasonably appropriate behavior to me. I suppose you could=
 argue
> > > > > > that the inline case should just terminate the iter, which perh=
aps means
> > > > > > it should call iomap_iter_advance_full() instead. That technica=
lly
> > > > > > hardcodes that we will never process mappings beyond an inline =
mapping
> > > > > > into iomap. That bugs me a little bit, but is also probably alw=
ays going
> > > > > > to be true so doesn't seem like that big of a deal.
> > > > >
> > > > > Reporting any remaining iter length as a hole also sounds reasona=
ble
> > > > > to me but it seems that this may add additional work that may not=
 be
> > > > > trivial. For example, I'm looking at erofs's erofs_map_blocks() c=
all
> > > > > which they would need to do to figure out it should be an iomap h=
ole.
> > > > > It seems a bit nonideal to me that any filesystem using iomap inl=
ine
> > > > > data would also have to make sure they cover this case, which may=
be
> > > > > they already need to do that, I'm not sure, but it seems like an =
extra
> > > > > thing they would now need to account for.
> > > > >
> > > >
> > > > To make sure I follow, you're talking about any potential non-erofs
> > > > cases, right? I thought it was mentioned that erofs already handled=
 this
> > > > correctly by returning a hole. So I take this to mean other users w=
ould
> > > > need to handle this similarly.
> >
> > Yes, sorry if my previous wording was confusing. Erofs already handles
> > this correctly but there's some overhead with having to determine it's
> > a hole.
> >
> > > >
> > > > Poking around, I see that ext4 uses iomap and IOMAP_INLINE in a cou=
ple
> > > > isolated cases. One looks like swapfile activation and the other ap=
pears
> > > > to be related to fiemap. Any idea if those are working correctly? A=
t
> > > > first look it kind of looks like they check and return error for of=
fset
> > > > beyond the specified length..
> > > >
> > >
> > > JFYI from digging further.. ext4 returns -ENOENT for this "offset bey=
ond
> > > inline size" case. I didn't see any error returns from fiemap/filefra=
g
> > > on a quick test against an inline data file. It looks like
> > > iomap_fiemap() actually ignores errors either if the previous mapping=
 is
> > > non-hole, or catches -ENOENT explicitly to handle an attribute mappin=
g
> > > case. So afaict this all seems to work Ok..
> > >
> > > I'm not sure this is all that relevant for the swap case. mkswap
> > > apparently requires a file at least 40k in size, which iiuc is beyond
> > > the scope of files with inline data..
> >
> > I think gfs2 also uses IOMAP_INLINE. In __gfs2_iomap_get(), it looks
> > like they report a hole if the offset is beyond the inode size, so
> > that looks okay.
> >
> > >
> > > Brian
> > >
> > > > > One scenario I'm imagining maybe being useful in the future is
> > > > > supporting chained inline mappings, in which case we would still =
want
> > > > > to continue processing after the first inline mapping, but we cou=
ld
> > > > > also address that if it does come up.
> > > > >
> > > >
> > > > Yeah..
> > > >
> > > > > >
> > > > > > If we wanted to consider it an optimization so we didn't always=
 do this
> > > > > > extra iter on inline files, perhaps another variant of that cou=
ld be an
> > > > > > EOF flag or some such that the fs could set to trigger a full a=
dvance
> > > > > > after the current mapping. OTOH you could argue that's what inl=
ine
> > > > > > already is so maybe that's overthinking it. Just a thought. Hm?
> > > > > >
> > > > >
> > > > > Would non-inline iomap types also find that flag helpful or is th=
e
> > > > > intention for it to be inline specific? I guess the flag could al=
so be
> > > > > used by non-inline types to stop the iteration short, if there's =
a use
> > > > > case for that?
> > > > >
> > > >
> > > > ... I hadn't really considered that. This was just me thinking out =
loud
> > > > about trying to handle things more generically.
> > > >
> > > > Having thought more about it, I think either way it might just make
> > > > sense to fix the inline read case to do the full advance (assuming =
it is
> > > > verified this fixes the problem) to restore historical iomap behavi=
or.
> >
> > Hmm, the iter is already fully advanced after the inline data is read.
> > I think the issue is that when the iomap mapping length is less than
> > the iter len (the iter len will always be the size of the folio but
> > the length for the inline data could be less), then advancing it fully
> > through iomap_iter_advance_full() will only advance it up to the iomap
> > length. iter->len will then still have a positive value which makes
> > iomap_iter() continue iterating.
> >
>
> Derp.. yeah, I had my wires crossed thinking the full advance completed
> the full request, when really it's just the current iteration. Thanks
> for pointing that out.
>
> > I don't see a cleaner way of restoring historical iomap behavior than
> > adding that eof/stop flag.
> >
>
> Hmm.. so then aside from the oddly aligned iter case warning that you've
> already fixed, ISTM that everything otherwise works correctly, right? If
> so, I wouldn't be in a huge rush to do the flag thing.
>
> In theory, there may still be similar options to do what I was thinking,
> like perhaps just zero out remaining iter->len in that particular inline
> path (maybe via an iomap_iter_advance_inline() helper for example). It's
> not totally clear to me it's worth it though if everything is pretty
> much working as is.

Sounds good to me to leave it as is. I was originally thinking it
might be nice to avoid the extra mapping overhead for determining it's
an iomap_hole but I guess it wouldn't actually be much overhead since
in most cases the metadata would be cached from the previous
iomap_inline call and not require a disk read.

Thanks for weighing in on this!

>
> Brian
>
> > Thanks,
> > Joanne
> >
> >
> > > > Then if there is ever value to support multiple inline mappings som=
ehow
> > > > or another, we could revisit the flag idea.
> >
> > > >
> > > > Brian
> > > >
> > > > > Thanks,
> > > > > Joanne
> >
>

