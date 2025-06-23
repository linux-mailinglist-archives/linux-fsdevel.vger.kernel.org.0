Return-Path: <linux-fsdevel+bounces-52579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20FFAE4615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236BB447566
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168CF76C61;
	Mon, 23 Jun 2025 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1z+mUzC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143C182B7;
	Mon, 23 Jun 2025 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687536; cv=none; b=GUxE+VlWh25LifltI2IycnfJs4lwWignadHizvHZzfr2gFWkJFn4/7YIUUeP4LugnlgTFRnMMsW8tc72EKzLRTulVTQ6lzarU6QQYh4LWIAiLLrTrni27lpd/+qRy3fpoNXPZa29BiyrDE7ke2TWbuiey6vt67bN5XGMQncVjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687536; c=relaxed/simple;
	bh=APur9JzsTMsI0B/zh/fikgFxjzTjltdsctiBZTePL7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTXEANHZjsQqtKBRvj5t1rZBSWo+HcG6bG43dv2r7xKIb2kuvy9Es49+lNPJdMGoLWFnDmokc+Faze0RCKThWG2yz5ZX8q8EfdWJmuBuFf8dynZ2Cse3fHdJ5YJDPkMwIHtqDZ+F99BUNtiYKbwgtUl/s4lZSnSqa1hW1b7pD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1z+mUzC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad574992fcaso724718466b.1;
        Mon, 23 Jun 2025 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750687533; x=1751292333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+G3ezD0b7pt+ySwBICrCnnVxMkhoN6C/k3v0ECf3hA=;
        b=l1z+mUzCR6lRW3S2OmVdndfBKaHw50Pk/NAq25Ps+/wK/Z4ZFhfXHUHTYe/5HXINhF
         mfzAKJsrt1scbvKQGJDh8WVBuZ9WY69zoSozLAoBeo3LwvMgDIr5vlbSgaZBLS0hpucv
         heeP68IUD9T0lfuq7UgS57EPKK+2KszEMYByxsHhhTcFZg3os4vYGdHBknf5KG4p2S4T
         teew6H4nGLNn1zrCb+rf5K1Ydde81paAm59MfOet1GZnosx89e2d31XYlcshhOHkqmZE
         knUc8rnkreNMFcUjW9VKk948+AbsxVDTdr/MGt4XnTPQHFnSN4259AJsmyNMcPLKMvfq
         Ed3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750687533; x=1751292333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+G3ezD0b7pt+ySwBICrCnnVxMkhoN6C/k3v0ECf3hA=;
        b=Y8ZUq0BF6nUlS1rIe40kM2Lshq7WTKZsIoscrYaHATtL/TkUxz91pj0xDKawD3KUzF
         M7H1C+tdDGGC+/QTOopR3ff58sqXauIkKyGeLCgJ6BPvy9KcaI2UHbLPSStoyFABI4cm
         kStxd2RN2q7PD6JpMZGAABSf9GbXoVzZKGPIz0HsBCMLG+zL5Vv8o8+72/YYwnr0yuyi
         jjGWuqZGTbpF0fw8/lkZWDIJ5TXNNPXupNJY2gMApB/Z0UJhFURz8SQCGOMX/mu99/Q4
         Lx7NsJyrht0WhhcMML/8gSxtQPBLtwLDXnpOu5d+l1yoL7RKP3PD2FegiPM6MYx6ZESw
         T/iw==
X-Forwarded-Encrypted: i=1; AJvYcCU1+v6k4Ej2+jbGpSmI89OrNfNDNKgu7Ux+4Qb9AXQ3+Fna0ezZqhC5+0WAO7ipW2phzvTOuOL7IICHZU+6@vger.kernel.org, AJvYcCUUb96L4G3EkYrdD8u3goD4GNqDwTuLFnfju+l+UKkbGEHTuUSvbCIeKqVvM7uweZKQU/uCBqrpVEMK@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNmJI/C/E+m6S1+dobHZK7Y6GyurQ79NAS+2gK13C+eZawlVo
	CbaSxU5D53HzPHIZ9OQLgn4RQNvE6xDvfvLHOaHp7VaeI6gkjKM7BEgS8U/0G11RDTxW6tP2krH
	Feqx+OH28T1oECGufDe/R7SWPIlE+SOc=
X-Gm-Gg: ASbGnctG5zbYHxL4VJcUavTWXTy69vf+emNlRBJOaY9DRzY1X1nQvTGdalG+ymugdyp
	gUXpfjFQD9DR0XitzmMBdjbFVf0f+9w9hAyHyJeT4/xamrreW/zwXhe12LpaiqdA1sZrxxiT3eH
	FJq4mftHpStae5/On1cpdzmHityZ0lo3DIlkt6SscXcqg=
X-Google-Smtp-Source: AGHT+IHdk0rHJs7g1Q2nl6nEL9cQVPn3QOhavYxcIIN4y7/jYHechg6+oUSCUeITBgdLVxFgK15bETyiAyDLLmfEzjY=
X-Received: by 2002:a17:906:c450:b0:ad8:a329:b4a0 with SMTP id
 a640c23a62f3a-ae057d0500cmr898101266b.24.1750687531217; Mon, 23 Jun 2025
 07:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
 <20250623-herzrasen-geblickt-9e2befc82298@brauner> <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
 <lo73q6ovi2m2skguq5ydedz2za4vud747ztwfxwzn33r3do7ia@p7y3sbyrznfi>
 <CAOQ4uxirz2sRrNNtO5Re=CdzwW+tLvoA0XHFW9V5HDPgh15g2A@mail.gmail.com> <idfofhnjxf35s4d6wifbdfh27a5blh5kzlpr5xkgkc3zkvz3nx@odyxd6o75a5a>
