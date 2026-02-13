Return-Path: <linux-fsdevel+bounces-77159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMHHMr1jj2n6QgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:47:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3311138BA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F67304F34F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F2247295;
	Fri, 13 Feb 2026 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W61V3Bk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB622FF22
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004851; cv=none; b=LV/OoeChyTWlEOFNCUKXuC9mOJuuMu/Ba8wqQoWS2ubBtQQhLo14ThdPC95wJxfaKlV2dCaVGKmgsMIGvbTD5SsahMo02RWToDufnTGrN4wm+lusvW94NEqxG5DXVyPC5pcNgFRyLUJRw/xrTtLJYi9tK4TarcfdgbgRY3ieFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004851; c=relaxed/simple;
	bh=yUnzePiwffHI/TgKPgP58/Z8tF6NfduSJ3IwuqHP7Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzkP0KigExzmpODMJ19djjsNqKH9kObrn9uyzpK22+EtRiEKCwcn476oeHSaPkMIkooVVMrVFmt5+A5p5jx5mwCbsTNIRF7bgR4w7BcIoNWinatFjcapdXL7JuFyRdy1O1mYGuGpq8H4ObWxZZW2XFt5cASMgiQkU2oz78z77Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W61V3Bk2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8fa79b9fcdso193819566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771004848; x=1771609648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vXuysKnU/8mZ4MhSe+ed8bQCsORmZGyWICllP1pQiGU=;
        b=W61V3Bk2cDRDP7CTW/3I5kEWUWDIbsx+slMS5eGQTDSTlgb3gFJLoR6zKwbIIxwgeG
         W2QiocaQzESoenBip3hrkroPYfZDIGJnuExLHRBaXClJUEXhcxT5FBKpgkTcX+YG6Arf
         3jI7M6CLpgUl8iS0FXcsBXOiCzEjzyfqQ7LIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004848; x=1771609648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXuysKnU/8mZ4MhSe+ed8bQCsORmZGyWICllP1pQiGU=;
        b=L/uJbLBPFjg6cICfV3hwa/zh7vmvqUffTvDd+mEwmg464IL3BnppQ0EOS66uEI3T5g
         52kAZXoo2jrBaYCf36XitegW6PjaWGtPzUoPH29xB/1hIdKBohTgCrv8e5YOcpaFBj3H
         QSrrFtxc/T4BNKvXajTTTnxqEPuGutWc4UosKB+5BKOGgEhhdxJ0wgK6lOo5QkZgLkt5
         5LPtX8rpeqZgmKvc2X4/wuT/xaBsqEG8DrqRGVg3i2nA8yusGCGUe2BsSWYuA6v6wJwO
         DPfH4zI6hN24a7cn6NwdaqtWRrRt8fE8r/Oj0XnePPS9qM8zJdQn0wC8ykANuSSrO6dQ
         WYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSOKhGsWhg2/R3/OEs5rZD95MFJOCydBHSKSdhesH5SpqhongA4/snScSlw1bRsG2oe/dPlDLDTkv6mHVy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vYdsSk2GSy6cnMPbiFbSsfHfCUdqqRm7GOXlhAdWDF01avX1
	U8b1j+wfsh1cbwwlCXJxnUUgs6RUBFb6y6ADLRJef0nMjZoe080kQi49nDXum7gl27YJNLfwnXB
	/s66EZE4=
X-Gm-Gg: AZuq6aKbnsLTgBC3EZT4uOHRA+GDIMAsoJ4wbXAv3pq0JBmlKQnlpIZ+1JL1/J7OmEI
	jxq+sEXjVGdFuLm7bg5M4glzUSJbhLmSUNHL9YpOsNMXJ0EgJM0JC77EhaeKGA0hIEvP3GD2wpi
	W3eym6zzKMs8w77KoOaUH6O13EKsc2pu+qx7Ra3JiYKmO1IO538czh6AZCbaYKi9J4muGgniLh+
	IJpq1LsT0yRzM+Q32TAXdWEK70/0duvAvFHdpXIDy+JzHdOqedYKlscpRY5tPGy5bRp14OGJWzS
	/33OiqYkwxLCAaJqcufXxPoy6bpI2ufBsRlVy5ICD028rMhNxVm9mmtBHWB0iufZt0UNQjAQqqV
	mYhsDVbFRfojeHbxbjB70SxI0I4TERAxmaWVOWXhcAEgcZDar4yoTmvD/TNqBT33ok7v6VL4g+8
	63501LpQq4ehqoXjiecDFZnGv+JOzHOj2x0sxfFr1pH8lu+tzV3Ir18DuqLIuBmvvhM7LD33Rd
X-Received: by 2002:a17:906:ee89:b0:b8f:8054:504 with SMTP id a640c23a62f3a-b8fc071d6cdmr65508866b.29.1771004847839;
        Fri, 13 Feb 2026 09:47:27 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6ebd986fsm281165066b.37.2026.02.13.09.47.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 09:47:27 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so2238845a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 09:47:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsUMs56hv+1Z/Wy38nbL7Keoh1NuSmerALKu7DKEroLiG5t6EUGTO+U7kkRACuibwRwbAcPxtme4tUx4hP@vger.kernel.org
