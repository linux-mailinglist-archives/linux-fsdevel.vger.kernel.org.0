Return-Path: <linux-fsdevel+bounces-26322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711F795778C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 00:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A062846EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299551DF68A;
	Mon, 19 Aug 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXaoYmvG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66799158216;
	Mon, 19 Aug 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106977; cv=none; b=b5KpIVbd1I7BRnWvNoukgzE80P6ZE/5m/aQd7YrqffF2ezBAm+uLMbb+AbCBBQNm1Up9vJ3zeGjfNFwY2TD28X2lJIV+MnwmdNILpUq1vyyDmrMqK4LEkVoNa58zpYfoSH4yO2SpXFTUKBZmX+4u/0U2ZTdjPej0AdaAvdgn4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106977; c=relaxed/simple;
	bh=1G9aDsJMVAuDJ3cqhNDnd+KzVaMg5MGilUcivSbjYkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3Uw7lm0Fu4AJwOkoK73VJJfT2CLDG3F/fw4J9HNioayT9ZNVjuNnR5Sbpd/IUz8Yh77ICTFexapRBL38K8SDrErmwii4q6QIL8giCFX7ehWoS1Z1DzmHXentLqRpxENu9KrnilqkZwXVom1M+iwO7SG3R2PDDEuxKIQuVkVqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXaoYmvG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efa16aad9so6028681e87.0;
        Mon, 19 Aug 2024 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724106973; x=1724711773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++VCcm6FrNCS+6UytOZ4cKi7ezoRKCpG0F5c0Jp2cCk=;
        b=CXaoYmvGCKDjDuzfSLEzPfMVEN2SX4kEN2NNU1dOEtPvUrzIpGcuH77KZvoJ5KW79q
         bBdlbCv8jEUvNZz/hcGC94Ze2RnTK/R7u+hwVYzsJ/lBSjFoR/vgXbUQMa59Y+40Lodq
         50J/g5tqEpKPDk9QV8XtN3Y12fm0nG71GoNndc+qvLsd2NDrnXqY86Fn17hMAnHTdnxh
         9kZ2ldmDNnfO4s3qrBoz3OTgQi14Owr/EuHMovebhJ+AyoxivMkH42kjmJjjZjK4cySl
         QnxCk92itNGntQaaJ7Tu9CADy11kjSqJ5P6yDeQx064+KlU78v//8F+pChAlz+P6N0ER
         9OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106973; x=1724711773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++VCcm6FrNCS+6UytOZ4cKi7ezoRKCpG0F5c0Jp2cCk=;
        b=NfG+xi6h6C1tJ929zqCc8PFCDDLbE+o9cQenoHfZhdJlIKlMwJGPPLDfWmLmL3aP1e
         vN27SCIXLy4u/uvPcwklBTlkVUgutuzZ4dhVJK5nblIlybDjTXv2t05AelSBNweIlfg0
         VLQ+Uryr2rpLnp7rwRyoVsYqn9HeapzG04/zNTsgBnl79cEuT8JrLvVG58UGptNdUrnB
         J7eLRYd1U87N3oBR/rhmSblCApmIgzP2AFtKbqHOgbYVWa9kgZlQR9zHe+czI8e6e6r9
         BQMDnDVleWlm888HJ/hsgpFEFQs9jrqCz3zUHmOCB4mMsDIvQFgkKJ7JuwAoozOlBq0z
         aiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEwFjCOmWVZ+7jaKI6ooIQoqkmwm/9oH/Vf//Fp7a/QJBvbVWUSVqbxc15kgDGqvtuV7BtFUsqF7NjNm76MBRRbV0G0jpFAwtX0pyW8LsZZsZT+aB0mVmOAc/ldVLBl57cQ0dpb7GbOL7DoHAa8Q0em7q+3lE+HMRRbiwfxLnMJBx1q9Q+gCw=
X-Gm-Message-State: AOJu0YzXbFozrCb8LKtddp5nESOlHcxUSANGWNdVzyrbcOj7cvZHdxFA
	lcpzZGSNnXuvWS4d0QImWmGNz4WT5Je2fs47O71zOFmrNpl2vCbMWcBTdcGEs7T/JmkY5t5L6xB
	B6YMkpbPlTVqxbB42805GzORQjGM=
X-Google-Smtp-Source: AGHT+IHfw0kqqwq5xAQSeTY5kw86EWTmZwz1spOhNQCNIm3z486eLKzHsutUH7QtawxGiX6DlMKis98zNcQDoOqo9mI=
X-Received: by 2002:a05:6512:10c1:b0:533:6f3:9857 with SMTP id
 2adb3069b0e04-5331c6904c5mr8137995e87.5.1724106973016; Mon, 19 Aug 2024
 15:36:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1229195.1723211769@warthog.procyon.org.uk> <ZrbgRnXV-snNicjY@codewreck.org>
