Return-Path: <linux-fsdevel+bounces-63676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B037BCA5FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F191A644E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA89242D69;
	Thu,  9 Oct 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KCNAX1AN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006AA31
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030977; cv=none; b=pOzVlUgxvGMQYLzOoFW6WoOsOfiCE1hDZhrQPimo62YliA9g/IA/67NXYC4G/vD+IGWTOxSHl3mWQmrEViRD+uY34tvFL650vwG+pTIg7mXXfvfy1UP9St5tqCF+8Ljq4vKEWZT7GmdqVAdzosVGkRJTum4iVnQuR1B621MgGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030977; c=relaxed/simple;
	bh=9qOquXIG4wn1svJJJb5+m2oTSm5s2mFPOLOoFh1xUDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZ8dF7XLXxdh08eTRwnJMFWC4/val6DUz5kAGjMHUHUpO4GqHMA6SCUUnnIWDJYAlZTgoJRVVwzdHU9JJYlp6UDzg25Li/HNDhfMcaNL1hXSwq2Bt6uteDCIyhlXTNIx2DXvzKlu3JvkRUOrxIxVygWgqpBFDGp6+GLj6sw7PKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KCNAX1AN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso2042106a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760030973; x=1760635773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dPx2sbctu0M7xDmpPB5FNDq3+BQ6qXvsQGjhqoyqbsU=;
        b=KCNAX1ANRghoSypqmyoD9pSFVlSwZsHE+qNSvNuPUGO/ZJe670NP+c8yLBpmvpGfWK
         S38Pb487819VcvPQTGPnVqFm2Z19BMK6wGWcLtxX7g8D14XtKBnP2DmfnYZ0i1OINdUq
         qctk4s5OQdD0AAK09+E7eyf6KxbrcVPOHiQzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030973; x=1760635773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPx2sbctu0M7xDmpPB5FNDq3+BQ6qXvsQGjhqoyqbsU=;
        b=axGJMIl2ZGdoSO0tNKmXqmMuMMc/rQvdQFdv1QfC+OMI0fmIfcMYAlibm4B1B8CZrc
         Ra5DGzj6OZu8yzpqlQHCFC6Gv+7kiBFfKzNSJWBQfQINDpokodkKvlPeW0V2TXH0mH5x
         0CZ06z3CfiORRVnc3XWY5Ewj0YFDC1PI1+Q5TPorE6wMOvpBG3QnX/KwY1V8HbruZ/OK
         sKAkOa/mTPzOt1TdwxCHrcWlhSJbIs6p13AXlpbA/fOJJrkHAXM1ZCDWZT8o/Q7mPvx1
         8AqBxvYse9Zn7nzYAaYgIZs2PAA8lgsM5rbVNcp5G7TF3UtjfNbGsdV+KpFm7mr7a3TG
         uvQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0qE3F5TNORKcR02tCeXZpk6ntKvOqotb7zOZqkxMH42ODwoNBlx4de1oD8Wu1AlYOu/jfWC7rql/wegxj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9z/281McgDdZPlnb1yj3vYDAFDeJTqhJf7vnaRaxUCcCXrQWK
	LGm+xWdn1R8/JJi0yoxTniP8aK35hRATLK+F4kyEzgzTYN0yY7LXuak93OkAFNwe6KJl1Y3bm0n
	nR2ncYJI=
X-Gm-Gg: ASbGncvJCKzzycRzrL45iGyYjTBgOY7D26gm75txw+XKNWbwpCQx/kncqsWvh4efZaL
	NE1dDSBe2BKSG2eq0AZTACNVXboutqhuTjRp+jl+TMpeqYhBo9PUIIdG2/5t7GuFw7GkshKMdqW
	ThIXROTvq0GTjB93vMkEJBjqkais1Stp71T+RtZAFUhk3pl3shXjZ+6k5Ct6Hva4kQxbFvchwrW
	mQAw9VariVp3BcDGmnB4c7l3zVfykvuiG3Jks6bZnnedSHPMskC01aMjNjXZwmD/21COQ/hgRMZ
	l+RckvX2TcOHzH1ayJFFxZKhTeK4DHTzpOGOwt9NY8hbo2csX56fVsgrvyspLqOINuZRGerKNsx
	8HGAD6l2KFLHnkNpW7PIQk3ZChIYj6fHXOsr7/h+C285lXRrLSU22OCJuTRT6yCsCu1ITVCzI+d
	apWH+l1u6a9VSCPRX0pGLJ