X-Received: by 2002:a05:6402:1467:b0:65a:3527:c5d1 with SMTP id
 4fb4d7f45d1cf-65bc424a4d2mr581292a12.2.1771004847015; Fri, 13 Feb 2026
 09:47:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wikNJ82dh097VZbqNf_jAiwwZ_opzfvMr-8Ub3_1cx3jQ@mail.gmail.com>
 <20260212171717.2927887-1-safinaskar@gmail.com> <CAHk-=wgS5T7sCbjweEKTqbT94XxmcPzppz6Mi6b8nKve-TFarg@mail.gmail.com>
 <2026-02-13-bronze-curly-digs-hopes-6qdLKp@cyphar.com> <4007566C-458F-45C3-BA9A-D99BCF8F16B4@zytor.com>
In-Reply-To: <4007566C-458F-45C3-BA9A-D99BCF8F16B4@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Feb 2026 09:47:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
X-Gm-Features: AZwV_QiwTJFupwLooQzJb2LFaAbZtq9tVGq84JA82voA6mk7usLEOG3jGwZsbys
Message-ID: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Askar Safin <safinaskar@gmail.com>, christian@brauner.io, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	werner@almesberger.net
Content-Type: multipart/mixed; boundary="000000000000cdd8b1064ab83231"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77159-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[cyphar.com,gmail.com,brauner.io,suse.cz,vger.kernel.org,zeniv.linux.org.uk,almesberger.net];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E3311138BA8
X-Rspamd-Action: no action

--000000000000cdd8b1064ab83231
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Feb 2026 at 07:04, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On February 13, 2026 5:46:34 AM PST, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> >I think the init(rd) people will care more -- my impression this was
> >only really needed because of the initrd switch (to change the root of
> >kthreads to the new root)?
>
> That was the original motivation, yes. The real question is if they are anytime out there abusing it in other ways...

I guess we could just try it.

How does something like this feel to people?

I also changed the name from 'chroot' to 'pivot'. Comments?

Entirely untested in every way possible.

            Linus

--000000000000cdd8b1064ab83231
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mll6jky70>
X-Attachment-Id: f_mll6jky70

