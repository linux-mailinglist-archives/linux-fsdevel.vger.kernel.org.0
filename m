Return-Path: <linux-fsdevel+bounces-55470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43EB0AACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89205A1FC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF991E3772;
	Fri, 18 Jul 2025 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOiuup7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671519E806
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867933; cv=none; b=D1ZHt4lK/hcRVG9ofdkl0eGofdqOqIGUlANmQnxML2ycIh+oSGFI6hR/wSPIz8uKcOuYN0QGj5CaadhVMa/bsSWFBW3g6lxl/p3iw9ClRLayDv446A2PlffTxgs5i9f/LA7t8MvHIpAM+mTrJLwxvO5udwG6fcryRiITxvcaEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867933; c=relaxed/simple;
	bh=k3aWrMFghdwanSFAJSBqsD+FpoXngkP6ZiEnjXuNe6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2lKS2OBe/9g5u/scWa3NVmVCyfZXejjR8dNU9OQQxYv+IUv64VVkw7CZPrDrSGbNIltNfp1C+9MAPMrnZlDPZQ+U+lJsPjPirgI6zS+gKm12Z+fR30SBiB7FE8DGTFMhUbxin8KMi4vDwEI97QcuROvLCW8HuBUKYBKz5YnPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOiuup7U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-612bc52ac2bso3087252a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867929; x=1753472729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETglIWDiKkxQuv5Ghgd64oOaxgf8+3/w+RMl+dHzmWc=;
        b=cOiuup7UQg3aebCwVxDLnlLwjQ9Er7ArurrvGUVs7axzmETXOq1MctQeOq4/ifQjXM
         til6wI3+tBNrb/LM+zAcfzkIftWTJ9hwGYKmXnDOa6FUmDkWCTN/fzd0TbvyqbFzIUc1
         3quKVKoZuXCh0jjeLBbjfGmQT5Sx8Hwf9omS8eYXGIMHBzGmaXxNxXeCpKzl+cjo+xGR
         7BAGeF1HyZs6VC/U5dBj0obnFCi4qHXoh/Rn88Y1h4ctAvHkUM+idaWqOEuEFbN5o7kQ
         pFJ2FPeV6ULHzph9TS9xQNyJJJ2j5hc2XuH/NPdMRjf0DvmUCFDz67GcLOSsoZFBSMnK
         m7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867929; x=1753472729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETglIWDiKkxQuv5Ghgd64oOaxgf8+3/w+RMl+dHzmWc=;
        b=JU5o0eMXAE4WPgLEsF7NMJEvlP2QyqakyERMPe3GcW93dDBxi+j6s9F684K38dLT7c
         wwkoz2G9c/Hs3Sa+P50Ou2IE+HAfiK3WzKXGQdNy72JcmBnAPzcJ+mThCPs1avjvp3br
         LAZiaj/nkq6BZc18T+bCDoMnJU+xgn01VQZIpbV+dxk+yyvrWCG6LUAEE/RD+UNi7QDq
         jyCy+Gt7xuvSudVmOE2GpyqDttdjOWOdJk2UJ5v97L5bBf6GdqPEvlNFLMYrrrPvaqE+
         jYGay1Zhi2R6OYeydsmA3X7qVqugqlTM77TLBKwxYXe5ZZ1QLXNg5tftcQ71CJvDmEGr
         /StA==
X-Gm-Message-State: AOJu0YyEzBZ0OMUvH6v99y2k91HPGXfqqlfX99JZpMiih6YO1oII+HaZ
	7DbfON7P6LE8CE0B1tou+f9B+Irr/OG6i79w8eIcsOxtpDBqhDoFVSzD3O0ZodVl5urWKs175Io
	3HyEcTwFzcZ8wF7oEIrMRj25Rco2j/T4=
