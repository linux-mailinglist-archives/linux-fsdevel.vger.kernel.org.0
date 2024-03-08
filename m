Return-Path: <linux-fsdevel+bounces-14031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC362876D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 23:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E8B1F2259B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63045FF16;
	Fri,  8 Mar 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UCsX8nN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4798D9445
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709936735; cv=none; b=XPhBErkRA5JBtNIq83J28zUCrvqHssakGhU0305K/v+7Tm7laxpB1UFcX73Xh6Aw8rY27hd0O8I5j4kYSwfsf+N1KxtzXdt6l/HO/kL218FaVxzAGiBhJED0SFET0upQXyLS3Fgl7bvdHpTV3CstlrqaXDKthwzbyDHhXv8Vr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709936735; c=relaxed/simple;
	bh=ClYzY2c7O6M4UuuA/IjpDza63NwIj3PQw2ENCW64gWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xm5DwLXnI+ECaxBWbyMDUm6o9iYkRZi+iNJh0Zqz77UZfzbezh1BrqONaMnVILhmopUaYLGCPg03gGMPj7HLdzWfQiqwVpNvhSFRB2p3vVPmY/IUHxYQeCEafFbJm20x9oNYuYpwGP51f6Mzfb+pbgo5Wwtm7ElevcA+s33m0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UCsX8nN2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d24737d7so2677268276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 14:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1709936732; x=1710541532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXDYSogmsoq5g6Cv2akA/KLSumsnEiQAY1I83GH43XI=;
        b=UCsX8nN2cqZ7Itjep/J1/u84K9qnNdDPWoUC56LlX09kfHwQ0TvFVI2Sk4HjDP7i5j
         eDoQr+EhgA/WE5PnjERGyzIZckaYx3zfXDwU7wujhh+C60ELldxW5+U1hxH5HR+d2xY/
         8D5rKnA1mcmxXeqjcJb7g9n/Jx/nLC5sE2CnKPZ5h0YTVkRc5tOYB0GOoiZ1THAZS1NH
         Eq6sF+zCm4QFynxMGFdn7M+iT1KXrCIeIHeagyPRt3iKyNyYiS2SkpRcPtTNcLLt0gt0
         0zB9IsvRM2O74zlLvEjLb4Qub8lEF00X1QuJ8gV+v4kqP1bYDoylSfGc/dRkoXoKF3gS
         WaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709936732; x=1710541532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXDYSogmsoq5g6Cv2akA/KLSumsnEiQAY1I83GH43XI=;
        b=B7Hhjp+ZdzImEra+2ymsJTHPchSq+XfcKtKCkurwvJDsG75+0hdFRIHWCONQECoK/T
         5nQY2WJs2n2xdK1opCFe6+vxzzPFCYKzTSa/e3zCQc/Sk91UjAdYAU62/xNx3mYhHZIM
         JkMhdKSlN17IkUP8VpPVjte4LUfQvlMvw27HcFiNnvDjg0ftERkiPUE32Ut7zJU2z94c
         1WBbkAlhL33bxh5sngLkYO19hTW3/kssEIVi/GvdbV3GB1ulJcSQbdd1mwh0XaSU5tqP
         A4zJ0SaU5IrVZRwH8lHoRlsqeF3HZj6DZn6aTTwskT9ezsoFjdlRQAh1MqpDFgYp5T3X
         0PgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDrYfX035+nIi7JQb88sU4LZEwZPllG00zyBQms8tGR7u6mH2yhF7bblhkoxGlfiyDJ7WxiTc6N5GXx2eAyFRerOoPRADvJP/4vqQ4AA==
X-Gm-Message-State: AOJu0YzdWMdmLOWjThbEJ8Yx3agVzHRpxkjqjqjap0nuKvPXgWQFQWLK
	qJbuBAmyJtNuKQOLuEzvqn3BJlIhd8pmREiRkdz/u7OJef5w0VUkbsffDdy0Z3gHSfHxasyvbzd
	E73gykvdbb76iSIq8Lu9H64d5rU0S3L8zl6Q/
