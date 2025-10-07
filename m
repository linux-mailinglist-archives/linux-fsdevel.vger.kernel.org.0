Return-Path: <linux-fsdevel+bounces-63569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ACBC2E6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 00:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9FD6F34D4CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245502586C5;
	Tue,  7 Oct 2025 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZERnoRTy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266743A1D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877684; cv=none; b=nyAjsOVxsPqtt+m3KGDIpde18581JtjlVCW6FZ+sax9RpUxuUy+HE7AUG71slJTkxfyzqAwQGLqdUPPa+UHDAGuctfDlu40LdmL2IXyGCTszr6tfIcqv9O8ctOM43WUE1vGs/dckg/d3+KJySba1u+JN0i+gPaaJUF3iIk0E5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877684; c=relaxed/simple;
	bh=hW4pHmRkCfUaFRmWPc8tvhCiTymSaZfAyyYutsbNt6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDCMrdBQ7oE39kLs8cZUg1qjFKb6SCUXTFR0FuRca7/egQtmtU2P3/LtSLIXUmwSESjR8aXMdIaqv02yS+oVFrr7QViFES2a/pXX+KWZnCZgC7m1n9W1TE6vklnMpbm+94A1jOiEfrf+JugOZMG5GLTrHJx95VMR2LgOJcK4g7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZERnoRTy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso864526a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759877680; x=1760482480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iocGsaFxj9W0yHWPhGI/EVJ1XNtx6l/u9S4RmMWxmZo=;
        b=ZERnoRTyql2qL+3N1eyu3PgOwbFyO35nA1zSvRSDIa7O4s4r9fo1uCFblqNfMLLdYS
         vvg3fd/BR2kFiSDiuy80a+Gd1fGxPqXCv6c9awjkbVHyU+VLFl6lmCKVm2MFr/hEAtGo
         gJMm+EKOR4ifv/5n2PH3lb6la5WFQqRGIazb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877680; x=1760482480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iocGsaFxj9W0yHWPhGI/EVJ1XNtx6l/u9S4RmMWxmZo=;
        b=BlvKLUlU9IulAeRHcJeY8OsNBou72+/GLssOV3xXZiTK2+bYuuQHPubFAuEZvp/7kU
         v/WuS+xPrkw5fYA3/WGZpKywmmBbFcjxO+fdJvpXxXUoK/Qlgmfrog2/5G3wLIjoyFUa
         LJV3WJJj11d/h40mSXS9zKi2jwLFxFv6aTB59A2z6qOcF3aJ3Yd19xiLtxxJLlLUIPrw
         DSivEPJUz/NeabgIDrWZg8XT4FCwUU0LUPfKjJpdbaQeAAwX7TxFefOnfRGOX+w4effv
         NPmAn76+vr2FeFxBaLgMhLShR8cHEm39/rO+lgXfbUw0DZSHzUyn3uXbQ6zFtwCP3AV0
         pxlw==
X-Forwarded-Encrypted: i=1; AJvYcCVVbjTZk1A1peeRJYQRsgd+7A61fjabZv77nsnK5pOH8O4p21nXKh2ZWPqwLuYZT38sxCcgqsTc0lf8WPC3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/wBQA4biNzOVuVRrfqhSFEO3aNSea0IDBidZztVIXF/BpXrE
	/dX4wBXrlvuoDymPTovFtTj8+cfwscPvz9deYzb+57tYyiTiOj+zJ1L8//XJZF++vAMVFXMJ35s
	owmJdncc=
X-Gm-Gg: ASbGncsF+wzzEwnnshzN80ihvmT3815n7DgoG5Ft0NFWhK4bPL7r4XMsg0Rs+POgKPR
	yVjWAnVRZhCm4UF3+EYUaaeG8LVBB5cLXD3SA/TsrhK2L/3QPjZqXoM+8VijjeFiJmNV1m44RrT
	aVeb48W/l1DlO2r6iL7A84uD5dzTU7o7CXpXBN2G3x0SQOajJupZA1ZmGi0ZDvFuqbtMYB0UGID
	oDFkrxv8ca+pz3Lxz+izhiVI7rNfAmHQl3p/U1AQdL5M62lFm0MiKM74dyfYwWyDBDfeQ8ZXYl4
	0dXgRXkzbAXPklewS8r8LVC70Ls0ZCRvMei6PI8EjchvSDwhjHM+BeyaFYmh5CD3WUtLGAAaK52
	JSKxkc9fu5kpHda1DY5zVqpQ2uqaQsLUIJMi97mhCMBx9u4ZoY9zTp8Frh/98sznTbQpZOGoOOk
	Qjarxq6EQqF50dLYBtE1JO
X-Google-Smtp-Source: AGHT+IFUtB3bzpjXaFSyuFz9a+cyAyZHPmkkyHG0mzzq0BwTNa7HY5Oe8XrZzliGGKkL/6+mDt4wug==
X-Received: by 2002:a05:6402:234c:b0:61f:eb87:fde7 with SMTP id 4fb4d7f45d1cf-639d616e7bdmr1233895a12.17.1759877680303;
        Tue, 07 Oct 2025 15:54:40 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788110224sm13183066a12.39.2025.10.07.15.54.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:54:39 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3d80891c6cso53148066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 15:54:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaapkpWlmmWLe21t7LAxO7SdBrXcpy/G9yIgnE/qb/Prpwmwu+iPiysmQTatQju+lrq5hhc7JNL0XAbjhX@vger.kernel.org
