Return-Path: <linux-fsdevel+bounces-26145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98395506E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E8C1C21C41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF281C3784;
	Fri, 16 Aug 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B8MWIWQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982E1BDAA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831104; cv=none; b=PUUwwdkwuuodJ4t6z/cQkai1iqYDAecF26DjXaCE8L04ZU2UorMPUtMnl+SEUMLeJdj5q3kIvhYtayMIenpghu509iJ09/Dqp7MJHXzGl0D9azzWR0dIbUWLPpwEvfmhhFprSs5qbYM4+oxvWQ3PGX5wJYO4lSXmqQjhTy+v+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831104; c=relaxed/simple;
	bh=IZbFsBi+AUhS0nl+Ku9YofFqnNoQ70+VxcMGqeG3GIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YgkKc319S2Py/qfViExDKn6u0GVsRw5jzDn+sLBU4tvXhyUmfBv7TRI2TBIllGCJvBMpZqR5UZ8B63faE2LhbkglPzWJWMCil7CAYxDo9Wf+jpjmApWWZwxpEHZz6YbvQMv6xV1P5IkFdpgdmsA/or7/GlrqAQe3VSWaNSW11dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B8MWIWQp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a94478a4eso577445966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723831101; x=1724435901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6PTTUnQnDEZMiZJWnQkbdW5zWFAhOIxfoXZWspzQQA=;
        b=B8MWIWQpbaB2jpb4H3+fQM1TsZwgB566JdJddblr+NRF9AOjMvcm2bfENIcFuWap4U
         23LSLOGutEtd4+OlArRtZTlLUtunWkKKV3BB31/eqL/pg6X7uRnPHLIMMXtpjO9Dn22r
         vojBfmRyADAyrpJuarX6GKKMp+Q/4J2+fpN0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831101; x=1724435901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B6PTTUnQnDEZMiZJWnQkbdW5zWFAhOIxfoXZWspzQQA=;
        b=mnqKmqlnF8Pt+r2Hhuja9wwLEsxVWA9SOwdOc0MLwrWMQA6LnUw2rpYrmE2BASTfXy
         glTcVi6oeJZ19XodFvXoaI3VUKcrD/6V24p/sxpevKVouGZI2aM1hMKIMW2WkMJBbKAu
         Cu+aZgiB5OcXS4iY3+LTrvN3owND2s5QUSOc7TJhErBOU6Fu5dTFYWbWiKRqc5Pq4by0
         iVdxG+3WCXz6pYpnA6slwor68+QICmUepMS7oJZlKvudkkP3+ebDVyCrzZ5rqddkfjeZ
         Ci97CZZRLYOLXWzHiNpqWjJThDA91B9PqMgUOpzymyS+N+Nyaew1oRFkrfbiEbVpHLVv
         uHxw==
X-Gm-Message-State: AOJu0YwGsLtUSkBHqMZJK1NMz1nVQ0T/fowwo6CrIdjLyqNsVofZ12J7
	t2PQaHxk7tgFjJ3OgySMalfwBYG1db35ZaSSzuLyNZe9p2K+4loqjmk69NM4R4BEe7taMc9DUn8
	arJh7fw==
X-Google-Smtp-Source: AGHT+IFy2yAEMK9WwdTAGxUDtEVGKyXZOf08jukDOe9U2ilv9JU0dX5Nf860SxXWbF1575BEW4BQUg==
X-Received: by 2002:a17:907:1c1a:b0:a7d:a453:dba1 with SMTP id a640c23a62f3a-a8394e3726amr270834266b.20.1723831100367;
        Fri, 16 Aug 2024 10:58:20 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396dfddsm285635366b.214.2024.08.16.10.58.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 10:58:19 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135eso371906a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 10:58:19 -0700 (PDT)
X-Received: by 2002:a05:6402:5108:b0:5bb:8ffd:24b9 with SMTP id
 4fb4d7f45d1cf-5beb38ba20fmr5954440a12.0.1723831099213; Fri, 16 Aug 2024
 10:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816030341.GW13701@ZenIV> <CAHk-=wh_K+qj=gmTjiUqr8R3x9Tco31FSBZ5qkikKN02bL4y7A@mail.gmail.com>
 <20240816171925.GB504335@ZenIV> <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