X-Google-Smtp-Source: AGHT+IGeX9v3HNY30ujRGwElgZMAClCvOi1NLZIrAFlEW0MFTfAOqyikN08EZTflRTf3oyXtPr/s1GFblDak9vtZeI0=
X-Received: by 2002:a25:a483:0:b0:dcc:273e:1613 with SMTP id
 g3-20020a25a483000000b00dcc273e1613mr316675ybi.40.1709936732132; Fri, 08 Mar
 2024 14:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306.zoochahX8xai@digikod.net> <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner> <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com> <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area> <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net> <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
 <20240308.eeZ1uungeeSa@digikod.net>
In-Reply-To: <20240308.eeZ1uungeeSa@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Mar 2024 17:25:21 -0500
Message-ID: <CAHC9VhRnUbu2jRwUhLGboAgus_oFEPyddu=mv-OMLg93HHk17w@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:12=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
> > On Fri, Mar 8, 2024 at 4:29=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Fri, Mar 08, 2024 at 08:02:13AM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 8, 2024, at 00:09, Dave Chinner wrote:
> > > > > On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> > > > >> On Thu, Mar 7, 2024 at 7:57=E2=80=AFAM G=C3=BCnther Noack <gnoac=
k@google.com> wrote:
> > > > >> I need some more convincing as to why we need to introduce these=
 new
> > > > >> hooks, or even the vfs_masked_device_ioctl() classifier as origi=
nally
> > > > >> proposed at the top of this thread.  I believe I understand why
> > > > >> Landlock wants this, but I worry that we all might have differen=
t
> > > > >> definitions of a "safe" ioctl list, and encoding a definition in=
to the
> > > > >> LSM hooks seems like a bad idea to me.
> > > > >
> > > > > I have no idea what a "safe" ioctl means here. Subsystems already
> > > > > restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, s=
o
> > > > > "safe" clearly means something different here.
> > > >
> > > > That was my problem with the first version as well, but I think
> > > > drawing the line between "implemented in fs/ioctl.c" and
> > > > "implemented in a random device driver fops->unlock_ioctl()"
> > > > seems like a more helpful definition.
> > > >
> > > > This won't just protect from calling into drivers that are lacking
> > > > a CAP_SYS_ADMIN check, but also from those that end up being
> > > > harmful regardless of the ioctl command code passed into them
> > > > because of stupid driver bugs.
> > >
> > > Indeed.
> > >
> > > "safe" is definitely not the right word, it is too broad, relative to
> > > use cases and threat models.  There is no "safe" IOCTL.
> > >
> > > Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
> > > sandbox".
> >
> > Which is a problem from a LSM perspective as we want to avoid hooks
> > which are tightly bound to a single LSM or security model.  It's okay
> > if a new hook only has a single LSM implementation, but the hook's
> > definition should be such that it is reasonably generalized to support
> > multiple LSM/models.
>
> As any new hook, there is a first user.  Obviously this new hook would
> not be restricted to Landlock, it is a generic approach.  I'm pretty
> sure a few hooks are only used by one LSM though. ;)

Sure, as I said above, it's okay for there to only be a single LSM
implementation, but the basic idea behind the hook needs to have some
hope of being generic.  Your "let's redefine a safe ioctl as 'IOCTL
always allowed in a Landlock sandbox'" doesn't fill me with confidence
about the hook being generic; who knows, maybe it will be, but in the
absence of a patch, I'm left with descriptions like those.