X-Google-Smtp-Source: AGHT+IHcfRKzw1FFrV/c0HUU4DGLPejHdll1DTVq2+3DY9AxO0YUYoDwbfnntGR9wG2diCbVXa8GPw==
X-Received: by 2002:a05:6402:510e:b0:634:7224:c6b5 with SMTP id 4fb4d7f45d1cf-639d5c593d5mr7838438a12.28.1760030973178;
        Thu, 09 Oct 2025 10:29:33 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c321341sm232004a12.38.2025.10.09.10.29.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 10:29:31 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so2001838a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 10:29:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc8QZYWmTKGAzYW56sZdGIwuvvv3mZxu7Xv92DzSlOi2FYNDCip3Md7H66KCL2lBpeRXwZfJw3S2LjddNh@vger.kernel.org
X-Received: by 2002:a17:907:3f21:b0:b40:51c0:b2d2 with SMTP id
 a640c23a62f3a-b50ace27589mr886846266b.63.1760030970199; Thu, 09 Oct 2025
 10:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp>
 <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
 <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com> <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
In-Reply-To: <nhrb37zzltn5hi3h5phwprtmkj2z2wb4gchvp725bwcnsgvjyf@eohezc2gouwr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Oct 2025 10:29:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
X-Gm-Features: AS18NWAte-czLoaMmDi6pQnXuRVuv098dMpIVY51gdMJ4ypv7e8n0y7lkdhlF-w
Message-ID: <CAHk-=wi1rrcijcD0i7V7JD6bLL-yKHUX-hcxtLx=BUd34phdug@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c634ff0640bd2493"

--000000000000c634ff0640bd2493
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 09:22, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> Objtool is not happy about calling random stuff within UACCESS. I
> ignored it for now.

Yeah, that needs to be done inside the other stuff - including, very
much, the folio lookup.

> I am not sure if I use user_access_begin()/_end() correctly. Let me know
> if I misunderstood or misimplemented your idea.

Close. Except I'd have gotten rid of the iov stuff by making the inner
helper just get a 'void __user *' pointer and a length, and then
updating the iov state outside that helper.

> This patch brings 4k reads from 512k files to ~60GiB/s. Making the
> buffer 4k, brings it ~95GiB/s (baseline is 100GiB/s).

Note that right now, 'unsafe_copy_to_user()' is a horrible thing. It's
almost entirely unoptimized, see the hacky unsafe_copy_loop
implementation in <asm/uaccess.h>.

Because before this code, it was only used for readdir() to copy
individual filenames, I think.

Anyway, I'd have organized things a bit differently. Incremental
UNTESTED patch attached.

objtool still complains about SMAP issues, because
memcpy_from_file_folio() ends up resulting in a external call to
memcpy. Not great.

I don't love how complicated this all got, and even with your bigger
buffer it's slower than the baseline/

So honestly I'd be inclined to go back to "just deal with the
trivially small reads", and scratch this extra complexity.

       Linus

--000000000000c634ff0640bd2493
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mgjozf8j0>
X-Attachment-Id: f_mgjozf8j0

