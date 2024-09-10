Return-Path: <linux-fsdevel+bounces-29019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC2973894
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A841C210AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5C18FDDF;
	Tue, 10 Sep 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOS0izhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D0137772
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974770; cv=none; b=YUuXE1vznN2yOJe5lk8Z6TUTM4NconBFR9j7H5vDkFCgIqgSj3mzUGdkaluBrDuyEUFTUPA9l0RWzxJ/6l+lB28BTsVL85z7laBjQqGBdmHnW8LEc5zSjVxpgbX4AUaAHHmm+LbuFzJUOnuuiXLvgN+o8qAA7sEVVGaLr14jy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974770; c=relaxed/simple;
	bh=N1qKDxPt8OGEjG93rKczJRC91uvITjKEXa9lEN9BiNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCAByFPJdtpH2RC5uBvMzsPGKs4jck6grHILrFMSYrofONYWjQ2UGbVsmdPIeZiD8LGR+3epSiyKc2eQZbczlAmaL5XNrMOCEA5u8occquoZak06W2GwNw5BnknyJTCrGo3wVMUs5EyH7QnDgca3Vrw+yfGLgSDxnBg5Vv72KWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOS0izhH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so10055321a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725974766; x=1726579566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHriZW/2yHOz6w7sn8IcX4MdTt+o2o4JEkR5cHxI9dI=;
        b=MOS0izhHOrGacQKdd4MIQrcpHmee9QzroSil174L/SNXIBbbfixz4/1cw+m2ojwZ3b
         9AiJRhB7z8EitGw++dtfWGjhJ2r7FaEpCRw+MNGoEwCtL85FB/uvOrToNoE2a+jzYRGD
         AURHpoIIRCqw4EmnNbf8oPvQQV6GYTDWkdJ3A99PI8Zzh9hGFIE9DiarNA+98mwaU5+b
         w3VBa8STF2EHtxWrBB2m2tI5logoubxWlUsdpygWpnUubYELgmJ0PIWODAvQf9a4fVWE
         aAkLmo9en4TR5fsHHLrCKsCBnw+ZERcf9NnvpymplR/RioGqymVq2DZIMx98675podC1
         MbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974766; x=1726579566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHriZW/2yHOz6w7sn8IcX4MdTt+o2o4JEkR5cHxI9dI=;
        b=R8QsEvcEzLlbkSMf9xEvqo4X418ySwrm26WZZff6t2GaSdn28/VgNkE5Kk7PFao+UV
         aAfXb+omwsGcRLFIUQ/KgHQdEUUnVTq2juKnLTUYMIeVL8t5V5z/G9hLR+7pN87Mjjim
         GLHmPJWRHnq2LquunaT3NamZe7/j6BrpbWWP00Pza68QoeppB+R6mRWAnqw4N2RuW7JD
         Uj01wnPdO2LFjJleAUHSyeegZKmYPkX5knL2WjQtjk+R3X75nRKgqg4SwRoN5u/60PWg
         j8nS7YltOLkLRzFe+QZLlJBpNmfWFxXigBOtThoXZUbk2a/hqNNOwQQa5+C+KAjm3U1r
         yzJg==
X-Gm-Message-State: AOJu0YwPOVt6MSnS9CTlSx8cruVadVhdq14W9OxCipT+ErGYJ6jQoXe2
	0Imc1SLFcVLfXgp2p5fYuX3IUw1hIveFeHoCSa9JNwZ/QMMajg3y1/5p66RCA5bFKifxGE0lKOb
	TY3jDucN8txfiDmiRjh2sW8OpBC0=
X-Google-Smtp-Source: AGHT+IFOoy3zVw0XY5Lmr4ATbX9UaptJXTjVrvsgxX9JFm02SHM1RSRwNfUDjXFa4MvNsEwIPkKky1oyIslHxPaap50=
X-Received: by 2002:a05:6402:3548:b0:5c2:7741:7d82 with SMTP id
 4fb4d7f45d1cf-5c4015e7553mr3283747a12.11.1725974765266; Tue, 10 Sep 2024
 06:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
 <ZttT_sHrS5NQPAM9@bfoster> <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
 <Zt74BI7C-ZPn_WV_@bfoster> <CAHB1Nahz2UmrCpqEivV0Dzkt5P=rjbRaBekxtaXeWNraXfvCCA@mail.gmail.com>
 <Zt9MrgnBStwlGWpY@bfoster> <767963be0ce83221792d58667afd8b4ccc4f160d.camel@gmail.com>
 <ZuA70EmA47amHnwH@bfoster>