X-Received: by 2002:a17:907:a70d:b0:b4a:e7fa:3196 with SMTP id
 a640c23a62f3a-b4f429efe15mr563250766b.20.1759877677521; Tue, 07 Oct 2025
 15:54:37 -0700 (PDT)
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
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com> <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
In-Reply-To: <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 15:54:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
X-Gm-Features: AS18NWCjiZmGz9lB5bT-2RpXXU6lsyJbiuU0NDcMLPnF_ouVHC3HSZomRtmlOeE
Message-ID: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d19e860640997327"

--000000000000d19e860640997327
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I think I'll try to boot it next. Wish me luck.

Bah. It boots - after you fix the stupid double increment of 'already_copied'.

I didn't remove the update inside the loop when I made it update it
after the loop.

So here's the slightly fixed patch that actually does boot - and that
I'm running right now. But I wouldn't call it exactly "tested".

Caveat patchor.

          Linus

--000000000000d19e860640997327
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mgh5pv7k0>
X-Attachment-Id: f_mgh5pv7k0

CiBtbS9maWxlbWFwLmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRleCA2MGE3YjkyNzU3NDEuLmJhMTFm
MDE4Y2E2YiAxMDA2NDQKLS0tIGEvbW0vZmlsZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAt
Mjc5MiwyMCArMjc5MiwzNyBAQCBzc2l6ZV90IGZpbGVtYXBfcmVhZChzdHJ1Y3Qga2lvY2IgKmlv
Y2IsIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAkgKiBhbnkgY29tcGlsZXIgaW5pdGlhbGl6YXRp
b24gd291bGQgYmUgcG9pbnRsZXNzIHNpbmNlIHRoaXMKIAkgKiBjYW4gZmlsbCBpdCB3aWxsIGdh
cmJhZ2UuCiAJICovCi0JaWYgKGlvdl9pdGVyX2NvdW50KGl0ZXIpIDw9IHNpemVvZihhcmVhKSkg
eworCWlmIChpb3ZfaXRlcl9jb3VudChpdGVyKSA8PSBQQUdFX1NJWkUpIHsKIAkJc2l6ZV90IGNv
dW50ID0gaW92X2l0ZXJfY291bnQoaXRlcik7CisJCXNpemVfdCBmYXN0X3JlYWQgPSAwOwogCiAJ
CS8qIExldCdzIHNlZSBpZiB3ZSBjYW4ganVzdCBkbyB0aGUgcmVhZCB1bmRlciBSQ1UgKi8KIAkJ
cmN1X3JlYWRfbG9jaygpOwotCQljb3VudCA9IGZpbGVtYXBfZmFzdF9yZWFkKG1hcHBpbmcsIGlv
Y2ItPmtpX3BvcywgYXJlYS5idWZmZXIsIGNvdW50KTsKKwkJcGFnZWZhdWx0X2Rpc2FibGUoKTsK
KwkJZG8geworCQkJc2l6ZV90IGNvcGllZCA9IG1pbihjb3VudCwgc2l6ZW9mKGFyZWEpKTsKKwor
CQkJY29waWVkID0gZmlsZW1hcF9mYXN0X3JlYWQobWFwcGluZywgaW9jYi0+a2lfcG9zLCBhcmVh
LmJ1ZmZlciwgY29waWVkKTsKKwkJCWlmICghY29waWVkKQorCQkJCWJyZWFrOworCQkJY29waWVk
ID0gY29weV90b19pdGVyKGFyZWEuYnVmZmVyLCBjb3BpZWQsIGl0ZXIpOworCQkJaWYgKCFjb3Bp
ZWQpCisJCQkJYnJlYWs7CisJCQlmYXN0X3JlYWQgKz0gY29waWVkOworCQkJaW9jYi0+a2lfcG9z
ICs9IGNvcGllZDsKKwkJCWNvdW50IC09IGNvcGllZDsKKwkJfSB3aGlsZSAoY291bnQpOworCQlw
YWdlZmF1bHRfZW5hYmxlKCk7CiAJCXJjdV9yZWFkX3VubG9jaygpOwotCQlpZiAoY291bnQpIHsK
LQkJCXNpemVfdCBjb3BpZWQgPSBjb3B5X3RvX2l0ZXIoYXJlYS5idWZmZXIsIGNvdW50LCBpdGVy
KTsKLQkJCWlmICh1bmxpa2VseSghY29waWVkKSkKLQkJCQlyZXR1cm4gYWxyZWFkeV9yZWFkID8g
YWxyZWFkeV9yZWFkIDogLUVGQVVMVDsKLQkJCXJhLT5wcmV2X3BvcyA9IGlvY2ItPmtpX3BvcyAr
PSBjb3BpZWQ7CisKKwkJaWYgKGZhc3RfcmVhZCkgeworCQkJcmEtPnByZXZfcG9zICs9IGZhc3Rf
cmVhZDsKKwkJCWFscmVhZHlfcmVhZCArPSBmYXN0X3JlYWQ7CiAJCQlmaWxlX2FjY2Vzc2VkKGZp
bHApOwotCQkJcmV0dXJuIGNvcGllZCArIGFscmVhZHlfcmVhZDsKKworCQkJLyogQWxsIGRvbmU/
ICovCisJCQlpZiAoIWNvdW50KQorCQkJCXJldHVybiBhbHJlYWR5X3JlYWQ7CiAJCX0KIAl9CiAK
--000000000000d19e860640997327--