IG1tL2ZpbGVtYXAuYyB8IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyks
IDI4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL2ZpbGVtYXAuYyBiL21tL2ZpbGVtYXAu
YwppbmRleCAxM2M1ZGU5NGM4ODQuLjY0ZGVmMGRkM2I5NyAxMDA2NDQKLS0tIGEvbW0vZmlsZW1h
cC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAtMjY5Nyw3ICsyNjk3LDQxIEBAIHN0YXRpYyB2b2lk
IGZpbGVtYXBfZW5kX2Ryb3BiZWhpbmRfcmVhZChzdHJ1Y3QgZm9saW8gKmZvbGlvKQogCX0KIH0K
IAotc3RhdGljIGJvb2wgZmlsZW1hcF9yZWFkX2Zhc3Qoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1
Y3QgaW92X2l0ZXIgKml0ZXIsCitzdGF0aWMgc2l6ZV90IGlubmVyX3JlYWRfbG9vcChzdHJ1Y3Qg
a2lvY2IgKmlvY2IsIHN0cnVjdCBmb2xpbyAqZm9saW8sCisJCQkJdm9pZCBfX3VzZXIgKmRzdCwg
c2l6ZV90IGRzdF9zaXplLAorCQkJCWNoYXIgKmJ1ZmZlciwgc2l6ZV90IGJ1ZmZlcl9zaXplLAor
CQkJCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCB1bnNpZ25lZCBpbnQgc2VxKQorewor
CXNpemVfdCByZWFkID0gMDsKKworCWlmIChjYW5fZG9fbWFza2VkX3VzZXJfYWNjZXNzKCkpCisJ
CWRzdCA9IG1hc2tlZF91c2VyX2FjY2Vzc19iZWdpbihkc3QpOworCWVsc2UgaWYgKCF1c2VyX2Fj
Y2Vzc19iZWdpbihkc3QsIGRzdF9zaXplKSkKKwkJcmV0dXJuIDA7CisKKwlkbyB7CisJCXNpemVf
dCB0b19yZWFkID0gbWluKGRzdF9zaXplLCBidWZmZXJfc2l6ZSk7CisKKwkJdG9fcmVhZCA9IG1l
bWNweV9mcm9tX2ZpbGVfZm9saW8oYnVmZmVyLCBmb2xpbywgaW9jYi0+a2lfcG9zLCB0b19yZWFk
KTsKKworCQkvKiBHaXZlIHVwIGFuZCBnbyB0byBzbG93IHBhdGggaWYgcmFjZWQgd2l0aCBwYWdl
X2NhY2hlX2RlbGV0ZSgpICovCisJCWlmIChyZWFkX3NlcWNvdW50X3JldHJ5KCZtYXBwaW5nLT5p
X3BhZ2VzX2RlbGV0ZV9zZXFjbnQsIHNlcSkpCisJCQlicmVhazsKKworCQl1bnNhZmVfY29weV90
b191c2VyKGRzdCwgYnVmZmVyLCB0b19yZWFkLCBFZmF1bHQpOworCisJCWRzdCArPSByZWFkOwor
CQlkc3Rfc2l6ZSAtPSByZWFkOworCisJCWlvY2ItPmtpX3BvcyArPSByZWFkOworCX0gd2hpbGUg
KGRzdF9zaXplICYmIGlvY2ItPmtpX3BvcyAlIGZvbGlvX3NpemUoZm9saW8pKTsKKworRWZhdWx0
OgorCXVzZXJfYWNjZXNzX2VuZCgpOworCXJldHVybiByZWFkOworfQorCitzdGF0aWMgYm9vbCBu
b2lubGluZSBmaWxlbWFwX3JlYWRfZmFzdChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3Zf
aXRlciAqaXRlciwKIAkJCSAgICAgIGNoYXIgKmJ1ZmZlciwgc2l6ZV90IGJ1ZmZlcl9zaXplLAog
CQkJICAgICAgc3NpemVfdCAqYWxyZWFkeV9yZWFkKQogewpAQCAtMjcxOSwxNCArMjc1MywxMiBA
QCBzdGF0aWMgYm9vbCBmaWxlbWFwX3JlYWRfZmFzdChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVj
dCBpb3ZfaXRlciAqaXRlciwKIAlpZiAoIXJhd19zZXFjb3VudF90cnlfYmVnaW4oJm1hcHBpbmct
PmlfcGFnZXNfZGVsZXRlX3NlcWNudCwgc2VxKSkKIAkJcmV0dXJuIGZhbHNlOwogCi0JaWYgKCF1
c2VyX2FjY2Vzc19iZWdpbihpdGVyLT51YnVmICsgaXRlci0+aW92X29mZnNldCwgaXRlci0+Y291
bnQpKQotCQlyZXR1cm4gZmFsc2U7Ci0KIAlyY3VfcmVhZF9sb2NrKCk7CiAJcGFnZWZhdWx0X2Rp
c2FibGUoKTsKIAogCWRvIHsKIAkJc2l6ZV90IHRvX3JlYWQsIHJlYWQ7CisJCXZvaWQgX191c2Vy
ICpkc3Q7CiAJCVhBX1NUQVRFKHhhcywgJm1hcHBpbmctPmlfcGFnZXMsIGlvY2ItPmtpX3BvcyA+
PiBQQUdFX1NISUZUKTsKIAogCQl4YXNfcmVzZXQoJnhhcyk7CkBAIC0yNzUwLDM0ICsyNzgyLDI3
IEBAIHN0YXRpYyBib29sIGZpbGVtYXBfcmVhZF9mYXN0KHN0cnVjdCBraW9jYiAqaW9jYiwgc3Ry
dWN0IGlvdl9pdGVyICppdGVyLAogCQkvKiBpX3NpemUgY2hlY2sgbXVzdCBiZSBhZnRlciBmb2xp
b190ZXN0X3VwdG9kYXRlKCkgKi8KIAkJZmlsZV9zaXplID0gaV9zaXplX3JlYWQobWFwcGluZy0+
aG9zdCk7CiAKLQkJZG8gewotCQkJaWYgKHVubGlrZWx5KGlvY2ItPmtpX3BvcyA+PSBmaWxlX3Np
emUpKQotCQkJCWdvdG8gb3V0OworCQlpZiAodW5saWtlbHkoaW9jYi0+a2lfcG9zID49IGZpbGVf
c2l6ZSkpCisJCQlicmVhazsKKwkJZmlsZV9zaXplIC09IGlvY2ItPmtpX3BvczsKKwkJdG9fcmVh
ZCA9IGlvdl9pdGVyX2NvdW50KGl0ZXIpOworCQlpZiAodG9fcmVhZCA+IGZpbGVfc2l6ZSkKKwkJ
CXRvX3JlYWQgPSBmaWxlX3NpemU7CiAKLQkJCXRvX3JlYWQgPSBtaW4oaW92X2l0ZXJfY291bnQo
aXRlciksIGJ1ZmZlcl9zaXplKTsKLQkJCWlmICh0b19yZWFkID4gZmlsZV9zaXplIC0gaW9jYi0+
a2lfcG9zKQotCQkJCXRvX3JlYWQgPSBmaWxlX3NpemUgLSBpb2NiLT5raV9wb3M7Ci0KLQkJCXJl
YWQgPSBtZW1jcHlfZnJvbV9maWxlX2ZvbGlvKGJ1ZmZlciwgZm9saW8sIGlvY2ItPmtpX3Bvcywg
dG9fcmVhZCk7Ci0KLQkJCS8qIEdpdmUgdXAgYW5kIGdvIHRvIHNsb3cgcGF0aCBpZiByYWNlZCB3
aXRoIHBhZ2VfY2FjaGVfZGVsZXRlKCkgKi8KLQkJCWlmIChyZWFkX3NlcWNvdW50X3JldHJ5KCZt
YXBwaW5nLT5pX3BhZ2VzX2RlbGV0ZV9zZXFjbnQsIHNlcSkpCi0JCQkJZ290byBvdXQ7Ci0KLQkJ
CXVuc2FmZV9jb3B5X3RvX3VzZXIoaXRlci0+dWJ1ZiArIGl0ZXItPmlvdl9vZmZzZXQsIGJ1ZmZl
ciwKLQkJCQkJICAgIHJlYWQsIG91dCk7Ci0KLQkJCWl0ZXItPmlvdl9vZmZzZXQgKz0gcmVhZDsK
LQkJCWl0ZXItPmNvdW50IC09IHJlYWQ7Ci0JCQkqYWxyZWFkeV9yZWFkICs9IHJlYWQ7Ci0JCQlp
b2NiLT5raV9wb3MgKz0gcmVhZDsKLQkJCWxhc3RfcG9zID0gaW9jYi0+a2lfcG9zOwotCQl9IHdo
aWxlIChpb3ZfaXRlcl9jb3VudChpdGVyKSAmJiBpb2NiLT5raV9wb3MgJSBmb2xpb19zaXplKGZv
bGlvKSk7CisJCWRzdCA9IGl0ZXItPnVidWYgKyBpdGVyLT5pb3Zfb2Zmc2V0OworCQlyZWFkID0g
aW5uZXJfcmVhZF9sb29wKGlvY2IsIGZvbGlvLAorCQkJZHN0LCB0b19yZWFkLCBidWZmZXIsIGJ1
ZmZlcl9zaXplLAorCQkJbWFwcGluZywgc2VxKTsKKwkJaWYgKCFyZWFkKQorCQkJYnJlYWs7CisJ
CWl0ZXItPmlvdl9vZmZzZXQgKz0gcmVhZDsKKwkJaXRlci0+Y291bnQgLT0gcmVhZDsKKwkJKmFs
cmVhZHlfcmVhZCArPSByZWFkOworCQlsYXN0X3BvcyA9IGlvY2ItPmtpX3BvczsKIAl9IHdoaWxl
IChpb3ZfaXRlcl9jb3VudChpdGVyKSk7Ci1vdXQ6CisKIAlwYWdlZmF1bHRfZW5hYmxlKCk7CiAJ
cmN1X3JlYWRfdW5sb2NrKCk7Ci0JdXNlcl9hY2Nlc3NfZW5kKCk7CiAKIAlmaWxlX2FjY2Vzc2Vk
KGlvY2ItPmtpX2ZpbHApOwogCXJhLT5wcmV2X3BvcyA9IGxhc3RfcG9zOwo=
--000000000000c634ff0640bd2493--

