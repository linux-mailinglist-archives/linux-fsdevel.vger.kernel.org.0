Return-Path: <linux-fsdevel+bounces-34690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A19C7B96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59A01F2246E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B26F174EFA;
	Wed, 13 Nov 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baHVqcB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CDC16F0EB;
	Wed, 13 Nov 2024 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523788; cv=none; b=pdvB9OjUsDmS3vT/oNRdwKxn8PE6NxeGK2YgDJUChYGavmLLwJJ5ogNVf4cX6FOiDLdugMCaP++gFOl8RSO3Jb2WFtdI4Y18aGVGsuFCz20yzIYltePRvYALN8rY1tSZDvOVSVz78z4i6M3JWLLK+a9wgpipKbsYG5ERgnFfVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523788; c=relaxed/simple;
	bh=t5NlRZM8mcG9cnwPsf2jesnjF7lEKLALv1OndVbCPKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWUOVzcia3/zIU3F826lMTt7ZlO5Msy59HxwpaVcE/znq7ROcSjAy345SW0sj6mwiOS7gjoHKvB8Hbft5A3/SlQf45+ny33RH5OGi8PSi9tghLm2XUamIoyiXtWCY78n6SUUksIG14Z4CGgI94SSMeSGzfZs1JV7wAxuMvHp0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baHVqcB5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso9173243a12.3;
        Wed, 13 Nov 2024 10:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731523785; x=1732128585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4+CN7Ii5HFh2C5ssFaQ0l9WBIBw5XbCT/tU3Jb6GRQ=;
        b=baHVqcB5ffbCuZDhLcVGEETK+lb1rUDqeywEJQMPvye9Q5WYGGtp/HDCfSasVUEz1U
         RWpH1HT+o2f66E5msIodiAFDL4xLp6XAPmlR++EGznj9x9/XP5FGQh2bVAWSwl0Hsl3Y
         HP2VEBTD/FEE1345q1QAx56ig/6vcwQYkLy+FGTqzbhQfcpahRmgvhRWCNAhYZc1vcZO
         GRYNnvcqsLaAuILAPLsh5m15nxRb6WVqwerdmox1ayCwld1s3R+O1zs0a0S7Vcs0giIK
         ESYpDUHPwnWBHNlGwML6BGlnXwevXvlb8LKV1KkQ58LD0aqbM+PXaA2nwqnELrpbHpk5
         JLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523785; x=1732128585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4+CN7Ii5HFh2C5ssFaQ0l9WBIBw5XbCT/tU3Jb6GRQ=;
        b=JoaEnB3QJDUzL81A2XkzFgk61+opHiiYv1N0qzil98zG3cWAdBvVbGQgQp/UOYRh35
         D/fFDwXOvA/0Z1LMVTOjQpuxHi4gYQbn7f9kaL4+EV6tx2omJa8hf1CJAE3uTFaxo1hC
         tyzYlScYU0MuXc0zq8i2LF6ggOhuGm2vYUWCBLn9v9WUeakCbFRspvHe62YQYhxI+rAK
         qRkkb3VnReHKKlzZAjs/IcUEwctT7ewQ0Lb6kBvkEg0LzKk/5FWb7GM1xn+76qW7FRug
         cHnx8anI7VnhT9kQ6uVEeRsUaeWiGjZfPfvHOqnu3eQC4VyXWavvkw8ayzBvwiKvzqby
         yOjg==