In-Reply-To: <CAHk-=wh7NJnJeKroRhZsSRxWGM4uYTgONWX7Ad8V9suO=t777w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Aug 2024 10:58:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPxGj3cawLhc1B8EjuDiA-hYVcQYL-ar3rvAyQYvs31A@mail.gmail.com>
Message-ID: <CAHk-=wjPxGj3cawLhc1B8EjuDiA-hYVcQYL-ar3rvAyQYvs31A@mail.gmail.com>
Subject: Re: [RFC] more close_range() fun
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000528653061fd0b43e"

--000000000000528653061fd0b43e
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 10:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh, and can we please make 'dup_fd()' return an error pointer instead
> of having that other int pointer argument for the error code?

Something like this, IOW.. Entirely untested, but looks obvious enough.

             Linus

--000000000000528653061fd0b43e
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lzx0imoj0>
X-Attachment-Id: f_lzx0imoj0

IGZzL2ZpbGUuYyAgICAgICAgICAgICAgIHwgMTMgKysrKysrLS0tLS0tLQogaW5jbHVkZS9saW51
eC9mZHRhYmxlLmggfCAgMiArLQoga2VybmVsL2ZvcmsuYyAgICAgICAgICAgfCAyNiArKysrKysr
KysrKystLS0tLS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9maWxlLmMgYi9mcy9maWxlLmMKaW5kZXgg
NjU1MzM4ZWZmZTljLi5kZTM5MjBkOTYzNDEgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGUuYworKysgYi9m
cy9maWxlLmMKQEAgLTMxNCwxNyArMzE0LDE3IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgc2FuZV9m
ZHRhYmxlX3NpemUoc3RydWN0IGZkdGFibGUgKmZkdCwgdW5zaWduZWQgaW50IG1heF9mZHMpCiAg
KiBwYXNzZWQgaW4gZmlsZXMgc3RydWN0dXJlLgogICogZXJyb3JwIHdpbGwgYmUgdmFsaWQgb25s
eSB3aGVuIHRoZSByZXR1cm5lZCBmaWxlc19zdHJ1Y3QgaXMgTlVMTC4KICAqLwotc3RydWN0IGZp
bGVzX3N0cnVjdCAqZHVwX2ZkKHN0cnVjdCBmaWxlc19zdHJ1Y3QgKm9sZGYsIHVuc2lnbmVkIGlu
dCBtYXhfZmRzLCBpbnQgKmVycm9ycCkKK3N0cnVjdCBmaWxlc19zdHJ1Y3QgKmR1cF9mZChzdHJ1
Y3QgZmlsZXNfc3RydWN0ICpvbGRmLCB1bnNpZ25lZCBpbnQgbWF4X2ZkcykKIHsKIAlzdHJ1Y3Qg
ZmlsZXNfc3RydWN0ICpuZXdmOwogCXN0cnVjdCBmaWxlICoqb2xkX2ZkcywgKipuZXdfZmRzOwog
CXVuc2lnbmVkIGludCBvcGVuX2ZpbGVzLCBpOwogCXN0cnVjdCBmZHRhYmxlICpvbGRfZmR0LCAq
bmV3X2ZkdDsKKwlpbnQgZXJyb3I7CiAKLQkqZXJyb3JwID0gLUVOT01FTTsKIAluZXdmID0ga21l
bV9jYWNoZV9hbGxvYyhmaWxlc19jYWNoZXAsIEdGUF9LRVJORUwpOwogCWlmICghbmV3ZikKLQkJ
Z290byBvdXQ7CisJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwogCiAJYXRvbWljX3NldCgmbmV3
Zi0+Y291bnQsIDEpOwogCkBAIC0zNTQsMTQgKzM1NCwxNCBAQCBzdHJ1Y3QgZmlsZXNfc3RydWN0
ICpkdXBfZmQoc3RydWN0IGZpbGVzX3N0cnVjdCAqb2xkZiwgdW5zaWduZWQgaW50IG1heF9mZHMs
IGludAogCiAJCW5ld19mZHQgPSBhbGxvY19mZHRhYmxlKG9wZW5fZmlsZXMgLSAxKTsKIAkJaWYg
KCFuZXdfZmR0KSB7Ci0JCQkqZXJyb3JwID0gLUVOT01FTTsKKwkJCWVycm9yID0gLUVOT01FTTsK
IAkJCWdvdG8gb3V0X3JlbGVhc2U7CiAJCX0KIAogCQkvKiBiZXlvbmQgc3lzY3RsX25yX29wZW47
IG5vdGhpbmcgdG8gZG8gKi8KIAkJaWYgKHVubGlrZWx5KG5ld19mZHQtPm1heF9mZHMgPCBvcGVu
X2ZpbGVzKSkgewogCQkJX19mcmVlX2ZkdGFibGUobmV3X2ZkdCk7Ci0JCQkqZXJyb3JwID0gLUVN
RklMRTsKKwkJCWVycm9yID0gLUVNRklMRTsKIAkJCWdvdG8gb3V0X3JlbGVhc2U7CiAJCX0KIApA
QCAtNDA2LDggKzQwNiw3IEBAIHN0cnVjdCBmaWxlc19zdHJ1Y3QgKmR1cF9mZChzdHJ1Y3QgZmls
ZXNfc3RydWN0ICpvbGRmLCB1bnNpZ25lZCBpbnQgbWF4X2ZkcywgaW50CiAKIG91dF9yZWxlYXNl
OgogCWttZW1fY2FjaGVfZnJlZShmaWxlc19jYWNoZXAsIG5ld2YpOwotb3V0OgotCXJldHVybiBO
VUxMOworCXJldHVybiBFUlJfUFRSKGVycm9yKTsKIH0KIAogc3RhdGljIHN0cnVjdCBmZHRhYmxl
ICpjbG9zZV9maWxlcyhzdHJ1Y3QgZmlsZXNfc3RydWN0ICogZmlsZXMpCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2ZkdGFibGUuaCBiL2luY2x1ZGUvbGludXgvZmR0YWJsZS5oCmluZGV4IDI5
NDRkNGFhNDEzYi4uYjkzNmQzNWJlYjU3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2ZkdGFi
bGUuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZkdGFibGUuaApAQCAtMTA2LDcgKzEwNiw3IEBAIHN0
cnVjdCB0YXNrX3N0cnVjdDsKIAogdm9pZCBwdXRfZmlsZXNfc3RydWN0KHN0cnVjdCBmaWxlc19z
dHJ1Y3QgKmZzKTsKIGludCB1bnNoYXJlX2ZpbGVzKHZvaWQpOwotc3RydWN0IGZpbGVzX3N0cnVj
dCAqZHVwX2ZkKHN0cnVjdCBmaWxlc19zdHJ1Y3QgKiwgdW5zaWduZWQsIGludCAqKSBfX2xhdGVu
dF9lbnRyb3B5Oworc3RydWN0IGZpbGVzX3N0cnVjdCAqZHVwX2ZkKHN0cnVjdCBmaWxlc19zdHJ1
Y3QgKiwgdW5zaWduZWQpIF9fbGF0ZW50X2VudHJvcHk7CiB2b2lkIGRvX2Nsb3NlX29uX2V4ZWMo
c3RydWN0IGZpbGVzX3N0cnVjdCAqKTsKIGludCBpdGVyYXRlX2ZkKHN0cnVjdCBmaWxlc19zdHJ1
Y3QgKiwgdW5zaWduZWQsCiAJCWludCAoKikoY29uc3Qgdm9pZCAqLCBzdHJ1Y3QgZmlsZSAqLCB1
bnNpZ25lZCksCmRpZmYgLS1naXQgYS9rZXJuZWwvZm9yay5jIGIva2VybmVsL2ZvcmsuYwppbmRl
eCAxOGJkYzg3MjA5ZDAuLjBjN2ExMmNiODYxNyAxMDA2NDQKLS0tIGEva2VybmVsL2ZvcmsuYwor
KysgYi9rZXJuZWwvZm9yay5jCkBAIC0xNzU0LDMzICsxNzU0LDMwIEBAIHN0YXRpYyBpbnQgY29w
eV9maWxlcyh1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRz
aywKIAkJICAgICAgaW50IG5vX2ZpbGVzKQogewogCXN0cnVjdCBmaWxlc19zdHJ1Y3QgKm9sZGYs
ICpuZXdmOwotCWludCBlcnJvciA9IDA7CiAKIAkvKgogCSAqIEEgYmFja2dyb3VuZCBwcm9jZXNz
IG1heSBub3QgaGF2ZSBhbnkgZmlsZXMgLi4uCiAJICovCiAJb2xkZiA9IGN1cnJlbnQtPmZpbGVz
OwogCWlmICghb2xkZikKLQkJZ290byBvdXQ7CisJCXJldHVybiAwOwogCiAJaWYgKG5vX2ZpbGVz
KSB7CiAJCXRzay0+ZmlsZXMgPSBOVUxMOwotCQlnb3RvIG91dDsKKwkJcmV0dXJuIDA7CiAJfQog
CiAJaWYgKGNsb25lX2ZsYWdzICYgQ0xPTkVfRklMRVMpIHsKIAkJYXRvbWljX2luYygmb2xkZi0+
Y291bnQpOwotCQlnb3RvIG91dDsKKwkJcmV0dXJuIDA7CiAJfQogCi0JbmV3ZiA9IGR1cF9mZChv
bGRmLCBOUl9PUEVOX01BWCwgJmVycm9yKTsKLQlpZiAoIW5ld2YpCi0JCWdvdG8gb3V0OworCW5l
d2YgPSBkdXBfZmQob2xkZiwgTlJfT1BFTl9NQVgpOworCWlmIChJU19FUlIobmV3ZikpCisJCXJl
dHVybiBQVFJfRVJSKG5ld2YpOwogCiAJdHNrLT5maWxlcyA9IG5ld2Y7Ci0JZXJyb3IgPSAwOwot
b3V0OgotCXJldHVybiBlcnJvcjsKKwlyZXR1cm4gMDsKIH0KIAogc3RhdGljIGludCBjb3B5X3Np
Z2hhbmQodW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncywgc3RydWN0IHRhc2tfc3RydWN0ICp0c2sp
CkBAIC0zMjU1LDEzICszMjUyLDE0IEBAIGludCB1bnNoYXJlX2ZkKHVuc2lnbmVkIGxvbmcgdW5z
aGFyZV9mbGFncywgdW5zaWduZWQgaW50IG1heF9mZHMsCiAJICAgICAgIHN0cnVjdCBmaWxlc19z
dHJ1Y3QgKipuZXdfZmRwKQogewogCXN0cnVjdCBmaWxlc19zdHJ1Y3QgKmZkID0gY3VycmVudC0+
ZmlsZXM7Ci0JaW50IGVycm9yID0gMDsKIAogCWlmICgodW5zaGFyZV9mbGFncyAmIENMT05FX0ZJ
TEVTKSAmJgogCSAgICAoZmQgJiYgYXRvbWljX3JlYWQoJmZkLT5jb3VudCkgPiAxKSkgewotCQkq
bmV3X2ZkcCA9IGR1cF9mZChmZCwgbWF4X2ZkcywgJmVycm9yKTsKLQkJaWYgKCEqbmV3X2ZkcCkK
LQkJCXJldHVybiBlcnJvcjsKKwkJc3RydWN0IGZpbGVzX3N0cnVjdCAqbmV3ZjsKKwkJbmV3ZiA9
IGR1cF9mZChmZCwgbWF4X2Zkcyk7CisJCWlmIChJU19FUlIobmV3ZikpCisJCQlyZXR1cm4gUFRS
X0VSUihuZXdmKTsKKwkJKm5ld19mZHAgPSBuZXdmOwogCX0KIAogCXJldHVybiAwOwo=
--000000000000528653061fd0b43e--

