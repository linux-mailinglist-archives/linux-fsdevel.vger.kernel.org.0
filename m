Return-Path: <linux-fsdevel+bounces-63567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA1BC2C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 23:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED82C3BB7BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7366F24729A;
	Tue,  7 Oct 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SdyDIoQW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A01C27
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873679; cv=none; b=VC5TTuPGUIufJSxi3XUU9HmMUNz2Eqvpwyj+j4Y6mYNJGxFQRGTC8wuIOWbYfQ5G5Ur6s4MjGesAh1SdfjRRdqMkfqsHo66tDLlpeGhBN08VhgiSkohSsKAwsCSLlvCMxzOqVu4pugOM9wE9tahKImvLqvBLF64uJD4GuEZsaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873679; c=relaxed/simple;
	bh=4CioMTe789qaZU6LyuZBsWxN4S0EhJplUkZl6Pqzu+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/zxKAWz82mC6Abo2vniZTPfSqwtXgfnbokjoa6woofWObghWKFDOrF7o++91GozdE+liBEoHE++6FRP6ijFbc6tWrPA30Do+CSGtxIhLW4nNJj99/ld4Jmgy4cAOdZqSXPGG7L4j16KrGMoPfhKS6rqFtskYkf6h4d6r4Wcrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SdyDIoQW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3ee18913c0so1069256466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759873675; x=1760478475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieAeKXE7WD+v9PCgJseY+hLwiQr0GAdIfqXkALMuGmE=;
        b=SdyDIoQW3MVbjB6UiVvdPNp6sY0d0Rug5mOnPQYL5AqlqZIPHib6nusGSBdHpo3Hmp
         jzOr5eHvGwgHHnlqAn7EoqRWt3N9b0h81bJVWqZrtcuNyP0dDOrXbdtQNUQ7EKOzgN7s
         U4PtSCNACSrZJ5NBJy5ZVSSPUlDB1tlofWIwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873675; x=1760478475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieAeKXE7WD+v9PCgJseY+hLwiQr0GAdIfqXkALMuGmE=;
        b=OcdQCDZMuoe7Z3BpXL5R29aFNO/UavbRQ2sMKIMgA8utd1yNk2XBVotAAIz0oybOVm
         y0zajuPfHLRhH/Jnm0OK+AEq66GL5O7EwIy1SCeWdBWn/m3pu8bHAeW9Gzp/zc62Zkva
         +OqGQHEJ5amNTM9mESDs8S8iSssbFVcQtXtp0oExRk4zhfp6D2SWLbMvi0HM3ZoKpJRZ
         Vh6/JQllYa8eQ+0NydHG8qLkCvSfhgds3z5K9TvyXQf2WX8W9QqBh/NBsv3EfZDg/e2N
         lqx8CKGLY0SwWycaUky2v18SoFcnOaGYGHGKKOwn5wNmOqN9Ra3VNZidUSLx1/ayv6+i
         e0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWsbHBaoGHfHB/jCcHyqpRVFjmPu7aOBhFEBK+WcevBprhMChvmvwIlcUKx3tm20zJ5R1/gp/z8J51gs+Bt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GwLDShUf0YAsQrRgYdLuEnHwVFQ3SMgud31LJeH8jD5SchKr
	HWcY5Ea9qjlBckmBWyvEUl0hxWWevvqEw4TO9e1mHrXrRnXsSKfsZL5BoOvIm8Ell85OoRlOUW0
	RXl/qBPA=
X-Gm-Gg: ASbGnctORr+X9evvC7IxoCaZAfkgeoqjVbeS+xH5vqJ7W28hv0cmfBA8fATjKMAIFk/
	XlrQv/QS+IjmcB8hdy3/L6QU826IGzajztpHopG0x1ELLNSPUhWFI7nmXIq13kXXdzO+uJapVWE
	sgjEo3h86mCXYBSzdKLF7HSSx8JO+MwynVTHsTWBNLkEcT9sj8rhiCMTTK+yzuxxkz8stQpFxtG
	CzkZYBtwHW6Ij/09P/5uPSA9508e7fjnDf8VIsRn1/+AyP9526FffYKCVb2eZtCIZ62d9lcFDfw
	4FhGfoWe6UJ1JX2+BTTKzH5aDs2T7WHE852s+IyaYibqeVMwwD+JyCjKcJz+lTCcqEK9vxm5cnk
	MUX4pQdXHhIpctPHfjBigrPoSUX3XMcNn6FfubgY7hr9ge122DPQ+ZRV9revuN62ozSEuHBc6X1
	W9ABgLwu2FDhW+M0cI9w0n
