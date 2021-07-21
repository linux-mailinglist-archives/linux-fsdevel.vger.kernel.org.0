Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC933D1708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhGUSqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbhGUSqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:46:15 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616EEC061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 12:26:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u14so4470154ljh.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sDQIsNrlW4/7KiDM2DrNKpvI0kLVfuko2l2eubfBvQ=;
        b=cz+Yym+fp4gdemr2ADcB3IUUobejnaEe8M1aadDtpYGC79aJSDdBdpkp+toJBuz6Ug
         xNAHIe1Ee+XlbRRevJOputY88NGZm0RTF+YaTX3jKt6kHnOvpCMiofgIHbABcuBLeg7M
         5EeQD0xon/UUwnnK8T/f+pY5s3Xa13Ex6ug+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sDQIsNrlW4/7KiDM2DrNKpvI0kLVfuko2l2eubfBvQ=;
        b=Mncn+MQ2CGA+F7z0tn1bAa2pEbKKWpyDUcNqoU7hPbxo+bvRl9oPSWnlzAnraVd0v6
         nBroBGxUrIO4yP3t2HU7X0EvaZrij0XFYOWOQ2uZxYk9y+PM/uobht8EqYQ+tr8vPSr3
         M+q7zlRtZXYAbosFqX8BDLPcgjOX+rYOCiJ26priDe38W4ZZNcdQAUMyed4a09z3KKKi
         eHTlMMfdUUf1Wdn29VL86VdXWtV3wfGUIcqrnAea2JqgjbcvNkALs5BTH0vjqtm8Wnut
         GVU0/H/KCbGPNvzCAE/vH37CKlKQkF56finyXKUsmGC0gfCtgGPkuHpjFYyOu4AFC1X0
         Wzcg==
X-Gm-Message-State: AOAM532xpI4LA8upy7bPf5S6oEDRqphk1dWJQbtWols9gUx9MvRRbGji
        c3x+sDd2W9UKiuCw7WFm6CZXp9+66bxVCBA+
X-Google-Smtp-Source: ABdhPJy3Dpm+aOVr3GKxVxX9CHwiVLNJXhjd015PExki0TRCh4EG+7ePwwwFwNk3x2KwCYila/cjig==
X-Received: by 2002:a2e:3310:: with SMTP id d16mr32950107ljc.199.1626895608598;
        Wed, 21 Jul 2021 12:26:48 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j3sm1082571lfe.133.2021.07.21.12.26.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 12:26:47 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id x24so690264ljm.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 12:26:47 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr15953928ljg.465.1626895606811;
 Wed, 21 Jul 2021 12:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com> <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 12:26:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
Message-ID: <CAHk-=wgr3JSoasv3Kyzc0u-L36oAr=hzY9oUrCxaszWaxgLW0A@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: multipart/mixed; boundary="000000000000bb410005c7a726dd"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000bb410005c7a726dd
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 21, 2021 at 11:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I can do the mutual alignment too, but I'd actually prefer to do it as
> a separate patch, for when there are numbers for that.
>
> And I wouldn't do it as a byte-by-byte case, because that's just stupid.

Here's that "try to align one of the pointers in order to avoid the
lots-of-unaligned case" patch.

It's not quite as simple, and the generated assembly isn't quite as
obvious. But it still generates code that looks good, it's just that
the code to align the first pointer ends up being a bit harder to
read.

And since it's a bit less obvious, the "this is probably buggy because
I didn't actually _test_ it" warning holds even more. But you can see
how much simpler the code still is than the horrendous glibc mess is.

And I removed the "CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS" checking,
because now it should be at least *somewhat* reasonable even on
machines that have a complicated "get_unaligned()".

But maybe I should have kept it. Only testing will tell.

Again: UNTESTED GARBAGE ATTACHED. Be careful. But it migth work, and
ti generates something that looks superficially reasonable.

