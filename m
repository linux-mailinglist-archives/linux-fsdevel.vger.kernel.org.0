Return-Path: <linux-fsdevel+bounces-24497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4509D93FC78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDCF1C21CBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E5517CA1A;
	Mon, 29 Jul 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="3D97LNd3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9881204
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274275; cv=none; b=HLWpvCZAk2yIoNtA22d1gR0d3Vvza+cFMKbVYiBvMdNikziURSGOpxkYrWLwVN3ArH/+aG55AMTRrU7M+vfYlMdMTHguGKj6vdaOITyEW5T6bOQOCP2iV72adNxrj43Fk7WNToNK3MSxWZq5RCyjhGB1sAMsaWNsuMcZckk74yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274275; c=relaxed/simple;
	bh=WoUrhf40bjWGMtskgrHHDvIfq9IkATgV5ty92feMTfc=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Zegc9ianI8YDl0Lc/TBZ5/bsFbNvXBlGbF+Iu3XT8fLVoAaMnmCnrgy6Uvb6v+TSTXWIswnx49NqCR7m8T+HPHtXAabAilwwNa5cDFTA3LnV7aiIDjzziMVtUT4Mm5wEeUJTy0p5QSpNQap+K2w5qZhBcUqF2vHBCY4Wi062HkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=3D97LNd3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ab34117cc2so2423488a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1722274272; x=1722879072; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4F+EGmOaofx3SoQmtfy/eVIHOP5G6aBCrdClrVrUU=;
        b=3D97LNd3QkDwqgFbPSNWsWfjSc2Hnp1sgMTSnTc7l9Rxg34QHaG1lx6GR+B3UW1IEA
         fYpVum+rLy/GhdgYaHKiS6fFRt/Cv/J/H2bLK86cqnGi/ilxH1YBN7izF+EF4w4cHWjE
         fjjwS0P+KBEENZZmNFemq0JkPF60ZePVRnKlP7iUYWnvONfnZ4lAChFohlquUdZsJ8pl
         auGAthU1BXGZ601cBnXm+HnPq290IixU01mdkGQlPBkDJ/rSInVaAAaDSWZ+EaUCCK4M
         +FcoJyoBLr+dcuo7OtB4pfIvfjq8zrKtdT58xfrhbHQZ0DgCYRIgeWY5m7CxE/bRXQ90
         2sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722274272; x=1722879072;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4F+EGmOaofx3SoQmtfy/eVIHOP5G6aBCrdClrVrUU=;
        b=MXdD5RMdQjDzC+PN+W/3dQcIxEKJC6GjfRXXeyvQskariMTGyPl4s/s2itx+lXuRrf
         NDZIBdvHwnNe6EkCVInnAnYySQUKP/4EoHcncuA8tTJ+oJQwSeGR+vvZxemXDsviskos
         kyG1kKQdUT1ZinNZEmA7TeSC4jgRqHHocjkrxG7gIWoWBnPERCmBUVTTfxyDPzkJ0jus
         pxwABbRl8H73OiNbmjCWqt+UzcteRGU4LlNHr83DMLJwVRfW+dTX7+1wPtixv3ePx95Q
         pxOsxrC5FQHjknJ6uGhXMNPnQIhezFekvPEzp3SvoHL/jQz2/z1jENOpkrUH8BFaMvRH
         /ahw==
X-Gm-Message-State: AOJu0YzoY9ReY8ZQ66sewzRY0D3WRIfCiZByPxK/YFhMLQw+i1Tpng+g
	NwOIYKRD7IlMC5S1fdNPczfUr/cF8zzsiDfGsqSRj4CvgwubNXq0r/ZDcaFzxfM=
X-Google-Smtp-Source: AGHT+IFjBJLCeGZeAw8972pnNWHpj6MNoQqGvixL9dWbRZyP+S/HQary+4djpg9Vp1C9x0YrcuALSw==
X-Received: by 2002:a05:6a21:150c:b0:1c0:e925:f3e1 with SMTP id adf61e73a8af0-1c4a14fcdebmr9862474637.50.1722274272370;
        Mon, 29 Jul 2024 10:31:12 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8751ab7sm6367572a12.42.2024.07.29.10.31.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:31:11 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <5DBD1307-465D-4145-A42E-36AD04BB41A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FC0ABA21-D857-4BDF-8F10-1BC72B11C33F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why do very few filesystems have umount helpers
