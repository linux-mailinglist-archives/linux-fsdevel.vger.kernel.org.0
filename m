Return-Path: <linux-fsdevel+bounces-32013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D399F38E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477A51C2237F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886F1F76B4;
	Tue, 15 Oct 2024 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJwdpUBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFB1F6665
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011582; cv=none; b=ForZ/WVl7Lag9PYE/z2my+bnOj/CflBwMDPHbwZWFv9h8knvb//9j6RIVif+bhHdut2KOWHOjQy4inaTtNNW6klYmsqPDfUkPkh2tj8XWaBumcAft6+5Oexeu98+4VvNdSAgceQF3kmyxzBTDTCUgBWyJG6Men0K14qAwDf3P2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011582; c=relaxed/simple;
	bh=CY7RVZ7pao828uLrtW0J9y/KtM1/Q2jXloY6x5KO/oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtMtLpgPgHPEwpZ4LnukSAW9mvkFR/jkP5+1h12E+n4tfXYgVEmjAM8uy8K98rco+1rfGC71Ga9VGszXhUINuLBza8uxnObbueO8w60Wj/0DbBOsqCB94EoTsKkm4tSyXRUv4Ls9L9YiPJ8wCy2nguIGtaWQPKkSfR2oir6btoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJwdpUBT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4605674e9cdso34964331cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729011579; x=1729616379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hdQgYz3+tlcMaERkh9NayoSNz5uNPePWp1YebiOWzA=;
        b=jJwdpUBTsoxdDE0oz8x9GMPnqWuCB83HfoKK0eikYAPVllPxGi1quBXeTqiI8ICGHG
         +fNNxr9us+5M4pdqVCIizsUa+evg3mqlW7/RXj21oYTo5BSqu81vq9+a7bVQUmBkz7IX
         uHUdiY3/znca+EbLdL6Sy8JHXvpGTect/cKaP8/WuhZlfoeQXThlC12oHgrL4NhM3J45
         Js9jsP6uX83x+C9uYb61d+xj9mP4fVKQrJJrymgF21/PY+UdslJlRMwr57R6M+TEdyC1
         eYBBZI/i4VV5UivuH+HrCmZo7zsdLQ7E0bULjgVMCsBxhxn9/xgsZe4LD4A4vg1BzSdy
         WxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011579; x=1729616379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hdQgYz3+tlcMaERkh9NayoSNz5uNPePWp1YebiOWzA=;
        b=u4VZfk34pNbEqJJLbrSW8uuolwpTNdama0+6+7q8+TO1lwx2ttzrYEdaRHo6GgcfxC
         Te3csadpH4/GqetZsvzKhj8aAKDMeTnUzOliR94mdVNVPJxwdo6kPBZMG6vHL6VN5l9Z
         PlREDPDOBut77nQujRjbnvmbVkIJOmaNejsaiR7eDa9T0wrffNO0q5zwpuTp9zRe20np
         hJLqaXfP+syXD1bvPxXsxvDtgFDycmAXiqhoemVNK3YpxbF7VwNI8DSidMW/Pv42jpcN
         TBFvOm9njHo+aQQsMA4IZaf7mvIB2C3XNIBoWwBiiSgh23NTM7DAoexV11Ukkj6/bXef
         75Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVmib6lz2Q0c/LDsUU8DMNDbrkvhkATp43C3ePgbS11ULa5kN/yCDRgwqrRy9aO7K2+NlLzAxUxdd1jij7j@vger.kernel.org
X-Gm-Message-State: AOJu0YzFO5jKYtKCop0Pd7mI44WUL1WrpWnjUZCVvd0q9OPfJhdE9my/
	aKGO1o7Vk1jUHdWzFcBxoH7wr8zAjcxMIpwAFyackWgGFUbwitJX+LNKXS33h9E645h7eC0if0d
	0piykYwKfCo0qdDL7YMeLgcLdcZhuvXdmv0k=
