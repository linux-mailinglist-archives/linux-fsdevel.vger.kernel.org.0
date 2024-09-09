Return-Path: <linux-fsdevel+bounces-28941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B71971917
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633DE1F2348F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FA1B6547;
	Mon,  9 Sep 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVTuznT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E815EFA1
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884162; cv=none; b=pB4xd5LhG9LmND5UnPjQODN6n06Q3A6qRunSDyQ0BCejXaIteTJ/JSR34G9HeVwVOZb2uHGgEnEFG1TCiLico2hT8ASaqA5g5vN8HkQCjFhN1cRivDdi8lO5DXKS8frCnTk/kDkjpKlJDZb1SVTC29olyqlyatcJFPsWjTU+cr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884162; c=relaxed/simple;
	bh=DhSkJUL8NJrMECGsPnuWPXkR0YqAN5KlJ6wwnrRBv7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXJlFEGHaJEcBmgozvWWYsCCgnPHovBFWWVGm72HLTiHP65uk5QWEU4EXTIX+fZ/Rb9PzRydDL5n6HsSp18mMgDCcPz8nOwC6j3ev7KPYLhn8G5u8d3r6svQEkXnx3S2Wb3TjuGNBk1FZMfFvqIy4n6b4Jk+8JRo5YX/0hR3YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQVTuznT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so26925981fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725884157; x=1726488957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs1LO9HKjlPki55gvqUejYVqcPzzhxN8fVRp2itascg=;
        b=EQVTuznT1bchdsb8X3EbDNmRUpNf/LbO+pKPOFmgDU8mludLGRU0/ppYerfuNusurb
         6irY1oAQ2nek9PIGSdc0ml9lru9ICg541EslasKICnNt1qrqdgdP5vLpD87CLTMcvcvh
         1NeTq5te2KG7Wg2qWl9qOC/hw2IO+Izc4MUf+Mx43cKiC1VNtclSuYP3FfVd5Oq7io/m
         5oobCjBxixC9A+ggebPjylzpmL1HjdA1bVT/jIIvJ1ScjF/xTYYryMXfkbG6T3qEXoaQ
         +TLmR3OS+YwGhptS8wQz2DWptG1rApDEy7NdNdMXgHq123DRG7DEyG0/3i3M9b3ssYrl
         EQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725884157; x=1726488957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs1LO9HKjlPki55gvqUejYVqcPzzhxN8fVRp2itascg=;
        b=btAZCtzgLAUO22D5TRSWmZhUMX+btDI26EiUPU9+jZ8rFmNECRoH5Avq0PA4p9uIA1
         UvZxGe77un8GPI9VR+octNs5zMXI8hJDD/TtILn5/yrA6YGspEPvmeAjKSrc9aUpsEal
         wBrl/SUu675bbdhNeDXhHN3BNMZnlg0JKSdgY0ICCNYD2E0qLSag9ikZDq3F5S4UCZtI
         d5nFtiReFEImfoh3Sg67iVkEihDNFJ4Zn27zc53EhcEtVssQbHw0A3adDZANwknxK8yh
         CGAhk0Elw1CRZ3GQyrGaAHTG7fVnyyFCH3RFOlEtTxX48pscf8616EWLALilTN+g1Qt1
         eOFg==
X-Gm-Message-State: AOJu0YwTSZ2E+CIaz0wg3j1a0oZFOS6Q4tJJAbOR/+iw7W3yYAgztHat
	f7fRdqfB7wT1NlmrCBOV7HdQfJkHIyNX+LiBEBrkpXfT8cxb8EvDnZUHN+gh8SHVO34vOZALiQX
	R/H8FGFpFI/Yeg80v0lHAlKV8XrE=
X-Google-Smtp-Source: AGHT+IHUGQyHBpG3HRrq902qh9xpO4UnZuCNA35yPaEKv7eiS+ScQjJoWGo3LVsmqEjR34WBg6GG7YoE9lZzGzGY7Ig=
X-Received: by 2002:a2e:bc15:0:b0:2f6:6198:1cf9 with SMTP id
 38308e7fff4ca-2f75aa0a315mr77025411fa.31.1725884155779; Mon, 09 Sep 2024
 05:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com> <ZttT_sHrS5NQPAM9@bfoster>
