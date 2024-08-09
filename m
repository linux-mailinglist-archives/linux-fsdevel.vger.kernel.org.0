Return-Path: <linux-fsdevel+bounces-25491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D704C94C79B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 02:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4597BB22C3D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63423DE;
	Fri,  9 Aug 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CahdGpwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354D4C8E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163313; cv=none; b=iKpV/3r5fOo7E87b4NnpAELJYCYXUveeUUnL3UNUned+qoTSb1FM4iMHkIl0Bs2CtIhksKPqKCfVtxu6X6b/4nz+N+HmadPZTuwOsDlQVCe2LyAp24l4znLrAqC55WtJT0TmgwhxtEPyX7kqlSnbdAIZTp5YvvdU7E57zuHCCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163313; c=relaxed/simple;
	bh=6osWMbwOg4Ag0jJaZ0T3U8g/7gy7C2ZC64se5ZGzwMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRNFsZo4AupysEoKr6XT0FzivzbUu+FQCrUadig+WLXCVxBIHPdvaVSDHoRtmrWkxbZu4Jt/BPApMpc9pne7WlqFcfrE44Ts/TWpKyApOUdUnbQH2QS+bRRdwbGn6QOYWdOZ63TOzfUcYJsiEbeqFLha+r2eWpRWJmanYNYqMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CahdGpwU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0bf97a2b96so1504951276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 17:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723163311; x=1723768111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yENP6sFmzdaYIAQ9oQ/ObMrdcuOATSgX3509zVldzcQ=;
        b=CahdGpwUj7TZGP4neGP2VAZAiRuDD5zx3lOaxgd1qLbkqIo/rLWVlwZbrQfR1vv3QQ
         GoO5jik9rb3BCLgQsvgKENmWpmqFH/uKt49lToglhCpwXoQhZKciysPJgmBzpN+0pfVY
         SoyMnn+Lhi9/pU2ywZ9VaUX0ob4htVP2xI/WyGhJEqsoWyDITmTQR0fs8oPiQu2AxZMZ
         GnAn31KJoS4HG0aSbzFXGTRMhd5FLCad2ALlrhLvrg1+lKNVejOhlAPKQCnyQf26qEaW
         0bdjft5WL711/xnMdD27QNnWMlgnPbBcaEgTnU25EYr/V8L6jwTCJ1vEQ7rf6V3zY0Ui
         cxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163311; x=1723768111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yENP6sFmzdaYIAQ9oQ/ObMrdcuOATSgX3509zVldzcQ=;
        b=uaHN3gU244paqbnrnq7cnxK6w+rtzmmvecBw5RWO/s9m9XRrkbBvS3GU7R45733Eib
         RoKcDvyYLKAdNUbmYFXkRpLRWuA0dnyjFS6hC9YcN9wxZS3rTxjk/ikd/0S5q9IPZvZm
         0vd2a4ov8qnVkNyPeYeImfzuYVHWptO1fY54+D0xwHqK3SnH/bm4z4IZI8wjUy0qteWp
         MrIwSh2A/XCtmHxQ7koz+G4FQ44KpMD/vcgZm6H5K9hFKbpwzn/m8wz5le10uPVhEw05
         i6IvrNcoOtDgGKeVTwNLNEsVjh5N62YgUP75jSaAZ0zAz8dYeAtXk4R8HCQW17qeyTwm
         CFlA==
X-Forwarded-Encrypted: i=1; AJvYcCV7MizuH57vpxyw/nVPF05Msd008jNjSLSvZweDFL6+uqUAR2BQCaIjPozva1rqSZUgLzc54hgHIzJDu/jeiGHhuRX8Q05RADtw429ZdQ==
X-Gm-Message-State: AOJu0YxTqfBALfusb7nlq3aHuiAqs01NNuPV55CEe3RawRn8UHbx6xlE
	8zcOOIPeFVZ1MxL5S83oxFrQA9rY8JZe8M/ynZV/QXkyWHTeiG5iz65AAqLg7a2UdL3zUw+Qns9
	1w+sP1ifhN0J8rxWxWXDjC97eo8lXmTIRuSE4
