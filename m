Return-Path: <linux-fsdevel+bounces-11235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF8A852116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E682817DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB54D5AC;
	Mon, 12 Feb 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eH1R7zfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C04D131
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775865; cv=none; b=GnhYMdUwrZrjsFaIBI//CeH5Tb7+yZ0yA8V/dXLtVjFoKDxxdeY13yu+micd287Je9SRydfsZm7CZ6fuCgRWX2i5zAd/hBHeYRnva0a1Ilbr8HstbDrNQrtHD96IEDmXQu61XbKvJXg6uRVA1/bB56/MnUplAEgFpEfFaOKqeKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775865; c=relaxed/simple;
	bh=9pFi49LPOH4JpcaJE6HqyBblmZ554R3zkdMU3FWm00E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=a2lp3tlL1YD2rRnQD0yViZ/2rIFfdN4jk/8RprD+noCZpqMZBwlffk6OTytN8x/hu9fZBl/LW0YQC1YHnAi6EL3LWWeR5Qnah4K81HXWofLumzdq/iJ5e6PPswdwigwryFAj2YMFJfsVkEGZaO5xdKyuQX9jPSyH7UpKmCVfoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eH1R7zfX; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-561bc69fbe5so701187a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707775862; x=1708380662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkEZInmn90xNLy467bdVGct4TJlQkx9R/tPBb/Eq5sI=;
        b=eH1R7zfXO6r1H9YNlXvJOvZ4vJp8OQNY4cqBQRj7QDPpehQj1GrCgWfKIqwpM0WcS3
         VZFgV1RdsfPQKCzshWda34RJtGcWlxMVtLKXE3moZKXOzROUu3uevFjrT/PmHVb6z8nc
         eHKv76PRqCOpVxIBBPc6hnfDl/wbnSw/jtPfEmELHzB/FwUZJqW1D7oC50udrtTvcPl4
         kCCG7TzWOKEnpAh445MQMKUqiK+fJUAJh/blnxwIxjy6c6N0DOuCkNqZKKKiVNq8wFU2
         dOBRBWnylqD9/ooSLMbqdl4jWoBRTnJIMOHEpKyEyuuC4lsVVEbUtvy9/o29QhM7N06V
         XtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775862; x=1708380662;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkEZInmn90xNLy467bdVGct4TJlQkx9R/tPBb/Eq5sI=;
        b=r1U+yB6pDnA/OZVKhMyqRUp38wo6PBnbwUrdnT9cPBjTry3VEgsMC6lB1HcHkgCeC8
         FZ/9tPmfO8lE6rCagY5f2kE1h1Sul0zVP/06uSK8MV/jaQjvC63ToDaHYpSyrja2Yunf
         S+CXHbGJPbWU49mt+2XRTtVme5EppGQAKB5mcKB/VuTFzgaBJg9v6c2R50yfFu4nf2PZ
         9ofQT5R4sHVRuaZzfarRhe3aH73jmHJAThNdga77iNQ8No6MqtaqgcdUm9doxPy+1T0O
         2cH8feRkm4o3abXTFdXoMkVWjAnlLLvGu1WnZRN2sFkZHvvQhCx1nU3OgPavIiFC9bIO
         kidw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ajnAsAGki3favAMEkMuOJzV6cs++l2kX3C3SAPbtNb/HAN263NpmDYLby1kztqkbJ1vLqZBTIX4FMdWyy39Z2T8Qs7NIwbXvXrCa/A==
X-Gm-Message-State: AOJu0YwMK7cIJdDPHteThiMB/FlNQJT0Q5xRBLvbEue7apDRsD426DYg
	DcAvUeY/6ZcLF2+NBGYa+PAWf3UfOle/YCfKTCEJiWdOMmvXfh90Xc9OnOp4eAt3ALYh6UXLpiL
	+pQ==
