Return-Path: <linux-fsdevel+bounces-64551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B603BEBA1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE1E1AE0C58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65482C21D5;
	Fri, 17 Oct 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Mb/AIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7582ECE9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732395; cv=none; b=fIFnV4OT+3nkmI2dBuPyMTdkVaWB8dgaHBTGcw1n7LBvzz7ZduYjwe3XAxqVXjnbThZejbqtlsO9hO7+LbN3+NGuUcdVegRJLFCQBDCX1KF1rk+oBwQXLGY0xEjpvKH4ZYHhx93GTj7TETnzHnWDRwkPL5s0UnPkWgNaAgzpfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732395; c=relaxed/simple;
	bh=Ym99Zs0WmsENYEokC/GRc2hoLxZvWX14miTPqdyT5rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiSx72Sgg7tPYcc59E90Ai7JMfJ0+CnYXq5f1kk2eKKQ0dakRf+xmH/3ubjfw/yyhxBN962Z66qBDN8qc2Cxy3SVgM/xW2osCtTsPz9IJ5tPvQAo8d3iQvys2D5lp81rowTcYqtxrLQN+Ehecj3JprZ6F4ryoXiillNUp82SFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Mb/AIO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c1877b428so40233336d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760732392; x=1761337192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmvTb6BTspYbBcs9I374v/VwG9kjrq7dAH3A3s7F1Tc=;
        b=D/Mb/AIOVR3D7biPnz795Wb9CSRy3EG16XadH8760Tj6QydEirezSYw+EzvWIeJkaD
         VD7aVJ+raDvyzt1N+iIn6Aibb4g3hlDbI0zW4r4R3FfplDoJm2EaTM0oLAhDeZeFkEL4
         3M3Cz05FMeQxS6oE14YhYyREfN03cQnOeYYMOwtgOR+2agkhIA5YdaPG468lRj/AkGpZ
         yMEEO08oNrqtrReb0VpUlcONgkhuc4Bdk6iTz8ojRehLd+9xlT1Yku1LDkoR1ZQSGocR
         EdSJuHmj2Q9cNvv38r+9XF/csQ6CBCnBcv6glq68D8uUf/HhV9MAywX5p5abqq0MrLag
         aufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732392; x=1761337192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmvTb6BTspYbBcs9I374v/VwG9kjrq7dAH3A3s7F1Tc=;
        b=v4HxG4U0E/MCJII9JmAwTamyjpoRLuKC6YmyjshuSrAgyorQkOCsoXOs/Q/CoIm5ak
         dXM62lrBr/tul6fk33Ew3pCC0Qfs44j3iHy0KbFz0Ynd93YK4jxYwRzF9S+VIEc8lvmQ
         BN/m4YA+OfYg8AuKy7U58DLG0AUCHlzHkelqy46HZX0fO/2pTXwEnENJG21Wn813JzGJ
         emqHMAjYWMaqcco3/w+PczHXqLhTDeBaWOZ2p8fccMEy9EZ2KzyHqHR4i6Mc7xKXxIDd
         X4u/UDKoDCR2JA+Uth0zCN0xd49MLdSqaVatL930lwbBHF3XS+0/0S7GtmFz4NHxh3oG
         rNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzyakU8PmncNXGNY/K5FVRit6cjFuQ11+Eln1LGesAv/4H2t9gK5sp9VMiLejxzYkGLX00v3B6eKRapfi1@vger.kernel.org
X-Gm-Message-State: AOJu0YwbI+bmtlRPb/yJr79Blvw+Q5eq6SnmALw5brFXrvPPuIfHxlzO
	EWuiHKLzeUXKp/P35O2LCZJO6M3zV57aQsMmTM/xbPlRVRWyIIVHsh26rcJ7wsiRas0rwZfyBvM
	yp9DQJZkv54mi5UKTF7SDMbGWXI2E3MU=
