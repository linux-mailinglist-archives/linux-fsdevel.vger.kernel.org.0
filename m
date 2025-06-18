Return-Path: <linux-fsdevel+bounces-52029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D593CADE982
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7059F167A5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD0286419;
	Wed, 18 Jun 2025 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAvdfn88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7A219E8;
	Wed, 18 Jun 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244519; cv=none; b=l5PjHaK+bzSqfMOCZtnFh5aNkCwn3nKqFA/N6NiEJKQRYqfX1ExQ1p/P/gbQsHkjNcoZcEixpD/WWsnpshoiDD0ZlHCZMnKpFsdm+OJPPEgzXqusUx7MAflBwInxkOCePxoMsKsIRD1qFDB6p5QWAE+u+rb7+1bP7ww1lWV/BSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244519; c=relaxed/simple;
	bh=h9/I3nrlPQariwUZfrtnu7LpZAl5DngQgOr++CUKMxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJj4VLSIH8cqIp5z9XVF04pgzP5OaEDIeBjBVW1jif0dmmLK4DmVSK05he1TxZwU5mqDjLovTV0REUFCmFnvEjrjENxGAlF4/36HHfGZJ8T7iBfEKBYdQW6YY3ruyygfUj6U5M7bqeP/aY6/r7/LE7cwnInyN5wo7/p7bt4uhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAvdfn88; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade76b8356cso1357952066b.2;
        Wed, 18 Jun 2025 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750244516; x=1750849316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9/I3nrlPQariwUZfrtnu7LpZAl5DngQgOr++CUKMxU=;
        b=IAvdfn8881IcNH5RB2stUywhK62rh/Wj3Lo78SVCl7g1gebusNQSsDg5hSUlhth43s
         oQadaXlpwzHEVq+6Z8ulXtEmX3zhmZyGuqzRn9wUWafWPM+fFWE4RO8ljzHxRRNZYGi3
         K6Wn+LGOPdAyWrmvI32TGzyqL11/uP73lfQpGQA0MsqQKjw2uDlRzAmASWMtREyThHlt
         m+yC0h960ijT9fopTgIfcK1yVxIPtpHXVOfaa3wseczNkQat5Z9TkHnMBVu+eo9soR1n
         M1XAousAUjUucezcGZzwHjIUSdeyQ2FFzUn8DFjDwJ1QhAGsxLOpzoqtiYz6WrviVk+b
         B0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750244516; x=1750849316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9/I3nrlPQariwUZfrtnu7LpZAl5DngQgOr++CUKMxU=;
        b=DZT5wdjCClLmYBWbkLcOjLfvNX0B21A2HwgTK6bqb3lJnDlJlZPxapLMwfOIvn74MY
         rq4cutpofpTBx9/nArYdqjqGenBTuagpDAj0Md71HpT4+47zmz3x/d2ccznR9HPO10wM
         7TfA0yl1QDR/1Ffz8uOuJzAIO1zplL6eYKtJcBcIwQ8Y3i6+3lHarcj1X4Ib4Jys25CI
         m3qfGNu++6yqpg17CG66ME6KHvgprQDRn9u8Kj+fgGqVBtqyYNdayC0l1ZW/Mb+zj0NB
         lukWP8gkY1QHoUqIw1JuVkxYKy6RM8Gqn7fPSyRCrH+kM/Iy69zmFuSMNsSAy3cUEFCd
         LfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzVhPX6D8+sNA1KPdgXjZijci+9ZIVRjThovFYMN+6dHcTaqZ75Q9j6Wj1e2uqWgF94d5mdNN4aQ9s9iGZ@vger.kernel.org, AJvYcCWyqs+XkrPvvXOxeWlxRRW93S7m/NPSAb3SDRmYwK74zIyRSFLvNofTD9bJLOD7/UQyji+kwg/WSaxE/1rt@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxORcoHVp+QTQjpVHli2NjRvk3/yRB1SbX7KjFzLycLJ7iMJR
	2E4h+0xy4B878IjM/fyycXGV1irHfho5NUDdlfqu3DFccskiBkRMMzxcu1sqZzcO4Azb34ylNNA
	kh3TTEviJWTKXM02ogZ4l2F6PNRfWnAswZmA8DCU=
X-Gm-Gg: ASbGncsTQbtyJluDtmtVM0KfTcOSj24Bdrtp9O6Vzwf5erIi/s9HU0i72NUpCYfC/Pq
	6SWQ8boOmGIPYUDw0fPR6PoUA44hIc6lG67M4swPgDqQwDYPkNzecGQgNqqwYXNXGgtWpQpZ6ib
	5mOU8C7Dlx9R/OoW5a2H8/K79spqnxTEuINEJTFAySdZY=
X-Google-Smtp-Source: AGHT+IEKtI8PcX1D79v67vC2jjYuHIlb9UuMWX/KVtnLMUKgldVeIFpe3vkjUwHvA96wjf7M+o1/kuCtqOd5E0aJzO0=
X-Received: by 2002:a17:907:d1b:b0:ade:17b0:9f48 with SMTP id
 a640c23a62f3a-adfad438459mr1688124366b.23.1750244515256; Wed, 18 Jun 2025
 04:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
In-Reply-To: <20250617221456.888231-1-paullawrence@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Jun 2025 13:01:44 +0200
X-Gm-Features: Ac12FXyYCn87um9zhV37U1p8liEd8GGdJB5TEHyQUKyQt08jYyzk84L90hwTdhA
Message-ID: <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I am very happy that you are getting back to this task
as I find myself never getting to it.

I would like to ask you to try to build on the code that was already
merged to the upstream kernel rather than trying to go back to
the out of tree version concepts.