X-Google-Smtp-Source: AGHT+IHNPySZ2/hxsa72eBReB+Xyvc0nb7k499jIOccEnpd371R+PDIzmQejp4QnaFUxuoaB6SBu/T07KQo=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:92bd:ea5e:3b78:5dd3])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4488:b0:55f:5f2f:706b with SMTP id
 er8-20020a056402448800b0055f5f2f706bmr29736edb.8.1707775862112; Mon, 12 Feb
 2024 14:11:02 -0800 (PST)
Date: Mon, 12 Feb 2024 23:10:54 +0100
In-Reply-To: <20240212-gelungen-holzfiguren-3a07655ad780@brauner>
Message-Id: <ZcqXbuMp9_gogYHj@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com> <20240209170612.1638517-2-gnoack@google.com>
 <ZcdYrJfhiNEtqIEW@google.com> <036db535-587a-4e1b-bd44-345af3b51ddf@app.fastmail.com>
 <20240212-gelungen-holzfiguren-3a07655ad780@brauner>
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-security-module@vger.kernel.org, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Arnd and Christian, for the detailed insights!
This is very helpful!

On Mon, Feb 12, 2024 at 12:09:47PM +0100, Christian Brauner wrote:
> On Sat, Feb 10, 2024 at 12:49:23PM +0100, Arnd Bergmann wrote:
> > On Sat, Feb 10, 2024, at 12:06, G=C3=BCnther Noack wrote:
> > > On Fri, Feb 09, 2024 at 06:06:05PM +0100, G=C3=BCnther Noack wrote:
> > >
> > > The IOCTL command in question is FIONREAD: fs/ioctl.c implements
> > > FIONREAD directly for S_ISREG files, but it does call the FIONREAD
> > > implementation in the VFS layer for other file types.
> > >
> > > The question we are asking ourselves is:
> > >
> > > * Can we let processes safely use FIONREAD for all files which get
> > >   opened for the purpose of reading, or do we run the risk of
> > >   accidentally exposing surprising IOCTL implementations which have
> > >   completely different purposes?
> > >
> > >   Is it safe to assume that the VFS layer FIONREAD implementations ar=
e
> > >   actually implementing FIONREAD semantics?
>=20
> Yes, otherwise this should considered a bug.

Excellent, thanks :)


> > > * I know there have been accidental collisions of IOCTL command
> > >   numbers in the past -- Hypothetically, if this were to happen in on=
e
> > >   of the VFS implementations of FIONREAD, would that be considered a
> > >   bug that would need to get fixed in that implementation?
> >=20
> > Clearly it's impossible to be sure no driver has a conflict
> > on this particular ioctl, but the risk for one intentionally
> > overriding it should be fairly low.
> >=20
> > There are a couple of possible issues I can think of:
> >=20
> > - the numeric value of FIONREAD is different depending
> >   on the architecture, with at least four different numbers
> >   aliasing to it. This is probably harmless but makes it
> >   harder to look for accidental conflicts.
> >=20
> > - Aside from FIONREAD, it is sometimes called SIOCINQ
> >   (for sockets) or TIOCINQ (for tty). These still go
> >   through the same VFS entry point and as far as I can
> >   tell always have the same semantics (writing 4 bytes
> >   of data with the count of the remaining bytes in the
> >   fd).

Thanks, good pointer!

Grepping for these three names, I found:

* ~10 FIONREAD implementations in various drivers
* ~10 TIOCINQ implementations (all in net/, mostly in net/*/af_*.c files)
* ~20 SIOCINQ implementations (all in net/, related to network protocols?)

The implementations seem mostly related to networking, which gives me
hope that special casing and denying FIONREAD in the common case might
not make a big difference after all.

(The ioctl filtering in this patch set only applies to files opened
through open(2), but not to network sockets and other files acquired
through socket(2), pipe(2), socketpair(2), fanotiy_init(2) and the
like. -- It just gets messy if such files are opened through
/proc/*/fd/*)


> > - There are probably a couple of drivers that do something
> >   in their ioctl handler without actually looking at
> >   the command number.

Thanks you for the pointers!

You are right, it is surprisingly common that ioctl handlers do work
without first looking at the command number.  I spot checked a few
ioctl handler implementations and it is easy to dig up examples.

If this is done, the pattern is often this:

   preparation_work();
  =20
   switch (cmd) {
   case A:   /* impl */
   case B:   /* impl */
   default:  /* set error */
   }
  =20
   cleanup_work();

