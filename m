Return-Path: <linux-fsdevel+bounces-3460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE707F504A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12461C20A82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20955C90E;
	Wed, 22 Nov 2023 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZJTAHvm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578BC1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 11:11:59 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so1542151fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700680317; x=1701285117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76U5LuXklWAyniR6ra54O/gPKsBzjp+msKjwOE8hsp8=;
        b=ZJTAHvm6iYti3SO3QhkT/q6cqN1s7YjM/kQn48dmVpZBCpoW7uM6HS+JacKr6rbMbl
         QRf8eUSnedjMiAWlJCU27sRZQs/iyXkUi4TFZlmBrOFk3IDBbrjSK7GVf2qowoDPnMni
         in6oD5ZiYlTu53ImYTcgR1LwClNLiGh+X8//k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680317; x=1701285117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76U5LuXklWAyniR6ra54O/gPKsBzjp+msKjwOE8hsp8=;
        b=QMZN1mf64lO9H7/aCx8JXX7ShasZU26abu6ODzDOozsqdsKtv3bPjxVEfDVs0zvt3c
         ooyVmTvwGXc9mkCtHh5qh/7HlMkDD8ORXR0eoTuEe7bCraZSTLGTPSj46psbnnMWGX8A
         M5gbaoF+sbs7sn6S1yHyGUcpPvBSEbFod6iQQrsRzLOj1l3BCaQOpym/z5H3DFiGB0hs
         iEiiP8a2vCBHspFhWfqLb5Qp76/Ald81HpN01Ymg1vbKanyJ581s59MM2hNFxSroPmfG
         DTbHCH8sU2oukbVFHOR3o7+bKJHWgAYfo+wWSreKOtsjGyAkpGv8iSmv0wMt/o/REpwK
         mdMg==
X-Gm-Message-State: AOJu0YwKx87MZd/94+TcB2YkFd1GUt3+vyg/v9COKzLYeUEg+7A7DKv6
	9MY1EjgZhLA9CEH0VJvrDhpz0KQcwf/vi0H0L78J8wba
X-Google-Smtp-Source: AGHT+IHLJmXke1vm4c0LNqcguzeOhSwjXsNn1gKen7C8GEmBpe1VV3XX4r34QrZvOOlaqtEP6Q9qVg==
X-Received: by 2002:a2e:9192:0:b0:2bc:c750:d9be with SMTP id f18-20020a2e9192000000b002bcc750d9bemr2426146ljg.29.1700680317453;
        Wed, 22 Nov 2023 11:11:57 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id b22-20020a05651c033600b002bfe8537f37sm24200ljp.33.2023.11.22.11.11.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:11:56 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso63881e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 11:11:56 -0800 (PST)
X-Received: by 2002:ac2:5159:0:b0:502:f7a4:c31f with SMTP id
 q25-20020ac25159000000b00502f7a4c31fmr2521099lfd.45.1700680316053; Wed, 22
 Nov 2023 11:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 11:11:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2ky85K5HYYLeLCP23qyTJpirnpiVSu5gWyT_GRXbJaQ@mail.gmail.com>
Message-ID: <CAHk-=wj2ky85K5HYYLeLCP23qyTJpirnpiVSu5gWyT_GRXbJaQ@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001e2d76060ac27e88"

--0000000000001e2d76060ac27e88
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 09:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Still not actually tested, but the code generation on x86 looks
> reasonable, so it migth be worth looking at whether it helps the
> RISC-V case.

Doing some more munging, and actually looking at RISC-V code
generation too (I obviously had to enable ARCH_USE_CMPXCHG_LOCKREF for
RISC-V).

I get this:

  lockref_get:
        addi    sp,sp,-32
        sd      s0,16(sp)
        sd      s1,8(sp)
        sd      ra,24(sp)
        addi    s0,sp,32
        li      a1,65536
        ld      a5,0(a0)
        mv      s1,a0
        addi    a1,a1,-1
        li      a0,100
  .L43:
        sext.w  a3,a5
        li      a4,1
        srliw   a2,a5,16
        and     a3,a3,a1
        slli    a4,a4,32
        bne     a2,a3,.L49
        add     a4,a5,a4
  0:
        lr.d a3, 0(s1)
        bne a3, a5, 1f
        sc.d.rl a2, a4, 0(s1)
        bnez a2, 0b
        fence rw, rw
  1:
        bne     a5,a3,.L52
        ld      ra,24(sp)
        ld      s0,16(sp)
        ld      s1,8(sp)
        addi    sp,sp,32
        jr      ra
  ...

so now that single update is indeed just one single instruction:

        add     a4,a5,a4

is that "increment count in the high 32 bits".

The ticket lock being unlocked checks are those

        li      a1,65536
        sext.w  a3,a5
        srliw   a2,a5,16
        and     a3,a3,a1
        bne     a2,a3,.L49

