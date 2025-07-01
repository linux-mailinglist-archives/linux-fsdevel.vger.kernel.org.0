Return-Path: <linux-fsdevel+bounces-53524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305CAEFC05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C228D487D23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF727A933;
	Tue,  1 Jul 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YixW7GGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAE2798FB;
	Tue,  1 Jul 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379390; cv=none; b=Zi7V4johC1l2FYiGDDaQIoZQ4XoMPjTw7tB1xj5rInXdGn0OTTasxob4YNCJKxsAnhh0Gkg2qI12ess4crtaMPT09WBsNaY1aqfN8x0CyUZDw8wKVout4QcuM0ii3+bW3SQ12Ch9hqpHBu2jpSXWpZuCF9HoOjkkczOV6hJNP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379390; c=relaxed/simple;
	bh=opnetTzEqSI8nfAjX3dcvSAkF20HA784Ujkzgdxg09s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcB6ZK/JzrpmdL9nHjBbrNk6nHQUbvxWdo52cywPUDPutewiYm0n6buL6JxzPrubsQoiGzQCyp/6/AdClISNTcAyIfO00Z48X4Acnl9pVDtIObuC7awyBny7qNuLiYpp51BHfwEuvkkqSkIHvDXIITTSGyrheJgCblib2Xe7lKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YixW7GGa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae223591067so577381666b.3;
        Tue, 01 Jul 2025 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379386; x=1751984186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DiLWWWTAl87647oLhK7vXbCdzk2u4rSNDXemJ0QmuA=;
        b=YixW7GGaSzWmqdn3FLG39rQp4Ud05GQr5+zpgqyqGz6E5HVT4YmJzKayW8boAREDYn
         7UftjjTU02Doyi/rduJ3a11ipM8F0wgg9WqTsWcc6mzI58BnxsOprLJi/Vi6A19QeRVt
         iff5rIzPEGYVwl9wkEYwT1LrFxrFBFfWOwKwe7vI6B2PkD5xbXCJpsm/8Mav66AZLQvC
         CET0kU115Mszr0mTrNT788+BYQb9ahApqLEzQZ17vdHutc5geR4p0wzl/ztJwdJPLzqS
         2f7UzbEyHz/7mhDQgvtrSZTClVTxe7Lthk2XfIGjeTKERkzuuA5DNF8Om4HAD2Zr+VxA
         yT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379386; x=1751984186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DiLWWWTAl87647oLhK7vXbCdzk2u4rSNDXemJ0QmuA=;
        b=nwkcgdIPOwRtHTO4ZIOEKBO+F2sCY6vBu4z7OiGChFjG55Dvj+DvF8SzPPYkcMgojP
         OTUyqwiKN7SILAaUvioSDzx+DAPkOT64kxq6hR/7AU0si8i+zwOA99vUsQz5/tvq4na0
         dboq6e8fZZ8P83kMJesWBHNCmjA43l3mK0/AtYr/gkzCzbdImtekUB3u90NF9StrInLW
         RY5q8tGWluc70XopJ3K9G3xYMGg3EERl1CxdvMfa8haS3lzgOGhBr92BKty2BXV8wmry
         FOg6dTpXjSY9EP66I1HQPAtmYPUQN/PIIN/pAC7JlW8Ako4DpCPkB7aVzXMVVPHXUCGJ
         LMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8a0CySHRItOHxehB970zf4lkBkGicQqfq86zJdL3FRGAaM0ZGmiKSIA7VgQ/8LBS9kjINnDhOgY+G@vger.kernel.org, AJvYcCVVsxAjSFRYXXhZarFtseMbiAH88LreMbyDa5AEsEvl0ld2dJRKV7n2S280L517J1M/vt1cSeu5ZTo=@vger.kernel.org, AJvYcCVc5zk3L1s5HLQjSOJevpBS8N+K+ld5XJL2I9fvn/tSVuSYxdTgsUEUs7cOYnT9auPXWjjXrJ7F4uHf3HQH@vger.kernel.org, AJvYcCWClLQc7UGgddPKnA00BLPI1PuHaQ//gwTA6nWgEpHP+lF6oZHyF24eV3kh2O+ZHbj9oWxJRkvJNQ==@vger.kernel.org, AJvYcCXAyCUjIIQKTFJPVU9qB6jwPNtIm1De7+n91/DbHM8w2GwfvpdZAUxaq9AC0aT+OVAKUawwXNy3eZX3sax+gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUWO/Hq1tRbfHoB1aF/YZusxtIMFQwOBZT724nIcCP1ZrAbSC
	mclp43VOisECu0Qy1DKR1KiyvOdVMZ4iWdeAojUHNgbSMmDV149t0y8sv0kN6gQFQPNqdPXXC5W
	a+VKUUGo0+6r/i2/sJN/CbFThq8NlPos=
