Return-Path: <linux-fsdevel+bounces-28960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FF97213C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A37283685
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7117217A92E;
	Mon,  9 Sep 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYjX/I+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B0168BD
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903640; cv=none; b=Q8DinhwRNLRUuIepWGUGBR/IDQrQF6LjMr9SE2eN4+gpz48nQR5RN829jxHUrTEKqZiF0vYAgcP6nqC5XrjkdvI+kKOfDUgHqo77l02aUYiSR1T6TFIUApZfvAll9qhmELk2ApbFf9BihR/c1C+ICSMxhqEpc19N06kjcmsoEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903640; c=relaxed/simple;
	bh=jAKlaf4Cqm4jnUbza13xwQLAS9Azuanh1NTRImL2JW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF42A4K7C6CrEJfIorRRTAYjbWpVVW0KbU24X5+ToBv199b5HQE0/epHROEMTW/iovjK+fHXRkBlcmpdUdvJcf5wxmg2+u1IXs35fedwiwPZok/fS6UtgL0oJou1PtmjNn2qySaH2MGlFbn20GkUu/98pj8+y7f6w2zjOeF0tFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYjX/I+E; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso10912238a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725903637; x=1726508437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H794s5nwY0UTiEBczS5Z7RUBWZZGOa/tbghlITz1LNg=;
        b=NYjX/I+E7FD7brbQZccjfC6/LHvoTuhJwYKoEq2D5XIhcXuEHr3MASBJktYuAW+vMs
         KUA24kJKClYgoPIsOX6dh5ioRjtI7RwZH8piQj1PQy7cQvw+t2R6NttXCSSwXHHfkJY1
         TLO0cI1oiXzjQ2Bg3wh9wUE11SOqKz6BsyfdnHxYun5+OBASDS+r6khdIJyOumhzMTYG
         +sowu03iBbhKg5Wpe3LLZjnIfwF+jazIkdRGSSaHl25UMOOsaWdD5IfnVZsA/rf92Jlh
         DGL8/NEyF8L+U76i2lI5uQwv7AuEY7C7T1PbQ2GEDgj4yUXHhDMisvvSNMIuwYGzPOEX
         whuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903637; x=1726508437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H794s5nwY0UTiEBczS5Z7RUBWZZGOa/tbghlITz1LNg=;
        b=rtdUsB66rOzY7eQuxCTq0Nm7TYp41OHHWeDoVaLZD1qZLtyI9L78xxshcsw6h6jc4D
         cuTafmOAdGYwaO/8Mre5kSTa2S40oNoMAqRCa1imtQJgd67Y4rV1o/vDRDPCVoe4/+Ae
         4fhl7pnMdoiqbpQ5uR11OwedVvpNpW5iv8h3LZcNnAtdUlTT6l9txZHOYPslyQE0sLYs
         e4HRoUvodyOdto7PWIMqqa8LeP0s/2VNzPQB8/1KVuDlZpRU5ei4E3Ywct8YaUhysqY+
         Lck4ZFheCLDnMCnzZXk/2C4J3xgHkytwi9zGPaGr8dednqzlGuqCWfzMtKY//+/WJEK1
         3AYA==
X-Gm-Message-State: AOJu0Yw2ELNTHgtmNBC6ZBSYktvgVr5DGN8MXKDVIEfu6nET5sW4/qIs
	7MwBIU0Kn+w0y3oS5lUveVgPJgwZpWTAcUGnNDfhqRsQD5E9mwFGZdcHqItVj/qrosIpDBF4yL3
	/x91pygvHQ3LIIL659OJcsgTKVIc=
X-Google-Smtp-Source: AGHT+IESzslmd4e0fWtxtzSPK7tSENfHSAhAGs2WW5xOUMah3H1bB6rzumaQBrYnn/ifaJoPSaV7u8stbgaSm91250A=
X-Received: by 2002:a05:6402:5209:b0:5be:e9f8:9ba4 with SMTP id
 4fb4d7f45d1cf-5c4015ce12emr507016a12.4.1725903636270; Mon, 09 Sep 2024
 10:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
 <ZttT_sHrS5NQPAM9@bfoster> <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
 <Zt74BI7C-ZPn_WV_@bfoster>
