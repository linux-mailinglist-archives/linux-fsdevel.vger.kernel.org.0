Return-Path: <linux-fsdevel+bounces-29075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA46974901
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 06:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAB2B24352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C2C3FB30;
	Wed, 11 Sep 2024 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfuxPnWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669A2A1B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027303; cv=none; b=saG6OBA94DZRXuf44sbW5V9mLqAKIe5JUCjnUlJ0IeHW+6zA7/ffvRurX9A5U073luljjJqZAVV4e5vAjpyxS98UiSaGa3YhDMh25DKcSLd/87neld8EqONkBxFeYwf64lXtJWHcUctRdy+Oze+w2Ad6fQAED97Qp70mM1AkIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027303; c=relaxed/simple;
	bh=VoRq06QNazvVLdoChwwE1pE68Wv3dBOlX/O48670LJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRx+z44qCGICr2Lm8caHm2KvJXIDiSDPcqIDzoMpNfv72Rszr71Q6RdaislaCGiiSvqPGoPnZYUIS4TWerWo07soDSQRI9NW6CDrqhzjwz4R++MZGzRDiUqHOrhc0sKUYksNOukX/wN05P5L58ew7Bclpl+RsF1M3Dqlcemm10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfuxPnWg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so16447005ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726027301; x=1726632101; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VoRq06QNazvVLdoChwwE1pE68Wv3dBOlX/O48670LJ4=;
        b=UfuxPnWgsQSXk2e5U+gUGWyZu/8leC+PkNGdM1E6vhrpvM4kNPbW9PadAWZp5I05rw
         LIHkjk51pvYRiMAFMW1nVhpb9weR27H3C5yD4tdchgVqVlNMpLEGEmymmuGKndlR5MQz
         BlQgU6GacZTyXuzWsgsSYF6sdNzOJmhiKbPI9DSu9epXKF0XDfs2Py+4acebjPuB5p/D
         Rag65XqKfYW1dngXcRzSud3H3kpZW2OV8s4hEKfeUzcHim/qvK344shXug+HalqG3Lyp
         ogKi/NOibFZE3Li7rGO/6F3kqUoy53WwcyEBPWin1qVzdf2EeTkadEsk/hfNR787ve8R
         rUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726027301; x=1726632101;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VoRq06QNazvVLdoChwwE1pE68Wv3dBOlX/O48670LJ4=;
        b=J4gAnLssg0ImzjkXJ0umi+uTnE+7ew+RNw5ugHhyewlQnuuKZlwc+2wIye98aAVC4P
         kUeCF4n2kzatKRKbbu9IJhhhqnP/E7X2C1qdODoAeHOqfuukzLRGqtsx4/0vLmoc/vRy
         cfzr9XN5voFbb8zK9sw2q8rOL3XqeRk6LUdhN3sjXdihMg31imqG/0lbtMoyKtgiOfZX
         A4OWi20V5+sxCsen2IcA6Qak2JhNKY0wJhA5t1laHZjZ9SX8qALnTU6VtRBr13TxVeAV
         qLAd+sHKNON6jnCvqdLimr+KcoxgqxzMPOKV1cWPvgO9gUqFr2Sj7ccSSOvDujBqN5JI
         Jt3g==
X-Gm-Message-State: AOJu0Yygv0bO8GgVr/Mg7euLYHoacOCRYADXubpeXGbzs/pd/XTEfX9P
	6h97tDBsAfoP9wQKG6NQkvnRIcy7EMK11aYkuE5K5SxbzOD/Kown
X-Google-Smtp-Source: AGHT+IH5urfty8sNL5l+vfk13T3z6f9FOlLCQBOTXy55acBv1qNX/8kroJrLG0eZ3/eKIcmIFXZMpQ==
X-Received: by 2002:a17:903:22ce:b0:206:8d6e:cff9 with SMTP id d9443c01a7336-2075219d268mr30105655ad.4.1726027300655;
        Tue, 10 Sep 2024 21:01:40 -0700 (PDT)