> > > Our assumptions are (in the context of Landlock):
> > >
> > > 1. There are IOCTLs tied to file types (e.g. block device with
> > >    major/minor) that can easily be identified from user space (e.g. w=
ith
> > >    the path name and file's metadata).  /dev/* files make sense for u=
ser
> > >    space and they scope to a specific use case (with relative
> > >    privileges).  This category of IOCTLs is implemented in standalone
> > >    device drivers (for most of them).
> > >
> > > 2. Most user space processes should not be denied access to IOCTLs th=
at
> > >    are managed by the VFS layer or the underlying filesystem
> > >    implementations.  For instance, the do_vfs_ioctl()'s ones (e.g.
> > >    FIOCLEX, FIONREAD) should always be allowed because they may be
> > >    required to legitimately use files, and for performance and securi=
ty
> > >    reasons (e.g. fs-crypt, fsverity implemented at the filesystem lay=
er).
> > >    Moreover, these IOCTLs should already check the read/write permiss=
ion
> > >    (on the related FD), which is not the case for most block/char dev=
ice
> > >    IOCTL.
> > >
> > > 3. IOCTLs to pipes and sockets are out of scope.  They should always =
be
> > >    allowed for now because they don't directly expose files' data but
> > >    IPCs instead, and we are focusing on FS access rights for now.
> > >
> > > We want to add a new LANDLOCK_ACCESS_FS_IOCTL_DEV right that could ma=
tch
> > > on char/block device's specific IOCTLs, but it would not have any imp=
act
> > > on other IOCTLs which would then always be allowed (if the sandboxed
> > > process is allowed to open the file).
> > >
> > > Because IOCTLs are implemented in layers and all IOCTLs commands live=
 in
> > > the same 32-bit namespace, we need a way to identify the layer
> > > implemented by block and character devices.  The new LSM hook proposa=
l
> > > enables us to cleanly and efficiently identify the char/block device
> > > IOCTL layer with an additional check on the file type.
> >
> > I guess I should wait until there is an actual patch, but as of right
> > now a VFS ioctl specific LSM hook looks far too limited to me and
> > isn't something I can support at this point in time.  It's obviously
> > limited to only a subset of the ioctls, meaning that in order to have
> > comprehensive coverage we would either need to implement a full range
> > of subsystem ioctl hooks (ugh), or just use the existing
> > security_file_ioctl().
>
> I think there is a misunderstanding.  The subset of IOCTL commands the
> new hook will see would be 99% of them (i.e. all except those
> implemented in fs/ioctl.c).

*cough* 99% !=3D 100% *cough*

> Being able to only handle this (big) subset
> would empower LSMs to control IOCTL commands without collision (e.g. the
> same command/value may have different meanings according to the
> implementation/layer), which is not currently possible (without manual
> tweaking).
>
> This proposal is to add a new hook for the layer just beneath the VFS
> catch-all IOCTL implementation.  This layer can then differentiate
> between the underlying implementation according to the file properties.
> There is no need for additional hooks for other layers/subsystems.

I'm not sure how you reconcile less than 100% coverage, the need for a
generic hook, and the idea that there will not be a need for
additional hooks.  That still seems like a problem to me.

> The existing security_file_ioctl() hook is useful to catch all IOCTL
> commands, but it doesn't enable to identify the underlying target and
> then the semantic of the command.

The LSM hook gets the file pointer, the command, and the argument, how
is a LSM not able to identify the underlying target?

> Furthermore, as G=C3=BCnther said, an
> IOCTL call can already do kernel operations without looking at the
> command, but we would then be able to identify that by looking at the
> char/block device file for instance.
>
> > I understand that this makes things a bit more
> > complicated for Landlock's initial ioctl implementation, but
> > considering my thoughts above and the fact that Landlock's ioctl
> > protections are still evolving I'd rather not add a lot of extra hooks
> > right now.
>
> Without this hook, we'll need to rely on a list of allowed IOCTLs, which
> will be out-of-sync eventually.  It would be a maintenance burden and an
> hacky approach.

Welcome to the painful world of a LSM developer, ioctls are not the
only place where this is a problem, and it should be easy enough to
watch for changes in the ioctl list and update your favorite LSM
accordingly.  Honestly, I think that is kinda the right thing anyway,
I'm skeptical that one could have a generic solution that would
automatically allow or disallow a new ioctl without potentially
breaking your favorite LSM's security model.  If a new ioctl is
introduced it seems like having someone manually review it's impact on
your LSM would be a good idea.

> We're definitely open to new proposals, but until now this is the best
> approach we found from a maintenance, performance, and security point of
> view.

At this point it's probably a good idea to post another RFC patch with
your revised idea, if nothing else it will help rule out any
confusion.  While I remain skeptical, perhaps I am misunderstanding
the design and you'll get my apology and an ACK, but be warned that as
of right now I'm not convinced.

--
paul-moore.com

