Return-Path: <linux-fsdevel+bounces-19108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D48C01D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510C8281EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB3212A17B;
	Wed,  8 May 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8lpRhWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E5128396
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185166; cv=none; b=cy8UeHKXbEgw4llky13x0F7sQJuH0/kM7Pb/wRmm9w1/yRpnUX4foUi7oSgDCkwuK8Qr6xnM1v77Y+Xz+jq+2b8iqR7LBRI773+A5lC11BT331d9tp+0LUc+KVGd4FzN/BJWnTMk/X+qPQJkjJnNxA7axe/XAPAHVt+KGZstoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185166; c=relaxed/simple;
	bh=EBgZslqy6XCFdm2svCR8wdSgwC1c5tdTUgjKXU1N4nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx/68Rj57/GPF6WN9ScAt5sVGBUpgZpMcOvVqHEp+F/5uW4MnOCOfyJC3e8UZJCapIoq/WgE/cfg6gC0HX+SuXcA6DtK5u1AF15NJ5ILszgn3gx7psO4EWyYtqDfctm8/RNGfVAx1NKA06nId4Owbob4AHkTmBgkkwzS7AoTzcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S8lpRhWx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59cdd185b9so190583966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715185162; x=1715789962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRnWniI6weHLAZe+jcS6e3kntzKq8xydvJSod9mqGMY=;
        b=S8lpRhWxSbC2lPt9deECHsu3p+I3K+45f3bb40YBkCrupQMsboscLRFdzvWqhaHFtU
         FnzVbbOhcNlu/NKCeN8G/s41Lcn+mz+QGXBI5GCSmqa6ym2cHX1Toxyg0T807+UCFv8d
         +LVVNQHGHtzloL6RSRQ0u074eghzOJEm6L7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185162; x=1715789962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRnWniI6weHLAZe+jcS6e3kntzKq8xydvJSod9mqGMY=;
        b=XW29GSL6CESxMD4FIMTroFUpaUbKKfXvSPLWTNyIVvaSGP4GgIWzgBx4Qn+CVlhey1
         6b6z5G/Qs+X40/lFXuluudyKLegNyUNvgCV8LnnbhSshgilXlj6Hs431HWqKoyUxa0w5
         a39PdPF3nXpcI7Kxf6E2eAmLDzD5P38NPWt6mdszhfAsamfKcQg3GH12pmVcDJfokMYa
         ZgaB4Z9nUunl9XfQQAq+WTv1/it0i1dgs6K0nt3BuQwe1qSXMeY4bJUjl6yrYRi2QqPP
         Wac7hvGiQJFPB9r8pi5Uqgwc+Eui85DVpSx7760yRpSUQwX9i5GhuG/mG8kaF8s6SsF5
         RCCg==
X-Forwarded-Encrypted: i=1; AJvYcCUew5x68am6Tstu1HpC388bZ2SR0WXpaPkWWs2FeTN7cNy19kx6VcsNKWhpAKafU9Q9TOW2y9JeJYSUTd6m2UdGE7s2Ly2FeCGYI714cA==
X-Gm-Message-State: AOJu0Yw2HEaHg2m0Kxror9qS06gtNy/0Bf2LEyrP7aSGRFEr7cf324t2
	33QCh35NLJv/wToBUzYgOzOR/J3Zh27rGbMHZOH3UF3Vt5hQtwGX07XYqYhfNKnHcg2XeokUwo6
	i0qsFog==
X-Google-Smtp-Source: AGHT+IG9IYk9YN6OYsHSHkllQgMFByQpN0yfiliDVTfZuXSTal+jBom4MoJNmPXZdX4Z/bbNwWBqww==
X-Received: by 2002:a17:906:c081:b0:a5a:c35:3a2 with SMTP id a640c23a62f3a-a5a1177fe36mr7981966b.25.1715185162464;
        Wed, 08 May 2024 09:19:22 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id rn9-20020a170906d92900b00a59a229564fsm5889822ejb.108.2024.05.08.09.19.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 09:19:21 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59ce1e8609so186744866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 09:19:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuLGMzPEF0qWyedjfbVeZIqOdm+yoTHyerxofWMYG73+L8ZPvJV0WjXeGSwkp50JVP3zdhOBmHZ21l5FPPHOHzC0nJc2o7BcX2UUOFOw==
X-Received: by 2002:a17:906:1c10:b0:a59:9c2f:c7d4 with SMTP id
 a640c23a62f3a-a5a1167be68mr9921366b.19.1715185161053; Wed, 08 May 2024
 09:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
 <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
 <b1728d20-047c-4e28-8458-bf3206a1c97c@gmail.com> <ZjoKX4nmrRdevyxm@phenom.ffwll.local>
 <CAHk-=wgh5S-7sCCqXBxGcXHZDhe4U8cuaXpVTjtXLej2si2f3g@mail.gmail.com>
 <CAKMK7uGzhAHHkWj0N33NB3OXMFtNHv7=h=P-bdtYkw=Ja9kwHw@mail.gmail.com> <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
