Return-Path: <linux-fsdevel+bounces-10266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5684994A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8F61C22805
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0052199BA;
	Mon,  5 Feb 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDwpVHTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C41AACB;
	Mon,  5 Feb 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134150; cv=none; b=bEqiP83/LEn1soAbmCD4s1ywkOLz208WG0UVqU56bxU+ezTkdPme3Tl/GMhlAMbCGdfWueH86l1MopclVINQaywVEMWxOZ5iITA4IVjxa49c2ZZfbOtCr/tBU5T3xa9NChjbiuhth5L3ES+L45Z9PkclL6elvyyzQEwZT9ki820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134150; c=relaxed/simple;
	bh=7sjnbi3Zqm0rqbTJviDtnwb4fVjVVWbZOQDGUhBayvE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IA1f2zryWl4GWgb535fO6fJSt8pK3xzlpEcXM3S6RqE9X3Uwotw6Eaw52ElbHtgd3irCkESixLu3YnLUAcgaLV5zI/NQM+EE/fTWC665UhTzHS0I2tUpGK74T3WozFKXLEQFX+p/NhF+x5NehRGJ2lrF33NA2OArcteEqxdmyT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDwpVHTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91B7C433C7;
	Mon,  5 Feb 2024 11:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134149;
	bh=7sjnbi3Zqm0rqbTJviDtnwb4fVjVVWbZOQDGUhBayvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iDwpVHTRayZ369Tuhd7arvj37VsW2w2ryV4TLG+76gbVdQVhFELSBlz0hUq3KBGUY
	 ZSCnn6SbOmfC17VZ0+xBc3pe1/W3Dhfuy/BdRtPI14LAG4yq4AnDJqEVb7zP28DbNu
	 3NsTXxAzd4RRJ5m7RDmM7tEJaa0i0P7mf5JX6CHDK6LUhrlqWIrcNfR1l7Uv7QNVuP
	 is/r+26lLOBooSps2noc0CL+npm4uBheHOBJyC78rWkW20cMYw5ZuI840nSrqj6XId
	 2Z0OPOGgWXW/ClDOBL3LzgnHyKqAgcdsU/K8lOa3CuU8U3tOptGArNHC9h3bYTYMiN
	 kMTyU5PhruBUQ==
Message-ID: <de77ec5ade7fac7e72445cb2d10d95efe8bf9c92.camel@kernel.org>
Subject: Re: [PATCH v3 04/47] filelock: add some new helper functions
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>,  David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>,  Ilya
 Dryomov <idryomov@gmail.com>, Alexander Aring <aahringo@redhat.com>, David
 Teigland <teigland@redhat.com>,  Andreas Gruenbacher <agruenba@redhat.com>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Mark
 Fasheh <mark@fasheh.com>,  Joel Becker <jlbec@evilplan.org>, Joseph Qi
 <joseph.qi@linux.alibaba.com>, Steve French <sfrench@samba.org>,  Paulo
 Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon
 <linkinjeon@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 ceph-devel@vger.kernel.org,  gfs2@lists.linux.dev,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org
Date: Mon, 05 Feb 2024 06:55:44 -0500
In-Reply-To: <20240205-wegschauen-unappetitlich-2b0926023605@brauner>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
	 <20240131-flsplit-v3-4-c6129007ee8d@kernel.org>
	 <20240205-wegschauen-unappetitlich-2b0926023605@brauner>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 12:36 +0100, Christian Brauner wrote:
> > diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> > index 085ff6ba0653..a814664b1053 100644
> > --- a/include/linux/filelock.h
> > +++ b/include/linux/filelock.h
> > @@ -147,6 +147,29 @@ int fcntl_setlk64(unsigned int, struct file *, uns=
igned int,
> > =A0int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
> > =A0int fcntl_getlease(struct file *filp);
> > =A0
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > +static inline bool lock_is_unlock(struct file_lock *fl)
> > +{
> > +	return fl->fl_type =3D=3D F_UNLCK;
> > +}
> > +
> > +static inline bool lock_is_read(struct file_lock *fl)
> > +{
> > +	return fl->fl_type =3D=3D F_RDLCK;
> > +}
> > +
> > +static inline bool lock_is_write(struct file_lock *fl)
> > +{
> > +	return fl->fl_type =3D=3D F_WRLCK;
> > +}
> > +
> > +static inline void locks_wake_up(struct file_lock *fl)
> > +{
> > +	wake_up(&fl->fl_wait);
> > +}
> > +
> > +/* for walking lists of file_locks linked by fl_list */
> > +#define for_each_file_lock(_fl, _head)	list_for_each_entry(_fl, _head,=
 fl_list)
> > +
>=20
> This causes a build warning for fs/ceph/ and fs/afs when
> !CONFIG_FILE_LOCKING. I'm about to fold the following diff into this
> patch. The diff looks a bit wonky but essentially I've moved
> lock_is_unlock(), lock_is_{read,write}(), locks_wake_up() and
> for_each_file_lock() out of the ifdef CONFIG_FILE_LOCKING:
>=20

I sent a patch for this problem yesterday. Did you not get it?


> diff --git a/include/linux/filelock.h b/include/linux/filelock.h
> index a814664b1053..62be9c6b1e59 100644
> --- a/include/linux/filelock.h
> +++ b/include/linux/filelock.h
> @@ -133,20 +133,6 @@ struct file_lock_context {
> =A0=A0=A0=A0=A0=A0=A0=A0struct list_head        flc_lease;
> =A0};
>=20
> -#ifdef CONFIG_FILE_LOCKING
> -int fcntl_getlk(struct file *, unsigned int, struct flock *);
> -int fcntl_setlk(unsigned int, struct file *, unsigned int,
> -                       struct flock *);
> -
> -#if BITS_PER_LONG =3D=3D 32
> -int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
> -int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> -                       struct flock64 *);
> -#endif
> -
> -int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
> -int fcntl_getlease(struct file *filp);
> -
> =A0static inline bool lock_is_unlock(struct file_lock *fl)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0return fl->fl_type =3D=3D F_UNLCK;
> @@ -170,6 +156,20 @@ static inline void locks_wake_up(struct file_lock *f=
l)
> =A0/* for walking lists of file_locks linked by fl_list */
> =A0#define for_each_file_lock(_fl, _head) list_for_each_entry(_fl, _head,=
 fl_list)
>=20
> +#ifdef CONFIG_FILE_LOCKING
> +int fcntl_getlk(struct file *, unsigned int, struct flock *);
> +int fcntl_setlk(unsigned int, struct file *, unsigned int,
> +                       struct flock *);
> +
> +#if BITS_PER_LONG =3D=3D 32
> +int fcntl_getlk64(struct file *, unsigned int, struct flock64 *);
> +int fcntl_setlk64(unsigned int, struct file *, unsigned int,
> +                       struct flock64 *);
> +#endif
> +
> +int fcntl_setlease(unsigned int fd, struct file *filp, int arg);
> +int fcntl_getlease(struct file *filp);
> +
> =A0/* fs/locks.c */
> =A0void locks_free_lock_context(struct inode *inode);
> =A0void locks_free_lock(struct file_lock *fl);
>=20

--=20
Jeff Layton <jlayton@kernel.org>