X-Gm-Gg: ASbGncuJU1SqY9xZVuWT0dbbJoozJPnlV6OnI7qawBHZIfCswd1JcB5BgrHUz4bLc6o
	WAg4mpGXoPzzX3LKEJAkKtJ4hyyTS5tZfxxOKkbw0uPckrH/24zrzaxcgWI4+8skVOQYU3blGxk
	ak2E4W7XphJpgVuqDqKZUdks0KzZGU7hOcsTO4PrbYq8hn8pIPyaMQGwbX0kgIWq6oIG0EVsTrW
	HDqetkuUzovl7Wyh6PESGABUKcdgy7FAAF1b29rpuuMMZez/vlFgMTlsqhaEapTFSgdPuK4QK0r
	gnpuSQJaH5ITOI778xQuuzWvQw4=
X-Google-Smtp-Source: AGHT+IF2uXTRROdAmeNjYsaKSGGf6ywdeWsug1qzmmf1xvjvn9Z2geaeNr1i4Tsa25BvCllOvjf7bfQ6iR36yoG9NYQ=
X-Received: by 2002:a05:6214:1c8e:b0:7e4:67a8:b1b5 with SMTP id
 6a1803df08f44-87c20649be0mr80264886d6.63.1760732391795; Fri, 17 Oct 2025
 13:19:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <aPDXIWeTKceHuqkj@bfoster> <CAJnrk1YeT8uBLf0e2-+wd6vKMH4Rp9dhHbC0d9eCu1hEwhiANA@mail.gmail.com>
 <aPJhy4kEw0M7vtz-@bfoster> <aPKKgctbV4TQ9vid@bfoster>