In-Reply-To: <CAHk-=whFyOn4vp7+++MTOd1Y3wgVFxRoVdSuPmN1_b6q_Jjkxg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 09:19:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
Message-ID: <CAHk-=wixO-fmQYgbGic-BQVUd9RQhwGsF4bGk8ufWDKnRS1v_A@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH] epoll: try to be a _bit_ better about
 file lifetimes
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Simon Ser <contact@emersion.fr>, Pekka Paalanen <pekka.paalanen@collabora.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, 
	axboe@kernel.dk, christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000003fddda0617f3aa7b"

--0000000000003fddda0617f3aa7b
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 12:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That example thing shows that we shouldn't make it a FISAME ioctl - we
> should make it a fcntl() instead, and it would just be a companion to
> F_DUPFD.
>
> Doesn't that strike everybody as a *much* cleaner interface? I think
> F_ISDUP would work very naturally indeed with F_DUPFD.

So since we already have two versions of F_DUPFD (the other being
F_DUPFD_CLOEXEC) I decided that the best thing to do is to just extend
on that existing naming pattern, and called it F_DUPFD_QUERY instead.

I'm not married to the name, so if somebody hates it, feel free to
argue otherwise.

But with that, the suggested patch would end up looking something like
the attached (I also re-ordered the existing "F_LINUX_SPECIFIC_BASE"
users, since one of them was out of numerical order).

This really feels like a very natural thing, and yes, the 'same_fd()'
function in systemd that Christian also pointed at could use this very
naturally.

Also note that I obviously haven't tested this. Because obviously this
is trivially correct and cannot possibly have any bugs. Right? RIGHT?

And yes, I did check - despite the odd jump in numbers, we've never
had anything between F_NOTIFY (+2) and F_CANCELLK (+5).

