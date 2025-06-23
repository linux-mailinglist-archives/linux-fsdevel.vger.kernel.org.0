Return-Path: <linux-fsdevel+bounces-52564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D084DAE419C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B923B543D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40924EAB2;
	Mon, 23 Jun 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNydz/tR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3824DD1D;
	Mon, 23 Jun 2025 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683962; cv=none; b=rGn9CVLAphGoHOEtreJgNHkNKFCPUSMzwJLO/nsn2u+M5L2EyrzNewHZFa5IRUFR+QefOaMZQX9fatenDe9QgT+3wxZje+hxzFX2GzjLCrpT9yMjUJsLJr0ffr7YhE1YpCZibHE01FQjh5qXH7XgEh2dRKw1XaTtvP3EBwaRwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683962; c=relaxed/simple;
	bh=OwVdO5Xa4BMEhy6sq0XI0lZU49QzEH8fPbNfGlvxaOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jq+m4O0Z7Pg5JyP1mSwtQkC+j9WqHEMtD534qhwOh7s8FKe/YXhdMHer6GiUhL/ii1WE1Oqx02F3vS+Cf5EBnaRG8HZyy4ZzvdLxW0o0424F21ynGOd5LbK3ysu6Tz1lJfgZ+jRiRQYoCttED/yAiXLl5HoxLdK/qLS+FR0DoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNydz/tR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so712470766b.0;
        Mon, 23 Jun 2025 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750683959; x=1751288759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHYynOat2euqSslpq12KrPNkS1xgL9vKXu2+o9aFOXo=;
        b=gNydz/tROhlfq3gUBTnyJn8f1rjY1snsy3WiV4Cu2taDUB3Hfpmt4ZCT8ujGbIGIwt
         NrwefUYFYeVloa85ZOIUmidY1Wvl5e89VTs85JvcFjbF+pwoJrnJRP134x/Hjzjri6Vj
         4EwL8hKj2o1pJmaOqv6bBT3NE2lqw/DinAxONJ7nwx/UEspcvyyO/MCq7tS3q9/hS5np
         9kwcRyghaE+7KeknmRSNldF9xTQuG80Ecb13WcQF0fCLkyJi/pxasO4IHbFv19YgV8rr
         6w3HNdnoOLHw083t8bVSHiTjGK36vO/p8TSUVSk9AHSVZkJzwn0tlP6kzTHZt36MeX0E
         24Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750683959; x=1751288759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHYynOat2euqSslpq12KrPNkS1xgL9vKXu2+o9aFOXo=;
        b=u4HJt5L7PhBu3Jp4GfNNdMm7AuiBtI0FD1hhZz8Ne1WpJhO6AJKOffEap9bP3hnzZ0
         hqwTfMNbdNz6k39qMHwAay4MHsv6MNjK77S8aWWeYfOwAKNSLcgxPAT5O/lt/Di6Hky1
         y3bfzwND+gVYyWN70+ippLZy6iXdDQP6GhH7Xlilci4pTiVsZsPNAB6H93mTtGUBuda3
         PsKJlDv0umxUPGNQUVCBpzdyCIzSxbFPSQm0hFqMnpDm9HhIP8rH1IprlhbEsXDkPvFq
         qJwJbQ+wQ8V41vmLiqBeFf7TNhDrdPUsSvdeteKuNHzShyFTjQ7RimOxSk7CQBDRV6g4
         cYLA==
X-Forwarded-Encrypted: i=1; AJvYcCXcfDANz36PMGL86wxD02Eb95YPLYKsFjs7dCVnh9E6Evk3hEyQjBKGBjYqbaurs2rPSzwtjxnPvDAc+YZd@vger.kernel.org, AJvYcCXvNMfNpP7IXzrQc3SXy/ntWWzQTXJGq5swxmo1vdYgRQLX0sAJw6lRgtu8SPlXYvc020NrQTdKHXgc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+8qdYRdqquzxIy+gfE/K3w81KII9msC2AlA4shR0T7pZs0cY
	jgPmNTLDZS/mrJrIOTqJ6pW9wk4ForVw/ghAPefbjXHWgdFCFDAhO3poQZdqdklrpKrNn6ZaAb8
	kSL+9mBzlwc78HPITSkQreUnBrYoF2f1F2PYOhVM=
X-Gm-Gg: ASbGncumAmC3olQM/lwCCH861qx/n7qOVann96q4l51kaSdxYUTvtBo0HcIv+loWNuG
	ddt3SZcQuUXtviGQtfhXtoyLPg5aVIOQBrrHHGJuMwMwOhrPEaHy0hvm+RyDV/Bqf6vob25UE5S
	szpvVETRTxB7whF6p6xdk34GwC9ym65zW4KYR9uitlb3pMBahx5J3qIg==
