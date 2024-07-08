Return-Path: <linux-fsdevel+bounces-23336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7692AC1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 00:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93EA2283177
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F81514CC;
	Mon,  8 Jul 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J+rwN3KV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167D50276
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477961; cv=none; b=T0QC3oeF4fuObHr2NOP4rdkZLAh41NueR6yE68QzZwxHQBqT4ZDThebGniDMOOKfuQ6khWcD7wyqsHWwNT/OwJ/ZveEHjLOsmT5Gt2X6/IPm18tmU2tbt/rpZyF60H9mjawG55czi9k5c3lHYQ4uWYaP6v0sTiVPjaFCRHghE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477961; c=relaxed/simple;
	bh=Slf7pI4DfRhx+s6iAFxWcyZpHfJvMkT4k4utjlxCMko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zm+Rv/7OivK9AwtYr1i7tp7mwKFRFbq1D7+UlzlOgm/otDTlZJXZYXFQqgg02rXySKpccSFP4tadM5gFTE9OHrZeP8Wolednk0pxYp8hx+UJCuTgo3eEo9rDY0RzF1tN3HmHrKtr1YIDF1wCJNajzeQAMs5LmJRrh6oBdaP4G2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J+rwN3KV; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-df481bf6680so4337883276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720477959; x=1721082759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnZIiITzAlGiaKrePmoZvp8ITih5adJJfAX3T737Yr8=;
        b=J+rwN3KVa41rqkq41J8rpIsFk6ovPBW5sEXrYDJzK07sjmRusjxVEY4QD4KMX2ALuo
         bJk1KCYVRYVpY0aT7WZnmB48X45ecDgDB1oLgJnQN/RWlGL2EF7LQEJjDOFM5lQa7qyr
         NRFLXHQSz5azkqYWh7rCXZOcgWTZC+1oYSoG9BWIgtoywRZ7tM6GhrKOhL36/szOpX4W
         HckrZi84b1Bu+bmFx2gUoDbYmfPJL3l2OCM0CTEMPAxDVzVNLDKyyI9AU6oKWuzYHUt7
         +TCUMNkW5izC7vIE+8G8BtfL3QtdfKNkr080bqZx+py8bgfAHYmzzC9WJzyP5UgUvOE5
         0q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720477959; x=1721082759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnZIiITzAlGiaKrePmoZvp8ITih5adJJfAX3T737Yr8=;
        b=Pvt0YFqeKaRbrRb+RONQmuvtPr6btJ+EW6elk6R5Wxi8yCMnX1pjYv7aspvrvFajeZ
         E4q70srbZS2z6iHn/AbL6qJQm/UWSBlltktPiT5JvMJBCrWNe8ryiaAZGCWJchONE5ou
         B7g2EkwdmRw25WVasycsj8IK/fxWsLtzg0XkBPNDCnU0TMyjpph+IfLXbUPag8/AEBOm
         YV2Nn0R3fK3Do0cQIZO5uuem6wlTPZrdL6t7ojjZdhACmv75nd0GNEBQAXOGbft4429+
         hEdRoFlnOMIIrhm6T3z1NT88lvuWg5aG30ETxKoEYEFTSTiqi7fdbHypkmYmKWJQ7t+E
         /I2w==
X-Forwarded-Encrypted: i=1; AJvYcCXfrbalOHGs9ezy3qaNJGzjJUejr7tNhVkgpVH+654WrRkcymuekYHG/xdqnpRMThNIJ+ZB7j8Oidq+/cPKN0fRu6Tyn6+DRPogeVqixg==
X-Gm-Message-State: AOJu0YyR8XNesToGNlE9sAgLowEyVHMP4cxs4uBlFoyEkdq46UkbeJ4/
	78ijP0BtbGCzP9q2obLVIsMand2/IP5lFXm8qX4k1BfoVbyCx7vTHYzON557sJkebzpZwfqGEDe
	M0c8ZzsmiyAqwiQSZCnicm52ITYBld2yezMOKC9FMe/5mMfs=
X-Google-Smtp-Source: AGHT+IF99Y+36stRXyUuKOt7oxt+1NAUpeQDk7zd7+zaGmS1bdJrisu3ORJ0M4042grDrNCzCJVzjwAKw5zafDfSk7U=
X-Received: by 2002:a25:c5d0:0:b0:e03:5f05:7566 with SMTP id
 3f1490d57ef6-e041b079cd3mr1183336276.34.1720477958973; Mon, 08 Jul 2024
 15:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
 <20240708.ig8Kucapheid@digikod.net>
In-Reply-To: <20240708.ig8Kucapheid@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jul 2024 18:32:28 -0400
Message-ID: <CAHC9VhT6oz_04EjQEovKvmafyFDZCEevqwBHZ+7omJHJ9=t_WQ@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:11=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Thu, Jun 27, 2024 at 02:28:03PM -0400, Paul Moore wrote:
> > On Thu, Jun 27, 2024 at 9:34=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > I didn't find specific issues with Landlock's code except the extra
> > > check in hook_inode_free_security().  It looks like inode->i_security=
 is
