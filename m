Return-Path: <linux-fsdevel+bounces-38301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F379FF076
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 17:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADEA18821EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA9C1632CA;
	Tue, 31 Dec 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Deoy8mmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEC1C683
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735661028; cv=none; b=ooqSGXv+95g43Cxs9lNAvdVZj+Gker9tARCWyk1VlqzkbAXf6EwD1rWEMLe9yhqswUwk3uEVOKBWP0xRqu/ckY7IwwNjHSc9OEqYuKTAX2pTvX5R2E/OyV9BKop097ZO1v8zhdekU5/CbolJ1KwInDSYoypz4ZAcHxmgIksUNaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735661028; c=relaxed/simple;
	bh=NKjcF4zDPGV6Q8WaTBtq207lZ5RPwc/wIEbc/MTpBHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB/6vFMsgKBCjJg/aq/VPkxnS0tS5n4RqCUFykkQ1enNIkd1Vr7W9eeqSt0Bdw+XsZ14IvlG+jiqfR4WGQgY7Cr4BqJFuFzkhrsnpu0RVQV5ZgFe7QDUQ+ZtheFwZ4JmHsPStdnIivdHAFGhsBx5G4Z55NPszMQeFpqdnieU7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Deoy8mmj; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so1464384a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735661025; x=1736265825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I9GSlwy/U4IbYRKnrsurDugQREc4hcmXrorKd1XERHQ=;
        b=Deoy8mmjZAhLtmZ+cmCDSk+i9thCoOXWNxicwL6APitV8RsjFukYAtzGg/OxglAF4F
         mqgnFxSAnvZ8CgAGjZ2vE5eX3iz9x15tJxYEkJxuUZtYttGj81yel8IlU4ekJD/H8Zha
         +V10jDwpI+ebCeZaVnUW3KkMUH+QPOU9FDe07rNIU+v6R2+LE+ojltfYbY6IdZw61fjO
         nTwHTT+HRZC0KSgfhc0xi2+BwoeGaqqDKo+8Hrxp4XYKkD0hUlDqsyl0hBVrDIhUAYR/
         LOjaR5sM2q2LiimFuMuiK7mDO0/vb7Xizcb/UjzLCq/FlFUv73moKOctAAPeUWn+YVSo
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735661025; x=1736265825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9GSlwy/U4IbYRKnrsurDugQREc4hcmXrorKd1XERHQ=;
        b=Wt3DTTq/SR0m7Nsqoz+MsMAyZ4eSGL5NAKRS1ENWpc2JerE7Y/lO/8YT0uZ29z0yQv
         EjtiMpDEtSSbTCoSMD4oRi4E7insLy49xKugR/DRyhdL+ZUsMkcT/UzG0Vu6VbjbTlSh
         Rxcw7sIbeFfabJ5D8qyNRFtD+Gq9WSrVJ7AIAV6xADgLBdiq0hRy4KSKQa+Ha3/NeO+T
         BHSF86UTHkHIk7mfGBDEPkhsIJykqLIL7FdgHwt+7OEjDCki7W66vMT1/nkuQCDK3yn/
         /GVVwhDhBe1z0I8t3wtmpMqXoJ7aRuPOt5aN72s/03bdEcvk95BG7sz5RBf2COoWpTND
         jMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq/WmXWkbEgPdaABb9juYHpkClZlLAe6Nds7fPzyQBI31C2WkueeHfivfA/f4taDyShzYDS2b9+PgXyTE4@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLjjVlQ+lXRHa0fE3mgtrsL0B2ctAexFSWzGqRJx8JotilLTs
	Dcfkax6oK9gk+wfuhyLam7R6DoarJEYY0y83GVzKiCHuskrN3x5lvXTSv27+dlgdl2YsrgIHgit
	ZC9DqZjkzauKwZ3c7aFa8OqfwV1VviAvgKZ4=
X-Gm-Gg: ASbGnctnwFY/3hxrAJciDc8vft3etcOBzNtgi77kJWxCLfPgRiJ+F+v2KI3/Fjf2Xnp
	W8q73Q5MIX0ux431mladcLdnXF7XkDu45lzHlug==
X-Google-Smtp-Source: AGHT+IFDMjV+BnL9+Q0FZoDY9KwhCevJcMXBFzfWjKWff5IH3/56an0CrIeS0e7JuONJV2qygdqpNBl2uVXlKPWKBkM=
X-Received: by 2002:a05:6402:50c6:b0:5d0:81dc:f20e with SMTP id
 4fb4d7f45d1cf-5d81dd99512mr36169150a12.17.1735661024144; Tue, 31 Dec 2024
 08:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
 <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com> <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
In-Reply-To: <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 31 Dec 2024 17:03:32 +0100
Message-ID: <CAOQ4uxhch3DUj3BtYBaZx6X3Jvpw4OqjcdnkXA_qQh2AQwAo1A@mail.gmail.com>
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Prince Kumar <princer@google.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>
Content-Type: multipart/mixed; boundary="000000000000cba6d9062a9312d9"

