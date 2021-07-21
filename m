Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534233D1699
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhGUSFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbhGUSFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:05:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA62C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:45:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y25so3469845ljy.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8y6QbjABYVdCwCo9bCH3uRUzlEcjRbA7x2BUjVyc0ws=;
        b=hBUMMtm8juMCJx4jllyZahvGiCtlfjKyjc1FvS1TrtIMoXehtYE8RQBhzutuMuUXBw
         +ZzhHb+Uy6icnIIwEZFOuLpqmC7VLRKYfCK1VRcuzDI5JuppC+jaTAWvJurBuPnMtXuA
         SFtKdmhSLtUp7cgKEZPGOTovb4IS5Dqjf8u7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8y6QbjABYVdCwCo9bCH3uRUzlEcjRbA7x2BUjVyc0ws=;
        b=WS6iNV1Yb0xi3C9vFtJZO8t4VRAG94KO1Z6nITs1Lb3BEKDBI5TDheCsvUIcOLYarm
         btNrXeLpxrQix2dXqxFiE7O2qV2Y/b34t6RDi1cC3atm1QaXvAZFeENmndvgQBTedCNU
         MDjRGHBqtrLLf0VmIMMw5xl8o091RY0QsMMh4+LcfmOm+g1UtjErj94nDjVnRT8zXdMn
         Su7PvmCQOye0Q+UDaSB+ZFGcm4KjplYlyrwHUk8DE++CZhHlU4m8iNm3tiRB7PJB1hWb
         oH/ZRqzzbSfFlinnFvwhPnzIcuP1KyrR1NSkRemUmShs3fvWV8diAHN1UJTGMVtLlPSv
         3pug==
X-Gm-Message-State: AOAM530FHpwR0TeD71Aeeektf6HyNv9awJfOP991y5fYEcqa0jL+ajhV
        6/xiotE+QBEsU8uPMXcOGAoLTiKG19lV0oBh
X-Google-Smtp-Source: ABdhPJwQiGyG1HGq/uw0vtmbHCpuXH5o5admdiT26SQomfRHspF50viYTHBxBNmqt1Xx9QbEDgGR4w==
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr32113436ljj.482.1626893153570;
        Wed, 21 Jul 2021 11:45:53 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y20sm1954579lfg.70.2021.07.21.11.45.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:45:53 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id u13so4608793lfs.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:45:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr25045987lfa.421.1626893152674;
 Wed, 21 Jul 2021 11:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
In-Reply-To: <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 11:45:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
Message-ID: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: multipart/mixed; boundary="000000000000741c3905c7a694cd"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000741c3905c7a694cd
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 21, 2021 at 11:17 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> I find it somewhat arbitrary that we choose to align the 2nd pointer and
> not the first.

Yeah, that's a bit odd, but I don't think it matters.

The hope is obviously that they are mutually aligned, and in that case
it doesn't matter which one you aim to align.

> So you are saying that the current memcmp could indeed use improvement
> but you don't want it to be based on the glibc's code due to the ugly
> misalignment handling?

Yeah. I suspect that this (very simple) patch gives you the same
performance improvement that the glibc code does.

NOTE! I'm not saying this patch is perfect. This one doesn't even
_try_ to do the mutual alignment, because it's really silly. But I'm
throwing this out here for discussion, because

 - it's really simple

 - I suspect it gets you 99% of the way there

 - the code generation is actually quite good with both gcc and clang.
This is gcc:

        memcmp:
                jmp     .L60
        .L52:
                movq    (%rsi), %rax
                cmpq    %rax, (%rdi)
                jne     .L53
                addq    $8, %rdi
                addq    $8, %rsi
                subq    $8, %rdx
        .L60:
                cmpq    $7, %rdx
                ja      .L52
                testq   %rdx, %rdx
                je      .L61
        .L53:
                xorl    %ecx, %ecx
                jmp     .L56
        .L62:
                addq    $1, %rcx
                cmpq    %rcx, %rdx
                je      .L51
        .L56:
                movzbl  (%rdi,%rcx), %eax
                movzbl  (%rsi,%rcx), %r8d
                subl    %r8d, %eax
                je      .L62
        .L51:
                ret
        .L61:
                xorl    %eax, %eax
                ret