X-Google-Smtp-Source: AGHT+IEzKxSyuGa1u19VyJ1QozJtT4I0UpsgYyVVZ4ObTgk3zSnNTQ3YLtlev3syyZY8uiFoV4BGxQDjW+2ESvY1akw=
X-Received: by 2002:a05:622a:114e:b0:453:7634:bbfa with SMTP id
 d75a77b69052e-460584249f1mr231528341cf.21.1729011579203; Tue, 15 Oct 2024
 09:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-2-joannelkoong@gmail.com> <265keu5uzo3gzqrvhcn2cagii4sak3e2a372ra7jlav35fnkrx@aicyzyftun3l>
 <CAJnrk1Yrn3_eXPCrXDqA-5F2un33BAxrP=GdmrLw7bhtbGypjA@mail.gmail.com> <5yasw5ke7aqfp2g7kzj2uzrrmvblesywavs6qs3bdcpe4vkmv2@iwpivyu7kzgy>
In-Reply-To: <5yasw5ke7aqfp2g7kzj2uzrrmvblesywavs6qs3bdcpe4vkmv2@iwpivyu7kzgy>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 15 Oct 2024 09:59:28 -0700
Message-ID: <CAJnrk1aAVmCx5hHfWETEGer7OuEeRPvmjvu-XG0o-E1u-C-r6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: skip reclaiming folios in writeback contexts
 that may trigger deadlock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:57=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Oct 14, 2024 at 02:04:07PM GMT, Joanne Koong wrote:
> > On Mon, Oct 14, 2024 at 11:38=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 11:22:27AM GMT, Joanne Koong wrote:
> > > > Currently in shrink_folio_list(), reclaim for folios under writebac=
k
> > > > falls into 3 different cases:
> > > > 1) Reclaim is encountering an excessive number of folios under
> > > >    writeback and this folio has both the writeback and reclaim flag=
s
> > > >    set
> > > > 2) Dirty throttling is enabled (this happens if reclaim through cgr=
oup
> > > >    is not enabled, if reclaim through cgroupv2 memcg is enabled, or
> > > >    if reclaim is on the root cgroup), or if the folio is not marked=
 for
> > > >    immediate reclaim, or if the caller does not have __GFP_FS (or
> > > >    __GFP_IO if it's going to swap) set
> > > > 3) Legacy cgroupv1 encounters a folio that already has the reclaim =
flag
> > > >    set and the caller did not have __GFP_FS (or __GFP_IO if swap) s=
et
> > > >
> > > > In cases 1) and 2), we activate the folio and skip reclaiming it wh=
ile
> > > > in case 3), we wait for writeback to finish on the folio and then t=
ry
> > > > to reclaim the folio again. In case 3, we wait on writeback because
> > > > cgroupv1 does not have dirty folio throttling, as such this is a
> > > > mitigation against the case where there are too many folios in writ=
eback
> > > > with nothing else to reclaim.
> > > >
> > > > The issue is that for filesystems where writeback may block, sub-op=
timal
> > > > workarounds need to be put in place to avoid potential deadlocks th=
at may
> > > > arise from the case where reclaim waits on writeback. (Even though =
case
> > > > 3 above is rare given that legacy cgroupv1 is on its way to being
> > > > deprecated, this case still needs to be accounted for)
> > > >
> > > > For example, for FUSE filesystems, when a writeback is triggered on=
 a
> > > > folio, a temporary folio is allocated and the pages are copied over=
 to
> > > > this temporary folio so that writeback can be immediately cleared o=
n the
> > > > original folio. This additionally requires an internal rb tree to k=
eep
> > > > track of writeback state on the temporary folios. Benchmarks show
> > > > roughly a ~20% decrease in throughput from the overhead incurred wi=
th 4k
> > > > block size writes. The temporary folio is needed here in order to a=
void
> > > > the following deadlock if reclaim waits on writeback:
> > > > * single-threaded FUSE server is in the middle of handling a reques=
t that
> > > >   needs a memory allocation
> > > > * memory allocation triggers direct reclaim
> > > > * direct reclaim waits on a folio under writeback (eg falls into ca=
se 3
> > > >   above) that needs to be written back to the fuse server
> > > > * the FUSE server can't write back the folio since it's stuck in di=
rect
> > > >   reclaim
> > > >
> > > > This commit adds a new flag, AS_NO_WRITEBACK_RECLAIM, to "enum
> > > > mapping_flags" which filesystems can set to signify that reclaim
> > > > should not happen when the folio is already in writeback. This only=
 has