X-Google-Smtp-Source: AGHT+IE7IHZZ2+pxmxmPdlIDTehUSPyKubL0nGJ5SEwengcl71AGU8My/TBU7MqZIhziIRSzbTYMPQ==
X-Received: by 2002:a17:907:da1:b0:b3a:e4b3:eeb9 with SMTP id a640c23a62f3a-b50abfcd075mr143737666b.55.1759873675386;
        Tue, 07 Oct 2025 14:47:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606bd5csm1492220266b.44.2025.10.07.14.47.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:47:54 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso12208877a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 14:47:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVehghUqEYdD5iF5ei/qOrdrQr4S+EKbNqiXgM21B8azJeXCFql6q4NFa+W/lxVpb5TOkQGMP1KRJBteBNO@vger.kernel.org
X-Received: by 2002:a05:6402:50c7:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-639d5b417e9mr911951a12.8.1759873673957; Tue, 07 Oct 2025
 14:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com> <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
In-Reply-To: <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 14:47:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
X-Gm-Features: AS18NWBCU1N7GZs0SuQExAE_SCw5ZvyC_Nu0gByF0GlCjHapw4qeC1V1VKnS80o
Message-ID: <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000307b730640988582"

--000000000000307b730640988582
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 11:04, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> On Mon, Oct 06, 2025 at 08:50:55AM -0700, Linus Torvalds wrote:
> > On Mon, 6 Oct 2025 at 04:45, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > >
> > >  - Size of area is 256 bytes. I wounder if we want to get the fast read
> > >    to work on full page chunks. Can we dedicate a page per CPU for this?
> > >    I expect it to cover substantially more cases.
> >
> > I guess a percpu page would be good, but I really liked using the
> > buffer we already ended up having for that page array.
> >
> > Maybe worth playing around with.
>
> With page size buffer we might consider serving larger reads in the same
> manner with loop around filemap_fast_read().

Actually, thinking much more about this, I definitely do *not* think
that doing a separate page buffer is a good idea. I think it will only
cause the "fast path" to pollute more of the L1 cache, and slow things
down.

The on-stack buffer, in contrast, will pretty much either already be
in the cache, or would be brought into it regardless. So there's no
extra cache footprint from using it.

But the "loop around filemap_fast_read()" might be a fine idea even
with "just" the 256 byte buffer.

Something ENTIRELY UNTESTED like this, perhaps? This is relative to your patch.

Note: this also ends up doing it all with pagefaults disabled, becasue
that way we can do the looping without dropping and re-taking the RCU
lock. I'm not sure that is sensible, but whatever. Considering that I
didn't test this AT ALL, please just consider this a "wild handwaving"
patch.

           Linus

--000000000000307b730640988582
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mgh3c31f0>
X-Attachment-Id: f_mgh3c31f0

