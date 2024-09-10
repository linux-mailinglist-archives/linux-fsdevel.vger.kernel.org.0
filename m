Return-Path: <linux-fsdevel+bounces-29001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B8972A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B961C24069
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 07:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2217BEBF;
	Tue, 10 Sep 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHxfXH74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE17B50A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951807; cv=none; b=b1Sma59G9F30sRqrdWn5VHOZnl41aTN5y2o/gL6QOUumR8k1H8iOEaCq+KsbUkDHFrXPMGE/niwG7KWGeqZa6DXfBpsCAJCcu+xCEc48gT5L5g891lq/Le2keLmos554eu0u7ovr7X9QGtRp+IDR9gtmAFfvyDxZ7aR+Bjh0F6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951807; c=relaxed/simple;
	bh=t5pGYH7M5C9ip7SC1NbPF37re2AZrFNW66tMb7mVbgc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gXVOAoFsIx/fMDQygSVD/jjWgRhiOCSTQsc4/Ua4zq1J7cvpZkL85GAALOfxn9TWQjNiqldU+wcyGUSDiP1hve+eB6uKZsi9Fa6k6KelF842rwfgllsVAfdH/2Ay/6hr93T/XcITONWxxJIUPQ9tLa7GMSW/LTNE2rttzt3d7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHxfXH74; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2057835395aso4700725ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725951804; x=1726556604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t5pGYH7M5C9ip7SC1NbPF37re2AZrFNW66tMb7mVbgc=;
        b=nHxfXH7470rW1uc/rkxHrIefv/YhZ4buAK4slG5+09DbGlmwIH1wnM/m6E8Mp2MG9P
         yLiTFSGsRn8C3A1FAwAJRot5xBdbAS0s9GhimiQl5fNIGGI6xvLPbSKyUmfIjkIqZQ09
         M60cRjjr48FVVFrGFECXyLrI9VlPouMDdDO/jMcLrIBeWZMZtkiFd6up3QqrX9rfiAIq
         T2qGJrOgiNxkXAhcmHLZlSPfrGumvMNMCtq0r22s/LSTRGVtAIbVFNPCixe+4DMqpRzT
         Lg7dPZCuu7VqOY9/gUeIa5eT6yph9h8GZ+xZml66F9xXCe1ujAskA9uzX8FTa9YYmhTe
         MDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725951804; x=1726556604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5pGYH7M5C9ip7SC1NbPF37re2AZrFNW66tMb7mVbgc=;
        b=gkMURAF6af53XcXQMKuAn29Gaktsf+bDjOnkbWCLLv6zhoY/zyJnqEtYI1JaBv63eI
         LzuKLn+FUASwXIsv4PwupYI9FK1OJFKjtWwKvhj+o3lS93RbifRrBCtRYoqRyfJ7LDsl
         p/UaVCcz90/CD1Nqdta42vmVemYYit2rOP/9C00TVND+qJ8WoRS7NJs884Xrfug2G6Hj
         BkDGUwauGbBPa9OUA0Bsqe6otUUW5qVPft2JPKpOYB2W4ZB/JOTOH0uHGgjrIgf4Ynav
         tr0aoCt49/OgRH7NyI9dVvOkkKYbm2fuAua75mA3vANfMRm/xbXgVPOvWHSjmTdS4IV4
         mdpg==
X-Gm-Message-State: AOJu0Yw5QVRS3joXGQYudh35vMXgM5i6kEtncIL52bsNiX4xqFPADLSY
	3B2q61jk7V/1YUl7N/MPN+4CXOXlHJrQKBYn4yCm06O0MexnjHR/
X-Google-Smtp-Source: AGHT+IHrmVY1yzI29gcTB8fp1Eoy8eCX0o8cp1Y+OD+SdgNV0hk9C6NXZKwudYUlDXTv3ava2RLLUA==
X-Received: by 2002:a17:90b:295:b0:2d3:c0ea:72b3 with SMTP id 98e67ed59e1d1-2dafd0970f0mr10733860a91.34.1725951804019;
        Tue, 10 Sep 2024 00:03:24 -0700 (PDT)
