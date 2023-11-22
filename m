Return-Path: <linux-fsdevel+bounces-3454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D17F4EC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 18:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B9BB20D0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CD58AA4;
	Wed, 22 Nov 2023 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eD40jz5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3507B9A
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:52:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fcfd2a069aso550813666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700675571; x=1701280371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4fJBtXJKx6342065rOAaMXkPkSTXthM68/ehufiEI+o=;
        b=eD40jz5nVTU65vLdxGRNLuJg5s/PR3CWk1D4QfwJXtB2R6gQNMjxC07Al9/7q5UXsE
         W+s45Y2eOllNvIy7/mC9vb7KyABCggEjcopLY7NbSBJdcZKxunpEeEY87eU4RGg3Ebh8
         Iyo+odkxAUIsmztOqSTx3nqPix9aupB3SeoMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675571; x=1701280371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fJBtXJKx6342065rOAaMXkPkSTXthM68/ehufiEI+o=;
        b=mL2jSdMmfEqTNszs/PLJDjwiKAkJR0ajBglbdur11hKOnXoz64K3Bq76gXETh80maZ
         iOGeKcEzN5X2Ae+4YWQOfqzrsgfrieQckvj3BszY/pl7jWehOQKdexkUi4Nv8gY2Fpmj
         nI2YJWhUqPEyudzPMtrMN5LBxH/b/b0QZcxU4jndk9QV39KUJYV1RjRbR0Pmq0Be+qLR
         xyWXYOprMAQ67p9rDY+YgfqrREGEgdEiSiGvK+RrnXBHhJc3FEv53k5opsQ8hc5I+cLi
         AgP7CLxrs18VUKyOlOY7eYzvaQzlgLIetJFxSQocFcHlwmLD2azCaGujchu7BBSq9Keq
         kIfg==
X-Gm-Message-State: AOJu0YxGCWTa3JrICfO2xE/kW2p9098AeUIKp537sSP34rUF0D2GTOdh
	uyPMIkjcVfeGXY6eP+CbNao3HUbDUcQ+04sg4y15/Q==
X-Google-Smtp-Source: AGHT+IGCBBLEdEdItmYViFsmJAt2AEpnrfI2MU7HCplpiJ+qejzrHY2sXanTXrdq9TpGL5CFc6ugCw==
X-Received: by 2002:a17:907:4ce:b0:9fe:458e:a813 with SMTP id vz14-20020a17090704ce00b009fe458ea813mr1709871ejb.73.1700675571303;
        Wed, 22 Nov 2023 09:52:51 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b009fd6a22c2e9sm22873ejo.138.2023.11.22.09.52.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:52:50 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so56593a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 09:52:50 -0800 (PST)
X-Received: by 2002:aa7:d1d3:0:b0:548:d1a9:82aa with SMTP id
 g19-20020aa7d1d3000000b00548d1a982aamr2303453edp.41.1700675570303; Wed, 22
 Nov 2023 09:52:50 -0800 (PST)
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
In-Reply-To: <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 09:52:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
Message-ID: <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003f6c8c060ac16372"

--0000000000003f6c8c060ac16372
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 09:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you want to do the optimization that the compiler misses by hand,
> it would be something like the attached patch.

Bah. Might as well do the reference decrements with the same logic,
not just the increments.

Of course, this is much more noticeable with the ticket locks, because
with the qspinlocks the "is this unlocked" test will check whether the
lock is all zeroes.

So with qspinlocks, the compiler sees that "oh, the low 32 bits are
zero", and the whole "merge the two words back to 64 bits" is much
cheaper, and doesn't generate quite the mess that it does for RISC-V
with ticket locks.

But this "treat the lockref as a 64-bit entity" thing is probably a
good thing on most 64-bit architectures, including x86 that has that
qspinlock thing.

Still not actually tested, but the code generation on x86 looks
reasonable, so it migth be worth looking at whether it helps the
RISC-V case.

                 Linus

--0000000000003f6c8c060ac16372
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lpa2b9un0>
X-Attachment-Id: f_lpa2b9un0

