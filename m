Return-Path: <linux-fsdevel+bounces-66879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92035C2F704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9C4734BFF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E772C2374;
	Tue,  4 Nov 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CWrXKmDa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9D134AB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237544; cv=none; b=euhCNHLpQT5Xk+LOzij9AaUKib8KdhpT/EI7mVu1guk9rsp0zADStTagokqUDvOc9KvXhjNBrqxNxcv0f4RKeue9SH+KWEvxSgdLYVkNppwGlnng+GF/wG8tqvx2zIzCRdOb/DevqUz6Oj5zHFFb0Tztso01XtaQ1YymR4K43II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237544; c=relaxed/simple;
	bh=ubuEjmLy2kImJfqKlWH5VdcWP18WDUWYFH4tWBBfrDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEaoUFisoikFKb+XHSLSK/y7BeXQoURZe545BI4Fa08I9RCK0jD+u2i9dVSJccJIZ5m38ksJEbUQELmB108M7yXk2Nlqah7B2RCeWbpTWI/qEpurv32LlOA0/AX1PMCLKuS/pk99Y75ndywerEOiRTKGECLWi/3hS8YUvbRWgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CWrXKmDa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d78062424so1039777866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 22:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762237540; x=1762842340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F21nu/70Y4PIfJ/LJgoigNQF+DEjcT0vVb1Y4wntgZo=;
        b=CWrXKmDam1D58J4SxpJi7chMazeSRUcECyK+V/3D66pFkBxf6WMl9e/Kpk4WPyw+5+
         lunjZpQ/1wlvEj1f6EuVS6lVjcKTi+qBBCW4tLfh3NEG//YSHUE4ZXkd/uKAyr5vHtRE
         L+aTFqCcsyjxR4HJsAhK4aHyLyu3LwJ8WuwFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762237540; x=1762842340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F21nu/70Y4PIfJ/LJgoigNQF+DEjcT0vVb1Y4wntgZo=;
        b=wOz38tamj7yNEdQCUClOYLIyYHHba50M82orQg0oxTzRMZjiA3F22u5x1peV7Utaty
         bu/gJ7fLI12eu1Id/IcBoCkQ20s5MK0NsLQEW5X/GinqaH6srQgJ/5/amANiCqz31RaR
         PzWDq8FxQ7zyNQZ2jbFCK2i26V16Oolu1jmG/Cyy9TVJHtkYQGZmBG3B0Y5Nt+RxCcpA
         BMc6ToDyfBoqbIOUoOP7SWDenwa7VFHlc8O4dVmpIjFxN8+MpxubMHxOotsHtUbzBCXN
         jK41AqB0QhRe7XNtLhGRmofobeLMw6yGQMMjSjixeiG/nz1zpoh9VBr3mo/ZF2WKUoaN
         xAMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8u8GeubHDHbRt4U5Ff/AGCgfpa47WHUalen0MRmNXtLuCR6+S7IjlQEyi1hAmo9gRU3eTOtMl+6463R3@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcWkmMtnsLX7K0iKK4K6mPf9BtEU1PpL8DvTUsczuGUozjH2T
	RehQltheRvGB1YvsYJKYMfmoy3NwDF8IWnBgDLrWYvKXETy/jNngesTvsL/Kqg0gGTNPcq5pRLD
	h7y1J2BbLvA==
X-Gm-Gg: ASbGncvnwwsBLvkEBrTMuPJrOU03pP2z00vN+UDLxFyivP57bBfrMfQs2VrKussEMJn
	+YavVcDS0FgtcIFbdq80Oy3yNbTWBdG7f86NkkDn1kIG4M/vzHLvmDNxTrljsjbdub/owjM6+cW
	iCdyx2mAEedCGDYiiU9hvMVEdPGGkC0xGDTynq/LZwUnFo87QJbKwO+RvnwNzYBmfyeGhmBwOvy
	NiMFQWLXMG45eHx9gB1xhQ5SwZkqRyNWkMIiCs1ItICSVn8HSDP903z5o9XBi3p+h2LtusYi24+
	d3QwmJos0+O2G4vtI4HtiEnUpnRh8mkmeFGG+HAUzQJ3yNtkM4FhcHebzLXaB2WQ+9XsIHraZWX
	gIdlRWolK1Rt8KEXEf91RHNDHkLVIk+MTsjkuB4KBbWJiORFUy4ip7xDzQkkWlSZLWhq2bQNPKR
	seaWTMBXqscC/9FGdMlAC92OSIPyjOBYrkzwV4Mz0K7AsTh1HVwQbfCb1BfLXF