In-Reply-To: <ZrbgRnXV-snNicjY@codewreck.org>
From: Steve French <smfrench@gmail.com>
Date: Mon, 19 Aug 2024 17:36:01 -0500
Message-ID: <CAH2r5mvXE9kKEFfEpsf3AA0s8oVA8737aLZ2LkOrz1hptujt2A@mail.gmail.com>
Subject: Re: [PATCH] 9p: Fix DIO read through netfs
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Christian Brauner <brauner@kernel.org>, 
	linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I did some additional testing of this patch after seeing regressions
starting with 6.11-rc4 with xfstests generic/125 and generic/210 and
was able to bisect it to this patch which just went in:

commit e3786b29c54cdae3490b07180a54e2461f42144c
Author: Dominique Martinet <asmadeus@codewreck.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b2405dd4d4d4..3f3842e7b44a 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -217,7 +217,8 @@ static void cifs_req_issue_read(struct
netfs_io_subrequest *subreq)
                        goto out;
        }

-       __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+       if (subreq->rreq->origin !=3D NETFS_DIO_READ)
+               __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);

        rc =3D rdata->server->ops->async_readv(rdata);
 out:

It is very simple to repro.
I originally noticed it with tests to shares in Azure, but it also
fails locally to Samba with default cifs.ko mount options.


log message is below:

[ 7884.205037] Workqueue: cifsiod smb2_readv_worker [cifs]
[ 7884.205262] RIP: 0010:netfs_subreq_terminated+0x3f0/0x4b0 [netfs]
[ 7884.205299] Code: 01 00 00 e8 02 b4 07 df 4c 8b 4c 24 08 49 89 d8
4c 89 e9 41 8b b4 24 d4 01 00 00 44 89 f2 48 c7 c7 40 10 65 c1 e8 30
a9 b6 de <0f> 0b 48 8b 7c 24 18 4c 8d bd c0 00 00 00 e8 2d b5 07 df 48
8b 7c
[ 7884.205305] RSP: 0018:ff1100010705fce8 EFLAGS: 00010286
[ 7884.205312] RAX: dffffc0000000000 RBX: 0000000000001000 RCX: 00000000000=
00027
[ 7884.205317] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ff110004cb1=
b1a08
[ 7884.205322] RBP: ff11000119450900 R08: ffffffffa03e346e R09: ffe21c00996=
36341
[ 7884.205326] R10: ff110004cb1b1a0b R11: 0000000000000001 R12: ff11000137b=
68a80
[ 7884.205330] R13: 000000000000012c R14: 0000000000000001 R15: ff11000126a=
96f78
[ 7884.205335] FS:  0000000000000000(0000) GS:ff110004cb180000(0000)
knlGS:0000000000000000
[ 7884.205339] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7884.205344] CR2: 00007f0035f0a67c CR3: 000000000f664004 CR4: 00000000003=
71ef0
[ 7884.205354] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7884.205359] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7884.205363] Call Trace:
[ 7884.205367]  <TASK>
[ 7884.205373]  ? __warn+0xa4/0x220
[ 7884.205386]  ? netfs_subreq_terminated+0x3f0/0x4b0 [netfs]
[ 7884.205423]  ? report_bug+0x1d4/0x1e0
[ 7884.205436]  ? handle_bug+0x42/0x80
[ 7884.205442]  ? exc_invalid_op+0x18/0x50
[ 7884.205449]  ? asm_exc_invalid_op+0x1a/0x20
[ 7884.205464]  ? irq_work_claim+0x1e/0x40
[ 7884.205475]  ? netfs_subreq_terminated+0x3f0/0x4b0 [netfs]
[ 7884.205512]  ? netfs_subreq_terminated+0x3f0/0x4b0 [netfs]
[ 7884.205554]  process_one_work+0x4cf/0xb80
[ 7884.205573]  ? __pfx_lock_acquire+0x10/0x10
[ 7884.205582]  ? __pfx_process_one_work+0x10/0x10
[ 7884.205599]  ? assign_work+0xd6/0x110
[ 7884.205609]  worker_thread+0x2cd/0x550
[ 7884.205622]  ? __pfx_worker_thread+0x10/0x10
[ 7884.205632]  kthread+0x187/0x1d0
[ 7884.205639]  ? __pfx_kthread+0x10/0x10
[ 7884.205648]  ret_from_fork+0x34/0x60
[ 7884.205655]  ? __pfx_kthread+0x10/0x10
[ 7884.205661]  ret_from_fork_asm+0x1a/0x30
[ 7884.205684]  </TASK>
[ 7884.205688] irq event stamp: 23635
[ 7884.205692] hardirqs last  enabled at (23641): [<ffffffffa022b58b>]
console_unlock+0x15b/0x170
[ 7884.205699] hardirqs last disabled at (23646): [<ffffffffa022b570>]
console_unlock+0x140/0x170
[ 7884.205705] softirqs last  enabled at (23402): [<ffffffffa0131a6e>]
__irq_exit_rcu+0xfe/0x120
[ 7884.205712] softirqs last disabled at (23397): [<ffffffffa0131a6e>]
__irq_exit_rcu+0xfe/0x120
[ 7884.205718] ---[ end trace 0000000000000000 ]---