and notice how there are no spills, no extra garbage, just simple and
straightforward code.

Those things ends mattering too - it's good for I$, it's good for the
small cases, and it's good for debugging and reading the code.

If this is "good enough" for your test-case, I really would prefer
something like this. "Make it as simple as possible, but no simpler"

I can do the mutual alignment too, but I'd actually prefer to do it as
a separate patch, for when there are numbers for that.

And I wouldn't do it as a byte-by-byte case, because that's just stupid.

I'd do it using a separate first single "get unaligned word from both
sources, compare them for equality, and then only add enough bytes to
align"

                  Linus

--000000000000741c3905c7a694cd
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_krdu1hal0>
X-Attachment-Id: f_krdu1hal0

IGxpYi9zdHJpbmcuYyB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGliL3N0cmluZy5jIGIvbGliL3N0cmluZy5jCmlu
ZGV4IDc3YmQwYjFkMzI5Ni4uYjJkZTQ1YTU4MWY0IDEwMDY0NAotLS0gYS9saWIvc3RyaW5nLmMK
KysrIGIvbGliL3N0cmluZy5jCkBAIC0yOSw2ICsyOSw3IEBACiAjaW5jbHVkZSA8bGludXgvZXJy
bm8uaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAKKyNpbmNsdWRlIDxhc20vdW5hbGlnbmVk
Lmg+CiAjaW5jbHVkZSA8YXNtL2J5dGVvcmRlci5oPgogI2luY2x1ZGUgPGFzbS93b3JkLWF0LWEt
dGltZS5oPgogI2luY2x1ZGUgPGFzbS9wYWdlLmg+CkBAIC05MzUsNiArOTM2LDIxIEBAIF9fdmlz
aWJsZSBpbnQgbWVtY21wKGNvbnN0IHZvaWQgKmNzLCBjb25zdCB2b2lkICpjdCwgc2l6ZV90IGNv
dW50KQogCWNvbnN0IHVuc2lnbmVkIGNoYXIgKnN1MSwgKnN1MjsKIAlpbnQgcmVzID0gMDsKIAor
I2lmZGVmIENPTkZJR19IQVZFX0VGRklDSUVOVF9VTkFMSUdORURfQUNDRVNTCisJaWYgKGNvdW50
ID49IHNpemVvZih1bnNpZ25lZCBsb25nKSkgeworCQljb25zdCB1bnNpZ25lZCBsb25nICp1MSA9
IGNzOworCQljb25zdCB1bnNpZ25lZCBsb25nICp1MiA9IGN0OworCQlkbyB7CisJCQlpZiAoZ2V0
X3VuYWxpZ25lZCh1MSkgIT0gZ2V0X3VuYWxpZ25lZCh1MikpCisJCQkJYnJlYWs7CisJCQl1MSsr
OworCQkJdTIrKzsKKwkJCWNvdW50IC09IHNpemVvZih1bnNpZ25lZCBsb25nKTsKKwkJfSB3aGls
ZSAoY291bnQgPj0gc2l6ZW9mKHVuc2lnbmVkIGxvbmcpKTsKKwkJY3MgPSB1MTsKKwkJY3QgPSB1
MjsKKwl9CisjZW5kaWYKIAlmb3IgKHN1MSA9IGNzLCBzdTIgPSBjdDsgMCA8IGNvdW50OyArK3N1
MSwgKytzdTIsIGNvdW50LS0pCiAJCWlmICgocmVzID0gKnN1MSAtICpzdTIpICE9IDApCiAJCQli
cmVhazsK
--000000000000741c3905c7a694cd--
