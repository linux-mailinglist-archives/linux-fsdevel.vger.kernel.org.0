Return-Path: <linux-fsdevel+bounces-52935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E2BAE8994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9452C161806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE42C08A5;
	Wed, 25 Jun 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKHS7PKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E026C3B2;
	Wed, 25 Jun 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868475; cv=none; b=u61oD7eXk+mOBnPiFr1LgN0h6/5lit3its691PMu3pYXII0up7Ea32vDElAygxVyKy7ETjm2Xrz9AShjm//0emLLKadadODd8V0SdtMHPF0ueXhEgxqLRSnMOCMhHNeieE4QFECEL6DRlPi46ivY4lM3fToMadGVeOayCTcKnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868475; c=relaxed/simple;
	bh=XMP6ERBXfxV519EBoe1Y/mZ/m+8At/oi36qL9USyJ5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juUUXwyK5WuJs95+f+RURZt6fgvIdnD1LbffjH0czGcTYqinNqBcKewnVIjOoNGOgkf0N97tRt+vnJqyfDFLaTyV4KV4eEXn5na/4Amxr0KULirIAOy1CvNATWgaWx49GXl6VQaRP7wXBN7se9Wtzvx9OYDOOcjY7SHhSmUhg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKHS7PKh; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fb3bba0730so13928566d6.0;
        Wed, 25 Jun 2025 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750868472; x=1751473272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NVslBr1xkJaej9KYSvp2pb98xkmIaEpx8AR8MBWA3Y=;
        b=KKHS7PKh1Tzi/umPFc5fZ06crDgdRXEIWlhStq7JSGeAVz7/qrt9SLqChBWXHmZ22V
         keGme5bnlSsc2k5nHggKOmhlEIp7hGAyPHS8U9UqPCKFo0C1ODiTngwRGd1mdTElhksy
         P7TTHUR1OxKu2FQGjEguHiZTPBpTA0w4/8n/hyDfbUMbCqNHooZ8LoMoXaBqusoQSaMt
         GvnoVU0W2SIHuUzuBk3MsYve3jPVgtOncq+7NkU4jfsEH/eJ+O7pvWn7+mFGZ5tfxmFA
         bJXoi7IIpxZAL96EtHA9SFCu2pzcAx0uCEy+MHxlkvCZuAQwLCTIETOw+UlsK2rYiUMX
         YMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750868472; x=1751473272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NVslBr1xkJaej9KYSvp2pb98xkmIaEpx8AR8MBWA3Y=;
        b=Aw6eixF4SVSE3Z2ScabJL/1fPhLCWQicIC4v2RAkO9S5HL7GDYakewRpbqSOtoDkbf
         8+Ysn1P+1uFsGH/Fh1yzjIDDDz6Wf8JE9+uRR/acyBe95+s/wMHS66tUwqjHUTVXv4Xl
         iUxBwSU5V2nC+Cq69kHxIxnZe+xwACin4sxnXuY0PBXSG7p9QEXzOVLaq8zypXYfObV4
         1ghbObD+cw7w4yGKNkXSwVua9VIFhWzGADMm6PMe3qwdMr3EO+0I/4fL7dhMDUyZQ4gc
         xP6HQHm9As0LwmQ14XS6NJdC24HyOxUP0gf5MqM6mYbwQARFbKic8Fe3cKo12T2QoIKE
         zjDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUm27OPwp+6fijOIR1K8EHjRl0X1e1CCsbTYxw6fjYUe6jDYH+23BlzHm3yJRpw+tWSZcCpqDAa+ci@vger.kernel.org, AJvYcCVU9vV0Znvp3jzD8lHU4NDKvzGPWqRlUmZTwKi2uOiY1PDc0TbfgJnRXrtVYEg7zpxhV8YGaevSoh2MmHfxdQ==@vger.kernel.org, AJvYcCW+c9Gfhnln1GEFf0QLaqyMaHZsQoWWijer5kSJVEn3Y1whaa+TlxcySFCKtWV6s5ytIAQESL3iJuLSnC8n@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1S9/j1HjlBrfGb8FoawmG9PfP8xarrrKi/BrJH0LSrMFHhs6V
	x4eBRcGcPCW7EgRA4CHezGJHryOeU54XAq1poMTTO2CsXcs6mxSwReRbDsQJrIwMnQlx+xkYTFd
	Bj0AI2r4tpe2Wb4sKxYjQBby2HRrNKPo=
X-Gm-Gg: ASbGncv9pfIuTX0082yYkNDONwmhKky098dkZKtC2GChiHSIXEDfzXRJ/H0EaosX3eP
	U1EnXl5TNf91P8rqe5JMyhEuTmpAmuBsGAgVtNL562jzZ7K3kYBwfTrREl9da0JlFsyYsYWR0H6
	ky8KHPUSsJqBJcF3qnXHo6whqSJFJ2dYo5BKOF5XbWyg1TfwaajiWhfUNgdwj+HAP2NEYz50//T
	kjQ