ZGlmZiAtLWdpdCBhL2xpYi9sb2NrcmVmLmMgYi9saWIvbG9ja3JlZi5jCmluZGV4IDJhZmU0YzVk
ODkxOS4uNTZmNDQxOWY1OTNkIDEwMDY0NAotLS0gYS9saWIvbG9ja3JlZi5jCisrKyBiL2xpYi9s
b2NrcmVmLmMKQEAgLTI2LDYgKzI2LDE3IEBACiAJfQkJCQkJCQkJCVwKIH0gd2hpbGUgKDApCiAK
Ky8qCisgKiBUaGUgY29tcGlsZXIgaXNuJ3Qgc21hcnQgZW5vdWdoIHRvIHRoZSB0aGUgY291bnQK
KyAqIGluY3JlbWVudCBpbiB0aGUgaGlnaCAzMiBiaXRzIG9mIHRoZSA2NC1iaXQgdmFsdWUsCisg
KiBzbyBkbyB0aGlzIG9wdGltaXphdGlvbiBieSBoYW5kLgorICovCisjaWYgZGVmaW5lZChfX0xJ
VFRMRV9FTkRJQU4pICYmIEJJVFNfUEVSX0xPTkcgPT0gNjQKKyAjZGVmaW5lIExPQ0tSRUZfQURE
KG4seCkgKChuKS5sb2NrX2NvdW50ICs9ICh1bnNpZ25lZCBsb25nKSh4KTw8MzIpCisjZWxzZQor
ICNkZWZpbmUgTE9DS1JFRl9BREQobix4KSAoKG4pLmNvdW50ICs9ICh1bnNpZ25lZCBsb25nKSh4
KTw8MzIpCisjZW5kaWYKKwogI2Vsc2UKIAogI2RlZmluZSBDTVBYQ0hHX0xPT1AoQ09ERSwgU1VD
Q0VTUykgZG8geyB9IHdoaWxlICgwKQpAQCAtNDIsNyArNTMsNyBAQAogdm9pZCBsb2NrcmVmX2dl
dChzdHJ1Y3QgbG9ja3JlZiAqbG9ja3JlZikKIHsKIAlDTVBYQ0hHX0xPT1AoCi0JCW5ldy5jb3Vu
dCsrOworCQlMT0NLUkVGX0FERChuZXcsMSk7CiAJLAogCQlyZXR1cm47CiAJKTsKQEAgLTYzLDcg
Kzc0LDcgQEAgaW50IGxvY2tyZWZfZ2V0X25vdF96ZXJvKHN0cnVjdCBsb2NrcmVmICpsb2NrcmVm
KQogCWludCByZXR2YWw7CiAKIAlDTVBYQ0hHX0xPT1AoCi0JCW5ldy5jb3VudCsrOworCQlMT0NL
UkVGX0FERChuZXcsMSk7CiAJCWlmIChvbGQuY291bnQgPD0gMCkKIAkJCXJldHVybiAwOwogCSwK
QEAgLTkxLDcgKzEwMiw3IEBAIGludCBsb2NrcmVmX3B1dF9ub3RfemVybyhzdHJ1Y3QgbG9ja3Jl
ZiAqbG9ja3JlZikKIAlpbnQgcmV0dmFsOwogCiAJQ01QWENIR19MT09QKAotCQluZXcuY291bnQt
LTsKKwkJTE9DS1JFRl9BREQobmV3LC0xKTsKIAkJaWYgKG9sZC5jb3VudCA8PSAxKQogCQkJcmV0
dXJuIDA7CiAJLApAQCAtMTE5LDcgKzEzMCw3IEBAIEVYUE9SVF9TWU1CT0wobG9ja3JlZl9wdXRf
bm90X3plcm8pOwogaW50IGxvY2tyZWZfcHV0X3JldHVybihzdHJ1Y3QgbG9ja3JlZiAqbG9ja3Jl
ZikKIHsKIAlDTVBYQ0hHX0xPT1AoCi0JCW5ldy5jb3VudC0tOworCQlMT0NLUkVGX0FERChuZXcs
LTEpOwogCQlpZiAob2xkLmNvdW50IDw9IDApCiAJCQlyZXR1cm4gLTE7CiAJLApAQCAtMTM3LDcg
KzE0OCw3IEBAIEVYUE9SVF9TWU1CT0wobG9ja3JlZl9wdXRfcmV0dXJuKTsKIGludCBsb2NrcmVm
X3B1dF9vcl9sb2NrKHN0cnVjdCBsb2NrcmVmICpsb2NrcmVmKQogewogCUNNUFhDSEdfTE9PUCgK
LQkJbmV3LmNvdW50LS07CisJCUxPQ0tSRUZfQUREKG5ldywtMSk7CiAJCWlmIChvbGQuY291bnQg
PD0gMSkKIAkJCWJyZWFrOwogCSwKQEAgLTE3NCw3ICsxODUsNyBAQCBpbnQgbG9ja3JlZl9nZXRf
bm90X2RlYWQoc3RydWN0IGxvY2tyZWYgKmxvY2tyZWYpCiAJaW50IHJldHZhbDsKIAogCUNNUFhD
SEdfTE9PUCgKLQkJbmV3LmNvdW50Kys7CisJCUxPQ0tSRUZfQUREKG5ldywxKTsKIAkJaWYgKG9s
ZC5jb3VudCA8IDApCiAJCQlyZXR1cm4gMDsKIAksCg==
--0000000000003f6c8c060ac16372--