On Fri, Aug 9, 2024 at 10:43=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> David Howells wrote on Fri, Aug 09, 2024 at 02:56:09PM +0100:
> > From: Dominique Martinet <asmadeus@codewreck.org>
> >
> > 9p: Fix DIO read through netfs
>
> nitpick: now sure how that ended up here but this is duplicated with the
> subject (the commit message ends up with this line twice)
>
> > If a program is watching a file on a 9p mount, it won't see any change =
in
> > size if the file being exported by the server is changed directly in th=
e
> > source filesystem, presumably because 9p doesn't have change notificati=
ons,
> > and because netfs skips the reads if the file is empty.
> >
> > Fix this by attempting to read the full size specified when a DIO read =
is
> > requested (such as when 9p is operating in unbuffered mode) and dealing
> > with a short read if the EOF was less than the expected read.
> >
> > To make this work, filesystems using netfslib must not set
> > NETFS_SREQ_CLEAR_TAIL if performing a DIO read where that read hit the =
EOF.
> > I don't want to mandatorily clear this flag in netfslib for DIO because=
,
> > say, ceph might make a read from an object that is not completely fille=
d,
> > but does not reside at the end of file - and so we need to clear the
> > excess.
> >
> > This can be tested by watching an empty file over 9p within a VM (such =
as
> > in the ktest framework):
> >
> >         while true; do read content; if [ -n "$content" ]; then echo $c=
ontent; break; fi; done < /host/tmp/foo
>
> (This is basically the same thing but if one wants to control the read
> timing for more precise/verbose debugging:
>   exec 3< /host/tmp/foo
>   read -u 3 content && echo $content
>   (repeat as appropriate)
>   exec 3>&-
> )
>
> > then writing something into the empty file.  The watcher should immedia=
tely
> > display the file content and break out of the loop.  Without this fix, =
it
> > remains in the loop indefinitely.
> >
> > Fixes: 80105ed2fd27 ("9p: Use netfslib read/write_iter")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218916
> > Written-by: Dominique Martinet <asmadeus@codewreck.org>
>
> Thanks for adding extra comments & fixing other filesystems.
>
> I've checked this covers all cases of setting NETFS_SREQ_CLEAR_TAIL so
> hopefully shouldn't have further side effects, this sounds good to me:
>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Eric Van Hensbergen <ericvh@kernel.org>
> > cc: Latchesar Ionkov <lucho@ionkov.net>
> > cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> > cc: Marc Dionne <marc.dionne@auristor.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > cc: v9fs@lists.linux.dev
> > cc: linux-afs@lists.infradead.org
> > cc: ceph-devel@vger.kernel.org
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-nfs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/9p/vfs_addr.c     |    3 ++-
> >  fs/afs/file.c        |    3 ++-
> >  fs/ceph/addr.c       |    6 ++++--
> >  fs/netfs/io.c        |   17 +++++++++++------
> >  fs/nfs/fscache.c     |    3 ++-
> >  fs/smb/client/file.c |    3 ++-
> >  6 files changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> > index a97ceb105cd8..24fdc74caeba 100644
> > --- a/fs/9p/vfs_addr.c
> > +++ b/fs/9p/vfs_addr.c
> > @@ -75,7 +75,8 @@ static void v9fs_issue_read(struct netfs_io_subreques=
t *subreq)
> >
> >       /* if we just extended the file size, any portion not in
> >        * cache won't be on server and is zeroes */
> > -     __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> > +     if (subreq->rreq->origin !=3D NETFS_DIO_READ)
> > +             __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> >
> >       netfs_subreq_terminated(subreq, err ?: total, false);
> >  }
> > diff --git a/fs/afs/file.c b/fs/afs/file.c
> > index c3f0c45ae9a9..ec1be0091fdb 100644
> > --- a/fs/afs/file.c
> > +++ b/fs/afs/file.c
> > @@ -242,7 +242,8 @@ static void afs_fetch_data_notify(struct afs_operat=
ion *op)
> >
> >       req->error =3D error;
> >       if (subreq) {
> > -             __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> > +             if (subreq->rreq->origin !=3D NETFS_DIO_READ)
> > +                     __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> >               netfs_subreq_terminated(subreq, error ?: req->actual_len,=
 false);
> >               req->subreq =3D NULL;
> >       } else if (req->done) {
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index cc0a2240de98..c4744a02db75 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -246,7 +246,8 @@ static void finish_netfs_read(struct ceph_osd_reque=
st *req)
> >       if (err >=3D 0) {
> >               if (sparse && err > 0)
> >                       err =3D ceph_sparse_ext_map_end(op);
> > -             if (err < subreq->len)
> > +             if (err < subreq->len &&
> > +                 subreq->rreq->origin !=3D NETFS_DIO_READ)
> >                       __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> >               if (IS_ENCRYPTED(inode) && err > 0) {
> >                       err =3D ceph_fscrypt_decrypt_extents(inode,
> > @@ -282,7 +283,8 @@ static bool ceph_netfs_issue_op_inline(struct netfs=
_io_subrequest *subreq)
> >       size_t len;
> >       int mode;
> >
> > -     __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> > +     if (rreq->origin !=3D NETFS_DIO_READ)
> > +             __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> >       __clear_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> >
> >       if (subreq->start >=3D inode->i_size)
> > diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> > index c179a1c73fa7..5367caf3fa28 100644
> > --- a/fs/netfs/io.c
> > +++ b/fs/netfs/io.c
> > @@ -530,7 +530,8 @@ void netfs_subreq_terminated(struct netfs_io_subreq=
uest *subreq,
> >
> >       if (transferred_or_error =3D=3D 0) {
> >               if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->f=
lags)) {
> > -                     subreq->error =3D -ENODATA;
> > +                     if (rreq->origin !=3D NETFS_DIO_READ)
> > +                             subreq->error =3D -ENODATA;
> >                       goto failed;
> >               }
> >       } else {
> > @@ -601,9 +602,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *r=
req,
> >                       }
> >                       if (subreq->len > ictx->zero_point - subreq->star=
t)
> >                               subreq->len =3D ictx->zero_point - subreq=
->start;
> > +
> > +                     /* We limit buffered reads to the EOF, but let th=
e
> > +                      * server deal with larger-than-EOF DIO/unbuffere=
d
> > +                      * reads.
> > +                      */
> > +                     if (subreq->len > rreq->i_size - subreq->start)
> > +                             subreq->len =3D rreq->i_size - subreq->st=
art;
> >               }
> > -             if (subreq->len > rreq->i_size - subreq->start)
> > -                     subreq->len =3D rreq->i_size - subreq->start;
> >               if (rreq->rsize && subreq->len > rreq->rsize)
> >                       subreq->len =3D rreq->rsize;
> >
> > @@ -739,11 +745,10 @@ int netfs_begin_read(struct netfs_io_request *rre=
q, bool sync)
> >       do {
> >               _debug("submit %llx + %llx >=3D %llx",
> >                      rreq->start, rreq->submitted, rreq->i_size);
> > -             if (rreq->origin =3D=3D NETFS_DIO_READ &&
> > -                 rreq->start + rreq->submitted >=3D rreq->i_size)
> > -                     break;
> >               if (!netfs_rreq_submit_slice(rreq, &io_iter))
> >                       break;
> > +             if (test_bit(NETFS_SREQ_NO_PROGRESS, &rreq->flags))
> > +                     break;
> >               if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
> >                   test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
> >                       break;
> > diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
> > index bf29a65c5027..7a558dea75c4 100644
> > --- a/fs/nfs/fscache.c
> > +++ b/fs/nfs/fscache.c
> > @@ -363,7 +363,8 @@ void nfs_netfs_read_completion(struct nfs_pgio_head=
er *hdr)
> >               return;
> >
> >       sreq =3D netfs->sreq;
> > -     if (test_bit(NFS_IOHDR_EOF, &hdr->flags))
> > +     if (test_bit(NFS_IOHDR_EOF, &hdr->flags) &&
> > +         sreq->rreq->origin !=3D NETFS_DIO_READ)
> >               __set_bit(NETFS_SREQ_CLEAR_TAIL, &sreq->flags);
> >
> >       if (hdr->error)
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index b2405dd4d4d4..3f3842e7b44a 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -217,7 +217,8 @@ static void cifs_req_issue_read(struct netfs_io_sub=
request *subreq)
> >                       goto out;
> >       }
> >
> > -     __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> > +     if (subreq->rreq->origin !=3D NETFS_DIO_READ)
> > +             __set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
> >
> >       rc =3D rdata->server->ops->async_readv(rdata);
> >  out:
> >
>
> --
> Dominique Martinet | Asmadeus
>


--=20
Thanks,

Steve