IG1tL2ZpbGVtYXAuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvbW0vZmlsZW1hcC5jIGIvbW0vZmlsZW1hcC5jCmluZGV4IDYwYTdiOTI3NTc0MS4uNTQx
MjczMzg4NTEyIDEwMDY0NAotLS0gYS9tbS9maWxlbWFwLmMKKysrIGIvbW0vZmlsZW1hcC5jCkBA
IC0yNjk3LDcgKzI2OTcsNyBAQCBzdGF0aWMgdm9pZCBmaWxlbWFwX2VuZF9kcm9wYmVoaW5kX3Jl
YWQoc3RydWN0IGZvbGlvICpmb2xpbykKIAl9CiB9CiAKLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQg
bG9uZyBmaWxlbWFwX2Zhc3RfcmVhZChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywKK3N0
YXRpYyB1bnNpZ25lZCBsb25nIGZpbGVtYXBfZmFzdF9yZWFkKHN0cnVjdCBhZGRyZXNzX3NwYWNl
ICptYXBwaW5nLAogCQkJCQkgICAgICBsb2ZmX3QgcG9zLCBjaGFyICpidWZmZXIsCiAJCQkJCSAg
ICAgIHNpemVfdCBzaXplKQogewpAQCAtMjc5MiwyMCArMjc5MiwzOCBAQCBzc2l6ZV90IGZpbGVt
YXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAkgKiBh
bnkgY29tcGlsZXIgaW5pdGlhbGl6YXRpb24gd291bGQgYmUgcG9pbnRsZXNzIHNpbmNlIHRoaXMK
IAkgKiBjYW4gZmlsbCBpdCB3aWxsIGdhcmJhZ2UuCiAJICovCi0JaWYgKGlvdl9pdGVyX2NvdW50
KGl0ZXIpIDw9IHNpemVvZihhcmVhKSkgeworCWlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8PSBQ
QUdFX1NJWkUpIHsKIAkJc2l6ZV90IGNvdW50ID0gaW92X2l0ZXJfY291bnQoaXRlcik7CisJCXNp
emVfdCBmYXN0X3JlYWQgPSAwOwogCiAJCS8qIExldCdzIHNlZSBpZiB3ZSBjYW4ganVzdCBkbyB0
aGUgcmVhZCB1bmRlciBSQ1UgKi8KIAkJcmN1X3JlYWRfbG9jaygpOwotCQljb3VudCA9IGZpbGVt
YXBfZmFzdF9yZWFkKG1hcHBpbmcsIGlvY2ItPmtpX3BvcywgYXJlYS5idWZmZXIsIGNvdW50KTsK
KwkJcGFnZWZhdWx0X2Rpc2FibGUoKTsKKwkJZG8geworCQkJc2l6ZV90IGNvcGllZCA9IG1pbihj
b3VudCwgc2l6ZW9mKGFyZWEpKTsKKworCQkJY29waWVkID0gZmlsZW1hcF9mYXN0X3JlYWQobWFw
cGluZywgaW9jYi0+a2lfcG9zLCBhcmVhLmJ1ZmZlciwgY29waWVkKTsKKwkJCWlmICghY29waWVk
KQorCQkJCWJyZWFrOworCQkJY29waWVkID0gY29weV90b19pdGVyKGFyZWEuYnVmZmVyLCBjb3Bp
ZWQsIGl0ZXIpOworCQkJaWYgKCFjb3BpZWQpCisJCQkJYnJlYWs7CisJCQlmYXN0X3JlYWQgKz0g
Y29waWVkOworCQkJaW9jYi0+a2lfcG9zICs9IGNvcGllZDsKKwkJCWFscmVhZHlfcmVhZCArPSBj
b3BpZWQ7CisJCQljb3VudCAtPSBjb3BpZWQ7CisJCX0gd2hpbGUgKGNvdW50KTsKKwkJcGFnZWZh
dWx0X2VuYWJsZSgpOwogCQlyY3VfcmVhZF91bmxvY2soKTsKLQkJaWYgKGNvdW50KSB7Ci0JCQlz
aXplX3QgY29waWVkID0gY29weV90b19pdGVyKGFyZWEuYnVmZmVyLCBjb3VudCwgaXRlcik7Ci0J
CQlpZiAodW5saWtlbHkoIWNvcGllZCkpCi0JCQkJcmV0dXJuIGFscmVhZHlfcmVhZCA/IGFscmVh
ZHlfcmVhZCA6IC1FRkFVTFQ7Ci0JCQlyYS0+cHJldl9wb3MgPSBpb2NiLT5raV9wb3MgKz0gY29w
aWVkOworCisJCWlmIChmYXN0X3JlYWQpIHsKKwkJCXJhLT5wcmV2X3BvcyArPSBmYXN0X3JlYWQ7
CisJCQlhbHJlYWR5X3JlYWQgKz0gZmFzdF9yZWFkOwogCQkJZmlsZV9hY2Nlc3NlZChmaWxwKTsK
LQkJCXJldHVybiBjb3BpZWQgKyBhbHJlYWR5X3JlYWQ7CisKKwkJCS8qIEFsbCBkb25lPyAqLwor
CQkJaWYgKCFjb3VudCkKKwkJCQlyZXR1cm4gYWxyZWFkeV9yZWFkOwogCQl9CiAJfQogCg==
--000000000000307b730640988582--