Gcc again:

        memcmp:
                cmpq    $7, %rdx
                jbe     .L56
                movq    (%rsi), %rax
                cmpq    %rax, (%rdi)
                je      .L61
        .L55:
                xorl    %ecx, %ecx
                jmp     .L58
        .L62:
                addq    $1, %rcx
                cmpq    %rcx, %rdx
                je      .L51
        .L58:
                movzbl  (%rdi,%rcx), %eax
                movzbl  (%rsi,%rcx), %r8d
                subl    %r8d, %eax
                je      .L62
        .L51:
                ret
        .L56:
                testq   %rdx, %rdx
                jne     .L55
                xorl    %eax, %eax
                ret
        .L61:
                movq    %rdi, %rcx
                movl    $8, %eax
                andl    $7, %ecx
                subq    %rcx, %rax
                leaq    -8(%rcx,%rdx), %rdx
                addq    %rax, %rdi
                addq    %rax, %rsi
                cmpq    $7, %rdx
                ja      .L57
                jmp     .L56
        .L63:
                subq    $8, %rdx
                addq    $8, %rdi
                addq    $8, %rsi
                cmpq    $7, %rdx
                jbe     .L56
        .L57:
                movq    (%rsi), %rax
                cmpq    %rax, (%rdi)
                je      .L63
                jmp     .L55

but clang is similar (except clang isn't as eager to move basic blocks
around, so it's visually very different).

Note no spills, no odd shifts for unaligned accesses, no garbage.

Again: untested, so consider this a starting point rather than
anything good and proper.

                   Linus

--000000000000bb410005c7a726dd
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_krdvlhyk0>
X-Attachment-Id: f_krdvlhyk0

IGxpYi9zdHJpbmcuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpYi9zdHJpbmcuYyBiL2xpYi9z
dHJpbmcuYwppbmRleCA3N2JkMGIxZDMyOTYuLjNlYjM5MGZjNGY3MyAxMDA2NDQKLS0tIGEvbGli
L3N0cmluZy5jCisrKyBiL2xpYi9zdHJpbmcuYwpAQCAtMjksNiArMjksNyBAQAogI2luY2x1ZGUg
PGxpbnV4L2Vycm5vLmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogCisjaW5jbHVkZSA8YXNt
L3VuYWxpZ25lZC5oPgogI2luY2x1ZGUgPGFzbS9ieXRlb3JkZXIuaD4KICNpbmNsdWRlIDxhc20v
d29yZC1hdC1hLXRpbWUuaD4KICNpbmNsdWRlIDxhc20vcGFnZS5oPgpAQCAtOTM1LDYgKzkzNiwz
MSBAQCBfX3Zpc2libGUgaW50IG1lbWNtcChjb25zdCB2b2lkICpjcywgY29uc3Qgdm9pZCAqY3Qs
IHNpemVfdCBjb3VudCkKIAljb25zdCB1bnNpZ25lZCBjaGFyICpzdTEsICpzdTI7CiAJaW50IHJl
cyA9IDA7CiAKKwlpZiAoY291bnQgPj0gc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKSB7CisJCWNvbnN0
IHVuc2lnbmVkIGxvbmcgKnUxID0gY3M7CisJCWNvbnN0IHVuc2lnbmVkIGxvbmcgKnUyID0gY3Q7
CisJCXVuc2lnbmVkIGxvbmcgb2Zmc2V0OworCisJCWlmIChnZXRfdW5hbGlnbmVkKHUxKSAhPSBn
ZXRfdW5hbGlnbmVkKHUyKSkKKwkJCWdvdG8gYnl0ZXdpc2U7CisKKwkJLyogQWxpZ24gJ3UxJyB1
cCAqLworCQlvZmZzZXQgPSBzaXplb2YoKnUxKSAtICgoc2l6ZW9mKCp1MSktMSkgJiAodW5zaWdu
ZWQgbG9uZykodTEpKTsKKwkJdTEgPSBjcyArIG9mZnNldDsKKwkJdTIgPSBjdCArIG9mZnNldDsK
KwkJY291bnQgLT0gb2Zmc2V0OworCisJCXdoaWxlIChjb3VudCA+PSBzaXplb2YodW5zaWduZWQg
bG9uZykpIHsKKwkJCWlmICgqdTEgIT0gZ2V0X3VuYWxpZ25lZCh1MikpCisJCQkJYnJlYWs7CisJ
CQl1MSsrOworCQkJdTIrKzsKKwkJCWNvdW50IC09IHNpemVvZih1bnNpZ25lZCBsb25nKTsKKwkJ
fQorCQljcyA9IHUxOworCQljdCA9IHUyOworCX0KK2J5dGV3aXNlOgogCWZvciAoc3UxID0gY3Ms
IHN1MiA9IGN0OyAwIDwgY291bnQ7ICsrc3UxLCArK3N1MiwgY291bnQtLSkKIAkJaWYgKChyZXMg
PSAqc3UxIC0gKnN1MikgIT0gMCkKIAkJCWJyZWFrOwo=
--000000000000bb410005c7a726dd--