I've added libfuse maintainer in CC, please remember to CC him
in future emails about proposed FUSE UAPI changes.

On Wed, Jun 18, 2025 at 12:15=E2=80=AFAM Paul Lawrence <paullawrence@google=
.com> wrote:
>
> This is the first part of a much larger patch set that would allow a dire=
ctory
> to be marked =E2=80=98passthrough=E2=80=99. At a high level, the fuse dae=
mon can return an
> optional extra argument to FUSE_LOOKUP that contains an fd.

What's wrong with returning a backing_id?
Why "reinvent" the pre-release wheel?

> Extra fields are
> added to the fuse_dentry, fuse_inode and fuse_file structs to have a back=
ing
> path, inode and file respectively. When fuse is performing an operation, =
it will
> check for the existence of a backing object and if it exists forward the
> operation to the backing object.

I read your patches and I have no idea why you needed to add fields to
fuse_dentry and why you needed to duplicate the backing file fields in
fuse_inode and fuse_file. Please explain yourself.

>
> These two patches add the core infrastructure, handling of the extra argu=
ment
> response to lookup, and forwarding open, flush and close to the backing f=
ile.
> This is sufficient to validate the concept.

What I am reading between the lines is that open/close are examples
of passthrough ops that are expected to be extended to more ops later.
Please see my WIP branch [1] for a suggestion to use an ops_mask API
for declaring which inode operations are passthrough.

[1] https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/

>
> The questions I have:
>
> * Is this something that interests the fuse maintainers and community?

Definitely interested in inode ops passthrough.
I am willing to help with review and implementation if needed.

> * Is this approach the correct one?

Which approach?

Miklos and I have been discussing setting up a backing file on
FUSE_LOOKUP for a while.
The same concept was discussed also for returning an iomap
description on FUSE_LOOKUP request [2]

[2] https://lore.kernel.org/linux-fsdevel/20250529164503.GB8282@frogsfrogsf=
rogs/

So yes, the concept of setting up passthough on lookup is the correct one.

One thing that you need to be aware of is that FUSE_LOOKUP is only one
of several ways to instantiate a fuse dentry/inode.

The commands FUSE_CREATE, FUSE_TMPFILE and FUSE_READDIRPLUS
also instantiate dentries and need to be dealt with as well.

Therefore, I was looking at the direction of extending struct fuse_entry_ou=
t
rather than adding a new argument to FUSE_LOOKUP.

> * (if we agree yes to 1 & 2) Detailed analysis of the patches for errors.
>
> A few observations:
>
> I have matched backing objects to their fuse objects. Currently fuse pass=
through
> puts a backing file into the fuse inode. I=E2=80=99m not quite sure why t=
his was done -
> it seems to have been a very late change in the passthrough patch sets wh=
ich
> happened without comment.

It was done to be able to have sane support for mmap passthrough among
other things and be able to have a sane story about inode attributes.

> It does not really make sense for full directory
> passthrough since unopened inodes still need to have backing inodes.

I do not understand this statement.
Why doesn't it make sense?
Why does it make sense to have a backing path per dentry?
Are you expecting to map different hardlink aliases to different backing in=
odes?
It might have helped if you had a design document explaining the reasoning
behind the implementation choices.

> The one
> advantage I can see is that it reduces the number of opens/closes of the =
backing
> file. However, this may also be a disadvantage - it moves closes, in part=
icular,
> to an arbitrary point when the inode is flushed from cache.
>

Rather than when? when dentry is flushed from cache?
I do not follow.

> Backing operations need to happen in the context of the daemon, not the c=
aller.

Correct.

> (I am a firm believer of this principle.) This is not yet implemented, an=
d is
> not (currently, and unfortunately) the way Android uses passthough. It is=
 not
> hard to do, and if these patches are otherwise acceptable, will be added.
>

Note that many of the passthrough method implementations were moved
to common "library" code for handling backing_file, which may or may not
be sharable with overlayfs.

I don't think that we need to have all passthough methods implemented in th=
e
generic backing_file "library" and share code with overlayfs, but we
should consider
it for new methods to see if it makes sense.

> There was a long discussion about the security issues of using an fd retu=
rned
> from the fuse daemon in the context of fuse passthrough, and the end solu=
tion
> was to use an ioctl to set the backing file. I have used the previously-r=
ejected
> approach of passing the fd in a struct in the fuse_daemon response. My de=
fense
> of this approach is
>
> * The fd is simply used to pull out the path and inode
> * All operations are revalidated
> * Thus there is no risk even if a privileged process with a protected fd =
is
> tricked into passing that fd back in this structure.

Not convinced.
Are you saying that passing an O_PATH fd of /etc/passwd is ok?
when that O_PATH is used to do passthrough open?
I do not follow and I also do not see the problem with sticking with
the already established backing_id and ioctl solution.

I would add that if you make your solution dependent on io_uring
then the security concern goes away, but you did not give a strong
enough reason to have this limitation IMO.

>
> I=E2=80=99m sure we will discuss this at length if this patch set is othe=
rwise deemed
> valuable, and I am certainly not wedded to this approach.
>
> I have written tests to validate this approach using tools/testing/selfte=
sts. I
> don=E2=80=99t want this patch set to get derailed by a discussion of the =
way I wrote the
> tests, so I have not included them. I am very open to any and every sugge=
stion
> as to how (and where) tests should be written for these patches.
>

Apart from specific function tests for passthrough, FUSE_PASSTHROUGH
was tested with fstests, using the scripts included in libfuse to run the
passthrough_hp examples in fstests.

So a basic sanity test for your code is that it does not regress fstests th=
at
are currently passing with passthrough_hp.

Please let me know if anything I wrote is not clear and if there is anythin=
g
else that I can help with.

Thanks,
Amir.