In-Reply-To: <aPKKgctbV4TQ9vid@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Oct 2025 13:19:39 -0700
X-Gm-Features: AS18NWDyqLC1HtTLn7ZQ66L-8JwLQMGQDw4IIAA70rf4_8262Syr-jP0phQNZsE
Message-ID: <CAJnrk1YLuiRyVwEW6nR1fUnvWf1Ozu1hK4LKn3mRWKeECVyMAA@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Brian Foster <bfoster@redhat.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:23=E2=80=AFAM Brian Foster <bfoster@redhat.com> =
wrote:
>
> On Fri, Oct 17, 2025 at 11:33:31AM -0400, Brian Foster wrote:
> > On Thu, Oct 16, 2025 at 03:39:27PM -0700, Joanne Koong wrote:
> > > On Thu, Oct 16, 2025 at 4:25=E2=80=AFAM Brian Foster <bfoster@redhat.=
com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 06:27:10PM -0700, Joanne Koong wrote:
> > > > > On Wed, Oct 15, 2025 at 5:36=E2=80=AFPM Joanne Koong <joannelkoon=
g@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 11:39=E2=80=AFAM Gao Xiang <hsiangkao@l=
inux.alibaba.com> wrote:
> > > > > > >
> > > > > > > Hi Joanne,
> > > > > > >
> > > > > > > On 2025/10/16 02:21, Joanne Koong wrote:
> > > > > > > > On Wed, Oct 15, 2025 at 11:06=E2=80=AFAM Gao Xiang <hsiangk=
ao@linux.alibaba.com> wrote:
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > >>>
> > > > > > > >>> This is where I encountered it in erofs: [1] for the "WAR=
NING in
> > > > > > > >>> iomap_iter_advance" syz repro. (this syzbot report was ge=
nerated in
> > > > > > > >>> response to this patchset version [2]).
> > > > > > > >>>
> > > > > > > >>> When I ran that syz program locally, I remember seeing po=
s=3D116 and length=3D3980.
> > > > > > > >>
> > > > > > > >> I just ran the C repro locally with the upstream codebase =
(but I
> > > > > > > >> didn't use the related Kconfig), and it doesn't show anyth=
ing.
> > > > > > > >
> > > > > > > > Which upstream commit are you running it on? It needs to be=
 run on top
> > > > > > > > of this patchset [1] but without this fix [2]. These change=
s are in
> > > > > > > > Christian's vfs-6.19.iomap branch in his vfs tree but I don=
't think
> > > > > > > > that branch has been published publicly yet so maybe just p=
atching it
> > > > > > > > in locally will work best.
> > > > > > > >
> > > > > > > > When I reproed it last month, I used the syz executor (not =
the C
> > > > > > > > repro, though that should probably work too?) directly with=
 the
> > > > > > > > kconfig they had.
> > > > > > >
> > > > > > > I believe it's a regression somewhere since it's a valid
> > > > > > > IOMAP_INLINE extent (since it's inlined, the length is not
> > > > > > > block-aligned of course), you could add a print just before
> > > > > > > erofs_iomap_begin() returns.
> > > > > >
> > > > > > Ok, so if erofs is strictly block-aligned except for tail inlin=
e data
> > > > > > (eg the IOMAP_INLINE extent), then I agree, there is a regressi=
on
> > > > > > somewhere as we shouldn't be running into the situation where e=
rofs is
> > > > > > calling iomap_adjust_read_range() with a non-block-aligned posi=
tion
> > > > > > and length. I'll track the offending commit down tomorrow.
> > > > > >
> > > > >
> > > > > Ok, I think it's commit bc264fea0f6f ("iomap: support incremental
> > > > > iomap_iter advances") that changed this behavior for erofs such t=
hat
> > > > > the read iteration continues even after encountering an IOMAP_INL=
INE
> > > > > extent, whereas before, the iteration stopped after reading in th=
e
> > > > > iomap inline extent. This leads erofs to end up in the situation =
where
> > > > > it calls into iomap_adjust_read_range() with a non-block-aligned
> > > > > position/length (on that subsequent iteration).
> > > > >
> > > > > In particular, this change in commit bc264fea0f6f to iomap_iter()=
:
> > > > >
> > > > > -       if (ret > 0 && !iter->processed && !stale)
> > > > > +       if (ret > 0 && !advanced && !stale)
> > > > >
> > > > > For iomap inline extents, iter->processed is 0, which stopped the
> > > > > iteration before. But now, advanced (which is iter->pos -
> > > > > iter->iter_start_pos) is used which will continue the iteration (=
since
> > > > > the iter is advanced after reading in the iomap inline extents).
> > > > >
> > > > > Erofs is able to handle subsequent iterations after iomap_inline
> > > > > extents because erofs_iomap_begin() checks the block map and retu=
rns
> > > > > IOMAP_HOLE if it's not mapped
> > > > >         if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> > > > >                 iomap->type =3D IOMAP_HOLE;
> > > > >                 return 0;
> > > > >         }
> > > > >
> > > > > but I think what probably would be better is a separate patch tha=
t
> > > > > reverts this back to the original behavior of stopping the iterat=
ion
> > > > > after IOMAP_INLINE extents are read in.
> > > > >
> > > >
> > > > Hmm.. so as of commit bc264fea0f6f, it looks like the read_inline()=
 path
> > > > still didn't advance the iter at all by that point. It just returne=
d 0
> > > > and this caused iomap_iter() to break out of the iteration loop.
> > > >
> > > > The logic noted above in iomap_iter() is basically saying to break =
out
> > > > if the iteration did nothing, which is a bit of a hacky way to term=
inate
> > > > an IOMAP_INLINE read. The proper thing to do in that path IMO is to
> > > > report the bytes processed and then terminate some other way more
> > > > naturally. I see Gao actually fixed this sometime later in commit
> > > > b26816b4e320 ("iomap: fix inline data on buffered read"), which is =
when
> > > > the inline read path started to advance the iter.
> > >
> > > That's a good point, the fix in commit b26816b4e320 is what led to th=
e
> > > new erofs behavior, not commit bc264fea0f6f.
> > >
> > > >
> > > > TBH, the behavior described above where we advance over the inline
> > > > mapping and then report any remaining iter length as a hole also so=
unds
> > > > like reasonably appropriate behavior to me. I suppose you could arg=
ue
> > > > that the inline case should just terminate the iter, which perhaps =
means
> > > > it should call iomap_iter_advance_full() instead. That technically
> > > > hardcodes that we will never process mappings beyond an inline mapp=
ing
> > > > into iomap. That bugs me a little bit, but is also probably always =
going
> > > > to be true so doesn't seem like that big of a deal.
> > >
> > > Reporting any remaining iter length as a hole also sounds reasonable
> > > to me but it seems that this may add additional work that may not be
> > > trivial. For example, I'm looking at erofs's erofs_map_blocks() call
> > > which they would need to do to figure out it should be an iomap hole.
> > > It seems a bit nonideal to me that any filesystem using iomap inline
> > > data would also have to make sure they cover this case, which maybe
> > > they already need to do that, I'm not sure, but it seems like an extr=
a
> > > thing they would now need to account for.
> > >
> >
> > To make sure I follow, you're talking about any potential non-erofs
> > cases, right? I thought it was mentioned that erofs already handled thi=
s
> > correctly by returning a hole. So I take this to mean other users would
> > need to handle this similarly.