> > > > effects on the case where cgroupv1 memcg encounters a folio under
> > > > writeback that already has the reclaim flag set (eg case 3 above), =
and
> > > > allows for the suboptimal workarounds added to address the "reclaim=
 wait
> > > > on writeback" deadlock scenario to be removed.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  include/linux/pagemap.h | 11 +++++++++++
> > > >  mm/vmscan.c             |  6 ++++--
> > > >  2 files changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > > index 68a5f1ff3301..513a72b8451b 100644
> > > > --- a/include/linux/pagemap.h
> > > > +++ b/include/linux/pagemap.h
> > > > @@ -210,6 +210,7 @@ enum mapping_flags {
> > > >       AS_STABLE_WRITES =3D 7,   /* must wait for writeback before m=
odifying
> > > >                                  folio contents */
> > > >       AS_INACCESSIBLE =3D 8,    /* Do not attempt direct R/W access=
 to the mapping */
> > > > +     AS_NO_WRITEBACK_RECLAIM =3D 9, /* Do not reclaim folios under=
 writeback */
> > >
> > > Isn't it "Do not wait for writeback completion for folios of this
> > > mapping during reclaim"?
> >
> > I think if we make this "don't wait for writeback completion for
> > folios of this mapping during reclaim", then the
> > mapping_no_writeback_reclaim check in shrink_folio_list() below would
> > need to be something like this instead:
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 885d496ae652..37108d633d21 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1190,7 +1190,8 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                         /* Case 3 above */
> >                         } else {
> >                                 folio_unlock(folio);
> > -                               folio_wait_writeback(folio);
> > +                               if (mapping &&
> > !mapping_no_writeback_reclaim(mapping))
> > +                                       folio_wait_writeback(folio);
> >                                 /* then go back and try same folio agai=
n */
> >                                 list_add_tail(&folio->lru, folio_list);
> >                                 continue;
>
> The difference between the outcome for Case 2 and Case 3 is that in Case
> 2 the kernel is putting the folio in an active list and thus the kernel
> will not try to reclaim it in near future but in Case 3, the kernel is
> putting back in the list from which it is currently reclaiming meaning
> the next iteration will try to reclaim the same folio.
>
> We definitely don't want it in Case 3.
>
> >
> > which I'm not sure if that would be the correct logic here or not.
> > I'm not too familiar with vmscan, but it seems like if we are going to
> > reclaim the folio then we should wait on it or else we would just keep
> > trying the same folio again and again and wasting cpu cycles. In this
> > current patch (if I'm understanding this mm code correctly), we skip
> > reclaiming the folio altogether if it's under writeback.
> >
> > Either one (don't wait for writeback during reclaim or don't reclaim
> > under writeback) works for mitigating the potential fuse deadlock,
> > but I was thinking "don't reclaim under writeback" might also be more
> > generalizable to other filesystems.
> >
> > I'm happy to go with whichever you think would be best.
>
> Just to be clear that we are on the same page that this scenario should
> be handled in Case 2. Our difference is on how to describe the scenario.
> To me the reason we are taking the path of Case 2 is because we don't
> want what Case 3 is doing and thus wrote that. Anyways I don't think it
> is that importatnt, use whatever working seems reasonable to you.

Gotcha, thanks for clarifying. Your point makes sense to me - if we go
this route we should also probably change the name to
AS_NO_RECLAIM_WAIT_WRITEBACK or something like that to make it more
congruent.

For now, I'll keep it as AS_NO_WRITEBACK_RECLAIM because I think that
might be more generalizable of a use case for other filesystems too.

>
> BTW you will need to update the comment for Case 2 which is above code
> block.

Great point, I will do this in v3.


Thanks,
Joanne
>
> thanks,
> Shakeel