--000000000000cba6d9062a9312d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 4:36=E2=80=AFAM Prince Kumar <princer@google.com> w=
rote:
>
> Thanks Bernd for looking into this!
>
> I think 6.9 added passthrough support. Are you using that?
> > Not yet, but we have plans to try this out.
>
> FOPEN_CACHE_DIR is default when there is no fuse-server open method
> defined - does your implementation have an open/dir_open?
> > Yes, here is the implementation in GCSFuse (internally uses jacobsa/fus=
e library) - https://github.com/GoogleCloudPlatform/gcsfuse/blob/b0ca9c5b2c=
0a35aeb8a48fe7a36120d7b33216aa/internal/fs/fs.go#L2328
> Here, op.CacheDir maps to FOPEN_CACHE_DIR and op.KeepCache maps to
> FOPEN_KEEP_CACHE.
>
> I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
> that always checks if it is set - either the flag gets set or does not
> come into role at all, because passthrough is used?
> > Being honest, I don't have much idea of linux source code. As a user, t=
o me the FOPEN_CACHE_DIR flag is working as expected.
> The problem is with the FOPEN_KEEP_CACHE flags, setting this should
> evict the dir cache, but it's not happening for linux 6.9.x and above.
> Although I see  a line in fs/fuse/dir.c
> (https://github.com/torvalds/linux/blob/ccb98ccef0e543c2bd4ef1a7227046195=
7f3d8d0/fs/fuse/dir.c#L718)
> which invalidates the inode pages if FOPEN_KEEP_CACHE is not set.
>
> So my ultimate question would be:
> (1) Do you see such recent changes in fs/fuse which explains the above
> regression?
> (2) If the changes are intentional, what should be the right way for
> fuse-server to evict the dir-cache (other than auto eviction due to
> change in dir-content, e.g., addition of new file inside a dir)?
>

Hi Prince,

The change is not international.
It is a regression due to commit
7de64d521bf92 ("fuse: break up fuse_open_common()") that missed the fact
the fuse_dir_open() may need to clean the page cache.

Can you test the attached fix patch?
It is only compile tested.
Due to holidays, I had no time to verify the fix.

Thanks,
Amir.

--000000000000cba6d9062a9312d9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fuse-respect-FOPEN_KEEP_CACHE-on-opendir.patch"
Content-Disposition: attachment; 
	filename="0001-fuse-respect-FOPEN_KEEP_CACHE-on-opendir.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m5cnpyc50>
X-Attachment-Id: f_m5cnpyc50

RnJvbSBjOGY1MDA2NzlmMGQyOGYzN2VmM2Q3NzU1ZmYxMzE3ODhjNDc0MDhkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDMxIERlYyAyMDI0IDE2OjU1OjI0ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZnVz
ZTogcmVzcGVjdCBGT1BFTl9LRUVQX0NBQ0hFIG9uIG9wZW5kaXIKClRoZSByZS1mYWN0b3Jpbmcg
b2YgZnVzZV9kaXJfb3BlbigpIG1pc3NlZCB0aGUgbmVlZCB0byBpbnZhbGlkYXRlCmRpcmVjdG9y
eSBpbm9kZSBwYWdlIGNhY2hlIHdpdGggb3BlbiBmbGFnIEZPUEVOX0tFRVBfQ0FDSEUuCgpGaXhl
czogN2RlNjRkNTIxYmY5MiAoImZ1c2U6IGJyZWFrIHVwIGZ1c2Vfb3Blbl9jb21tb24oKSIpClJl
cG9ydGVkLWJ5OiBQcmluY2UgS3VtYXIgPHByaW5jZXJAZ29vZ2xlLmNvbT4KQ2xvc2VzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsL0NBRVc9VFJyN0NZYjRMdHN2UVBMai16
eDVZK0VZQm1HZk0yNFN1end5RG9HVk5vS203d0BtYWlsLmdtYWlsLmNvbS8KU2lnbmVkLW9mZi1i
eTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KLS0tCiBmcy9mdXNlL2Rpci5j
IHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Zz
L2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDQ5NGFjMzcyYWNlMDcuLmU1NDBkMDU1
NDlmZmYgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZGlyLmMKKysrIGIvZnMvZnVzZS9kaXIuYwpAQCAt
MTY4MSw2ICsxNjgxLDggQEAgc3RhdGljIGludCBmdXNlX2Rpcl9vcGVuKHN0cnVjdCBpbm9kZSAq
aW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQogCQkgKi8KIAkJaWYgKGZmLT5vcGVuX2ZsYWdzICYg
KEZPUEVOX1NUUkVBTSB8IEZPUEVOX05PTlNFRUtBQkxFKSkKIAkJCW5vbnNlZWthYmxlX29wZW4o
aW5vZGUsIGZpbGUpOworCQlpZiAoIShmZi0+b3Blbl9mbGFncyAmIEZPUEVOX0tFRVBfQ0FDSEUp
KQorCQkJaW52YWxpZGF0ZV9pbm9kZV9wYWdlczIoaW5vZGUtPmlfbWFwcGluZyk7CiAJfQogCiAJ
cmV0dXJuIGVycjsKLS0gCjIuMzQuMQoK
--000000000000cba6d9062a9312d9--