X-Gm-Gg: ASbGncvILDHjLeLf8P6zpUuCe0BtE/LZp9Ni/TTpwFeK0P0wHOIuFx6hF3mYpvcFYsr
	ipv68Y4IWl1EL7IlK4bxJMjbRY3TKaomiCvvUNNCe0cpGVeaWOWYgs3Q4I9yBNCRPvkMWc/shwt
	xhXRTzvQvoUe6vRrnsVPWebQI1T3AB7wOGXFELP7hzvO/JW8H7x/mr2Q==
X-Google-Smtp-Source: AGHT+IExL0USiABTSMqYLTui/Nj2BbMzBWIcX+hzwzcIv1r5t+NBbuTb2QESaxkCUab/7rZ19/dSWN/0JPksKaH3/Co=
X-Received: by 2002:a17:907:7e8a:b0:ae3:b5c6:4d6c with SMTP id
 a640c23a62f3a-ae3b5c65147mr201077966b.43.1751379385667; Tue, 01 Jul 2025
 07:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org> <CAOQ4uxgbeMEqx7FtBc3KnrCjOHHRniSjBPLzk7_S9SjYKcY_ag@mail.gmail.com>
 <ozxxm5fglq5kuoiteqr34wghaqhxgue4kshz2jnnk7oopmhxk6@a2lo6weivsyz>
In-Reply-To: <ozxxm5fglq5kuoiteqr34wghaqhxgue4kshz2jnnk7oopmhxk6@a2lo6weivsyz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 16:16:13 +0200
X-Gm-Features: Ac12FXwKBREmBs-fWZtiuT1yk0gj2b76cKsQsQgoRyzkaLrSaYJvhifpASRz3lQ
Message-ID: <CAOQ4uxj22du-+8vmkSq3V8C22y7hEGhOHqryAck9yuB1V3spow@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
To: Jan Kara <jack@suse.cz>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000269fb60638deca8a"

--000000000000269fb60638deca8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 2:51=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 01-07-25 08:05:45, Amir Goldstein wrote:
> > On Mon, Jun 30, 2025 at 6:20=E2=80=AFPM Andrey Albershteyn <aalbersh@re=
dhat.com> wrote:
> > >
> > > Future patches will add new syscalls which use these functions. As
> > > this interface won't be used for ioctls only, the EOPNOSUPP is more
> > > appropriate return code.
> > >
> > > This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> > > vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> > > EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.=
c.
> > >
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ...
> > > --- a/fs/overlayfs/inode.c
> > > +++ b/fs/overlayfs/inode.c
> > > @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *real=
path, struct fileattr *fa)
> > >                 return err;
> > >
> > >         err =3D vfs_fileattr_get(realpath->dentry, fa);
> > > -       if (err =3D=3D -ENOIOCTLCMD)
> > > +       if (err =3D=3D -EOPNOTSUPP)
> > >                 err =3D -ENOTTY;
> > >         return err;
> > >  }
> >
> > That's the wrong way, because it hides the desired -EOPNOTSUPP
> > return code from ovl_fileattr_get().
> >
> > The conversion to -ENOTTY was done for
> > 5b0a414d06c3 ("ovl: fix filattr copy-up failure"),
> > so please do this instead:
> >
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path
> > *realpath, struct fileattr *fa)
> >
> >         err =3D vfs_fileattr_get(realpath->dentry, fa);
> >         if (err =3D=3D -ENOIOCTLCMD)
> > -               err =3D -ENOTTY;
> > +               err =3D -EOPNOTSUPP;
>
> Is this really needed? AFAICS nobody returns ENOIOCTLCMD after this
> patch...

you are right it is not needed

Attaching the patch with missing bits of fuse and overlayfs to make this
conversion complete.

Christian, please squash my patch
and afterward make sure there is no conversion remaining in
ovl_real_fileattr_get() as well as in ecryptfs_fileattr_get()
Both those helpers should return the value they
got from vfs_fileattr_get() as is.

Thanks,
Amir.

--000000000000269fb60638deca8a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fuse-return-EOPNOTSUPP-from-fileattr_-gs-et-instead-.patch"
Content-Disposition: attachment; 
	filename="0001-fuse-return-EOPNOTSUPP-from-fileattr_-gs-et-instead-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcklwtsq0>
X-Attachment-Id: f_mcklwtsq0