In-Reply-To: <ZttT_sHrS5NQPAM9@bfoster>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 9 Sep 2024 20:15:43 +0800
Message-ID: <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com, hch@lst.de, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=887=E6=97=
=A5=E5=91=A8=E5=85=AD 03:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> > Attempting to unshare extents beyond EOF will trigger
> > the need zeroing case, which in turn triggers a warning.
> > Therefore, let's skip the unshare process if extents are
> > beyond EOF.
> >
> > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotma=
il.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf306e5a0
> > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> > Inspired-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index f420c53d86ac..8898d5ec606f 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap_ite=
r *iter)
> >       /* don't bother with holes or unwritten extents */
> >       if (srcmap->type =3D=3D IOMAP_HOLE || srcmap->type =3D=3D IOMAP_U=
NWRITTEN)
> >               return length;
> > +     /* don't try to unshare any extents beyond EOF. */
> > +     if (pos > i_size_read(iter->inode))
> > +             return length;
>
> Hi Julian,
>
>
> > What about if pos starts within EOF and the operation extends beyond it=
?

Extents within EOF will be unshared as usual. Details are below.
>
> > I ask because I think I've reproduced this scenario, though it is a bit
> > tricky and has dependencies...
> >
> > For one, it seems to depend on the cowblocks patch I recently posted
> > here [1] (though I don't think this is necessarily a problem with the
> > patch, it just depends on keeping COW fork blocks around after the
> > unshare). With that, I reproduce via fsx with unshare range support [2]
> > using the ops file appended below [3] on a -bsize=3D1k XFS fs.
> >
> > I haven't quite characterized the full sequence other than it looks lik=
e
> > the unshare walks across EOF with a shared data fork block and COW fork
> > delalloc, presumably finds the post-eof part of the folio !uptodate (so
> > iomap_adjust_read_range() doesn't skip it), and then trips over the
> > warning and error return associated with the folio zeroing in
> > __iomap_write_begin().

The scenario has already been reproduced by syzbot[1]. The reproducer
provided by syzbot constructed the following extent maps for a file of
size 0xE00 before fallocate unshare:

0 - 4k: shared between two files
4k - 6k: hole beyond EOF, not shared
6k - 8k: delalloc extends

Then the reproducer attempted to unshare the extent between 0 and
0x2000 bytes, but the file size is 0xE00. This is likely the scenario
you were referring to?

Eventually the unshare code does:
first map: 0 - 4k - unshare successfully.
second map: 4k - 6k - hole, skip. Beyond EOF.
third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
Fires warnings because UNSHARE.

During the first call to iomap_unshare_iter(), iomap_length() returned
4k, so 4k bytes were unshared.
See discuss here[2] for more details.
>
> This all kind of has me wondering.. do we know the purpose of this
> warning/error in the first place? It seems like it's more of an
> "unexpected situation" than a specific problem. E.g., assuming the same
> page were mmap'd, I _think_ the read fault path would do the same sort
> of zeroing such that the unshare would see a fully uptodate folio and
> carry on as normal. I added the mapread op to the opsfile below to give
> that a quick test (remove the "skip" text to enable it), and it seems to
> prevent the error, but I've not confirmed whether that theory is
> actually what's happening.
>
>
> > FWIW, I also wonder if another way to handle this would be to just
> > restrict the range of iomap_file_unshare() to within EOF. IOW if a
> > caller passes a range beyond EOF, just process whatever part of the
> > range falls within EOF. It seems iomap isn't responsible for the file
> > extending aspect of the fallocate unshare command anyways.

It already does 'just process whatever part of the range falls within EOF'.
Check the above case.

I'm not sure if I fully understand what you mean. This patch does not
prevent unsharing extents within the EOF. This patch checks if pos is
beyond EOF, instead of checking if pos + length is beyond EOF. So the
extents within EOF should be unshared as usual.

BTW, maybe the check here should be
                  if (pos >=3D i_size_read(iter->inode))

If there is any misunderstanding, please let me know, thanks.

[1]: https://lore.kernel.org/all/0000000000008964f1061f8c32b6@google.com/T/
[2]: https://lore.kernel.org/all/20240903054808.126799-1-sunjunchao2870@gma=
il.com/

>
> Thoughts?
>
> Brian
>
> [1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1-bfoster@red=
hat.com/
> [2] https://lore.kernel.org/fstests/20240906185606.136402-1-bfoster@redha=
t.com/
> [3] fsx ops file:
>
> fallocate 0x3bc00 0x400 0
> write 0x3bc00 0x800 0x3c000
> clone_range 0x3bc00 0x400 0x0 0x3c400
> skip mapread 0x3c000 0x400 0x3c400
> fallocate 0x3bc00 0xc00 0x3c400 unshare
>


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

