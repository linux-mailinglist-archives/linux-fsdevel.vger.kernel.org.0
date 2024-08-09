Return-Path: <linux-fsdevel+bounces-25533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80B94D211
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE361F22A01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8E197549;
	Fri,  9 Aug 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrHExJea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25619645D;
	Fri,  9 Aug 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213293; cv=none; b=n3OjlEwkSyYqmFkOGUeeoXuuY1rJ1vLdTW56+rL/DK3NKeqAmXjBP+Qf8A7C6Al1HmEyXTqf55sN0l6izDXa8SypGe6Pm7gm3LCLA3Y8NF1EpxfCCy1oNYB9tB9MmL4Debxr29TqjaRnx0T5b7YAyDAOPEsJFESelF0KcrmgEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213293; c=relaxed/simple;
	bh=g22gSE9OQzn4WTodB921V6rgOPbnguVUHQyL9yzvCOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbIWnLFOtf9d+yi0lCVhmJlPTbY8rfycntJM4VMbXoAGyy2MiB+OlhEpWaYPX15UX0nA92kDWR1wGBH919ORIMe9mdleuEDXO7C6KWGwCgeY0yVkgp3BOYXnSs0ZrcGyd4w61m83IJgQb5DAnQ6G7bB2wGiZdKdr7JfZuPkvGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrHExJea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434E2C32782;
	Fri,  9 Aug 2024 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723213293;
	bh=g22gSE9OQzn4WTodB921V6rgOPbnguVUHQyL9yzvCOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=PrHExJeaxziz/LR+vnYv8ZPYHYYJvcyFjdXhqdPIrWpwAmlOfgRBbvWy086Fyyh9m
	 N6WWnfWBynAYFPTteGeRDWUZLVaWyFJg4//PlsMPHqx/ijrC92h+yA0Yldlq7Qae5r
	 3Jw0IvN6nD7JhxewndbVrljCZ+7AWf+SpTWDe1/1No3TdKC1KPXi6S4+d0jpBGed2j
	 /CI0wJB7EkxVx5M9amI7vEcb6wy2XwhoNEEBAxwPnSurIJgfkfPRm8ydEUt/OH9a7X
	 2BPSk8PtKzpYazM7R5a8UHmHU/x5Xuywv06zgzPVMfDWxlZ3ibF31lsUkp0d5dxjJX
	 pNQGx4U+14qTA==
Message-ID: <cd7133462f3018114f16366bae14ef6504d75b68.camel@kernel.org>
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
From: Jeff Layton <jlayton@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, Josef Bacik
 <josef@toxicpanda.com>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  audit@vger.kernel.org
Date: Fri, 09 Aug 2024 10:21:31 -0400
In-Reply-To: <CAHC9VhSEuj_70ohbrgHrFv7Y8-MvwH7EwkD_L0=0KhVW-bX=Nw@mail.gmail.com>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
	 <20240807-erledigen-antworten-6219caebedc0@brauner>
	 <d682e7c2749f8e8c74ea43b8893a17bd6e9a0007.camel@kernel.org>
	 <20240808-karnickel-miteinander-d4fa6cd5f3c7@brauner>
	 <20240808171130.5alxaa5qz3br6cde@quack3>
	 <CAHC9VhQ8h-a3HtRERGxAK77g6nw3fDzguFvwNkDcdbOYojQ6PQ@mail.gmail.com>
	 <d0677c60eb1f47eb186f3e5493ba5aa7e0eaa445.camel@kernel.org>
	 <CAHC9VhREbEAYQUoVrJ3=YHUh2tuL5waUMaXQGG_yzFsMNomRVg@mail.gmail.com>
	 <a8e24c94fa5500ee3c99a3dabba452e381512808.camel@kernel.org>
	 <CAHC9VhSEuj_70ohbrgHrFv7Y8-MvwH7EwkD_L0=0KhVW-bX=Nw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 21:22 -0400, Paul Moore wrote:
> On Thu, Aug 8, 2024 at 8:33=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> wrote:
> > On Thu, 2024-08-08 at 20:28 -0400, Paul Moore wrote:
> > > On Thu, Aug 8, 2024 at 7:43=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g>
> > > wrote:
> > > > On Thu, 2024-08-08 at 17:12 -0400, Paul Moore wrote:
> > > > > On Thu, Aug 8, 2024 at 1:11=E2=80=AFPM Jan Kara <jack@suse.cz> wr=
ote:
> > > > > > On Thu 08-08-24 12:36:07, Christian Brauner wrote:
> > > > > > > On Wed, Aug 07, 2024 at 10:36:58AM GMT, Jeff Layton
> > > > > > > wrote:
> > > > > > > > On Wed, 2024-08-07 at 16:26 +0200, Christian Brauner
> > > > > > > > wrote:
> > > > > > > > > > +static struct dentry *lookup_fast_for_open(struct
> > > > > > > > > > nameidata *nd, int open_flag)
> > > > > > > > > > +{
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *de=
ntry;
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (open_flag & O=
_CREAT) {
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Don't bother on an O_EXCL create
> > > > > > > > > > */
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (open_flag & O_EXCL)
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return NULL;
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * FIXME: If auditing is enabled,
> > > > > > > > > > then we'll have to unlazy to
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use the dentry. For now, don't
> > > > > > > > > > do this, since it shifts
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * contention from parent's i_rwsem
> > > > > > > > > > to its d_lockref spinlock.
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Reconsider this once dentry
> > > > > > > > > > refcounting handles heavy
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * contention better.
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((nd->flags & LOOKUP_RCU) &&
> > > > > > > > > > !audit_dummy_context())
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return NULL;
> > > > > > > > >=20
> > > > > > > > > Hm, the audit_inode() on the parent is done
> > > > > > > > > independent of whether the
> > > > > > > > > file was actually created or not. But the
> > > > > > > > > audit_inode() on the file
> > > > > > > > > itself is only done when it was actually created.
> > > > > > > > > Imho, there's no need
> > > > > > > > > to do audit_inode() on the parent when we immediately
> > > > > > > > > find that file
> > > > > > > > > already existed. If we accept that then this makes
> > > > > > > > > the change a lot
> > > > > > > > > simpler.
> > > > > > > > >=20
> > > > > > > > > The inconsistency would partially remain though. When
> > > > > > > > > the file doesn't
> > > > > > > > > exist audit_inode() on the parent is called but by
> > > > > > > > > the time we've
> > > > > > > > > grabbed the inode lock someone else might already
> > > > > > > > > have created the file
> > > > > > > > > and then again we wouldn't audit_inode() on the file
> > > > > > > > > but we would have
> > > > > > > > > on the parent.
> > > > > > > > >=20
> > > > > > > > > I think that's fine. But if that's bothersome the
> > > > > > > > > more aggressive thing
> > > > > > > > > to do would be to pull that audit_inode() on the
> > > > > > > > > parent further down
> > > > > > > > > after we created the file. Imho, that should be
> > > > > > > > > fine?...
> > > > > > > > >=20
> > > > > > > > > See
> > > > > > > > > https://gitlab.com/brauner/linux/-/commits/vfs.misc.jeff/=
?ref_type=3Dheads
> > > > > > > > > for a completely untested draft of what I mean.
> > > > > > > >=20
> > > > > > > > Yeah, that's a lot simpler. That said, my experience
> > > > > > > > when I've worked
> > > > > > > > with audit in the past is that people who are using it
> > > > > > > > are _very_
> > > > > > > > sensitive to changes of when records get emitted or
> > > > > > > > not. I don't like
> > > > > > > > this, because I think the rules here are ad-hoc and
> > > > > > > > somewhat arbitrary,
> > > > > > > > but keeping everything working exactly the same has
> > > > > > > > been my MO whenever
> > > > > > > > I have to work in there.
> > > > > > > >=20
> > > > > > > > If a certain access pattern suddenly generates a
> > > > > > > > different set of
> > > > > > > > records (or some are missing, as would be in this
> > > > > > > > case), we might get
> > > > > > > > bug reports about this. I'm ok with simplifying this
> > > > > > > > code in the way
> > > > > > > > you suggest, but we may want to do it in a patch on top
> > > > > > > > of mine, to
> > > > > > > > make it simple to revert later if that becomes
> > > > > > > > necessary.
> > > > > > >=20
> > > > > > > Fwiw, even with the rearranged checks in v3 of the patch
> > > > > > > audit records
> > > > > > > will be dropped because we may find a positive dentry but
> > > > > > > the path may
> > > > > > > have trailing slashes. At that point we just return
> > > > > > > without audit
> > > > > > > whereas before we always would've done that audit.
> > > > > > >=20
> > > > > > > Honestly, we should move that audit event as right now
> > > > > > > it's just really
> > > > > > > weird and see if that works. Otherwise the change is
> > > > > > > somewhat horrible
> > > > > > > complicating the already convoluted logic even more.
> > > > > > >=20
> > > > > > > So I'm appending the patches that I have on top of your
> > > > > > > patch in
> > > > > > > vfs.misc. Can you (other as well ofc) take a look and
> > > > > > > tell me whether
> > > > > > > that's not breaking anything completely other than later
> > > > > > > audit events?
> > > > > >=20
> > > > > > The changes look good as far as I'm concerned but let me CC
> > > > > > audit guys if
> > > > > > they have some thoughts regarding the change in generating
> > > > > > audit event for
> > > > > > the parent. Paul, does it matter if open(O_CREAT) doesn't
> > > > > > generate audit
> > > > > > event for the parent when we are failing open due to
> > > > > > trailing slashes in
> > > > > > the pathname? Essentially we are speaking about moving:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 audit_inode(nd->name=
, dir, AUDIT_INODE_PARENT);
> > > > > >=20
> > > > > > from open_last_lookups() into lookup_open().
> > > > >=20
> > > > > Thanks for adding the audit mailing list to the CC, Jan.=C2=A0 I
> > > > > would ask
> > > > > for others to do the same when discussing changes that could
> > > > > impact
> > > > > audit (similar requests for the LSM framework, SELinux,
> > > > > etc.).
> > > > >=20
> > > > > The inode/path logging in audit is ... something.=C2=A0 I have a
> > > > > longstanding todo item to go revisit the audit inode logging,
> > > > > both to
> > > > > fix some known bugs, and see what we can improve (I'm
> > > > > guessing quite a
> > > > > bit).=C2=A0 Unfortunately, there is always something else which i=
s
> > > > > burning
> > > > > a little bit hotter and I haven't been able to get to it yet.
> > > > >=20
> > > >=20
> > > > It is "something" alright. The audit logging just happens at
> > > > strange
> > > > and inconvenient times vs. what else we're trying to do wrt
> > > > pathwalking
> > > > and such. In particular here, the fact __audit_inode can block
> > > > is what
> > > > really sucks.
> > > >=20
> > > > Since we're discussing it...
> > > >=20
> > > > ISTM that the inode/path logging here is something like a
> > > > tracepoint.
> > > > In particular, we're looking to record a specific set of
> > > > information at
> > > > specific points in the code. One of the big differences between
> > > > them
> > > > however is that tracepoints don't block.=C2=A0 The catch is that we
> > > > can't
> > > > just drop messages if we run out of audit logging space, so
> > > > that would
> > > > have to be handled reasonably.
> > >=20
> > > Yes, the buffer allocation is the tricky bit.=C2=A0 Audit does
> > > preallocate
> > > some structs for tracking names which ideally should handle the
> > > vast
> > > majority of the cases, but yes, we need something to handle all
> > > of the
> > > corner cases too without having to resort to audit_panic().
> > >=20
> > > > I wonder if we could leverage the tracepoint infrastructure to
> > > > help us
> > > > record the necessary info somehow? Copy the records into a
> > > > specific
> > > > ring buffer, and then copy them out to the audit infrastructure
> > > > in
> > > > task_work?
> > >=20
> > > I believe using task_work will cause a number of challenges for
> > > the
> > > audit subsystem as we try to bring everything together into a
> > > single
> > > audit event.=C2=A0 We've had a lot of problems with io_uring doing
> > > similar
> > > things, some of which are still unresolved.
> > >=20
> > > > I don't have any concrete ideas here, but the path/inode audit
> > > > code has
> > > > been a burden for a while now and it'd be good to think about
> > > > how we
> > > > could do this better.
> > >=20
> > > I've got some grand ideas on how to cut down on a lot of our
> > > allocations and string generation in the critical path, not just
> > > with
> > > the inodes, but with audit records in general.=C2=A0 Sadly I just
> > > haven't
> > > had the time to get to any of it.
> > >=20
> > > > > The general idea with audit is that you want to record the
> > > > > information
> > > > > both on success and failure.=C2=A0 It's easy to understand the
> > > > > success
> > > > > case, as it is a record of what actually happened on the
> > > > > system, but
> > > > > you also want to record the failure case as it can provide
> > > > > some
> > > > > insight on what a process/user is attempting to do, and that
> > > > > can be
> > > > > very important for certain classes of users.=C2=A0 I haven't dug
> > > > > into the
> > > > > patches in Christian's tree, but in general I think Jeff's
> > > > > guidance
> > > > > about not changing what is recorded in the audit log is
> > > > > probably good
> > > > > advice (there will surely be exceptions to that, but it's
> > > > > still good
> > > > > guidance).
> > > > >=20
> > > >=20
> > > > In this particular case, the question is:
> > > >=20
> > > > Do we need to emit a AUDIT_INODE_PARENT record when opening an
> > > > existing
> > > > file, just because O_CREAT was set? We don't emit such a record
> > > > when
> > > > opening without O_CREAT set.
> > >=20
> > > I'm not as current on the third-party security requirements as I
> > > used
> > > to be, but I do know that oftentimes when a file is created the
> > > parent
> > > directory is an important bit of information to have in the audit
> > > log.
> > >=20
> >=20
> > Right. We'd still have that here since we have to unlazy to
> > actually
> > create the file.
> >=20
> > The question here is about the case where O_CREAT is set, but the
> > file
> > already exists. Nothing is being created in that case, so do we
> > need to
> > emit an audit record for the parent?
>=20
> As long as the full path information is present in the existing
> file's
> audit record it should be okay.
>=20

O_CREAT is ignored when the dentry already exists, so doing the same
thing that we do when O_CREAT isn't set seems reasonable.

We do call this in do_open, which would apply in this case:

        if (!(file->f_mode & FMODE_CREATED))
                audit_inode(nd->name, nd->path.dentry, 0);

That should have the necessary path info. If that's the case, then I
think Christian's cleanup series on top of mine should be OK. I think
that the only thing that would be missing is the AUDIT_INODE_PARENT
record for the directory in the case where the dentry already exists,
which should be superfluous.

ISTR that Red Hat has a pretty extensive testsuite for audit. We might
want to get them to run their tests on Christian's changes to be sure
there are no surprises, if they are amenable.
--=20
Jeff Layton <jlayton@kernel.org>