X-Google-Smtp-Source: AGHT+IF0E2ADWqAWPU392h4IO+FZ/wRsjmuf7c03br6vhyt8kFz6PcUB5E7QjpVnFsCxdOzBZ17XM3vfqbwilSgcRb4=
X-Received: by 2002:a05:6214:419e:b0:6fa:ad2a:7998 with SMTP id
 6a1803df08f44-6fd753a870emr3103946d6.18.1750868472164; Wed, 25 Jun 2025
 09:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1372501.1750858644@warthog.procyon.org.uk> <1382992.1750862802@warthog.procyon.org.uk>
 <011ec23b-d151-4ef8-bbe7-ba79e3678ae7@samba.org>
In-Reply-To: <011ec23b-d151-4ef8-bbe7-ba79e3678ae7@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 25 Jun 2025 11:21:00 -0500
X-Gm-Features: Ac12FXwJI9fijUzybZTm6c-W7y-I5jTYEiHnpSWQL96V5yQo6-_Q8OXO622L3v8
Message-ID: <CAH2r5mtzPKaiOmwQsaSTRWy1YdWygvVBdOPrhLLGbEfNAWXvEQ@mail.gmail.com>
Subject: Re: [PATCH v2] cifs: Fix the smbd_request and smbd_reponse slabs to
 allow usercopy
To: Stefan Metzmacher <metze@samba.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next and added RB and tested-by

On Wed, Jun 25, 2025 at 10:55=E2=80=AFAM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> reviewed-by and tested-by: Stefan Metzmacher <metze@samba.org>
>
> Am 25.06.25 um 16:46 schrieb David Howells:
> >
> > The handling of received data in the smbdirect client code involves usi=
ng
> > copy_to_iter() to copy data from the smbd_reponse struct's packet trail=
er
> > to a folioq buffer provided by netfslib that encapsulates a chunk of
> > pagecache.
> >
> > If, however, CONFIG_HARDENED_USERCOPY=3Dy, this will result in the chec=
ks
> > then performed in copy_to_iter() oopsing with something like the follow=
ing:
> >
> >   CIFS: Attempting to mount //172.31.9.1/test
> >   CIFS: VFS: RDMA transport established
> >   usercopy: Kernel memory exposure attempt detected from SLUB object 's=
mbd_response_0000000091e24ea1' (offset 81, size 63)!
> >   ------------[ cut here ]------------
> >   kernel BUG at mm/usercopy.c:102!
> >   ...
> >   RIP: 0010:usercopy_abort+0x6c/0x80
> >   ...
> >   Call Trace:
> >    <TASK>
> >    __check_heap_object+0xe3/0x120
> >    __check_object_size+0x4dc/0x6d0
> >    smbd_recv+0x77f/0xfe0 [cifs]
> >    cifs_readv_from_socket+0x276/0x8f0 [cifs]
> >    cifs_read_from_socket+0xcd/0x120 [cifs]
> >    cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
> >    kthread+0x396/0x830
> >    ret_from_fork+0x2b8/0x3b0
> >    ret_from_fork_asm+0x1a/0x30
> >
> > The problem is that the smbd_response slab's packet field isn't marked =
as
> > being permitted for usercopy.
> >
> > Fix this by passing parameters to kmem_slab_create() to indicate that
> > copy_to_iter() is permitted from the packet region of the smbd_response
> > slab objects, less the header space.
> >
> > Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> > Reported-by: Stefan Metzmacher <metze@samba.org>
> > Link: https://lore.kernel.org/r/acb7f612-df26-4e2a-a35d-7cd040f513e1@sa=
mba.org/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >   fs/smb/client/smbdirect.c |   18 +++++++++++++-----
> >   1 file changed, 13 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> > index ef6bf8d6808d..f9773cc0d562 100644
> > --- a/fs/smb/client/smbdirect.c
> > +++ b/fs/smb/client/smbdirect.c
> > @@ -1475,6 +1475,9 @@ static int allocate_caches_and_workqueue(struct s=
mbd_connection *info)
> >       char name[MAX_NAME_LEN];
> >       int rc;
> >
> > +     if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data=
_transfer)))
> > +             return -ENOMEM;
> > +
> >       scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
> >       info->request_cache =3D
> >               kmem_cache_create(
> > @@ -1492,12 +1495,17 @@ static int allocate_caches_and_workqueue(struct=
 smbd_connection *info)
> >               goto out1;
> >
> >       scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
> > +
> > +     struct kmem_cache_args response_args =3D {
> > +             .align          =3D __alignof__(struct smbd_response),
> > +             .useroffset     =3D (offsetof(struct smbd_response, packe=
t) +
> > +                                sizeof(struct smbdirect_data_transfer)=
),
> > +             .usersize       =3D sp->max_recv_size - sizeof(struct smb=
direct_data_transfer),
> > +     };
> >       info->response_cache =3D
> > -             kmem_cache_create(
> > -                     name,
> > -                     sizeof(struct smbd_response) +
> > -                             sp->max_recv_size,
> > -                     0, SLAB_HWCACHE_ALIGN, NULL);
> > +             kmem_cache_create(name,
> > +                               sizeof(struct smbd_response) + sp->max_=
recv_size,
> > +                               &response_args, SLAB_HWCACHE_ALIGN);
> >       if (!info->response_cache)
> >               goto out2;
> >
>
>


--=20
Thanks,

Steve