In-Reply-To: <Zt74BI7C-ZPn_WV_@bfoster>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 10 Sep 2024 01:40:24 +0800
Message-ID: <CAHB1Nahz2UmrCpqEivV0Dzkt5P=rjbRaBekxtaXeWNraXfvCCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com, hch@lst.de, 
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=80 21:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Sep 09, 2024 at 08:15:43PM +0800, Julian Sun wrote:
> > Hi Brian,
> >
> > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=85=AD 03:11=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun wrote:
> > > > Attempting to unshare extents beyond EOF will trigger
> > > > the need zeroing case, which in turn triggers a warning.
> > > > Therefore, let's skip the unshare process if extents are
> > > > beyond EOF.
> > > >
> > > > Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appsp=
otmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf306e=
5a0
> > > > Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unsha=
re")
> > > > Inspired-by: Dave Chinner <david@fromorbit.com>
> > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > ---
> > > >  fs/iomap/buffered-io.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index f420c53d86ac..8898d5ec606f 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -1340,6 +1340,9 @@ static loff_t iomap_unshare_iter(struct iomap=
_iter *iter)
> > > >       /* don't bother with holes or unwritten extents */
> > > >       if (srcmap->type =3D=3D IOMAP_HOLE || srcmap->type =3D=3D IOM=
AP_UNWRITTEN)
> > > >               return length;
> > > > +     /* don't try to unshare any extents beyond EOF. */
> > > > +     if (pos > i_size_read(iter->inode))
> > > > +             return length;
> > >
> > > Hi Julian,
> > >
> > >
> > > > What about if pos starts within EOF and the operation extends beyon=
d it?
> >
> > Extents within EOF will be unshared as usual. Details are below.
> > >
> > > > I ask because I think I've reproduced this scenario, though it is a=
 bit
> > > > tricky and has dependencies...
> > > >
> > > > For one, it seems to depend on the cowblocks patch I recently poste=
d
> > > > here [1] (though I don't think this is necessarily a problem with t=
he
> > > > patch, it just depends on keeping COW fork blocks around after the
> > > > unshare). With that, I reproduce via fsx with unshare range support=
 [2]
> > > > using the ops file appended below [3] on a -bsize=3D1k XFS fs.
> > > >
> > > > I haven't quite characterized the full sequence other than it looks=
 like
