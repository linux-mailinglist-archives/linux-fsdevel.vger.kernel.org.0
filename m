Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099311F00DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFEUSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgFEUSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:18:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A826C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 13:18:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so13242796lji.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyZXapUgSv5A3j8QPmWLFE2iYeTmmUoWDYx23agQz54=;
        b=YYiqnQqM7NGXKi3qv8b8zw6+JFTu2Oks5vDFwqewXnT0C6nTwpTLvRv+w2vnIa50ux
         JZ7XEsvqzKMuyX0XT2Geu6g1Zz10yr/6Oj4g/6IlEAL2qAV72//YEpWmVsYTPafRKhOj
         Z3RVMkeziQuTJT8/AGw71xR8ZWIsB0ShrmBC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyZXapUgSv5A3j8QPmWLFE2iYeTmmUoWDYx23agQz54=;
        b=V1LAqBuvTqk1Tyl6yqDB2ktDPjvgvAsrumTPm6NE1nAvOJQYT47LWU+p0sp3aArc9T
         DVHZELzF3c7KObSqiPHcl8gBu67OgohBRRF7yoqWg7jnAc3M+0X0Zg4lFvEFILyxopD7
         65Pt/cMvKr2cg0QM8QCsvsPSClT+cokiNXCgUUnk62UfAk9jQcpezly1l4TyIAq2lmOZ
         aoADWBkC8b0EPVaLqsxTHVuXoDMB/X9SVpIkymk69juAMhBRabYvLqxdM3fORf1VI+N3
         /3gM208uLQWfSWnISiGxanUv1lGHdnRvi9JOANw0u2EVqPc5pVijrzyUYVV8gr4SIXCD
         Eq8Q==
X-Gm-Message-State: AOAM531qRQV2WH9TtkNowwwApIE8/ItxgyLF+HUJFbEuqE/dCarvvrkU
        aX4oEDGw+ir9XBzvlfgVDm3QXppdGKA=
X-Google-Smtp-Source: ABdhPJxTQ2q250w/eVEHT436QYIQIfVFfQhzSg3Q090G6wGTu67+DAeJgefu3XA3XL8Kf4SlZcwjRA==
X-Received: by 2002:a2e:6f13:: with SMTP id k19mr6018625ljc.364.1591388319460;
        Fri, 05 Jun 2020 13:18:39 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y16sm1155798ljm.19.2020.06.05.13.18.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:18:38 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id i27so2327653ljb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 13:18:38 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr5890987ljn.285.1591388317824;
 Fri, 05 Jun 2020 13:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 13:18:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
Message-ID: <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000006294c705a75bf797"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000006294c705a75bf797
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 5, 2020 at 7:23 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> +               /*
> +                * If the "group" and "other" permissions are the same,
> +                * there's no point calling in_group_p() to decide which
> +                * set to use.
> +                */
> +               if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
>                         mode >>= 3;

Ugh. Not only is this ugly, but it's not even the best optimization.

We don't care that group and other match exactly. We only care that
they match in the low 3 bits of the "mask" bits.

So if we want this optimization - and it sounds worth it - I think we
should do it right. But I also think it should be written more
legibly.

And the "& 7" is the same "& (MAY_READ | MAY_WRITE | MAY_EXEC)" we do later.

In other words, if we do this, I'd like it to be done even more
aggressively, but I'd also like the end result to be a lot more
readable and have more comments about why we do that odd thing.

Something like this *UNTESTED* patch, perhaps?

I might have gotten something wrong, so this would need
double-checking, but if it's right, I find it a _lot_ more easy to
understand than making one expression that is pretty complicated and
opaque.

Hmm?

                 Linus

--0000000000006294c705a75bf797
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kb2ni6c00>
X-Attachment-Id: f_kb2ni6c00

