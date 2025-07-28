Return-Path: <linux-fsdevel+bounces-56114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9AAB132AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 02:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AA43B7C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 00:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822886342;
	Mon, 28 Jul 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9am8BK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076027082A;
	Mon, 28 Jul 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753663297; cv=none; b=h6T/WVrQaAWoyyhxD696Tbfe56nn7n3bMPGByWdguDZDhLfaTQENHrwHdPmrZl6HmSDFtUL4BMS72IuZ/O/kj6pLhW+RscyUTcvvtnvyIhgTTNfGsccmC3mHaUPrF1oOM9w0GyP7kSmrWEcBqxQIpKXKn7Zp9RMnD0QE+8lEB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753663297; c=relaxed/simple;
	bh=UZkETwY5e1S8Xe8SRngsFTFPMTp9hDopIH7DN/5V980=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NaCgOsLakQ1VhNdQty6BXGVpMUJOs/sGbnKXGXnCuDl4cE5U97c3sMWA/O2DX8XEV6h47Wz2lQdilrIZUL14u+LnZ9txxrDKW3Tr+u29MRN/hj6E9wRLbFZGxELgbBSQlv29Ts4C6EJzpVOoRICvalSYPcpLSgfxB9G1RvfuMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9am8BK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E00EC4CEEB;
	Mon, 28 Jul 2025 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753663296;
	bh=UZkETwY5e1S8Xe8SRngsFTFPMTp9hDopIH7DN/5V980=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L9am8BK/qj77d0JZZ54oifmK5RjBS7Ui3iWN4WZwotTgusRLi9gaFMqJQ4/DC6Cmr
	 HykWygYvjsqzUzMV1j+Z7IuS/ePbwVT33M/+JTSHSYt5hrQgdf5zjo4Z9PDg/1Q8Ap
	 6xK9VdfbvZxrTCgI/lPCXYbbuDesIqc2hyomqUqqCLfiSDms845kpbPpSwcshkudhG
	 f3c51H4A1K86DwTU9HsL2WxYXaQjRftWQjIjN7BHkMjnwIqEM0uzE52FWwCinryRR3
	 vVNl8yp5C8/CZ9iZyPOzh/nq+kFC7smYtc9vtLoxHGXvzdYsnl6FKOgvlzMXAR9MxP
	 fOLOL0HtIgDQw==
Message-ID: <3d02578c8fa2c6b17d4fde12af328d0b5f93ca5e.camel@kernel.org>
Subject: Re: [PATCH v3 3/8] vfs: add ATTR_CTIME_SET flag
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Steven Rostedt	
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever
 <chuck.lever@oracle.com>, Olga Kornievskaia	 <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Trond Myklebust
 <trondmy@hammerspace.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	linux-nfs@vger.kernel.org
Date: Sun, 27 Jul 2025 20:41:34 -0400
In-Reply-To: <175366106815.2234665.13768447223879357240@noble.neil.brown.name>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
	, <20250727-nfsd-testing-v3-3-8dc2aafb166d@kernel.org>
	 <175366106815.2234665.13768447223879357240@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-28 at 10:04 +1000, NeilBrown wrote:
> On Mon, 28 Jul 2025, Jeff Layton wrote:
> > When ATTR_ATIME_SET and ATTR_MTIME_SET are set in the ia_valid mask, th=
e
> > notify_change() logic takes that to mean that the request should set
> > those values explicitly, and not override them with "now".
> >=20
> > With the advent of delegated timestamps, similar functionality is neede=
d
> > for the ctime. Add a ATTR_CTIME_SET flag, and use that to indicate that
> > the ctime should be accepted as-is. Also, clean up the if statements to
> > eliminate the extra negatives.
>=20
> I don't feel entirely comfortable with this.  ctime is a fallback for
> "has anything changed" - mtime can be changed but ctime is always
> reliable, controlled by VFS and FS.
>=20
> Until now.
>=20

I know. I have many of the same reservations, but the specification is
pretty clear (now that I understand it better). I don't see a better
way to do this.

> I know you aren't exposing this to user-space, but then not doing so
> blocks user-space file servers from using this functionality.
>=20
> I see that you also move vetting of the value out of vfs code and into
> nfsd code.  I don't really understand why you did that.  Maybe nfsd has
> more information about previous timestamps than the vfs has?
>=20

Yes. We need to track the timestamps of the inode at the time that the
delegation was handed out. nfsd is (arguably) in a better position to
do this than the VFS is. Patch #5 adds this functionality.