> > > > the unshare walks across EOF with a shared data fork block and COW =
fork
> > > > delalloc, presumably finds the post-eof part of the folio !uptodate=
 (so
> > > > iomap_adjust_read_range() doesn't skip it), and then trips over the
> > > > warning and error return associated with the folio zeroing in
> > > > __iomap_write_begin().
> >
> > The scenario has already been reproduced by syzbot[1]. The reproducer
> > provided by syzbot constructed the following extent maps for a file of
> > size 0xE00 before fallocate unshare:
> >
> > 0 - 4k: shared between two files
> > 4k - 6k: hole beyond EOF, not shared
> > 6k - 8k: delalloc extends
> >
> > Then the reproducer attempted to unshare the extent between 0 and
> > 0x2000 bytes, but the file size is 0xE00. This is likely the scenario
> > you were referring to?
> >
>
> Yes, sort of..
>
> > Eventually the unshare code does:
> > first map: 0 - 4k - unshare successfully.
> > second map: 4k - 6k - hole, skip. Beyond EOF.
> > third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
> > Fires warnings because UNSHARE.
> >
> > During the first call to iomap_unshare_iter(), iomap_length() returned
> > 4k, so 4k bytes were unshared.
> > See discuss here[2] for more details.
> > >
> > > This all kind of has me wondering.. do we know the purpose of this
> > > warning/error in the first place? It seems like it's more of an
> > > "unexpected situation" than a specific problem. E.g., assuming the sa=
me
> > > page were mmap'd, I _think_ the read fault path would do the same sor=
t
> > > of zeroing such that the unshare would see a fully uptodate folio and
> > > carry on as normal. I added the mapread op to the opsfile below to gi=
ve
> > > that a quick test (remove the "skip" text to enable it), and it seems=
 to
> > > prevent the error, but I've not confirmed whether that theory is
> > > actually what's happening.
> > >
> > >
> > > > FWIW, I also wonder if another way to handle this would be to just
> > > > restrict the range of iomap_file_unshare() to within EOF. IOW if a
> > > > caller passes a range beyond EOF, just process whatever part of the
> > > > range falls within EOF. It seems iomap isn't responsible for the fi=
le
> > > > extending aspect of the fallocate unshare command anyways.
> >
> > It already does 'just process whatever part of the range falls within E=
OF'.
> > Check the above case.
> >
> > I'm not sure if I fully understand what you mean. This patch does not
> > prevent unsharing extents within the EOF. This patch checks if pos is
> > beyond EOF, instead of checking if pos + length is beyond EOF. So the
> > extents within EOF should be unshared as usual.
> >
>
> I'm not concerned about preventing unsharing. I'm concerned that this
> patch doesn't always prevent attempts to unshare post-eof ranges. I
> think the difference here is that in the variant I was hitting, we end
>
> > up with a mapping that starts within EOF and ends beyond EOF, whereas
> > the syzbot variant produces a scenario where the problematic mapping
> > always starts beyond EOF.

This is not true. In the case above, the syzbot did indeed unshare the
extents between 0-4k, which were started within EOF and ended beyond
EOF. The specific variants here are: pos:0 len:0x1000 EOF: 0xE00. And
the unshare code successfully unshared extents between 0 and 4k.

During the next loop in iomap_file_unshare(), the pos became 0x1000,
which is beyond EOF.  What this patch does is to skip the unshare
during the second loop.
Is there anything I misunderstand=EF=BC=9F
>
> So IOW, this patch works for the syzbot variant because it happens to
> reproduce a situation where pos will be beyond EOF, but that is an
>
> > assumption that might not always be true. The fsx generated variant run=
s
> > a sequence that produces a mapping that spans across EOF, which means
> > that pos is within EOF at the start of unshare, so unshare proceeds to
> > walk across the EOF boundary, the corresponding EOF folio is not fully
> > uptodate, and thus write begin wants to do partial zeroing and
> > fails/warns.

Yeah, it's exactly what the syzbot does.
>
> I suspect that if the higher level range were trimmed to be within EOF
> in iomap_file_unshare(), that would prevent this problem in either case.
> Note that this was on a -bsize=3D1k fs, so what I'm not totally sure abou=
t
> is whether skipping zeroing as such would be a problem with larger FSBs.
> My initial thinking was this might not be possible since the EOF folio
> should be fully uptodate in that case, but that probably requires some
> thought/review/testing.
>
> Brian
>
> > BTW, maybe the check here should be
> >                   if (pos >=3D i_size_read(iter->inode))
> >
> > If there is any misunderstanding, please let me know, thanks.
> >
> > [1]: https://lore.kernel.org/all/0000000000008964f1061f8c32b6@google.co=
m/T/
> > [2]: https://lore.kernel.org/all/20240903054808.126799-1-sunjunchao2870=
@gmail.com/
> >
> > >
> > > Thoughts?
> > >
> > > Brian
> > >
> > > [1] https://lore.kernel.org/linux-xfs/20240906114051.120743-1-bfoster=
@redhat.com/
> > > [2] https://lore.kernel.org/fstests/20240906185606.136402-1-bfoster@r=
edhat.com/
> > > [3] fsx ops file:
> > >
> > > fallocate 0x3bc00 0x400 0
> > > write 0x3bc00 0x800 0x3c000
> > > clone_range 0x3bc00 0x400 0x0 0x3c400
> > > skip mapread 0x3c000 0x400 0x3c400
> > > fallocate 0x3bc00 0xc00 0x3c400 unshare
> > >
> >
> >
> > Thanks,
> > --
> > Julian Sun <sunjunchao2870@gmail.com>
> >
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