instructions if I read it right.

That actually looks fairly close to optimal, although the frame setup
is kind of sad.

(The above does not include the "loop if the cmpxchg failed" part of
the code generation)

Anyway, apart from enabling LOCKREF, the patch to get this for RISC-V
is attached.

I'm not going to play with this any more, but you might want to check
whether this actually does work on RISC-V.

Becaue I only looked at the code generation, I didn't actually look at
whether it *worked*.

                Linus

--0000000000001e2d76060ac27e88
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-lockref-improve-code-generation-for-ref-updates.patch"
Content-Disposition: attachment; 
	filename="0001-lockref-improve-code-generation-for-ref-updates.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lpa54btf0>
X-Attachment-Id: f_lpa54btf0

RnJvbSAxNjhmMzU4NTBjMTU0Njg5NDFlNTk3OTA3ZTMzZGFhY2QxNzlkNTRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFdlZCwgMjIgTm92IDIwMjMgMDk6MzM6MjkgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBsb2NrcmVmOiBpbXByb3ZlIGNvZGUgZ2VuZXJhdGlvbiBmb3IgcmVmIHVwZGF0ZXMK
Ck91ciBsb2NrcmVmIGRhdGEgc3RydWN0dXJlIGlzIHR3byAzMi1iaXQgd29yZHMgbGFpZCBvdXQg
bmV4dCB0byBlYWNoCm90aGVyLCBjb21iaW5pbmcgdGhlIHNwaW5sb2NrIGFuZCB0aGUgY291bnQg
aW50byBvbmUgZW50aXR5IHRoYXQgY2FuIGJlCmFjY2Vzc2VkIGF0b21pY2FsbHkgdG9nZXRoZXIu
CgpJbiBwYXJ0aWN1bGFyLCB0aGUgc3RydWN0dXJlIGlzIGxhaWQgb3V0IHNvIHRoYXQgdGhlIGNv
dW50IGlzIHRoZSB1cHBlcgozMiBiaXQgd29yZCAob24gbGl0dGxlLWVuZGlhbiksIHNvIHRoYXQg
eW91IGNhbiBkbyBiYXNpYyBhcml0aG1ldGljIG9uCnRoZSBjb3VudCBpbiA2NCBiaXRzOiBpbnN0
ZWFkIG9mIGFkZGluZyBvbmUgdG8gdGhlIDMyLWJpdCB3b3JkLCB5b3UgY2FuCmp1c3QgYWRkIGEg
dmFsdWUgc2hpZnRlZCBieSAzMiB0byB0aGUgZnVsbCA2NC1iaXQgd29yZC4KClNhZGx5LCBuZWl0
aGVyIGdjYyBub3IgY2xhbmcgYXJlIHF1aXRlIGNsZXZlciBlbm91Z2ggdG8gd29yayB0aGF0IG91
dCBvbgp0aGVpciBvd24sIHNvIHRoaXMgZG9lcyB0aGF0ICJtYW51YWxseSIuCgpBbHNvLCB0cnkg
dG8gZG8gYW55IGNvbXBhcmVzIGFnYWluc3QgemVybyB2YWx1ZXMsIHdoaWNoIGdlbmVyYWxseQpp
bXByb3ZlcyB0aGUgY29kZSBnZW5lcmF0aW9uLiAgU28gcmF0aGVyIHRoYW4gY2hlY2sgdGhhdCB0
aGUgdmFsdWUgd2FzCmF0IGxlYXN0IDEgYmVmb3JlIGEgZGVjcmVtZW50LCBjaGVjayB0aGF0IGl0
J3MgcG9zaXRpdmUgb3IgemVybyBhZnRlcgp0aGUgZGVjcmVtZW50LiAgV2UgZG9uJ3Qgd29ycnkg
YWJvdXQgdGhlIG92ZXJmbG93IHBvaW50IGluIGxvY2tyZWZzLgoKQ2M6IEd1byBSZW4gPGd1b3Jl
bkBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGlu
dXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogbGliL2xvY2tyZWYuYyB8IDI5ICsrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIvbG9ja3JlZi5jIGIvbGliL2xvY2tyZWYuYwppbmRl
eCAyYWZlNGM1ZDg5MTkuLmYzYzMwYzUzOGFmMSAxMDA2NDQKLS0tIGEvbGliL2xvY2tyZWYuYwor
KysgYi9saWIvbG9ja3JlZi5jCkBAIC0yNiw2ICsyNiwxNyBAQAogCX0JCQkJCQkJCQlcCiB9IHdo
aWxlICgwKQogCisvKgorICogVGhlIGNvbXBpbGVyIGlzbid0IHNtYXJ0IGVub3VnaCB0byB0aGUg
dGhlIGNvdW50CisgKiBpbmNyZW1lbnQgaW4gdGhlIGhpZ2ggMzIgYml0cyBvZiB0aGUgNjQtYml0
IHZhbHVlLAorICogc28gZG8gdGhpcyBvcHRpbWl6YXRpb24gYnkgaGFuZC4KKyAqLworI2lmIGRl
ZmluZWQoX19MSVRUTEVfRU5ESUFOKSAmJiBCSVRTX1BFUl9MT05HID09IDY0CisgI2RlZmluZSBM
T0NLUkVGX0FERChuLHgpICgobikubG9ja19jb3VudCArPSAodW5zaWduZWQgbG9uZykoeCk8PDMy
KQorI2Vsc2UKKyAjZGVmaW5lIExPQ0tSRUZfQUREKG4seCkgKChuKS5jb3VudCArPSAodW5zaWdu
ZWQgbG9uZykoeCk8PDMyKQorI2VuZGlmCisKICNlbHNlCiAKICNkZWZpbmUgQ01QWENIR19MT09Q
KENPREUsIFNVQ0NFU1MpIGRvIHsgfSB3aGlsZSAoMCkKQEAgLTQyLDcgKzUzLDcgQEAKIHZvaWQg
bG9ja3JlZl9nZXQoc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiB7CiAJQ01QWENIR19MT09QKAot
CQluZXcuY291bnQrKzsKKwkJTE9DS1JFRl9BREQobmV3LDEpOwogCSwKIAkJcmV0dXJuOwogCSk7
CkBAIC02Myw5ICs3NCw5IEBAIGludCBsb2NrcmVmX2dldF9ub3RfemVybyhzdHJ1Y3QgbG9ja3Jl
ZiAqbG9ja3JlZikKIAlpbnQgcmV0dmFsOwogCiAJQ01QWENIR19MT09QKAotCQluZXcuY291bnQr
KzsKIAkJaWYgKG9sZC5jb3VudCA8PSAwKQogCQkJcmV0dXJuIDA7CisJCUxPQ0tSRUZfQUREKG5l
dywxKTsKIAksCiAJCXJldHVybiAxOwogCSk7CkBAIC05MSw4ICsxMDIsOCBAQCBpbnQgbG9ja3Jl
Zl9wdXRfbm90X3plcm8oc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiAJaW50IHJldHZhbDsKIAog
CUNNUFhDSEdfTE9PUCgKLQkJbmV3LmNvdW50LS07Ci0JCWlmIChvbGQuY291bnQgPD0gMSkKKwkJ
TE9DS1JFRl9BREQobmV3LC0xKTsKKwkJaWYgKG5ldy5jb3VudCA8PSAwKQogCQkJcmV0dXJuIDA7
CiAJLAogCQlyZXR1cm4gMTsKQEAgLTExOSw4ICsxMzAsOCBAQCBFWFBPUlRfU1lNQk9MKGxvY2ty
ZWZfcHV0X25vdF96ZXJvKTsKIGludCBsb2NrcmVmX3B1dF9yZXR1cm4oc3RydWN0IGxvY2tyZWYg
KmxvY2tyZWYpCiB7CiAJQ01QWENIR19MT09QKAotCQluZXcuY291bnQtLTsKLQkJaWYgKG9sZC5j
b3VudCA8PSAwKQorCQlMT0NLUkVGX0FERChuZXcsLTEpOworCQlpZiAobmV3LmNvdW50IDwgMCkK
IAkJCXJldHVybiAtMTsKIAksCiAJCXJldHVybiBuZXcuY291bnQ7CkBAIC0xMzcsOCArMTQ4LDgg
QEAgRVhQT1JUX1NZTUJPTChsb2NrcmVmX3B1dF9yZXR1cm4pOwogaW50IGxvY2tyZWZfcHV0X29y
X2xvY2soc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiB7CiAJQ01QWENIR19MT09QKAotCQluZXcu
Y291bnQtLTsKLQkJaWYgKG9sZC5jb3VudCA8PSAxKQorCQlMT0NLUkVGX0FERChuZXcsLTEpOwor
CQlpZiAobmV3LmNvdW50IDw9IDApCiAJCQlicmVhazsKIAksCiAJCXJldHVybiAxOwpAQCAtMTc0
LDkgKzE4NSw5IEBAIGludCBsb2NrcmVmX2dldF9ub3RfZGVhZChzdHJ1Y3QgbG9ja3JlZiAqbG9j
a3JlZikKIAlpbnQgcmV0dmFsOwogCiAJQ01QWENIR19MT09QKAotCQluZXcuY291bnQrKzsKIAkJ
aWYgKG9sZC5jb3VudCA8IDApCiAJCQlyZXR1cm4gMDsKKwkJTE9DS1JFRl9BREQobmV3LDEpOwog
CSwKIAkJcmV0dXJuIDE7CiAJKTsKLS0gCjIuNDMuMC41LmczOGZiMTM3YmRiCgo=
--0000000000001e2d76060ac27e88--

