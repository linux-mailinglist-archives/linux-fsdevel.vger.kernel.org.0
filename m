Return-Path: <linux-fsdevel+bounces-20166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CDB8CF290
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 07:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97EE1F2126B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0D1FA5;
	Sun, 26 May 2024 05:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q04vE/Nn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCC1A2C1D
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716700083; cv=none; b=jLNFHhJ7R2EqYRXbiC6icQFDqEhcWXnLun5eIIO6eadTl6GW9YGUv3DIVG8vheFbAZWaPJvNcI9N/cFI9BAi8afKT7IHulFwDl2PoWE0uzhkWu+I/wRUXfUivRjyuWkcIVd9DrI4rVVugoE1DOXBU7r9NLkkyJb65/UE9F8Ejck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716700083; c=relaxed/simple;
	bh=6TpbQGOzm1TK1AWkb7x1al1XxOWPdbLNGq+G4FKAa2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhZMm5Fw2Un9/HZ1MpjUCQ2fx8hTe/uLeFubwCe0UccKdiivIiNf2P5gVJUluHQMz58x7wGq8Mth9+Zx7ZBYvzIfuxDzJt6sEtDRbGBUn4TqP2wJbopXLXmaSDgAtXxjLFcb5EaQL0rvBQO9W94cl5JOMRY3KSlp5t8ww4z7s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q04vE/Nn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5788eaf5320so848632a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716700079; x=1717304879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W9v3n21tw1t78rmDeyKZUV+aOEclcFgn/2PUfzT+BoM=;
        b=Q04vE/Nnj+16ipLa2upSwj47oto6kxUqiM1xNpD3IZSWAr/H3Cta7/l4WI2M+rSDhB
         gf2OHUXLUkGtY17Kb/eglxxJy+0+0WwCNdXUaM99+f5NUuUfp+0hzmTyoGNfqsHoa9JM
         pq/69JS9lIA0eojHNZBDviceiL6lI9G8UbKjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716700079; x=1717304879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9v3n21tw1t78rmDeyKZUV+aOEclcFgn/2PUfzT+BoM=;
        b=xBY794Jt71I5Q4/NXD8shQeVUz+HXNQqK+ItQUkwC1Ki+YLzXIvXBQxaxuayk49uTB
         xwjrN8icjBxwROj6M5xVBzCJeVw1FAyOEGLdydNbmwdE5A2pOeaqAET7b+Td68vBDeDV
         wzttNzT6CXrV9PEqX+QOpRPQlenEQUg07jrDfpLPQV+1c9PsDzIHd+XyXwonuD0hgBoy
         nSrRC5bDkPeOUGSfdS8FWRrfskJwJPSa11Har+W4VRIwwCoZQMRrVM7qipRf1kAHnrU3
         wFUZ68o8NwE9OobeTapK3UbNKKQKSOyjnx8EYbaW+u9UbV0CfP4nRm6Zf0sZe4fFYn+Q
         //qg==
X-Forwarded-Encrypted: i=1; AJvYcCUU5wD5+y1YjHtMvTXxaScwPUy/s6KwoRWMRWtU+zFFGwp/Rnn8BatpwJcN3eQ/btGqHex+TbaDIhfESekJJWZ+JRBm5swAZiKbCu0o6g==
X-Gm-Message-State: AOJu0YxMVwg9MZ76sqA5TNMUC1XkYBK8oshdvpzEnZmBMsQBYyT2htQ2
	lskEYJMnm5xUrfcn900x3d6lZPrHJu2umCIB1omZ+2ihfivqKsekD4FIZGNeQwFlafx7504etLA
	r93q+RA==
X-Google-Smtp-Source: AGHT+IFYRxflNaGlDuvPwe5mN0FSxy7xsX9LuPQ60aN7AbFcPqtraf9qeYkKhBZRHwgZh73ghfuv/A==
X-Received: by 2002:a17:906:f9c9:b0:a5a:f16:32b1 with SMTP id a640c23a62f3a-a62641cfb1dmr432232266b.31.1716700078644;
        Sat, 25 May 2024 22:07:58 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817357sm332127566b.44.2024.05.25.22.07.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 22:07:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5785d466c82so2253652a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 May 2024 22:07:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUBOMtFFFfKAO1J5t3ExKFptRoOFVuYLxo4K4EuDJxKrPqo99UhlfFbF5UHfBS8qCokwydHPb3zSHL4AnzdCWR1sUNdgBrjIKvTViLoA==