X-Google-Smtp-Source: AGHT+IFM6D2i1+XgUh1AOuEoHlQaK16ynuHtuiZiJ6v8TUlcm3dGIWxTDZWHO+/katDb6+SuuPDChg==
X-Received: by 2002:a17:906:c114:b0:b6d:6c11:e9fe with SMTP id a640c23a62f3a-b70708ad2acmr1465257666b.64.1762237539674;
        Mon, 03 Nov 2025 22:25:39 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72596bb0f1sm6620366b.0.2025.11.03.22.25.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 22:25:38 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3b27b50090so800113066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 22:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2juFdjn2PUZxOpeJhVUo9cRJTKuZMVpaE4VrzoDTSVrb0k7p+55TIKQDgiYhRCqZhvWndYUx4VDHHnsXQ@vger.kernel.org
X-Received: by 2002:a17:906:d555:b0:b70:b5ce:e66e with SMTP id
 a640c23a62f3a-b70b5cf23acmr702009266b.21.1762237537508; Mon, 03 Nov 2025
 22:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
In-Reply-To: <20251031174220.43458-2-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 15:25:20 +0900
X-Gmail-Original-Message-ID: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
X-Gm-Features: AWmQ_bkCiE0d-T6yyLCYrNs9euBFEsDAScPsO79Es5nrtD56kkYzWZYWoyCfZ7k
Message-ID: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: multipart/mixed; boundary="0000000000006f35580642bee61d"

--0000000000006f35580642bee61d
Content-Type: text/plain; charset="UTF-8"

[ Adding x86 maintainers - I had added Thomas earlier, but I guess at
least Borislav might actually care and have input too ]

So I think the patch I will commit would look like the attached: it's
similar to your suggestion, but without the renaming of USER_PTR_MAX,
and with just a

  #ifdef MODULE
    #define runtime_const_ptr(sym) (sym)
  #else
    #include <asm/runtime-const.h>
  #endif

in the x86 asm/uaccess_64.h header file and an added '#error' for the
MODULE case in the actual x86 runtime-const.h file.

As it is, this bug really only affects modular code that uses
access_ok() and __{get,put}_user(), which is a really broken pattern
to begin with these days, and is happily fairly rare.

That is an old optimization that is no longer an optimization at all
(since a plain "get_user()" is actually *faster* than the access_ok()
and __get_user() these days), and I wish we didn't have any such code
any more, but there are a handful of things that have never been
converted to the modern world order.

So it is what it is, and we have to deal with it.

Also, even that kind of rare and broken code actually *works*,
although the whole "non-canonical reads can speculatively leak
possibly kernel data" does end up being an issue (largely theoretical
because it's now limited to just a couple of odd-ball code sequences)

And yes, it works just because I picked a runtime-const value that is
non-canonical. I'd say it's "by luck", but I did pick that value
partly *because* it's non-canonical, so it's not _entirely_ just luck.
But mostly.

That was all a long explanation for why I am planning on committing
this as a real fix, even if the actual impact of it is largely
theoretical.

Borislav - comments? Generating this patch took longer than it should
have, but I had travel and jetlag and a flight that I expected to have
wifi but didn't...  And properly it should probably be committed by
x86 maintainers rather than me, but I did mess this code up in the
first place.

The patch *looks* very straightforward, but since I'm on the road I am
doing this on my laptop and haven't actually tested it yet (well, I've
built this, and booted it, but nothing past that).

Mateusz - I'd like to just credit you with this, since your comment
about modules was why I started looking into this all in the first
place (and you then wrote a similar patch). But I'm not going to do
that without your ack.

               Linus