Received: from [10.172.23.18] ([103.172.183.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e324a3sm55043435ad.69.2024.09.10.21.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:01:40 -0700 (PDT)
Message-ID: <f77404c7edf749b9981dd13ad45350faa60ce039.camel@gmail.com>
Subject: Re: [PATCH 1/2] iomap: Do not unshare exents beyond EOF
From: Julian Sun <sunjunchao2870@gmail.com>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org, 
 viro@zeniv.linux.org.uk, djwong@kernel.org, david@fromorbit.com,
 hch@lst.de,  syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Date: Wed, 11 Sep 2024 12:01:34 +0800
In-Reply-To: <ZuBQFMkIa5XNXrU0@bfoster>
References: <20240905102425.1106040-1-sunjunchao2870@gmail.com>
	 <ZttT_sHrS5NQPAM9@bfoster>
	 <CAHB1Nag5+AEqhd=nDKPg7S4y89CRAZp0mRU4_UHuQ=WnR58WpQ@mail.gmail.com>
	 <Zt74BI7C-ZPn_WV_@bfoster>
	 <CAHB1Nahz2UmrCpqEivV0Dzkt5P=rjbRaBekxtaXeWNraXfvCCA@mail.gmail.com>
	 <Zt9MrgnBStwlGWpY@bfoster>
	 <767963be0ce83221792d58667afd8b4ccc4f160d.camel@gmail.com>
	 <ZuA70EmA47amHnwH@bfoster>
	 <CAHB1Naj2XsnmeXJorOon1d1sOJnKKX4qeu_XZ+Z+8rd2vzcZow@mail.gmail.com>
	 <ZuBQFMkIa5XNXrU0@bfoster>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 09:56 -0400, Brian Foster wrote:
> On Tue, Sep 10, 2024 at 09:25:41PM +0800, Julian Sun wrote:
> > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C 20:29=E5=86=99=E9=81=93=EF=BC=9A
> > >=20
> > > On Tue, Sep 10, 2024 at 03:03:18PM +0800, Julian Sun wrote:
> > > > On Mon, 2024-09-09 at 15:29 -0400, Brian Foster wrote:
> > > > > On Tue, Sep 10, 2024 at 01:40:24AM +0800, Julian Sun wrote:
> > > > > > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=
=889=E6=97=A5=E5=91=A8=E4=B8=80 21:27=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > >=20
> > > > > > > On Mon, Sep 09, 2024 at 08:15:43PM +0800, Julian Sun wrote:
> > > > > > > > Hi Brian,
> > > > > > > >=20
> > > > > > > > Brian Foster <bfoster@redhat.com> =E4=BA=8E2024=E5=B9=B49=
=E6=9C=887=E6=97=A5=E5=91=A8=E5=85=AD 03:11=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > > >=20
> > > > > > > > > On Thu, Sep 05, 2024 at 06:24:24PM +0800, Julian Sun
> > > > > > > > > wrote:
> > > > > > > > > > Attempting to unshare extents beyond EOF will trigger
> > > > > > > > > > the need zeroing case, which in turn triggers a
> > > > > > > > > > warning.
> > > > > > > > > > Therefore, let's skip the unshare process if extents
> > > > > > > > > > are
> > > > > > > > > > beyond EOF.
> > > > > > > > > >=20
> > > > > > > > > > Reported-and-tested-by:
> > > > > > > > > > syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> > > > > > > > > > Closes:
> > > > > > > > > > https://syzkaller.appspot.com/bug?extid=3D296b1c84b9cbf=
30
> > > > > > > > > > 6e5a0
> > > > > > > > > > Fixes: 32a38a499104 ("iomap: use write_begin to read
> > > > > > > > > > pages to unshare")
> > > > > > > > > > Inspired-by: Dave Chinner <david@fromorbit.com>
> > > > > > > > > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > > =C2=A0fs/iomap/buffered-io.c | 3 +++
> > > > > > > > > > =C2=A01 file changed, 3 insertions(+)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/fs/iomap/buffered-io.c
> > > > > > > > > > b/fs/iomap/buffered-io.c
> > > > > > > > > > index f420c53d86ac..8898d5ec606f 100644
> > > > > > > > > > --- a/fs/iomap/buffered-io.c
> > > > > > > > > > +++ b/fs/iomap/buffered-io.c
> > > > > > > > > > @@ -1340,6 +1340,9 @@ static loff_t
> > > > > > > > > > iomap_unshare_iter(struct iomap_iter *iter)
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* don't bother with hol=
es or unwritten extents
> > > > > > > > > > */
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (srcmap->type =3D=3D =
IOMAP_HOLE || srcmap->type =3D=3D
> > > > > > > > > > IOMAP_UNWRITTEN)
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return length;
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 /* don't try to unshare any e=
xtents beyond EOF.
> > > > > > > > > > */
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (pos > i_size_read(iter->i=
node))
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return length;
> > > > > > > > >=20
> > > > > > > > > Hi Julian,
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > What about if pos starts within EOF and the operation
> > > > > > > > > > extends beyond it?
> > > > > > > >=20
> > > > > > > > Extents within EOF will be unshared as usual. Details are
> > > > > > > > below.
> > > > > > > > >=20
> > > > > > > > > > I ask because I think I've reproduced this scenario,
> > > > > > > > > > though it is a bit
> > > > > > > > > > tricky and has dependencies...
> > > > > > > > > >=20
> > > > > > > > > > For one, it seems to depend on the cowblocks patch I
> > > > > > > > > > recently posted
> > > > > > > > > > here [1] (though I don't think this is necessarily a
> > > > > > > > > > problem with the
> > > > > > > > > > patch, it just depends on keeping COW fork blocks
> > > > > > > > > > around after the
> > > > > > > > > > unshare). With that, I reproduce via fsx with unshare
> > > > > > > > > > range support [2]
> > > > > > > > > > using the ops file appended below [3] on a -bsize=3D1k
> > > > > > > > > > XFS fs.
> > > > > > > > > >=20
> > > > > > > > > > I haven't quite characterized the full sequence other
> > > > > > > > > > than it looks like
> > > > > > > > > > the unshare walks across EOF with a shared data fork
> > > > > > > > > > block and COW fork
> > > > > > > > > > delalloc, presumably finds the post-eof part of the
> > > > > > > > > > folio !uptodate (so
> > > > > > > > > > iomap_adjust_read_range() doesn't skip it), and then
> > > > > > > > > > trips over the
> > > > > > > > > > warning and error return associated with the folio
> > > > > > > > > > zeroing in
> > > > > > > > > > __iomap_write_begin().
> > > > > > > >=20
> > > > > > > > The scenario has already been reproduced by syzbot[1]. The
> > > > > > > > reproducer
> > > > > > > > provided by syzbot constructed the following extent maps
> > > > > > > > for a file of
> > > > > > > > size 0xE00 before fallocate unshare:
> > > > > > > >=20
> > > > > > > > 0 - 4k: shared between two files
> > > > > > > > 4k - 6k: hole beyond EOF, not shared
> > > > > > > > 6k - 8k: delalloc extends
> > > > > > > >=20
> > > > > > > > Then the reproducer attempted to unshare the extent between
> > > > > > > > 0 and
> > > > > > > > 0x2000 bytes, but the file size is 0xE00. This is likely
> > > > > > > > the scenario
> > > > > > > > you were referring to?
> > > > > > > >=20
> > > > > > >=20
> > > > > > > Yes, sort of..
> > > > > > >=20
> > > > > > > > Eventually the unshare code does:
> > > > > > > > first map: 0 - 4k - unshare successfully.
> > > > > > > > second map: 4k - 6k - hole, skip. Beyond EOF.
> > > > > > > > third map: 6k - 8k - delalloc, beyond EOF so needs zeroing.
> > > > > > > > Fires warnings because UNSHARE.
> > > > > > > >=20
> > > > > > > > During the first call to iomap_unshare_iter(),
> > > > > > > > iomap_length() returned
> > > > > > > > 4k, so 4k bytes were unshared.
> > > > > > > > See discuss here[2] for more details.
> > > > > > > > >=20
> > > > > > > > > This all kind of has me wondering.. do we know the
> > > > > > > > > purpose of this
> > > > > > > > > warning/error in the first place? It seems like it's more
> > > > > > > > > of an
> > > > > > > > > "unexpected situation" than a specific problem. E.g.,
> > > > > > > > > assuming the same
> > > > > > > > > page were mmap'd, I _think_ the read fault path would do
> > > > > > > > > the same sort
> > > > > > > > > of zeroing such that the unshare would see a fully
> > > > > > > > > uptodate folio and
> > > > > > > > > carry on as normal. I added the mapread op to the opsfile
> > > > > > > > > below to give
> > > > > > > > > that a quick test (remove the "skip" text to enable it),
> > > > > > > > > and it seems to
> > > > > > > > > prevent the error, but I've not confirmed whether that
> > > > > > > > > theory is
> > > > > > > > > actually what's happening.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > FWIW, I also wonder if another way to handle this would
> > > > > > > > > > be to just
> > > > > > > > > > restrict the range of iomap_file_unshare() to within
> > > > > > > > > > EOF. IOW if a
> > > > > > > > > > caller passes a range beyond EOF, just process whatever
> > > > > > > > > > part of the
> > > > > > > > > > range falls within EOF. It seems iomap isn't
> > > > > > > > > > responsible for the file
> > > > > > > > > > extending aspect of the fallocate unshare command
> > > > > > > > > > anyways.
> > > > > > > >=20
> > > > > > > > It already does 'just process whatever part of the range
> > > > > > > > falls within EOF'.
> > > > > > > > Check the above case.
> > > > > > > >=20
> > > > > > > > I'm not sure if I fully understand what you mean. This
> > > > > > > > patch does not
> > > > > > > > prevent unsharing extents within the EOF. This patch checks
> > > > > > > > if pos is
> > > > > > > > beyond EOF, instead of checking if pos + length is beyond
> > > > > > > > EOF. So the
> > > > > > > > extents within EOF should be unshared as usual.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > I'm not concerned about preventing unsharing. I'm concerned
> > > > > > > that this
> > > > > > > patch doesn't always prevent attempts to unshare post-eof
> > > > > > > ranges. I
> > > > > > > think the difference here is that in the variant I was
> > > > > > > hitting, we end
> > > > > > >=20
> > > > > > > > up with a mapping that starts within EOF and ends beyond
> > > > > > > > EOF, whereas
> > > > > > > > the syzbot variant produces a scenario where the
> > > > > > > > problematic mapping
> > > > > > > > always starts beyond EOF.
> > > > > >=20
> > > > > > This is not true. In the case above, the syzbot did indeed
> > > > > > unshare the
> > > > > > extents between 0-4k, which were started within EOF and ended
> > > > > > beyond
> > > > > > EOF. The specific variants here are: pos:0 len:0x1000 EOF:
> > > > > > 0xE00. And
> > > > > > the unshare code successfully unshared extents between 0 and
> > > > > > 4k.
> > > > > >=20
> > > > > > During the next loop in iomap_file_unshare(), the pos became
> > > > > > 0x1000,
> > > > > > which is beyond EOF.=C2=A0 What this patch does is to skip the
> > > > > > unshare
> > > > > > during the second loop.
> > > > > > Is there anything I misunderstand=EF=BC=9F
> > > > >=20
> > > > > Hmm, what block size? Does the associated mapping have at least
> > > > > one full
> > > > > block beyond EOF? If you have a map at offset 0, length 0x1000
> > > > > and EOF
> > > > > at 0xE00, then unless you have 512b blocks it sounds like the EOF
> > > > > block
> > > > > actually starts within EOF.
> > > >=20
> > > > The block size here is 2k, and there isn't a full block beyond EOF
> > > > within
> > > > this extent map.
> > >=20
> > > Ok. That likely explains the difference in behavior. The fsx variant
> > > has
> > > a mapping that starts within EOF and has at least one post-EOF block
> > > that unshare attempts to process.
> > >=20
> > > > >=20
> > > > > The variant I'm seeing is more like this.. consider a -bsize=3D1k
> > > > > fs, a
> > > > > file size of 0x3c400, and an EOF mapping of (offset 0x3c000,
> > > > > length
> > > > > 0x4000). The EOF folio in this case is 4k in size and starts at
> > > > > the same
> > > > > 0x3c000 offset as the EOF mapping.
> > > > >=20
> > > > > So with 1k blocks, the EOF mapping starts one block before EOF
> > > > > and
> > > > > extends well beyond it. What happens in the test case is that
> > > > > iomap_unshare_iter() is called with the EOF folio, pos 0x3c000,
> > > > > length
> > > > > 0x800, and where the block at offset 0x3c400 is not marked
> > > > > uptodate. pos
> > > > > is thus within EOF, but the while loop in __iomap_write_begin()
> > > > > walks
> > > > > past it and attempts to process one block beyond EOF.
> > > >=20
> > > > Ok, so the key point here is that there is a full block beyond EOF
> > > > within
> > > > the associated extent map, which is different with the scenario
> > > > reproduced
> > > > by syzbot.
> > > > According to the Dave's comments, the trimming behavior seems like
> > > > should
> > > > be done in filesystem(e.g.,xfs), instead of iomap. I will
> > > > reconsider this scenario.
> > > >=20
> > >=20
> > > Seems reasonable, but I don't agree that is a suitable fix for iomap.
> > > To
> > > be clear, it's perfectly fine for the fs to trim the range however it
> > > sees fit (i.e. no shared blocks beyond EOF in XFS), but we should
> > > also
> > > recognize that iomap is a generic layer and unshare is currently
> > > implemented to trip over itself, warn and fail if passed a post-eof
> > > range.
> > >=20
> > >=20
> > > > I still suspect that just making unshare work correctly around
> > > > i_size
> > > > might be the more elegant long term solution, but that is not
> > > > totally
> > > > clear. IMO, as long as unshare is written to intentionally trip
> > > > over
> > > > itself for post-eof ranges, it should either trim the range or
> > > > check for
> > > > valid parameters and document the limitation. Otherwise we just
> > > > leave a
> > > > landmine for the next caller to have to work through the same
> > > > problems,
> > > > which is particularly subtle since the higher level fallocate
> > > > unshare
> > > > mode supports post-eof ranges. Just my .02.
> >=20
> > Yeah, totally agreed. I prefer to do the trimming in the vfs layer
> > just like what generic_copy_file_checks() does, instead of a specific
> > file system. Maybe we need a helper function
> > generic_fallocate_checks(). But it requires more thought and testing.
> >=20
>=20
> I would agree with that if not for the subtle difference between
> fallocate unshare and the iomap implementation. fallocate unshare is
> basically just a behavior modifier for how shared blocks are handled by
> mode=3D0 preallocation, so AIUI it fully supports post-eof ranges. It can
> extend the file size or leave it unchanged (based on whether KEEP_SIZE
> is set) and preallocate beyond EOF.
>=20
> IOW, it might be perfectly valid for a caller to run an fallocate
> unshare across EOF that happens to unshare various shared blocks within
> EOF, and then preallocate and extend the file size as part of the same
> command. The functional responsibility just happens to be split between
> iomap and the fs.

Yeah, precisely. It seems that fallocate unshare do support post-eof
ranges, but iomap_unshare_iter() doesn't expect any blocks beyond eof.
Maybe the semantics here is that any blocks beyond eof shouldn't be shared,
but I can not confirm that. Also, it's possible that blocks beyond eof
which may belong to an extent acrossing eof may be passed to
iomap_unshare_iter() in some cases. It seems we should figure out the
purpose of this warning.=20

Hi, Christoph. Do you remember why the warning was introduced? Looking
forward to your reply after you return from vacation.


>=20
> Brian
>=20
> > >=20
> > > Brian
> > >=20
> > > > Thanks for your comments and review.
> > > > >=20
> > > > > Brian
> > > > >=20
> > > > > > >=20
> > > > > > > So IOW, this patch works for the syzbot variant because it
> > > > > > > happens to
> > > > > > > reproduce a situation where pos will be beyond EOF, but that
> > > > > > > is an
> > > > > > >=20
> > > > > > > > assumption that might not always be true. The fsx generated
> > > > > > > > variant runs
> > > > > > > > a sequence that produces a mapping that spans across EOF,
> > > > > > > > which means
> > > > > > > > that pos is within EOF at the start of unshare, so unshare
> > > > > > > > proceeds to
> > > > > > > > walk across the EOF boundary, the corresponding EOF folio
> > > > > > > > is not fully
> > > > > > > > uptodate, and thus write begin wants to do partial zeroing
> > > > > > > > and
> > > > > > > > fails/warns.
> > > > > >=20
> > > > > > Yeah, it's exactly what the syzbot does.
> > > > > > >=20
> > > > > > > I suspect that if the higher level range were trimmed to be
> > > > > > > within EOF
> > > > > > > in iomap_file_unshare(), that would prevent this problem in
> > > > > > > either case.
> > > > > > > Note that this was on a -bsize=3D1k fs, so what I'm not total=
ly
> > > > > > > sure about
> > > > > > > is whether skipping zeroing as such would be a problem with
> > > > > > > larger FSBs.
> > > > > > > My initial thinking was this might not be possible since the
> > > > > > > EOF folio
> > > > > > > should be fully uptodate in that case, but that probably
> > > > > > > requires some
> > > > > > > thought/review/testing.
> > > > > > >=20
> > > > > > > Brian
> > > > > > >=20
> > > > > > > > BTW, maybe the check here should be
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pos >=3D i_size_read(iter=
->inode))
> > > > > > > >=20
> > > > > > > > If there is any misunderstanding, please let me know,
> > > > > > > > thanks.
> > > > > > > >=20
> > > > > > > > [1]:
> > > > > > > > https://lore.kernel.org/all/0000000000008964f1061f8c32b6@go
> > > > > > > > ogle.com/T/
> > > > > > > > [2]: https://lore.kernel.org/all/20240903054808.126799-1-
> > > > > > > > sunjunchao2870@gmail.com/
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Thoughts?
> > > > > > > > >=20
> > > > > > > > > Brian
> > > > > > > > >=20
> > > > > > > > > [1] https://lore.kernel.org/linux-
> > > > > > > > > xfs/20240906114051.120743-1-bfoster@redhat.com/
> > > > > > > > > [2]
> > > > > > > > > https://lore.kernel.org/fstests/20240906185606.136402-1-
> > > > > > > > > bfoster@redhat.com/
> > > > > > > > > [3] fsx ops file:
> > > > > > > > >=20
> > > > > > > > > fallocate 0x3bc00 0x400 0
> > > > > > > > > write 0x3bc00 0x800 0x3c000
> > > > > > > > > clone_range 0x3bc00 0x400 0x0 0x3c400
> > > > > > > > > skip mapread 0x3c000 0x400 0x3c400
> > > > > > > > > fallocate 0x3bc00 0xc00 0x3c400 unshare
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Thanks,
> > > > > > > > --
> > > > > > > > Julian Sun <sunjunchao2870@gmail.com>
> > > > > > > >=20
> > > > > > >=20
> > > > > >=20
> > > > > > Thanks,
> > > > > > --
> > > > > > Julian Sun <sunjunchao2870@gmail.com>
> > > > > >=20
> > > > >=20
> > > >=20
> > > > Thanks,
> > > > --
> > > > Julian Sun <sunjunchao2870@gmail.com>
> > > >=20
> > >=20
> >=20
> >=20
> > --=20
> > Julian Sun <sunjunchao2870@gmail.com>
> >=20
>=20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

