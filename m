Return-Path: <linux-fsdevel+bounces-22367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8B916B02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9D9B267ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A3316E89E;
	Tue, 25 Jun 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg1wZLMI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DE16D4F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327060; cv=none; b=CR/Xc1S19xFO6CaOPBT5Mo4H3tBFluOxB0HFrVfBqEhfpx+vH6AxB/V5EJWWaPuWbDLehITRwky4bJN8CPNHjfKb1DN8Pr6xVRlxjWfw59jeo0xyWRAwWSq1y1SH6nWfEjqfWf323Aj7rC8xuFkC3fL9OrTk9sP7thDWYqrpSSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327060; c=relaxed/simple;
	bh=uB851uHl5zL7gOn3qL/TRpyATmASFUOK4v5Tgo8/w7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITtNoGl5hif3kmaH7Z+Cfs+rwiTkjHSnIe1x9x78FalCP5SILwxAmjUzsmGVsrWzZvdahz43hd2tK7esu3UbYkTaM0k1Aci1bui4q5Cpz93fWLofK6mpLJ4b2UQSsOYSFN0UsYu7VbrHtAP85iv5tCSweXVXzQrbvPB9MDZbYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg1wZLMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3446C32781;
	Tue, 25 Jun 2024 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327059;
	bh=uB851uHl5zL7gOn3qL/TRpyATmASFUOK4v5Tgo8/w7I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Fg1wZLMIbVto1rchCC6XcfbeJy5KjFqfSQNQy7QO74kfiL3hzxia7NkjKyLv9gSI1
	 myOqTki316VMegyK0Fd+4KznwTAG2ES80eRsp8lmFlYTW1vXk1tiDlBfLYw5ZpYBSL
	 ooaMJC5gdVwdemQP+KnuWUFEK6cqo3nLgzchXImJjNP1l/hWjjB7uOt9no9XBjPqAR
	 qp7cGuzEdNo7zJQjsBlZIiVkCVHn7kHJR4vS+g8TFFihMlkoSTKKb5U6ZOQmBMaaAV
	 YaMS2969R4xOuTTHPKXXUtVER3F8hm0G/Gn7THRiRL8PpGU8C227llTBczHI8kitRG
	 2SdUnTwpPNt5g==
Message-ID: <1833a18f7935aed5df264ed295d1084672234541.camel@kernel.org>
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Date: Tue, 25 Jun 2024 10:50:57 -0400
In-Reply-To: <20240625-darunter-wieweit-9ced87b1df0b@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
	 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
	 <14330f15065f92a88c7c0364cba3e26c294293a4.camel@kernel.org>
	 <20240625-darunter-wieweit-9ced87b1df0b@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 16:21 +0200, Christian Brauner wrote:
> On Tue, Jun 25, 2024 at 10:10:29AM GMT, Jeff Layton wrote:
> > On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> > > In order to utilize the listmount() and statmount() extensions that
> > > allow us to call them on different namespaces we need a way to get
> > > the
> > > mnt namespace id from user space.=C2=A0 Add an ioctl to nsfs that wil=
l
> > > allow
> > > us to extract the mnt namespace id in order to make these new
> > > extensions
> > > usable.
> > >=20
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > > =C2=A0fs/nsfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
> > > =C2=A0include/uapi/linux/nsfs.h |=C2=A0 2 ++
> > > =C2=A02 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > > index 07e22a15ef02..af352dadffe1 100644
> > > --- a/fs/nsfs.c
> > > +++ b/fs/nsfs.c
> > > @@ -12,6 +12,7 @@
> > > =C2=A0#include <linux/nsfs.h>
> > > =C2=A0#include <linux/uaccess.h>
> > > =C2=A0
> > > +#include "mount.h"
> > > =C2=A0#include "internal.h"
> > > =C2=A0
> > > =C2=A0static struct vfsmount *nsfs_mnt;
> > > @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned
> > > int ioctl,
> > > =C2=A0		argp =3D (uid_t __user *) arg;
> > > =C2=A0		uid =3D from_kuid_munged(current_user_ns(), user_ns-
> > > > owner);
> > > =C2=A0		return put_user(uid, argp);
> > > +	case NS_GET_MNTNS_ID: {
> > > +		struct mnt_namespace *mnt_ns;
> > > +		__u64 __user *idp;
> > > +		__u64 id;
> > > +
> > > +		if (ns->ops->type !=3D CLONE_NEWNS)
> > > +			return -EINVAL;
> > > +
> > > +		mnt_ns =3D container_of(ns, struct mnt_namespace, ns);
> > > +		idp =3D (__u64 __user *)arg;
> > > +		id =3D mnt_ns->seq;
> > > +		return put_user(id, idp);
> > > +	}
> > > =C2=A0	default:
> > > =C2=A0		return -ENOTTY;
> > > =C2=A0	}
> > > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > > index a0c8552b64ee..56e8b1639b98 100644
> > > --- a/include/uapi/linux/nsfs.h
> > > +++ b/include/uapi/linux/nsfs.h
> > > @@ -15,5 +15,7 @@
> > > =C2=A0#define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> > > =C2=A0/* Get owner UID (in the caller's user namespace) for a user
> > > namespace */
> > > =C2=A0#define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > > +/* Get the id for a mount namespace */
> > > +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
> > > =C2=A0
> > > =C2=A0#endif /* __LINUX_NSFS_H */
> >=20
> > Thinking about this more...
> >=20
> > Would it also make sense to wire up a similar ioctl in pidfs? It seems
> > like it might be nice to just open a pidfd for pid and then issue the
> > above to get its mntns id, rather than having to grovel around in nsfs.
>=20
> I had a different idea yesterday: get a mount namespace fd from a pidfd
> in fact, get any namespace fd based on a pidfd. It's the equivalent to:
> /proc/$pid/ns* and then you can avoid having to go via procfs at all.

That would work too. I'd specifically like to be able to avoid crawling
around in /proc/<pid> as much as possible.

At this point, I think we're still stuck with having to walk /proc to
know what pids currently exist though, right? I don't think there is
any way to walk all the pids just using pidfds is there?

>=20
> Needs to be governed by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)=
.
>=20
> (We also need an ioctl() on the pidfd to get to the PID without procfs bt=
w.

A PIDFS_GET_PID ioctl seems like a reasonable thing to add.
--=20
Jeff Layton <jlayton@kernel.org>