X-Gm-Gg: ASbGncu1hM4wsDyUgqrn4hCOFBN55D32kb1C5/BWVLn8SDvtl5DdR4E7sTzdXy8SkvL
	95IpSuQ8ltFGS7hiVEN9l/9Gp/e6WYsvRJ7hfLM0UrtVvZMa/NsiuAeq5ZnbqASNZXyCJJ+bslx
	43rNu/bQaPrrckD43WA1iN1Acq9nowcdPuJKWfeUfACPHcbceA0yQ4fXkI3CjvWdXMvKfDWzd8+
	CAJYpg=
X-Google-Smtp-Source: AGHT+IESGENlps6XTUZoU1g5bjjYuFnNMXIFv4UuPqBacse7gHXSEPPNdxIgFrSxxtauEIgWAOY7dPWHfOfc7DTOaP4=
X-Received: by 2002:a17:906:7f02:b0:ae8:e6f9:7cf with SMTP id
 a640c23a62f3a-ae9cde23acbmr827346366b.23.1752867929010; Fri, 18 Jul 2025
 12:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449855.711291.17231562727952977187.stgit@frogsfrogsfrogs>
 <175279450066.711291.11325657475144563199.stgit@frogsfrogsfrogs>
 <CAOQ4uxjfTp0My7xv39BA1_nD95XLQd-TqERAMG-C4V3UFYpX8w@mail.gmail.com> <20250718180121.GV2672029@frogsfrogsfrogs>
In-Reply-To: <20250718180121.GV2672029@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 18 Jul 2025 21:45:17 +0200
X-Gm-Features: Ac12FXyzu87OIy1Xd_bwZeQpBGBczXDGUAj2gsE7cMM6Ju_LMp4lGSz6kTClWOg
Message-ID: <CAOQ4uxjBhFeksGKpvpSb0qzaOP=zzwQSRGPjb4JRAytnTDQrXg@mail.gmail.com>
Subject: Re: [PATCH 06/13] fuse: implement buffered IO with iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 8:01=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 05:10:14PM +0200, Amir Goldstein wrote:
> > On Fri, Jul 18, 2025 at 1:32=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > Implement pagecache IO with iomap, complete with hooks into truncate =
and
> > > fallocate so that the fuse server needn't implement disk block zeroin=
g
> > > of post-EOF and unaligned punch/zero regions.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h          |   46 +++
> > >  fs/fuse/fuse_trace.h      |  391 ++++++++++++++++++++++++
> > >  include/uapi/linux/fuse.h |    5
> > >  fs/fuse/dir.c             |   23 +
> > >  fs/fuse/file.c            |   90 +++++-
> > >  fs/fuse/file_iomap.c      |  723 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |   14 +
> > >  7 files changed, 1268 insertions(+), 24 deletions(-)
> > >
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 67e428da4391aa..f33b348d296d5e 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -161,6 +161,13 @@ struct fuse_inode {
> > >
> > >                         /* waitq for direct-io completion */
> > >                         wait_queue_head_t direct_io_waitq;
> > > +
> > > +#ifdef CONFIG_FUSE_IOMAP
> > > +                       /* pending io completions */
> > > +                       spinlock_t ioend_lock;
> > > +                       struct work_struct ioend_work;
> > > +                       struct list_head ioend_list;
> > > +#endif
> > >                 };
> >
> > This union member you are changing is declared for
> > /* read/write io cache (regular file only) */
> > but actually it is also for parallel dio and passthrough mode
> >
> > IIUC, there should be zero intersection between these io modes and
> >  /* iomap cached fileio (regular file only) */
> >
> > Right?
>
> Right.  iomap will get very very confused if you switch file IO paths on
> a live file.  I think it's /possible/ to switch if you flush and
> truncate the whole page cache while holding inode_lock() but I don't
> think anyone has ever tried.
>
> > So it can use its own union member without increasing fuse_inode size.
> >
> > Just need to be carefull in fuse_init_file_inode(), fuse_evict_inode() =
and
> > fuse_file_io_release() which do not assume a specific inode io mode.
>
> Yes, I think it's possible to put the iomap stuff in a separate struct
> within that union so that we're not increasing the fuse_inode size
> unnecessarily.  That's desirable for something to do before merging,
> but for now prototyping is /much/ easier if I don't have to do that.
>