IGZzL25hbWVpLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMKaW5kZXggZDgxZjczZmYxYThiLi41MTdiZDZh
MjU3NjEgMTAwNjQ0Ci0tLSBhL2ZzL25hbWVpLmMKKysrIGIvZnMvbmFtZWkuYwpAQCAtMjk0LDI1
ICsyOTQsMzQgQEAgc3RhdGljIGludCBhY2xfcGVybWlzc2lvbl9jaGVjayhzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBpbnQgbWFzaykKIHsKIAl1bnNpZ25lZCBpbnQgbW9kZSA9IGlub2RlLT5pX21vZGU7
CiAKLQlpZiAobGlrZWx5KHVpZF9lcShjdXJyZW50X2ZzdWlkKCksIGlub2RlLT5pX3VpZCkpKQot
CQltb2RlID4+PSA2OwotCWVsc2UgewotCQlpZiAoSVNfUE9TSVhBQ0woaW5vZGUpICYmIChtb2Rl
ICYgU19JUldYRykpIHsKLQkJCWludCBlcnJvciA9IGNoZWNrX2FjbChpbm9kZSwgbWFzayk7Ci0J
CQlpZiAoZXJyb3IgIT0gLUVBR0FJTikKLQkJCQlyZXR1cm4gZXJyb3I7Ci0JCX0KKwltYXNrICY9
IE1BWV9SRUFEIHwgTUFZX1dSSVRFIHwgTUFZX0VYRUM7CiAKKwkvKiBBcmUgd2UgdGhlIG93bmVy
PyBJZiBzbywgQUNMJ3MgZG9uJ3QgbWF0dGVyICovCisJaWYgKGxpa2VseSh1aWRfZXEoY3VycmVu
dF9mc3VpZCgpLCBpbm9kZS0+aV91aWQpKSkgeworCQlpZiAoKG1hc2sgPDwgNikgJiB+bW9kZSkK
KwkJCXJldHVybiAtRUFDQ0VTOworCQlyZXR1cm4gMDsKKwl9CisKKwkvKiBEbyB3ZSBoYXZlIEFD
TCdzPyAqLworCWlmIChJU19QT1NJWEFDTChpbm9kZSkgJiYgKG1vZGUgJiBTX0lSV1hHKSkgewor
CQlpbnQgZXJyb3IgPSBjaGVja19hY2woaW5vZGUsIG1hc2spOworCQlpZiAoZXJyb3IgIT0gLUVB
R0FJTikKKwkJCXJldHVybiBlcnJvcjsKKwl9CisKKwkvKgorCSAqIEFyZSB0aGUgZ3JvdXAgcGVy
bWlzc2lvbnMgZGlmZmVyZW50IGZyb20KKwkgKiB0aGUgb3RoZXIgcGVybWlzc2lvbnMgaW4gdGhl
IGJpdHMgd2UgY2FyZQorCSAqIGFib3V0PyBOZWVkIHRvIGNoZWNrIGdyb3VwIG93bmVyc2hpcCBp
ZiBzby4KKwkgKi8KKwlpZiAobWFzayAmIChtb2RlIF4gKG1vZGUgPj4gMykpKSB7CiAJCWlmIChp
bl9ncm91cF9wKGlub2RlLT5pX2dpZCkpCiAJCQltb2RlID4+PSAzOwogCX0KIAotCS8qCi0JICog
SWYgdGhlIERBQ3MgYXJlIG9rIHdlIGRvbid0IG5lZWQgYW55IGNhcGFiaWxpdHkgY2hlY2suCi0J
ICovCi0JaWYgKChtYXNrICYgfm1vZGUgJiAoTUFZX1JFQUQgfCBNQVlfV1JJVEUgfCBNQVlfRVhF
QykpID09IDApCi0JCXJldHVybiAwOwotCXJldHVybiAtRUFDQ0VTOworCS8qIEJpdHMgaW4gJ21v
ZGUnIGNsZWFyIHRoYXQgd2UgcmVxdWlyZT8gKi8KKwlyZXR1cm4gKG1hc2sgJiB+bW9kZSkgPyAt
RUFDQ0VTIDogMDsKIH0KIAogLyoqCg==
--0000000000006294c705a75bf797--