Date: Mon, 29 Jul 2024 11:31:17 -0600
In-Reply-To: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>
To: Steve French <smfrench@gmail.com>
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_FC0ABA21-D857-4BDF-8F10-1BC72B11C33F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 28, 2024, at 1:09 PM, Steve French <smfrench@gmail.com> wrote:
> 
> I noticed that nfs has a umount helper (/sbin/umount.nfs) as does hfs
> (as does /sbin/umount.udisks2).  Any ideas why those are the only
> three filesystems have them but other fs don't?

I think one of the reasons for this is that *unmount* helpers have been
available only for a relatively short time compared to *mount* helpers,
so not nearly as many filesystems have created them (though I'd wanted
this functionality on occasion over the years).

> Since umount does not notify the filesystem on unmount until
> references are closed (unless you do "umount --force") and therefore
> the filesystem is only notified at kill_sb time, an easier approach to
> fixing some of the problems where resources are kept around too long
> (e.g. cached handles or directory entries etc. or references on the
> mount are held) may be to add a mount helper which notifies the fs
> (e.g. via fs specific ioctl) when umount has begun.   That may be an
> easier solution that adding a VFS call to notify the fs when umount
> begins.

I don't think that would be easier in the end, since you still need to
change the kernel code to handle the new ioctl, and coordinate the umount
helper to call this ioctl in userspace, rather than just have the kernel
notify that an unmount is being called.

One potential issue is with namespaces and virtualization, which may
"unmount" the filesystem pretty frequently, even though the filesystem
on the host is kept mounted the whole time.  If the host filesystem is
flushing its cache "in anticipation" of being fully unmounted, but is
actually servicing dozens of guests, then it could be a significant hit
to system performance each time a guest/container starts and stops.

Cheers, Andreas

> As you can see from fs/namespace.c there is no mount
> notification normally (only on "force" unmounts)
> 
>        /*
>         * If we may have to abort operations to get out of this
>         * mount, and they will themselves hold resources we must
>         * allow the fs to do things. In the Unix tradition of
>         * 'Gee thats tricky lets do it in userspace' the umount_begin
>         * might fail to complete on the first run through as other tasks
>         * must return, and the like. Thats for the mount program to worry
>         * about for the moment.
>         */
> 
>        if (flags & MNT_FORCE && sb->s_op->umount_begin) {
>                sb->s_op->umount_begin(sb);
>        }
> 
> 
> Any thoughts on why those three fs are the only cases where there are
> umount helpers? And why they added them?
> 
> I do notice umount failures (which can cause the subsequent mount to
> fail) on some of our functional test runs e.g. generic/043 and
> generic/044 often fail to Samba with
> 
>     QA output created by 043
>    +umount: /mnt-local-xfstest/scratch: target is busy.
>    +mount error(16): Device or resource busy


Cheers, Andreas






--Apple-Mail=_FC0ABA21-D857-4BDF-8F10-1BC72B11C33F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAman0eUACgkQcqXauRfM
H+Dyrw/+KYVvg8287QIU7mnX40kwGjAYFGFa6n97jUXc4t2MuCal6iubNvPJujNW
gGxe/TRTcShB+63XfjDlGcbugxgBxSPZrdK92/0GuEp2YsuqtK21TLd3Ht2QDkRx
cLPkq/ctRugO6TU1ToYqRRZmlGReyyDekbREI0Dw+gSlEMC7uKNAKFhYQ44y8MC4
nJdH8t09QTFrSxsqlFqZi6rIX8RmSQy4iAC6M3/Vci5sBTytNXfqehMRjvuBL2G6
7fb8u+pH2zwEUJEz3LkNZGGRAPBq1s/jl7Lk1Prn40IEwAmNv6mbcY25dss68cxm
hVn2GMaI5rBMfjHHpDAcY3RHKNs/g+wQGixF9Aey2h9FEdO2KKdtN4zjWYPBcFL6
tJyRwu596hEeO2XQRBn0oz6GEJmghr5ODFFIqRTfSLjtZM5LdKa5IDPCoaxhk+O2
0P1H33VkzXRCVxDKNk5izqrcnUatN8TWu1ZrRLVyS6ANX/WzDWXwmNUbZYQ0kyGJ
VQjju5FLbUUJPJlKQ1u/Sl+oHHshxEYmJW2Z+2WJm8qfV6jDK+THx40PXFAp4+l5
Y8ygL+/jiPrPTnosXy+bCVL0OU7BYx4cfk6fCOikg42GlO/nrFo8ROWLRzd6hhtV
pa9UsjoqlJBUJ9LnN5smEMFXN/FJknWR3jV9Kjv/YPUQpM79YUE=
=vse+
-----END PGP SIGNATURE-----

--Apple-Mail=_FC0ABA21-D857-4BDF-8F10-1BC72B11C33F--