Common types of preparation work are the acquisition and release of
locks, allocation and release of commonly used buffers, copying memory
to and from userspace, and flushing buffers.

One of the larger examples which I found was video_ioctl2() from
drivers/media/v412-core/v412-ioctl.c, which is used from multiple
video drivers.

It also seems to me that ioctl handlers doing work independent of
command number might be a bigger problem than the hypothetical command
number collision I originally asked about.  -- If we allow FIONREAD to be c=
alled on files too liberally, we are not only exposing=20


> > If you want to be really sure you get this right, you
> > could add a new callback to struct file_operations
> > that handles this for all drivers, something like
> >=20
> > static int ioctl_fionread(struct file *filp, int __user *arg)
> > {
> >      int n;
> >=20
> >      if (S_ISREG(inode->i_mode))
> >          return put_user(i_size_read(inode) - filp->f_pos, arg);
> >=20
> >      if (!file->f_op->fionread)
> >          return -ENOIOCTLCMD;
> >=20
> >      n =3D file->f_op->fionread(filp);
> >=20
> >      if (n < 0)
> >          return n;
> >=20
> >      return put_user(n, arg);
> > }
> >=20
> > With this, you can go through any driver implementing
> > FIONREAD/SIOCINQ/TIOCINQ and move the code from .ioctl
> > into .fionread. This probably results in cleaner code
> > overall, especially in drivers that have no other ioctl
> > commands besides this one.
> >=20
> > Since sockets and ttys tend to have both SIOCINQ/TIOCINQ
> > and SIOCOUTQ/TIOCOUTQ (unlike regular files), it's
> > probably best to do both at the same time, or maybe
> > have a single callback pointer with an in/out flag.
>=20
> I'm not excited about adding a bunch of methods to struct
> file_operations for this stuff.

Agreed.  As far as I understand, if we added a special .fionread
handler to struct file_operations, the pros and cons would be:

 + For files that don't implement FIONREAD, calling ioctl(fd,
   FIONREAD, ...) could not accidentally execute ioctl handler
   preparation and cleanup work.

 - It would use a bit more space in struct file_operations.

 - It might not be obvious to driver implementers that they'd need to
   hook into .fionread.  There is a slight risk that some ioctl
   implementers would still accidentally implement FIONREAD the "old"
   way, and then it would not get called.

 - It would set a weird precedent to have a special handler for a
   single IOCTL command (why is this one command special?); this can't
   be done for all IOCTL commands like that.

If I weigh this against each other, I am not convinced that it
wouldn't cause more complications later on.  But it was a good idea
that I had not considered and it was worth looking into, I think.


In summary, I need to digest this a bit longer ;-)

I think these two were the key insights for me from this discussion:

 * There are fewer implementations of FIONREAD than I was afraid we
   would find.  This gives me some hope that we can maybe special case
   it after all in Landlock, and solve the 99% of realistic scenarios
   with it (and the remaining 1% can still ask for the "all IOCTLs"
   right, if needed).

 * Some IOCTL handlers are messier than I had expected, and it seems
   less realistic that we can convince ourselves that these are safe.
   I particularly did not realize before that ioctl handlers that
   don't even implement FIONREAD might actually still do work when
   called with FIONREAD... who would have thought! o_O

I'll try to explore the direction of special casing FIONREAD for now,
and think about it some more.  Thank you for the insightful input,
I'll loop you in when I have something more concrete.

=E2=80=94G=C3=BCnther