We added F_SETLEASE (+0) , F_GETLEASE (+1) and F_NOTIFY (+2) in
2.4.0-test9 (roughly October 2000, I didn't dig deeper).

And then back in 2007 we suddenly jumped to F_CANCELLK (+5) in commit
9b9d2ab4154a ("locks: add lock cancel command"). I don't know why 3/4
were shunned.

After that we had 22d2b35b200f ("F_DUPFD_CLOEXEC implementation") add
F_DUPFD_CLOEXEC (+6).

I'd have loved to put F_DUPFD_QUERY next to it, but +5 and +7 are both used.

                Linus

--0000000000003fddda0617f3aa7b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lvy090o10>
X-Attachment-Id: f_lvy090o10

IGZzL2ZjbnRsLmMgICAgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysK
IGluY2x1ZGUvdWFwaS9saW51eC9mY250bC5oIHwgMTQgKysrKysrKystLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9m
cy9mY250bC5jIGIvZnMvZmNudGwuYwppbmRleCA1NGNjODVkMzMzOGUuLjFkZGI2M2Y3MDQ0NSAx
MDA2NDQKLS0tIGEvZnMvZmNudGwuYworKysgYi9mcy9mY250bC5jCkBAIC0zMjcsNiArMzI3LDI1
IEBAIHN0YXRpYyBsb25nIGZjbnRsX3NldF9yd19oaW50KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNp
Z25lZCBpbnQgY21kLAogCXJldHVybiAwOwogfQogCisvKgorICogSXMgdGhlIGZpbGUgZGVzY3Jp
cHRvciBhIGR1cCBvZiB0aGUgZmlsZT8KKyAqLworc3RhdGljIGxvbmcgZl9kdXBmZF9xdWVyeShp
bnQgZmQsIHN0cnVjdCBmaWxlICpmaWxwKQoreworCXN0cnVjdCBmZCBmID0gZmRnZXRfcmF3KGZk
KTsKKworCS8qCisJICogV2UgY2FuIGRvIHRoZSAnZmRwdXQoKScgaW1tZWRpYXRlbHksIGFzIHRo
ZSBvbmx5IHRoaW5nIHRoYXQKKwkgKiBtYXR0ZXJzIGlzIHRoZSBwb2ludGVyIHZhbHVlIHdoaWNo
IGlzbid0IGNoYW5nZWQgYnkgdGhlIGZkcHV0LgorCSAqCisJICogVGVjaG5pY2FsbHkgd2UgZGlk
bid0IG5lZWQgYSByZWYgYXQgYWxsLCBhbmQgJ2ZkZ2V0KCknIHdhcworCSAqIG92ZXJraWxsLCBi
dXQgZ2l2ZW4gb3VyIGxvY2tsZXNzIGZpbGUgcG9pbnRlciBsb29rdXAsIHRoZQorCSAqIGFsdGVy
bmF0aXZlcyBhcmUgY29tcGxpY2F0ZWQuCisJICovCisJZmRwdXQoZik7CisJcmV0dXJuIGYuZmls
ZSA9PSBmaWxwOworfQorCiBzdGF0aWMgbG9uZyBkb19mY250bChpbnQgZmQsIHVuc2lnbmVkIGlu
dCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnLAogCQlzdHJ1Y3QgZmlsZSAqZmlscCkKIHsKQEAgLTM0
Miw2ICszNjEsOSBAQCBzdGF0aWMgbG9uZyBkb19mY250bChpbnQgZmQsIHVuc2lnbmVkIGludCBj
bWQsIHVuc2lnbmVkIGxvbmcgYXJnLAogCWNhc2UgRl9EVVBGRF9DTE9FWEVDOgogCQllcnIgPSBm
X2R1cGZkKGFyZ2ksIGZpbHAsIE9fQ0xPRVhFQyk7CiAJCWJyZWFrOworCWNhc2UgRl9EVVBGRF9R
VUVSWToKKwkJZXJyID0gZl9kdXBmZF9xdWVyeShhcmdpLCBmaWxwKTsKKwkJYnJlYWs7CiAJY2Fz
ZSBGX0dFVEZEOgogCQllcnIgPSBnZXRfY2xvc2Vfb25fZXhlYyhmZCkgPyBGRF9DTE9FWEVDIDog
MDsKIAkJYnJlYWs7CkBAIC00NDYsNiArNDY4LDcgQEAgc3RhdGljIGludCBjaGVja19mY250bF9j
bWQodW5zaWduZWQgY21kKQogCXN3aXRjaCAoY21kKSB7CiAJY2FzZSBGX0RVUEZEOgogCWNhc2Ug
Rl9EVVBGRF9DTE9FWEVDOgorCWNhc2UgRl9EVVBGRF9RVUVSWToKIAljYXNlIEZfR0VURkQ6CiAJ
Y2FzZSBGX1NFVEZEOgogCWNhc2UgRl9HRVRGTDoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC9mY250bC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2ZjbnRsLmgKaW5kZXggMjgyZTkwYWVi
MTYzLi5jMGJjYzE4NWZhNDggMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9mY250bC5o
CisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9mY250bC5oCkBAIC04LDYgKzgsMTQgQEAKICNkZWZp
bmUgRl9TRVRMRUFTRQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNFICsgMCkKICNkZWZpbmUgRl9HRVRM
RUFTRQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNFICsgMSkKIAorLyoKKyAqIFJlcXVlc3Qgbm9maWNh
dGlvbnMgb24gYSBkaXJlY3RvcnkuCisgKiBTZWUgYmVsb3cgZm9yIGV2ZW50cyB0aGF0IG1heSBi
ZSBub3RpZmllZC4KKyAqLworI2RlZmluZSBGX05PVElGWQkoRl9MSU5VWF9TUEVDSUZJQ19CQVNF
ICsgMikKKworI2RlZmluZSBGX0RVUEZEX1FVRVJZCShGX0xJTlVYX1NQRUNJRklDX0JBU0UgKyAz
KQorCiAvKgogICogQ2FuY2VsIGEgYmxvY2tpbmcgcG9zaXggbG9jazsgaW50ZXJuYWwgdXNlIG9u
bHkgdW50aWwgd2UgZXhwb3NlIGFuCiAgKiBhc3luY2hyb25vdXMgbG9jayBhcGkgdG8gdXNlcnNw
YWNlOgpAQCAtMTcsMTIgKzI1LDYgQEAKIC8qIENyZWF0ZSBhIGZpbGUgZGVzY3JpcHRvciB3aXRo
IEZEX0NMT0VYRUMgc2V0LiAqLwogI2RlZmluZSBGX0RVUEZEX0NMT0VYRUMJKEZfTElOVVhfU1BF
Q0lGSUNfQkFTRSArIDYpCiAKLS8qCi0gKiBSZXF1ZXN0IG5vZmljYXRpb25zIG9uIGEgZGlyZWN0
b3J5LgotICogU2VlIGJlbG93IGZvciBldmVudHMgdGhhdCBtYXkgYmUgbm90aWZpZWQuCi0gKi8K
LSNkZWZpbmUgRl9OT1RJRlkJKEZfTElOVVhfU1BFQ0lGSUNfQkFTRSsyKQotCiAvKgogICogU2V0
IGFuZCBnZXQgb2YgcGlwZSBwYWdlIHNpemUgYXJyYXkKICAqLwo=
--0000000000003fddda0617f3aa7b--