X-Forwarded-Encrypted: i=1; AJvYcCUL+7/3J/9aayRZNsKGOI4Mh5hFH+RFhHC0DbXzr+hu5Iw8W+F8DnAiukGM7rZjM1VwEk8ccwtuQNelFOyvFw==@vger.kernel.org, AJvYcCWJtXbqjfvqfKT0Qrg5M6Kv8N9yw/mMJ5miieA6rfSUHLXAr7J1/7sqTKTNIo+umPRGUz5f1Uglzt4wRg==@vger.kernel.org, AJvYcCWlc7VtFDpA5uoH3DtYHMGyibzLPPWngZl2GXSYVxArltIxlNIV/h66AsoZDsEn57CqFT4c+FF/Bhnz@vger.kernel.org, AJvYcCWmsaCDFLZm+AvOc/QCNjhgMj1gLoMxXz3Rp18Mv+KXf5V7z6hBwK4ri5y9gcdUyr1pIUwdnj/lH5hNGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+kK8OfR/QNa+Tvf0CcFZR9lYC7eT/tNb65+kDL4piB8xSAzd
	OmX/b/QFIeJz0xOXyS/K9twxwmgQBnByYK4Nee6QSSOzklYgd3yzsdqZii5rmz/DJ/u6e1pLrDS
	Q0S/RsaZqcrTy9eootWwfARDZ3Fc=
X-Google-Smtp-Source: AGHT+IFNpYzMGsm11wKWjUIBvPQE5e42MxlUp78YWQFMFDmZWQD3yazyTEb0xl8oWFcBkpJzsMp2m5YzpbN40qacbNk=
X-Received: by 2002:a17:907:d2a:b0:a9a:a891:b43e with SMTP id
 a640c23a62f3a-a9ef0049273mr2186275166b.50.1731523784879; Wed, 13 Nov 2024
 10:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com> <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
In-Reply-To: <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Nov 2024 19:49:31 +0100
Message-ID: <CAOQ4uxjeWrJtcgsC0YEmjdMPBOOpfz=zQ9VuG=z-Sc6WYNJOjQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e48560626cfcc8c"

--0000000000001e48560626cfcc8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:06, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Maybe I could use just this one bit, but together with the existing
> > FMODE_NONOTIFY bit, I get 4 modes, which correspond to the
> > highest watching priority:
>
> So you'd use two bits, but one of those would re-use the existing
> FMODE_NONOTIFY? That sounds perfectly fine to me.
>

Yes, exactly, like this:

/*
 * The two FMODE_NONOTIFY_ bits used together have a special meaning of
 * not reporting any events at all including non-permission events.
 * These are the possible values of FMODE_NOTIFY(f->f_mode) and their meani=
ng:
 *
 * FMODE_NONOTIFY_HSM - suppress only pre-content events.
 * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) events.
 * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
 */
#define FMODE_NONOTIFY_MASK \
        (FMODE_NONOTIFY_HSM | FMODE_NONOTIFY_PERM)
#define FMODE_NONOTIFY FMODE_NONOTIFY_MASK
#define FMODE_NOTIFY(mode) \
        ((mode) & FMODE_NONOTIFY_MASK)

Please see attached patch (build and sanity tested) to make sure that
we are on the same page.

