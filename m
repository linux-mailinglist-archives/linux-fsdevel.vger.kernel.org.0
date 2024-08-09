Return-Path: <linux-fsdevel+bounces-25495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C494C7FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C791C21F42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A631D517;
	Fri,  9 Aug 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c4RdXLHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26A846F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166588; cv=none; b=Y7C351x5Z0o4MvEvQrguixI24exCEtemqe6WraChJ31qYrrQ9A0yaCpd/MXBTr+L+buDJ1839WW74ryAxr7zSF/Ej8uLLBlxwZe+3EnjkdKYC0Hjbx9HSDYaOPAmz0S4tblkKZIDSxFCApBzXduXGToVORQkEWGhuedOy9XEyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166588; c=relaxed/simple;
	bh=hbGnygk7hxJbZu0jyxT9iMEYWeJVRVSEXdmikHa4ArQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k63+DqmI6Z84cscqkzYvHfR27Ic2AUytgCUEcacUvY16y0XLHkGSyihZB0JgpJUvRtIksbOvAGuoy2BDNznREXTAA1ZnuZiaGfwiQ9zpPQl6m+0tvQa1e+m4G2HmvNWhrN2wSD9b119NnowmlFJ000WPzoJW8EZwOfN5rOCYTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c4RdXLHH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690ad83d4d7so14939817b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723166585; x=1723771385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9bXLF4NefoobiKX9+zIRi7gWzdnSGjmqx0nUbqIEf8=;
        b=c4RdXLHHmAJRfUYj6g7GpxHyzE6i3Q/LQ83cO8Yemdu4x96BG+j6IMHpQmvQikxNBo
         NP6AqdkknPDurOVcJ12Yz4+xXHqHUcBdx70rt8CMomWULievM35bLYH/oJ5zeOlcZiqV
         DZMKVqFbhzdsoaIeVECkt7haAk4K2hzTXranHlkhen/Wg/QpDfSfmBuL9op+LdCUFp93
         luz9USN+xOQoouBIN0GRn+QPrOUFy4aJ1uuCu6ofT3+F+wzP8000RmqL9ulQvr7sCJnC
         czudtwraUGQieYMpznwc1Wi8PuMq7iU9JSrxCWeXRm7k85tJa+dD7a13yjI7mbl62FmC
         D/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166585; x=1723771385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9bXLF4NefoobiKX9+zIRi7gWzdnSGjmqx0nUbqIEf8=;
        b=Tcpn2HNm8zMI/mUozbakKyac/hhtO8y80P5/HSTfDCKOytCBQvfXeMXwjMPVFeQNjB
         urpqzZV2UAyLcLJaiUjJroQhGHnJJVpDPFOmo7T7rcrHscKVp4mrylT2s6KNMFA53PAf
         hpDs5/1Qh4TctCt89uU1FGLnhzk6OFamRAbHSSu47yHE4y0NtQAHe7SsWqPuoAAiUh+j
         uilZB8IWgQTP+3MdpivMQPScOWa+8+Mp1Ke1tSN9oog10FHF3erdz80ncCXCLpM4Mfih
         pqLfpWrdwR4pBgW9JWydo3pqEVmHSML2bjv4yhU2x/XQBI7dQNsi7CT/Nb1OV272ZqYZ
         qhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmHB/D1/Qvrl2kQimKRwimEWJAZETdbRNEhQxeSrKxq3zqNwa/kQSAduaXxX8i0QTnEWtwKCPVwh4e7niS0/LX4QRVWQFeqBCqiCnUNg==
X-Gm-Message-State: AOJu0YzD39RnuQOQaC8ezx6s/btYiRjpLUspY/d5goKBv1fwwlAgZJNC
	ocPL1eElnKerWBOgCmsBXEn10reYFbg6GnFRyzmspZm/hRq9N4FjYhJs9koM4HVTfC7d3A7L6ps
	9VFV9UZHCmbTCDWor2uS/D7xToh1PIKA11wIB
X-Google-Smtp-Source: AGHT+IHAUa6Q+LYMkbNRDeMI4FjrabMEZxysSMR+Wn8lEcrEUa9i7f8iYckyZqbRN3DpJ6uezP+4mRsx6Ws4h4d3IaQ=
X-Received: by 2002:a05:690c:fce:b0:64b:7859:a92f with SMTP id
 00721157ae682-69ec49238d6mr406897b3.5.1723166585032; Thu, 08 Aug 2024
 18:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <20240807-erledigen-antworten-6219caebedc0@brauner> <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner> <20240808171130.5alxaa5qz3br6cde@quack3>
 <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
 <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
 <CAHC9VhREbEAYQUoVrJ3=YHUh2tuL5waUMaXQGG_yzFsMNomRVg@mail.gmail.com> <a8e24c94fa5500ee3c99a3dabba452e381512808.camel@kernel.org>
