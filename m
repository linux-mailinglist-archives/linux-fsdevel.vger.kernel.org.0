Return-Path: <linux-fsdevel+bounces-50813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B87ACFC75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705641699B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252224EA8F;
	Fri,  6 Jun 2025 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiyqEgn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D311E8337;
	Fri,  6 Jun 2025 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190670; cv=none; b=aVVbAsO37uju9RxMgzEAYI1yL2lzTxx+4XIfV5Es6+DQAC6FHKFAst0SdPicEnBM77cLB01eMneoCOvpZIw4gPHcRjDGXBBbbRs9+v8vHEJgt3PVzOxInNa9KX1KH5zIOUstVNzq77CR7gKZAsR/MInSUMsf4HlR/CV2mI88nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190670; c=relaxed/simple;
	bh=SF9pnJKnNvJt5GB/TJXAodAn4YH5J/lqxYSi0zGmEng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHUX/klzUo86GxRTo+KeF701nGDdzdLWxqgT54YL3oFWKxXzGPx0TnWAyS1EoUzCRhc4wPin+k+coV+Uwf58dZKKKhde5/MzfLHWl7NrisSjyS21F11LAe6KrPS48p7P75SHid5nm6kpuN/yIbrvoDfUffo0X29Z+d2nAcasfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiyqEgn+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so279829866b.2;
        Thu, 05 Jun 2025 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749190666; x=1749795466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nRs08LfcktLWpDpyY7DT8aoE81qqeKAA3VrrevBQiPg=;
        b=WiyqEgn+7qOxGDyNAtI7kzPPVLYSFSCE89WBr8qTyz9tOORLraMWvdaSZDqdqdo9HU
         7nOht99w7R4ofcGrJTYDj5hIiUFBBjEPWob9X51f2BCyS1E7drIA6K0hzwxTCcJ6hnC/
         297YsMpapEIQQJTdmYfltzV2RWQI5LnWf1h8OQ7fCaFvkSOrLFhhgSTT4MAuaWFAPm3M
         ovFbjlp/6pBkrFLa+Yoy0Q4gGRzvFzF5yPei+ZjVHenHO2inPqUdRRB+7PCmkheP+Io4
         WR6KmbEaBO1Q7GVmGIyHLM18FD+vZcGMk7WE1FpTE44ijyAypl5oqQ2jK7JWeRnMqMBo
         waHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749190666; x=1749795466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRs08LfcktLWpDpyY7DT8aoE81qqeKAA3VrrevBQiPg=;
        b=PJuWavu/Z2RTnB8bBSXWG2sSK1oqzlXoMJt8xBmAza1PAEMAhXTCwHTv4IhYGuoDKm
         kk44AjC/2ajmPN+uY957ayKWOdCGdvwzGP4dh8BkVuoU5hryfEatQaNvzNvLYrBSr9UX
         /DVEqrP65GjeU4A4ajGfPS67Zwk7YTBcj/U3VKDJsexSKLA8YBxFRrjTuyCvonSzM/Af
         O6XzBh2V4TXRCDflKFSPeAFLOLynRG1E1+w3w0ubownTuMzPYc1jotjOTABaQeXefQcy
         4dM1FiJ7nCcT+LIAqMSzkap/qn71g6Ah9ZWn0g7FrhZrxHVqBTHYGdtpDcqFg5l4SOPf
         c8+A==
X-Forwarded-Encrypted: i=1; AJvYcCUSLUrEEtMFzMy0z9UPa9PgX70YTCuPUAc7yMRdbOD8ADAlF72c1tL1bfObcWVoPpLFC05v0c1ZIJoRA9ou4w==@vger.kernel.org, AJvYcCUjao9p78FgmV8EC/kJty4h394tL/aKsBRaJfiOe/Asm8OahWUaQsAWoFk2tjPSmetYUaLqkEvXnHFsgrYV@vger.kernel.org, AJvYcCUvubmwFHQBHfGxPkV787/GsyC13JLjf4VeVPLJzwGTR7yWZlg4NrVTl5114S95EBvS58RHqNFcS2IW2DX/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9t2EcNIWHk2u/ywSWbsbsGkkfKGK3fZcwB0HEZy0vnoholRP
	HfG0ZJEl35v0TUgZHxAyufyxpwtysJJ2+DDzpL6rup/EJawrdweJDolkqUV+qbY+yrPpM0Z95Be
	0yfcU/nQMP+M4B/k7VZ9xdPN/nT282ogRV1NBi34=