Yes, sorry if my previous wording was confusing. Erofs already handles
this correctly but there's some overhead with having to determine it's
a hole.

> >
> > Poking around, I see that ext4 uses iomap and IOMAP_INLINE in a couple
> > isolated cases. One looks like swapfile activation and the other appear=
s
> > to be related to fiemap. Any idea if those are working correctly? At
> > first look it kind of looks like they check and return error for offset
> > beyond the specified length..
> >
>
> JFYI from digging further.. ext4 returns -ENOENT for this "offset beyond
> inline size" case. I didn't see any error returns from fiemap/filefrag
> on a quick test against an inline data file. It looks like
> iomap_fiemap() actually ignores errors either if the previous mapping is
> non-hole, or catches -ENOENT explicitly to handle an attribute mapping
> case. So afaict this all seems to work Ok..
>
> I'm not sure this is all that relevant for the swap case. mkswap
> apparently requires a file at least 40k in size, which iiuc is beyond
> the scope of files with inline data..

I think gfs2 also uses IOMAP_INLINE. In __gfs2_iomap_get(), it looks
like they report a hole if the offset is beyond the inode size, so
that looks okay.

>
> Brian
>
> > > One scenario I'm imagining maybe being useful in the future is
> > > supporting chained inline mappings, in which case we would still want
> > > to continue processing after the first inline mapping, but we could
> > > also address that if it does come up.
> > >
> >
> > Yeah..
> >
> > > >
> > > > If we wanted to consider it an optimization so we didn't always do =
this
> > > > extra iter on inline files, perhaps another variant of that could b=
e an
> > > > EOF flag or some such that the fs could set to trigger a full advan=
ce
> > > > after the current mapping. OTOH you could argue that's what inline
> > > > already is so maybe that's overthinking it. Just a thought. Hm?
> > > >
> > >
> > > Would non-inline iomap types also find that flag helpful or is the
> > > intention for it to be inline specific? I guess the flag could also b=
e
> > > used by non-inline types to stop the iteration short, if there's a us=
e
> > > case for that?
> > >
> >
> > ... I hadn't really considered that. This was just me thinking out loud
> > about trying to handle things more generically.
> >
> > Having thought more about it, I think either way it might just make
> > sense to fix the inline read case to do the full advance (assuming it i=
s
> > verified this fixes the problem) to restore historical iomap behavior.

Hmm, the iter is already fully advanced after the inline data is read.
I think the issue is that when the iomap mapping length is less than
the iter len (the iter len will always be the size of the folio but
the length for the inline data could be less), then advancing it fully
through iomap_iter_advance_full() will only advance it up to the iomap
length. iter->len will then still have a positive value which makes
iomap_iter() continue iterating.

I don't see a cleaner way of restoring historical iomap behavior than
adding that eof/stop flag.

Thanks,
Joanne


> > Then if there is ever value to support multiple inline mappings somehow
> > or another, we could revisit the flag idea.

> >
> > Brian
> >
> > > Thanks,
> > > Joanne