understood. you can deal with that later. I just wanted to leave a TODO not=
e.

> Making that change will require a lot of careful auditing, first I want
> to make sure you all agree with the iomap approach because it's much
> different from what I see in the other fuse IO paths. :)
>

Indeed a good audit will be required, but
*if* you can guarantee to configure iomap alway at inode initiation
then in fuse_init_file_inode() it is clear, which member of the union
is being initialized and this mode has to stick with the inode until
evict anyway.

So basically, all you need to do is never allow configuring iomap on an
already initialized inode.

> Eeeyiks, struct fuse_inode shrinks from 1272 bytes to 1152 if I push the
> iomap stuff into its own union struct.
>
> > Was it your intention to allow filesystems to configure some inodes to =
be
> > in file_iomap mode and other inodes to be in regular cached/direct/pass=
through
> > io modes?
>
> That was a deliberate design decision on my part -- maybe a fuse server
> would be capable of serving up some files from a local disk, and others
> from (say) a network filesystem.  Or maybe it would like to expose an
> administrative fd for the filesystem (like the xfs_healer event stream)
> that isn't backed by storage.
>

Understood.

But the filesystem should be able to make the decision on inode
initiation time (lookup)
and once made, this decision sticks throughout the inode lifetime. Right?

> > I can't say that I see a big benefit in allowing such setups.
> > It certainly adds a lot of complication to the test matrix if we allow =
that.
> > My instinct is for initial version, either allow only opening files in
> > FILE_IOMAP or
> > DIRECT_IOMAP to inodes for a filesystem that supports those modes.
>
> I was thinking about combining FUSE_ATTR_IOMAP_(DIRECTIO|FILEIO) for the
> next RFC because I can't imagine any scenario where you don't want
> directio support if you already use iomap for the pagecache.  fuse iomap
> requires directio write support for writeback, so the server *must*
> support IOMAP_WRITE|IOMAP_DIRECT.
>
> > Perhaps later we can allow (and maybe fallback to) FOPEN_DIRECT_IO
> > (without parallel dio) if a server does not configure IOMAP to some ino=
de
> > to allow a server to provide the data for a specific inode directly.
>
> Hrmm.  Is FOPEN_DIRECT_IO the magic flag that fuse passes to the fuse
> server to tell it that a file is open in directio mode?  There's a few
> fstests that initiate aio+dio writes to a dm-error device that currently
> fail in non-iomap mode because fuse2fs writes everything to the bdev
> pagecache.
>

Not exactly, but nevermind, you can use a much simpler logic for what
you described:
iomap has to be configured on inode instantiation and never changed afterwa=
rds.
Other inodes are not going to be affected by iomap at all from that point o=
n.

> > fuse_file_io_open/release() can help you manage those restrictions and
> > set ff->iomode =3D IOM_FILE_IOMAP when a file is opened for file iomap.
> > I did not look closely enough to see if file_iomap code ends up setting
> > ff->iomode =3D IOM_CACHED/UNCACHED or always remains IOM_NONE.
>
> I don't touch ff->iomode because iomap is a per-inode property, not a
> per-file property... but I suppose that would be a good place to look.
>

Right, with cached/direct/passthrough the inode may change the iomode
after all files are closed, but we *do* keep the mode in the inode,
so we know that files cannot be opened in conflicting modes on the same ino=
de.

The purpose of ff->iomode is to know if the file contributes to cached mode
positive iocachectr or to a negative passthrough mode refcount.

So setting ff->iomode =3D IOM_IOMAP just helps for annotating how the
file was opened, in case we are tracing it. There is no functional need to
define and set this mode on the file when the mode of the inode is const.

Thanks,
Amir.