In-Reply-To: <ZuA70EmA47amHnwH@bfoster>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 10 Sep 2024 21:25:41 +0800
Message-ID: <CAHB1Naj2XsnmeXJorOon1d1sOJnKKX4qeu_XZ+Z+8rd2vzcZow@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com, hch@lst.de, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 20:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 10, 2024 at 03:03:18PM +0800, Julian Sun wrote:
> > On Mon, 2024-09-09 at 15:29 -0400, Brian Foster wrote:
> > > On Tue, Sep 10, 2024 at 01:40:24AM +0800, Julian Sun wrote:
> > > > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=80 21:27=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On Mon, Sep 09, 2024 at 08:15:43PM +0800, Julian Sun wrote:
> > > > > > Hi Brian,
> > > > > >
> > > > > > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=
=887=E6=97=A5=E5=91=A8=E5=85=AD 03:11=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >
> > > > > > > On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> > > > > > > > Attempting to unshare extents beyond EOF will trigger
> > > > > > > > the need zeroing case, which in turn triggers a warning.
> > > > > > > > Therefore, let's skip the unshare process if extents are
> > > > > > > > beyond EOF.
> > > > > > > >
> > > > > > > > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkall=
er.appspotmail.com
> > > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b=
9cbf306e5a0
> > > > > > > > Fixes: 32a38a499104 ("iomap: use write_begin to read pages =
to unshare")
> > > > > > > > Inspired-by: Dave Chinner <david@fromorbit.com>
> > > > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > > > ---
> > > > > > > >  fs/iomap/buffered-io.c | 3 +++
> > > > > > > >  1 file changed, 3 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.=
c
> > > > > > > > index f420c53d86ac..8898d5ec606f 100644
> > > > > > > > --- a/fs/iomap/buffered-io.c
> > > > > > > > +++ b/fs/iomap/buffered-io.c
> > > > > > > > @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(stru=
ct iomap_iter *iter)
> > > > > > > >       /* don't bother with holes or unwritten extents */
> > > > > > > >       if (srcmap->type =3D=3D IOMAP_HOLE || srcmap->type =
=3D=3D IOMAP_UNWRITTEN)
> > > > > > > >               return length;
> > > > > > > > +     /* don't try to unshare any extents beyond EOF. */
> > > > > > > > +     if (pos > i_size_read(iter->inode))
> > > > > > > > +             return length;
> > > > > > >
> > > > > > > Hi Julian,
> > > > > > >
> > > > > > >
> > > > > > > > What about if pos starts within EOF and the operation exten=
ds beyond it?
> > > > > >
> > > > > > Extents within EOF will be unshared as usual. Details are below=
.
> > > > > > >
> > > > > > > > I ask because I think I've reproduced this scenario, though=
 it is a bit
> > > > > > > > tricky and has dependencies...
> > > > > > > >
> > > > > > > > For one, it seems to depend on the cowblocks patch I recent=
ly posted
> > > > > > > > here [1] (though I don't think this is necessarily a proble=
m with the
> > > > > > > > patch, it just depends on keeping COW fork blocks around af=
ter the
> > > > > > > > unshare). With that, I reproduce via fsx with unshare range=
 support [2]
> > > > > > > > using the ops file appended below [3] on a -bsize=3D1k XFS =
fs.
> > > > > > > >
> > > > > > > > I haven't quite characterized the full sequence other than =
it looks like
> > > > > > > > the unshare walks across EOF with a shared data fork block =
and COW fork
> > > > > > > > delalloc, presumably finds the post-eof part of the folio !=
uptodate (so
> > > > > > > > iomap_adjust_read_range() doesn't skip it), and then trips =
over the
> > > > > > > > warning and error return associated with the folio zeroing =
in
> > > > > > > > __iomap_write_begin().
> > > > > >
> > > > > > The scenario has already been reproduced by syzbot[1]. The repr=
oducer
> > > > > > provided by syzbot constructed the following extent maps for a =
file of
> > > > > > size 0xE00 before fallocate unshare:
> > > > > >
> > > > > > 0 - 4k: shared between two files
> > > > > > 4k - 6k: hole beyond EOF, not shared
> > > > > > 6k - 8k: delalloc extends
> > > > > >
> > > > > > Then the reproducer attempted to unshare the extent between 0 a=
nd
> > > > > > 0x2000 bytes, but the file size is 0xE00. This is likely the sc=
enario
> > > > > > you were referring to?
> > > > > >
> > > > >
> > > > > Yes, sort of..
> > > > >
> > > > > > Eventually the unshare code does:
> > > > > > first map: 0 - 4k - unshare successfully.
> > > > > > second map: 4k - 6k - hole, skip. Beyond EOF.
> > > > > > third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
> > > > > > Fires warnings because UNSHARE.
> > > > > >
> > > > > > During the first call to iomap_unshare_iter(), iomap_length() r=
eturned
> > > > > > 4k, so 4k bytes were unshared.
> > > > > > See discuss here[2] for more details.
> > > > > > >
> > > > > > > This all kind of has me wondering.. do we know the purpose of=
 this
> > > > > > > warning/error in the first place? It seems like it's more of =
an
> > > > > > > "unexpected situation" than a specific problem. E.g., assumin=
g the same
> > > > > > > page were mmap'd, I _think_ the read fault path would do the =
same sort
> > > > > > > of zeroing such that the unshare would see a fully uptodate f=
olio and
> > > > > > > carry on as normal. I added the mapread op to the opsfile bel=
ow to give
> > > > > > > that a quick test (remove the "skip" text to enable it), and =
it seems to
> > > > > > > prevent the error, but I've not confirmed whether that theory=
 is
> > > > > > > actually what's happening.
> > > > > > >
> > > > > > >
> > > > > > > > FWIW, I also wonder if another way to handle this would be =
to just
> > > > > > > > restrict the range of iomap_file_unshare() to within EOF. I=
OW if a
> > > > > > > > caller passes a range beyond EOF, just process whatever par=
t of the
> > > > > > > > range falls within EOF. It seems iomap isn't responsible fo=
r the file
> > > > > > > > extending aspect of the fallocate unshare command anyways.
> > > > > >
> > > > > > It already does 'just process whatever part of the range falls =
within EOF'.
> > > > > > Check the above case.
> > > > > >
> > > > > > I'm not sure if I fully understand what you mean. This patch do=
es not
> > > > > > prevent unsharing extents within the EOF. This patch checks if =
pos is
> > > > > > beyond EOF, instead of checking if pos + length is beyond EOF. =
So the
> > > > > > extents within EOF should be unshared as usual.
> > > > > >
> > > > >
> > > > > I'm not concerned about preventing unsharing. I'm concerned that =
this
> > > > > patch doesn't always prevent attempts to unshare post-eof ranges.=
 I
> > > > > think the difference here is that in the variant I was hitting, w=
e end
> > > > >
> > > > > > up with a mapping that starts within EOF and ends beyond EOF, w=
hereas
> > > > > > the syzbot variant produces a scenario where the problematic ma=
pping
> > > > > > always starts beyond EOF.
> > > >
> > > > This is not true. In the case above, the syzbot did indeed unshare =
the
> > > > extents between 0-4k, which were started within EOF and ended beyon=
d
> > > > EOF. The specific variants here are: pos:0 len:0x1000 EOF: 0xE00. A=
nd
> > > > the unshare code successfully unshared extents between 0 and 4k.
> > > >
> > > > During the next loop in iomap_file_unshare(), the pos became 0x1000=
,
> > > > which is beyond EOF.  What this patch does is to skip the unshare
> > > > during the second loop.
> > > > Is there anything I misunderstand=EF=BC=9F
> > >
> > > Hmm, what block size? Does the associated mapping have at least one f=
ull
> > > block beyond EOF? If you have a map at offset 0, length 0x1000 and EO=
F
> > > at 0xE00, then unless you have 512b blocks it sounds like the EOF blo=
ck
> > > actually starts within EOF.
> >
> > The block size here is 2k, and there isn't a full block beyond EOF with=
in
> > this extent map.
>
> Ok. That likely explains the difference in behavior. The fsx variant has
> a mapping that starts within EOF and has at least one post-EOF block
> that unshare attempts to process.
>
> > >
> > > The variant I'm seeing is more like this.. consider a -bsize=3D1k fs,=
 a
> > > file size of 0x3c400, and an EOF mapping of (offset 0x3c000, length
> > > 0x4000). The EOF folio in this case is 4k in size and starts at the s=
ame
> > > 0x3c000 offset as the EOF mapping.
> > >
> > > So with 1k blocks, the EOF mapping starts one block before EOF and
> > > extends well beyond it. What happens in the test case is that
> > > iomap_unshare_iter() is called with the EOF folio, pos 0x3c000, lengt=
h
> > > 0x800, and where the block at offset 0x3c400 is not marked uptodate. =
pos
> > > is thus within EOF, but the while loop in __iomap_write_begin() walks
> > > past it and attempts to process one block beyond EOF.
> >
> > Ok, so the key point here is that there is a full block beyond EOF with=
in
> > the associated extent map, which is different with the scenario reprodu=
ced
> > by syzbot.
> > According to the Dave's comments, the trimming behavior seems like shou=
ld
> > be done in filesystem(e.g.,xfs), instead of iomap. I will reconsider th=
is scenario.
> >
>
> Seems reasonable, but I don't agree that is a suitable fix for iomap. To
> be clear, it's perfectly fine for the fs to trim the range however it
> sees fit (i.e. no shared blocks beyond EOF in XFS), but we should also
> recognize that iomap is a generic layer and unshare is currently
> implemented to trip over itself, warn and fail if passed a post-eof
> range.
>
>
> > I still suspect that just making unshare work correctly around i_size
> > might be the more elegant long term solution, but that is not totally
> > clear. IMO, as long as unshare is written to intentionally trip over
> > itself for post-eof ranges, it should either trim the range or check fo=
r
> > valid parameters and document the limitation. Otherwise we just leave a
> > landmine for the next caller to have to work through the same problems,
> > which is particularly subtle since the higher level fallocate unshare
> > mode supports post-eof ranges. Just my .02.

Yeah, totally agreed. I prefer to do the trimming in the vfs layer
just like what generic_copy_file_checks() does, instead of a specific
file system. Maybe we need a helper function
generic_fallocate_checks(). But it requires more thought and testing.

>
> Brian
>
> > Thanks for your comments and review.
> > >
> > > Brian
> > >
> > > > >
> > > > > So IOW, this patch works for the syzbot variant because it happen=
s to
> > > > > reproduce a situation where pos will be beyond EOF, but that is a=
n
> > > > >
> > > > > > assumption that might not always be true. The fsx generated var=
iant runs
> > > > > > a sequence that produces a mapping that spans across EOF, which=
 means
> > > > > > that pos is within EOF at the start of unshare, so unshare proc=
eeds to
> > > > > > walk across the EOF boundary, the corresponding EOF folio is no=
t fully
> > > > > > uptodate, and thus write begin wants to do partial zeroing and
> > > > > > fails/warns.
> > > >
> > > > Yeah, it's exactly what the syzbot does.
> > > > >
> > > > > I suspect that if the higher level range were trimmed to be withi=
n EOF
> > > > > in iomap_file_unshare(), that would prevent this problem in eithe=
r case.
> > > > > Note that this was on a -bsize=3D1k fs, so what I'm not totally s=
ure about
> > > > > is whether skipping zeroing as such would be a problem with large=
r FSBs.
> > > > > My initial thinking was this might not be possible since the EOF =
folio
> > > > > should be fully uptodate in that case, but that probably requires=
 some
> > > > > thought/review/testing.
> > > > >
> > > > > Brian
> > > > >
> > > > > > BTW, maybe the check here should be
> > > > > >                   if (pos >=3D i_size_read(iter->inode))
> > > > > >
> > > > > > If there is any misunderstanding, please let me know, thanks.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/all/0000000000008964f1061f8c32b6@g=
oogle.com/T/
> > > > > > [2]: https://lore.kernel.org/all/20240903054808.126799-1-sunjun=
chao2870@gmail.com/
> > > > > >
> > > > > > >
> > > > > > > Thoughts?
> > > > > > >
> > > > > > > Brian
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1=
-bfoster@redhat.com/
> > > > > > > [2] https://lore.kernel.org/fstests/20240906185606.136402-1-b=
foster@redhat.com/
> > > > > > > [3] fsx ops file:
> > > > > > >
> > > > > > > fallocate 0x3bc00 0x400 0
> > > > > > > write 0x3bc00 0x800 0x3c000
> > > > > > > clone_range 0x3bc00 0x400 0x0 0x3c400
> > > > > > > skip mapread 0x3c000 0x400 0x3c400
> > > > > > > fallocate 0x3bc00 0xc00 0x3c400 unshare
> > > > > > >
> > > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > --
> > > > > > Julian Sun <sunjunchao2870@gmail.com>
> > > > > >
> > > > >
> > > >
> > > > Thanks,
> > > > --
> > > > Julian Sun <sunjunchao2870@gmail.com>
> > > >
> > >
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao2870@gmail.com>
> >
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