RnJvbSA4NWQwOTdmNjM5NTE4NjcwYzU3ODI3NTEzYjAyZjQ5Nzk1MDA3MWRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEgSnVsIDIwMjUgMTY6MDY6NDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmdXNl
OiByZXR1cm4gLUVPUE5PVFNVUFAgZnJvbSAtPmZpbGVhdHRyX1tnc11ldCgpIGluc3RlYWQgb2YK
IC1FTk9UVFkKCkFzIHBhcnQgb2YgY2hhbmdpbmcgY2FsbGluZyBjb252ZW5zdGlvbiBvZiAtPmZp
bGVhdHRyX1tnc11ldCgpCnRvIHJldHVybiAtRU9QTk9UU1VQUCBhbmQgZml4IHJlbGF0ZWQgb3Zl
cmxheWZzIGNvZGUuCgpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21h
aWwuY29tPgotLS0KIGZzL2Z1c2UvaW9jdGwuYyAgICAgICAgfCA0ICsrKysKIGZzL292ZXJsYXlm
cy9jb3B5X3VwLmMgfCAyICstCiBmcy9vdmVybGF5ZnMvaW5vZGUuYyAgIHwgMiArLQogMyBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvZnVzZS9pb2N0bC5jIGIvZnMvZnVzZS9pb2N0bC5jCmluZGV4IDJkOWFiZjQ4ODI4Zi4uZjI2
OTJmN2Q1OTMyIDEwMDY0NAotLS0gYS9mcy9mdXNlL2lvY3RsLmMKKysrIGIvZnMvZnVzZS9pb2N0
bC5jCkBAIC01MzYsNiArNTM2LDggQEAgaW50IGZ1c2VfZmlsZWF0dHJfZ2V0KHN0cnVjdCBkZW50
cnkgKmRlbnRyeSwgc3RydWN0IGZpbGVhdHRyICpmYSkKIGNsZWFudXA6CiAJZnVzZV9wcml2X2lv
Y3RsX2NsZWFudXAoaW5vZGUsIGZmKTsKIAorCWlmIChlcnIgPT0gLUVOT1RUWSkKKwkJZXJyID0g
LUVPUE5PVFNVUFA7CiAJcmV0dXJuIGVycjsKIH0KIApAQCAtNTcyLDUgKzU3NCw3IEBAIGludCBm
dXNlX2ZpbGVhdHRyX3NldChzdHJ1Y3QgbW50X2lkbWFwICppZG1hcCwKIGNsZWFudXA6CiAJZnVz
ZV9wcml2X2lvY3RsX2NsZWFudXAoaW5vZGUsIGZmKTsKIAorCWlmIChlcnIgPT0gLUVOT1RUWSkK
KwkJZXJyID0gLUVPUE5PVFNVUFA7CiAJcmV0dXJuIGVycjsKIH0KZGlmZiAtLWdpdCBhL2ZzL292
ZXJsYXlmcy9jb3B5X3VwLmMgYi9mcy9vdmVybGF5ZnMvY29weV91cC5jCmluZGV4IGQ3MzEwZmNm
Mzg4OC4uMmM2NDZiNzA3NmQwIDEwMDY0NAotLS0gYS9mcy9vdmVybGF5ZnMvY29weV91cC5jCisr
KyBiL2ZzL292ZXJsYXlmcy9jb3B5X3VwLmMKQEAgLTE3OCw3ICsxNzgsNyBAQCBzdGF0aWMgaW50
IG92bF9jb3B5X2ZpbGVhdHRyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IHN0cnVjdCBwYXRo
ICpvbGQsCiAJZXJyID0gb3ZsX3JlYWxfZmlsZWF0dHJfZ2V0KG9sZCwgJm9sZGZhKTsKIAlpZiAo
ZXJyKSB7CiAJCS8qIE50ZnMtM2cgcmV0dXJucyAtRUlOVkFMIGZvciAibm8gZmlsZWF0dHIgc3Vw
cG9ydCIgKi8KLQkJaWYgKGVyciA9PSAtRU5PVFRZIHx8IGVyciA9PSAtRUlOVkFMKQorCQlpZiAo
ZXJyID09IC1FT1BOT1RTVVBQIHx8IGVyciA9PSAtRUlOVkFMKQogCQkJcmV0dXJuIDA7CiAJCXBy
X3dhcm4oImZhaWxlZCB0byByZXRyaWV2ZSBsb3dlciBmaWxlYXR0ciAoJXBkMiwgZXJyPSVpKVxu
IiwKIAkJCW9sZC0+ZGVudHJ5LCBlcnIpOwpkaWZmIC0tZ2l0IGEvZnMvb3ZlcmxheWZzL2lub2Rl
LmMgYi9mcy9vdmVybGF5ZnMvaW5vZGUuYwppbmRleCA2ZjBlMTVmODZjMjEuLjkyNzU0NzQ5ZjMx
NiAxMDA2NDQKLS0tIGEvZnMvb3ZlcmxheWZzL2lub2RlLmMKKysrIGIvZnMvb3ZlcmxheWZzL2lu
b2RlLmMKQEAgLTcyMiw3ICs3MjIsNyBAQCBpbnQgb3ZsX3JlYWxfZmlsZWF0dHJfZ2V0KGNvbnN0
IHN0cnVjdCBwYXRoICpyZWFscGF0aCwgc3RydWN0IGZpbGVhdHRyICpmYSkKIAogCWVyciA9IHZm
c19maWxlYXR0cl9nZXQocmVhbHBhdGgtPmRlbnRyeSwgZmEpOwogCWlmIChlcnIgPT0gLUVOT0lP
Q1RMQ01EKQotCQllcnIgPSAtRU5PVFRZOworCQllcnIgPSAtRU9QTk9UU1VQUDsKIAlyZXR1cm4g
ZXJyOwogfQogCi0tIAoyLjQzLjAKCg==
--000000000000269fb60638deca8a--