X-Gm-Gg: ASbGncv2xKCDmFwZPOx1A59oLnL7zefzgOiHcIEwRwryOD1hcqk8iekCoN9GBmzS7DD
	1lcEtFXcEgGhGpRBLnJyp3L99eioEOs/YK2AxzZ81W8WMdxHMgnhjUziP448KjLOAEoIFhjyH2S
	AAGVt0SY0MFv4hTcXQa4S2FxdJbOiknZx8jDGJugugCKQ=
X-Google-Smtp-Source: AGHT+IGsB0y2l3ws0C3uckN6XKQ15qKp9ZgPXIycqjRBr4MIjxZXJ+ylqyulQkJZVox4sKt79ZXGFa40LU8O7+/iens=
X-Received: by 2002:a17:907:9407:b0:adb:4917:3c08 with SMTP id
 a640c23a62f3a-ade1aa159a8mr176880766b.34.1749190665979; Thu, 05 Jun 2025
 23:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
 <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
In-Reply-To: <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 6 Jun 2025 08:17:33 +0200
X-Gm-Features: AX0GCFvaxWmRTk4e0Wx398vHWxelvszP8dEz46XV_bxmSatoU7iUtrjKUfGO7w0
Message-ID: <CAOQ4uxjXvcj8Vf3y81KJCbn6W5CSm9fFofV8P5ihtcZ=zYSREA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004ae1b40636e1301e"

--0000000000004ae1b40636e1301e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:34=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 5 Jun 2025 at 07:51, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > - The above fix contains a cast to non-const, which is not actually
> > needed.  So add the necessary helpers postfixed with _c that allow the
> > cast to be removed (touches vfs files but only in trivial ways)
>

I must have snoozed the review of this one :-/

> Grr.
>
> I despise those "trivial ways".
>
> In particular, I despise how this renames the backing_file_user_path()
> helper to something actively *worse*.
>
> The "_c()" makes no sense as a name. Yes, I realize that the "c"
> stands for "const", but it still makes absolutely zero sense, since
> everybody wants the const version.
>
> The only user of the non-const version is the *ointernal*
> implementation that is never exported to other modules, and that could
> have the special name.
>
> Although I suspect it doesn't even need it, it could just use the
> backing_file(f) macro directly and that should just be moved to
> internal.h, and then the 'const'ness would come from the argument as
> required.
>
> In fact, most of the _internal_ vfs users don't even want the
> non-const version, ie as far as I can tell the user in
> file_get_write_access() would be perfectly happy with the const
> version too.
>
> So you made the *normal* case have an odd name, and then kept the old
> sane name for the case nobody else really wants to see.
>
> If anything, the internal non-const version is the one that should be
> renamed (and *not* using some crazy "_nc()" postfix nasty crud). Not
> the one that gets exported and that everybody wants.
>

IMO, it would be nicer to use backing_file_set_user_path()
(patch attached).

> So I could fix up that last commit to not hate it, but honestly, I
> don't want that broken state in the kernel in the first place.
>

Would you consider pulling ovl-update-6.16^
and applying the attached patch [*]?

Thanks,
Amir.

[*] I did not include the removal of non-const casting to keep this
patch independent of the ovl PR.
Feel free to add it to my patch or I can send the patch post merge
or cleanup of casting post merge.

--0000000000004ae1b40636e1301e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fs-constify-file-ptr-in-backing_file_user_path.patch"
Content-Disposition: attachment; 
	filename="fs-constify-file-ptr-in-backing_file_user_path.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbkerqp50>
X-Attachment-Id: f_mbkerqp50