Received: from [10.172.23.42] ([103.172.183.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c40e6sm5625521a91.30.2024.09.10.00.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:03:23 -0700 (PDT)
Message-ID: <767963be0ce83221792d58667afd8b4ccc4f160d.camel@gmail.com>
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
From: Julian Sun <sunjunchao2870@gmail.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
 viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com,
 hch@lst.de,  syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Date: Tue, 10 Sep 2024 15:03:18 +0800
In-Reply-To: <Zt9MrgnBStwlGWpY@bfoster>
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
	 <ZttT_sHrS5NQPAM9@bfoster>
	 <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
	 <Zt74BI7C-ZPn_WV_@bfoster>
	 <CAHB1Nahz2UmrCpqEivV0Dzkt5P=rjbRaBekxtaXeWNraXfvCCA@mail.gmail.com>
	 <Zt9MrgnBStwlGWpY@bfoster>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 15:29 -0400, Brian Foster wrote:
> On Tue, Sep 10, 2024 at 01:40:24AM +0800, Julian Sun wrote:
> > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=80 21:27=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > > On Mon, Sep 09, 2024 at 08:15:43PM +0800, Julian Sun wrote:
> > > > Hi Brian,
> > > >=20
> > > > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=887=
=E6=97=A5=E5=91=A8=E5=85=AD 03:11=E5=86=99=E9=81=93=EF=BC=9A
> > > > >=20
> > > > > On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> > > > > > Attempting to unshare extents beyond EOF will trigger
> > > > > > the need zeroing case, which in turn triggers a warning.
> > > > > > Therefore, let's skip the unshare process if extents are
> > > > > > beyond EOF.
> > > > > >=20
> > > > > > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.a=
ppspotmail.com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf=
306e5a0
> > > > > > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to u=
nshare")
> > > > > > Inspired-by: Dave Chinner <david@fromorbit.com>
> > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > ---
> > > > > > =C2=A0fs/iomap/buffered-io.c | 3 +++
> > > > > > =C2=A01 file changed, 3 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > > index f420c53d86ac..8898d5ec606f 100644
> > > > > > --- a/fs/iomap/buffered-io.c
> > > > > > +++ b/fs/iomap/buffered-io.c
> > > > > > @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct i=
omap_iter *iter)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* don't bother with holes or un=
written extents */
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (srcmap->type =3D=3D IOMAP_HO=
LE || srcmap->type =3D=3D IOMAP_UNWRITTEN)
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return length;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* don't try to unshare any extents b=
eyond EOF. */
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (pos > i_size_read(iter->inode))
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return length;
> > > > >=20
> > > > > Hi Julian,
> > > > >=20
> > > > >=20
> > > > > > What about if pos starts within EOF and the operation extends b=
eyond it?
> > > >=20
> > > > Extents within EOF will be unshared as usual. Details are below.
> > > > >=20
> > > > > > I ask because I think I've reproduced this scenario, though it =
is a bit
> > > > > > tricky and has dependencies...
> > > > > >=20
> > > > > > For one, it seems to depend on the cowblocks patch I recently p=
osted
> > > > > > here [1] (though I don't think this is necessarily a problem wi=
th the
> > > > > > patch, it just depends on keeping COW fork blocks around after =
the
> > > > > > unshare). With that, I reproduce via fsx with unshare range sup=
port [2]
> > > > > > using the ops file appended below [3] on a -bsize=3D1k XFS fs.
> > > > > >=20
> > > > > > I haven't quite characterized the full sequence other than it l=
ooks like
> > > > > > the unshare walks across EOF with a shared data fork block and =
COW fork
> > > > > > delalloc, presumably finds the post-eof part of the folio !upto=
date (so
> > > > > > iomap_adjust_read_range() doesn't skip it), and then trips over=
 the
> > > > > > warning and error return associated with the folio zeroing in
> > > > > > __iomap_write_begin().
> > > >=20
> > > > The scenario has already been reproduced by syzbot[1]. The reproduc=
er
> > > > provided by syzbot constructed the following extent maps for a file=
 of
> > > > size 0xE00 before fallocate unshare:
> > > >=20
> > > > 0 - 4k: shared between two files
> > > > 4k - 6k: hole beyond EOF, not shared
> > > > 6k - 8k: delalloc extends
> > > >=20
> > > > Then the reproducer attempted to unshare the extent between 0 and
> > > > 0x2000 bytes, but the file size is 0xE00. This is likely the scenar=
io
> > > > you were referring to?
> > > >=20
> > >=20
> > > Yes, sort of..
> > >=20
> > > > Eventually the unshare code does:
> > > > first map: 0 - 4k - unshare successfully.
> > > > second map: 4k - 6k - hole, skip. Beyond EOF.
> > > > third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
> > > > Fires warnings because UNSHARE.
> > > >=20
> > > > During the first call to iomap_unshare_iter(), iomap_length() retur=
ned
> > > > 4k, so 4k bytes were unshared.
> > > > See discuss here[2] for more details.
> > > > >=20
> > > > > This all kind of has me wondering.. do we know the purpose of thi=
s
> > > > > warning/error in the first place? It seems like it's more of an
> > > > > "unexpected situation" than a specific problem. E.g., assuming th=
e same
> > > > > page were mmap'd, I _think_ the read fault path would do the same=
 sort
> > > > > of zeroing such that the unshare would see a fully uptodate folio=
 and
> > > > > carry on as normal. I added the mapread op to the opsfile below t=
o give
> > > > > that a quick test (remove the "skip" text to enable it), and it s=
eems to
> > > > > prevent the error, but I've not confirmed whether that theory is
> > > > > actually what's happening.
> > > > >=20
> > > > >=20
> > > > > > FWIW, I also wonder if another way to handle this would be to j=
ust
> > > > > > restrict the range of iomap_file_unshare() to within EOF. IOW i=
f a
> > > > > > caller passes a range beyond EOF, just process whatever part of=
 the
> > > > > > range falls within EOF. It seems iomap isn't responsible for th=
e file
> > > > > > extending aspect of the fallocate unshare command anyways.
> > > >=20
> > > > It already does 'just process whatever part of the range falls with=
in EOF'.
> > > > Check the above case.
> > > >=20
> > > > I'm not sure if I fully understand what you mean. This patch does n=
ot
> > > > prevent unsharing extents within the EOF. This patch checks if pos =
is
> > > > beyond EOF, instead of checking if pos + length is beyond EOF. So t=
he
> > > > extents within EOF should be unshared as usual.
> > > >=20
> > >=20
> > > I'm not concerned about preventing unsharing. I'm concerned that this
> > > patch doesn't always prevent attempts to unshare post-eof ranges. I
> > > think the difference here is that in the variant I was hitting, we en=
d
> > >=20
> > > > up with a mapping that starts within EOF and ends beyond EOF, where=
as
> > > > the syzbot variant produces a scenario where the problematic mappin=
g
> > > > always starts beyond EOF.
> >=20
> > This is not true. In the case above, the syzbot did indeed unshare the
> > extents between 0-4k, which were started within EOF and ended beyond
> > EOF. The specific variants here are: pos:0 len:0x1000 EOF: 0xE00. And
> > the unshare code successfully unshared extents between 0 and 4k.
> >=20
> > During the next loop in iomap_file_unshare(), the pos became 0x1000,
> > which is beyond EOF.=C2=A0 What this patch does is to skip the unshare
> > during the second loop.
> > Is there anything I misunderstand=EF=BC=9F
>=20
> Hmm, what block size? Does the associated mapping have at least one full
> block beyond EOF? If you have a map at offset 0, length 0x1000 and EOF
> at 0xE00, then unless you have 512b blocks it sounds like the EOF block
> actually starts within EOF.

The block size here is 2k, and there isn't a full block beyond EOF within=
=C2=A0
this extent map.
>=20
> The variant I'm seeing is more like this.. consider a -bsize=3D1k fs, a
> file size of 0x3c400, and an EOF mapping of (offset 0x3c000, length
> 0x4000). The EOF folio in this case is 4k in size and starts at the same
> 0x3c000 offset as the EOF mapping.
>=20
> So with 1k blocks, the EOF mapping starts one block before EOF and
> extends well beyond it. What happens in the test case is that
> iomap_unshare_iter() is called with the EOF folio, pos 0x3c000, length
> 0x800, and where the block at offset 0x3c400 is not marked uptodate. pos
> is thus within EOF, but the while loop in __iomap_write_begin() walks
> past it and attempts to process one block beyond EOF.

Ok, so the key point here is that there is a full block beyond EOF within
the associated extent map, which is different with the scenario reproduced=
=20
by syzbot.
According to the Dave's comments, the trimming behavior seems like should=
=C2=A0
be done in filesystem(e.g.,xfs), instead of iomap. I will reconsider this s=
cenario.

Thanks for your comments and review.
>=20
> Brian
>=20
> > >=20
> > > So IOW, this patch works for the syzbot variant because it happens to
> > > reproduce a situation where pos will be beyond EOF, but that is an
> > >=20
> > > > assumption that might not always be true. The fsx generated variant=
 runs
> > > > a sequence that produces a mapping that spans across EOF, which mea=
ns
> > > > that pos is within EOF at the start of unshare, so unshare proceeds=
 to
> > > > walk across the EOF boundary, the corresponding EOF folio is not fu=
lly
> > > > uptodate, and thus write begin wants to do partial zeroing and
> > > > fails/warns.
> >=20
> > Yeah, it's exactly what the syzbot does.
> > >=20
> > > I suspect that if the higher level range were trimmed to be within EO=
F
> > > in iomap_file_unshare(), that would prevent this problem in either ca=
se.
> > > Note that this was on a -bsize=3D1k fs, so what I'm not totally sure =
about
> > > is whether skipping zeroing as such would be a problem with larger FS=
Bs.
> > > My initial thinking was this might not be possible since the EOF foli=
o
> > > should be fully uptodate in that case, but that probably requires som=
e
> > > thought/review/testing.
> > >=20
> > > Brian
> > >=20
> > > > BTW, maybe the check here should be
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pos >=3D i_size_read(iter->inode))
> > > >=20
> > > > If there is any misunderstanding, please let me know, thanks.
> > > >=20
> > > > [1]: https://lore.kernel.org/all/0000000000008964f1061f8c32b6@googl=
e.com/T/
> > > > [2]: https://lore.kernel.org/all/20240903054808.126799-1-sunjunchao=
2870@gmail.com/
> > > >=20
> > > > >=20
> > > > > Thoughts?
> > > > >=20
> > > > > Brian
> > > > >=20
> > > > > [1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1-bfo=
ster@redhat.com/
> > > > > [2] https://lore.kernel.org/fstests/20240906185606.136402-1-bfost=
er@redhat.com/
> > > > > [3] fsx ops file:
> > > > >=20
> > > > > fallocate 0x3bc00 0x400 0
> > > > > write 0x3bc00 0x800 0x3c000
> > > > > clone_range 0x3bc00 0x400 0x0 0x3c400
> > > > > skip mapread 0x3c000 0x400 0x3c400
> > > > > fallocate 0x3bc00 0xc00 0x3c400 unshare
> > > > >=20
> > > >=20
> > > >=20
> > > > Thanks,
> > > > --
> > > > Julian Sun <sunjunchao2870@gmail.com>
> > > >=20
> > >=20
> >=20
> > Thanks,
> > --=20
> > Julian Sun <sunjunchao2870@gmail.com>
> >=20
>=20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