X-Google-Smtp-Source: AGHT+IHRMxfvhIx0WTCVuB3z9PYCZ7vIKkVNmuKX4MeEL3Gn6geNVLcPKeUIr5HeJuQyqYVQsKIOOsfJTJY1EPoX8xY=
X-Received: by 2002:a17:907:26c9:b0:ad5:7234:e4a9 with SMTP id
 a640c23a62f3a-ae057acc409mr1082742766b.28.1750683958207; Mon, 23 Jun 2025
 06:05:58 -0700 (PDT)
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
In-Reply-To: <lo73q6ovi2m2skguq5ydedz2za4vud747ztwfxwzn33r3do7ia@p7y3sbyrznfi>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Jun 2025 15:05:45 +0200
X-Gm-Features: AX0GCFuSl-TM5f1qL7SXheaQjSybqfVB7NoGVo3VaTnfpzF6a6ioRafp-vecWyM
Message-ID: <CAOQ4uxirz2sRrNNtO5Re=CdzwW+tLvoA0XHFW9V5HDPgh15g2A@mail.gmail.com>
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 2:41=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-06-25 14:22:26, Amir Goldstein wrote:
> > On Mon, Jun 23, 2025 at 1:58=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> > > > On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > > > > Introduce new pidfs file handle values.
> > > > >
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >  include/linux/exportfs.h | 11 +++++++++++
> > > > >  1 file changed, 11 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > > index 25c4a5afbd44..45b38a29643f 100644
> > > > > --- a/include/linux/exportfs.h
> > > > > +++ b/include/linux/exportfs.h
> > > > > @@ -99,6 +99,11 @@ enum fid_type {
> > > > >      */
> > > > >     FILEID_FAT_WITH_PARENT =3D 0x72,
> > > > >
> > > > > +   /*
> > > > > +    * 64 bit inode number.
> > > > > +    */
> > > > > +   FILEID_INO64 =3D 0x80,
> > > > > +
> > > > >     /*
> > > > >      * 64 bit inode number, 32 bit generation number.
> > > > >      */
> > > > > @@ -131,6 +136,12 @@ enum fid_type {
> > > > >      * Filesystems must not use 0xff file ID.
> > > > >      */
> > > > >     FILEID_INVALID =3D 0xff,
> > > > > +
> > > > > +   /* Internal kernel fid types */
> > > > > +
> > > > > +   /* pidfs fid types */
> > > > > +   FILEID_PIDFS_FSTYPE =3D 0x100,
> > > > > +   FILEID_PIDFS =3D FILEID_PIDFS_FSTYPE | FILEID_INO64,
> > > >
> > > > What is the point behind having FILEID_INO64 and FILEID_PIDFS separ=
ately?
> > > > Why not just allocate one value for FILEID_PIDFS and be done with i=
t? Do
> > > > you expect some future extensions for pidfs?
> > >
> > > I wouldn't rule it out, yes. This was also one of Amir's suggestions.
> >
> > The idea was to parcel the autonomous fid type to fstype (pidfs)
> > which determines which is the fs to decode the autonomous fid
> > and a per-fs sub-type like we have today.
> >
> > Maybe it is a bit over design, but I don't think this is really limitin=
g us
> > going forward, because those constants are not part of the uapi.
>
> OK, I agree these file handles do not survive reboot anyway so we are fre=
e
> to redefine the encoding in the future. So it is not a big deal (but it
> also wouldn't be a big deal to start simple and add some subtyping in the
> future when there's actual usecase). But in the current patch set we have
> one flag FILEID_IS_AUTONOMOUS which does provide this subtyping and then
> this FILEID_PIDFS_FSTYPE which doesn't seem to be about subtyping but abo=
ut
> pidfs expecting some future extensions and wanting to recognize all its
> file handle types more easily (without having to enumerate all types like
> other filesystems)? My concern is that fh_type space isn't that big and i=
f
> every filesystem started to reserve flag-like bits in it, we'd soon run o=
ut
> of it. So I don't think this is a great precedens although in this
> particular case I agree it can be modified in the future if we decide so.=
..
>

Yes, I agree.
For the sake of argument let's assume we have two types to begin with
pidfs and drm and then would you want to define them as:

   /* Internal kernel fid types */
   FILEID_PIDFS =3D 0x100,
   FILEID_DRM =3D 0x200,

Or

   FILEID_PIDFS =3D 0x100,
   FILEID_DRM =3D 0x101,

I think the former is easy to start with and we have plenty of time to
make reparceling if we get to dousens and file id type...

Regarding the lower bits, I think it would be wise to reserve

FILEID_PIDFS_FSTYPE =3D 0x100,
FILEID_PIDFS_ROOT =3D FILEID_PIDFS_FSTYPE | FILEID_ROOT /* also 0x100 */

This is why I suggested using non zero lower bits and then why
not use the actual format descriptor for the lower bits as it was intended.

Thanks,
Amir.