RnJvbSBiYzc5NDkxYmY2NzFiOGExZDY2MDNlMDM2Nzk2MzM0MTMzOWY5NDNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDYgSnVuIDIwMjUgMDc6NDY6MDIgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmczog
Y29uc3RpZnkgZmlsZSBwdHIgaW4gYmFja2luZ19maWxlX3VzZXJfcGF0aCgpCgpBZGQgaW50ZXJu
YWwgaGVscGVyIGJhY2tpbmdfZmlsZV9zZXRfdXNlcl9wYXRoKCkgZm9yIHRoZSBvbmx5CnR3byBj
YXNlcyB0aGF0IG5lZWQgdG8gbW9kaWZ5IHVzZXIgcGF0aC4KClNpZ25lZC1vZmYtYnk6IEFtaXIg
R29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMvYmFja2luZy1maWxlLmMgIHwg
IDQgKystLQogZnMvZmlsZV90YWJsZS5jICAgIHwgMTMgKysrKysrKystLS0tLQogZnMvaW50ZXJu
YWwuaCAgICAgIHwgIDEgKwogaW5jbHVkZS9saW51eC9mcy5oIHwgIDIgKy0KIDQgZmlsZXMgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9i
YWNraW5nLWZpbGUuYyBiL2ZzL2JhY2tpbmctZmlsZS5jCmluZGV4IDc2M2ZiZTliNzJiMi4uOGM3
Mzk2YmZmMTIxIDEwMDY0NAotLS0gYS9mcy9iYWNraW5nLWZpbGUuYworKysgYi9mcy9iYWNraW5n
LWZpbGUuYwpAQCAtNDEsNyArNDEsNyBAQCBzdHJ1Y3QgZmlsZSAqYmFja2luZ19maWxlX29wZW4o
Y29uc3Qgc3RydWN0IHBhdGggKnVzZXJfcGF0aCwgaW50IGZsYWdzLAogCQlyZXR1cm4gZjsKIAog
CXBhdGhfZ2V0KHVzZXJfcGF0aCk7Ci0JKmJhY2tpbmdfZmlsZV91c2VyX3BhdGgoZikgPSAqdXNl
cl9wYXRoOworCWJhY2tpbmdfZmlsZV9zZXRfdXNlcl9wYXRoKGYsIHVzZXJfcGF0aCk7CiAJZXJy
b3IgPSB2ZnNfb3BlbihyZWFsX3BhdGgsIGYpOwogCWlmIChlcnJvcikgewogCQlmcHV0KGYpOwpA
QCAtNjUsNyArNjUsNyBAQCBzdHJ1Y3QgZmlsZSAqYmFja2luZ190bXBmaWxlX29wZW4oY29uc3Qg
c3RydWN0IHBhdGggKnVzZXJfcGF0aCwgaW50IGZsYWdzLAogCQlyZXR1cm4gZjsKIAogCXBhdGhf
Z2V0KHVzZXJfcGF0aCk7Ci0JKmJhY2tpbmdfZmlsZV91c2VyX3BhdGgoZikgPSAqdXNlcl9wYXRo
OworCWJhY2tpbmdfZmlsZV9zZXRfdXNlcl9wYXRoKGYsIHVzZXJfcGF0aCk7CiAJZXJyb3IgPSB2
ZnNfdG1wZmlsZShyZWFsX2lkbWFwLCByZWFsX3BhcmVudHBhdGgsIGYsIG1vZGUpOwogCWlmIChl
cnJvcikgewogCQlmcHV0KGYpOwpkaWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmls
ZV90YWJsZS5jCmluZGV4IGMwNGVkOTRjZGM0Yi4uOGFjMmZiYmQ0ZjZkIDEwMDY0NAotLS0gYS9m
cy9maWxlX3RhYmxlLmMKKysrIGIvZnMvZmlsZV90YWJsZS5jCkBAIC01MiwxNyArNTIsMjAgQEAg
c3RydWN0IGJhY2tpbmdfZmlsZSB7CiAJfTsKIH07CiAKLXN0YXRpYyBpbmxpbmUgc3RydWN0IGJh
Y2tpbmdfZmlsZSAqYmFja2luZ19maWxlKHN0cnVjdCBmaWxlICpmKQotewotCXJldHVybiBjb250
YWluZXJfb2YoZiwgc3RydWN0IGJhY2tpbmdfZmlsZSwgZmlsZSk7Ci19CisjZGVmaW5lIGJhY2tp
bmdfZmlsZShmKSBjb250YWluZXJfb2YoZiwgc3RydWN0IGJhY2tpbmdfZmlsZSwgZmlsZSkKIAot
c3RydWN0IHBhdGggKmJhY2tpbmdfZmlsZV91c2VyX3BhdGgoc3RydWN0IGZpbGUgKmYpCitzdHJ1
Y3QgcGF0aCAqYmFja2luZ19maWxlX3VzZXJfcGF0aChjb25zdCBzdHJ1Y3QgZmlsZSAqZikKIHsK
IAlyZXR1cm4gJmJhY2tpbmdfZmlsZShmKS0+dXNlcl9wYXRoOwogfQogRVhQT1JUX1NZTUJPTF9H
UEwoYmFja2luZ19maWxlX3VzZXJfcGF0aCk7CiAKK3ZvaWQgYmFja2luZ19maWxlX3NldF91c2Vy
X3BhdGgoc3RydWN0IGZpbGUgKmYsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoKQoreworCWJhY2tp
bmdfZmlsZShmKS0+dXNlcl9wYXRoID0gKnBhdGg7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChiYWNr
aW5nX2ZpbGVfc2V0X3VzZXJfcGF0aCk7CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBmaWxlX2ZyZWUo
c3RydWN0IGZpbGUgKmYpCiB7CiAJc2VjdXJpdHlfZmlsZV9mcmVlKGYpOwpkaWZmIC0tZ2l0IGEv
ZnMvaW50ZXJuYWwuaCBiL2ZzL2ludGVybmFsLmgKaW5kZXggMjEzYmYzMjI2MjEzLi4zODYwYjAy
MmU1N2MgMTAwNjQ0Ci0tLSBhL2ZzL2ludGVybmFsLmgKKysrIGIvZnMvaW50ZXJuYWwuaApAQCAt
MTAxLDYgKzEwMSw3IEBAIGV4dGVybiB2b2lkIGNocm9vdF9mc19yZWZzKGNvbnN0IHN0cnVjdCBw
YXRoICosIGNvbnN0IHN0cnVjdCBwYXRoICopOwogc3RydWN0IGZpbGUgKmFsbG9jX2VtcHR5X2Zp
bGUoaW50IGZsYWdzLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCk7CiBzdHJ1Y3QgZmlsZSAqYWxs
b2NfZW1wdHlfZmlsZV9ub2FjY291bnQoaW50IGZsYWdzLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3Jl
ZCk7CiBzdHJ1Y3QgZmlsZSAqYWxsb2NfZW1wdHlfYmFja2luZ19maWxlKGludCBmbGFncywgY29u
c3Qgc3RydWN0IGNyZWQgKmNyZWQpOwordm9pZCBiYWNraW5nX2ZpbGVfc2V0X3VzZXJfcGF0aChz
dHJ1Y3QgZmlsZSAqZiwgY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpOwogCiBzdGF0aWMgaW5saW5l
IHZvaWQgZmlsZV9wdXRfd3JpdGVfYWNjZXNzKHN0cnVjdCBmaWxlICpmaWxlKQogewpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9mcy5oIGIvaW5jbHVkZS9saW51eC9mcy5oCmluZGV4IGE0ZmQ2
NDllMmMzZi4uYzc0NWFlZTljODhhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgKKysr
IGIvaW5jbHVkZS9saW51eC9mcy5oCkBAIC0yODEzLDcgKzI4MTMsNyBAQCBzdHJ1Y3QgZmlsZSAq
ZGVudHJ5X29wZW5fbm9ub3RpZnkoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgsIGludCBmbGFncywK
IAkJCQkgIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkKTsKIHN0cnVjdCBmaWxlICpkZW50cnlfY3Jl
YXRlKGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoLCBpbnQgZmxhZ3MsIHVtb2RlX3QgbW9kZSwKIAkJ
CSAgIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkKTsKLXN0cnVjdCBwYXRoICpiYWNraW5nX2ZpbGVf
dXNlcl9wYXRoKHN0cnVjdCBmaWxlICpmKTsKK3N0cnVjdCBwYXRoICpiYWNraW5nX2ZpbGVfdXNl
cl9wYXRoKGNvbnN0IHN0cnVjdCBmaWxlICpmKTsKIAogLyoKICAqIFdoZW4gbW1hcHBpbmcgYSBm
aWxlIG9uIGEgc3RhY2thYmxlIGZpbGVzeXN0ZW0gKGUuZy4sIG92ZXJsYXlmcyksIHRoZSBmaWxl
Ci0tIAoyLjM0LjEKCg==
--0000000000004ae1b40636e1301e--

