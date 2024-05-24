Return-Path: <linux-fsdevel+bounces-20120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A68CE822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225791F22F73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A812E1FA;
	Fri, 24 May 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO3XjmRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3733FBB7;
	Fri, 24 May 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564779; cv=none; b=IpBSsqDQ7LxpjEYbOaKUdCm7GQjYKzU0XoofXoO5OH5QH14AokfAdVzewaWuA2GU76jkIlLdBB7GadWfDpRztGkkXEEtUW5BtTS/GOAfS+h3q54yJW0UyJwdjyDtP1hyT92ZEyvS9On8ThN8TdWHIlTAX20P7Tw4p3KFGkbOcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564779; c=relaxed/simple;
	bh=ZFDKBdBTekCEENY+51EMzM9biBYe/pA7eJ3KiZKFGRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb2NdInso/RRxf8dxWWaJUA7jLQcr3U8XPY+m8FA2Cj0d5NAupuO8i4FICyKN4QyLK6FePk4ps0vN0esrEjAqmE3V9nYBK3U77OAFj5fcrMQBFQfUZmiVykQm4b+y+ULC5SiXeM4WidDmYlT9r8UWymxXg9nnFKMUeOQV0hjFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO3XjmRK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73441edf7so57501461fa.1;
        Fri, 24 May 2024 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716564776; x=1717169576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6qOkh/PGC494+O1SNtX3YdK252w8wI7PTCcvr+/gao=;
        b=TO3XjmRK2M/qk7zMhMunZ+c5BxCESDIwciNu+Md4QRiBVX/xOOOuoNGc6giJpefiM6
         vNMUvNmmrSM7NNPiIbGtvhd3bpUbxYYIPGnPVpWLjwJznFLuDW5jyyLIL0MFPoaq0LKF
         bw2ah3aeqXq3zIIbwiHSt/qY+pa3puFZrlKsmfgyBA7gcTqnKE8QNcfOu7DR8XJaiy9P
         6zTuD42sLU95obyaR8UViQH2IuRIrViwJuLz84FZIYQDYLnVEk/N+vZU9KQ1tjTw0nIx
         4jffLzDR9FdCVAGzGEFhKHzcVftI88bHUSkGYjtob3p9Do0XMIhNr+6A4WxbDUQ/yfZ2
         IopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564776; x=1717169576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6qOkh/PGC494+O1SNtX3YdK252w8wI7PTCcvr+/gao=;
        b=CAt1HA/NVs7bCfndX0TpUfuUqNjlslyJrvEQqFNlGdxyI0xFAYrwGL9Esy5B0mcm9p
         u25eeeBFaUST7frk7/9pN1ZUV48by2K+gHOwtkgITFEvK4iIehWYm8pgEya+A5hJ5mYf
         uaiPlqNJrWfApXenNFBWL7DElP3KAG4qsG2u2go4BKoOzukpoDu/ROSbcM//HAqm3AdK
         m4B40SUnE5TOG9OSsHH1XMgvslTuxZCg7QbZCOUG0wj32rvgd60uKQTbxui3HNH1eu0v
         unpvVnoaRXtM4TgCn1b2lXYvQ/sRJLU21TNaBeagQCp+KDWsLoEypWQH71KBdfAAybIE
         MGkw==
X-Forwarded-Encrypted: i=1; AJvYcCVpmGbbjsblZ1/vbMi/1GyZ+FkpnQE/L8e44aqB+ZhOk5F4kCuneJtOsVZGvOUxJE/TZlBHq3FHGAZDM4RFHwxVgLuZeBuhIl1vHWfnGe471JJcn10m6dxLrCCu0nADqlOFaEMD9j3Wvfg83ABRih2mJQWWosk2kAbtXfXlWup5saSY8RMr2qA=
X-Gm-Message-State: AOJu0Yytxxj3sD8Gm0y8yVlXNHkMPOfCBr1zjaAJWCTnQp9xE+lqqoqr
	JHAGQo8n5L4XwCC0DciecNs7q+m32yI8SJFSVOb7KuD6jZ16h2avaPIQfGrfgWWXHJ4Vg645UlB
	Ti7ip7Kk/HOli6FhE29ZSqsyR3ww4JhWm