--0000000000006f35580642bee61d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mhk6mmvp0>
X-Attachment-Id: f_mhk6mmvp0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCB8ICA0ICsrKysKIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaCAgICB8IDEwICsrKysrLS0tLS0KIGFyY2gveDg2L2tl
cm5lbC9jcHUvY29tbW9uLmMgICAgICAgICB8ICA2ICsrKysrLQogMyBmaWxlcyBjaGFuZ2VkLCAx
NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3J1bnRpbWUtY29uc3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3J1bnRpbWUt
Y29uc3QuaAppbmRleCA4ZDk4M2NmZDA2ZWEuLmU1YTEzZGM4ODE2ZSAxMDA2NDQKLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vcnVudGltZS1jb25zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3J1bnRpbWUtY29uc3QuaApAQCAtMiw2ICsyLDEwIEBACiAjaWZuZGVmIF9BU01fUlVOVElN
RV9DT05TVF9ICiAjZGVmaW5lIF9BU01fUlVOVElNRV9DT05TVF9ICiAKKyNpZmRlZiBNT0RVTEUK
KyAgI2Vycm9yICJDYW5ub3QgdXNlIHJ1bnRpbWUtY29uc3QgaW5mcmFzdHJ1Y3R1cmUgZnJvbSBt
b2R1bGVzIgorI2VuZGlmCisKICNpZmRlZiBfX0FTU0VNQkxZX18KIAogLm1hY3JvIFJVTlRJTUVf
Q09OU1RfUFRSIHN5bSByZWcKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nl
c3NfNjQuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaAppbmRleCBjOGE1YWUz
NWM4NzEuLjY0MWY0NWMyMmY5ZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFj
Y2Vzc182NC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3NfNjQuaApAQCAtMTIs
MTIgKzEyLDEyIEBACiAjaW5jbHVkZSA8YXNtL2NwdWZlYXR1cmVzLmg+CiAjaW5jbHVkZSA8YXNt
L3BhZ2UuaD4KICNpbmNsdWRlIDxhc20vcGVyY3B1Lmg+Ci0jaW5jbHVkZSA8YXNtL3J1bnRpbWUt
Y29uc3QuaD4KIAotLyoKLSAqIFZpcnR1YWwgdmFyaWFibGU6IHRoZXJlJ3Mgbm8gYWN0dWFsIGJh
Y2tpbmcgc3RvcmUgZm9yIHRoaXMsCi0gKiBpdCBjYW4gcHVyZWx5IGJlIHVzZWQgYXMgJ3J1bnRp
bWVfY29uc3RfcHRyKFVTRVJfUFRSX01BWCknCi0gKi8KKyNpZmRlZiBNT0RVTEUKKyAgI2RlZmlu
ZSBydW50aW1lX2NvbnN0X3B0cihzeW0pIChzeW0pCisjZWxzZQorICAjaW5jbHVkZSA8YXNtL3J1
bnRpbWUtY29uc3QuaD4KKyNlbmRpZgogZXh0ZXJuIHVuc2lnbmVkIGxvbmcgVVNFUl9QVFJfTUFY
OwogCiAjaWZkZWYgQ09ORklHX0FERFJFU1NfTUFTS0lORwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKaW5kZXgg
YzdkMzUxMjkxNGNhLi4wMmQ5NzgzNGExZDQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvY29tbW9uLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYwpAQCAtNzgsNiAr
NzgsMTAgQEAKIERFRklORV9QRVJfQ1BVX1JFQURfTU9TVExZKHN0cnVjdCBjcHVpbmZvX3g4Niwg
Y3B1X2luZm8pOwogRVhQT1JUX1BFUl9DUFVfU1lNQk9MKGNwdV9pbmZvKTsKIAorLyogVXNlZCBm
b3IgbW9kdWxlczogYnVpbHQtaW4gY29kZSB1c2VzIHJ1bnRpbWUgY29uc3RhbnRzICovCit1bnNp
Z25lZCBsb25nIFVTRVJfUFRSX01BWDsKK0VYUE9SVF9TWU1CT0woVVNFUl9QVFJfTUFYKTsKKwog
dTMyIGVsZl9od2NhcDIgX19yZWFkX21vc3RseTsKIAogLyogTnVtYmVyIG9mIHNpYmxpbmdzIHBl
ciBDUFUgcGFja2FnZSAqLwpAQCAtMjU3OSw3ICsyNTgzLDcgQEAgdm9pZCBfX2luaXQgYXJjaF9j
cHVfZmluYWxpemVfaW5pdCh2b2lkKQogCWFsdGVybmF0aXZlX2luc3RydWN0aW9ucygpOwogCiAJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX1g4Nl82NCkpIHsKLQkJdW5zaWduZWQgbG9uZyBVU0VSX1BU
Ul9NQVggPSBUQVNLX1NJWkVfTUFYOworCQlVU0VSX1BUUl9NQVggPSBUQVNLX1NJWkVfTUFYOwog
CiAJCS8qCiAJCSAqIEVuYWJsZSB0aGlzIHdoZW4gTEFNIGlzIGdhdGVkIG9uIExBU1Mgc3VwcG9y
dAo=
--0000000000006f35580642bee61d--

