Return-Path: <linux-fsdevel+bounces-40640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995CA2619E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25E17A2D78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A41E20CCC5;
	Mon,  3 Feb 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Or4dK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658720B808;
	Mon,  3 Feb 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604557; cv=none; b=lZM81uPd72XH6qHzTMYHI1e+ZT8U/ZOY9jHQedtMFwVDXWcVlp/BuOrrWSBoH3Ftib1bmyyG9VdcBaXyhJD6VPBOsa+mwyUiMZ6sD/KFmvyKgW+ao4USgOmeDZ6qfBcnNNucMWMWYW/yFrVU/kcrbfBvalfpoBbDHYULDHp02s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604557; c=relaxed/simple;
	bh=w8+HSJk4xltd50d3lEfUpCcmRQ0282WxjoW1Xh2epvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqKjZPI8T2ds4flqcz/m/bZ1nBVSMqqe3adwE5xX+jLrarnqUSkf+YZFaNhs3WrSnJBLkis6sSeyYVjhShZt/hvkZ6OUM8jebTKr3KBw5mwFqsbVUxXOvNr38QGi+lXRsME9ymJZ22RIEh7Q9CaLb4B6Kbl/nX0mugvHeosNjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Or4dK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1779C4CED2;
	Mon,  3 Feb 2025 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738604556;
	bh=w8+HSJk4xltd50d3lEfUpCcmRQ0282WxjoW1Xh2epvc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z6Or4dK5+lTYqhvb5utVEOAIhB/pz1jAoJrGAFBvuQS8REQ1EH5Yq6lKjapycTVD7
	 GyTkfPWWHx+bN8zeCHHiJM+1QyvzvaSMe8CnyYioTEaeZZsJlVfygMuAS2/kfDBn35
	 su+Loic4LT7mQj9VvNQvRyItWqe0K+OhrrbeMHrrZ3sQQzl8Rhxa8cdnxxmTtf9QMI
	 kn8Zn7QJZTbw7oWMNNW75D0abDGDmyJTHrebc4wFT8J4q3O8Bog6UgM3v7lOBqmcQ5
	 ZKQpQie0t3REzuk3rm7F/G6HLyBwtBfwjzMwUnFuRHPLR2aY9BTEC7slLZAP4+QSuI
	 EilmUSZzIZCXQ==
Message-ID: <115733465f444bd127c5a0a1db1215980b4607c9.camel@kernel.org>
Subject: Re: [PATCH] fuse: add a new "connections" file to show longest
 waiting reqeust
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Feb 2025 12:42:34 -0500
In-Reply-To: <CAJnrk1Zz+QHVctL61bXwaoY4b3DFVJ+PvKw6Qq6_D=MvBQoD+w@mail.gmail.com>
References: <20250203-fuse-sysfs-v1-1-36faa01f2338@kernel.org>
	 <CAJnrk1Zz+QHVctL61bXwaoY4b3DFVJ+PvKw6Qq6_D=MvBQoD+w@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-03 at 09:31 -0800, Joanne Koong wrote:
> On Mon, Feb 3, 2025 at 8:37=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > Add a new file to the "connections" directory that shows how long (in
> > seconds) the oldest fuse_req in the processing hash or pending queue ha=
s
> > been waiting.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > This is based on top of Joanne's work, as it requires the "create_time"
> > field in fuse_req.  We have some internal detection of hung fuse server
> > processes that relies on seeing elevated values in the "waiting" sysfs
> > file. The problem with that method is that it can't detect when highly
> > serialized workloads on a FUSE mount are hung. This adds another metric
> > that we can use to detect when fuse mounts are hung.
> > ---
> >  fs/fuse/control.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/fuse/fuse_i.h  |  2 +-
> >  2 files changed, 57 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..b213db11a2d7d85c4403baa=
61f9f7850fed150a8 100644
> > --- a/fs/fuse/control.c
> > +++ b/fs/fuse/control.c
> > @@ -180,6 +180,55 @@ static ssize_t fuse_conn_congestion_threshold_writ=
e(struct file *file,
> >         return ret;
> >  }
> >=20
> > +/* Show how long (in s) the oldest request has been waiting */
> > +static ssize_t fuse_conn_oldest_read(struct file *file, char __user *b=
uf,
> > +                                     size_t len, loff_t *ppos)
> > +{
> > +       char tmp[32];
> > +       size_t size;
> > +       unsigned long oldest =3D jiffies;
> > +
> > +       if (!*ppos) {
> > +               struct fuse_conn *fc =3D fuse_ctl_file_conn_get(file);
> > +               struct fuse_iqueue *fiq =3D &fc->iq;
> > +               struct fuse_dev *fud;
> > +               struct fuse_req *req;
> > +
> > +               if (!fc)
> > +                       return 0;
> > +
> > +               spin_lock(&fc->lock);
> > +               list_for_each_entry(fud, &fc->devices, entry) {
> > +                       struct fuse_pqueue *fpq =3D &fud->pq;
> > +                       int i;
> > +
> > +                       spin_lock(&fpq->lock);
> > +                       for (i =3D 0; i < FUSE_PQ_HASH_SIZE; i++) {
> > +                               if (list_empty(&fpq->processing[i]))
> > +                                       continue;
> > +                               /*
> > +                                * Only check the first request in the =
queue. The
> > +                                * assumption is that the one at the he=
ad of the list
> > +                                * will always be the oldest.
> > +                                */
> > +                               req =3D list_first_entry(&fpq->processi=
ng[i], struct fuse_req, list);
>=20
> This probably doesn't matter in actuality, but maybe
> list_first_entry_or_null() on fpq->processing[i] would be more optimal
> here than "list_empty()" and "list_first_entry()" since that'll
> minimize the number of READ_ONCE() calls we'd need to do.
>=20

I don't think the above will do more than one READ_ONCE, but I agree
that list_first_entry_or_null() is more idiomatic. I'll switch to that.

> > +                               if (req->create_time < oldest)
> > +                                       oldest =3D req->create_time;
> > +                       }
> > +                       spin_unlock(&fpq->lock);
> > +               }
> > +               if (!list_empty(&fiq->pending)) {
>=20
> I think we'll need to grab the fiq->lock here first before checking fiq->=
pending
>=20

Doh! Will fix.

> > +                       req =3D list_first_entry(&fiq->pending, struct =
fuse_req, list);
> > +                       if (req->create_time < oldest)
> > +                               oldest =3D req->create_time;
> > +               }
> > +               spin_unlock(&fc->lock);
> > +               fuse_conn_put(fc);
> > +       }
> > +       size =3D sprintf(tmp, "%ld\n", (jiffies - oldest)/HZ);
>=20
> If there are no requests, I think this will still return a non-zero
> value since jiffies is a bit more than what the last "oldest =3D
> jiffies" was, which might be confusing. Maybe we should just return 0
> in this case?
>=20
>=20

You should only see a non-zero value in that case if it takes more than
a second to walk the hash. Possible, but pretty unlikely.


> > +       return simple_read_from_buffer(buf, len, ppos, tmp, size);
> > +}
> > +
> >  static const struct file_operations fuse_ctl_abort_ops =3D {
> >         .open =3D nonseekable_open,
> >         .write =3D fuse_conn_abort_write,
> > @@ -202,6 +251,11 @@ static const struct file_operations fuse_conn_cong=
estion_threshold_ops =3D {
> >         .write =3D fuse_conn_congestion_threshold_write,
> >  };
> >=20
> > +static const struct file_operations fuse_ctl_oldest_ops =3D {
> > +       .open =3D nonseekable_open,
> > +       .read =3D fuse_conn_oldest_read,
> > +};
> > +
> >  static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
> >                                           struct fuse_conn *fc,
> >                                           const char *name,
> > @@ -264,6 +318,8 @@ int fuse_ctl_add_conn(struct fuse_conn *fc)
> >=20
> >         if (!fuse_ctl_add_dentry(parent, fc, "waiting", S_IFREG | 0400,=
 1,
> >                                  NULL, &fuse_ctl_waiting_ops) ||
> > +           !fuse_ctl_add_dentry(parent, fc, "oldest", S_IFREG | 0400, =
1,
> > +                                NULL, &fuse_ctl_oldest_ops) ||
> >             !fuse_ctl_add_dentry(parent, fc, "abort", S_IFREG | 0200, 1=
,
> >                                  NULL, &fuse_ctl_abort_ops) ||
> >             !fuse_ctl_add_dentry(parent, fc, "max_background", S_IFREG =
| 0600,
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index dcc1c327a0574b1fd1adda4b7ca047aa353b6a0a..b46c26bc977ad2d75d10fb3=
06d3ecc4caf2c53bd 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -42,7 +42,7 @@
> >  #define FUSE_NAME_MAX 1024
> >=20
> >  /** Number of dentries for each connection in the control filesystem *=
/
> > -#define FUSE_CTL_NUM_DENTRIES 5
> > +#define FUSE_CTL_NUM_DENTRIES 6
> >=20
> >  /* Frequency (in seconds) of request timeout checks, if opted into */
> >  #define FUSE_TIMEOUT_TIMER_FREQ 15
> >=20
> > ---
> > base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
> > change-id: 20250203-fuse-sysfs-ce351d105cf0
> >=20
> > Best regards,
> > --
> > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