Going forward in the patch series, the choice of the NONOTIFY lingo
creates some double negatives, like:

        /*
         * read()/write() and other types of access generate pre-content ev=
ents.
         */
        if (!likely(file->f_mode & FMODE_NONOTIFY_HSM)) {
                int ret =3D fsnotify_path(&file->f_path);

But it was easier for me to work with NONOTIFY flags.

Thanks,
Amir.

--0000000000001e48560626cfcc8c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-opt-in-for-permission-events-at-file-open-t.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-opt-in-for-permission-events-at-file-open-t.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3g86qoe0>
X-Attachment-Id: f_m3g86qoe0

RnJvbSA3YTJjZDc0NjU0YTUzNjg0ZDU0NWI5NmM1N2M5MDkxZTQyMGIzYWRkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEyIE5vdiAyMDI0IDEzOjQ2OjA4ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IG9wdC1pbiBmb3IgcGVybWlzc2lvbiBldmVudHMgYXQgZmlsZSBvcGVuIHRpbWUKCkxl
Z2FjeSBpbm90aWZ5L2Zhbm90aWZ5IGxpc3RlbmVycyBjYW4gYWRkIHdhdGNoZXMgZm9yIGV2ZW50
cyBvbiBpbm9kZSwKcGFyZW50IG9yIG1vdW50IGFuZCBleHBlY3QgdG8gZ2V0IGV2ZW50cyAoZS5n
LiBGU19NT0RJRlkpIG9uIGZpbGVzIHRoYXQKd2VyZSBhbHJlYWR5IG9wZW4gYXQgdGhlIHRpbWUg
b2Ygc2V0dGluZyB1cCB0aGUgd2F0Y2hlcy4KCmZhbm90aWZ5IHBlcm1pc3Npb24gZXZlbnRzIGFy
ZSB0eXBpY2FsbHkgdXNlZCBieSBBbnRpLW1hbHdhcmUgc29md2FyZSwKdGhhdCBpcyB3YXRjaGlu
ZyB0aGUgZW50aXJlIG1vdW50IGFuZCBpdCBpcyBub3QgY29tbW9uIHRvIGhhdmUgbW9yZSB0aGF0
Cm9uZSBBbnRpLW1hbHdhcmUgZW5naW5lIGluc3RhbGxlZCBvbiBhIHN5c3RlbS4KClRvIHJlZHVj
ZSB0aGUgb3ZlcmhlYWQgb2YgdGhlIGZzbm90aWZ5X2ZpbGVfcGVybSgpIGhvb2tzIG9uIGV2ZXJ5
IGZpbGUKYWNjZXNzLCByZWxheCB0aGUgc2VtYW50aWNzIG9mIHRoZSBsZWdhY3kgRkFOX0FDQ0VT
U19QRVJNIGV2ZW50IHRvIGdlbmVyYXRlCmV2ZW50cyBvbmx5IGlmIHRoZXJlIHdlcmUgKmFueSog
cGVybWlzc2lvbiBldmVudCBsaXN0ZW5lcnMgb24gdGhlCmZpbGVzeXN0ZW0gYXQgdGhlIHRpbWUg
dGhhdCB0aGUgZmlsZSB3YXMgb3BlbmVkLgoKVGhlIG5ldyBzZW1hbnRpYyBpcyBpbXBsZW1lbnRl
ZCBieSBleHRlbmRpbmcgdGhlIEZNT0RFX05PTk9USUZZIGJpdCBpbnRvCnR3byBGTU9ERV9OT05P
VElGWV8qIGJpdHMsIHRoYXQgYXJlIHVzZWQgdG8gc3RvcmUgYSBtb2RlIGZvciB3aGljaCBvZiB0
aGUKZXZlbnRzIHR5cGVzIHRvIHJlcG9ydC4KClRoaXMgaXMgZ29pbmcgdG8gYXBwbHkgdG8gdGhl
IG5ldyBmYW5vdGlmeSBwcmUtY29udGVudCBldmVudHMgaW4gb3JkZXIKdG8gcmVkdWNlIHRoZSBj
b3N0IG9mIHRoZSBuZXcgcHJlLWNvbnRlbnQgZXZlbnQgdmZzIGhvb2tzLgoKU3VnZ2VzdGVkLWJ5
OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ckxpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZzZGV2ZWwvQ0FIay09d2o4TD1tdGNSVGk9TkVD
SE1HZlpRZ1hPcF91aXgxWVZoMDRmRW1yS2FNblhBQG1haWwuZ21haWwuY29tLwpTaWduZWQtb2Zm
LWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZzL29wZW4uYyAg
ICAgICAgICAgICAgICB8ICA4ICsrKystCiBpbmNsdWRlL2xpbnV4L2ZzLmggICAgICAgfCAyNiAr
KysrKysrKysrKystLS0KIGluY2x1ZGUvbGludXgvZnNub3RpZnkuaCB8IDcxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgODMgaW5zZXJ0
aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Bl
bi5jCmluZGV4IDIyNmFjYThjNzkwOS4uMTk0YzJjOGQ4Y2Q0IDEwMDY0NAotLS0gYS9mcy9vcGVu
LmMKKysrIGIvZnMvb3Blbi5jCkBAIC05MDEsNyArOTAxLDcgQEAgc3RhdGljIGludCBkb19kZW50
cnlfb3BlbihzdHJ1Y3QgZmlsZSAqZiwKIAlmLT5mX3NiX2VyciA9IGZpbGVfc2FtcGxlX3NiX2Vy
cihmKTsKIAogCWlmICh1bmxpa2VseShmLT5mX2ZsYWdzICYgT19QQVRIKSkgewotCQlmLT5mX21v
ZGUgPSBGTU9ERV9QQVRIIHwgRk1PREVfT1BFTkVEOworCQlmLT5mX21vZGUgPSBGTU9ERV9QQVRI
IHwgRk1PREVfT1BFTkVEIHwgRk1PREVfTk9OT1RJRlk7CiAJCWYtPmZfb3AgPSAmZW1wdHlfZm9w
czsKIAkJcmV0dXJuIDA7CiAJfQpAQCAtOTI5LDYgKzkyOSwxMiBAQCBzdGF0aWMgaW50IGRvX2Rl
bnRyeV9vcGVuKHN0cnVjdCBmaWxlICpmLAogCWlmIChlcnJvcikKIAkJZ290byBjbGVhbnVwX2Fs
bDsKIAorCS8qCisJICogU2V0IEZNT0RFX05PTk9USUZZXyogYml0cyBhY2NvcmRpbmcgdG8gZXhp
c3RpbmcgcGVybWlzc2lvbiB3YXRjaGVzLgorCSAqIElmIEZNT0RFX05PTk9USUZZIHdhcyBhbHJl
YWR5IHNldCBmb3IgYW4gZmFub3RpZnkgZmQsIHRoaXMgZG9lc24ndAorCSAqIGNoYW5nZSBhbnl0
aGluZy4KKwkgKi8KKwlmLT5mX21vZGUgfD0gZnNub3RpZnlfZmlsZV9tb2RlKGYpOwogCWVycm9y
ID0gZnNub3RpZnlfb3Blbl9wZXJtKGYpOwogCWlmIChlcnJvcikKIAkJZ290byBjbGVhbnVwX2Fs
bDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaApp
bmRleCA3MDM1OWRkNjY5ZmYuLmRkNTgzY2U3ZGJhOCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgvZnMuaApAQCAtMTczLDEzICsxNzMsMTQgQEAgdHlw
ZWRlZiBpbnQgKGRpb19pb2RvbmVfdCkoc3RydWN0IGtpb2NiICppb2NiLCBsb2ZmX3Qgb2Zmc2V0
LAogCiAjZGVmaW5lCUZNT0RFX05PUkVVU0UJCSgoX19mb3JjZSBmbW9kZV90KSgxIDw8IDIzKSkK
IAotLyogRk1PREVfKiBiaXQgMjQgKi8KLQogLyogRmlsZSBpcyBlbWJlZGRlZCBpbiBiYWNraW5n
X2ZpbGUgb2JqZWN0ICovCi0jZGVmaW5lIEZNT0RFX0JBQ0tJTkcJCSgoX19mb3JjZSBmbW9kZV90
KSgxIDw8IDI1KSkKKyNkZWZpbmUgRk1PREVfQkFDS0lORwkJKChfX2ZvcmNlIGZtb2RlX3QpKDEg
PDwgMjQpKQorCisvKiBGaWxlIHNob3VsZG4ndCBnZW5lcmF0ZSBmYW5vdGlmeSBwcmUtY29udGVu
dCBldmVudHMgKi8KKyNkZWZpbmUgRk1PREVfTk9OT1RJRllfSFNNCSgoX19mb3JjZSBmbW9kZV90
KSgxIDw8IDI1KSkKIAotLyogRmlsZSB3YXMgb3BlbmVkIGJ5IGZhbm90aWZ5IGFuZCBzaG91bGRu
J3QgZ2VuZXJhdGUgZmFub3RpZnkgZXZlbnRzICovCi0jZGVmaW5lIEZNT0RFX05PTk9USUZZCQko
KF9fZm9yY2UgZm1vZGVfdCkoMSA8PCAyNikpCisvKiBGaWxlIHNob3VsZG4ndCBnZW5lcmF0ZSBm
YW5vdGlmeSBwZXJtaXNzaW9uIGV2ZW50cyAqLworI2RlZmluZSBGTU9ERV9OT05PVElGWV9QRVJN
CSgoX19mb3JjZSBmbW9kZV90KSgxIDw8IDI2KSkKIAogLyogRmlsZSBpcyBjYXBhYmxlIG9mIHJl
dHVybmluZyAtRUFHQUlOIGlmIEkvTyB3aWxsIGJsb2NrICovCiAjZGVmaW5lIEZNT0RFX05PV0FJ
VAkJKChfX2ZvcmNlIGZtb2RlX3QpKDEgPDwgMjcpKQpAQCAtMTkwLDYgKzE5MSwyMSBAQCB0eXBl
ZGVmIGludCAoZGlvX2lvZG9uZV90KShzdHJ1Y3Qga2lvY2IgKmlvY2IsIGxvZmZfdCBvZmZzZXQs
CiAvKiBGaWxlIGRvZXMgbm90IGNvbnRyaWJ1dGUgdG8gbnJfZmlsZXMgY291bnQgKi8KICNkZWZp
bmUgRk1PREVfTk9BQ0NPVU5UCQkoKF9fZm9yY2UgZm1vZGVfdCkoMSA8PCAyOSkpCiAKKy8qCisg
KiBUaGUgdHdvIEZNT0RFX05PTk9USUZZXyBiaXRzIHVzZWQgdG9nZXRoZXIgaGF2ZSBhIHNwZWNp
YWwgbWVhbmluZyBvZgorICogbm90IHJlcG9ydGluZyBhbnkgZXZlbnRzIGF0IGFsbCBpbmNsdWRp
bmcgbm9uLXBlcm1pc3Npb24gZXZlbnRzLgorICogVGhlc2UgYXJlIHRoZSBwb3NzaWJsZSB2YWx1
ZXMgb2YgRk1PREVfTk9USUZZKGYtPmZfbW9kZSkgYW5kIHRoZWlyIG1lYW5pbmc6CisgKgorICog
Rk1PREVfTk9OT1RJRllfSFNNIC0gc3VwcHJlc3Mgb25seSBwcmUtY29udGVudCBldmVudHMuCisg
KiBGTU9ERV9OT05PVElGWV9QRVJNIC0gc3VwcHJlc3MgcGVybWlzc2lvbiAoaW5jbC4gcHJlLWNv
bnRlbnQpIGV2ZW50cy4KKyAqIEZNT0RFX05PTk9USUZZIC0gc3VwcHJlc3MgYWxsIChpbmNsLiBu
b24tcGVybWlzc2lvbikgZXZlbnRzLgorICovCisjZGVmaW5lIEZNT0RFX05PTk9USUZZX01BU0sg
XAorCShGTU9ERV9OT05PVElGWV9IU00gfCBGTU9ERV9OT05PVElGWV9QRVJNKQorI2RlZmluZSBG
TU9ERV9OT05PVElGWSBGTU9ERV9OT05PVElGWV9NQVNLCisjZGVmaW5lIEZNT0RFX05PVElGWSht
b2RlKSBcCisJKChtb2RlKSAmIEZNT0RFX05PTk9USUZZX01BU0spCisKIC8qCiAgKiBBdHRyaWJ1
dGUgZmxhZ3MuICBUaGVzZSBzaG91bGQgYmUgb3ItZWQgdG9nZXRoZXIgdG8gZmlndXJlIG91dCB3
aGF0CiAgKiBoYXMgYmVlbiBjaGFuZ2VkIQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25v
dGlmeS5oIGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4IDI3ODYyMGUwNjNhYi4uOWYx
M2M3YzE5Yjc0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKKysrIGIvaW5j
bHVkZS9saW51eC9mc25vdGlmeS5oCkBAIC0xMDgsMzggKzEwOCw2NiBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgZnNub3RpZnlfZGVudHJ5KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgX191MzIgbWFzaykK
IAlmc25vdGlmeV9wYXJlbnQoZGVudHJ5LCBtYXNrLCBkZW50cnksIEZTTk9USUZZX0VWRU5UX0RF
TlRSWSk7CiB9CiAKLXN0YXRpYyBpbmxpbmUgaW50IGZzbm90aWZ5X2ZpbGUoc3RydWN0IGZpbGUg
KmZpbGUsIF9fdTMyIG1hc2spCitzdGF0aWMgaW5saW5lIGludCBmc25vdGlmeV9wYXRoKGNvbnN0
IHN0cnVjdCBwYXRoICpwYXRoLCBfX3UzMiBtYXNrKQogewotCWNvbnN0IHN0cnVjdCBwYXRoICpw
YXRoOworCXJldHVybiBmc25vdGlmeV9wYXJlbnQocGF0aC0+ZGVudHJ5LCBtYXNrLCBwYXRoLCBG
U05PVElGWV9FVkVOVF9QQVRIKTsKK30KIAorc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfZmls
ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgX191MzIgbWFzaykKK3sKIAkvKgogCSAqIEZNT0RFX05PTk9U
SUZZIGFyZSBmZHMgZ2VuZXJhdGVkIGJ5IGZhbm90aWZ5IGl0c2VsZiB3aGljaCBzaG91bGQgbm90
CiAJICogZ2VuZXJhdGUgbmV3IGV2ZW50cy4gV2UgYWxzbyBkb24ndCB3YW50IHRvIGdlbmVyYXRl
IGV2ZW50cyBmb3IKIAkgKiBGTU9ERV9QQVRIIGZkcyAoaW52b2x2ZXMgb3BlbiAmIGNsb3NlIGV2
ZW50cykgYXMgdGhleSBhcmUganVzdAogCSAqIGhhbmRsZSBjcmVhdGlvbiAvIGRlc3RydWN0aW9u
IGV2ZW50cyBhbmQgbm90ICJyZWFsIiBmaWxlIGV2ZW50cy4KIAkgKi8KLQlpZiAoZmlsZS0+Zl9t
b2RlICYgKEZNT0RFX05PTk9USUZZIHwgRk1PREVfUEFUSCkpCi0JCXJldHVybiAwOwotCi0JcGF0
aCA9ICZmaWxlLT5mX3BhdGg7Ci0JLyogUGVybWlzc2lvbiBldmVudHMgcmVxdWlyZSBncm91cCBw
cmlvID49IEZTTk9USUZZX1BSSU9fQ09OVEVOVCAqLwotCWlmIChtYXNrICYgQUxMX0ZTTk9USUZZ
X1BFUk1fRVZFTlRTICYmCi0JICAgICFmc25vdGlmeV9zYl9oYXNfcHJpb3JpdHlfd2F0Y2hlcnMo
cGF0aC0+ZGVudHJ5LT5kX3NiLAotCQkJCQkgICAgICAgRlNOT1RJRllfUFJJT19DT05URU5UKSkK
KwlpZiAoRk1PREVfTk9USUZZKGZpbGUtPmZfbW9kZSkgPT0gRk1PREVfTk9OT1RJRlkpCiAJCXJl
dHVybiAwOwogCi0JcmV0dXJuIGZzbm90aWZ5X3BhcmVudChwYXRoLT5kZW50cnksIG1hc2ssIHBh
dGgsIEZTTk9USUZZX0VWRU5UX1BBVEgpOworCXJldHVybiBmc25vdGlmeV9wYXRoKCZmaWxlLT5m
X3BhdGgsIG1hc2spOwogfQogCiAjaWZkZWYgQ09ORklHX0ZBTk9USUZZX0FDQ0VTU19QRVJNSVNT
SU9OUworLyoKKyAqIEF0IG9wZW4gdGltZSB3ZSBjaGVjayBmc25vdGlmeV9zYl9oYXNfcHJpb3Jp
dHlfd2F0Y2hlcnMoKSBhbmQgc2V0IHRoZQorICogRk1PREVfTk9OT1RJRllfIG1vZGUgYml0cyBh
Y2NvcmRpZ25seS4KKyAqIExhdGVyLCBmc25vdGlmeSBwZXJtaXNzaW9uIGhvb2tzIGRvIG5vdCBj
aGVjayBpZiB0aGVyZSBhcmUgcGVybWlzc2lvbiBldmVudAorICogd2F0Y2hlcywgYnV0IHRoYXQg
dGhlcmUgd2VyZSBwZXJtaXNzaW9uIGV2ZW50IHdhdGNoZXMgYXQgb3BlbiB0aW1lLgorICovCitz
dGF0aWMgaW5saW5lIGZtb2RlX3QgZnNub3RpZnlfZmlsZV9tb2RlKHN0cnVjdCBmaWxlICpmaWxl
KQoreworCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBmaWxlLT5mX3BhdGguZGVudHJ5LT5kX3Ni
OworCisJLyogSXMgaXQgYSBmaWxlIG9wZW5lZCBieSBmYW5vdGlmeT8gKi8KKwlpZiAoRk1PREVf
Tk9USUZZKGZpbGUtPmZfbW9kZSkgPT0gRk1PREVfTk9OT1RJRlkpCisJCXJldHVybiBGTU9ERV9O
T05PVElGWTsKKworCS8qCisJICogUGVybWlzc2lvbiBldmVudHMgaXMgYSBzdXBlciBzZXQgb2Yg
cHJlLWNvbnRlbnQgZXZlbnRzLCBzbyBpZiB0aGVyZQorCSAqIGFyZSBubyBwZXJtaXNzaW9uIGV2
ZW50IHdhdGNoZXJzLCB0aGVyZSBhcmUgYWxzbyBubyBwcmUtY29udGVudCBldmVudAorCSAqIHdh
dGNoZXJzIGFuZCB0aGlzIGlzIGltcGxpZWQgZnJvbSB0aGUgc2luZ2xlIEZNT0RFX05PTk9USUZZ
X1BFUk0gYml0LgorCSAqLworCWlmIChsaWtlbHkoIWZzbm90aWZ5X3NiX2hhc19wcmlvcml0eV93
YXRjaGVycyhzYiwKKwkJCQkJCUZTTk9USUZZX1BSSU9fQ09OVEVOVCkpKQorCQlyZXR1cm4gRk1P
REVfTk9OT1RJRllfUEVSTTsKKworCS8qCisJICogRk1PREVfTk9OT1RJRllfSFNNIGJpdCBtZWFu
cyB0aGVyZSBhcmUgcGVybWlzc2lvbiBldmVudCB3YXRjaGVycywgYnV0CisJICogbm8gcHJlLWNv
bnRlbnQgZXZlbnQgd2F0Y2hlcnMuCisJICovCisJaWYgKGxpa2VseSghZnNub3RpZnlfc2JfaGFz
X3ByaW9yaXR5X3dhdGNoZXJzKHNiLAorCQkJCQkJRlNOT1RJRllfUFJJT19QUkVfQ09OVEVOVCkp
KQorCQlyZXR1cm4gRk1PREVfTk9OT1RJRllfSFNNOworCisJcmV0dXJuIDA7Cit9CisKIC8qCiAg
KiBmc25vdGlmeV9maWxlX2FyZWFfcGVybSAtIHBlcm1pc3Npb24gaG9vayBiZWZvcmUgYWNjZXNz
IHRvIGZpbGUgcmFuZ2UKICAqLwogc3RhdGljIGlubGluZSBpbnQgZnNub3RpZnlfZmlsZV9hcmVh
X3Blcm0oc3RydWN0IGZpbGUgKmZpbGUsIGludCBwZXJtX21hc2ssCiAJCQkJCSAgY29uc3QgbG9m
Zl90ICpwcG9zLCBzaXplX3QgY291bnQpCiB7Ci0JX191MzIgZnNub3RpZnlfbWFzayA9IEZTX0FD
Q0VTU19QRVJNOwotCiAJLyoKIAkgKiBmaWxlc3lzdGVtIG1heSBiZSBtb2RpZmllZCBpbiB0aGUg
Y29udGV4dCBvZiBwZXJtaXNzaW9uIGV2ZW50cwogCSAqIChlLmcuIGJ5IEhTTSBmaWxsaW5nIGEg
ZmlsZSBvbiBhY2Nlc3MpLCBzbyBzYiBmcmVlemUgcHJvdGVjdGlvbgpAQCAtMTUwLDcgKzE3OCwx
MCBAQCBzdGF0aWMgaW5saW5lIGludCBmc25vdGlmeV9maWxlX2FyZWFfcGVybShzdHJ1Y3QgZmls
ZSAqZmlsZSwgaW50IHBlcm1fbWFzaywKIAlpZiAoIShwZXJtX21hc2sgJiBNQVlfUkVBRCkpCiAJ
CXJldHVybiAwOwogCi0JcmV0dXJuIGZzbm90aWZ5X2ZpbGUoZmlsZSwgZnNub3RpZnlfbWFzayk7
CisJaWYgKGxpa2VseShmaWxlLT5mX21vZGUgJiBGTU9ERV9OT05PVElGWV9QRVJNKSkKKwkJcmV0
dXJuIDA7CisKKwlyZXR1cm4gZnNub3RpZnlfcGF0aCgmZmlsZS0+Zl9wYXRoLCBGU19BQ0NFU1Nf
UEVSTSk7CiB9CiAKIC8qCkBAIC0xNjgsMTYgKzE5OSwyNCBAQCBzdGF0aWMgaW5saW5lIGludCBm
c25vdGlmeV9vcGVuX3Blcm0oc3RydWN0IGZpbGUgKmZpbGUpCiB7CiAJaW50IHJldDsKIAorCWlm
IChsaWtlbHkoZmlsZS0+Zl9tb2RlICYgRk1PREVfTk9OT1RJRllfUEVSTSkpCisJCXJldHVybiAw
OworCiAJaWYgKGZpbGUtPmZfZmxhZ3MgJiBfX0ZNT0RFX0VYRUMpIHsKLQkJcmV0ID0gZnNub3Rp
ZnlfZmlsZShmaWxlLCBGU19PUEVOX0VYRUNfUEVSTSk7CisJCXJldCA9IGZzbm90aWZ5X3BhdGgo
JmZpbGUtPmZfcGF0aCwgRlNfT1BFTl9FWEVDX1BFUk0pOwogCQlpZiAocmV0KQogCQkJcmV0dXJu
IHJldDsKIAl9CiAKLQlyZXR1cm4gZnNub3RpZnlfZmlsZShmaWxlLCBGU19PUEVOX1BFUk0pOwor
CXJldHVybiBmc25vdGlmeV9wYXRoKCZmaWxlLT5mX3BhdGgsIEZTX09QRU5fUEVSTSk7CiB9CiAK
ICNlbHNlCitzdGF0aWMgaW5saW5lIGZtb2RlX3QgZnNub3RpZnlfZmlsZV9tb2RlKHN0cnVjdCBm
aWxlICpmaWxlKQoreworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW5saW5lIGludCBmc25vdGlm
eV9maWxlX2FyZWFfcGVybShzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IHBlcm1fbWFzaywKIAkJCQkJ
ICBjb25zdCBsb2ZmX3QgKnBwb3MsIHNpemVfdCBjb3VudCkKIHsKLS0gCjIuMzQuMQoK
--0000000000001e48560626cfcc8c--