X-Google-Smtp-Source: AGHT+IET+SxNQZJlDbNpqEa/XDACkqtNs4ecbaUXuz1eCuEcR3UXWzaoWJeTKa7TkU50/GrdokDPWydnBIjehjbcgJA=
X-Received: by 2002:a05:651c:1058:b0:2e9:532f:9797 with SMTP id
 38308e7fff4ca-2e95b27ebdfmr17603971fa.43.1716564775482; Fri, 24 May 2024
 08:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <351482.1716336150@warthog.procyon.org.uk> <CAH2r5muWt2X55sVfk6Ngct-+c_SFepPzQdhUiZNQT+o_twiivw@mail.gmail.com>
In-Reply-To: <CAH2r5muWt2X55sVfk6Ngct-+c_SFepPzQdhUiZNQT+o_twiivw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 24 May 2024 10:32:44 -0500
Message-ID: <CAH2r5mvHZLLb_hJmXGvWbKDNKoLPwkXO5wFpOM0eTZkKvtV5Ug@mail.gmail.com>
Subject: Re: [PATCH v2] netfs: Fix io_uring based write-through
To: David Howells <dhowells@redhat.com>
Cc: Steve French <stfrench@microsoft.com>, Jeff Layton <jlayton@kernel.org>, 
	Enzo Matsumiya <ematsumiya@suse.de>, Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, 
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can add my Tested-by if you would like.  Hopefully this (and "netfs:
Fix setting of BDP_ASYNC from iocb flags") can be in mainline
relatively soon as they both fix some issues we hit with netfs testing
cifs.ko.   There are still a few more netfs bugs to work through but
this is progress.

On Tue, May 21, 2024 at 9:06=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> fixed minor checpatch warning (updated patch attached)
>
> On Tue, May 21, 2024 at 7:02=E2=80=AFPM David Howells <dhowells@redhat.co=
m> wrote:
> >
> > This can be triggered by mounting a cifs filesystem with a cache=3Dstri=
ct
> > mount option and then, using the fsx program from xfstests, doing:
> >
> >         ltp/fsx -A -d -N 1000 -S 11463 -P /tmp /cifs-mount/foo \
> >           --replay-ops=3Dgen112-fsxops
> >
> > Where gen112-fsxops holds:
> >
> >         fallocate 0x6be7 0x8fc5 0x377d3
> >         copy_range 0x9c71 0x77e8 0x2edaf 0x377d3
> >         write 0x2776d 0x8f65 0x377d3
> >
> > The problem is that netfs_io_request::len is being used for two purpose=
s
> > and ends up getting set to the amount of data we transferred, not the
> > amount of data the caller asked to be transferred (for various reasons,
> > such as mmap'd writes, we might end up rounding out the data written to=
 the
> > server to include the entire folio at each end).
> >
> > Fix this by keeping the amount we were asked to write in ->len and usin=
g
> > ->submitted to track what we issued ops for.  Then, when we come to cal=
ling
> > ->ki_complete(), ->len is the right size.
> >
> > This also required netfs_cleanup_dio_write() to change since we're no
> > longer advancing wreq->len.  Use wreq->transferred instead as we might =
have
> > done a short read and wreq->len must be set when setting up a direct wr=
ite.
> >
> > With this, the generic/112 xfstest passes if cifs is forced to put all
> > non-DIO opens into write-through mode.
> >
> > Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Enzo Matsumiya <ematsumiya@suse.de>
> > cc: netfs@lists.linux.dev
> > cc: v9fs@lists.linux.dev
> > cc: linux-afs@lists.infradead.org
> > cc: linux-cifs@vger.kernel.org
> > cc: linux-fsdevel@vger.kernel.org
> > Link: https://lore.kernel.org/r/295086.1716298663@warthog.procyon.org.u=
k/ # v1
> > ---
> >  Changes
> >  =3D=3D=3D=3D=3D=3D=3D
> >  ver #2)
> >   - Set wreq->len when doing direct writes.
> >
> >  fs/netfs/direct_write.c  |    5 +++--
> >  fs/netfs/write_collect.c |    7 ++++---
> >  fs/netfs/write_issue.c   |    2 +-
> >  3 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> > index 608ba6416919..93b41e121042 100644
> > --- a/fs/netfs/direct_write.c
> > +++ b/fs/netfs/direct_write.c
> > @@ -12,7 +12,7 @@
> >  static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
> >  {
> >         struct inode *inode =3D wreq->inode;
> > -       unsigned long long end =3D wreq->start + wreq->len;
> > +       unsigned long long end =3D wreq->start + wreq->transferred;
> >
> >         if (!wreq->error &&
> >             i_size_read(inode) < end) {
> > @@ -92,8 +92,9 @@ static ssize_t netfs_unbuffered_write_iter_locked(str=
uct kiocb *iocb, struct iov
> >         __set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
> >         if (async)
> >                 wreq->iocb =3D iocb;
> > +       wreq->len =3D iov_iter_count(&wreq->io_iter);
> >         wreq->cleanup =3D netfs_cleanup_dio_write;
> > -       ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_i=
ter_count(&wreq->io_iter));
> > +       ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq-=
>len);
> >         if (ret < 0) {
> >                 _debug("begin =3D %zd", ret);
> >                 goto out;
> > diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
> > index 60112e4b2c5e..426cf87aaf2e 100644
> > --- a/fs/netfs/write_collect.c
> > +++ b/fs/netfs/write_collect.c
> > @@ -510,7 +510,7 @@ static void netfs_collect_write_results(struct netf=
s_io_request *wreq)
> >          * stream has a gap that can be jumped.
> >          */
> >         if (notes & SOME_EMPTY) {
> > -               unsigned long long jump_to =3D wreq->start + wreq->len;
> > +               unsigned long long jump_to =3D wreq->start + READ_ONCE(=
wreq->submitted);
> >
> >                 for (s =3D 0; s < NR_IO_STREAMS; s++) {
> >                         stream =3D &wreq->io_streams[s];
> > @@ -690,10 +690,11 @@ void netfs_write_collection_worker(struct work_st=
ruct *work)
> >         wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
> >
> >         if (wreq->iocb) {
> > -               wreq->iocb->ki_pos +=3D wreq->transferred;
> > +               size_t written =3D min(wreq->transferred, wreq->len);
> > +               wreq->iocb->ki_pos +=3D written;
> >                 if (wreq->iocb->ki_complete)
> >                         wreq->iocb->ki_complete(
> > -                               wreq->iocb, wreq->error ? wreq->error :=
 wreq->transferred);
> > +                               wreq->iocb, wreq->error ? wreq->error :=
 written);
> >                 wreq->iocb =3D VFS_PTR_POISON;
> >         }
> >
> > diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> > index acbfd1f5ee9d..3aa86e268f40 100644
> > --- a/fs/netfs/write_issue.c
> > +++ b/fs/netfs/write_issue.c
> > @@ -254,7 +254,7 @@ static void netfs_issue_write(struct netfs_io_reque=
st *wreq,
> >         stream->construct =3D NULL;
> >
> >         if (subreq->start + subreq->len > wreq->start + wreq->submitted=
)
> > -               wreq->len =3D wreq->submitted =3D subreq->start + subre=
q->len - wreq->start;
> > +               WRITE_ONCE(wreq->submitted, subreq->start + subreq->len=
 - wreq->start);
> >         netfs_do_issue_write(stream, subreq);
> >  }
> >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