X-Google-Smtp-Source: AGHT+IHyFhWUFo7ni7dMY3nl8Z/bYXXdEviSRRjk6pPVPAwvD4m9fPeo4wKTWYkkffZieVE36Yn834qCLvbMbHY2alQ=
X-Received: by 2002:a05:6902:1609:b0:e0b:fd0e:26a6 with SMTP id
 3f1490d57ef6-e0e9dbbe4dfmr4661886276.40.1723163310891; Thu, 08 Aug 2024
 17:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner> <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner> <20240808171130.5alxaa5qz3br6cde@quack3>
 <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com> <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
In-Reply-To: <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 20:28:19 -0400
Message-ID: <CAHC9VhREbEAYQUoVrJ3=YHUh2tuL5waUMaXQGG_yzFsMNomRVg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:43=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> On Thu, 2024-08-08 at 17:12 -0400, Paul Moore wrote:
> > On Thu, Aug 8, 2024 at 1:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> > > > On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> > > > > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > > > > > +static struct dentry *lookup_fast_for_open(struct nameidata =
*nd, int open_flag)
> > > > > > > +{
> > > > > > > +       struct dentry *dentry;
> > > > > > > +
> > > > > > > +       if (open_flag & O_CREAT) {
> > > > > > > +               /* Don't bother on an O_EXCL create */
> > > > > > > +               if (open_flag & O_EXCL)
> > > > > > > +                       return NULL;
> > > > > > > +
> > > > > > > +               /*
> > > > > > > +                * FIXME: If auditing is enabled, then we'll =
have to unlazy to
> > > > > > > +                * use the dentry. For now, don't do this, si=
nce it shifts
> > > > > > > +                * contention from parent's i_rwsem to its d_=
lockref spinlock.
> > > > > > > +                * Reconsider this once dentry refcounting ha=
ndles heavy
> > > > > > > +                * contention better.
> > > > > > > +                */
> > > > > > > +               if ((nd->flags & LOOKUP_RCU) && !audit_dummy_=
context())
> > > > > > > +                       return NULL;
> > > > > >
> > > > > > Hm, the audit_inode() on the parent is done independent of whet=
her the
> > > > > > file was actually created or not. But the audit_inode() on the =
file
> > > > > > itself is only done when it was actually created. Imho, there's=
 no need
> > > > > > to do audit_inode() on the parent when we immediately find that=
 file
> > > > > > already existed. If we accept that then this makes the change a=
 lot
> > > > > > simpler.
> > > > > >
> > > > > > The inconsistency would partially remain though. When the file =
doesn't
> > > > > > exist audit_inode() on the parent is called but by the time we'=
ve
> > > > > > grabbed the inode lock someone else might already have created =
the file
> > > > > > and then again we wouldn't audit_inode() on the file but we wou=
ld have
> > > > > > on the parent.
> > > > > >
> > > > > > I think that's fine. But if that's bothersome the more aggressi=
ve thing
> > > > > > to do would be to pull that audit_inode() on the parent further=
 down
> > > > > > after we created the file. Imho, that should be fine?...
> > > > > >
> > > > > > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?r=
ef_type=3Dheads
> > > > > > for a completely untested draft of what I mean.
> > > > >
> > > > > Yeah, that's a lot simpler. That said, my experience when I've wo=
rked
> > > > > with audit in the past is that people who are using it are _very_
> > > > > sensitive to changes of when records get emitted or not. I don't =
like
> > > > > this, because I think the rules here are ad-hoc and somewhat arbi=
trary,
> > > > > but keeping everything working exactly the same has been my MO wh=
enever
> > > > > I have to work in there.
> > > > >
> > > > > If a certain access pattern suddenly generates a different set of
> > > > > records (or some are missing, as would be in this case), we might=
 get
> > > > > bug reports about this. I'm ok with simplifying this code in the =
way
> > > > > you suggest, but we may want to do it in a patch on top of mine, =
to
> > > > > make it simple to revert later if that becomes necessary.
> > > >
> > > > Fwiw, even with the rearranged checks in v3 of the patch audit reco=
rds
> > > > will be dropped because we may find a positive dentry but the path =
may
> > > > have trailing slashes. At that point we just return without audit
> > > > whereas before we always would've done that audit.
> > > >
> > > > Honestly, we should move that audit event as right now it's just re=
ally
> > > > weird and see if that works. Otherwise the change is somewhat horri=
ble
> > > > complicating the already convoluted logic even more.
> > > >
> > > > So I'm appending the patches that I have on top of your patch in
> > > > vfs.misc. Can you (other as well ofc) take a look and tell me wheth=
er
> > > > that's not breaking anything completely other than later audit even=
ts?
> > >
> > > The changes look good as far as I'm concerned but let me CC audit guy=
s if
> > > they have some thoughts regarding the change in generating audit even=
t for
> > > the parent. Paul, does it matter if open(O_CREAT) doesn't generate au=
dit
> > > event for the parent when we are failing open due to trailing slashes=
 in
> > > the pathname? Essentially we are speaking about moving:
> > >
> > >         audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> > >
> > > from open_last_lookups() into lookup_open().
> >
> > Thanks for adding the audit mailing list to the CC, Jan.  I would ask
> > for others to do the same when discussing changes that could impact
> > audit (similar requests for the LSM framework, SELinux, etc.).
> >
> > The inode/path logging in audit is ... something.  I have a
> > longstanding todo item to go revisit the audit inode logging, both to
> > fix some known bugs, and see what we can improve (I'm guessing quite a
> > bit).  Unfortunately, there is always something else which is burning
> > a little bit hotter and I haven't been able to get to it yet.
> >
>
> It is "something" alright. The audit logging just happens at strange
> and inconvenient times vs. what else we're trying to do wrt pathwalking
> and such. In particular here, the fact __audit_inode can block is what
> really sucks.
>
> Since we're discussing it...
>
> ISTM that the inode/path logging here is something like a tracepoint.
> In particular, we're looking to record a specific set of information at
> specific points in the code. One of the big differences between them
> however is that tracepoints don't block.  The catch is that we can't
> just drop messages if we run out of audit logging space, so that would
> have to be handled reasonably.

Yes, the buffer allocation is the tricky bit.  Audit does preallocate
some structs for tracking names which ideally should handle the vast
majority of the cases, but yes, we need something to handle all of the
corner cases too without having to resort to audit_panic().

> I wonder if we could leverage the tracepoint infrastructure to help us
> record the necessary info somehow? Copy the records into a specific
> ring buffer, and then copy them out to the audit infrastructure in
> task_work?

I believe using task_work will cause a number of challenges for the
audit subsystem as we try to bring everything together into a single
audit event.  We've had a lot of problems with io_uring doing similar
things, some of which are still unresolved.

> I don't have any concrete ideas here, but the path/inode audit code has
> been a burden for a while now and it'd be good to think about how we
> could do this better.

I've got some grand ideas on how to cut down on a lot of our
allocations and string generation in the critical path, not just with
the inodes, but with audit records in general.  Sadly I just haven't
had the time to get to any of it.

> > The general idea with audit is that you want to record the information
> > both on success and failure.  It's easy to understand the success
> > case, as it is a record of what actually happened on the system, but
> > you also want to record the failure case as it can provide some
> > insight on what a process/user is attempting to do, and that can be
> > very important for certain classes of users.  I haven't dug into the
> > patches in Christian's tree, but in general I think Jeff's guidance
> > about not changing what is recorded in the audit log is probably good
> > advice (there will surely be exceptions to that, but it's still good
> > guidance).
> >
>
> In this particular case, the question is:
>
> Do we need to emit a AUDIT_INODE_PARENT record when opening an existing
> file, just because O_CREAT was set? We don't emit such a record when
> opening without O_CREAT set.

I'm not as current on the third-party security requirements as I used
to be, but I do know that oftentimes when a file is created the parent
directory is an important bit of information to have in the audit log.

--=20
paul-moore.com