X-Received: by 2002:a17:906:d18d:b0:a59:ab57:741e with SMTP id
 a640c23a62f3a-a6265112305mr426487966b.76.1716700077223; Sat, 25 May 2024
 22:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV>
In-Reply-To: <20240526034506.GZ2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 22:07:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
Message-ID: <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004a2ad90619546221"

--0000000000004a2ad90619546221
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 20:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Checking the theory that the important part in sockfd_lookup_light() is
> avoiding needless file refcount operations, not the marginal reduction
> of the register pressure from not keeping a struct file pointer in the
> caller.

Yeah, the register pressure thing is not likely an issue. That said, I
think we can fix it.

> If that's true, we should get the same benefits from straight fdget()/fdput().

Agreed.

That said, your patch is just horrendous.

> +static inline bool fd_empty(struct fd f)
> +{
> +       // better code with gcc that way
> +       return unlikely(!(f.flags | (unsigned long)f.file));
> +}

Ok, this is disgusting. I went all "WTF?"

And then looked at why you would say that testing two different fields
in a 'struct fd' would possibly be better than just checking one.

And I see why that's the case - it basically short-circuits the
(inlined) __to_fd() logic, and the compiler can undo it and look at
the original single-word value.

But it's still disgusting. If there is anything else in between, the
compiler wouldn't then notice any more.

What we *really* should do is have 'struct fd' just *be* that
single-word value, never expand it to two words at all, and instead of
doing "fd.file" we'd do "fd_file(fd)" and "fd_flags(fd)".

Maybe it's not too late to do that?

This is *particularly* true for the socket code that doesn't even want
the 'struct file *' at all outside of that "check that it's a socket,
then turn it into a socket pointer". So _particularly_ in that
context, having a "fd_file()" helper to do the (trivial) unpacking
would work very well.

But even without changing 'struct fd', maybe we could just have
"__fdget()" and friends not return a "unsigned long", but a "struct
rawfd".

Which would is a struct with an unsigned long.

There's actually a possible future standard C++ extension for what we
want to do ("C++ tagged pointers") and while it might make it into C
eventually, we'd have to do it manully with ugly inline helpers (LLVM
does it manually in C++ with a PointerIntPair class).

IOW, we could do something like the attached. I think it's actually
almost a cleanup, and now your socket things can use "struct rawfd"
and that fd_empty() becomes

   static inline bool rawfd_empty(struct rawfd raw)
   { return !raw.word; }

instead. Still somewhat disgusting, but now it's a "C doesn't have
tagged pointers, so we do this by hand" _understandable_ disgusting.

Hmm? The attached patch compiles. It looks "ObviouslyCorrect(tm)". But
it might be "TotallyBroken(tm)". You get the idea.

               Linus

--0000000000004a2ad90619546221
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lwn2kuaq0>
X-Attachment-Id: f_lwn2kuaq0