In-Reply-To: <idfofhnjxf35s4d6wifbdfh27a5blh5kzlpr5xkgkc3zkvz3nx@odyxd6o75a5a>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 16:05:18 +0200
X-Gm-Features: AX0GCFsnLMm9BhDALAGz6VWiS3hb8KYoKXkquIy_0Ig7FY1wMBnHnbgIk2KcUeY
Message-ID: <CAOQ4uxg9jWNxWg3ksoeEQ-KY0xKUwTPYokKN7d4whi_QDa=u_g@mail.gmail.com>
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:18=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-06-25 15:05:45, Amir Goldstein wrote:
> > On Mon, Jun 23, 2025 at 2:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 23-06-25 14:22:26, Amir Goldstein wrote:
> > > > On Mon, Jun 23, 2025 at 1:58=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> > > > >
> > > > > On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> > > > > > On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > > > > > > Introduce new pidfs file handle values.
> > > > > > >
> > > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > > ---
> > > > > > >  include/linux/exportfs.h | 11 +++++++++++
> > > > > > >  1 file changed, 11 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/linux/exportfs.h b/include/linux/exportf=
s.h
> > > > > > > index 25c4a5afbd44..45b38a29643f 100644
> > > > > > > --- a/include/linux/exportfs.h
> > > > > > > +++ b/include/linux/exportfs.h
> > > > > > > @@ -99,6 +99,11 @@ enum fid_type {
> > > > > > >      */
> > > > > > >     FILEID_FAT_WITH_PARENT =3D 0x72,
> > > > > > >
> > > > > > > +   /*
> > > > > > > +    * 64 bit inode number.
> > > > > > > +    */
> > > > > > > +   FILEID_INO64 =3D 0x80,
> > > > > > > +
> > > > > > >     /*
> > > > > > >      * 64 bit inode number, 32 bit generation number.
> > > > > > >      */
> > > > > > > @@ -131,6 +136,12 @@ enum fid_type {
> > > > > > >      * Filesystems must not use 0xff file ID.
> > > > > > >      */
> > > > > > >     FILEID_INVALID =3D 0xff,
> > > > > > > +
> > > > > > > +   /* Internal kernel fid types */
> > > > > > > +
> > > > > > > +   /* pidfs fid types */
> > > > > > > +   FILEID_PIDFS_FSTYPE =3D 0x100,
> > > > > > > +   FILEID_PIDFS =3D FILEID_PIDFS_FSTYPE | FILEID_INO64,
> > > > > >
> > > > > > What is the point behind having FILEID_INO64 and FILEID_PIDFS s=
eparately?
> > > > > > Why not just allocate one value for FILEID_PIDFS and be done wi=
th it? Do
> > > > > > you expect some future extensions for pidfs?
> > > > >
> > > > > I wouldn't rule it out, yes. This was also one of Amir's suggesti=
ons.
> > > >
> > > > The idea was to parcel the autonomous fid type to fstype (pidfs)
> > > > which determines which is the fs to decode the autonomous fid
> > > > and a per-fs sub-type like we have today.
> > > >
> > > > Maybe it is a bit over design, but I don't think this is really lim=
iting us
> > > > going forward, because those constants are not part of the uapi.
> > >
> > > OK, I agree these file handles do not survive reboot anyway so we are=
 free
> > > to redefine the encoding in the future. So it is not a big deal (but =
it
> > > also wouldn't be a big deal to start simple and add some subtyping in=
 the
> > > future when there's actual usecase). But in the current patch set we =
have
> > > one flag FILEID_IS_AUTONOMOUS which does provide this subtyping and t=
hen
> > > this FILEID_PIDFS_FSTYPE which doesn't seem to be about subtyping but=
 about
> > > pidfs expecting some future extensions and wanting to recognize all i=
ts
> > > file handle types more easily (without having to enumerate all types =
like
> > > other filesystems)? My concern is that fh_type space isn't that big a=
nd if
> > > every filesystem started to reserve flag-like bits in it, we'd soon r=
un out
> > > of it. So I don't think this is a great precedens although in this
> > > particular case I agree it can be modified in the future if we decide=
 so...
> > >
> >
> > Yes, I agree.
> > For the sake of argument let's assume we have two types to begin with
> > pidfs and drm and then would you want to define them as:
> >
> >    /* Internal kernel fid types */
> >    FILEID_PIDFS =3D 0x100,
> >    FILEID_DRM =3D 0x200,
> >
> > Or
> >
> >    FILEID_PIDFS =3D 0x100,
> >    FILEID_DRM =3D 0x101,
> >
> > I think the former is easy to start with and we have plenty of time to
> > make reparceling if we get to dousens and file id type...
>
> No strong preference if we then test for equality with FILEID_PIDFS and
> FILEID_DRM and not like fh_type & FILEID_PIDFS.
>
> > Regarding the lower bits, I think it would be wise to reserve
> >
> > FILEID_PIDFS_FSTYPE =3D 0x100,
> > FILEID_PIDFS_ROOT =3D FILEID_PIDFS_FSTYPE | FILEID_ROOT /* also 0x100 *=
/
> >
> > This is why I suggested using non zero lower bits and then why
> > not use the actual format descriptor for the lower bits as it was inten=
ded.
>
> I'm getting lost in these names a bit :) It's hard to see a difference fo=
r
> me without a concrete examples of where one should be used compared to th=
e
> other...

In any case, I don't feel strongly about it.
You can leave it as is or use
    FILEID_PIDFS =3D 0x100,
or
    FILEID_PIDFS =3D 0x180,

we can always change it later if we want to.

Thanks,
Amir.