In-Reply-To: <a8e24c94fa5500ee3c99a3dabba452e381512808.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 21:22:54 -0400
Message-ID: <CAHC9VhSEuj_70ohbrgHrFv7Y8-MvwH7EwkD_L0=0KhVW-bX=Nw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
> On Thu, 2024-08-08 at 20:28 -0400, Paul Moore wrote:
> > On Thu, Aug 8, 2024 at 7:43=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > On Thu, 2024-08-08 at 17:12 -0400, Paul Moore wrote:
> > > > On Thu, Aug 8, 2024 at 1:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrot=
e:
> > > > > On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> > > > > > On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> > > > > > > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > > > > > > > +static struct dentry *lookup_fast_for_open(struct nameid=
ata *nd, int open_flag)
> > > > > > > > > +{
> > > > > > > > > +       struct dentry *dentry;
> > > > > > > > > +
> > > > > > > > > +       if (open_flag & O_CREAT) {
> > > > > > > > > +               /* Don't bother on an O_EXCL create */
> > > > > > > > > +               if (open_flag & O_EXCL)
> > > > > > > > > +                       return NULL;
> > > > > > > > > +
> > > > > > > > > +               /*
> > > > > > > > > +                * FIXME: If auditing is enabled, then we=
'll have to unlazy to
> > > > > > > > > +                * use the dentry. For now, don't do this=
, since it shifts
> > > > > > > > > +                * contention from parent's i_rwsem to it=
s d_lockref spinlock.
> > > > > > > > > +                * Reconsider this once dentry refcountin=
g handles heavy
> > > > > > > > > +                * contention better.
> > > > > > > > > +                */
> > > > > > > > > +               if ((nd->flags & LOOKUP_RCU) && !audit_du=
mmy_context())
> > > > > > > > > +                       return NULL;
> > > > > > > >
> > > > > > > > Hm, the audit_inode() on the parent is done independent of =
whether the
> > > > > > > > file was actually created or not. But the audit_inode() on =
the file
> > > > > > > > itself is only done when it was actually created. Imho, the=
re's no need
> > > > > > > > to do audit_inode() on the parent when we immediately find =
that file
> > > > > > > > already existed. If we accept that then this makes the chan=
ge a lot
> > > > > > > > simpler.
> > > > > > > >
> > > > > > > > The inconsistency would partially remain though. When the f=
ile doesn't
> > > > > > > > exist audit_inode() on the parent is called but by the time=
 we've
> > > > > > > > grabbed the inode lock someone else might already have crea=
ted the file
> > > > > > > > and then again we wouldn't audit_inode() on the file but we=
 would have
> > > > > > > > on the parent.
> > > > > > > >
> > > > > > > > I think that's fine. But if that's bothersome the more aggr=
essive thing
> > > > > > > > to do would be to pull that audit_inode() on the parent fur=
ther down
> > > > > > > > after we created the file. Imho, that should be fine?...
> > > > > > > >
> > > > > > > > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jef=
f/?ref_type=3Dheads
> > > > > > > > for a completely untested draft of what I mean.
> > > > > > >
> > > > > > > Yeah, that's a lot simpler. That said, my experience when I'v=
e worked
> > > > > > > with audit in the past is that people who are using it are _v=
ery_
> > > > > > > sensitive to changes of when records get emitted or not. I do=
n't like
> > > > > > > this, because I think the rules here are ad-hoc and somewhat =
arbitrary,
> > > > > > > but keeping everything working exactly the same has been my M=
O whenever
> > > > > > > I have to work in there.
> > > > > > >
> > > > > > > If a certain access pattern suddenly generates a different se=
t of
> > > > > > > records (or some are missing, as would be in this case), we m=
ight get
> > > > > > > bug reports about this. I'm ok with simplifying this code in =
the way
> > > > > > > you suggest, but we may want to do it in a patch on top of mi=
ne, to
> > > > > > > make it simple to revert later if that becomes necessary.
> > > > > >
> > > > > > Fwiw, even with the rearranged checks in v3 of the patch audit =
records
> > > > > > will be dropped because we may find a positive dentry but the p=
ath may
> > > > > > have trailing slashes. At that point we just return without aud=
it
> > > > > > whereas before we always would've done that audit.
> > > > > >
> > > > > > Honestly, we should move that audit event as right now it's jus=
t really
> > > > > > weird and see if that works. Otherwise the change is somewhat h=
orrible
> > > > > > complicating the already convoluted logic even more.
> > > > > >
> > > > > > So I'm appending the patches that I have on top of your patch i=
n
> > > > > > vfs.misc. Can you (other as well ofc) take a look and tell me w=
hether
> > > > > > that's not breaking anything completely other than later audit =
events?
> > > > >
> > > > > The changes look good as far as I'm concerned but let me CC audit=
 guys if
> > > > > they have some thoughts regarding the change in generating audit =
event for
> > > > > the parent. Paul, does it matter if open(O_CREAT) doesn't generat=
e audit
> > > > > event for the parent when we are failing open due to trailing sla=
shes in
> > > > > the pathname? Essentially we are speaking about moving:
> > > > >
> > > > >         audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> > > > >
> > > > > from open_last_lookups() into lookup_open().
> > > >
> > > > Thanks for adding the audit mailing list to the CC, Jan.  I would a=
sk
> > > > for others to do the same when discussing changes that could impact
> > > > audit (similar requests for the LSM framework, SELinux, etc.).
> > > >
> > > > The inode/path logging in audit is ... something.  I have a
> > > > longstanding todo item to go revisit the audit inode logging, both =
to
> > > > fix some known bugs, and see what we can improve (I'm guessing quit=
e a
> > > > bit).  Unfortunately, there is always something else which is burni=
ng
> > > > a little bit hotter and I haven't been able to get to it yet.
> > > >
> > >
> > > It is "something" alright. The audit logging just happens at strange
> > > and inconvenient times vs. what else we're trying to do wrt pathwalki=
ng
> > > and such. In particular here, the fact __audit_inode can block is wha=
t
> > > really sucks.
> > >
> > > Since we're discussing it...
> > >
> > > ISTM that the inode/path logging here is something like a tracepoint.
> > > In particular, we're looking to record a specific set of information =
at
> > > specific points in the code. One of the big differences between them
> > > however is that tracepoints don't block.  The catch is that we can't
> > > just drop messages if we run out of audit logging space, so that woul=
d
> > > have to be handled reasonably.
> >
> > Yes, the buffer allocation is the tricky bit.  Audit does preallocate
> > some structs for tracking names which ideally should handle the vast
> > majority of the cases, but yes, we need something to handle all of the
> > corner cases too without having to resort to audit_panic().
> >
> > > I wonder if we could leverage the tracepoint infrastructure to help u=
s
> > > record the necessary info somehow? Copy the records into a specific
> > > ring buffer, and then copy them out to the audit infrastructure in
> > > task_work?
> >
> > I believe using task_work will cause a number of challenges for the
> > audit subsystem as we try to bring everything together into a single
> > audit event.  We've had a lot of problems with io_uring doing similar
> > things, some of which are still unresolved.
> >
> > > I don't have any concrete ideas here, but the path/inode audit code h=
as
> > > been a burden for a while now and it'd be good to think about how we
> > > could do this better.
> >
> > I've got some grand ideas on how to cut down on a lot of our
> > allocations and string generation in the critical path, not just with
> > the inodes, but with audit records in general.  Sadly I just haven't
> > had the time to get to any of it.
> >
> > > > The general idea with audit is that you want to record the informat=
ion
> > > > both on success and failure.  It's easy to understand the success
> > > > case, as it is a record of what actually happened on the system, bu=
t
> > > > you also want to record the failure case as it can provide some
> > > > insight on what a process/user is attempting to do, and that can be
> > > > very important for certain classes of users.  I haven't dug into th=
e
> > > > patches in Christian's tree, but in general I think Jeff's guidance
> > > > about not changing what is recorded in the audit log is probably go=
od
> > > > advice (there will surely be exceptions to that, but it's still goo=
d
> > > > guidance).
> > > >
> > >
> > > In this particular case, the question is:
> > >
> > > Do we need to emit a AUDIT_INODE_PARENT record when opening an existi=
ng
> > > file, just because O_CREAT was set? We don't emit such a record when
> > > opening without O_CREAT set.
> >
> > I'm not as current on the third-party security requirements as I used
> > to be, but I do know that oftentimes when a file is created the parent
> > directory is an important bit of information to have in the audit log.
> >
>
> Right. We'd still have that here since we have to unlazy to actually
> create the file.
>
> The question here is about the case where O_CREAT is set, but the file
> already exists. Nothing is being created in that case, so do we need to
> emit an audit record for the parent?

As long as the full path information is present in the existing file's
audit record it should be okay.

--=20
paul-moore.com