IGZzL2ZpbGUuYyAgICAgICAgICAgIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQogaW5jbHVk
ZS9saW51eC9maWxlLmggfCAyMiArKysrKysrKysrKysrKysrKy0tLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDI4IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2Zp
bGUuYyBiL2ZzL2ZpbGUuYwppbmRleCA4MDc2YWVmOWMyMTAuLmExZjQ0NzYwZGRiZiAxMDA2NDQK
LS0tIGEvZnMvZmlsZS5jCisrKyBiL2ZzL2ZpbGUuYwpAQCAtMTEyOCw3ICsxMTI4LDcgQEAgRVhQ
T1JUX1NZTUJPTCh0YXNrX2xvb2t1cF9uZXh0X2ZkZ2V0X3JjdSk7CiAgKiBUaGUgZnB1dF9uZWVk
ZWQgZmxhZyByZXR1cm5lZCBieSBmZ2V0X2xpZ2h0IHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlCiAg
KiBjb3JyZXNwb25kaW5nIGZwdXRfbGlnaHQuCiAgKi8KLXN0YXRpYyB1bnNpZ25lZCBsb25nIF9f
ZmdldF9saWdodCh1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3QgbWFzaykKK3N0YXRpYyBzdHJ1Y3Qg
cmF3ZmQgX19mZ2V0X2xpZ2h0KHVuc2lnbmVkIGludCBmZCwgZm1vZGVfdCBtYXNrKQogewogCXN0
cnVjdCBmaWxlc19zdHJ1Y3QgKmZpbGVzID0gY3VycmVudC0+ZmlsZXM7CiAJc3RydWN0IGZpbGUg
KmZpbGU7CkBAIC0xMTQ1LDIyICsxMTQ1LDIyIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9fZmdl
dF9saWdodCh1bnNpZ25lZCBpbnQgZmQsIGZtb2RlX3QgbWFzaykKIAlpZiAobGlrZWx5KGF0b21p
Y19yZWFkX2FjcXVpcmUoJmZpbGVzLT5jb3VudCkgPT0gMSkpIHsKIAkJZmlsZSA9IGZpbGVzX2xv
b2t1cF9mZF9yYXcoZmlsZXMsIGZkKTsKIAkJaWYgKCFmaWxlIHx8IHVubGlrZWx5KGZpbGUtPmZf
bW9kZSAmIG1hc2spKQotCQkJcmV0dXJuIDA7Ci0JCXJldHVybiAodW5zaWduZWQgbG9uZylmaWxl
OworCQkJcmV0dXJuIEVNUFRZX1JBV0ZEOworCQlyZXR1cm4gKHN0cnVjdCByYXdmZCkgeyAodW5z
aWduZWQgbG9uZylmaWxlIH07CiAJfSBlbHNlIHsKIAkJZmlsZSA9IF9fZmdldF9maWxlcyhmaWxl
cywgZmQsIG1hc2spOwogCQlpZiAoIWZpbGUpCi0JCQlyZXR1cm4gMDsKLQkJcmV0dXJuIEZEUFVU
X0ZQVVQgfCAodW5zaWduZWQgbG9uZylmaWxlOworCQkJcmV0dXJuIEVNUFRZX1JBV0ZEOworCQly
ZXR1cm4gKHN0cnVjdCByYXdmZCkgeyBGRFBVVF9GUFVUIHwgKHVuc2lnbmVkIGxvbmcpZmlsZSB9
OwogCX0KIH0KLXVuc2lnbmVkIGxvbmcgX19mZGdldCh1bnNpZ25lZCBpbnQgZmQpCitzdHJ1Y3Qg
cmF3ZmQgX19mZGdldCh1bnNpZ25lZCBpbnQgZmQpCiB7CiAJcmV0dXJuIF9fZmdldF9saWdodChm
ZCwgRk1PREVfUEFUSCk7CiB9CiBFWFBPUlRfU1lNQk9MKF9fZmRnZXQpOwogCi11bnNpZ25lZCBs
b25nIF9fZmRnZXRfcmF3KHVuc2lnbmVkIGludCBmZCkKK3N0cnVjdCByYXdmZCBfX2ZkZ2V0X3Jh
dyh1bnNpZ25lZCBpbnQgZmQpCiB7CiAJcmV0dXJuIF9fZmdldF9saWdodChmZCwgMCk7CiB9CkBA
IC0xMTgxLDEzICsxMTgxLDEzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBmaWxlX25lZWRzX2ZfcG9z
X2xvY2soc3RydWN0IGZpbGUgKmZpbGUpCiAJCShmaWxlX2NvdW50KGZpbGUpID4gMSB8fCBmaWxl
LT5mX29wLT5pdGVyYXRlX3NoYXJlZCk7CiB9CiAKLXVuc2lnbmVkIGxvbmcgX19mZGdldF9wb3Mo
dW5zaWduZWQgaW50IGZkKQorc3RydWN0IHJhd2ZkIF9fZmRnZXRfcG9zKHVuc2lnbmVkIGludCBm
ZCkKIHsKLQl1bnNpZ25lZCBsb25nIHYgPSBfX2ZkZ2V0KGZkKTsKLQlzdHJ1Y3QgZmlsZSAqZmls
ZSA9IChzdHJ1Y3QgZmlsZSAqKSh2ICYgfjMpOworCXN0cnVjdCByYXdmZCB2ID0gX19mZGdldChm
ZCk7CisJc3RydWN0IGZpbGUgKmZpbGUgPSBmZGZpbGUodik7CiAKIAlpZiAoZmlsZSAmJiBmaWxl
X25lZWRzX2ZfcG9zX2xvY2soZmlsZSkpIHsKLQkJdiB8PSBGRFBVVF9QT1NfVU5MT0NLOworCQl2
LndvcmQgfD0gRkRQVVRfUE9TX1VOTE9DSzsKIAkJbXV0ZXhfbG9jaygmZmlsZS0+Zl9wb3NfbG9j
ayk7CiAJfQogCXJldHVybiB2OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maWxlLmggYi9p
bmNsdWRlL2xpbnV4L2ZpbGUuaAppbmRleCA0NWQwZjQ4MDBhYmQuLjYwM2FhMzJmOTg1YyAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9maWxlLmgKKysrIGIvaW5jbHVkZS9saW51eC9maWxlLmgK
QEAgLTQyLDYgKzQyLDE4IEBAIHN0cnVjdCBmZCB7CiAjZGVmaW5lIEZEUFVUX0ZQVVQgICAgICAg
MQogI2RlZmluZSBGRFBVVF9QT1NfVU5MT0NLIDIKIAorLyogIlRhZ2dlZCBmaWxlIHBvaW50ZXIi
ICovCitzdHJ1Y3QgcmF3ZmQgeworCXVuc2lnbmVkIGxvbmcgd29yZDsKK307CisjZGVmaW5lIEVN
UFRZX1JBV0ZEIChzdHJ1Y3QgcmF3ZmQpIHsgMCB9CisKK3N0YXRpYyBpbmxpbmUgc3RydWN0IGZp
bGUgKmZkZmlsZShzdHJ1Y3QgcmF3ZmQgcmF3KQoreyByZXR1cm4gKHN0cnVjdCBmaWxlICopIChy
YXcud29yZCAmIH4zKTsgfQorCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBmZGZsYWdzKHN0
cnVjdCByYXdmZCByYXcpCit7IHJldHVybiByYXcud29yZCAmIDM7IH0KKwogc3RhdGljIGlubGlu
ZSB2b2lkIGZkcHV0KHN0cnVjdCBmZCBmZCkKIHsKIAlpZiAoZmQuZmxhZ3MgJiBGRFBVVF9GUFVU
KQpAQCAtNTEsMTQgKzYzLDE0IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmZHB1dChzdHJ1Y3QgZmQg
ZmQpCiBleHRlcm4gc3RydWN0IGZpbGUgKmZnZXQodW5zaWduZWQgaW50IGZkKTsKIGV4dGVybiBz
dHJ1Y3QgZmlsZSAqZmdldF9yYXcodW5zaWduZWQgaW50IGZkKTsKIGV4dGVybiBzdHJ1Y3QgZmls
ZSAqZmdldF90YXNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgdW5zaWduZWQgaW50IGZkKTsK
LWV4dGVybiB1bnNpZ25lZCBsb25nIF9fZmRnZXQodW5zaWduZWQgaW50IGZkKTsKLWV4dGVybiB1
bnNpZ25lZCBsb25nIF9fZmRnZXRfcmF3KHVuc2lnbmVkIGludCBmZCk7Ci1leHRlcm4gdW5zaWdu
ZWQgbG9uZyBfX2ZkZ2V0X3Bvcyh1bnNpZ25lZCBpbnQgZmQpOworZXh0ZXJuIHN0cnVjdCByYXdm
ZCBfX2ZkZ2V0KHVuc2lnbmVkIGludCBmZCk7CitleHRlcm4gc3RydWN0IHJhd2ZkIF9fZmRnZXRf
cmF3KHVuc2lnbmVkIGludCBmZCk7CitleHRlcm4gc3RydWN0IHJhd2ZkIF9fZmRnZXRfcG9zKHVu
c2lnbmVkIGludCBmZCk7CiBleHRlcm4gdm9pZCBfX2ZfdW5sb2NrX3BvcyhzdHJ1Y3QgZmlsZSAq
KTsKIAotc3RhdGljIGlubGluZSBzdHJ1Y3QgZmQgX190b19mZCh1bnNpZ25lZCBsb25nIHYpCitz
dGF0aWMgaW5saW5lIHN0cnVjdCBmZCBfX3RvX2ZkKHN0cnVjdCByYXdmZCByYXcpCiB7Ci0JcmV0
dXJuIChzdHJ1Y3QgZmQpeyhzdHJ1Y3QgZmlsZSAqKSh2ICYgfjMpLHYgJiAzfTsKKwlyZXR1cm4g
KHN0cnVjdCBmZCl7ZmRmaWxlKHJhdyksZmRmbGFncyhyYXcpfTsKIH0KIAogc3RhdGljIGlubGlu
ZSBzdHJ1Y3QgZmQgZmRnZXQodW5zaWduZWQgaW50IGZkKQo=
--0000000000004a2ad90619546221--

