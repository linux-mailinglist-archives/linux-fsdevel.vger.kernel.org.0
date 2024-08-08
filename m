Return-Path: <linux-fsdevel+bounces-25488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80694C76E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 01:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D760EB2496C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C211649C6;
	Thu,  8 Aug 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBoAAJtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B4166314;
	Thu,  8 Aug 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160609; cv=none; b=Jv9FkwWhFIerHt1FiyPox1Tv86ujuEfWuOhdhpJwYmbOthpXWHFVml9ib7NJB13HyiuJItT1FAzToWbbFhLolyHeLkcJKcb2ntTxtSZ9sO4ElkFHKHHYp2S8AbpOj+EQRMgPqRgNBPf5KM1/mF7SewCesepI5jSO2eHsarUxncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160609; c=relaxed/simple;
	bh=D0nZdzoiJnGLrGHXx+vX60YdnArnxjQB/HltQXsiEAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHXnVbBPXWxV3flAcIFFEN3a/PdzLeCtTiorIfjCfuFX8FmBi0L2dAiUBqUFU+aVzJbv3UP5x7NPrzxzWSfQgSldtgA0/SzjwiYz3930/f5aX7R/AXys2KbW/Pjh7FXnioOszvnd91mDKa8v2yJh3RzOQdDma9i6mks60XGPuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBoAAJtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB0FC32782;
	Thu,  8 Aug 2024 23:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723160608;
	bh=D0nZdzoiJnGLrGHXx+vX60YdnArnxjQB/HltQXsiEAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rBoAAJtmx+jLN0E7BUSujTsNdDuEdUti7AvjHAXQkh5pnk6h2fXip4VxdjUYbM8dH
	 Epm+Iped9l/uijtzh1zAs78PEJFwTOkZqw7maB269106FQNhyj34UIwDy1Vb8GgDiL
	 H+e53tazwedjj0xIyw6tFRdFl2FIpfVc4hLjQ4O9nUjuS+O56aPuuUgj51KfO0UIaK
	 DcdH7kbGJ2vdBxKnoW0I0NI+0mCofBkkYtbi65Cyatp+c4ccsc5tEXRbR5kGFxllSy
	 B0aIHlPmOhNCMHsvDZeuZNIgjUn0rvKe3qhB29kupltbC1qSoHRe7wBvQJu6ZPC+D3
	 a+tmp9ubK1lFw==
Message-ID: <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 audit@vger.kernel.org
Date: Thu, 08 Aug 2024 19:43:26 -0400
In-Reply-To: <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	 <20240807-erledigen-antworten-6219caebedc0@brauner>
	 <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
	 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
	 <20240808171130.5alxaa5qz3br6cde@quack3>
	 <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 17:12 -0400, Paul Moore wrote:
> On Thu, Aug 8, 2024 at 1:11=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> > > On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton wrote:
> > > > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner wrote:
> > > > > > +static struct dentry *lookup_fast_for_open(struct nameidata *n=
d, int open_flag)
> > > > > > +{
> > > > > > +       struct dentry *dentry;
> > > > > > +
> > > > > > +       if (open_flag & O_CREAT) {
> > > > > > +               /* Don't bother on an O_EXCL create */
> > > > > > +               if (open_flag & O_EXCL)
> > > > > > +                       return NULL;
> > > > > > +
> > > > > > +               /*
> > > > > > +                * FIXME: If auditing is enabled, then we'll ha=
ve to unlazy to
> > > > > > +                * use the dentry. For now, don't do this, sinc=
e it shifts
> > > > > > +                * contention from parent's i_rwsem to its d_lo=
ckref spinlock.
> > > > > > +                * Reconsider this once dentry refcounting hand=
les heavy
> > > > > > +                * contention better.
> > > > > > +                */
> > > > > > +               if ((nd->flags & LOOKUP_RCU) && !audit_dummy_co=
ntext())
> > > > > > +                       return NULL;
> > > > >=20
> > > > > Hm, the audit_inode() on the parent is done independent of whethe=
r the
> > > > > file was actually created or not. But the audit_inode() on the fi=
le
> > > > > itself is only done when it was actually created. Imho, there's n=
o need
> > > > > to do audit_inode() on the parent when we immediately find that f=
ile
> > > > > already existed. If we accept that then this makes the change a l=
ot
> > > > > simpler.
> > > > >=20
> > > > > The inconsistency would partially remain though. When the file do=
esn't
> > > > > exist audit_inode() on the parent is called but by the time we've
> > > > > grabbed the inode lock someone else might already have created th=
e file
> > > > > and then again we wouldn't audit_inode() on the file but we would=
 have
> > > > > on the parent.
> > > > >=20
> > > > > I think that's fine. But if that's bothersome the more aggressive=
 thing
> > > > > to do would be to pull that audit_inode() on the parent further d=
own
> > > > > after we created the file. Imho, that should be fine?...
> > > > >=20
> > > > > See https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/?ref=
_type=3Dheads
> > > > > for a completely untested draft of what I mean.
> > > >=20
> > > > Yeah, that's a lot simpler. That said, my experience when I've work=
ed
> > > > with audit in the past is that people who are using it are _very_
> > > > sensitive to changes of when records get emitted or not. I don't li=
ke
> > > > this, because I think the rules here are ad-hoc and somewhat arbitr=
ary,
> > > > but keeping everything working exactly the same has been my MO when=
ever
> > > > I have to work in there.
> > > >=20
> > > > If a certain access pattern suddenly generates a different set of
> > > > records (or some are missing, as would be in this case), we might g=
et
> > > > bug reports about this. I'm ok with simplifying this code in the wa=
y
> > > > you suggest, but we may want to do it in a patch on top of mine, to
> > > > make it simple to revert later if that becomes necessary.
> > >=20
> > > Fwiw, even with the rearranged checks in v3 of the patch audit record=
s
> > > will be dropped because we may find a positive dentry but the path ma=
y
> > > have trailing slashes. At that point we just return without audit
> > > whereas before we always would've done that audit.
> > >=20
> > > Honestly, we should move that audit event as right now it's just real=
ly
> > > weird and see if that works. Otherwise the change is somewhat horribl=
e
> > > complicating the already convoluted logic even more.
> > >=20
> > > So I'm appending the patches that I have on top of your patch in
> > > vfs.misc. Can you (other as well ofc) take a look and tell me whether
> > > that's not breaking anything completely other than later audit events=
?
> >=20
> > The changes look good as far as I'm concerned but let me CC audit guys =
if
> > they have some thoughts regarding the change in generating audit event =
for
> > the parent. Paul, does it matter if open(O_CREAT) doesn't generate audi=
t
> > event for the parent when we are failing open due to trailing slashes i=
n
> > the pathname? Essentially we are speaking about moving:
> >=20
> >         audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
> >=20
> > from open_last_lookups() into lookup_open().
>=20
> Thanks for adding the audit mailing list to the CC, Jan.  I would ask
> for others to do the same when discussing changes that could impact
> audit (similar requests for the LSM framework, SELinux, etc.).
>=20
> The inode/path logging in audit is ... something.  I have a
> longstanding todo item to go revisit the audit inode logging, both to
> fix some known bugs, and see what we can improve (I'm guessing quite a
> bit).  Unfortunately, there is always something else which is burning
> a little bit hotter and I haven't been able to get to it yet.
>=20

It is "something" alright. The audit logging just happens at strange
and inconvenient times vs. what else we're trying to do wrt pathwalking
and such. In particular here, the fact __audit_inode can block is what
really sucks.

Since we're discussing it...

ISTM that the inode/path logging here is something like a tracepoint.
In particular, we're looking to record a specific set of information at
specific points in the code. One of the big differences between them
however is that tracepoints don't block.  The catch is that we can't
just drop messages if we run out of audit logging space, so that would
have to be handled reasonably.

I wonder if we could leverage the tracepoint infrastructure to help us
record the necessary info somehow? Copy the records into a specific
ring buffer, and then copy them out to the audit infrastructure in
task_work?

I don't have any concrete ideas here, but the path/inode audit code has
been a burden for a while now and it'd be good to think about how we
could do this better.

> The general idea with audit is that you want to record the information
> both on success and failure.  It's easy to understand the success
> case, as it is a record of what actually happened on the system, but
> you also want to record the failure case as it can provide some
> insight on what a process/user is attempting to do, and that can be
> very important for certain classes of users.  I haven't dug into the
> patches in Christian's tree, but in general I think Jeff's guidance
> about not changing what is recorded in the audit log is probably good
> advice (there will surely be exceptions to that, but it's still good
> guidance).
>=20

In this particular case, the question is:

Do we need to emit a AUDIT_INODE_PARENT record when opening an existing
file, just because O_CREAT was set? We don't emit such a record when
opening without O_CREAT set.

--=20
Jeff Layton <jlayton@kernel.org>