> Anyway I would much prefer that ATTR_CTIME_SET could only change the
> ctime value to something between the old ctime value and the current
> time (inclusive).
>=20

That will be a problem. What you're suggesting is the current status
quo with the delegated attrs code, and that behavior was the source of
the problems that we were seeing in the git regression testsuite.


When git checks out an object, it opens a file, writes to it and then
stats it so that it can later see whether it changed. If it gets a
WRITE_ATTRS_DELEG delegation, the client doesn't wait on writeback
before returning from that stat().

Then later, we go to do writeback. The mtime and ctime on the server
get set to the server's local time (which is later than the time that
git has recorded). Finally, the client does the SETATTR+DELEGRETURN and
tries to set the timestamps to the same times that git has recorded,
but those times are too early vs. the current timestamps on the file
and they get ignored (in accordance with the spec).

This was the source of my confusion with the spec. When it says
"original time", it means the timestamps at the time that the
delegation was created, but I interpreted it the same way you did.

Unfortunately, if we want to do this, then we have to allow nfsd to set
the ctime to a time earlier than the current ctime on the inode. I too
have some reservations with this. This means that applications on the
server may see the ctime go backward, which I really do not like.=C2=A0

In practice though, if there is an outstanding delegation then those
applications can't do anything other than stat() the file without
causing it to be recalled. They can't have the file open at the time,
and can't do any directory operations that involve it. Given that, I
think the ctime rollbacks are "mostly harmless".=20

Moving these checks into the VFS would be pretty ugly, unless we want
to tightly integrate the setattr and lease handling code. nfsd is just
in a much better position to track and vet this info than the VFS.

> Certainly nfsd might impose extra restrictions, but I think that basic
> restriction should by in the VFS close to what ATTR_CTIME_SET is
> honoured.  What way if someone else finds another use for it some day
> they will have to work within the same restriction (or change it
> explicitly and try to justify that change).
>=20
> Lustre has the equivalent of ATTR_CTIME_SET (MFS_ATTR_CTIME_SET and
> LA_CTIME) and would want to use it if the server-side code ever landed
> upstream.  It appears to just assume the client sent a valid timestamp.
> I would rather it were vetted by the VFS.
>

Interesting. I don't think they have any immediate plans to upstream
the server (the priority is the client), but having this functionality
in the VFS would make it easier to integrate.

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/attr.c          | 15 +++++++++------
> >  include/linux/fs.h |  1 +
> >  2 files changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/attr.c b/fs/attr.c
> > index 9caf63d20d03e86c535e9c8c91d49c2a34d34b7a..f0dabd2985989d283a93153=
6a5fc53eda366b373 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -463,15 +463,18 @@ int notify_change(struct mnt_idmap *idmap, struct=
 dentry *dentry,
> > =20
> >  	now =3D current_time(inode);
> > =20
> > -	attr->ia_ctime =3D now;
> > -	if (!(ia_valid & ATTR_ATIME_SET))
> > -		attr->ia_atime =3D now;
> > -	else
> > +	if (ia_valid & ATTR_ATIME_SET)
> >  		attr->ia_atime =3D timestamp_truncate(attr->ia_atime, inode);
> > -	if (!(ia_valid & ATTR_MTIME_SET))
> > -		attr->ia_mtime =3D now;
> >  	else
> > +		attr->ia_atime =3D now;
> > +	if (ia_valid & ATTR_CTIME_SET)
> > +		attr->ia_ctime =3D timestamp_truncate(attr->ia_ctime, inode);
> > +	else
> > +		attr->ia_ctime =3D now;
> > +	if (ia_valid & ATTR_MTIME_SET)
> >  		attr->ia_mtime =3D timestamp_truncate(attr->ia_mtime, inode);
> > +	else
> > +		attr->ia_mtime =3D now;
> > =20
> >  	if (ia_valid & ATTR_KILL_PRIV) {
> >  		error =3D security_inode_need_killpriv(dentry);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 040c0036320fdf87a2379d494ab408a7991875bd..f18f45e88545c39716b917b=
1378fb7248367b41d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -237,6 +237,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff=
_t offset,
> >  #define ATTR_ATIME_SET	(1 << 7)
> >  #define ATTR_MTIME_SET	(1 << 8)
> >  #define ATTR_FORCE	(1 << 9) /* Not a change, but a change it */
> > +#define ATTR_CTIME_SET	(1 << 10)
> >  #define ATTR_KILL_SUID	(1 << 11)
> >  #define ATTR_KILL_SGID	(1 << 12)
> >  #define ATTR_FILE	(1 << 13)
> >=20
> > --=20
> > 2.50.1
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