> > > a dangling pointer, leading to UAF.
> > >
> > > Reading security_inode_free() comments, two things looks weird to me:
> > >
> > > > /**
> > > >  * security_inode_free() - Free an inode's LSM blob
> > > >  * @inode: the inode
> > > >  *
> > > >  * Deallocate the inode security structure and set @inode->i_securi=
ty to NULL.
> > >
> > > I don't see where i_security is set to NULL.
> >
> > The function header comments are known to be a bit suspect, a side
> > effect of being detached from the functions for many years, this may
> > be one of those cases.  I tried to fix up the really awful ones when I
> > moved the comments back, back I didn't have time to go through each
> > one in detail.  Patches to correct the function header comments are
> > welcome and encouraged! :)
> >
> > > >  */
> > > > void security_inode_free(struct inode *inode)
> > > > {
> > >
> > > Shouldn't we add this check here?
> > > if (!inode->i_security)
> > >         return;
> >
> > Unless I'm remembering something wrong, I believe we *should* always
> > have a valid i_security pointer each time we are called, if not
> > something has gone wrong, e.g. the security_inode_free() hook is no
> > longer being called from the right place.  If we add a NULL check, we
> > should probably have a WARN_ON(), pr_err(), or something similar to
> > put some spew on the console/logs.
> >
> > All that said, it would be good to hear some confirmation from the VFS
> > folks that the security_inode_free() hook is located in a spot such
> > that once it exits it's current RCU critical section it is safe to
> > release the associated LSM state.
> >
> > It's also worth mentioning that while we always allocate i_security in
> > security_inode_alloc() right now, I can see a world where we allocate
> > the i_security field based on need using the lsm_blob_size info (maybe
> > that works today?  not sure how kmem_cache handled 0 length blobs?).
> > The result is that there might be a legitimate case where i_security
> > is NULL, yet we still want to call into the LSM using the
> > inode_free_security() implementation hook.
> >
> > > >       call_void_hook(inode_free_security, inode);
> > > >       /*
> > > >        * The inode may still be referenced in a path walk and
> > > >        * a call to security_inode_permission() can be made
> > > >        * after inode_free_security() is called. Ideally, the VFS
> > > >        * wouldn't do this, but fixing that is a much harder
> > > >        * job. For now, simply free the i_security via RCU, and
> > > >        * leave the current inode->i_security pointer intact.
> > > >        * The inode will be freed after the RCU grace period too.
> > >
> > > It's not clear to me why this should be safe if an LSM try to use the
> > > partially-freed blob after the hook calls and before the actual blob
> > > free.
> >
> > I had the same thought while looking at this just now.  At least in
> > the SELinux case I think this "works" simply because SELinux doesn't
> > do much here, it just drops the inode from a SELinux internal list
> > (long story) and doesn't actually release any memory or reset the
> > inode's SELinux state (there really isn't anything to "free" in the
> > SELinux case).  I haven't checked the other LSMs, but they may behave
> > similarly.
> >
> > We may want (need?) to consider two LSM implementation hooks called
> > from within security_inode_free(): the first where the existing
> > inode_free_security() implementation hook is called, the second inside
> > the inode_free_by_rcu() callback immediately before the i_security
> > data is free'd.
>
> Couldn't we call everything in inode_free_by_rcu()?

My two concerns would be 1) an LSM needed to mark the inode
immediately (to be fair, I'm not sure how plausible that is, and it
would likely require LSM specific locking/sync) and 2) if an LSM
needed more context than would be valid in the RCU callback case
(although that is questionable, I don't believe any of the current
users need anything like that, e.g. task_struct).  I'm not opposed to
just moving everything to a single hook done when the inode is
actually dropped from memory as long as the current LSMs which make
use of it are okay with that (Landlock, IMA, SELinux).

> > ... or we find a better placement in the VFS for
> > security_inode_free(), is that is possible.  It may not be, our VFS
> > friends should be able to help here.
>
> Christian? Al?

I poked around a bit more and it looks like bcachefs has some error
handling code that frees the inodes synchronously instead of using the
i_callback/inode::free_inode approach; xfs has its own thing too.
Although if it really is just some bcachefs/xfs error handlers maybe
inserting a LSM hook in the proper
the-memory-is-actually-being-dropped code path  (with adjustments for
bcachefs/xfs) isn't too bad.  Once again, we would need to hear from
the VFS folks regarding their thoughts on this, it wouldn't surprise
me if there is some detail missing in the above, or if they are
opposed to this for some other reason not mentioned yet in this
thread.

--=20
paul-moore.com