IGZzL2ZzX3N0cnVjdC5jIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIGZzL2ludGVybmFsLmggIHwgIDIgKy0KIGZzL25hbWVzcGFjZS5j
IHwgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZnMvZnNfc3RydWN0LmMgYi9mcy9mc19zdHJ1Y3QuYwppbmRleCAz
OTQ4NzVkMDZmZDYuLjc2YTQ2ZmQ3ODYwMiAxMDA2NDQKLS0tIGEvZnMvZnNfc3RydWN0LmMKKysr
IGIvZnMvZnNfc3RydWN0LmMKQEAgLTUyLDMwICs1Miw0MyBAQCBzdGF0aWMgaW5saW5lIGludCBy
ZXBsYWNlX3BhdGgoc3RydWN0IHBhdGggKnAsIGNvbnN0IHN0cnVjdCBwYXRoICpvbGQsIGNvbnN0
IHN0cgogCXJldHVybiAxOwogfQogCi12b2lkIGNocm9vdF9mc19yZWZzKGNvbnN0IHN0cnVjdCBw
YXRoICpvbGRfcm9vdCwgY29uc3Qgc3RydWN0IHBhdGggKm5ld19yb290KQorc3RhdGljIGludCBw
aXZvdF9wcm9jZXNzX3JlZnMoc3RydWN0IHRhc2tfc3RydWN0ICogcCwgY29uc3Qgc3RydWN0IHBh
dGggKm9sZF9yb290LCBjb25zdCBzdHJ1Y3QgcGF0aCAqbmV3X3Jvb3QpCiB7Ci0Jc3RydWN0IHRh
c2tfc3RydWN0ICpnLCAqcDsKKwlpbnQgY291bnQgPSAwOwogCXN0cnVjdCBmc19zdHJ1Y3QgKmZz
OworCisJdGFza19sb2NrKHApOworCWZzID0gcC0+ZnM7CisJaWYgKGZzKSB7CisJCWludCBoaXRz
ID0gMDsKKwkJd3JpdGVfc2VxbG9jaygmZnMtPnNlcSk7CisJCWhpdHMgKz0gcmVwbGFjZV9wYXRo
KCZmcy0+cm9vdCwgb2xkX3Jvb3QsIG5ld19yb290KTsKKwkJaGl0cyArPSByZXBsYWNlX3BhdGgo
JmZzLT5wd2QsIG9sZF9yb290LCBuZXdfcm9vdCk7CisJCXdoaWxlIChoaXRzLS0pIHsKKwkJCWNv
dW50Kys7CisJCQlwYXRoX2dldChuZXdfcm9vdCk7CisJCX0KKwkJd3JpdGVfc2VxdW5sb2NrKCZm
cy0+c2VxKTsKKwl9CisJdGFza191bmxvY2socCk7CisJcmV0dXJuIGNvdW50OworfQorCit2b2lk
IHBpdm90X2ZzX3JlZnMoY29uc3Qgc3RydWN0IHBhdGggKm9sZF9yb290LCBjb25zdCBzdHJ1Y3Qg
cGF0aCAqbmV3X3Jvb3QpCit7CiAJaW50IGNvdW50ID0gMDsKIAotCXJlYWRfbG9jaygmdGFza2xp
c3RfbG9jayk7Ci0JZm9yX2VhY2hfcHJvY2Vzc190aHJlYWQoZywgcCkgewotCQl0YXNrX2xvY2so
cCk7Ci0JCWZzID0gcC0+ZnM7Ci0JCWlmIChmcykgewotCQkJaW50IGhpdHMgPSAwOwotCQkJd3Jp
dGVfc2VxbG9jaygmZnMtPnNlcSk7Ci0JCQloaXRzICs9IHJlcGxhY2VfcGF0aCgmZnMtPnJvb3Qs
IG9sZF9yb290LCBuZXdfcm9vdCk7Ci0JCQloaXRzICs9IHJlcGxhY2VfcGF0aCgmZnMtPnB3ZCwg
b2xkX3Jvb3QsIG5ld19yb290KTsKLQkJCXdoaWxlIChoaXRzLS0pIHsKLQkJCQljb3VudCsrOwot
CQkJCXBhdGhfZ2V0KG5ld19yb290KTsKLQkJCX0KLQkJCXdyaXRlX3NlcXVubG9jaygmZnMtPnNl
cSk7Ci0JCX0KLQkJdGFza191bmxvY2socCk7Ci0JfQotCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9s
b2NrKTsKKwkvKiBTcGVjaWFsIGNhc2U6ICdpbml0JyBjaGFuZ2VzIGV2ZXJ5dGhpbmcgKi8KKwlp
ZiAoY3VycmVudCA9PSAgJmluaXRfdGFzaykgeworCQlzdHJ1Y3QgdGFza19zdHJ1Y3QgKmcsICpw
OworCisJCXJlYWRfbG9jaygmdGFza2xpc3RfbG9jayk7CisJCWZvcl9lYWNoX3Byb2Nlc3NfdGhy
ZWFkKGcsIHApCisJCQljb3VudCArPSBwaXZvdF9wcm9jZXNzX3JlZnMocCwgb2xkX3Jvb3QsIG5l
d19yb290KTsKKwkJcmVhZF91bmxvY2soJnRhc2tsaXN0X2xvY2spOworCX0gZWxzZQorCQljb3Vu
dCA9IHBpdm90X3Byb2Nlc3NfcmVmcyhjdXJyZW50LCBvbGRfcm9vdCwgbmV3X3Jvb3QpOworCiAJ
d2hpbGUgKGNvdW50LS0pCiAJCXBhdGhfcHV0KG9sZF9yb290KTsKIH0KZGlmZiAtLWdpdCBhL2Zz
L2ludGVybmFsLmggYi9mcy9pbnRlcm5hbC5oCmluZGV4IGNiYzM4NGExYWEwOS4uMjYxNTQwMWU4
YzY2IDEwMDY0NAotLS0gYS9mcy9pbnRlcm5hbC5oCisrKyBiL2ZzL2ludGVybmFsLmgKQEAgLTk5
LDcgKzk5LDcgQEAgaW50IHNob3dfcGF0aChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBkZW50
cnkgKnJvb3QpOwogLyoKICAqIGZzX3N0cnVjdC5jCiAgKi8KLWV4dGVybiB2b2lkIGNocm9vdF9m
c19yZWZzKGNvbnN0IHN0cnVjdCBwYXRoICosIGNvbnN0IHN0cnVjdCBwYXRoICopOworZXh0ZXJu
IHZvaWQgcGl2b3RfZnNfcmVmcyhjb25zdCBzdHJ1Y3QgcGF0aCAqLCBjb25zdCBzdHJ1Y3QgcGF0
aCAqKTsKIAogLyoKICAqIGZpbGVfdGFibGUuYwpkaWZmIC0tZ2l0IGEvZnMvbmFtZXNwYWNlLmMg
Yi9mcy9uYW1lc3BhY2UuYwppbmRleCBhNjdjYmU0Mjc0NmQuLmIwMTc0OTY4MzQzOSAxMDA2NDQK
LS0tIGEvZnMvbmFtZXNwYWNlLmMKKysrIGIvZnMvbmFtZXNwYWNlLmMKQEAgLTQ2ODEsNyArNDY4
MSw3IEBAIGludCBwYXRoX3Bpdm90X3Jvb3Qoc3RydWN0IHBhdGggKm5ldywgc3RydWN0IHBhdGgg
Km9sZCkKIAl1bmxvY2tfbW91bnRfaGFzaCgpOwogCW1udF9ub3RpZnlfYWRkKHJvb3RfbW50KTsK
IAltbnRfbm90aWZ5X2FkZChuZXdfbW50KTsKLQljaHJvb3RfZnNfcmVmcygmcm9vdCwgbmV3KTsK
KwlwaXZvdF9mc19yZWZzKCZyb290LCBuZXcpOwogCXJldHVybiAwOwogfQogCg==
--000000000000cdd8b1064ab83231--

